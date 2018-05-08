CREATE OR REPLACE PACKAGE PKG_SW_COMPARE IS

    ---подготовка данных
   procedure data_prepare (p_date in date, p_clob   out nocopy clob);

  --конвертируем клоб в блоб и пишем в талицу фалов РУ
  procedure write_files (p_sign      in raw default null,
                         p_file_data in clob,
                         p_message   in VARCHAR2,
                         p_date      in date,
                         p_clob      out nocopy clob,
                         p_state     out NUMBER,
                         p_id        out number);

  --отправка файлов (эта процедура вызывается в цикле по каждой РУ в джобе)
  procedure send_data (p_date in date) ;

  --парсим XML
  PROCEDURE p_xml_parse(p_id          in  NUMBER,
                        p_kf          in  varchar2,
                        p_err         out NUMBER,
                        p_message     out varchar2);

  --получение файлов в ЦБД (эта процедура вызывается веб сервисом на уровне ЦБД)
  procedure recive_data (p_mfo in varchar, p_id in number, p_date in varchar2, p_clob in clob, p_state out number, p_message  out varchar2);

  --точечный запрос данных из ЦБД на РУ
  procedure request_data (p_date in varchar2, p_mfo in varchar2, p_message out varchar2);

 --ответ на запрос файлов из ЦБД
  procedure response_data (p_date in varchar2, p_mfo in varchar2, p_id out number, p_clob out clob, p_message out varchar2) ;

    --ЦБД импортит файлы со сторонних систем
  procedure import_sw_data (p_date in date,p_kod_nbu VARCHAR2, p_type in number, p_message out varchar2);

  --ЦБД парсит полученные файлы со сторонних систем
  procedure parse_sw_data (p_id in  NUMBER,
                           p_err out number,
                           p_message     out varchar2);

  -- автоматическое квитование по transactionid
  procedure compare_data_auto  (p_kod_nbu       in SW_COMPARE.KOD_NBU%type, p_message out varchar2 );

  -- ручное квитование
  procedure compare_data_hand  (p_kod_nbu       in SW_COMPARE.KOD_NBU%type ,
                                p_ref           in SW_OWN.REF%type,
                                p_tt            in SW_OWN.TT%type,
                                p_transactionid in SW_IMPORT.TRANSACTIONID%type,
                                p_operation     in SW_IMPORT.operation%type,
                                p_ddate_oper    in SW_COMPARE.DDATE_OPER%type,
                                p_prn_file      in SW_COMPARE.PRN_FILE_OWN%type,
                                p_kf            in  SW_COMPARE.KF%type,
                                p_comments      in SW_COMPARE.COMMENTS%type);
 -- удаление квитования
  procedure  del_compare_data  (p_id           in SW_COMPARE.ID%type);

  -- Устранение причины расхождения
  procedure  resolve_cause  (p_id           in SW_COMPARE.ID%type,
                             p_comments     in SW_COMPARE.COMMENTS%type default null);

  -- функция возвращает количество загруженных import_sw_data строк
  function get_row_count (p_date in date
                         ,p_kod_nbu VARCHAR2)
    return number;

  -- функция возвращает количество загруженных request_data строк
  function get_own_row_count (p_date in date
                             ,p_mfo in varchar)
    return number;

