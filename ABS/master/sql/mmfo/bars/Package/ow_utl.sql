
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/ow_utl.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.OW_UTL is

  -- Author  : VITALII.KHOMIDA
  -- Created : 11.08.2016 13:01:00
  -- Purpose :
  type t_rec is record(
    id              number,
    ext_file_id     number,
    ext_id          varchar2(100),
    oper_type       number(1),
    date_in         date,
    contract_number varchar2(14),
    product_code    varchar2(32),
    card_type       varchar2(32),
    oper_date       date,
    status          number,
    msg             varchar2(254),
    okpo            varchar2(14),
    okpo_n          number(22),
    card_expire     varchar2(4),
    eng_first       varchar2(30),
    eng_last        varchar2(30)
    );
  
  procedure rebranch_file_processing(p_filename in varchar2,
                                     p_filebody in blob,
                                     p_fileid   out number,
                                     p_msg      out varchar2);

  procedure get_nd(p_rnk in number);
  function get_filefromzip(p_zipped_blob blob) return blob;

  procedure acc_req_file_processing;


  procedure request_procesing(p_ext_file_id in varchar2);

end;  
/
CREATE OR REPLACE PACKAGE BODY ow_utl is

  type t_rebranch is table of ow_rebranch_data%rowtype index by pls_integer;
  type t_accreq is table of w4_acc_request%rowtype index by pls_integer;
  g_modcode         constant varchar2(3)   := 'BPK';  
  c_END_OF_CENTRAL_DIRECTORY constant raw(4) := hextoraw( '504B0506' ); -- End of central directory signature for zip

  procedure parse_rebranch_file(p_fileid   in number,
                                p_filebody in clob) is
    l_parser dbms_xmlparser.parser;
    l_doc    dbms_xmldom.domdocument;
    l_rows   dbms_xmldom.domnodelist;
    l_row    dbms_xmldom.domnode;
    l_lines  t_rebranch;
    l_tmp    number;
  begin
    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, p_filebody);
    l_doc := dbms_xmlparser.getdocument(l_parser);

    l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'ROW');
    for i in 0 .. dbms_xmldom.getlength(l_rows) - 1
    loop
      begin
        l_row := dbms_xmldom.item(l_rows, i);

        l_lines(i).kf := sys_context('bars_context','user_mfo');
        l_lines(i).id := s_ow_rebranch_data.nextval;
        l_lines(i).fileid := p_fileid;
        l_lines(i).idn := i + 1;
        l_lines(i).rnk := to_number(dbms_xslprocessor.valueof(l_row,
                                                              'RNK/text()'));
        l_lines(i).nls := dbms_xslprocessor.valueof(l_row, 'NLS/text()');
        l_lines(i).branch := dbms_xslprocessor.valueof(l_row,
                                                       'BRANCH/text()');
        l_lines(i).state := 0;

      exception
        when others then
          l_lines(i).kf := sys_context('bars_context','user_mfo');
          l_lines(i).state := 10;
          l_lines(i).msg := 'Помилка парсінгу строки :' ||
                            dbms_utility.format_error_stack() || chr(10) ||
                            dbms_utility.format_error_backtrace();

      end;

    end loop;

    forall j in l_lines.first .. l_lines.last
      insert into ow_rebranch_data values l_lines (j);
    l_tmp := l_lines.count;
    update ow_files
       set file_n      = l_tmp,
           file_status = 1,
           err_text    = null
     where id = p_fileid;
  end;

  procedure upd_branch(p_acc_list in number_list,
                       p_branch   in varchar2) is
  begin
    forall i in p_acc_list.first .. p_acc_list.last
      update accounts t
         set t.tobo   = p_branch,
             t.branch = p_branch
       where t.acc = p_acc_list(i) and t.branch <> p_branch;
  end;

  procedure rebranch_data_procesing(p_fileid in number) is
    l_lines    t_rebranch;
    l_acc_list number_list;
    l_nd       w4_acc.nd%type;
  begin
    select t.* bulk collect
      into l_lines
      from ow_rebranch_data t
     where t.fileid = p_fileid and t.state = 0;
    if l_lines.count > 0 then
      for i in l_lines.first .. l_lines.last
      loop
        begin
          savepoint befor_upd;
          select nd
            into l_nd
            from w4_acc w
            join accounts a
              on w.acc_pk = a.acc and a.nls = l_lines(i).nls and
                 a.rnk = l_lines(i).rnk;

          select atr_vallue bulk collect
            into l_acc_list
            from w4_acc unpivot(atr_vallue for attribute_name in(acc_2207,
                                                                  acc_2208,
                                                                  acc_2209,
                                                                  acc_2625d,
                                                                  acc_2625x,
                                                                  acc_2627,
                                                                  acc_2627x,
                                                                  acc_2628,
                                                                  acc_3570,
                                                                  acc_3579,
                                                                  acc_9129,
                                                                  acc_ovr,
                                                                  acc_pk))
           where nd = l_nd;

          upd_branch(l_acc_list, l_lines(i).branch);

          -- формуємо заявку в СМ на зміну бранча
          begin
            bars_ow.add_deal_to_cmque(l_nd, 7);
            l_lines(i).state := 1;
            l_lines(i).msg := 'Успішно';
          exception
            when others then
              l_lines(i).state := 10;
              l_lines(i).msg := 'Помилка при відрпавці запиту в СМ:' ||
                                dbms_utility.format_error_stack() ||
                                chr(10) ||
                                dbms_utility.format_error_backtrace();
          end;

        exception
          when no_data_found then
            rollback to befor_upd;
            l_lines(i).state := 10;
            l_lines(i).msg := 'Рахунок у клієнта не знайдено';
          when others then
            rollback to befor_upd;
            l_lines(i).state := 10;
            l_lines(i).msg := dbms_utility.format_error_stack() || chr(10) ||
                              dbms_utility.format_error_backtrace();
        end;
      end loop;

      forall ii in l_lines.first .. l_lines.last
        update ow_rebranch_data t
           set t.state = l_lines(ii).state,
               t.msg   = l_lines(ii).msg
         where t.id = l_lines(ii).id;
      update ow_files
         set file_status = 2,
             err_text    = null
       where id = p_fileid;
    end if;
  end;

  procedure rebranch_file_processing(p_filename in varchar2,
                                     p_filebody in blob,
                                     p_fileid   out number,
                                     p_msg      out varchar2) is
    l_filename     varchar2(100);
    l_filetype     varchar2(8) := 'REBRANCH';
    l_id           number := null;
    i              number;
    l_blob         blob;
    l_clob         clob;
    l_warning      integer;
    l_dest_offset  integer := 1;
    l_src_offset   integer := 1;
    l_blob_csid    number := dbms_lob.default_csid;
    l_lang_context number := dbms_lob.default_lang_ctx;
    h              varchar2(100) := 'ow_files_utl.rebranch_file_processing. ';

  begin

    bars_audit.info(h || 'Start.');

    l_blob := utl_compress.lz_uncompress(p_filebody);
    dbms_lob.createtemporary(l_clob, false);

    dbms_lob.converttoclob(dest_lob     => l_clob,
                           src_blob     => l_blob,
                           amount       => dbms_lob.lobmaxsize,
                           dest_offset  => l_dest_offset,
                           src_offset   => l_src_offset,
                           blob_csid    => l_blob_csid,
                           lang_context => l_lang_context,
                           warning      => l_warning);

    bars_audit.info(h || 'File converted to clob');

    l_id := bars_sqnc.get_nextval('S_OWFILES');

    insert into ow_files
      (id, file_type, file_name, file_body, file_status, origin)
    values
      (l_id, l_filetype, p_filename, empty_blob(), 0, 0);
    p_fileid := l_id;

    parse_rebranch_file(p_fileid, l_clob);

    rebranch_data_procesing(p_fileid);

    bars_audit.info(h || 'Finish.' || 'p_msg=>' || p_msg);
  exception
    when others then
      update ow_files
         set file_status = 3,
             err_text    = dbms_utility.format_error_stack() || chr(10) ||
                           dbms_utility.format_error_backtrace()
       where id = p_fileid;

  end;
   procedure get_nd(p_rnk in number)
     is

  begin
   for z in (select w.nd
     from w4_acc w, accounts a
     where
        w.acc_pk = a.acc
       and W.DAT_CLOSE is null
       and a.dazs is null
       and rnk =p_rnk)
     loop
     begin
        bars.bars_ow.add_deal_to_cmque(z.nd,3);
     exception when OTHERS then
        bars_audit.info('Помилка при відправці № дог=' || to_char(z.nd));
     end;
     end loop;

   end;
  function little_endian( p_big number, p_bytes pls_integer := 4 )
  return raw
  is
    t_big number := p_big;
  begin
    if t_big > 2147483647
    then
      t_big := t_big - 4294967296;
    end if;
    return utl_raw.substr( utl_raw.cast_from_binary_integer( t_big, utl_raw.little_endian ), 1, p_bytes );
  end;
     
  function blob2num(p_blob blob,
                    p_len  integer,
                    p_pos  integer) return number is
    rv number;
  begin
    rv := utl_raw.cast_to_binary_integer(dbms_lob.substr(p_blob,
                                                         p_len,
                                                         p_pos),
                                         utl_raw.little_endian);
    if rv < 0 then
      rv := rv + 4294967296;
    end if;
    return rv;
  end;
  function get_filefromzip(p_zipped_blob blob) return blob is
    t_tmp      blob;
    t_ind      integer;
    t_hd_ind   integer;
    t_fl_ind   integer;
    t_len      integer;
  begin
    t_ind := nvl(dbms_lob.getlength(p_zipped_blob), 0) - 21;
    loop
      exit when t_ind < 1 or dbms_lob.substr(p_zipped_blob, 4, t_ind) = c_end_of_central_directory;
      t_ind := t_ind - 1;
    end loop;
    --
    if t_ind <= 0 then
      return null;
    end if;
    --
    t_hd_ind := blob2num(p_zipped_blob, 4, t_ind + 16) + 1;
    for i in 1 .. blob2num(p_zipped_blob, 2, t_ind + 8)
    loop
        t_len := blob2num(p_zipped_blob, 4, t_hd_ind + 24); -- uncompressed length
        if t_len = 0 then
            -- empty file
            return empty_blob();
        end if;
        --
        if dbms_lob.substr(p_zipped_blob, 2, t_hd_ind + 10) in
           (hextoraw('0800') -- deflate
           ,
            hextoraw('0900') -- deflate64
            ) then
          t_fl_ind := blob2num(p_zipped_blob, 4, t_hd_ind + 42);
          t_tmp    := hextoraw('1F8B0800000000000003'); -- gzip header
          dbms_lob.copy(t_tmp,
                        p_zipped_blob,
                        blob2num(p_zipped_blob, 4, t_hd_ind + 20),
                        11,
                        t_fl_ind + 31 +
                        blob2num(p_zipped_blob, 2, t_fl_ind + 27) -- File name length
                        + blob2num(p_zipped_blob, 2, t_fl_ind + 29) -- Extra field length
                        );
          dbms_lob.append(t_tmp,
                          utl_raw.concat(dbms_lob.substr(p_zipped_blob,
                                                         4,
                                                         t_hd_ind + 16) -- CRC32
                                        ,
                                         little_endian(t_len) -- uncompressed length
                                         ));
          return utl_compress.lz_uncompress(t_tmp);
        end if;
        --
        if dbms_lob.substr(p_zipped_blob, 2, t_hd_ind + 10) =
           hextoraw('0000') -- The file is stored (no compression)
         then
          t_fl_ind := blob2num(p_zipped_blob, 4, t_hd_ind + 42);
          dbms_lob.createtemporary(t_tmp, true);
          dbms_lob.copy(t_tmp,
                        p_zipped_blob,
                        t_len,
                        1,
                        t_fl_ind + 31 +
                        blob2num(p_zipped_blob, 2, t_fl_ind + 27) -- File name length
                        + blob2num(p_zipped_blob, 2, t_fl_ind + 29) -- Extra field length
                        );
          return t_tmp;
        end if;
      t_hd_ind := t_hd_ind + 46 + blob2num(p_zipped_blob, 2, t_hd_ind + 28) -- File name length
                  + blob2num(p_zipped_blob, 2, t_hd_ind + 30) -- Extra field length
                  + blob2num(p_zipped_blob, 2, t_hd_ind + 32); -- File comment length
    end loop;
    --
    return null;
  end;
  
    procedure bulk_insert_accreq(l_rec in t_accreq) is
  begin
    forall j in l_rec.first .. l_rec.last
      insert into w4_acc_request values l_rec (j);
  end;

  procedure parse_acc_req_file(p_fileid   in varchar2,
                               p_filebody in clob) is
    l_parser dbms_xmlparser.parser;
    l_doc    dbms_xmldom.domdocument;
    l_rows   dbms_xmldom.domnodelist;
    l_row    dbms_xmldom.domnode;
    l_lines  t_accreq;
    h        varchar2(100) := 'ow_files_utl.parse_acc_req_file. ';
  begin

    bars_audit.info(h || 'File(id=' || p_fileid || ') is parsed');
    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, p_filebody);
    l_doc := dbms_xmlparser.getdocument(l_parser);

    l_rows := dbms_xmldom.getelementsbytagname(l_doc, 'row');
    for c_line in 0 .. dbms_xmldom.getlength(l_rows) - 1
    loop
      begin
        l_row := dbms_xmldom.item(l_rows, c_line);

        l_lines(c_line).id := s_w4_acc_request.nextval;
        l_lines(c_line).ext_file_id := p_fileid;
        l_lines(c_line).ext_id := dbms_xslprocessor.valueof(l_row,
                                                            'ext_id/text()');
        l_lines(c_line).oper_type := to_number(dbms_xslprocessor.valueof(l_row,
                                                                         'oper_type/text()'));
        l_lines(c_line).date_in := sysdate;
        l_lines(c_line).lastedit := sysdate;
        l_lines(c_line).contract_number := dbms_xslprocessor.valueof(l_row,
                                                                     'contract_number/text()');
        l_lines(c_line).product_code := dbms_xslprocessor.valueof(l_row,
                                                                  'product_code/text()');
        l_lines(c_line).card_type := dbms_xslprocessor.valueof(l_row,
                                                               'card_type/text()');
        l_lines(c_line).oper_date := to_date(dbms_xslprocessor.valueof(l_row,
                                                                       'oper_date/text()'),
                                             'dd.mm.yyyy');
        l_lines(c_line).status := 0;
        l_lines(c_line).okpo := dbms_xslprocessor.valueof(l_row,
                                                          'okpo/text()');
        l_lines(c_line).okpo_n := dbms_xslprocessor.valueof(l_row,
                                                            'okpo_n/text()');
        l_lines(c_line).card_expire := dbms_xslprocessor.valueof(l_row,
                                                                 'card_expire/text()');
        l_lines(c_line).eng_firstname := substr(dbms_xslprocessor.valueof(l_row,
                                                                     'eng_firts/text()'), 1, 30);
        l_lines(c_line).eng_lastname := substr(dbms_xslprocessor.valueof(l_row,
                                                                     'eng_last/text()'), 1, 30);
        l_lines(c_line).kf := sys_context('bars_context', 'user_mfo');
        if mod(c_line + 1, 1000) = 0 then
          bulk_insert_accreq(l_lines);
          l_lines.delete;
        end if;
      exception
        when others then
          l_lines(c_line).kf := sys_context('bars_context', 'user_mfo');
          l_lines(c_line).status := 2;
          l_lines(c_line).msg := 'Помилка парсінгу строки :' ||
                                 dbms_utility.format_error_stack() ||
                                 chr(10) ||
                                 dbms_utility.format_error_backtrace();

      end;
    end loop;

    bulk_insert_accreq(l_lines);
    bars_audit.info(h || 'File(id=' || p_fileid || ')parsed');
  end;

  function can_closeacc(p_acc in number) return number is
    l_cnt number;
  begin
    begin
      select 1
        into l_cnt
        from accounts b
       where b.acc = p_acc and b.ostc = 0 and b.ostb = 0 and b.ostf = 0 and
             b.dapp < bankdate and b.daos <= bankdate
         for update nowait;
    exception
      when no_data_found then
        l_cnt := 0;
    end;
    return l_cnt;
  end can_closeacc;

  function can_close_acc(p_close number,
                         p_acc   number,
                         p_msg   in out varchar2) return number is
    l_ret number := 0;
    l_tmp varchar2(14);
  begin
    if p_close = 1 then
      if p_acc is not null then
        l_ret := can_closeacc(p_acc);
        if l_ret = 0 then
          begin
            select nls into l_tmp from accounts where acc = p_acc;
            p_msg := 'Рахунок ' || l_tmp || ' - неможливо закрити';
          exception
            when no_data_found then
              null;
          end;
        end if;
      else
        l_ret := 1;
      end if;
    end if;
    return l_ret;
  end;

  procedure close_acc(p_acc number) is
  begin
    if p_acc is not null then
      update accounts
         set dazs = decode(dazs, null, bankdate, dazs)
       where acc = p_acc;
    end if;
  end;

  procedure close_deal(p_req in out ow_utl.t_rec) is

    l_msg       cm_acc_request.abs_msg%type;
    l_acc       accounts.acc%type;
    l_nls       accounts.nls%type;
    l_kv        accounts.kv%type;
    l_ostc      accounts.ostc%type;
    l_ostb      accounts.ostb%type;
    l_ostf      accounts.ostf%type;
    l_dapp      accounts.dapp%type;
    l_acc_ovr   number;
    l_acc_3570  number;
    l_acc_2208  number;
    l_acc_9129  number;
    l_acc_2627  number;
    l_acc_2207  number;
    l_acc_3579  number;
    l_acc_2209  number;
    l_acc_2625x number;
    l_acc_2627x number;
    l_acc_2625d number;
    l_acc_2628  number;
    l_close     number; -- Признак: счет закрывать
    l_cnt       number;
    l_iserr     boolean := false;
    ora_lock exception;
    pragma exception_init(ora_lock, -54);
    h varchar2(100) := 'ow_utl.close_nd. ';

  begin

    bars_audit.trace(h || 'Start.');

    l_close := 1;
    l_msg   := null;

    begin
      select a.acc, a.nls, a.kv, a.ostc, a.ostb, a.ostf, a.dapp, o.acc_ovr,
             o.acc_3570, o.acc_2208, o.acc_9129, o.acc_2627, o.acc_2207,
             o.acc_3579, o.acc_2209, o.acc_2625x, o.acc_2627x, o.acc_2625d,
             o.acc_2628
        into l_acc, l_nls, l_kv, l_ostc, l_ostb, l_ostf, l_dapp, l_acc_ovr,
             l_acc_3570, l_acc_2208, l_acc_9129, l_acc_2627, l_acc_2207,
             l_acc_3579, l_acc_2209, l_acc_2625x, l_acc_2627x, l_acc_2625d,
             l_acc_2628
        from accounts a, w4_acc o
       where a.acc = o.acc_pk and a.nls = p_req.contract_number and
             a.dazs is null;
      -- счета с остатком
      if l_ostc <> 0 or l_ostb <> 0 or l_ostf <> 0 then
        l_msg := 'Ненульовий залишок';
      end if;
      -- были обороты сегодня
      if l_dapp is not null and l_dapp >= bankdate then
        l_msg := 'Є обороти';
      end if;
    exception
      when no_data_found then
        l_msg := 'Рахунок не знайдено або закрито';
    end;

    if l_msg is null then

      begin
        savepoint sp_before;
        l_close := 1;

        -- блокируем карточный счет
        select 1
          into l_cnt
          from accounts
         where acc = l_acc
           for update nowait;

        -- дополнительные проверки:
        l_close := can_close_acc(l_close, l_acc_ovr, l_msg);
        l_close := can_close_acc(l_close, l_acc_3570, l_msg);
        l_close := can_close_acc(l_close, l_acc_2208, l_msg);
        l_close := can_close_acc(l_close, l_acc_9129, l_msg);
        l_close := can_close_acc(l_close, l_acc_2627, l_msg);
        l_close := can_close_acc(l_close, l_acc_2207, l_msg);
        l_close := can_close_acc(l_close, l_acc_3579, l_msg);
        l_close := can_close_acc(l_close, l_acc_2209, l_msg);
        l_close := can_close_acc(l_close, l_acc_2625x, l_msg);
        l_close := can_close_acc(l_close, l_acc_2627x, l_msg);
        l_close := can_close_acc(l_close, l_acc_2625d, l_msg);
        l_close := can_close_acc(l_close, l_acc_2628, l_msg);

        if l_close = 1 then

          -- закрываем счет
          update accounts set dazs = bankdate where acc = l_acc;

          -- закрываем все привязанные счета
          close_acc(l_acc_ovr);
          close_acc(l_acc_3570);
          close_acc(l_acc_2208);
          close_acc(l_acc_9129);
          close_acc(l_acc_2627);
          close_acc(l_acc_2207);
          close_acc(l_acc_3579);
          close_acc(l_acc_2209);
          close_acc(l_acc_2625x);
          close_acc(l_acc_2627x);
          close_acc(l_acc_2625d);
          close_acc(l_acc_2628);

          begin
            insert into accountsw
              (acc, tag, value)
            values
              (l_acc, 'RCLOS', 'Закрито по інформації з CardMake');
          exception
            when dup_val_on_index then
              null;
          end;

          bars_audit.info(h || 'Account ' || l_nls || '/' || l_kv ||
                          ' closed.');

          dpt_web.close_sto_argmnt(p_dptid    => null,
                                   p_accid    => l_acc,
                                   p_argmntid => null);

          dpt_web.close_sto_argmnt(p_dptid    => null,
                                   p_accid    => l_acc_2625d,
                                   p_argmntid => null);

        end if;

      exception
        when ora_lock then
          rollback to sp_before;
          l_iserr := true;
      end;

    end if;
    p_req.msg := l_msg;

    if (l_iserr) then
      p_req.msg := 'Рахунки для закриття блоковані іншими користувачами.';
    end if;

    bars_audit.trace(h || 'Finish.');

  end;

  procedure alter_deal(p_req in out ow_utl.t_rec) is
    l_date              date;
    l_msg               varchar2(254);
    l_nd                w4_acc.nd%type;
    l_term              number;
    l_acc               number;
    l_acc_ovr           number;
    l_card_code         w4_acc.card_code%type;
    l_old_nbs           w4_product.nbs%type;
    l_old_kv            w4_product.kv%type;
    l_old_ob22          w4_product.ob22%type;
    l_old_tip           w4_product.tip%type;
    l_new_nbs           w4_product.nbs%type;
    l_new_kv            w4_product.kv%type;
    l_new_ob22          w4_product.ob22%type;
    l_new_tip           w4_product.tip%type;
    l_ovr_old_nbs       accounts.nbs%type;
    l_ovr_old_nls       accounts.nls%type;
    l_ovr_old_nms       accounts.nms%type;
    l_ovr_old_dazs      date;
    l_ovr_old_ob22      accounts.ob22%type;
    l_ovr_new_nbs       accounts.nbs%type;
    l_ovr_new_acc       number;
    l_ovr_new_ob22      accounts.ob22%type;
    l_bpk_proect_id_new number;
    l_name_new          bpk_proect.name%type;
    l_bpk_proect_id_old number;
    l_name_old          bpk_proect.name%type;
    l_trmask            bars_ow.t_trmask;
    h                   varchar2(100) := 'ow_utl.alter_deal. ';
  begin
    bars_audit.trace(h || 'Start.');
    -- змінюємо срок дії
    if p_req.card_expire is not null then
      begin
        l_date := to_date('01' || substr(p_req.card_expire, -2) || '20' ||
                          substr(p_req.card_expire, 1, 2),
                          'ddmmyyyy');
      exception
        when others then
          l_msg := 'Некоректно задано термін дії основної картки';
      end;

      if l_msg is not null then
        begin
          select o.nd
            into l_nd
            from accounts a, w4_acc o
           where a.acc = o.acc_pk and a.nls = p_req.contract_number and
                 a.dazs is null;
          l_term := months_between(to_date('01' ||
                                           substr(p_req.card_expire, -2) || '20' ||
                                           substr(p_req.card_expire, 1, 2),
                                           'ddmmyyyy'),
                                   trunc(p_req.oper_date, 'mm'));
          if l_term < 0 then
            l_msg := 'Некоректно задано термін дії  основної картки';
          else
            if l_term <> 0 then
              bars_ow.set_term(l_nd, p_req.oper_date, l_term);
            end if;
          end if;
        exception
          when no_data_found then
            l_msg := 'Рахунок не знайдено або закрито';
        end;
      end if;
    end if;

    -- змінюємо налаштування продукту
    if l_msg is null then
      bars_audit.info(h || 'Start.');

      l_msg := null;

      -- проверка новой карты
      begin
        select p.nbs, p.kv, p.ob22, p.tip
          into l_new_nbs, l_new_kv, l_new_ob22, l_new_tip
          from w4_card c, w4_product p
         where c.code = p_req.card_type and c.product_code = p.code;
      exception
        when no_data_found then
          l_msg := 'Не знайдено картку ' || p_req.card_type;
      end;

      -- поиск счета
      if l_msg is null then
        begin
          select o.nd, a.acc, o.acc_ovr, o.card_code
            into l_nd, l_acc, l_acc_ovr, l_card_code
            from accounts a, w4_acc o
           where a.acc = o.acc_pk and a.nls = p_req.contract_number and
                 (a.dazs is null or (a.nbs is null and a.dazs is not null));
        exception
          when no_data_found then
            l_msg := 'Рахунок не знайдено або закрито';
        end;
      end if;

      -- проверка старой карты
      if l_msg is null then
        begin
          select p.nbs, p.kv, p.ob22, p.tip
            into l_old_nbs, l_old_kv, l_old_ob22, l_old_tip
            from w4_card c, w4_product p
           where c.code = l_card_code and c.product_code = p.code;
          if l_old_nbs <> l_new_nbs or l_old_kv <> l_new_kv then
            l_msg := 'Параметри старого продукту не відповідають параметрам нового продукту (НБС, валюта)';
          end if;
        exception
          when no_data_found then
            l_msg := 'Не знайдено картку ' || l_card_code;
        end;
      end if;

      -- Поиск нового идетнификатора зп проекта

      if l_msg is not null then
        begin
          select e.id, e.name
            into l_bpk_proect_id_old, l_name_old
            from accountsw w, bpk_proect e, w4_product p
           where w.acc = l_acc and w.tag = 'PK_PRCT' and
                 w.value = to_char(e.id) and e.product_code = p.code and
                 p.grp_code = 'SALARY';
        exception
          when no_data_found then
            l_bpk_proect_id_old := null;
            l_name_old          := null;
        end;
      end if;

      if p_req.okpo is not null and p_req.okpo_n is not null and
         l_msg is null then
        begin
          select t.id, t.name
            into l_bpk_proect_id_new, l_name_new
            from bpk_proect t, w4_card w
           where t.product_code = w.product_code and t.okpo = p_req.okpo and
                 w.code = p_req.card_type and t.used_w4 = 1 and
                 t.okpo_n = p_req.okpo_n;
        exception
          when no_data_found then
            l_msg := 'Не знайдено зп проект по параметрам OKPO=' ||
                     p_req.okpo || ' OKPO_N=' || p_req.okpo_n ||
                     ' CARD_TYPE =' || p_req.card_type;
        end;

      end if;

      if l_msg is null and
         nvl(l_bpk_proect_id_old, 0) <> nvl(l_bpk_proect_id_new, 0) then
        -- меняем идентификатор зп проекта
        accreg.setaccountwparam(l_acc, 'PK_PRCT', l_bpk_proect_id_new);
      end if;
      if l_msg is null and nvl(l_name_old, '0') <> nvl(l_name_new, '0') then
        -- меняем название зп проекта
        accreg.setaccountwparam(l_acc, 'PK_WORK', l_name_new);
      end if;
      -- изменение параметров договора
      if l_msg is null and p_req.card_type <> l_card_code then

        -- меняем тип карточного счета
        if l_old_tip <> l_new_tip then
          -- меняем тип карточного счета
          update accounts set tip = l_new_tip where acc = l_acc;
          
          l_trmask.a_w4_acc := 'ACC_PK';
          l_trmask.nbs := substr(account_utl.read_account(l_acc).nls,1,4);

          -- specparams:
          bars_ow.set_sparam('1', l_acc, l_trmask);          

        end if;

        -- меняем ОБ22 карточного счета
        if l_old_ob22 <> l_new_ob22 then
          accreg.setaccountsparam(l_acc, 'OB22', l_new_ob22);
        end if;

        -- если поменялся срок (краткосрочн./долгосрочн.), открываем новый счет, переносим остатки
        l_ovr_new_acc := l_acc_ovr;
        if l_old_tip <> l_new_tip and l_acc_ovr is not null then
          begin
            select nbs, dazs, nls, substr(nms, 1, 38)
              into l_ovr_old_nbs, l_ovr_old_dazs, l_ovr_old_nls,
                   l_ovr_old_nms
              from accounts
             where acc = l_acc_ovr;
            -- кредитный счет закрыт, отвяжем его от договора
            if l_ovr_old_dazs is not null then
              l_ovr_new_acc := null;
            else
              -- новый долгоср. 2203
               if newnbs.g_state = 1 then
                  begin
                    select t.ob_ovr
                      into l_ovr_new_ob22
                      from w4_nbs_ob22 t
                     where t.nbs = l_new_nbs
                       and t.ob22 = l_new_ob22
                       and t.tip = l_new_tip;
                   exception when no_data_found then
                      l_ovr_new_ob22 := null;
                   end;
                  -- новый долгоср. 2203
                  if l_old_tip = 'W4C' and l_ovr_new_ob22 <> l_ovr_old_ob22 then
                     l_ovr_new_nbs := case when l_ovr_old_nbs = '2203' then '2203' else '2063' end;
                  -- новый краткоср. 2203
                  elsif l_new_tip = 'W4C'  and l_ovr_new_ob22 <> l_ovr_old_ob22 then
                     l_ovr_new_nbs := case when l_ovr_old_nbs = '2203' then '2203' else '2063' end;
                  -- БС не меняется
                  else
                     l_ovr_new_nbs := null;
                  end if;
               else
                  -- новый долгоср. 2203
              if l_new_tip = 'W4B' and l_ovr_old_nbs in ('2202', '2062') then
                     l_ovr_new_nbs := case when l_ovr_old_nbs = '2202' then '2203' else '2063' end;
                -- новый краткоср. 2202
              elsif l_new_tip = 'W4C' and l_ovr_old_nbs in ('2203', '2063') then
                     l_ovr_new_nbs := case when l_ovr_old_nbs = '2203' then '2202' else '2062' end;
                -- БС не меняется
              else
                l_ovr_new_nbs := null;
              end if;

               end if;

              -- если БС меняется, открываем новый счет
              if l_ovr_new_nbs is not null then
                bars_ow.open_2203(l_acc,
                          l_acc_ovr,
                          l_ovr_old_nls,
                          l_ovr_old_nms,
                          l_ovr_new_nbs,
                          l_ovr_new_acc);
              end if;
            end if;
          exception
            when no_data_found then
              null;
          end;
        end if;

        -- меняем тип карты
        update w4_acc
           set card_code = p_req.card_type,
               acc_ovr   = l_ovr_new_acc
         where nd = l_nd;

        -- спецпараметры по счетам договора
        if l_old_ob22 <> l_new_ob22 or l_old_tip <> l_new_tip then
           for x in ( select substr(w.name,5) name, w.acc, a.tip, a.nbs
                      from v_w4_nd_acc w, accounts a
                     where w.nd = l_nd
                          -- для acc_pk и acc_ovr уже все поменяли
                         and w.name not in ('ACC_PK', 'ACC_OVR')
                         and w.acc = a.acc
                         and a.dazs is null )
          loop
             begin
               select * into l_trmask from ow_transnlsmask t where t.nbs = x.nbs and t.tip = x.tip and rownum = 1;
             exception
               when no_data_found then
                 l_trmask := null;
             end;
            -- меняем спецпараметры
              bars_ow.set_sparam('0', x.acc, l_trmask);
          end loop;
        end if;

        -- обновление %% ставок по счетам договра
        bars_ow.set_accounts_rate(l_nd);

      end if;
      bars_audit.info(h || 'Finish.');
    end if;
    if l_msg is null and p_req.eng_first is not null and p_req.eng_last is not null then
      accreg.setAccountwParam(l_acc, 'W4_EFN',  p_req.eng_first);
      accreg.setAccountwParam(l_acc, 'W4_ELN',  p_req.eng_last);
    end if;
    p_req.msg := l_msg;
    bars_audit.trace(h || 'Finish.');
  end;

  procedure set_req_state(p_req in ow_utl.t_rec) is
  begin
    update w4_acc_request t
       set t.status   = decode(p_req.msg, null, 1, 2),
           t.msg      = p_req.msg,
           t.lastedit = sysdate
     where t.id = p_req.id;
  end;

  procedure request_procesing(p_ext_file_id in varchar2) is

    h     varchar2(100) := 'ow_utl.request_procesing. ';
    l_req ow_utl.t_rec;
  begin
    bars_audit.info(h || 'Start.');

    for i in (select t.*
                from w4_acc_request t
               where (t.ext_file_id = p_ext_file_id or p_ext_file_id is null) and
                     nvl(t.oper_date, bankdate) <= bankdate and t.status = 0)
    loop
      l_req.id              := i.id;
      l_req.ext_file_id     := i.ext_file_id;
      l_req.ext_id          := i.ext_id;
      l_req.oper_type       := i.oper_type;
      l_req.contract_number := i.contract_number;
      l_req.product_code    := i.product_code;
      l_req.card_type       := i.card_type;
      l_req.oper_date       := i.oper_date;
      l_req.okpo            := i.okpo;
      l_req.okpo_n          := i.okpo_n;
      l_req.card_expire     := i.card_expire;
      l_req.eng_first       := i.eng_firstname;
      l_req.eng_last        := i.eng_lastname;
      l_req.msg             := null;

      if l_req.oper_date is not null then
        if l_req.oper_type = 1 then
          close_deal(l_req);
          set_req_state(l_req);
        elsif l_req.oper_type = 2 then
          alter_deal(l_req);
          set_req_state(l_req);
        end if;
      else
        l_req.msg := 'Відстуня дата здійснення операції в АБС';
        set_req_state(l_req);
      end if;

    end loop;

    bars_audit.info(h || 'End.');
  end;

  function get_req_receipt(p_ext_file_id in varchar2) return clob is
    l_clob      clob;
    l_domdoc    dbms_xmldom.domdocument;
    l_root_node dbms_xmldom.domnode;

    l_supp_element dbms_xmldom.domelement;

    l_supp_node dbms_xmldom.domnode;

    l_supp_tnode dbms_xmldom.domnode;

    l_supp_text dbms_xmldom.domtext;

    l_supplier_element dbms_xmldom.domelement;
    l_supplier_node    dbms_xmldom.domnode;
    l_sup_node         dbms_xmldom.domnode;
    l_suppp_node       dbms_xmldom.domnode;

  begin

    dbms_lob.createtemporary(l_clob, true, 12);
    -- Create an empty XML document
    l_domdoc := dbms_xmldom.newdomdocument;

    -- Create a root node
    l_root_node := dbms_xmldom.makenode(l_domdoc);

    -- Create a new Supplier Node and add it to the root node
    l_sup_node   := dbms_xmldom.appendchild(l_root_node,
                                            dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
                                                                                           'root')));
    l_suppp_node := dbms_xmldom.appendchild(l_sup_node,
                                            dbms_xmldom.makenode(dbms_xmldom.createelement(l_domdoc,
                                                                                           'body')));

    for sup_rec in (select *
                      from w4_acc_request t
                     where t.ext_file_id = p_ext_file_id)
    loop

      -- For each record, create a new Supplier element
      -- and add this new Supplier element to the Supplier Parent node
      l_supplier_element := dbms_xmldom.createelement(l_domdoc, 'row');
      l_supplier_node    := dbms_xmldom.appendchild(l_suppp_node,
                                                    dbms_xmldom.makenode(l_supplier_element));

      -- Each Supplier node will get a Number node which contains the Supplier Number as text
      l_supp_element := dbms_xmldom.createelement(l_domdoc, 'ext_id');
      l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                dbms_xmldom.makenode(l_supp_element));
      l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, sup_rec.ext_id);
      l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                                dbms_xmldom.makenode(l_supp_text));

      l_supp_element := dbms_xmldom.createelement(l_domdoc, 'code');
      l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                dbms_xmldom.makenode(l_supp_element));
      l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, sup_rec.status);
      l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,

                                                dbms_xmldom.makenode(l_supp_text));
      if sup_rec.msg is not null then
        l_supp_element := dbms_xmldom.createelement(l_domdoc, 'msg');
        l_supp_node    := dbms_xmldom.appendchild(l_supplier_node,
                                                  dbms_xmldom.makenode(l_supp_element));
        l_supp_text    := dbms_xmldom.createtextnode(l_domdoc, sup_rec.msg);
        l_supp_tnode   := dbms_xmldom.appendchild(l_supp_node,
                                                  dbms_xmldom.makenode(l_supp_text));
      end if;
    end loop;

    dbms_xmldom.writetoclob(l_domdoc, l_clob);
    dbms_xmldom.freedocument(l_domdoc);
    return l_clob;
  exception
    when others then
      return l_clob;
  end;

  procedure acc_req_file_processing is
    l_blob         blob;
    l_clob         clob;
    l_warning      integer;
    l_dest_offset  integer;
    l_src_offset   integer;
    l_blob_csid    number := dbms_lob.default_csid;
    l_lang_context number := dbms_lob.default_lang_ctx;
    l_unit_type_id number := barstrans.transport_utl.get_unit_type_id('BPK_PKG_CHANGES');
    h              varchar2(100) := 'ow_files_utl.acc_req_file_processing. ';

  begin

    bars_audit.info(h || 'Start.');
    for c_req in (select t.id, t.external_file_id, t.request_data, t.kf
                    from barstrans.transport_unit t
                   where t.unit_type_id = l_unit_type_id and
                         t.state_id in
                         (barstrans.transport_utl.trans_state_new,
                          barstrans.transport_utl.trans_state_failed) and
                         t.failures_count < barstrans.transport_utl.marginal_tries_count
                   order by 1 desc)
    loop
      begin
        bc.go(c_req.kf);
        l_dest_offset := 1;
        l_src_offset  := 1;
        bars_audit.info(h || 'File(id=' || c_req.id || ') is processed');
        l_blob := utl_compress.lz_uncompress(c_req.request_data);
        dbms_lob.createtemporary(l_clob, false);
        dbms_lob.converttoclob(dest_lob     => l_clob,
                               src_blob     => l_blob,
                               amount       => dbms_lob.lobmaxsize,
                               dest_offset  => l_dest_offset,
                               src_offset   => l_src_offset,
                               blob_csid    => l_blob_csid,
                               lang_context => l_lang_context,
                               warning      => l_warning);

        bars_audit.info(h || 'File(id=' || c_req.id ||
                        ') converted to clob');

        parse_acc_req_file(c_req.id, l_clob);

        request_procesing(c_req.id);

        l_clob        := get_req_receipt(c_req.id);
        l_dest_offset := 1;
        l_src_offset  := 1;
        dbms_lob.createtemporary(l_blob, false);
        dbms_lob.converttoblob(dest_lob     => l_blob,
                               src_clob     => l_clob,
                               amount       => dbms_lob.lobmaxsize,
                               dest_offset  => l_dest_offset,
                               src_offset   => l_src_offset,
                               blob_csid    => l_blob_csid,
                               lang_context => l_lang_context,
                               warning      => l_warning);

        l_blob := utl_compress.lz_compress(l_blob);

        barstrans.transport_utl.save_response(p_id        => c_req.id,
                                              p_resp_data => l_blob);
        barstrans.transport_utl.set_transport_state(c_req.id,
                                                    barstrans.transport_utl.trans_state_done,
                                                    null,
                                                    null);
        dbms_lob.freetemporary(l_clob);
        dbms_lob.freetemporary(l_blob);
      exception
        when others then
          barstrans.transport_utl.set_transport_failure(p_id            => c_req.id,
                                                        p_error_message => sqlerrm,
                                                        p_stack_trace   => dbms_utility.format_error_stack() ||
                                                                           chr(10) ||
                                                                           dbms_utility.format_error_backtrace());
      end;
    end loop;
    --
    request_procesing(null);
    bars_audit.info(h || 'Finish.' || 'p_msg=>' || null);
  exception
    when others then
      bars_audit.info(h || 'Finish.' || 'p_msg=>' ||
                      dbms_utility.format_error_stack() || chr(10) ||
                      dbms_utility.format_error_backtrace());

  end;

end;
/
 show err;
 
PROMPT *** Create  grants  OW_UTL ***
grant EXECUTE                                                                on OW_UTL          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on OW_UTL          to BARS_ACCESS_USER;
grant EXECUTE                                                                on OW_UTL          to PUBLIC;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/ow_utl.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 