end  PKG_SW_COMPARE;
/
CREATE OR REPLACE PACKAGE BODY PKG_SW_COMPARE IS

    TYPE t_SW_OWN               IS TABLE OF SW_OWN%ROWTYPE;
    TYPE t_SW_IMPORT            IS TABLE OF SW_IMPORT%ROWTYPE;
    g_service_name_ru           constant varchar2(30 char) := 'RuDataExchangeService.asmx';
    g_service_name_cbd          constant varchar2(30 char) := 'CBDDataExchangeService.asmx';
    g_service_namespace         constant varchar2(30 char) := 'http://ws.unity-bars.com.ua/';

    function encode_base64(
         p_blob_in in blob)
    return clob
    is
        v_clob clob;
        v_result clob;
        v_offset integer;
        v_chunk_size binary_integer := (48 / 4) * 3;
        v_buffer_varchar varchar2(48);
        v_buffer_raw raw(48);
    begin
        if p_blob_in is null then
            return null;
        end if;
        dbms_lob.createtemporary(v_clob, true);
        v_offset := 1;
        for i in 1 .. ceil(dbms_lob.getlength(p_blob_in) / v_chunk_size) loop
            dbms_lob.read(p_blob_in, v_chunk_size, v_offset, v_buffer_raw);
            v_buffer_raw := utl_encode.base64_encode(v_buffer_raw);
            v_buffer_varchar := utl_raw.cast_to_varchar2(v_buffer_raw);
            dbms_lob.writeappend(v_clob, length(v_buffer_varchar), v_buffer_varchar);
            v_offset := v_offset + v_chunk_size;
        end loop;

        v_result := v_clob;
        dbms_lob.freetemporary(v_clob);
        return v_result;
    end;


    function decode_base64(
        p_clob_in in clob)
    return blob
    is
        v_blob blob;
        v_result blob;
        v_offset integer;
        v_buffer_size binary_integer := 48;
        v_buffer_varchar varchar2(48);
        v_buffer_raw raw(48);
    begin
        if p_clob_in is null then
            return null;
        end if;

        dbms_lob.createtemporary(v_blob, true);
        v_offset := 1;

        for i in 1 .. ceil(dbms_lob.getlength(p_clob_in) / v_buffer_size) loop
            dbms_lob.read(p_clob_in, v_buffer_size, v_offset, v_buffer_varchar);
            v_buffer_raw := utl_raw.cast_to_raw(v_buffer_varchar);
            v_buffer_raw := utl_encode.base64_decode(v_buffer_raw);
            dbms_lob.writeappend(v_blob, utl_raw.length(v_buffer_raw), v_buffer_raw);
            v_offset := v_offset + v_buffer_size;
        end loop;

        v_result := v_blob;
        dbms_lob.freetemporary(v_blob);

        return v_result;
    end;

   function read_sw_branch_ws_parameters(
        p_branch in integer,
        p_lock   in boolean default false,
        p_raise_ndf in boolean default true)
    return sw_branch_ws_parameters%rowtype
    is
        l_sw_branch_ws_parameters_row sw_branch_ws_parameters%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_sw_branch_ws_parameters_row
            from   sw_branch_ws_parameters p
            where  p.kf  = p_branch
            for update;
        else
            select *
            into   l_sw_branch_ws_parameters_row
            from   sw_branch_ws_parameters p
            where  p.kf  = p_branch;
        end if;

        return l_sw_branch_ws_parameters_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20001,'Параметри web-сервісу для філіалу  {' || p_branch || '} не знайдені');
             else return null;
             end if;
    end;


    ---подготовка данных
   procedure data_prepare (p_date in date, p_clob   out nocopy clob)
       IS
    title  constant varchar2(60) := 'pkg_SW_COMPARE.data_prepare';
    l_dt               date;

    l_domdoc           dbms_xmldom.domdocument;
    l_root_node        dbms_xmldom.domnode;

    l_supp_element     dbms_xmldom.domelement;

    l_supp_node        dbms_xmldom.domnode;
    l_sup_node_table   dbms_xmldom.domnode;

    l_supp_tnode       dbms_xmldom.domnode;

    l_supp_text        dbms_xmldom.domtext;
    l_supp_node_text   dbms_xmldom.domtext;

    l_supplier_element dbms_xmldom.domelement;
    l_supplier_element_table dbms_xmldom.domelement;
    l_root_element     dbms_xmldom.domelement;
    l_supplier_node    dbms_xmldom.domnode;
    l_supplier_text    dbms_xmldom.domtext;
    l_supplier_tnode   dbms_xmldom.domnode;
    l_sup_node         dbms_xmldom.domnode;
    l_suppp_node       dbms_xmldom.domnode;

    l_supp1_element    dbms_xmldom.domelement;
    l_supp1_node       dbms_xmldom.domnode;
  BEGIN

  bars_audit.trace( '%s: Start running.', title );
  l_dt := trunc(p_date);

  dbms_lob.createtemporary(p_clob, true, 12);
  -- Create an empty XML document
  l_domdoc := dbms_xmldom.newdomdocument;

  -- Create a root node
  l_root_node := dbms_xmldom.makenode(l_domdoc);

    -- Create a new Supplier Node and add it to the root node
  l_root_element:= dbms_xmldom.createelement(l_domdoc, 'root');
  l_sup_node := dbms_xmldom.appendchild(l_root_node,dbms_xmldom.makenode(l_root_element));

  l_supplier_element_table := dbms_xmldom.createelement(l_domdoc, 'table');
  l_sup_node_table := dbms_xmldom.appendchild(l_sup_node,dbms_xmldom.makenode(l_supplier_element_table));

          for sup_rec in (/*select
                                 p.ref,
                                 o.tt,
                                 (select name  from tts where tt =p.tt) tt_name,
                                 p.branch oper_branch ,
                                 p.pdat,
                                 o.fdat,
                                 (select value from operw where ref = p.ref and tag = 'MTSC') MTSC,
                                 o.dk,
                                 o.s s,
                                 null sk,
                                 x.nls,
                                 x.kv,
                                 x.kod_nbu,
                                 sw.name,
                                 x.branch acc_branch ,
                                 x.ob22,
                                 p.nazn
                            from oper p,
                                 opldok o,
                                 saldoa s,
                                 (select a.branch,
                                         a.kv,
                                         a.nls,
                                         a.dapp,
                                         a.acc,
                                         a.isp,
                                         a.nms,
                                         w.kod_nbu,
                                         a.nbs,
                                         a.ob22
                                    from accounts a,  (select  distinct decode(t.kod_nbu ,'94','97','95','97','96','97',t.kod_nbu ) kod_nbu , t.ob22_2909, t.ob22_2809
                                                        from BARS.SWI_MTI_LIST t,(select distinct kod_nbu from sw_system) s where s.kod_nbu = t.kod_nbu) w
                                   where (a.nbs = '2909' and a.ob22 = w.OB22_2909 or
                                         a.nbs = '2809' and a.ob22 = w.OB22_2809)
                                     and a.dapp >= l_dt)x,
                                   SWI_MTI_LIST SW
                           where s.fdat = l_dt
                             and s.acc = x.acc
                             and s.acc = o.acc
                             and s.fdat = o.fdat
                             and (x.NBS = '2909' and o.dk = 1 OR x.NBS = '2809' and o.dk = 0)
                             and p.ref = o.ref
                             and x.kod_nbu = sw.kod_nbu
                             and p.tt = o.tt
                             and p.sos= 5*/

                            with x as(select a.branch,
                                                                     a.kv,
                                                                     a.nls,
                                                                     a.dapp,
                                                                     a.acc,
                                                                     a.isp,
                                                                     a.nms,
                                                                     w.kod_nbu,
                                                                     a.nbs,
                                                                     a.ob22
                                                                from accounts a,  (select distinct decode(t.kod_nbu ,'94','97','95','97','96','97',t.kod_nbu ) kod_nbu , t.ob22_2909, t.ob22_2809
                                                                                    from BARS.SWI_MTI_LIST t,(select distinct kod_nbu from sw_system) s where s.kod_nbu = t.kod_nbu) w
                                                               where (a.nbs = '2909' and a.ob22 = w.OB22_2909 or
                                                                     a.nbs = '2809' and a.ob22 = w.OB22_2809)
                                                                 and a.dapp >= l_dt)
                            select   p.ref,
                                     o.tt,
                                     tts.name tt_name,
                                     p.branch oper_branch ,
                                     p.pdat,
                                     o.fdat,
                                     ow.value MTSC,
                                     o.dk,
                                     nvl(o.s,0) s,
                                     nvl(ok.s,0)-nvl(okm.s,0) sk,
                                     x.nls,
                                     tg.lcv kv,
                                     x.kod_nbu,
                                     sw.name,
                                     x.branch acc_branch ,
                                     x.ob22,
                                     p.nazn
                            from x
                            join  saldoa s on  s.fdat = l_dt
                                           and s.acc = x.acc
                            join  opldok o on  o.acc = x.acc
                                                         and o.fdat = l_dt
                                                         and (x.NBS = '2909' and o.dk = 1 OR x.NBS = '2809' and o.dk = 0)
                            join  oper p   on  p.ref = o.ref
                                           and p.tt = o.tt
                                           and p.sos= 5
                            join OPERW OW on ow.ref = p.ref and ow.tag = 'TR_ID'
                            join SWI_MTI_LIST SW on x.kod_nbu = sw.kod_nbu
                            left join SW_TT_OPER_KOM TTK  on ttk.tt = o.tt and ttk.kod_nbu = x.kod_nbu
                            left join  opldok     ok on  ok.ref  = o.ref
                                                         and ttk.ttk  = ok.tt
                                                         and ok.acc = o.acc
                            left join  opldok     okm on okm.ref  = o.ref
                                                         and ttk.ttkm  = okm.tt
                                                         and okm.acc = o.acc
                            join tts  on  tts.tt = p.tt
                            join TABVAL$GLOBAL tg on tg.kv = x.kv  )
          loop

            -- For each record, create a new Supplier element
            -- and add this new Supplier element to the Supplier Parent node
            l_supplier_element := dbms_xmldom.createelement(l_domdoc, 'SW_OWN');
            l_supplier_node    := dbms_xmldom.appendchild(l_sup_node_table,dbms_xmldom.makenode(l_supplier_element));

            l_supp_element := dbms_xmldom.createelement(l_domdoc, 'ref');
            l_supp_node    := dbms_xmldom.appendchild(l_supplier_node, dbms_xmldom.makenode(l_supp_element));
            l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, sup_rec.REF);
            l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node, dbms_xmldom.makenode(l_supp_text));

            l_supp_element := dbms_xmldom.createelement(l_domdoc, 'tt');
            l_supp_node    := dbms_xmldom.appendchild(l_supplier_node, dbms_xmldom.makenode(l_supp_element));
            l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, sup_rec.tt);
            l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node, dbms_xmldom.makenode(l_supp_text));

            l_supp_element := dbms_xmldom.createelement(l_domdoc, 'tt_name');
            l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,dbms_xmldom.makenode(l_supp_element));
            l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, sup_rec.tt_name );
            l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,dbms_xmldom.makenode(l_supp_text));

            l_supp_element := dbms_xmldom.createelement(l_domdoc, 'oper_branch');
            l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,dbms_xmldom.makenode(l_supp_element));
            l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, sup_rec.oper_branch );
            l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,dbms_xmldom.makenode(l_supp_text));

            l_supp_element := dbms_xmldom.createelement(l_domdoc, 'pdat');
            l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,dbms_xmldom.makenode(l_supp_element));
            l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, to_char(sup_rec.pdat , 'dd.mm.yyyy hh24:mi:ss'));
            l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,dbms_xmldom.makenode(l_supp_text));

            l_supp_element := dbms_xmldom.createelement(l_domdoc, 'fdat');
            l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,dbms_xmldom.makenode(l_supp_element));
            l_supp_text    := dbms_xmldom.createtextnode(l_domdoc,  to_char(sup_rec.fdat  , 'dd.mm.yyyy') );
            l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,dbms_xmldom.makenode(l_supp_text));

            l_supp_element := dbms_xmldom.createelement(l_domdoc, 'mtsc');
            l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,dbms_xmldom.makenode(l_supp_element));
            l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, sup_rec.mtsc );
            l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,dbms_xmldom.makenode(l_supp_text));

            l_supp_element := dbms_xmldom.createelement(l_domdoc, 'dk');
            l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,dbms_xmldom.makenode(l_supp_element));
            l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, sup_rec.dk );
            l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,dbms_xmldom.makenode(l_supp_text));

            l_supp_element := dbms_xmldom.createelement(l_domdoc, 's');
            l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,dbms_xmldom.makenode(l_supp_element));
            l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, sup_rec.s );
            l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,dbms_xmldom.makenode(l_supp_text));

            l_supp_element := dbms_xmldom.createelement(l_domdoc, 'sk');
            l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,dbms_xmldom.makenode(l_supp_element));
            l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, sup_rec.sk );
            l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,dbms_xmldom.makenode(l_supp_text));

            l_supp_element := dbms_xmldom.createelement(l_domdoc, 'nls');
            l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,dbms_xmldom.makenode(l_supp_element));
            l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, sup_rec.nls );
            l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,dbms_xmldom.makenode(l_supp_text));

            l_supp_element := dbms_xmldom.createelement(l_domdoc, 'kv');
            l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,dbms_xmldom.makenode(l_supp_element));
            l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, sup_rec.kv );
            l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,dbms_xmldom.makenode(l_supp_text));

            l_supp_element := dbms_xmldom.createelement(l_domdoc, 'kod_nbu ');
            l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,dbms_xmldom.makenode(l_supp_element));
            l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, sup_rec.kod_nbu );
            l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,dbms_xmldom.makenode(l_supp_text));

            l_supp_element := dbms_xmldom.createelement(l_domdoc, 'name');
            l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,dbms_xmldom.makenode(l_supp_element));
            l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, sup_rec.name );
            l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,dbms_xmldom.makenode(l_supp_text));

            l_supp_element := dbms_xmldom.createelement(l_domdoc, 'acc_branch');
            l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,dbms_xmldom.makenode(l_supp_element));
            l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, sup_rec.acc_branch );
            l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,dbms_xmldom.makenode(l_supp_text));

            l_supp_element := dbms_xmldom.createelement(l_domdoc, 'ob22');
            l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,dbms_xmldom.makenode(l_supp_element));
            l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, sup_rec.ob22 );
            l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,dbms_xmldom.makenode(l_supp_text));

            l_supp_element := dbms_xmldom.createelement(l_domdoc, 'nazn');
            l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,dbms_xmldom.makenode(l_supp_element));
            l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, sup_rec.nazn );
            l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,dbms_xmldom.makenode(l_supp_text));

          end loop;
 --    end loop;

  dbms_xmldom.writetoclob(l_domdoc, p_clob);
  dbms_xmldom.freedocument(l_domdoc);

    bars_audit.trace( '%s: Exit.', title );

  EXCEPTION
    WHEN OTHERS THEN
      dbms_xmldom.freedocument(l_domdoc);
      bars_audit.error( title || ': ' || dbms_utility.format_error_stack() ||
                              chr(10) || dbms_utility.format_error_backtrace() );
      RAISE;
   end;


  --конвертируем клоб в блоб и пишем в талицу фалов РУ
  procedure write_files (p_sign      in raw default null,
                         p_file_data in clob,
                         p_message   in VARCHAR2,
                         p_date      in date,
                         p_clob      out nocopy clob,
                         p_state     out NUMBER,
                         p_id        out number) is
    l_blob        blob;
    l_clob_arh    clob;
    l_warning     integer;
    l_dest_offset integer := 1;
    l_src_offset  integer := 1;
    l_blob_csid    number := dbms_lob.default_csid;
    l_lang_context number := dbms_lob.default_lang_ctx;

    title        varchar2(100) := 'pkg_SW_COMPARE.write_files. ';
  begin
      bars_audit.info(title || 'Start. ');
      dbms_lob.createtemporary(lob_loc => l_blob,
                               cache   => true,
                               dur     => dbms_lob.call);

      dbms_lob.converttoblob(dest_lob     => l_blob,
                             src_clob     => p_file_data,
                             amount       => dbms_lob.lobmaxsize,
                             dest_offset  => l_dest_offset,
                             src_offset   => l_src_offset,
                             blob_csid    => l_blob_csid,
                             lang_context => l_lang_context,
                             warning      => l_warning);

       l_blob := utl_compress.lz_compress(l_blob);
       l_clob_arh:= encode_base64(l_blob);

      p_state:=0;
      insert into SW_RU_FILES
        (id, file_data, state, message, sign, ddate, sdate )
      values
        (S_SW_RU_FILES.NEXTVAL,l_clob_arh, p_state, null,null, p_date, sysdate)
      returning id into p_id;
      bars_audit.info(title || 'File written.');

      p_clob:=l_clob_arh;

  exception
    when others   then
      p_state:=-1;--ошибка
      bars_audit.error( title || ': ' || dbms_utility.format_error_stack() ||
                              chr(10) || dbms_utility.format_error_backtrace() );
  end;

  procedure prepare_transport_request_ru(p_id           in number,
                                         p_clob         in clob,
                                         p_date         in date) is
    l_url         varchar2(4000 byte);
    l_url_goal    varchar2(4000 byte);
    l_wallet_path varchar2(4000 byte);
    l_wallet_pass varchar2(4000 byte);
    l_sw_branch_ws_parameters_row sw_branch_ws_parameters%rowtype;  --RU
    l_sw_branch_ws_parameters_row2 sw_branch_ws_parameters%rowtype; --CA
  begin
    l_sw_branch_ws_parameters_row := read_sw_branch_ws_parameters(sys_context('bars_context','user_mfo'));
    l_sw_branch_ws_parameters_row2 := read_sw_branch_ws_parameters(300465);
    -----------------------------------------------------------------------------------
    $if $$debug_flag $then
    l_sw_branch_ws_parameters_row.url:='http://10.10.10.101:10102/barsroot/webservices/';  --jeka тестовая строка
    l_sw_branch_ws_parameters_row2.url:='http://10.10.10.101:10102/barsroot/webservices/';  --jeka тестовая строка
    $end
    ----------------------------------------------------------------------------------------
    l_wallet_path := bars.getglobaloption('OWWALLETPATH');
    l_wallet_pass := bars.getglobaloption('OWWALETPWD');
    bars.wsm_mgr.prepare_request(p_url          => l_sw_branch_ws_parameters_row.url || g_service_name_ru,
                                 p_action       => null,
                                 p_http_method  => bars.wsm_mgr.g_http_post,
                                 p_soap_method  => 'SendData',
                                 p_content_type => bars.wsm_mgr.G_CT_XML,
                                 p_wallet_path  => l_wallet_path,
                                 p_wallet_pwd   => l_wallet_pass,
                                 p_content_charset => wsm_mgr.g_cc_utf8,
                                 p_namespace    => g_service_namespace,
                                 p_body         => '<buffer><![CDATA['||p_clob||']]></buffer>');

    bars.wsm_mgr.add_parameter(p_name  => 'p_id',p_value => to_char(p_id));
    bars.wsm_mgr.add_parameter(p_name  => 'p_mfo',p_value => to_char(sys_context('bars_gl', 'mfo')));
    bars.wsm_mgr.add_parameter(p_name  => 'p_date',p_value => to_char(p_date,'dd.mm.yyyy'));
    bars.wsm_mgr.add_parameter(p_name  => 'p_url',p_value => l_sw_branch_ws_parameters_row2.url|| g_service_name_cbd);
  end;

  procedure prepare_transport_request_cbd(p_date         in date,
                                          p_mfo          in varchar2) is
    l_url         varchar2(4000 byte);
    l_wallet_path varchar2(4000 byte);
    l_wallet_pass varchar2(4000 byte);
    l_sw_branch_ws_parameters_row sw_branch_ws_parameters%rowtype;  --RU
    l_sw_branch_ws_parameters_row2 sw_branch_ws_parameters%rowtype; --CA
  begin
    l_sw_branch_ws_parameters_row := read_sw_branch_ws_parameters(p_mfo);
    l_sw_branch_ws_parameters_row2 := read_sw_branch_ws_parameters(300465);
    l_wallet_path := bars.getglobaloption('OWWALLETPATH');
    l_wallet_pass := bars.getglobaloption('OWWALETPWD');

--------------------------------------------------------------------------------
    $if $$debug_flag $then
    l_SW_branch_ws_parameters_row2.url :='http://10.10.10.44:19485/barsroot/webservices/';  --jeka тестовая строка
    l_SW_branch_ws_parameters_row.url:='http://10.10.10.44:19485/barsroot/webservices/';  --OBMMFO6   --jeka тестовая строка
    $end
    --l_SW_branch_ws_parameters_row.url:='http://10.10.10.101:10080/barsroot/webservices/';   --TSTSUM   --jeka тестовая строка
---------------------------------------------------------------------------------------

    bars.wsm_mgr.prepare_request(p_url          => l_SW_branch_ws_parameters_row2.url|| g_service_name_cbd,
                                 p_action       => null,
                                 p_http_method  => bars.wsm_mgr.g_http_post,
                                 p_soap_method  => 'RequestDataToRU',
                                 p_content_type => bars.wsm_mgr.G_CT_XML,
                                 p_wallet_path  => l_wallet_path,
                                 p_wallet_pwd   => l_wallet_pass,
                                 p_content_charset => wsm_mgr.g_cc_utf8,
                                 p_namespace    => g_service_namespace);


    bars.wsm_mgr.add_parameter(p_name => 'UserName', p_value => l_SW_branch_ws_parameters_row.login);
    bars.wsm_mgr.add_parameter(p_name => 'Password', p_value => l_SW_branch_ws_parameters_row.password);
    bars.wsm_mgr.add_parameter(p_name  => 'p_mfo',p_value => p_mfo);
    bars.wsm_mgr.add_parameter(p_name  => 'p_date',p_value => to_char(p_date,'dd.mm.yyyy'));
    bars.wsm_mgr.add_parameter(p_name  => 'p_url',p_value => l_SW_branch_ws_parameters_row.url|| g_service_name_ru);
  end;

  --отправка файлов (эта процедура вызывается в цикле по каждой РУ в джобе и в цикле коннектиться юзером из параметров. в котором устанавливается контекст РУ)
  procedure send_data (p_date in date) is
    l_id         SW_RU_FILES.ID%type;
    title        varchar2(100) := 'pkg_SW_COMPARE.send_data. ';
    l_clob       clob;
    l_clob_arh   clob;
    l_clob_arh_b clob;
    l_state      number;
    l_state_b      number;
    l_response   bars.wsm_mgr.t_response;
    l_xml xmltype;
    l_message     sw_ru_files.message%type;
    l_xdoc        xmltype;
  begin
     begin
      select s.id, s.file_data, s.state into l_id,l_clob_arh_b, l_state_b from SW_RU_FILES s where s.ddate  = p_date;
      if l_id is not null and l_state_b  in (4,10) then --только эти ошибки из-за содержимого
            begin
              insert into SW_RU_FILES_HIST (STATE,
                                            MESSAGE,
                                            SIGN,
                                            DDATE,
                                            KF,
                                            ID,
                                            FILE_DATA,
                                            SDATE,
                                            CHGDATE)
                                   select state,
                                          message,
                                          sign,
                                          ddate,
                                          kf,
                                          id,
                                          file_data,
                                          sdate,
                                          sysdate
                                    from SW_RU_FILES where ddate  = p_date;
              delete from SW_RU_FILES where ddate  = p_date;
            exception
              when others then
                bars_audit.error( title || ': ' || dbms_utility.format_error_stack() ||
                                        chr(10) || dbms_utility.format_error_backtrace() );
             update SW_RU_FILES s
             set s.message = substr(title || ': ' || dbms_utility.format_error_stack() ||
                                        chr(10) || dbms_utility.format_error_backtrace(),1,4000)
             where s.id =  l_id;
            end;
      l_state_b:=-1;
      end if;
     exception when no_data_found then l_state_b:=-1;
     end;

    if l_state_b = 3  then  --файл был успешно обработан
         null;
    elsif l_state_b = -1  then  --файл еще не создавался либо перегружается
      bars_audit.info(title || 'Start. ');
      begin

       ---подготовка данных
       data_prepare (p_date, l_clob);

       --конвертируем клоб в блоб, пакуем, опять в клоб и пишем в талицу фалов РУ
       write_files (null,l_clob,null,p_date,l_clob_arh,l_state, l_id);

       if l_state <> - 1 then

           --вызываем вебсервис
           prepare_transport_request_ru(l_id,l_clob_arh, p_date);
           bars.wsm_mgr.execute_soap(l_response);

           --считываем статус ответа
          -- dbms_output.put_line(l_response.cdoc);
           l_xdoc:=xmltype.createxml(l_response.cdoc);
           l_xml := l_xdoc.extract('/soap:Envelope/soap:Body/child::node()', 'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"');
           l_state := l_xml.extract('/SendDataResponse/SendDataResult/status/text()').GetStringVal();
           l_message := l_xml.extract('/SendDataResponse/SendDataResult/message/text()').GetStringVal();

           --обновляем статус на успешный
           update SW_RU_FILES s
           set s.state   = l_state,
               s.message = decode( substr(l_message,1,4000),'null',null,substr(l_message,1,4000))
           where s.id =  l_id;

       end if;

      exception
        when others then
          bars_audit.error( title || ': ' || dbms_utility.format_error_stack() ||
                                  chr(10) || dbms_utility.format_error_backtrace() );
          if l_id is not null then
           update SW_RU_FILES s
           set s.message = substr(title || ': ' || dbms_utility.format_error_stack() ||
                                      chr(10) || dbms_utility.format_error_backtrace(),1,4000)
           where s.id =  l_id;
          end if;
      end;
      bars_audit.info(title || 'Finish. ');
    else --только отправляем файл, файл не пересобирается
      bars_audit.info(title || 'Start. ');
      begin
       --вызываем вебсервис
       prepare_transport_request_ru(l_id,l_clob_arh_b, p_date);
       bars.wsm_mgr.execute_soap(l_response);

       --считываем статус ответа
       l_xdoc:=xmltype.createxml(l_response.cdoc);
       l_xml := l_xdoc.extract('/soap:Envelope/soap:Body/child::node()', 'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"');
       l_state := l_xml.extract('/SendDataResponse/SendDataResult/status/text()').GetStringVal();
       l_message := l_xml.extract('/SendDataResponse/SendDataResult/message/text()').GetStringVal();

       --обновляем статус на успешный
       update SW_RU_FILES s
       set s.state   = l_state,
           s.message = decode( substr(l_message,1,4000),'null',null,substr(l_message,1,4000))
       where s.id =  l_id;

      exception
        when others then
          bars_audit.error( title || ': ' || dbms_utility.format_error_stack() ||
                                  chr(10) || dbms_utility.format_error_backtrace() );
       update SW_RU_FILES s
       set s.message = substr(title || ': ' || dbms_utility.format_error_stack() ||
                                  chr(10) || dbms_utility.format_error_backtrace(),1,4000)
       where s.id =  l_id;
      end;
      bars_audit.info(title || 'Finish. ');
    end if;
  end;


  --парсим XML
 PROCEDURE p_xml_parse
  (
    p_id          in  NUMBER,
    p_kf          in  varchar2,
    p_err         out NUMBER,
    p_message     out varchar2
  ) IS
    l_doc         dbms_xmldom.domdocument;
    title         VARCHAR2(100) := 'pkg_SW_COMPARE.p_xml_parse.';
    l_parser      dbms_xmlparser.parser;
    l_tablelist   dbms_xmldom.domnodelist;
    l_rowlist     dbms_xmldom.domnodelist;
    l_columnlist  dbms_xmldom.domnodelist;
    l_row         dbms_xmldom.domnode;
    l_table_name  VARCHAR2(100);
    l_str         VARCHAR2(2000);
    l_clob        clob;
    l_blob        blob;
    l_tmpb          blob;
    l_file_data     clob;
    l_warning       integer;
    l_dest_offset   integer := 1;
    l_src_offset    integer := 1;
    l_blob_csid     number := dbms_lob.default_csid;
    l_lang_context  number := dbms_lob.default_lang_ctx;
    l_xml           xmltype;
    --типы
    l_SW_OWN            t_SW_OWN           :=t_SW_OWN();

    v_Attr_Node      Dbms_Xmldom.Domnode;
    v_Attr_Nodes     Dbms_Xmldom.Domnamednodemap;
    p_err_loc        NUMBER(10);
  BEGIN
    dbms_output.put_line(p_id);
      BEGIN
        SELECT t.file_data
          INTO l_clob
          FROM SW_CA_FILES t
         WHERE t.id = p_id;
      EXCEPTION
        WHEN no_data_found THEN
           bars_audit.error( title || ': ' || dbms_utility.format_error_stack() ||
                              chr(10) || dbms_utility.format_error_backtrace() );
      END;
       l_blob := decode_base64(l_clob);
       l_tmpb      := utl_compress.lz_uncompress(l_blob);

        dbms_lob.createtemporary(l_file_data, false);

        dbms_lob.converttoclob(dest_lob     => l_file_data,
                               src_blob     => l_tmpb,
                               amount       => dbms_lob.lobmaxsize,
                               dest_offset  => l_dest_offset,
                               src_offset   => l_src_offset,
                               blob_csid    => l_blob_csid,
                               lang_context => l_lang_context,
                               warning      => l_warning);

    bars_audit.trace(title || 'Started');
    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, l_file_data);
    bars_audit.trace(title || 'clob loaded');

    l_doc := dbms_xmlparser.getdocument(l_parser);
    bars_audit.trace(title || 'getdocument done');

------------------------------------------
          --формируем список строк
          l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,'SW_OWN');
          FOR i IN 0 .. dbms_xmldom.getlength(l_rowlist) - 1
          LOOP
             l_row := dbms_xmldom.item(l_rowlist, i);
             l_SW_OWN .extend;


             dbms_xslprocessor.valueof(l_row, 'ref/text()', l_str);
             l_SW_OWN (l_SW_OWN .last).ref   := to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'tt/text()', l_str);
             l_SW_OWN (l_SW_OWN .last).TT   := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'tt_name/text()', l_str);
             l_SW_OWN (l_SW_OWN .last).tt_name    := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'oper_branch/text()', l_str);
             l_SW_OWN (l_SW_OWN .last).oper_branch    := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'pdat/text()', l_str);
             l_SW_OWN (l_SW_OWN .last).pdat    := to_date(trim(l_str), 'dd.mm.yyyy hh24:mi:ss');

             dbms_xslprocessor.valueof(l_row, 'fdat/text()', l_str);
             l_SW_OWN (l_SW_OWN .last).fdat    := to_date(trim(l_str), 'dd.mm.yyyy');

             dbms_xslprocessor.valueof(l_row, 'mtsc/text()', l_str);
             l_SW_OWN (l_SW_OWN .last).mtsc    := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'dk/text()', l_str);
             l_SW_OWN (l_SW_OWN .last).dk    := to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 's/text()', l_str);
             l_SW_OWN (l_SW_OWN .last).s    := to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'sk/text()', l_str);
             l_SW_OWN (l_SW_OWN .last).sk    := to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'nls/text()', l_str);
             l_SW_OWN (l_SW_OWN .last).nls    := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'kv/text()', l_str);
             l_SW_OWN (l_SW_OWN .last).kv    := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'kod_nbu/text()', l_str);
             l_SW_OWN (l_SW_OWN .last).kod_nbu    := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'name/text()', l_str);
             l_SW_OWN (l_SW_OWN .last).name    := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'acc_branch/text()', l_str);
             l_SW_OWN (l_SW_OWN .last).acc_branch    := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'ob22/text()', l_str);
             l_SW_OWN (l_SW_OWN .last).ob22    := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'nazn/text()', l_str);
             l_SW_OWN (l_SW_OWN .last).nazn    := trim(l_str);

           END LOOP;

             BEGIN
               EXECUTE IMMEDIATE ' delete from   ERR$_SW_OWN where kf=:p_kf'
               using p_kf;
             END;

             if l_SW_OWN IS NOT EMPTY then
              --обновление данных
              BEGIN
                FOR j IN l_SW_OWN.first .. l_SW_OWN.last
                loop
                  INSERT INTO SW_OWN(kf,
                                         ref,
                                         tt,
                                         tt_name,
                                         oper_branch,
                                         pdat,
                                         fdat,
                                         mtsc,
                                         dk,
                                         s,
                                         sk,
                                         nls,
                                         kv,
                                         kod_nbu,
                                         name,
                                         acc_branch,
                                         ob22,
                                         nazn,
                                         prn_file
                                          )
                  VALUES ( p_kf,
                           l_SW_OWN(j).ref,
                           l_SW_OWN(j).tt ,
                           l_SW_OWN(j).tt_name,
                           l_SW_OWN(j).oper_branch,
                           l_SW_OWN(j).pdat,
                           l_SW_OWN(j).fdat,
                           l_SW_OWN(j).mtsc,
                           l_SW_OWN(j).dk,
                           l_SW_OWN(j).s/100,
                           l_SW_OWN(j).sk/100,
                           l_SW_OWN(j).nls,
                           l_SW_OWN(j).kv,
                           l_SW_OWN(j).kod_nbu,
                           l_SW_OWN(j).name,
                           l_SW_OWN(j).acc_branch,
                           l_SW_OWN(j).ob22,
                           l_SW_OWN(j).nazn,
                           p_id
                   )
                     log errors INTO ERR$_SW_OWN
                    ('INSERT') reject LIMIT unlimited;

               end loop;
             END;
           end if;
     BEGIN
       SELECT count(*) into p_err_loc  from  ERR$_SW_OWN where kf=p_kf;
       p_err:=p_err_loc;
       if p_err_loc> 0 then
         p_message:='ERR$_SW_OWN HAS ERRORS';
       end if;
     END;
     --очистка,якщо виникли помилки
    l_SW_OWN.delete();
    l_SW_OWN := NULL;

    dbms_xmlparser.freeparser(l_parser);
    dbms_xmldom.freedocument(l_doc);


  END p_xml_parse;


  --ЦБД получает файлы (эта процедура вызывается веб сервисом на уровне ЦБД)
  procedure recive_data (p_mfo in varchar, p_id in number, p_date in varchar2, p_clob in clob, p_state out number, p_message  out varchar2) is
    title        varchar2(100) := 'pkg_SW_COMPARE.recive_data. ';
    l_err        number(10);
    l_message    VARCHAR2(4000);
    l_CF         SW_CA_FILES%ROWTYPE;
    l_com_id     SW_COMPARE.ID%TYPE;
    n_ex         number(1):=1;
    l_date       date;
    l_id         number;
  begin
    bars_audit.info(title || 'Start. ');
    l_date:=to_date(p_date,'dd.mm.yyyy');
    begin
      begin  --ищем на наличие уже принятых файлов
       select CF.* into l_CF from SW_CA_FILES CF where CF.KF = p_mfo and CF.DDATE = l_date;
      exception when no_data_found then n_ex:=0;
                when others then p_message:= title || ': ' || dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace();
                                  n_ex:=2;
      end;

      if n_ex = 1 then  --перегрузка файла.
        select min(c.id)
        into l_com_id
        from SW_COMPARE C , OPER O
        where c.prn_file_own = l_CF.id
           and c.ref         = o.ref(+)
           and o.sos <> -1;

        if l_com_id is not null then
          p_state:=-2;  -- найдены квитовки с операциями, перегрузки не будет, вернем статус = -2
        else
         begin
           insert into SW_CA_FILES_HIST(ID,PID,KF, STATE, MESSAGE,SIGN, DDATE,FILE_DATA,SDATE,CHG_DATE)
                                 values(l_CF.ID,l_CF.PID, l_CF.KF, l_CF.STATE, l_CF.MESSAGE, l_CF.SIGN, l_CF.DDATE, l_CF.FILE_DATA, l_CF.SDATE, sysdate);
           delete from SW_OWN o where o.prn_file =  l_CF.id;
           delete from SW_CA_FILES where ID = l_CF.id;

           update SW_IMPORT i set i.compare_id = 0 where i.prn_file in (select distinct prn_file_import from SW_COMPARE where prn_file_own =l_CF.id);

           delete from SW_COMPARE c where c.prn_file_own = l_CF.id;


         exception when others then p_message:= substr(title || ': ' || dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace(),1,4000);
         end;
        end if;
      end if;

     if p_state <> -2 or p_state is null and p_message is null then
          ---запись файла в таблицу
        begin
          insert into SW_CA_FILES
            (id,pid,kf, file_data , state,message ,sign, ddate , sdate )
          values
            (S_SW_CA_FILES.NEXTVAL,p_id,p_mfo,p_clob, 1, null,null, l_date, sysdate)
          return id into l_id;  
          p_state :=1; --успешно прошел только импорт
        exception
              when others then
                p_message:= substr(title || ': ' || dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace(),1,4000);
                p_state :=0; --сбой при записи в SW_CA_FILES
        end;
          --парсим XML
        if  p_state <> 0 then
            begin
             p_xml_parse(l_id, p_mfo, l_err, l_message);
             if l_err> 0 then p_state := 2; --загрузка с ошибками
             else p_state :=3; --загрузка прошла успешно
             end if;
            exception
                when others then
                  p_message:= substr(title || ': ' || dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace(),1,4000);
                  p_state :=4; --сбой загрузки
            end;

            update  SW_CA_FILES set state =  p_state, message  = p_message  where id = l_id;
        end if;
      end if;
    exception when others then  p_message:= substr(title || ': ' || dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace(),1,4000);
    if p_message is not null
      then bars_audit.error(p_message);
      p_state:=10; -- 'неопознанная ошибка'
    end if;
    end;
    bars_audit.info(title || 'Finish. ');
  end;

  --точечный запрос данных из ЦБД на РУ
  procedure request_data (p_date in varchar2, p_mfo in varchar2, p_message out varchar2) is
    l_pid            SW_RU_FILES.ID%type;
    title           varchar2(100) := 'pkg_SW_COMPARE.request_data. ';
    l_response      bars.wsm_mgr.t_response;
    p_file_data     blob;
    l_tmpb          blob;
    l_file_data     clob;
    l_warning       integer;
    l_dest_offset   integer := 1;
    l_src_offset    integer := 1;
    l_blob_csid     number := dbms_lob.default_csid;
    l_lang_context  number := dbms_lob.default_lang_ctx;
    l_CF            SW_CA_FILES%ROWTYPE;
    n_ex            number(1):=1;
    l_com_id        SW_COMPARE.ID%TYPE;
    l_err           number(10);
    l_xml           xmltype;
    l_message       sw_ru_files.message%type;
    l_xdoc          xmltype;
    l_date          date;
    l_id            SW_CA_FILES.ID%type;
  begin
      l_date:=to_date(p_date,'dd.mm.yyyy');
      begin  --ищем на наличие уже принятых файлов
       select CF.* into l_CF from SW_CA_FILES CF where CF.KF = p_mfo and CF.DDATE = l_date;
      exception when no_data_found then n_ex:=0;
      end;

      if n_ex = 1 then  --перегрузка файла.
        select min(c.id)
        into l_com_id
        from SW_COMPARE C , OPER O
        where c.prn_file_own = l_CF.id
           and c.ref         = o.ref(+)
           and o.sos <> -1;

        if l_com_id is not null then
          raise_application_error(-20001,'Існують квитовки з операціями, перегрузка неможлива');
        else
         begin
           insert into SW_CA_FILES_HIST(ID,PID,KF, STATE, MESSAGE,SIGN, DDATE,FILE_DATA,SDATE,CHG_DATE)
                                 values(l_CF.ID,l_CF.PID, l_CF.KF, l_CF.STATE, l_CF.MESSAGE, l_CF.SIGN, l_CF.DDATE, l_CF.FILE_DATA, l_CF.SDATE, sysdate);
           delete from SW_OWN o where o.prn_file =  l_CF.id;
           delete from SW_CA_FILES where ID = l_CF.id;

           update SW_IMPORT i set i.compare_id = 0 where i.prn_file in (select distinct prn_file_import from SW_COMPARE where prn_file_own =l_CF.id);

           delete from SW_COMPARE c where c.prn_file_own = l_CF.id;

         exception when others then bars_audit.error( title || ': ' || dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace() );
         end;
        end if;
      end if;


      begin
    --вызываем вебсервис
       prepare_transport_request_cbd(l_date,p_mfo);
       bars.wsm_mgr.execute_soap(l_response);

       --считываем  ответ
    --   dbms_output.put_line(l_response.cdoc);
       l_xdoc:=xmltype.createxml(l_response.cdoc);
       l_xml := l_xdoc.extract('/soap:Envelope/soap:Body/child::node()', 'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"');
       l_pid := l_xml.extract('/RequestDataToRUResponse/RequestDataToRUResult/id/text()').GetStringVal();
       l_message := l_xml.extract('/RequestDataToRUResponse/RequestDataToRUResult/message/text()').GetStringVal();

       if l_pid <> -999 then
           l_file_data := l_xml.extract('/RequestDataToRUResponse/RequestDataToRUResult/clob/text()').getclobval();
          insert into SW_CA_FILES
            (id,pid,kf, file_data , state,message ,sign, ddate , sdate )
          values
            (S_SW_CA_FILES.NEXTVAL,l_pid,p_mfo,l_file_data, 1, l_message,null, l_date, sysdate)
          return id into l_id  ;
            --парсим XML
           p_xml_parse(l_id, p_mfo, l_err, l_message);
/*           if l_err> 0 then raise_application_error(-20001,'Помилка при обробці даних!');
           end if;*/
          update  SW_CA_FILES set state = 5, message = l_message where id = l_id;
          if l_message is null then
            p_message:= 'Файл прийнято та оброблено без помилок!';
          else
            p_message:= 'Файл прийнято, але при обробці виникли помилки! Кількість помилок = '||l_err||'.  Дані о помилках в таблиці - '||l_message;
          end if;
       else   raise_application_error(-20001,nvl(l_message,'Повертається пустий файл!'));
       end if;
      end;
      bars_audit.info(title || 'Finish. ');
  exception
   when others then
         bars_audit.error( title || ': ' || dbms_utility.format_error_stack() ||
                                  chr(10) || dbms_utility.format_error_backtrace() );
         raise_application_error(-20001,title || ': ' || dbms_utility.format_error_stack() ||
                                        chr(10) || dbms_utility.format_error_backtrace());
  end;


 --ответ на запрос файлов из ЦБД
  procedure response_data (p_date in varchar2, p_mfo in varchar2, p_id out number, p_clob out clob, p_message out varchar2) is
    l_id         SW_RU_FILES.ID%type;
    title        varchar2(100) := 'pkg_SW_COMPARE.response_data. ';
    l_clob       clob;
    l_clob_arh   clob;
    l_clob_arh_b clob;
    l_state      number;
    l_state_b      number;
    l_response   bars.wsm_mgr.t_response;
    l_date       date;
  begin
      bc.go(p_mfo);
      bars_audit.info(title || 'Start. ');
      l_date:=to_date(p_date,'dd.mm.yyyy');
     begin
      begin
      select s.id, s.file_data, s.state into l_id,l_clob_arh_b, l_state_b from SW_RU_FILES s where s.ddate  = l_date;
       if l_id is not null then
             insert into SW_RU_FILES_HIST (STATE,
                                           MESSAGE,
                                           SIGN,
                                           DDATE,
                                           KF,
                                           ID,
                                           FILE_DATA,
                                           SDATE,
                                           CHGDATE)
                select state,
                                          message,
                                          sign,
                                          ddate,
                                          kf,
                                          id,
                                          file_data,
                                          sdate,
                                          sysdate
                                    from SW_RU_FILES where ddate  = l_date;
              delete from SW_RU_FILES where ddate  = l_date;

      l_state_b:=-1;
      end if;
     exception when no_data_found then l_state_b:=-1;
     end;

      bars_audit.info(title || 'Start. ');
      begin
       ---подготовка данных
       data_prepare (l_date, l_clob);

       --конвертируем клоб в блоб, пакуем, опять в клоб и пишем в талицу фалов РУ
       write_files (null,l_clob,null,l_date,l_clob_arh,l_state, l_id);

       --обновляем статус на успешный
       update SW_RU_FILES s set s.state = 5 where s.id =  l_id;

      exception
        when others then
          p_message:=title || ': ' || dbms_utility.format_error_stack() ||
                                  chr(10) || dbms_utility.format_error_backtrace();
      end;
    exception when others then
              p_message:=title || ': ' || dbms_utility.format_error_stack() ||
                                  chr(10) || dbms_utility.format_error_backtrace();
    end;
  if p_message is not null then
    bars_audit.error(p_message);
  else
    p_id  := l_id;
    p_clob:= l_clob_arh;
  end if;
  bars_audit.info(title || 'Finish. ');
  end;



  procedure sk_service(p_ReportSystemId in varchar2, p_ReportDateFrom in date, p_clob out clob )
  is
      l_request        soap_rpc.t_request;
      l_response       soap_rpc.t_response;
      l_url            varchar2(4000);
      l_xml_resp       xmltype;
      l_errtxt         varchar2(4000);
      l_params         varchar2(4000);
    function get_param_webconfig(par varchar2) return web_barsconfig.val%type is
      l_res web_barsconfig.val%type;
    begin
      select val into l_res from web_barsconfig where key = par;
      return trim(l_res);
    exception
      when no_data_found then
        raise_application_error(-20000, 'Не найден KEY=' || par || ' в таблице web_barsconfig!');
    end;
  begin
      begin
          select substr(val, 1, instr(val, '/', 1, 4)-1) || '/webservices/QuickMoneyService.asmx' into l_url from web_barsconfig  where key = 'EWA.URL_SEND_REF_STATUS';
      exception when no_data_found then
          raise_application_error(-20000, 'Параметр REPORT_SERVER_URL не задано');
      end;
      $if $$debug_flag $then
        l_url:= 'http://10.10.10.101:10102/barsroot/webservices/QuickMoneyService.asmx'; --jeka потом убрать
      $end

      logger.info('profix_service: begin call service ' || l_url || ' with method [ TransactionShortReport ]');
      --подготовить реквест
      l_request := soap_rpc.new_request(p_url         => l_url,
                                        p_namespace   => 'http://ws.unity-bars.com.ua/',
                                        p_method      => 'TransactionShortReport',
                                        p_wallet_dir  => get_param_webconfig('VAL.Wallet_dir'),
                                        p_wallet_pass => get_param_webconfig('VAL.Wallet_pass'));

      -- добавить параметры
     -- soap_rpc.add_parameter(l_request, 'reportdate', to_char(p_ReportDateFrom, 'DD.MM.YYYY hh24:mi:ss'));
     -- soap_rpc.add_parameter(l_request, 'SystemId', p_ReportSystemId);

      l_params:='<' || 'REPORTDATE' || '>'||to_char(p_ReportDateFrom, 'DD.MM.YYYY hh24:mi:ss')||'</' || 'REPORTDATE' || '>'
/*                ||
                '<' || 'SystemId' || '>'||p_ReportSystemId||'</' || 'SystemId' || '>'*/;
      soap_rpc.add_parameter(l_request, 'Parameters', l_params);
      soap_rpc.add_parameter(l_request, 'ServiceMethod', '0');

      -- позвать метод веб-сервиса
      l_response := soap_rpc.invoke(l_request);

      --Фикс неприятности в работе xpath при указанных xmlns
      p_clob := replace(l_response.doc.getClobVal(), 'xmlns', 'mlns');
      p_clob := l_response.doc.getClobVal();

      begin
        l_xml_resp := xmltype(p_clob);
        select l_xml_resp.extract('//TransactionShortReportResult/text()','xmlns="http://ws.unity-bars.com.ua/"').getstringval
          into l_errtxt
          from dual;
      exception
        when others then null;
      end;
      if instr(l_errtxt,'Exception') >0 then
        raise_application_error(-20100,l_errtxt);
      end if;
     -- l_tmp  := xmltype(l_clob);

  end sk_service;

  procedure sw_service(p_ReportSystemId in varchar2, p_ReportDateFrom in date, p_clob out clob )
  is
      l_request        soap_rpc.t_request;
      l_response       soap_rpc.t_response;
      l_url            varchar2(4000);
      l_xml_resp       xmltype;
      l_errtxt         varchar2(4000);
      l_params         varchar2(4000);
    function get_param_webconfig(par varchar2) return web_barsconfig.val%type is
      l_res web_barsconfig.val%type;
    begin
      select val into l_res from web_barsconfig where key = par;
      return trim(l_res);
    exception
      when no_data_found then
        raise_application_error(-20000, 'Не найден KEY=' || par || ' в таблице web_barsconfig!');
    end;
  begin
      begin
          select substr(val, 1, instr(val, '/', 1, 4)-1) || '/webservices/SingleWindowService.asmx' into l_url from web_barsconfig where key = 'EWA.URL_SEND_REF_STATUS';
      exception when no_data_found then
          raise_application_error(-20000, 'Параметр REPORT_SERVER_URL не задано');
      end;
      $if $$debug_flag $then
      l_url:= 'http://10.10.10.101:10102/barsroot/webservices/SingleWindowService.asmx'; --jeka потом убрать
      $end

      logger.info('finsb_service: begin call service ' || l_url || ' with method [ TransactionDetailReport ],  ReportSystemId =>[' || p_ReportSystemId || ']');
      --подготовить реквест
      l_request := soap_rpc.new_request(p_url         => l_url,
                                        p_namespace   => 'http://ws.unity-bars.com.ua/',
                                        p_method      => 'TransactionDetailReport',
                                        p_wallet_dir  => get_param_webconfig('VAL.Wallet_dir'),
                                        p_wallet_pass => get_param_webconfig('VAL.Wallet_pass'));

      -- добавить параметры
      --soap_rpc.add_parameter(l_request, 'ReportDateFrom', to_char(p_ReportDateFrom, 'DD.MM.YYYY hh24:mi:ss'));
      --soap_rpc.add_parameter(l_request, 'ReportSystemId', p_ReportSystemId);

      l_params:='<' || 'ReportDateFrom' || '>'||to_char(p_ReportDateFrom, 'DD.MM.YYYY hh24:mi:ss')||'</' || 'ReportDateFrom' || '>'
                ||
                '<' || 'ReportSystemId' || '>'||p_ReportSystemId||'</' || 'ReportSystemId' || '>';
      soap_rpc.add_parameter(l_request, 'Parameters', l_params);
      soap_rpc.add_parameter(l_request, 'ServiceMethod', '74');

      -- позвать метод веб-сервиса
      l_response := soap_rpc.invoke(l_request);

      --Фикс неприятности в работе xpath при указанных xmlns
      p_clob := l_response.doc.getClobVal();
      --p_clob := replace(l_response.doc.getClobVal(), 'xmlns', 'mlns');
     -- l_tmp  := xmltype(l_clob);

      begin
        l_xml_resp := xmltype(p_clob);
        select l_xml_resp.extract('//TransactionDetailReportResult/text()','xmlns="http://ws.unity-bars.com.ua/"').getstringval
          into l_errtxt
          from dual;
      exception
        when others then null;
      end;
      if instr(l_errtxt,'Exception') >0 then
        raise_application_error(-20100,'Помилка при отриманні даних: '||l_errtxt);
      end if;


  end sw_service;


  --ЦБД импортит файлы со сторонних систем
  procedure import_sw_data (p_date in date,p_kod_nbu VARCHAR2, p_type in number, p_message out varchar2) is
    title        varchar2(100) := 'pkg_SW_COMPARE.import_sw_data. ';
    l_clob       clob;
    l_com_id     SW_COMPARE.ID%TYPE;
    l_id         SW_FILES.ID%TYPE;
    l_message     varchar2(4000);
    l_err         number(17);
  begin
    bars_audit.info(title || 'Start import_sw_data. ');
      for cur in (select s.systemcode, s.vebservise,
                         f.id,f.operdate,f.state,f.data
                            from sw_system s
                            left join SW_files  f on f.systemcode = s.systemcode and f.operdate = p_date
                  where s.close_date > p_date  or s.close_date is null
                    and (s.kod_nbu = p_kod_nbu or p_kod_nbu is null))
      loop
      begin
      if cur.id is not null then  --перегрузка файла.
        select min(c.id)
        into l_com_id
        from SW_COMPARE C , OPER O
        where c.prn_file_import = cur.id
           and c.ref         = o.ref(+)
           and o.sos <> -1;

        if l_com_id is not null then
          raise_application_error(-20001,'Були знайдені операції по квитовкам по файлу = '||cur.id||' система = '||cur.systemcode||' Перегрузка неможлива!');
        else
         begin
           insert into SW_FILES_HIST(ID, SYSTEMCODE, OPERDATE, STATE, DATA, CHG_DATE)
                              values(cur.ID, cur.SYSTEMCODE, cur.OPERDATE, cur.STATE, cur.DATA, sysdate);
          delete from SW_IMPORT o where o.prn_file =  cur.id;
          delete from SW_files where ID = cur.id;

           update SW_OWN i set i.compare_id = 0 where i.prn_file in (select distinct prn_file_import from SW_COMPARE where prn_file_import =cur.id);

           delete from SW_COMPARE c where c.prn_file_import = cur.id;

         end;
        end if;
      end if;

        if cur.vebservise = 'Single Window' then
          pkg_SW_COMPARE.sw_service(p_ReportSystemId => cur.systemcode,
                                        p_ReportDateFrom => p_date,
                                        p_clob           => l_clob);
        else
          pkg_SW_COMPARE.sk_service(p_ReportSystemId => 'st',
                                    p_ReportDateFrom => p_date,
                                    p_clob           => l_clob);
        end if;

        if l_clob is not null then
           insert into SW_FILES (ID,SYSTEMCODE,OPERDATE,STATE,DATA) values (S_SW_FILES.NEXTVAL,cur.systemcode,p_date,1,l_clob)
           returning id into l_id;
        end if;

          parse_sw_data(p_id      => l_id,
                        p_err     => l_err,
                        p_message => l_message);
          if l_err > 0  then
             update SW_FILES set state = 2 where id = l_id;
             p_message:= 'Файл прийнято, але при обробці виникли помилки! Кількість помилок = '||l_err||'.  Дані о помилках в таблиці - '||l_message;
          else
             update SW_FILES set state = 3 where id = l_id;
             p_message:= 'Файл прийнято та оброблено без помилок!';
          end if;

        exception when others then  bars_audit.error( title || ': '||cur.SYSTEMCODE||' - ' || dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace() );
        if p_type = 2 then
            raise_application_error(-20001,title || ': '||cur.SYSTEMCODE||' - ' || dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace() );
        end if;
        end;
      end loop;

    --квитуем все, что не сквитовано на данный момент
    --наверно. лучше перенести на кнопку
   -- compare_data_auto(p_kod_nbu => null);
    bars_audit.info(title || 'Finish import_sw_data. ');
  exception when others then bars_audit.error( title || ': ' || dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace() );
    raise_application_error(-20001,'Помилка при запиті даних! -  '||title || ': ' || dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace() );
  end;

  --ЦБД парсит полученные файлы со сторонних систем
  procedure parse_sw_data (p_id      in  NUMBER,
                           p_err     out number,
                           p_message out varchar2 )
  is
    title        varchar2(100) := 'pkg_SW_COMPARE.parse_sw_data. ';
    l_clob       clob;
    l_parser      dbms_xmlparser.parser;
    l_doc         dbms_xmldom.domdocument;
    l_rowlist     dbms_xmldom.domnodelist;
    l_row         dbms_xmldom.domnode;
    l_str         VARCHAR2(2000);
    l_SW_IMPORT   t_SW_IMPORT           :=t_SW_IMPORT();
    l_date        date;
    l_systemcode SW_FILES.SYSTEMCODE%type;
    l_decimal    varchar2(1) := substr(to_char(1/3,'FM0D00'),2,1);
    l_amount     varchar2(100);
    l_flag       number;

  begin
    bars_audit.info(title || 'Start '||'p_id = '||p_id);

      BEGIN
        SELECT t.data, t.operdate, t.systemcode
          INTO l_clob , l_date, l_systemcode
          FROM SW_files t
         WHERE t.id = p_id;
/*      EXCEPTION
        WHEN no_data_found THEN
           bars_audit.error( title || ': ' || dbms_utility.format_error_stack() ||
                              chr(10) || dbms_utility.format_error_backtrace() );*/
      END;
        l_clob := replace(replace(replace(l_clob,chr(38)||'lt;','<'),chr(38)||'gt;','>'),'Short','Detail');
        l_parser := dbms_xmlparser.newparser;
        dbms_xmlparser.parseclob(l_parser, l_clob);
        bars_audit.trace(title || 'clob loaded');
        l_doc := dbms_xmlparser.getdocument(l_parser);
        bars_audit.trace(title || 'getdocument done');

         --формируем список строк
        l_rowlist := dbms_xmldom.getelementsbytagname(l_doc,'Transfer');
        FOR i IN 0 .. dbms_xmldom.getlength(l_rowlist) - 1
        LOOP
             l_row := dbms_xmldom.item(l_rowlist, i);
             l_SW_IMPORT .extend;

             dbms_xslprocessor.valueof(l_row, 'TRANSACTIONID/text()', l_str);
             l_SW_IMPORT (l_SW_IMPORT .last).transactionid   := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'TRN/text()', l_str);
             l_SW_IMPORT (l_SW_IMPORT .last).TRN   := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'BARSPOINTCODE/text()', l_str);
             l_SW_IMPORT (l_SW_IMPORT .last).barspointcode    := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'AMOUNT/text()', l_str);
             l_SW_IMPORT (l_SW_IMPORT .last).amount   := to_number(replace(replace(l_str,'.',l_decimal),',',l_decimal));

             dbms_xslprocessor.valueof(l_row, 'CURRENCY/text()', l_str);
             l_SW_IMPORT (l_SW_IMPORT .last).currency    := trim(l_str);

             dbms_xslprocessor.valueof(l_row, 'OPERATION/text()', l_str);
             l_SW_IMPORT (l_SW_IMPORT .last).operation   := to_number(l_str);

             dbms_xslprocessor.valueof(l_row, 'TOTALCOMISSION/text()', l_str);
             l_SW_IMPORT (l_SW_IMPORT .last).totalcomission  := to_number(replace(replace(l_str,'.',l_decimal),',',l_decimal));

             dbms_xslprocessor.valueof(l_row, 'BANKCOMISSION/text()', l_str);
             l_SW_IMPORT (l_SW_IMPORT .last).bankcomission  := to_number(replace(replace(l_str,'.',l_decimal),',',l_decimal));

         END LOOP;

/*        l_clob := replace(replace(replace(l_clob,chr(38)||'lt;','<'),chr(38)||'gt;','>'),'Short','Detail');
          for r in (select *
                      from xmltable(xmlnamespaces(default 'http://ws.unity-bars.com.ua/'),'TransactionDetailReportResponse/TransactionDetailReportResult/Transfer' passing xmltype(l_clob)
                                    columns
                                    TRANSACTIONID number        path 'TRANSACTIONID',
                                    BARSPOINTCODE varchar2(30)  path 'BARSPOINTCODE',
                                    AMOUNT        varchar2(20)  path 'AMOUNT',
                                    CURRENCY      varchar2(3)   path 'CURRENCY',
                                    OPERATION     number        path 'OPERATION'

                                   ) p
                   )
           loop
               l_SW_IMPORT .extend;
               l_SW_IMPORT (l_SW_IMPORT .last).transactionid   := r.transactionid;

               l_SW_IMPORT (l_SW_IMPORT .last).barspointcode   := r.barspointcode;
               l_amount  := replace(replace(r.amount,'.',l_decimal),',',l_decimal);
               l_sw_import(l_sw_import.last).amount := to_number(l_amount);

               l_SW_IMPORT (l_SW_IMPORT .last).currency    := trim(r.currency);

               l_SW_IMPORT (l_SW_IMPORT .last).operation   := to_number(r.operation);
           end loop;*/


             BEGIN
               EXECUTE IMMEDIATE ' delete from   ERR$_SW_IMPORT where prn_file = :p_id'
               using p_id;
             END;

             if l_SW_IMPORT IS NOT EMPTY then
              --обновление данных
              BEGIN
                FOR j IN l_SW_IMPORT.first .. l_SW_IMPORT.last
                loop
                    INSERT INTO SW_IMPORT(systemcode,
                                          operdate,
                                          transactionid,
                                          barspointcode,
                                          amount,
                                          currency,
                                          operation,
                                          kf,
                                          prn_file,
                                          totalcomission,
                                          bankcomission,
                                          TRN
                                           )
                    VALUES ( l_systemcode,
                             l_date ,
                             l_SW_IMPORT(j).transactionid,
                             l_SW_IMPORT(j).barspointcode,
                             l_SW_IMPORT(j).amount,
                             --l_SW_IMPORT(j).currency,
                             (select min(lcv)  from TABVAL$GLOBAL t where kv = l_SW_IMPORT(j).currency),
                             l_SW_IMPORT(j).operation,
                             substr (l_SW_IMPORT(j).barspointcode,2,6),
                             p_id,
                             l_SW_IMPORT(j).totalcomission,
                             l_SW_IMPORT(j).bankcomission,
                             l_SW_IMPORT(j).trn
                     )
                       log errors INTO ERR$_SW_IMPORT
                      ('INSERT') reject LIMIT unlimited;
               end loop;
             END;
            end if;

           BEGIN
             SELECT count(*) into p_err  from  ERR$_SW_IMPORT where prn_file =p_id;
             if p_err> 0 then
               p_message:='ERR$_SW_IMPORT HAS ERRORS';
             end if;
           END;

           --очистка,якщо виникли помилки
          l_SW_IMPORT.delete();
         -- l_SW_IMPORT:= NULL;

          dbms_xmlparser.freeparser(l_parser);
          dbms_xmldom.freedocument(l_doc);

    bars_audit.info(title || 'Finish. ');
  end;

  --установка соответствия
  procedure set_match (p_type          in number:=1, --    1-обычное квитование, 2 - фиктивное
                       p_kod_nbu       in SW_COMPARE.KOD_NBU%type ,
                       p_resolve       in SW_COMPARE.IS_RESOLVE%type,
                       p_cause         in SW_COMPARE.CAUSE_ERR%type,
                       p_ref           in SW_OWN.REF%type,
                       p_tt            in SW_OWN.TT%type,
                       p_transactionid in SW_IMPORT.TRANSACTIONID%type,
                       p_operation     in SW_IMPORT.operation%type,
                       p_ddate_oper    in SW_COMPARE.DDATE_OPER%type,
                       p_prn_file_own  in SW_COMPARE.PRN_FILE_OWN%type,
                       p_prn_file_import in SW_COMPARE.PRN_FILE_IMPORT%type,
                       p_kf            in SW_COMPARE.KF%type,
                       p_COMMENTS      in SW_COMPARE.COMMENTS%type
                       )
  is
  l_id         SW_COMPARE.ID%type;
  title        varchar2(100) := 'pkg_SW_COMPARE.set_match. ';
  begin
    bars_audit.info(title);
    savepoint DO_O;
    insert into SW_COMPARE(ID,DDATE_OPER,KOD_NBU,DDATE,REF, USERID_REF,KF,IS_RESOLVE,CAUSE_ERR,PRN_FILE_OWN,PRN_FILE_IMPORT,COMMENTS)
                    values(s_sw_compare.nextval,p_ddate_oper,p_kod_nbu, sysdate,null,null,p_kf,p_resolve,p_cause, p_prn_file_own,p_prn_file_import,p_COMMENTS)
    returning id into l_id;

    update SW_OWN O
       set o.compare_id = l_id
     where o.ref = p_ref
       and o.tt  = p_tt
       and o.kod_nbu = p_kod_nbu
       and o.compare_id = 0;
    if ( sql%rowcount = 0 ) and p_type=1  then rollback to DO_O; end if;  --дубляж, его не квитуем

    update SW_IMPORT I
       set I.COMPARE_ID = l_id
     where I.TRANSACTIONID = p_transactionid
       and I.OPERATION     = p_operation
       and i.systemcode in (select ss.systemcode from SW_SYSTEM ss where ss.kod_nbu = p_kod_nbu)
       and I.compare_id = 0;
   if ( sql%rowcount = 0 ) and p_type=1   then rollback to DO_O; end if;  --дубляж, его не квитуем

  end;

  -- автоматическое квитование по transactionid
  procedure compare_data_auto  (p_kod_nbu  in SW_COMPARE.KOD_NBU%type, p_message out varchar2 ) is
    title        varchar2(100) := 'pkg_SW_COMPARE.compare_data_auto. ';
    l_cause      SW_COMPARE.CAUSE_ERR%type:=0;
    l_count      number(17):=0;
    l_resolve    SW_COMPARE.IS_RESOLVE%type:=0;
  begin
  bars_audit.info(title);
  for cur in (select o.kf,
                     o.kod_nbu,
                     o.oper_branch,
                     i.barspointcode,
                     o.fdat,
                     i.operdate,
                     o.nls,
                     o.s,
                     o.sk,
                     i.amount,
                     o.ref,
                     o.tt,
                     i.transactionid,
                     i.operation ,
                     i.totalcomission,
                     i.bankcomission,
                     o.prn_file prn_file_own,
                     i.prn_file prn_file_import
              from SW_OWN O, SW_IMPORT I, SW_SYSTEM S, SW_TT_OPER TT
              where I.SYSTEMCODE = S.SYSTEMCODE
                and o.compare_id = 0
                and i.compare_id = 0
                and o.mtsc = i.transactionid
                and S.KOD_NBU = O.KOD_NBU
                and O.TT      = TT.TT
                and I.OPERATION = TT.ID
                and (o.kod_nbu = p_kod_nbu or p_kod_nbu is null))
  loop
    l_cause :=0;
    l_resolve:=0;
    if cur.oper_branch<> cur.barspointcode then
      l_cause:=l_cause+1;    -- переміщення касира
    end if;
    if cur.s<> cur.amount then
      l_cause:=l_cause+2; --некорректна сумма ЄВ-АБС
    end if;
    if cur.operdate<> cur.fdat then
      l_cause:=l_cause+4;  --розбіжність у даті ЄВ-АБС
    end if;
    if cur.nls is null then
      l_cause:=l_cause+8; -- відсутній рахунок ТВБВ (некорректний)
    end if;
     if cur.sk <> nvl(cur.totalcomission,0)-nvl(cur.bankcomission,0) and cur.tt = 'CN1'  then
      l_cause:=l_cause+16; -- некорректна комісія ЄВ-АБС
    end if;

    if l_cause not in (0, 4) then -- для розбіжність у даті ЄВ-АБС сразу делаем зеленой
      l_resolve:=1;
    end if;

    set_match(1,
              cur.kod_nbu,
              l_resolve,
              l_cause,
              cur.ref,
              cur.tt,
              cur.transactionid,
              cur.operation,
              cur.operdate,
              cur.prn_file_own,
              cur.prn_file_import,
              cur.kf,
              null);
  l_count:=l_count+1;
  end loop;
  p_message:='Успішно зквитовано ' ||l_count||' операцій.';
  end;

  -- ручное квитование
  procedure compare_data_hand  (p_kod_nbu       in SW_COMPARE.KOD_NBU%type ,
                                p_ref           in SW_OWN.REF%type,
                                p_tt            in SW_OWN.TT%type,
                                p_transactionid in SW_IMPORT.TRANSACTIONID%type,
                                p_operation     in SW_IMPORT.operation%type,
                                p_ddate_oper    in SW_COMPARE.DDATE_OPER%type,
                                p_prn_file      in SW_COMPARE.PRN_FILE_OWN%type,
                                p_kf            in  SW_COMPARE.KF%type,
                                p_comments      in SW_COMPARE.COMMENTS%type)
  is
    title        varchar2(100) := 'pkg_SW_COMPARE.compare_data_hand. ';
  begin
  bars_audit.info(title);
    set_match(2,
              p_kod_nbu,
              5,
              case when p_ref is null then 1002 else 1001 end,
              p_ref,
              p_tt,
              p_transactionid,
              p_operation,
              p_ddate_oper,
              case when p_ref is not null then p_prn_file else null end,
              case when p_ref is null then p_prn_file else null end,
              p_kf,
              p_comments);
  end;

 -- удаление квитования
  procedure  del_compare_data  (p_id           in SW_COMPARE.ID%type)
  is
    title        varchar2(100) := 'pkg_SW_COMPARE.del_compare_data. ';
    l_ref        SW_COMPARE.REF%TYPE;
    l_p1         number;
    l_p2         varchar2(100);
    l_resolve    sw_compare.is_resolve%type;
  begin
   bars_audit.info(title || ' ID='||p_id);
   select is_resolve into l_resolve from SW_COMPARE where id=p_id;
   if l_resolve <> 5 then
       update SW_COMPARE c set c.is_resolve = 1 where c.id = p_id return c.ref into l_ref;
       if l_ref is not null then
          p_back_dok(l_ref, 5, null, l_p1, l_p2);
       end if;
   else
      delete from SW_COMPARE c where c.id = p_id;
      update SW_OWN c set c.compare_id = 0 where c.compare_id = p_id;
      update SW_IMPORT c set c.compare_id = 0 where c.compare_id = p_id;
   end if;
  exception when others then raise_application_error(-20001,'Помилка видалення квитовки - ID = '||p_id||' '||SQLERRM,TRUE);
  end;

  -- Устранение причины расхождения
  procedure  resolve_cause  (p_id           in SW_COMPARE.ID%type,
                             p_comments     in SW_COMPARE.COMMENTS%type default null)
  is
    title        varchar2(100) := 'pkg_SW_COMPARE.resolve_cause. ';
    REF_ int ;
    NAZN_ varchar2(180);
    FL_ int  ;
    l_cause_err SW_COMPARE.CAUSE_ERR%TYPE;
    l_s         OPER.S%TYPE;
    l_sk        OPER.S%TYPE:=0;
    l_nls       accounts.nls%type;
    l_nms       accounts.nms%type;
    l_kv        accounts.kv%type;
    l_nbs       accounts.nbs%type;
    l_ob22      accounts.ob22%type;
    l_okpo      customer.okpo%type;
    l_tt        sw_cause_err.tt%type;
    l_nls2      accounts.nls%type;
    l_nms2      accounts.nms%type;
    l_branch_b  branch.branch%type;
    l_branch_a  branch.branch%type;
    l_pdat      date;

  begin
   bars_audit.info(title || ' ID='||p_id);

   begin
    select c.cause_err, o.s*100, aa.nls, aa.nms, aa.kv,aa.nbs, aa.ob22, c1.okpo , ce.tt, o.oper_branch, o.pdat , o.sk*100
    into l_cause_err, l_s, l_nls, l_nms, l_kv, l_nbs, l_ob22, l_okpo , l_tt, l_branch_a, l_pdat, l_sk
    from SW_COMPARE c, SW_OWN O, TABVAL$GLOBAL tg, accounts aa, customer c1, sw_cause_err ce
    where c.id = p_id
      and c.is_resolve = 1
      and c.id = o.compare_id
      and o.kv = tg.lcv
      and aa.nls = o.nls
      and aa.kv = tg.kv
      and c1.rnk = aa.rnk
      and ce.id  = c.cause_err;

   exception when others then raise_application_error (-20001,'Квитовка '||p_id||' вже оброблена або взагалі не потребує вирішення!');
   end;

   if l_tt in ('PS1')  then
     GL.REF (REF_);
     bars_audit.info(title || 'Start pay document #' || to_char( REF_ ));
     begin
       select barspointcode
       into l_branch_b
       from sw_import
       where compare_id = p_id;
       l_nls2:=nbs_ob22_bra(nbs_     => l_nbs,
                            ob22_    => l_ob22,
                            p_branch => l_branch_b);
       select  substr(a.nms,1,38) into l_nms from accounts a where a.nls = l_nls2 and a.kv =  l_kv;
     NAZN_:=substr('Перенесення коштів по операції здійснення переказу коштів за '||to_char(l_pdat,'dd.mm.yyyy')||' у зв’язку із переміщенням касира.',1,160);
     exception when others then raise_application_error (-20001,'Помилка при визначенні рахунку переводу!');
     end;

    begin
      select decode (substr(flags,38,1), '1',1,0) into FL_ from tts where tt=l_tt;
    exception
      when NO_DATA_FOUND then
        logger.error( title ||'  Операція НЕ знайдена '||l_tt);
        raise_application_error(-(20203),'\9350 - Cannot found '||'Операція НЕ знайдена '||l_tt||' '||SQLERRM,TRUE);
    end;

          GL.IN_DOC3( ref_   => REF_,
                      tt_    => l_tt,         dk_    => case when l_nbs = '2809' then 0 else 1 end,
                      vob_   => 6,            nd_    => REF_,
                      pdat_  => sysdate,      data_  => gl.bDATE,
                      vdat_  => gl.bDATE,     datp_  => gl.bDATE,
                      kv_    => l_kv,         kv2_   => l_kv,
                      s_     => l_s,          s2_    => l_s,
                      mfoa_  => gl.AMFO,      mfob_  => gl.AMFO,
                      nlsa_  => l_nls,        nlsb_  => l_nls2,
                      nam_a_ => l_NMS,        nam_b_ => l_nms,
                      id_a_  => l_okpo,       id_b_  => l_okpo,
                      nazn_  => NAZN_,        uid_   => null,
                      d_rec_ => null,         sk_    => null,
                      id_o_  => null,         sign_  => null,
                      sos_   => null,         prty_  => null
                    );

          GL.PAYV( FL_, REF_, GL.BDATE, l_tt, case when l_nbs = '2809' then 0 else 1 end
                 , l_kv, l_NLS, l_s
                 , l_kv, l_NLS2, l_s );

          if l_sk > 0 then
          GL.PAYV( FL_, REF_, GL.BDATE, l_tt, case when l_nbs = '2809' then 0 else 1 end
                 , l_kv, l_NLS, l_sk
                 , l_kv, l_NLS2, l_sk );
          end if;

   update SW_COMPARE c
      set c.is_resolve = 4,
          c.ref        = REF_,
          c.userid_ref = gl.aUID,
          c.comments   = p_comments
    where c.id = p_id ;
  else
   update SW_COMPARE c
      set c.is_resolve = 4,
          c.comments   = p_comments
    where c.id = p_id ;
  end if;


  exception when others then raise_application_error(-20001,'Помилка вирішення розбіжності - ID = '||p_id||'  '||SQLERRM);
  end;

  function get_row_count (p_date in date
                         ,p_kod_nbu VARCHAR2)
    return number
    is
    v_ret number;
  begin
    select count(1)
      into v_ret
      from sw_import si,
           sw_system ss
      where si.operdate = p_date
        and (ss.kod_nbu = p_kod_nbu or p_kod_nbu is null)
        and si.systemcode = ss.systemcode;
    return v_ret;
  exception
    when others then
      return 0;
  end get_row_count;

  function get_own_row_count (p_date in date
                             ,p_mfo in varchar)
    return number
    is
    v_ret number;
  begin
    select count(1)
      into v_ret
      from sw_own so
      where (so.kf,so.prn_file) in (select scf.kf, scf.id
                                      from sw_ca_files scf
                                      where scf.kf = p_mfo
                                        and scf.ddate = p_date);
    return v_ret;
  exception
    when others then return 0;
  end;


begin
  null;
end  PKG_SW_COMPARE;
/
