
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/ow_files_proc.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.OW_FILES_PROC is

  -- Author  : VITALII.KHOMIDA
  -- Created : 09.08.2017 14:10:37
  -- Purpose : Пакет для опрацювання файлів від ПЦ

  type t_file is record(id number,
                        file_name varchar2(100),
                        file_type varchar2(30),
                        status number,
                        type number,
                        offset number,
                        offsetexpire varchar2(8)
                        );
  type t_files is table of t_file;

  procedure load_file(p_filename in varchar2,
                      p_filebody in blob,
                      p_origin   in number,
                      p_id       out number,
                      p_msg      out varchar2);

  procedure files_processing(p_kf     in varchar2,
                             p_userid in number default 1);

  function get_file_list return t_files ;
  procedure parse_files(p_files out t_files);
  procedure parse_file(p_fileid in number);
  function lock_file (p_id in number) return boolean;
  procedure pay_file(p_fileid in number);
  type docs_buffers_rec is record
   (
      ref              oper.ref%type,
      doc_buffer_int   varchar2(32767),
      doc_buffer_ext   varchar2(32767)
  );
  type docs_buffers_set is table of docs_buffers_rec;

  function get_docs_buffers (p_key in varchar2)
   return docs_buffers_set
  pipelined;
  procedure put_doc_sign(p_ref      in integer,
                         p_key       in varchar2,
                         p_int_sign  in varchar2,
                         p_sep_sign  in varchar2);
end;
/
CREATE OR REPLACE PACKAGE BODY BARS.OW_FILES_PROC is

  g_modcode       constant varchar2(3) := 'BPK';
  g_filetype_atrn constant varchar2(30) := 'ATRANSFERS';
  g_filetype_ftrn constant varchar2(30) := 'FTRANSFERS';
  g_filetype_strn constant varchar2(30) := 'STRANSFERS'; -- not use
  g_filetype_doc  constant varchar2(30) := 'DOCUMENTS';
  g_filetype_rxa  constant varchar2(30) := 'RXADVAPL';
  g_filetype_riic constant varchar2(30) := 'R_IIC_DOCUMENTS';
  g_filetype_cng  constant varchar2(30) := 'CNGEXPORT';
  g_filetype_roic constant varchar2(30) := 'R_DOCUMENTS_REV';
  g_keytype       constant varchar2(30) := 'WAY_DOC';

  --types
  type t_cng is table of ow_cng_data%rowtype;
  type t_atrn is table of ow_oic_atransfers_data%rowtype;
  type t_strn is table of ow_oic_stransfers_data%rowtype;
  type t_doc is table of ow_oic_documents_data%rowtype;
  type t_salp is table of ow_salary_data%rowtype;
  type t_operw is table of operw%rowtype;
  type t_tr2924 is record ( branch v_w4_tr2924.branch%type,
                            nls    v_w4_tr2924.nls%type );
  type t_tr2924_tbl is table of t_tr2924;
  g_nls_trans t_tr2924_tbl;
  g_chkid       number;
  g_chkid_hex   varchar2(2);
  g_chkid2      number;
  g_chkid2_hex  varchar2(2);

  -- Код операции гашения КД с карточки
  g_tt_asg      varchar2(3);
  -- Код бранча для Way4
  g_w4_branch   varchar2(4);
  -- Количество счетов в файле IIC
  g_iicnum      number;
  -- Маршрут создания НК: 1-через CardMake, 0-через Way4
  g_w4_lc       number;
  -- 1=Проверять Дату выдачи карты при миграции PK
  g_check_idat  number;
  -- счет 3800 для ГОУ
  g_nls3800     varchar2(14);
  -- счет 9900 для ГОУ
  g_nls9900     varchar2(14);
  -- бранч, который передается в CM
  g_cm_branch   varchar2(30);



/*  type t_file is record(id number,
                        status number,
                        type number);
  type t_files is table of t_file;*/

  procedure init is
    h varchar2(100) := 'ow_files_proc.ow_init. ';
  begin

    g_chkid  := getglobaloption('BPK_CHK');
    g_chkid2 := getglobaloption('BPK_CHK2');
    if g_chkid is null then
       g_chkid := 30;
    end if;
    if g_chkid2 is null then
       g_chkid2 := 31;
    end if;
    g_chkid_hex  := lpad(chk.to_hex(g_chkid),2,'0');
    g_chkid2_hex := lpad(chk.to_hex(g_chkid2),2,'0');

    g_tt_asg := nvl(getglobaloption('ASG_FOR_BPK'), 'W4Y');

    select branch, nls
      bulk collect
      into g_nls_trans
      from v_w4_tr2924;

    begin
       select substr(val,1,4) into g_w4_branch from ow_params where par = 'W4_BRANCH';
    exception when no_data_found then
       g_w4_branch := '0000';
    end;

    begin
       select to_number(nvl(val,'1000')) into g_iicnum from ow_params where par = 'IICNUM';
    exception when others then
       g_iicnum := 1000;
    end;

    begin
       select to_number(nvl(val,'0')) into g_w4_lc from ow_params where par = 'W4_LC';
    exception when others then
       g_w4_lc := 0;
    end;

    begin
       select to_number(nvl(val,'0')) into g_check_idat from ow_params where par = 'CHECK_IDAT';
    exception when others then
       g_check_idat := 0;
    end;

    begin
       select val into g_nls3800 from ow_params where par = 'NLS_3800';
    exception when no_data_found then
       g_nls3800 := null;
    end;

    begin
       select val into g_nls9900 from params where par = 'NLS_9900';
    exception when no_data_found then
       g_nls9900 := null;
    end;
    bars_audit.trace(h || 'Params:' ||
       ' g_chkid=>' || to_char(g_chkid) ||
       ' g_chkid2=>' || to_char(g_chkid2) ||
       ' g_chkid_hex=>' || g_chkid_hex ||
       ' g_chkid2_hex=>' || g_chkid2_hex ||
       ' g_w4_branch=>' || g_w4_branch ||
       ' g_iicnum=>' || g_iicnum ||
       ' g_w4_lc=>' || g_w4_lc ||
       ' g_check_idat=>' || g_check_idat);

  end init;


  function get_file_state(p_fileid in number) return number is
    l_state ow_files.file_status%type;
  begin
    select t.file_status into l_state from ow_files t where t.id = p_fileid;
    return l_state;
  exception
    when no_data_found then
      return null;
  end;

  function get_file_type(p_filename in varchar2) return varchar2 is
    l_filename varchar2(100);
    l_filetype varchar2(100);
  begin

    l_filename := upper(p_filename);

    if instr(l_filename, 'CNGEXPORT') > 0 then
      l_filetype := g_filetype_cng;
    elsif instr(l_filename, 'OIC_ATRANSFERS') > 0 then
      l_filetype := g_filetype_atrn;
    elsif instr(l_filename, 'OIC_FTRANSFERS') > 0 then
      l_filetype := g_filetype_ftrn;
    elsif instr(l_filename, 'OIC_STRANSFERS') > 0 then
      l_filetype := g_filetype_strn;
    elsif instr(l_filename, 'R_OIC_DOCUMENTS') > 0 then
      l_filetype := g_filetype_roic;
    elsif instr(l_filename, 'OIC_DOCUMENTS') > 0 then
      l_filetype := g_filetype_doc;
    elsif instr(l_filename, 'RXADVAPL') > 0 then
      l_filetype := g_filetype_rxa;
    elsif instr(l_filename, 'R_IIC_DOCUMENTS') > 0 then
      l_filetype := g_filetype_riic;
    else
      l_filetype := null;
    end if;

    return l_filetype;

  end;
  procedure load_file(p_filename in varchar2,
                      p_filebody in blob,
                      p_origin   in number,
                      p_id       out number,
                      p_msg      out varchar2) is
    l_filename varchar2(100);
    l_filetype varchar2(100);
    l_id       number := null;
    i          number;
    h          varchar2(100) := 'ow_files_proc.load_file. ';
  begin

    bars_audit.info(h || 'Start. filename=' || p_filename);

    l_filename := upper(p_filename);

    -- определяем тип файла
    l_filetype := get_file_type(l_filename);
    bars_audit.info(h || 'l_filetype=>' || l_filetype);

    if l_filetype is null then
      p_msg := 'Невідомий тип файлу';
    else
      select count(*)
        into i
        from ow_files
       where substr(file_name, 1, instr(file_name, '.', -1) - 1) =
             substr(l_filename, 1, instr(l_filename, '.', -1) - 1);
      -- файл еще не принимался
      if i = 0 then
        begin
          select bars_sqnc.get_nextval('S_OWFILES') into l_id from dual;
          insert into ow_files
            (id, file_type, file_name, file_body, file_status, origin)
          values
            (l_id, l_filetype, l_filename, empty_blob(), 0, p_origin);
          update ow_files set file_body = p_filebody where id = l_id;
        exception
          when others then
            p_msg := sqlerrm;
        end;
      else
        p_msg := 'Файл вже імпортувався';
      end if;
    end if;

    p_id := l_id;

    bars_audit.info(h || 'Finish. filename' || p_filename || ' p_msg=>' ||
                    p_msg);

  end;
  -------------------------------------------------------------------------------
  -- EXTRACT()
  --
  --   безопаcно получает значение по XPath
  --
  --
  function extract(p_xml     in xmltype,
                   p_xpath   in varchar2,
                   p_default in varchar2) return varchar2 is
  begin
    return p_xml.extract(p_xpath).getStringVal();
  exception
    when others then
      if sqlcode = -30625 then
        return p_default;
      else
        raise;
      end if;
  end extract;

  procedure set_file_status(p_id     number,
                            p_nrow   number,
                            p_status number,
                            p_err    varchar2) is
  begin
    update ow_files
       set file_n = p_nrow, file_status = p_status, err_text = p_err
     where id = p_id;
  end set_file_status;

  procedure set_files_status(p_files t_files,
                             p_status number)
    is
    begin
      for i in 1 .. p_files.count loop
         set_file_status(p_files(i).id, null, p_status, null);
      end loop;
      commit;
    end;
  -------------------------------------------------------------------------------
  -- CONVERT_TO_NUMBER()
  --
  --   Конвертит строку в число  соответсвующим exept
  --
  --
  function convert_to_number(p_str varchar2) return number is
  begin
    return to_number(replace(replace(p_str,
                                     ',',
                                     substr(to_char(11 / 10), 2, 1)),
                             '.',
                             substr(to_char(11 / 10), 2, 1)));
  exception
    when others then
      raise_application_error(-20000, sqlerrm, true);
  end convert_to_number;

  -- процедура пакетной вставки коллекции
  procedure bulk_insert_doc(l_recs in t_doc) is
  begin
    forall j in l_recs.first .. l_recs.last
      insert into ow_oic_documents_data values l_recs (j);
  end;

  -------------------------------------------------------------------------------
  -- iparse_oic_atransfers_file
  -- процедура разбора файла OIC_ATransfers*.xml
  --
  procedure iparse_oic_atransfers_file(p_fileid    in number,
                                       p_filebody  in clob,
                                       p_file_name in varchar2) is

    l_parser       dbms_xmlparser.parser;
    l_doc          dbms_xmldom.domdocument;
    l_filetrailer  dbms_xmldom.DOMNodeList;
    l_trailer      dbms_xmldom.DOMNode;
    l_analyticlist dbms_xmldom.DOMNodeList;
    l_analytic     dbms_xmldom.DOMNode;
    l_rec          t_atrn := t_atrn();

    l_filetype   ow_files.file_type%type;
    l_file_n     number(6);
    l_file_summ  number(20, 2);
    l_idn        number;
    l_check_n    number;
    l_check_summ number(20, 2) := 0;
    l_status     number;
    l_err        varchar2(254);

    l_str varchar2(2000);

    h varchar2(100) := 'ow_files_proc.iparse_oic_atransfers_file. ';

    -- процедура пакетной вставки коллекции
    procedure bulk_insert(l_rec in t_atrn) is
    begin
      forall j in l_rec.first .. l_rec.last
        insert into ow_oic_atransfers_data values l_rec (j);
    end;

  begin

    bars_audit.info(h || 'Start. p_fileid=' || p_fileid || '(' || p_file_name || ')');

    -- тип файла (ATransfers/FTransfers)
    begin
      select file_type into l_filetype from ow_files where id = p_fileid;
    exception

      when no_data_found then
        bars_error.raise_nerror(g_modcode, 'FILE_NOT_FOUND');
    end;

    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, p_filebody);
    bars_audit.info(h || 'clob loaded p_fileid=' || p_fileid || '(' || p_file_name || ')');

    l_doc := dbms_xmlparser.getdocument(l_parser);
    bars_audit.info(h || 'getdocument done p_fileid=' || p_fileid || '(' || p_file_name || ')');

    l_filetrailer := dbms_xmldom.getelementsbytagname(l_doc, 'FileTrailer');
    l_trailer     := dbms_xmldom.item(l_filetrailer, 0);

    dbms_xslprocessor.valueof(l_trailer, 'CheckSum/RecsCount/text()', l_str);
    l_file_n := convert_to_number(l_str);

    dbms_xslprocessor.valueof(l_trailer, 'CheckSum/HashTotalAmount/text()', l_str);
    l_file_summ := convert_to_number(l_str);

    l_analyticlist := dbms_xmldom.getelementsbytagname(l_doc, 'Analytic');
    bars_audit.info(h || 'getelementsbytagname done p_fileid=' || p_fileid || '(' || p_file_name || ')');

    for i in 0 .. dbms_xmldom.getlength(l_analyticlist) - 1 loop

      -- счетчик транзакций
      l_idn := i + 1;

      l_analytic := dbms_xmldom.item(l_analyticlist, i);

      l_rec.extend;

      l_rec(l_rec.last).id := p_fileid;
      l_rec(l_rec.last).idn := l_idn;

      dbms_xslprocessor.valueof(l_analytic, 'SynthRefN/text()', l_str);
      l_rec(l_rec.last).anl_synthrefn := trim(l_str);

      dbms_xslprocessor.valueof(l_analytic, 'SynthCode/text()', l_str);
      l_rec(l_rec.last).anl_synthcode := trim(l_str);

      dbms_xslprocessor.valueof(l_analytic, 'TransferDescription/text()', l_str);
      l_rec(l_rec.last).anl_trndescr := trim(convert(dbms_xmlgen.convert(l_str, 1), 'CL8MSWIN1251', 'UTF8'));

      dbms_xslprocessor.valueof(l_analytic, 'AnalyticRefN/text()', l_str);
      l_rec(l_rec.last).anl_analyticrefn := trim(l_str);

      dbms_xslprocessor.valueof(l_analytic, 'Credit/AnalyticAccount/AccountNumber/text()', l_str);
      l_rec(l_rec.last).credit_anlaccount := trim(l_str);

      dbms_xslprocessor.valueof(l_analytic, 'Credit/SyntAccount/AccountNumber/text()', l_str);
      l_rec(l_rec.last).credit_syntaccount := trim(l_str);

      dbms_xslprocessor.valueof(l_analytic, 'Credit/Amount/text()', l_str);
      l_rec(l_rec.last).credit_amount := convert_to_number(l_str);

      dbms_xslprocessor.valueof(l_analytic, 'Credit/Currency/text()', l_str);
      l_rec(l_rec.last).credit_currency := trim(l_str);

      dbms_xslprocessor.valueof(l_analytic, 'Debit/AnalyticAccount/AccountNumber/text()', l_str);
      l_rec(l_rec.last).debit_anlaccount := trim(l_str);

      dbms_xslprocessor.valueof(l_analytic, 'Debit/SyntAccount/AccountNumber/text()', l_str);
      l_rec(l_rec.last).debit_syntaccount := trim(l_str);

      dbms_xslprocessor.valueof(l_analytic, 'Debit/Amount/text()', l_str);
      l_rec(l_rec.last).debit_amount := convert_to_number(l_str);

      dbms_xslprocessor.valueof(l_analytic, 'Debit/Currency/text()', l_str);
      l_rec(l_rec.last).debit_currency := trim(l_str);

      dbms_xslprocessor.valueof(l_analytic, 'PostingDate/text()', l_str);
      l_rec(l_rec.last).anl_postingdate := to_date(l_str, 'yyyy-mm-dd');

      dbms_xslprocessor.valueof(l_analytic, 'DocInfo/LocalDt/text()', l_str);
      l_rec(l_rec.last).doc_localdate := to_date(l_str, 'yyyy-mm-dd');

      dbms_xslprocessor.valueof(l_analytic, 'DocInfo/Description/text()', l_str);
      l_rec(l_rec.last).doc_descr := substr(trim(convert(dbms_xmlgen.convert(l_str, 1), 'CL8MSWIN1251', 'UTF8')), 1, 160);

      dbms_xslprocessor.valueof(l_analytic, 'DocInfo/AmountData/Amount/text()', l_str);
      l_rec(l_rec.last).doc_amount := convert_to_number(l_str);

      dbms_xslprocessor.valueof(l_analytic, 'DocInfo/AmountData/Currency/text()', l_str);
      l_rec(l_rec.last).doc_currency := trim(l_str);

      if l_filetype = g_filetype_atrn then

        dbms_xslprocessor.valueof(l_analytic, 'DocInfo/DocRefSet/Parm[ParmCode="DRN"]/Value/text()', l_str);
        l_rec(l_rec.last).doc_drn := convert_to_number(l_str);

        dbms_xslprocessor.valueof(l_analytic, 'Extra/AddData/Parm[ParmCode="OperationRN"]/Value/text()', l_str);
        l_rec(l_rec.last).doc_orn := convert_to_number(l_str);

        dbms_xslprocessor.valueof(l_analytic, 'DocInfo/AmountData/Extra/AddData/Parm[ParmCode="TRANS_INFO"]/Value/text()', l_str);
        l_rec(l_rec.last).trans_info := trim(convert(dbms_xmlgen.convert(l_str,1), 'CL8MSWIN1251', 'UTF8'));

      else

        dbms_xslprocessor.valueof(l_analytic, 'DocInfo/DocRefSet/Parm[ParmCode="2924*016"]/Value/text()',l_str);
        l_rec(l_rec.last).account_2924_016 := substr(trim(l_str), 1, 14);

      end if;
      l_rec(l_rec.last).kf := sys_context('bars_context', 'user_mfo');
      l_check_summ := l_check_summ + l_rec(l_rec.last).debit_amount + l_rec(l_rec.last)
                     .credit_amount;

      -- пакетная вставка каждых 10к
      if mod(l_idn, 10000) = 0 then
        bulk_insert(l_rec);
        l_rec.delete;
      end if;

    end loop;

    -- оставшиеся записи
    bulk_insert(l_rec);

    bars_audit.info(h || 'load done p_fileid=' || p_fileid || '(' ||
                    p_file_name || ')');

    --free (не забыть делать очистку в случае ошибок)
    l_rec.delete();
    l_rec := null;
    dbms_xmlparser.freeparser(l_parser);
    DBMS_XMLDOM.freeDocument(l_doc);

    l_check_n := l_idn;

    bars_audit.info(h || 'p_fileid=' || p_fileid || '(' || p_file_name || ')' || ' ' ||
                    to_char(l_idn) || ' rows parsed:' || ' l_check_n=>' ||
                    to_char(l_check_n) || ' l_file_n=>' ||
                    to_char(l_file_n) || ' l_check_summ=>' ||
                    to_char(l_check_summ) || ' l_file_summ=>' ||
                    to_char(l_file_summ));

    if l_check_n <> l_file_n or l_check_summ <> l_file_summ then
      l_file_n := 0;
      l_status := 3;
      l_err    := 'Не співпадають контрольні суми';
      delete from ow_oic_atransfers_data where id = p_fileid;
    else
      l_status := 1;
      l_err    := null;
    end if;
    set_file_status(p_fileid, l_file_n, l_status, l_err);

    bars_audit.info(h || 'Finish.p_fileid=' || p_fileid || '(' ||
                    p_file_name || ')');

  end;

  -------------------------------------------------------------------------------
  -- iparse_oic_doc
  -- процедура разбора файла OIC_Documents*.xml
  --
  procedure iparse_oic_doc(p_fileid    in number,
                           p_filebody  in clob,
                           p_file_name in varchar2) is

    l_parser      dbms_xmlparser.parser;
    l_doc         dbms_xmldom.domdocument;
    l_extralist   dbms_xmldom.DOMNodeList;
    l_extra       dbms_xmldom.DOMNode;
    l_doclist     dbms_xmldom.DOMNodeList;
    l_doc_item    dbms_xmldom.DOMNode;
    l_filetrailer dbms_xmldom.DOMNodeList;
    l_trailer     dbms_xmldom.DOMNode;

    l_filebody xmltype;

    l_file_n     number(6);
    l_file_summ  number(20, 2);
    l_check_n    number;
    l_check_summ number(20, 2) := 0;
    l_status     number;
    l_err        varchar2(254);

    l_rec  ow_oic_documents_data%rowtype;
    l_recs t_doc := t_doc();
    i      number;
    j      number;
    l_tmp  varchar2(2000);

    c_file   varchar2(48) := '/DocFile/FileTrailer/CheckSum/';
    c_data   varchar2(53) := '/DocFile/DocList/';
    c_doc    varchar2(254);
    c_parm   varchar2(254);
    l_xml    xmltype;
    l_socmnt varchar2(254);
    l_dtls1  varchar2(254);
    l_dtls2  varchar2(254);
    h        varchar2(100) := 'ow_files_proc.iparse_oic_doc. ';

  begin

    bars_audit.info(h || 'Start.p_fileid=' || p_fileid || '(' ||
                    p_file_name || ')');

    l_parser := dbms_xmlparser.newparser;

    dbms_xmlparser.parseclob(l_parser, p_filebody);


    bars_audit.info(h || 'clob loaded p_fileid=' || p_fileid || '(' || p_file_name || ')');

    l_doc := dbms_xmlparser.getdocument(l_parser);

    l_filetrailer := dbms_xmldom.getelementsbytagname(l_doc, 'FileTrailer');
    l_trailer     := dbms_xmldom.item(l_filetrailer, 0);

    l_file_n    := convert_to_number(dbms_xslprocessor.valueof(l_trailer, 'CheckSum/RecsCount/text()'));
    l_file_summ := convert_to_number(dbms_xslprocessor.valueof(l_trailer, 'CheckSum/HashTotalAmount/text()'));

    l_doclist := dbms_xmldom.getelementsbytagname(l_doc, 'Doc');

    l_check_n := dbms_xmldom.getlength(l_doclist);
    for i in 0 .. l_check_n - 1 loop

      l_doc_item := dbms_xmldom.item(l_doclist, i);

      l_recs.extend;
      l_recs(l_recs.last).id := p_fileid;
      l_recs(l_recs.last).idn := i + 1;
      l_recs(l_recs.last).doc_localdate := to_date(dbms_xslprocessor.valueof(l_doc_item, 'LocalDt/text()'), 'yyyy-mm-dd hh24:mi:ss');
      l_recs(l_recs.last).doc_descr := substr(trim(dbms_xslprocessor.valueof(l_doc_item, 'Description/text()')), 1, 254);
      l_recs(l_recs.last).cnt_contractnumber := substr(dbms_xslprocessor.valueof(l_doc_item, 'ContractFor/ContractNumber/text()'), 1, 100);
      l_recs(l_recs.last).cnt_clientregnumber := substr(dbms_xslprocessor.valueof(l_doc_item, 'ContractFor/Client/ClientInfo/RegNumber/text()'), 1, 10);
      l_recs(l_recs.last).cnt_clientname := substr(trim(dbms_xslprocessor.valueof(l_doc_item, 'ContractFor/Client/ClientInfo/CompanyName/text()')), 1, 38);
      l_recs(l_recs.last).org_cbsnumber := substr(dbms_xslprocessor.valueof(l_doc_item, 'Originator/CBSNumber/text()'), 1, 100);
      l_recs(l_recs.last).dest_institution := substr(dbms_xslprocessor.valueof(l_doc_item, 'Destination/InstInfo/Institution/text()'), 4, 6);
      l_recs(l_recs.last).bill_phasedate := to_date(dbms_xslprocessor.valueof(l_doc_item, 'Billing/PhaseDate/text()'), 'yyyy-mm-dd');
      l_recs(l_recs.last).bill_amount := convert_to_number(dbms_xslprocessor.valueof(l_doc_item, 'Billing/Amount/text()'));
      l_recs(l_recs.last).bill_currency := convert_to_number(dbms_xslprocessor.valueof(l_doc_item, 'Billing/Currency/text()'));

      l_recs(l_recs.last).doc_drn := dbms_xslprocessor.valueof(l_doc_item, 'DocRefSet/Parm[ParmCode="DRN"]/Value/text()');

      l_socmnt := substr(trim(dbms_xslprocessor.valueof(l_doc_item, 'ContractFor/AddData/Parm[ParmCode="SO_CMNT"]/Value/text()')), 1, 254);
      l_dtls1  := substr(trim(dbms_xslprocessor.valueof(l_doc_item, 'ContractFor/AddData/Parm[ParmCode="SO_DTLS1"]/Value/text()')), 1, 254);
      l_dtls2  := substr(trim(dbms_xslprocessor.valueof(l_doc_item, 'ContractFor/AddData/Parm[ParmCode="SO_DTLS2"]/Value/text()')), 1, 254);

      l_recs(l_recs.last).doc_socmnt := substr(nvl(trim(l_dtls1 || ' ' || l_dtls2), l_socmnt), 1, 254);

      l_recs(l_recs.last).doc_trdetails := null;

      if dbms_xslprocessor.valueof(l_doc_item, 'Transaction/Extra/AddData/Parm[ParmCode="TR_DETAILS"]/Value/text()') is not null then
        l_recs(l_recs.last).doc_trdetails := substr(trim(dbms_xslprocessor.valueof(l_doc_item, 'Transaction/Extra/AddData/Parm[ParmCode="TR_DETAILS"]/Value/text()')), 1, 254);
      end if;
      if dbms_xslprocessor.valueof(l_doc_item, 'Transaction/Extra/AddData/Parm[ParmCode="TR_PREFIX"]/text()') is not null then
        l_recs(l_recs.last).doc_socmnt := nvl(substr(trim(dbms_xslprocessor.valueof(l_doc_item, 'Transaction/Extra/AddData/Parm[ParmCode="TR_PREFIX"]/Value/text()')), 1, 254),'') || l_recs(l_recs.last).cnt_clientname || '/Відшкодування за дату ' || l_recs(l_recs.last).doc_trdetails;
      end if;

      l_recs(l_recs.last).kf := sys_context('bars_context', 'user_mfo');
      l_check_summ := l_check_summ + l_recs(l_recs.last).bill_amount;

      if mod(l_recs(l_recs.last).id, 1000) = 0 then
        bulk_insert_doc(l_recs);
        l_recs.delete;
      end if;
    end loop;

    bulk_insert_doc(l_recs);

    bars_audit.info(h || 'p_fileid=' || p_fileid || '(' || p_file_name || ') ' ||
                    to_char(i) || ' rows parsed:' || ' l_check_n=>' ||
                    to_char(l_check_n) || ' l_file_n=>' ||
                    to_char(l_file_n) || ' l_check_summ=>' ||
                    to_char(l_check_summ) || ' l_file_summ=>' ||
                    to_char(l_file_summ));

    if l_check_n <> l_file_n or l_check_summ <> l_file_summ then
      l_file_n := 0;
      l_status := 3;
      l_err    := 'Не співпадають контрольні суми';
      delete from ow_oic_documents_data where id = p_fileid;
    else
      l_status := 1;
      l_err    := null;
    end if;
    set_file_status(p_fileid, l_file_n, l_status, l_err);

    bars_audit.info(h || 'Finish.p_fileid=' || p_fileid || '(' ||
                    p_file_name || ')');

  end iparse_oic_doc;

  -------------------------------------------------------------------------------
  -- iparse_oic_docl
  -- процедура разбора файла OIC_Documents*LOCPAY*.xml
  --
  procedure iparse_oic_docl(p_fileid    in number,
                            p_filebody  in clob,
                            p_file_name in varchar2) is

    l_parser      dbms_xmlparser.parser;
    l_doc         dbms_xmldom.domdocument;
    l_extralist   dbms_xmldom.DOMNodeList;
    l_extra       dbms_xmldom.DOMNode;
    l_doclist     dbms_xmldom.DOMNodeList;
    l_doc_item    dbms_xmldom.DOMNode;
    l_filetrailer dbms_xmldom.DOMNodeList;
    l_trailer     dbms_xmldom.DOMNode;
    l_file_n      number(6);
    l_file_summ   number(20, 2);
    l_check_n     number;
    l_check_summ  number(20, 2) := 0;
    l_status      number;
    l_err         varchar2(254);
    l_recs        t_doc := t_doc();
    l_recamount   number;
    l_extraamount number;
    l_transamount number;
    l_sign        varchar2(2000);
    l_signf       varchar2(2000);
    l_key         varchar2(1000) := crypto_utl.get_key_value(gl.bDATE,
                                                             g_keytype);
    l_key_p       varchar2(1000);
    l_nwdate      date;
    l_clob        clob;
    l_dcntnb      varchar2(100);
    h             varchar2(100) := 'ow_files_proc.iparse_oic_docl. ';
  begin

    if l_key is null then
      raise_application_error(-20000,
                              'Не задано ключ по платежам на вільні реквізити.');
    end if;

    bars_audit.info(h || 'Start.p_fileid=' || p_fileid || '(' ||
                    p_file_name || ')');

    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, p_filebody);
    bars_audit.info(h || 'clob loaded p_fileid=' || p_fileid || '(' ||
                    p_file_name || ')');

    l_doc := dbms_xmlparser.getdocument(l_parser);

    l_filetrailer := dbms_xmldom.getelementsbytagname(l_doc, 'FileTrailer');
    l_trailer     := dbms_xmldom.item(l_filetrailer, 0);

    l_file_n    := convert_to_number(dbms_xslprocessor.valueof(l_trailer, 'CheckSum/RecsCount/text()'));
    l_file_summ := convert_to_number(dbms_xslprocessor.valueof(l_trailer, 'CheckSum/HashTotalAmount/text()'));

    l_doclist := dbms_xmldom.getelementsbytagname(l_doc, 'Doc');

    l_check_n := dbms_xmldom.getlength(l_doclist);
    for i in 0 .. l_check_n - 1 loop

      dbms_lob.createtemporary(l_clob, false);
      l_doc_item := dbms_xmldom.item(l_doclist, i);

      l_recs.extend;
      l_recs(l_recs.last).id := p_fileid;
      l_recs(l_recs.last).idn := i + 1;
      l_recs(l_recs.last).work_flag := 0;

      l_recs(l_recs.last).doc_localdate := to_date(dbms_xslprocessor.valueof(l_doc_item, 'LocalDt/text()'), 'yyyy-mm-dd hh24:mi:ss');
      l_nwdate := to_date(dbms_xslprocessor.valueof(l_doc_item, 'NWDt/text()'), 'yyyy-mm-dd hh24:mi:ss');
      l_recs(l_recs.last).cnt_contractnumber := substr(dbms_xslprocessor.valueof(l_doc_item, 'Destination/ContractNumber/text()'), 1, 100);
      l_dcntnb := substr(dbms_xslprocessor.valueof(l_doc_item, 'Originator/ContractNumber/text()'), 1, 100);
      l_recs(l_recs.last).cnt_clientregnumber := substr(dbms_xslprocessor.valueof(l_doc_item, 'Destination/Client/ClientInfo/TaxpayerIdentifier/text()'), 1, 10);
      l_recs(l_recs.last).cnt_clientname := substr(trim(convert(dbms_xslprocessor.valueof(l_doc_item, 'Destination/Client/ClientInfo/ShortName/text()'), 'CL8MSWIN1251', 'UTF8')), 1, 38);
      -- Серию и номер паспорта для СЄП Запишем в tr_details
      l_recs(l_recs.last).doc_trdetails := substr(trim(convert(dbms_xslprocessor.valueof(l_doc_item, 'Destination/Client/ClientInfo/RegNumber/text()'), 'CL8MSWIN1251', 'UTF8')), 1, 38);
      l_recs(l_recs.last).org_cbsnumber := substr(dbms_xslprocessor.valueof(l_doc_item, 'Originator/RBSNumber/text()'), 1, 100);
      l_recs(l_recs.last).dest_institution := substr(dbms_xslprocessor.valueof(l_doc_item, 'Destination/InstInfo/Institution/text()'), 1, 6);
      l_recs(l_recs.last).bill_phasedate := to_date(dbms_xslprocessor.valueof(l_doc_item, 'Billing/PhaseDate/text()'), 'yyyy-mm-dd');
      l_recs(l_recs.last).bill_amount := convert_to_number(dbms_xslprocessor.valueof(l_doc_item, 'Billing/Amount/text()'));
      l_recs(l_recs.last).bill_currency := convert_to_number(dbms_xslprocessor.valueof(l_doc_item, 'Billing/Currency/text()'));
      l_recamount := convert_to_number(nvl(dbms_xslprocessor.valueof(l_doc_item, 'Reconciliation/Amount/text()'), '0'));
      l_transamount := convert_to_number(nvl(dbms_xslprocessor.valueof(l_doc_item, 'Transaction/Amount/text()'), '0'));

      l_recs(l_recs.last).doc_drn := dbms_xslprocessor.valueof(l_doc_item, 'DocRefSet/Parm[ParmCode="DRN"]/Value/text()');
      l_recs(l_recs.last).doc_rrn := dbms_xslprocessor.valueof(l_doc_item, 'DocRefSet/Parm[ParmCode="RRN"]/Value/text()');

      l_extralist := dbms_xslprocessor.selectNodes(l_doc_item, 'Transaction/Extra');

      l_signf       := null;
      l_extraamount := 0;
      for c_extr in 0 .. dbms_xmldom.getlength(l_extralist) - 1 loop

        l_extra := dbms_xmldom.item(l_extralist, c_extr);

        if dbms_xslprocessor.valueof(l_extra, 'Type/text()') = 'AddInfo' then
          l_recs(l_recs.last).doc_socmnt := replace(replace(substr(convert(trim(dbms_xslprocessor.valueof(l_extra, 'AddData/Parm[ParmCode="DTL"]/Value/text()')), 'CL8MSWIN1251', 'UTF8'), 1, 254), '%SEMICOLON%', ';'),'%EQUALS%', '=');
          l_signf := dbms_xslprocessor.valueof(l_extra, 'AddData/Parm[ParmCode="CNTRL_INF"]/Value/text()');
        end if;

        l_extraamount := l_extraamount + abs(nvl(convert_to_number(dbms_xslprocessor.valueof(l_extra, 'Amount/text()')), 0));

      end loop;

      if trim(l_recs(l_recs.last).doc_socmnt) is null or
         length(l_recs(l_recs.last).doc_socmnt) < 2 then
        l_recs(l_recs.last).doc_socmnt := replace(replace(convert(substr(trim(dbms_xslprocessor.valueof(l_extra, 'SourceDtls/MerchantName/text()')), 1, 254), 'CL8MSWIN1251', 'UTF8'), '%SEMICOLON%', ';'), '%EQUALS%', '=');
      end if;

      dbms_xmldom.writeToClob(l_doc_item, l_clob);
      l_recs(l_recs.last).doc_data := l_clob;
      l_sign := 'RRN' || to_char(l_recs(l_recs.last).doc_rrn) ||
                to_char(l_recs(l_recs.last).doc_localdate,
                        'yyyymmddhh24miss') ||
                to_char(l_nwdate, 'yyyymmddhh24miss') || l_dcntnb || l_recs(l_recs.last)
               .cnt_contractnumber || l_recs(l_recs.last).dest_institution ||
                to_char(l_recs(l_recs.last).bill_currency) ||
                to_char(l_recs(l_recs.last).bill_amount);
      if crypto_utl.check_mac_sh1(l_sign, l_key, l_signf, 'utf8') then
        l_recs(l_recs.last).is_sign_ok := 'Y';
      else
        if l_recs(l_recs.last).bill_phasedate < gl.bDATE then
          l_key_p := crypto_utl.get_key_value(l_recs(l_recs.last)
                                              .bill_phasedate,
                                              g_keytype,
                                              true);
          if l_key_p is not null then
            if crypto_utl.check_mac_sh1(l_sign, l_key_p, l_signf, 'utf8') then
              l_recs(l_recs.last).is_sign_ok := 'Y';
            else
              l_recs(l_recs.last).is_sign_ok := 'N';
            end if;
          else
            l_recs(l_recs.last).is_sign_ok := 'N';
          end if;
        else
          l_recs(l_recs.last).is_sign_ok := 'N';
        end if;
      end if;

      l_recs(l_recs.last).kf := sys_context('bars_context', 'user_mfo');
      l_check_summ := l_check_summ + abs(l_recs(l_recs.last).bill_amount) +
                      abs(l_recamount) + abs(l_transamount) + l_extraamount;
      l_clob := null;

      if mod(l_recs(l_recs.last).idn, 1000) = 0 then
        bulk_insert_doc(l_recs);
        l_recs.delete;
      end if;
    end loop;

    bulk_insert_doc(l_recs);

    dbms_xmlparser.freeparser(l_parser);
    dbms_xmldom.freedocument(l_doc);

    bars_audit.info(h || 'p_fileid=' || p_fileid || '(' || p_file_name || ')' || ' ' ||
                    to_char(l_check_n) || ' rows parsed:' ||
                    ' l_check_n=>' || to_char(l_check_n) || ' l_file_n=>' ||
                    to_char(l_file_n) || ' l_check_summ=>' ||
                    to_char(l_check_summ) || ' l_file_summ=>' ||
                    to_char(l_file_summ));

    if l_check_n <> l_file_n or l_check_summ <> l_file_summ then
      l_file_n := 0;
      l_status := 3;
      l_err    := 'Не співпадають контрольні суми';
      delete from ow_oic_documents_data where id = p_fileid;
    else
      l_status := 1;
      l_err    := null;
    end if;
    set_file_status(p_fileid, l_file_n, l_status, l_err);

    bars_audit.info(h || 'Finish.p_fileid=' || p_fileid || '(' ||
                    p_file_name || ')');
  end;
  -------------------------------------------------------------------------------
  -- iparse_oic_docf
  -- процедура разбора файла OIC_Documents*FINES*.xml
  --
  procedure iparse_oic_docf(p_fileid    in number,
                            p_filebody  in clob,
                            p_file_name in varchar2) is

    l_parser    dbms_xmlparser.parser;
    l_doc       dbms_xmldom.domdocument;
    l_batchlist dbms_xmldom.DOMNodeList;
    l_batch     dbms_xmldom.DOMNode;
    l_doclist   dbms_xmldom.DOMNodeList;
    l_doc_item  dbms_xmldom.DOMNode;
    l_element   dbms_xmldom.DOMElement;
    l_documents dbms_xmldom.DOMNodeList;
    l_document  dbms_xmldom.DOMNode;

    l_filetrailer dbms_xmldom.DOMNodeList;
    l_trailer     dbms_xmldom.DOMNode;

    l_file_n  number(6);
    l_check_n number := 0;
    l_status  number := 1;
    l_err     varchar2(254) := null;
    l_idn     number := 0;

    l_rec  ow_oic_documents_data%rowtype;
    l_recs t_doc := t_doc();

    h varchar2(100) := 'ow_files_proc.iparse_oic_docf. ';

  begin

    bars_audit.info(h || 'Start.p_fileid=' || p_fileid || '(' ||
                    p_file_name || ')');

    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, p_filebody);
    bars_audit.info(h || 'clob loaded p_fileid=' || p_fileid || '(' ||
                    p_file_name || ')');

    l_doc := dbms_xmlparser.getdocument(l_parser);

    l_filetrailer := dbms_xmldom.getelementsbytagname(l_doc, 'FileTrailer');
    l_trailer     := dbms_xmldom.item(l_filetrailer, 0);

    l_file_n := convert_to_number(dbms_xslprocessor.valueof(l_trailer,
                                                            'CheckSum/RecsCount/text()'));

    l_batchlist := dbms_xmldom.getelementsbytagname(l_doc, 'DocBatch');

    bars_audit.info(h || 'getdocument done p_fileid=' || p_fileid || '(' ||
                    p_file_name || ')');

    for i in 0 .. dbms_xmldom.getlength(l_batchlist) - 1 loop

      l_batch := dbms_xmldom.item(l_batchlist, i);

      l_rec.cnt_contractnumber := substr(dbms_xslprocessor.valueof(l_batch, 'BatchHeader/ContractFor/ContractNumber/text()'), 1, 100);

      l_rec.cnt_clientregnumber := substr(dbms_xslprocessor.valueof(l_batch, 'BatchHeader/ContractFor/Client/ClientInfo/RegNumber/text()'), 1, 10);

      l_rec.cnt_clientname := substr(trim(dbms_xslprocessor.valueof(l_batch, 'BatchHeader/ContractFor/Client/ClientInfo/CompanyName/text()')), 1, 38);

      l_rec.org_cbsnumber := substr(dbms_xslprocessor.valueof(l_batch, 'BatchHeader/Originator/CBSNumber/text()'), 1, 100);

      l_rec.dest_institution := substr(dbms_xslprocessor.valueof(l_batch, 'BatchHeader/Destination/InstInfo/Institution/text()'), 4, 6);

      l_element   := dbms_xmldom.makeElement(l_batch);
      l_documents := dbms_xmldom.getchildrenbytagname(l_element, 'DocList');
      l_document  := dbms_xmldom.item(l_documents, 0);
      l_doclist   := dbms_xmldom.getChildNodes(l_document);
      for n in 0 .. dbms_xmldom.getlength(l_doclist) - 1 loop

        -- счетчик транзакций
        l_idn      := l_idn + 1;
        l_doc_item := dbms_xmldom.item(l_doclist, n);

        l_recs.extend;

        l_recs(l_recs.last).id := p_fileid;
        l_recs(l_recs.last).idn := l_idn;
        l_recs(l_recs.last).cnt_contractnumber := l_rec.cnt_contractnumber;
        l_recs(l_recs.last).cnt_clientregnumber := l_rec.cnt_clientregnumber;
        l_recs(l_recs.last).cnt_clientname := l_rec.cnt_clientname;
        l_recs(l_recs.last).org_cbsnumber := l_rec.org_cbsnumber;
        l_recs(l_recs.last).dest_institution := l_rec.dest_institution;
        l_recs(l_recs.last).doc_localdate := to_date(dbms_xslprocessor.valueof(l_doc_item, 'LocalDt/text()'), 'yyyy-mm-dd hh24:mi:ss');
        l_recs(l_recs.last).bill_amount := convert_to_number(dbms_xslprocessor.valueof(l_doc_item, 'Transaction/Amount/text()'));
        l_recs(l_recs.last).bill_currency := convert_to_number(dbms_xslprocessor.valueof(l_doc_item, 'Transaction/Currency/text()'));
        l_recs(l_recs.last).msgcodes := dbms_xslprocessor.valueof(l_doc_item, 'TransType/TransCode/MsgCode/text()');
        l_recs(l_recs.last).postingstatus := dbms_xslprocessor.valueof(l_doc_item, 'Status/PostingStatus/text()');
        l_recs(l_recs.last).doc_descr := dbms_xslprocessor.valueof(l_doc_item, 'Transaction/Extra/AddData/Parm[ParmCode="FINE_INFO"]/Value/text()');
        l_recs(l_recs.last).repost_doc := dbms_xslprocessor.valueof(l_doc_item, 'Transaction/Extra/AddData/Parm[ParmCode="REPOST_DOC"]/Value/text()');
        l_recs(l_recs.last).kf := sys_context('bars_context', 'user_mfo');
        l_recs(l_recs.last).work_flag := 1;
        l_check_n := l_check_n + 1;

        -- пакетная вставка каждых 1к
        if mod(l_idn, 1000) = 0 then
          bulk_insert_doc(l_recs);
          l_recs.delete;
        end if;

      end loop;
      bulk_insert_doc(l_recs);
      l_recs.delete;
    end loop;

    if l_check_n <> l_file_n then
      l_file_n := 0;
      l_status := 3;
      l_err    := 'Не співпадають контрольні суми';
      delete from ow_oic_documents_data where id = p_fileid;
    else
      l_status := 1;
      l_err    := null;
    end if;

    dbms_xmlparser.freeparser(l_parser);
    DBMS_XMLDOM.freeDocument(l_doc);

    set_file_status(p_fileid, l_file_n, l_status, l_err);

    bars_audit.info(h || 'Finish.p_fileid=' || p_fileid || '(' ||
                    p_file_name || ')');

  end iparse_oic_docf;

  -- iparse_oic_docr
  -- процедура разбора файла OIC_Documents*FreeReqisites*.xml
  --
  procedure iparse_oic_docr(p_fileid    number,
                            p_filebody  clob,
                            p_file_name in varchar2) is

    l_parser        dbms_xmlparser.parser;
    l_doc           dbms_xmldom.domdocument;
    l_batchlist     dbms_xmldom.DOMNodeList;
    l_batch         dbms_xmldom.DOMNode;
    l_doclist       dbms_xmldom.DOMNodeList;
    l_doc_item      dbms_xmldom.DOMNode;
    l_element       dbms_xmldom.DOMElement;
    l_documents     dbms_xmldom.DOMNodeList;
    l_document      dbms_xmldom.DOMNode;
    l_trans         dbms_xmldom.DOMNodeList;
    l_element_doc   dbms_xmldom.DOMElement;
    l_extra         dbms_xmldom.DOMNode;
    l_tran          dbms_xmldom.DOMNode;
    l_translist     dbms_xmldom.DOMNodeList;
    l_element_extra dbms_xmldom.DOMElement;
    l_extraslist    dbms_xmldom.DOMNodeList;
    l_add_data      dbms_xmldom.DOMNode;
    l_parms         dbms_xmldom.DOMNodeList;
    l_parm          dbms_xmldom.DOMNode;
    l_docrefsetlist dbms_xmldom.DOMNodeList;
    l_docrefset     dbms_xmldom.DOMNode;
    l_parm_refs     dbms_xmldom.DOMNodeList;
    l_parm_ref      dbms_xmldom.DOMNode;

    h               varchar2(100) := 'ow_files_proc.iparse_oic_docr. '; --FreeReqisites
    q               number := 0;
    l_nwdt          date;
    l_dcntnb        varchar2(100);
    l_rec           ow_oic_documents_data%rowtype;
    l_rec_commision ow_oic_documents_data%rowtype;

    l_signf  varchar2(2000);
    l_signf1 varchar2(2000);
    l_sign   varchar2(2000);
    l_str    varchar2(4000);
    l_str_if varchar2(4000);
    l_key    varchar2(1000) := crypto_utl.get_key_value(gl.bDATE, g_keytype);
    l_key_p  varchar2(1000);

    l_fee_doc number;
    l_doc_pay number;

    l_total_doc_amount number;

  begin

    bars_audit.info(h || 'Start.p_fileid=' || p_fileid || '(' ||
                    p_file_name || ')');

    if l_key is null then
      raise_application_error(-20000,
                              'Не задано ключ по платежам на вільні реквізити.');
    end if;

    l_rec.work_flag           := 2;
    l_rec.id                  := p_fileid;
    l_rec.kf                  := sys_context('bars_context', 'user_mfo');
    l_rec_commision.work_flag := 2;
    l_rec_commision.id        := p_fileid;
    l_rec_commision.kf        := sys_context('bars_context', 'user_mfo');

    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, p_filebody);

    l_doc := dbms_xmlparser.getdocument(l_parser);

    l_batchlist := dbms_xmldom.getelementsbytagname(l_doc, 'DocBatch');

    for i in 0 .. dbms_xmldom.getlength(l_batchlist) - 1 loop

      l_batch := dbms_xmldom.item(l_batchlist, i);
      dbms_xslprocessor.valueof(l_batch, 'BatchHeader/Destination/InstInfo/Institution/text()', l_str);
      l_rec_commision.dest_institution := substr(l_str, 4, 6);
      dbms_xslprocessor.valueof(l_batch, 'BatchHeader/ContractFor/ContractNumber/text()',
                                l_str);
      l_rec_commision.cnt_contractnumber := substr(l_str, 1, 100);
      dbms_xslprocessor.valueof(l_batch, 'BatchHeader/ContractFor/Client/ClientInfo/RegNumber/text()', l_str);
      l_rec_commision.cnt_clientregnumber := substr(l_str, 1, 10);
      dbms_xslprocessor.valueof(l_batch, 'BatchHeader/ContractFor/Client/ClientInfo/CompanyName/text()', l_str);
      l_rec_commision.cnt_clientname := substr(trim(dbms_xmlgen.convert(l_str, 1)), 1, 38);
      dbms_xslprocessor.valueof(l_batch, 'BatchHeader/Originator/CBSNumber/text()', l_str);
      l_rec.org_cbsnumber           := substr(l_str, 1, 100);
      l_rec_commision.org_cbsnumber := substr(l_str, 1, 100);

      l_element   := dbms_xmldom.makeElement(l_batch);
      l_documents := dbms_xmldom.getchildrenbytagname(l_element, 'DocList');
      l_document  := dbms_xmldom.item(l_documents, 0);
      l_doclist   := dbms_xmldom.getChildNodes(l_document);

      if dbms_xmldom.getlength(l_doclist) = 0 then
        exit;
      end if;

      for n in 0 .. dbms_xmldom.getlength(l_doclist) - 1 loop
        l_fee_doc := 0;
        l_doc_pay := 0;

        l_rec.idn           := q + 1;
        q                   := q + 1;
        l_rec_commision.idn := q + 1;
        q                   := q + 1;

        l_doc_item := dbms_xmldom.item(l_doclist, n);
        dbms_xslprocessor.valueof(l_doc_item, 'LocalDt/text()', l_str);
        l_rec.doc_localdate           := to_date(l_str, 'yyyy-mm-dd hh24:mi:ss');
        l_rec_commision.doc_localdate := to_date(l_str, 'yyyy-mm-dd hh24:mi:ss');
        dbms_xslprocessor.valueof(l_doc_item, 'Status/PostingStatus/text()', l_str);
        l_rec.postingstatus           := l_str;
        l_rec_commision.postingstatus := l_str;
        dbms_xslprocessor.valueof(l_doc_item, 'Billing/PhaseDate/text()', l_str);
        l_rec.bill_phasedate           := to_date(l_str, 'yyyy-mm-dd');
        l_rec_commision.bill_phasedate := to_date(l_str, 'yyyy-mm-dd');
        dbms_xslprocessor.valueof(l_doc_item, 'NWDt/text()', l_str);
        l_nwdt := to_date(l_str, 'yyyy-mm-dd hh24:mi:ss');
        dbms_xslprocessor.valueof(l_doc_item, 'Originator/ContractNumber/text()', l_str);
        l_dcntnb := substr(l_str, 1, 100);
        dbms_xslprocessor.valueof(l_doc_item, 'Transaction/Currency/text()', l_str);
        l_rec.bill_currency           := convert_to_number(l_str);
        l_rec_commision.bill_currency := convert_to_number(l_str);
        dbms_xslprocessor.valueof(l_doc_item, 'Transaction/Amount/text()', l_str);
        l_total_doc_amount := convert_to_number(l_str);
        l_str              := null;

        l_element_doc := dbms_xmldom.makeElement(l_doc_item);

        l_docrefsetlist := dbms_xmldom.getchildrenbytagname(l_element_doc, 'DocRefSet');
        l_docrefset     := dbms_xmldom.item(l_docrefsetlist, 0);
        l_parm_refs     := dbms_xmldom.getChildNodes(l_docrefset);

        for o in 0 .. dbms_xmldom.getlength(l_parm_refs) - 1 loop
          l_parm_ref := dbms_xmldom.item(l_parm_refs, o);
          dbms_xslprocessor.valueof(l_parm_ref, 'ParmCode/text()', l_str_if);
          if l_str_if = 'RRN' then
            dbms_xslprocessor.valueof(l_parm_ref, 'Value/text()', l_str);
            l_rec.doc_rrn           := l_str;
            l_rec_commision.doc_rrn := l_str;

          end if;
        end loop;

        l_str := null;

        l_translist := dbms_xmldom.getchildrenbytagname(l_element_doc,
                                                        'Transaction');
        l_tran      := dbms_xmldom.item(l_translist, 0);
        l_trans     := dbms_xmldom.getChildNodes(l_tran);

        for m in 0 .. dbms_xmldom.getlength(l_trans) - 1 loop
          l_extra := dbms_xmldom.item(l_trans, m);
          if dbms_xmldom.getNodeName(l_extra) = 'Extra' then
            dbms_xslprocessor.valueof(l_extra, 'Type/text()', l_str);
            if l_str = 'AddInfo' then

              l_element_extra := dbms_xmldom.makeElement(l_extra);
              l_extraslist    := dbms_xmldom.getchildrenbytagname(l_element_extra, 'AddData');
              l_add_data      := dbms_xmldom.item(l_extraslist, 0);
              l_parms         := dbms_xmldom.getChildNodes(l_add_data);

              for b in 0 .. dbms_xmldom.getlength(l_parms) - 1 loop
                l_parm := dbms_xmldom.item(l_parms, b);
                dbms_xslprocessor.valueof(l_parm, 'ParmCode/text()', l_str_if);
                l_str := null;
                if l_str_if = 'OB_FEE' then
                  dbms_xslprocessor.valueof(l_parm, 'Value/text()', l_str);
                  l_rec_commision.bill_amount := convert_to_number(l_str);
                  if  nvl(l_rec_commision.bill_amount,0)=0
                     then
                          l_fee_doc:=0;
                  else
                          l_fee_doc:=1;
                  end if;
                elsif l_str_if = 'OB_CNTRL_INF' then
                  dbms_xslprocessor.valueof(l_parm, 'Value/text()', l_str);
                  l_signf   := l_str;
                  l_doc_pay := l_doc_pay + 1;
                elsif l_str_if = 'OB_TRANS_AMNT' then
                  dbms_xslprocessor.valueof(l_parm, 'Value/text()', l_str);
                  l_rec.bill_amount := convert_to_number(l_str);
                  l_doc_pay         := l_doc_pay + 1;
                elsif l_str_if = 'OB_RCPT_MFO' then
                  dbms_xslprocessor.valueof(l_parm, 'Value/text()', l_str);
                  l_rec.dest_institution := l_str;
                  l_doc_pay              := l_doc_pay + 1;
                elsif l_str_if = 'OB_RCPT_ACNT' then
                  dbms_xslprocessor.valueof(l_parm, 'Value/text()', l_str);
                  l_rec.cnt_contractnumber := substr(l_str, 1, 100);
                  l_doc_pay                := l_doc_pay + 1;
                elsif l_str_if = 'OB_RCPT_EGRPOU' then
                  dbms_xslprocessor.valueof(l_parm, 'Value/text()', l_str);
                  l_rec.cnt_clientregnumber := substr(l_str, 1, 10);
                  l_doc_pay                 := l_doc_pay + 1;
                elsif l_str_if = 'OB_RCPT_NAME' then
                  dbms_xslprocessor.valueof(l_parm, 'Value/text()', l_str);
                  l_rec.cnt_clientname := substr(trim(dbms_xmlgen.convert(l_str,
                                                                          1)),
                                                 1,
                                                 38);
                  l_doc_pay            := l_doc_pay + 1;
                elsif l_str_if = 'OB_PMNT_DTLS' then
                  dbms_xslprocessor.valueof(l_parm, 'Value/text()', l_str);
                  l_rec.doc_socmnt           := substr(trim(dbms_xmlgen.convert(l_str, 1)), 1, 254);
                  l_rec_commision.doc_socmnt := substr(trim(dbms_xmlgen.convert(l_str, 1)), 1, 254);
                  l_doc_pay                  := l_doc_pay + 1;
                elsif l_str_if = 'OB_REGNUMBER' then
                  dbms_xslprocessor.valueof(l_parm, 'Value/text()', l_str);
                  l_rec.doc_trdetails           := substr(trim(dbms_xmlgen.convert(l_str, 1)), 1, 38);
                  l_rec_commision.doc_trdetails := substr(trim(dbms_xmlgen.convert(l_str, 1)), 1, 38);
                  l_doc_pay                     := l_doc_pay + 1;
                end if;

              end loop;
            end if;
          end if;
        end loop;

        l_sign := 'RRN' || trim(to_char(l_rec.doc_rrn)) ||
                  to_char(l_rec.doc_localdate, 'yyyymmddhh24miss') ||
                  to_char(l_nwdt, 'yyyymmddhh24miss') || trim(l_dcntnb) ||
                  trim(l_rec.cnt_contractnumber) ||
                  trim(l_rec.dest_institution) ||
                  trim(to_char(l_rec.bill_currency)) ||
                  trim(to_char(l_rec.bill_amount, 9999999999990.99));
        if crypto_utl.check_mac_sh1(l_sign, l_key, l_signf) then
          l_rec.is_sign_ok           := 'Y';
          l_rec_commision.is_sign_ok := 'Y';

        else
          if l_rec.bill_phasedate < gl.bDATE then
            l_key_p := crypto_utl.get_key_value(l_rec.bill_phasedate,
                                                g_keytype,
                                                true);
            if l_key_p is not null then
              if crypto_utl.check_mac_sh1(l_sign, l_key_p, l_signf) then
                l_rec.is_sign_ok           := 'Y';
                l_rec_commision.is_sign_ok := 'Y';

              else
                l_rec.is_sign_ok           := 'N';
                l_rec_commision.is_sign_ok := 'N';

              end if;
            else
              l_rec.is_sign_ok           := 'N';
              l_rec_commision.is_sign_ok := 'N';
            end if;
          else
            l_rec.is_sign_ok           := 'N';
            l_rec_commision.is_sign_ok := 'N';
          end if;
        end if;

        if l_fee_doc = 0 then
          l_rec_commision.bill_amount := 0;
        end if;

        if l_total_doc_amount <>
           l_rec_commision.bill_amount + l_rec.bill_amount then
          l_rec_commision.doc_descr := 'Невідповідність загальної суми платежу';
          l_rec.doc_descr           := 'Невідповідність загальної суми платежу';
        else
          l_rec_commision.doc_descr := null;
          l_rec.doc_descr           := null;
        end if;

        if l_doc_pay = 8 and l_rec.postingstatus = 'Posted' then
          insert into ow_oic_documents_data values l_rec;
          if l_fee_doc = 1 and l_rec_commision.postingstatus = 'Posted' then
            insert into ow_oic_documents_data values l_rec_commision;
          else
            q := q - 1;
          end if;
        else
          q := q - 2;
        end if;

      end loop;
    end loop;

    dbms_xmlparser.freeparser(l_parser);
    DBMS_XMLDOM.freeDocument(l_doc);

    set_file_status(p_fileid, q, 1, null);

    bars_audit.info(h || 'Finish.p_fileid=' || p_fileid || '(' || p_file_name || ')');

  end;
  -------------------------------------------------------------------------------
  -- iparse_oic_documents_file
  -- процедура разбора файла OIC_Documents*.xml
  --
  procedure iparse_oic_documents_file(p_fileid    in number,
                                      p_filebody  in clob,
                                      p_file_name in varchar2) is

    l_filebody      xmltype;
    l_file_receiver varchar2(254);

  begin

    l_filebody := xmltype(p_filebody);

    l_file_receiver := substr(extract(l_filebody, '/DocFile/FileHeader/' || 'Receiver/text()', null), 1, 100);
    if l_file_receiver = 'FINES' then
      iparse_oic_docf(p_fileid, p_filebody, p_file_name);
    elsif l_file_receiver = 'LOCPAY' then
      iparse_oic_docl(p_fileid, p_filebody, p_file_name);
    elsif l_file_receiver = 'FreeReqisites' then
      iparse_oic_docr(p_fileid, p_filebody, p_file_name);

    else
      iparse_oic_doc(p_fileid, p_filebody, p_file_name);
    end if;

  end iparse_oic_documents_file;


  -------------------------------------------------------------------------------
  procedure iparse_cm_mobile_file(p_clob in clob, p_filename in varchar2, p_fileid in number default null) is
    l_filebody   xmltype;
    l_xml        xmltype;
    c_clientlist varchar2(100) := '/ChangesExportFile/ChangesList/';
    c_client     varchar2(100);
    c_phone      varchar2(100);
    l_rnk        number;
    l_mphone     varchar2(12);
    l_tmp        varchar2(100);
    i            number;
    j            number;
    l_custtype   customer.custtype%type;
    l_filetype   ow_cl_info_data_error%rowtype;
    l_ismmfo     params$base.val%type := nvl(getglobaloption('IS_MMFO'), '0');

  begin

    l_filebody := xmltype(p_clob);

    i := 0;

    loop

      i := i + 1;

      c_client := c_clientlist || 'ChangedItem[' || i || ']/ClientRs/Client';

      -- выход при отсутствии транзакций
      if l_filebody.existsnode(c_client) = 0 then
        exit;
      end if;

      l_xml := xmltype(extract(l_filebody, c_client, null));

      l_rnk := to_number(substr(extract(l_xml, '/Client/ClientInfo/ClientNumber/text()', null),
                                5));
      if l_ismmfo = '1' then
        l_rnk := to_number(bars_sqnc.rukey(p_key => to_char(l_rnk)));
      end if;
      l_mphone := null;

      j := 0;

      l_filetype.file_name := p_filename;
      l_filetype.rnk       := l_rnk;
      loop

        j := j + 1;

        c_phone := '/Client/PhoneList/Phone[' || j || ']';

        -- выход при отсутствии транзакций
        if l_xml.existsnode(c_phone) = 0 then
          exit;
        end if;

        l_tmp := substr(extract(l_xml, c_phone || '/PhoneType/text()', null), 1, 100);
        if l_tmp = 'Mobile' then
          l_mphone := substr(extract(l_xml, c_phone || '/PhoneNumber/text()', null), 1, 12);
        end if;

      end loop;
      l_filetype.mphone := l_mphone;
      l_filetype.kf     := sys_context('bars_context', 'user_mfo');
      begin
        select rnk, custtype
          into l_tmp, l_custtype
          from customer
         where rnk = l_rnk;
        kl.setcustomerelement(rnk_ => l_rnk,
                              tag_ => 'MPNO ',
                              val_ => l_mphone,
                              otd_ => 0);
        --Створюємо заявку в СМ при оновленні моб. номера телефону.
        for k in (select w.nd, decode(l_custtype, 3, 3, 8) opertype
                    from accounts a
                    join w4_acc w
                      on a.acc = w.acc_pk
                     and a.rnk = l_rnk) loop
          begin
            bars_ow.add_deal_to_cmque(p_nd => k.nd, p_opertype => k.opertype);
          exception
            when others then
              l_filetype.err_text := dbms_utility.format_error_stack() ||
                                     chr(10) ||
                                     dbms_utility.format_error_backtrace();
              insert into ow_cl_info_data_error values l_filetype;
          end;
        end loop;

      exception
        when no_data_found then
          l_filetype.err_text := 'Клієнта РНК ' || l_rnk || ' не знайдено';
          insert into ow_cl_info_data_error values l_filetype;
      end;

    end loop;
    set_file_status(p_fileid, i - 1, 2, null);

  end iparse_cm_mobile_file;

  -------------------------------------------------------------------------------
  -- iparse_cng_file
  -- процедура разбора файла CNGEXPORT*.xml
  --
  procedure iparse_cng_file(p_fileid in number, p_filebody in clob, p_file_name in varchar2) is

    l_parser       dbms_xmlparser.parser;
    l_doc          dbms_xmldom.domdocument;
    l_fileheader   dbms_xmldom.DOMNodeList;
    l_header       dbms_xmldom.DOMNode;
    l_contractlist dbms_xmldom.DOMNodeList;
    l_contract     dbms_xmldom.DOMNode;
    l_rec          t_cng := t_cng();
    l_pardate      date := null;
    l_filedate     date := null;
    l_acc          number;
    l_nls          accounts.nls%type;
    l_lcv          varchar2(3);

    l_id  number;
    l_idn number := 0;
    l_str varchar2(2000);

    h varchar2(100) := 'ow_files_proc.iparse_cng_file. ';

    -- процедура пакетной вставки коллекции
    procedure bulk_insert(l_rec in t_cng) is
    begin
      forall j in l_rec.first .. l_rec.last
        insert into ow_cng_data values l_rec (j);
    end;

  begin

    bars_audit.info(h || 'Start.p_fileid=' || p_fileid || '(' || p_file_name || ')');

    l_id := p_fileid;

    --  delete from ow_cng_data;
    -- дата предыдущего баланса
    select nvl(min(to_date(val, 'dd.mm.yyyy')), sysdate - 7)
      into l_pardate
      from ow_params
     where par = 'CNGDATE';

    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, p_filebody);
    bars_audit.info(h || 'clob loaded p_fileid=' || p_fileid || '(' || p_file_name || ')');

    l_doc := dbms_xmlparser.getdocument(l_parser);
    bars_audit.info(h || 'getdocument done p_fileid=' || p_fileid || '(' || p_file_name || ')');

    -- Заголовок файла
    l_fileheader := dbms_xmldom.getelementsbytagname(l_doc, 'FileHeader');
    l_header     := dbms_xmldom.item(l_fileheader, 0);

    -- дата баланса
    dbms_xslprocessor.valueof(l_header, 'CreationDate/text()', l_str);
    l_filedate := to_date(l_str, 'yyyy-mm-dd');

    -- проверка дат баланса
    if l_filedate < l_pardate then
      begin
        select file_name into l_str from ow_files where id = l_id;
      exception
        when no_data_found then
          l_str := to_char(l_id);
      end;
      -- ставим статус "обработан с ошибкой"
      set_file_status(p_fileid,
                      null,
                      3,
                      'Дата балансу в файлі менше за встановлену дату балансу');
      bars_audit.info(h || l_str ||
                      ': Дата балансу в файлі менше за встановлену дату балансу');
      raise_application_error(-20000,
                              l_str ||
                              ': Дата балансу в файлі менше за встановлену дату балансу');
    elsif l_filedate > l_pardate then
      -- удаляем старый баланс
      delete from ow_cng_data where cngdate < l_filedate;
      -- сохраняем дату баланса
      update ow_params
         set val = to_char(l_filedate, 'dd.mm.yyyy')
       where par = 'CNGDATE';
    end if;

    -- Тело файла
    l_contractlist := dbms_xmldom.getelementsbytagname(l_doc, 'ContractRs');
    bars_audit.info(h || 'getelementsbytagname done p_fileid=' || p_fileid || '(' || p_file_name || ')');

    for i in 0 .. dbms_xmldom.getlength(l_contractlist) - 1 loop

      l_idn := i + 1;

      l_contract := dbms_xmldom.item(l_contractlist, i);

      l_rec.extend;

      l_rec(l_rec.last).id := l_id;
      l_rec(l_rec.last).idn := l_idn;

      dbms_xslprocessor.valueof(l_contract, 'Contract/ContractIDT/ContractNumber/text()', l_str);
      l_rec(l_rec.last).contract_id := l_str;

      dbms_xslprocessor.valueof(l_contract, 'Contract/ContractIDT/RBSNumber/text()',  l_str);
      l_rec(l_rec.last).contract_acc := l_str;

      dbms_xslprocessor.valueof(l_contract, 'Contract/Currency/text()', l_str);
      l_rec(l_rec.last).contract_currency := l_str;

      dbms_xslprocessor.valueof(l_contract,
                                'Contract/ContractName/text()',
                                l_str);
      l_rec(l_rec.last).contract_name := trim(convert(dbms_xmlgen.convert(l_str, 1), 'CL8MSWIN1251', 'UTF8'));

      dbms_xslprocessor.valueof(l_contract, 'Contract/DateOpen/text()', l_str);
      l_rec(l_rec.last).contract_dateopen := to_date(l_str, 'YYYY-MM-DD');

      dbms_xslprocessor.valueof(l_contract, 'Contract/PlasticInfo/FirstName/text()', l_str);
      l_rec(l_rec.last).plastic_title := trim(convert(dbms_xmlgen.convert(l_str, 1), 'CL8MSWIN1251', 'UTF8'));

      dbms_xslprocessor.valueof(l_contract, 'Contract/PlasticInfo/FirstName/text()', l_str);
      l_rec(l_rec.last).plastic_firstname := trim(convert(dbms_xmlgen.convert(l_str, 1), 'CL8MSWIN1251', 'UTF8'));

      dbms_xslprocessor.valueof(l_contract, 'Contract/PlasticInfo/LastName/text()', l_str);
      l_rec(l_rec.last).plastic_lastname := trim(convert(dbms_xmlgen.convert(l_str, 1), 'CL8MSWIN1251', 'UTF8'));

      dbms_xslprocessor.valueof(l_contract, 'Contract/PlasticInfo/CompanyName/text()', l_str);
      l_rec(l_rec.last).plastic_companyname := trim(convert(dbms_xmlgen.convert(l_str, 1), 'CL8MSWIN1251', 'UTF8'));

      dbms_xslprocessor.valueof(l_contract, 'Info/Balances/Balance[Type="AVAILABLE"]/Amount/text()', l_str);
      l_rec(l_rec.last).avl_amount := convert_to_number(l_str);

      dbms_xslprocessor.valueof(l_contract, 'Info/Balances/Balance[Type="OWN_BALANCE"]/Amount/text()', l_str);
      l_rec(l_rec.last).own_amount := convert_to_number(l_str);

      dbms_xslprocessor.valueof(l_contract, 'Info/Balances/Balance[Type="CR_LIMIT"]/Amount/text()', l_str);
      l_rec(l_rec.last).cr_amount := convert_to_number(l_str);

      dbms_xslprocessor.valueof(l_contract, 'Info/Balances/Balance[Type="06"]/Amount/text()', l_str);
      l_rec(l_rec.last).mob_amount := convert_to_number(l_str);

      dbms_xslprocessor.valueof(l_contract,'Info/Balances/Balance[Type="SEC_DEPOSIT"]/Amount/text()', l_str);
      l_rec(l_rec.last).sec_amount := convert_to_number(l_str);

      dbms_xslprocessor.valueof(l_contract, 'Info/Balances/Balance[Type="ADRESS1"]/Amount/text()', l_str);
      l_rec(l_rec.last).ad_amount := convert_to_number(l_str);

      dbms_xslprocessor.valueof(l_contract, 'Info/Balances/Balance[Type="VIRTUAL"]/Amount/text()', l_str);
      l_rec(l_rec.last).virtual_amount := convert_to_number(l_str);

      l_nls := l_rec(l_rec.last).contract_acc;
      l_lcv := l_rec(l_rec.last).contract_currency;
      begin
        select acc
          into l_acc
          from accounts
         where nls = l_nls
           and kv = decode(l_lcv, 'UAH', 980, 'USD', 840, 'EUR', 978);
      exception
        when no_data_found then
          l_acc := null;
      end;
      l_rec(l_rec.last).acc := l_acc;

      l_rec(l_rec.last).cngdate := l_filedate;
      l_rec(l_rec.last).kf := sys_context('bars_context', 'user_mfo');
      -- пакетная вставка каждых 10к
      if mod(i, 10000) = 0 then
        bulk_insert(l_rec);
        l_rec.delete;
      end if;

    end loop;

    -- оставшиеся записи
    bulk_insert(l_rec);

    -- удаляем старые данные по счетам файла,
    --   1) если заимпортировали файл, переименовали его и заимпортировали еще раз,
    --   2) если Way4 прислал файл, передумал и прислал еще раз.
    delete from ow_cng_data
     where (id, idn) in
           (select c.id, c.idn
              from ow_cng_data c, ow_cng_data d
             where c.id <> p_fileid
               and d.id = p_fileid
               and c.contract_acc = d.contract_acc
               and c.contract_currency = d.contract_currency);

    -- ставим статус "обработан"
    set_file_status(p_fileid, l_idn, 2, null);

    bars_audit.info(h || 'load done p_fileid=' || p_fileid || '(' || p_file_name || ')');

    -- free (не забыть делать очистку в случае ошибок)
    l_rec.delete();
    l_rec := null;
    dbms_xmlparser.freeparser(l_parser);
    DBMS_XMLDOM.freeDocument(l_doc);

    bars_audit.info(h || to_char(l_idn) || ' rows parsed. p_fileid=' || p_fileid || '(' || p_file_name || ')');

    for z in (select a.acc,
                     decode(a.pap, 2, 1, -1) * nvl(abs(c.cr_amount), 0) * 100 lim
                from ow_cng_data c, accounts a
               where c.id = p_fileid
                 and c.acc = a.acc
                 and a.dazs is null
                 and a.lim <>
                     decode(a.pap, 2, 1, -1) * nvl(abs(c.cr_amount), 0) * 100) loop
      update accounts set lim = z.lim where acc = z.acc;
    end loop;

    bars_audit.info(h || 'Finish. p_fileid=' || p_fileid || '(' || p_file_name || ')');

  end iparse_cng_file;

  -- iparse_cng_file
  -- процедура разбора файла CNG - " _GL_BAL.txt"
  --

  procedure iparse_cng_file_txt(p_fileid in number, p_filebody in clob, p_file_name in varchar2) is
    l_id       number;
    l_filebody clob;
    l_idn      number := 0;
    l_idn_lim  number := 0;
    l_kf       varchar2(6);
    l_nls      varchar2(15);
    l_dat_bal  date;
    l_data     varchar2(4000);
    l_acc      number;
    l_pardate  date := null;
    l_filedate date := null;
    l_str      varchar2(2000);

    type t_cng_txt is table of ow_cng_data_txt%rowtype;
    l_rec t_cng_txt := t_cng_txt();

    type t_cng_txt_r is record(
      acc_pk ow_cng_data_txt.acc_pk%type,
      nbs_ow ow_cng_data_txt.nbs_ow%type,
      ost    ow_cng_data_txt.ost%type);

    type t_cng_txt_lim is table of t_cng_txt_r;
    l_rec_lim t_cng_txt_lim := t_cng_txt_lim();

    h varchar2(100) := 'ow_files_proc.iparse_cng_file_txt. ';

    -- процедура пакетной вставки коллекции+апдейт accounts
    procedure bulk_insert(l_rec in t_cng_txt) is
    begin

      forall j in l_rec.first .. l_rec.last
        insert into ow_cng_data_txt values l_rec (j);
    end;

    procedure bulk_update(l_rec_lim in t_cng_txt_lim) is
    begin
      forall k in l_rec_lim.first .. l_rec_lim.last
        update accounts
           set lim = decode(pap, 2, 1, -1) * nvl(abs(l_rec_lim(k).ost), 0) * 100
         where l_rec_lim(k).acc_pk = acc
            and l_rec_lim(k).nbs_ow = 'NLS_9129'
            and dazs is null
            and lim <> decode(pap, 2, 1, -1) *
                nvl(abs(l_rec_lim(k).ost), 0) * 100;
    end;

  begin

    bars_audit.info(h || 'Start. p_fileid=' || p_fileid || '(' || p_file_name || ')');

    l_id       := p_fileid;
    l_filebody := p_filebody;

    delete ow_cng_data_txt;

    bars_audit.info(h || 'Deleted. p_fileid=' || p_fileid || '(' || p_file_name || ')');

    import_flat_file(l_filebody);

    bars_audit.info(h || 'Imported to TMP_IMP_FILE. p_fileid=' || p_fileid || '(' || p_file_name || ')');

    -- дата предыдущего баланса
    select nvl(min(to_date(val, 'dd.mm.yyyy')), trunc(sysdate - 7))
      into l_pardate
      from ow_params
     where par = 'CNGDATE';

    -- дата нового баланса баланса
    select min(to_date(substr(line, instr(line, '/') - 2, 10), 'dd/mm/yyyy'))
      into l_filedate
      from TMP_IMP_FILE
     where rownum = 1;

    -- проверка дат баланса
    if l_filedate < l_pardate then
      begin
        select file_name into l_str from ow_files where id = l_id;
      exception
        when no_data_found then
          l_str := to_char(l_id);
      end;
      -- ставим статус "обработан с ошибкой"
      set_file_status(p_fileid,
                      null,
                      3,
                      'Дата балансу в файлі менше за встановлену дату балансу');
      bars_audit.info(h || l_str ||
                      ': Дата балансу в файлі менше за встановлену дату балансу');
      raise_application_error(-20000,
                              l_str ||
                              ': Дата балансу в файлі менше за встановлену дату балансу');
    elsif l_filedate > l_pardate then
      update ow_params
         set val = to_char(l_filedate, 'dd.mm.yyyy')
       where par = 'CNGDATE';
    end if;

    for c0 in (select t.line, t.nls, a.acc, t.kf, t.data, t.dat_bal
                 from (select line,
                              trim(substr(line, instr(line, '-') + 1, 14)) nls,
                              substr(line, 1, 6) kf,
                              substr(line, instr(line, '/') + 9, length(line)) data,
                              to_date(substr(line, instr(line, '/') - 2, 10),
                                      'dd/mm/yyyy') dat_bal
                         from TMP_IMP_FILE) t,
                      accounts a
                where a.nls = t.nls
                  and trim(t.data) <> '0') loop

      l_data    := c0.data;
      l_nls     := c0.nls;
      l_acc     := c0.acc;
      l_kf      := c0.kf;
      l_dat_bal := c0.dat_bal;

      if instr(l_data, 'NLS_9129=') > 0 then
        l_rec_lim.extend;
        l_rec_lim(l_rec_lim.last).nbs_ow := 'NLS_9129';
        l_rec_lim(l_rec_lim.last).acc_pk := l_acc;
        l_rec_lim(l_rec_lim.last).ost := substr(l_data,
                                                instr(l_data, 'NLS_9129=') +
                                                length('NLS_9129') + 1,
                                                instr(substr(l_data,
                                                             instr(l_data,
                                                                   'NLS_9129=') +
                                                             length('NLS_9129') + 1,
                                                             length(l_data)),
                                                      ';') - 1);
        l_idn_lim := l_idn_lim + 1;
      end if;

      if mod(l_idn_lim, 10000) = 0 then
        bulk_update(l_rec_lim);
        l_rec_lim.delete;
      end if;

      for c1 in (select * from ow_cng_types) loop

        if instr(l_data, c1.nbs_ow || '=') > 0 then
          l_rec.extend;
          l_idn := l_idn + 1;
          l_rec(l_rec.last).id := l_id;
          l_rec(l_rec.last).idn := l_idn;
          l_rec(l_rec.last).kf := l_kf;
          l_rec(l_rec.last).nls := l_nls;
          l_rec(l_rec.last).dat_bal := l_dat_bal;
          l_rec(l_rec.last).nbs_ow := c1.nbs_ow;
          l_rec(l_rec.last).acc_pk := l_acc;
          l_rec(l_rec.last).ost := substr(l_data,
                                          instr(l_data, c1.nbs_ow || '=') +
                                          length(c1.nbs_ow) + 1,
                                          instr(substr(l_data,
                                                       instr(l_data,
                                                             c1.nbs_ow || '=') +
                                                       length(c1.nbs_ow) + 1,
                                                       length(l_data)),
                                                ';') - 1);
        end if;

        -- пакетная вставка каждых 10к
        if mod(l_idn, 10000) = 0 then
          bulk_insert(l_rec);
          l_rec.delete;
        end if;

      end loop;

    end loop;

    -- оставшиеся записи
    bulk_insert(l_rec);

    bulk_update(l_rec_lim);

    bars_audit.info(h || 'Imported data. p_fileid=' || p_fileid || '(' || p_file_name || ')');

    -- ставим статус "обработан"
    set_file_status(l_id, l_idn, 2, null);

    l_rec.delete();
    l_rec := null;

    l_rec_lim.delete();
    l_rec_lim := null;

    bars_audit.info(h || 'Finish. p_fileid=' || p_fileid || '(' || p_file_name || ')');

  end iparse_cng_file_txt;

  -------------------------------------------------------------------------------
  -- iparse_riic_file
  -- процедура разбора квитанции RIIC*.*
  --
  procedure iparse_riic_file(p_fileid in number, p_file_name in varchar2, p_filebody in clob) is
    l_filebody xmltype;

    l_iic_filename ow_iicfiles.file_name%type;
    l_iic_n        ow_iicfiles.file_n%type;
    l_filestatus   ow_files.file_status%type := 2;
    l_status       varchar2(23);
    l_acceptrec    number;
    l_rejectrec    number;
    l_msg_code     varchar2(100);
    l_resp_class   varchar2(100);
    l_resp_code    varchar2(100);
    l_resp_text    varchar2(254);
    l_drn          number;
    l_srn          number;
    l_tmp          varchar2(100);
    l_dk           number;
    l_acc          number;
    l_nls          varchar2(14);
    l_kv           number;

    c_filetrailer varchar2(48) := '/DocFile/FileTrailer/';
    c_doclist     varchar2(100) := '/DocFile/DocList/';
    c_doc         varchar2(100);
    c_parm        varchar2(100);
    l_xml         xmltype;
    l_err         varchar2(254) := null;
    l_msg         varchar2(254) := null;

    l_payflag number;
    l_tt      varchar2(3);
    b_kvt     boolean := false;
    l_p1      number;
    l_p2      number;

    i number := null;
    j number;
    h varchar2(100) := 'ow_files_proc.iparse_riic_file. ';

  begin

    bars_audit.info(h || 'Start: p_fileid=' || p_fileid || '(' || p_file_name || ')');

    begin
      select file_name, file_n
        into l_iic_filename, l_iic_n
        from ow_iicfiles
       where upper(p_file_name) like upper('%' || file_name || '%');
    exception
      when no_data_found then
        l_filestatus := 3;
        l_msg        := 'Квитанція на неіснуючий файл';
        bars_audit.info(h || p_file_name || ': ' || l_msg);
    end;

    if l_filestatus <> 3 then

      l_filebody := xmltype(p_filebody);

      l_status    := substr(extract(l_filebody, c_filetrailer || '/LoadingStatus/text()', null), 1, 23);
      l_acceptrec := to_number(extract(l_filebody, c_filetrailer || '/NOfAcceptedRecs/text()', null));
      l_rejectrec := to_number(extract(l_filebody, c_filetrailer || '/NOfRejectedRecs/text()', null));

      if l_iic_n <> l_acceptrec + l_rejectrec then
        l_filestatus := 3;
        l_msg        := 'Кількість документів квитанції не відповідає кількості документів файла';
        bars_audit.info(h || p_file_name || ': ' || l_msg ||' .p_fileid=' || p_fileid || '(' || p_file_name || ')');
      end if;

    end if;

    if l_filestatus <> 3 then

      i := 0;

      loop

        -- счетчик документов
        i := i + 1;

        c_doc := c_doclist || 'Doc[' || i || ']';

        -- выход при отсутствии транзакций
        if l_filebody.existsnode(c_doc) = 0 then
          exit;
        end if;

        l_xml := xmltype(extract(l_filebody, c_doc, null));

        l_msg_code   := substr(extract(l_xml, '/Doc/TransType/TransCode/MsgCode/text()', null), 1, 100);
        l_resp_class := substr(extract(l_xml, '/Doc/Status/RespClass/text()', null), 1, 100);
        l_resp_code  := substr(extract(l_xml, '/Doc/Status/RespCode/text()', null), 1, 100);
        l_resp_text  := substr(extract(l_xml, '/Doc/Status/RespText/text()', null), 1, 254);

        j := 0;

        loop

          j := j + 1;

          c_parm := '/Doc/DocRefSet/Parm[' || j || ']';

          -- выход при отсутствии транзакций
          if l_xml.existsnode(c_parm) = 0 then
            exit;
          end if;

          l_tmp := substr(extract(l_xml, c_parm || '/ParmCode/text()', null),
                          1,
                          100);
          if l_tmp = 'DRN' then
            l_drn := to_number(extract(l_xml, c_parm || '/Value/text()', null));
          elsif l_tmp = 'SRN' then
            l_srn := to_number(extract(l_xml, c_parm || '/Value/text()', null));
          end if;

        end loop;

        l_err := null;
        l_acc := null;

        -- счета
        if l_msg_code = 'PAYFAAS' then

          -- ищем счет
          l_tmp := substr(extract(l_xml, '/Doc/Destination/ContractNumber/text()', null), 1, 100);
          l_nls := trim(replace(l_tmp, g_w4_branch || '-', ''));
          l_kv  := to_number(extract(l_xml, '/Doc/Billing/Currency/text()', null));

          begin
            select acc
              into l_acc
              from accounts
             where nls = l_nls
               and kv = l_kv;
          exception
            when no_data_found then
              l_acc := null;
              l_err := 'Квитовка счета ' || l_nls || '/' || l_kv || ' - счет не найден';
              bars_audit.info(h || p_file_name || ': ' || l_err);
              l_msg := substr(l_msg || l_err, 1, 254);
          end;

          if l_acc is not null then
            -- сохраняем историю
            insert into ow_acc_history
              (acc, s, dat, f_n, resp_class, resp_code, resp_text)
              select acc, s, dat, f_n, l_resp_class, l_resp_code, l_resp_text
                from ow_acc_que
               where upper(f_n) = upper(substr(p_file_name, 3))
                 and acc = l_acc
                 and sos = 1;
            -- ошибка
            if l_resp_class = 'Error' then
              -- повторно отправить файл
              begin
                update ow_acc_que
                   set sos = 0, f_n = null
                 where upper(f_n) = upper(substr(p_file_name, 3))
                   and acc = l_acc
                   and sos = 1;
              exception
                when dup_val_on_index then
                  -- уже есть новые данные для отправки по этому счету, удаляем старые
                  delete from ow_acc_que
                   where upper(f_n) = upper(substr(p_file_name, 3))
                     and acc = l_acc
                     and sos = 1;
              end;
              -- успешная обработка
            else
              delete from ow_acc_que
               where upper(f_n) = upper(substr(p_file_name, 3))
                 and acc = l_acc
                 and sos = 1;
            end if;
          end if;

          -- документы
        else
          begin
            select dk into l_dk from ow_msgcode where msgcode = l_msg_code;

            -- квитовка строки
            update ow_pkk_que
               set drn        = l_drn,
                   resp_class = l_resp_class,
                   resp_code  = l_resp_code,
                   resp_text  = l_resp_text
             where f_n = l_iic_filename
               and ref = l_srn
               and dk = l_dk
            returning acc into l_acc;
            -- если не нашли, смотрим на уже сквитованные документы
            if sql%rowcount = 0 then
              update ow_pkk_history
                 set drn        = l_drn,
                     resp_class = l_resp_class,
                     resp_code  = l_resp_code,
                     resp_text  = l_resp_text
               where f_n = l_iic_filename
                 and ref = l_srn
                 and dk = l_dk
              returning acc into l_acc;
              if sql%rowcount = 0 then
                l_err := 'Квитовка док. ' || l_srn || ' - док. не відправлявся в файлі ' || l_iic_filename || ';';
                bars_audit.info(h || p_file_name || ': ' || l_err ||' .p_fileid=' || p_fileid || '(' || p_file_name || ')');
                l_msg := substr(l_msg || l_err, 1, 254);
              end if;
            end if;

            begin
              select t.pay_flag, o.tt
                into l_payflag, l_tt
                from obpc_trans_out t, oper o
               where o.ref = l_srn
                 and o.tt = t.tt
                 and t.dk = l_dk;
            exception
              when no_data_found then
                null;
            end;

            -- оплата/сторнирование при квитовке
            if l_srn is not null and l_err is null and l_payflag in (1, 2) then
              b_kvt := false;
              -- успешная квитовка
              if l_payflag = 1 and l_resp_code = '0' then
                 begin
                bars_ow.final_payment(l_srn, l_dk, b_kvt);
                -- квитовка документа
                if b_kvt then
                  -- доп. реквизиты
                  if l_dk = 1 then
                    set_operw(l_srn, 'OW_FL', p_file_name);
                  else
                    set_operw(l_srn, 'OWFL2', p_file_name);
                  end if;
                  -- удаление из очереди на отправку/квитовку
                  bars_ow.del_pkkque(l_srn, l_dk);
                end if;
                 exception
                   when others then
                    l_err := substr('Квитовка док.' || l_srn || '-ошибка:'||sqlerrm,1,254);
                    bars_audit.info(h ||'Err:' || p_file_name|| ' Ref:'||l_srn||' '|| dbms_utility.format_error_stack() || chr(10) ||
                                    dbms_utility.format_error_backtrace());
                    l_msg := substr(l_msg || l_err, 1, 254);
                    update ow_pkk_que
                       set resp_text  = l_err
                    where f_n = l_iic_filename
                       and ref = l_srn
                       and dk = l_dk
                    returning acc into l_acc;
                 end;
              end if;
              -- ошибка квитовки
              if l_payflag in (1, 2) and l_resp_code <> '0' then
                -- удаление из очереди на отправку/квитовку
                bars_ow.del_pkkque(l_srn, l_dk);
                -- сторнируем документ
                begin
                  savepoint sp_back;
                  if l_tt = g_tt_asg then
                    declare
                      l_asg_nd  number;
                      l_asg_dat date;
                    begin
                      select to_number(min(decode(trim(tag), 'ND', value, null))),
                             to_date(min(decode(trim(tag), 'MDATE', value, null)),'dd.mm.yyyy')
                        into l_asg_nd, l_asg_dat
                        from operw
                       where ref = l_srn;
                      if l_asg_nd is not null and l_asg_dat is not null then
                        execute immediate 'declare l_asg_ref number; begin l_asg_ref := ' ||
                                          l_srn ||
                                          '; cck_dpk.modi_ret_ex(:nd, l_asg_ref, :dat); end;'
                          using l_asg_nd, l_asg_dat;
                      else
                        p_back_dok(l_srn, 5, null, l_p1, l_p2);
                      end if;
                    end;
                  else
                    p_back_dok(l_srn, 5, null, l_p1, l_p2);
                  end if;
                  update operw
                     set value = substr('Повернено по квитанції ПЦ ' ||
                                        p_file_name || '(' || l_resp_code || '#' ||
                                        l_resp_text || ')',
                                        1,
                                        220)
                   where ref = l_srn
                     and tag = 'BACKR';
                  insert into oper_visa
                    (ref, dat, userid, groupid, status)
                  values
                    (l_srn, sysdate, user_id, g_chkid, 3);
                exception
                  when others then
                    rollback to sp_back;
                    bars_audit.info(h || 'Err:' || p_file_name || ' ' ||
                                    dbms_utility.format_error_stack() ||
                                    chr(10) ||
                                    dbms_utility.format_error_backtrace());
                end;
              end if;
              if l_tt = g_tt_asg then
                bars_ow.set_cck_sob(l_srn, l_dk, l_acc, 2, b_kvt);
              end if;
            end if;

          exception
            when no_data_found then
              l_err := 'Квитовка док. ' || l_srn ||
                       ' - неизвестный код MsgCode - ' || l_msg_code;
              bars_audit.info(h || p_file_name || ': ' || l_err);
              l_msg := substr(l_msg || l_err, 1, 254);
          end;
        end if;

      end loop;

      -- квитовка файла
      update ow_iicfiles
         set tick_name       = p_file_name,
             tick_date       = sysdate,
             tick_status     = l_status,
             tick_accept_rec = l_acceptrec,
             tick_reject_rec = l_rejectrec
       where file_name = l_iic_filename;

    end if;

    -- ставим статус
    set_file_status(p_fileid,
                    (case when i is null then null else i - 1 end),
                    l_filestatus,
                    l_msg);

    bars_audit.info(h || 'Finish. p_fileid=' || p_fileid || '(' || p_file_name || ')');

  end iparse_riic_file;

  -------------------------------------------------------------------------------
  -- iparse_roic_doc_rev
  -- процедура разбора файла R_OIC_Documents*LOCPAYREV*.xml
  --
  procedure iparse_roic_doc_rev(p_fileid   in number,
                                p_filename in varchar2,
                                p_filebody in clob) is

    l_parser       dbms_xmlparser.parser;
    l_doc          dbms_xmldom.domdocument;
    l_filetrailer  dbms_xmldom.domnodelist;
    l_trailer      dbms_xmldom.domnode;
    l_analyticlist dbms_xmldom.domnodelist;
    l_analytic     dbms_xmldom.domnode;
    l_rec          ow_oic_documents_data%rowtype;
    l_str          varchar2(2000);
    l_resp_class ow_locpay_match.resp_class%type;
    l_resp_code  ow_locpay_match.resp_code%type;
    l_resp_text  ow_locpay_match.resp_text%type;
    l_filestatus ow_files.file_status%type := 2;

    l_status       varchar2(23);
    l_acceptrec    number;
    l_rejectrec    number;
    l_oic_filename ow_iicfiles.file_name%type;
    l_oic_n        ow_iicfiles.file_n%type;
    l_msg          varchar2(254) := null;

    h varchar2(100) := 'ow_files_proc.iparse_roic_doc_rev. ';
  begin
    bars_audit.info(h || 'Start: p_filename=>' || p_filename);

    begin
      select file_name, file_n
        into l_oic_filename, l_oic_n
        from ow_oicrevfiles
       where upper(p_filename) like upper('%'||file_name||'%');
    exception
      when no_data_found then
        l_filestatus := 3;
        l_msg        := 'Квитанція на неіснуючий файл';
        bars_audit.info(h || p_filename || ': ' || l_msg);
    end;

    if l_filestatus <> 3 then

      l_parser := dbms_xmlparser.newparser;
      dbms_xmlparser.parseclob(l_parser, p_filebody);
      bars_audit.info(h || 'clob loaded');

      l_doc := dbms_xmlparser.getdocument(l_parser);
      bars_audit.info(h || 'getdocument done');

      l_filetrailer := dbms_xmldom.getelementsbytagname(l_doc, 'FileTrailer');
      l_trailer     := dbms_xmldom.item(l_filetrailer, 0);

      dbms_xslprocessor.valueof(l_trailer, 'LoadingStatus/text()', l_str);
      l_status := substr(l_str, 1, 23);

      dbms_xslprocessor.valueof(l_trailer, 'NOfAcceptedRecs/text()', l_str);
      l_acceptrec := convert_to_number(l_str);

      dbms_xslprocessor.valueof(l_trailer, 'NOfRejectedRecs/text()', l_str);
      l_rejectrec := convert_to_number(l_str);
      if l_oic_n <> l_acceptrec + l_rejectrec then
        l_filestatus := 3;
        l_msg        := 'Кількість документів квитанції не відповідає кількості документів файла';
        bars_audit.info(h || p_filename || ': ' || l_msg);
      end if;

      if l_filestatus <> 3 then
        l_analyticlist := dbms_xmldom.getelementsbytagname(l_doc, 'Doc');
        bars_audit.info(h || 'getelementsbytagname done');
        for i in 0 .. dbms_xmldom.getlength(l_analyticlist) - 1
        loop

        l_analytic := dbms_xmldom.item(l_analyticlist, i);

        dbms_xslprocessor.valueof(l_analytic, 'DocRefSet/Parm[ParmCode="RRN"]/Value/text()', l_str);
        l_rec.doc_rrn := convert_to_number(l_str);

        dbms_xslprocessor.valueof(l_analytic, 'Status/RespClass/text()', l_str);
        l_resp_class := substr(l_str,1,100);
        dbms_xslprocessor.valueof(l_analytic, 'Status/RespCode/text()', l_str);
        l_resp_code := substr(l_str,1,100);
        dbms_xslprocessor.valueof(l_analytic, 'Status/RespText/text()', l_str);
        l_resp_text := substr(l_str,1,254);
        if l_resp_class = 'Error' then
          update ow_locpay_match t
             set t.state = 3,
                 t.resp_class = l_resp_class,
                 t.resp_code = l_resp_code,
                 t.resp_text = l_resp_text
          where t.rrn = l_rec.doc_rrn and t.revfile_name = l_oic_filename;

        else
          update ow_locpay_match t
             set t.state = 2,
                 t.resp_class = l_resp_class,
                 t.resp_code = l_resp_code,
                 t.resp_text = l_resp_text
          where t.rrn = l_rec.doc_rrn and t.revfile_name = l_oic_filename;
        end if;

        end loop;

      end if;

    end if;

      --квитовка файла
      update ow_oicrevfiles
       set tick_name = p_filename,
           tick_date = sysdate,
           tick_status = l_status,
           tick_accept_rec = l_acceptrec,
           tick_reject_rec = l_rejectrec
     where file_name = l_oic_filename;
      -- ставим статус
    set_file_status(p_fileid, l_acceptrec + l_rejectrec, l_filestatus, l_msg);

    bars_audit.info(h || 'Finish.');
  end iparse_roic_doc_rev;

  procedure parse_file(p_fileid in number) is
    l_filetype ow_files.file_type%type;
    l_filename ow_files.file_name%type;
    l_fileblob blob;
    l_fileclob clob;
    l_u        blob;
    l_err      ow_files.err_text%type;
    l_status   number;
    h          varchar2(100) := 'ow_files_proc.parse_file. ';
  begin

    bars_audit.info(h || 'Start. p_fileid=>' || p_fileid);

    -- определяем тип файла
    begin
      select file_type, file_name, file_body
        into l_filetype, l_filename, l_fileblob
        from ow_files
       where id = p_fileid;
    exception
      when no_data_found then
        bars_audit.info(h || 'File not found p_fileid=>' ||
                        to_char(p_fileid));
        bars_error.raise_nerror(g_modcode, 'FILE_NOT_FOUND');
    end;
    bars_audit.info(h || 'l_filetype=>' || l_filetype);

    -- разархивируем blob
    if lower(substr(l_filename, -4)) = '.zip' then
      -- zip
      l_u := ow_utl.get_filefromzip(l_fileblob);
    else
      -- gzip
      l_u := utl_compress.lz_uncompress(l_fileblob);
    end if;
    -- преобразуем в clob
    l_fileclob := lob_utl.blob_to_clob(l_u);

    if l_filetype = g_filetype_atrn then
      iparse_oic_atransfers_file(p_fileid, l_fileclob, l_filename);
    elsif l_filetype = g_filetype_ftrn then
      -- структура atransfers и ftransfers одинаковая, отличаются только алгоритмы оплаты
      iparse_oic_atransfers_file(p_fileid, l_fileclob, l_filename);
    elsif l_filetype = g_filetype_doc then
      iparse_oic_documents_file(p_fileid, l_fileclob, l_filename);
    elsif l_filetype = g_filetype_cng then
      if instr(upper(l_filename), 'CL_INFO') > 0 then
        iparse_cm_mobile_file(l_fileclob, l_filename, p_fileid);
      else
        if instr(upper(l_filename), '_GL_BAL') > 0 then
          iparse_cng_file_txt(p_fileid, l_fileclob, l_filename);
        else
          iparse_cng_file(p_fileid, l_fileclob, l_filename);
        end if;
      end if;
    elsif l_filetype = g_filetype_riic then
      iparse_riic_file(p_fileid, l_filename, l_fileclob);
    elsif l_filetype = g_filetype_roic then
      iparse_roic_doc_rev(p_fileid, l_filename, l_fileclob);
    end if;

    begin
      select file_status into l_status from ow_files where id = p_fileid;
      if l_status <> 0 then
        update ow_files set file_body = empty_blob() where id = p_fileid;
      end if;
    exception
      when no_data_found then
        null;
    end;

    bars_audit.info(h || 'Finish. p_fileid=>' || p_fileid);

  exception
    when others then
      if (sqlcode = -19202 or sqlcode = -31011) then
        l_err := 'Порушено структуру файла';
      else
        l_err := substr(dbms_utility.format_error_stack() || chr(10) ||
                        dbms_utility.format_error_backtrace(),
                        1,
                        254);
      end if;
      begin
        select file_status into l_status from ow_files where id = p_fileid;
        if l_status <> 3 then
          set_file_status(p_fileid,
                          null,
                          3,
                          substr('Loading error: ' || l_err, 1, 254));
        end if;
      exception
        when no_data_found then
          null;
      end;
      bars_audit.info(h || 'Loading error: ' ||
                      dbms_utility.format_error_stack() || chr(10) ||
                      dbms_utility.format_error_backtrace());
  end parse_file;

  function get_file_list return t_files is
    l_files t_files := t_files();
  begin
    select t.id, t.file_name, t.file_type, t.file_status, nvl(tt.type, 0) type, tt.offset, tt.offsetexpire
      bulk collect
      into l_files
      from ow_files t, ow_file_type tt
     where tt.file_type = t.file_type
       and t.file_status = 0
       and tt.io = 'I'
       and t.origin = 1
       and t.file_date >= trunc(sysdate) - 10
       for update skip locked
     order by tt.priority,
              to_number(regexp_replace(regexp_substr(lower(t.file_name),
                                                     '(_[0-9]{1,}\.)|(_[0-9]{1,}_[b-c])'),
                                       '[^0-9]',
                                       ''));
     return l_files;
  end;

  function lock_file (p_id in number) return boolean
  is
     l_id   number;
     b_lock boolean;
  begin
     begin
        select id into l_id from ow_files where id = p_id for update skip locked;
        b_lock := true;
     exception when no_data_found then
        b_lock := false;
     end;
     return b_lock;
  end;

  procedure parse_files(p_files out t_files) is
    l_files           t_files := t_files();
    l_useparallelexec params$global.val%type;
    l_sql_chunk       varchar2(32000);
    l_sql_stmt        varchar2(32000);
    l_parallel_level  number;
    l_parallel_group  number;
    h          varchar2(100) := 'ow_files_proc.parse_files. ';
  begin
    begin
      l_useparallelexec := trim(get_global_param('USEPAREXEC'));
    exception
      when others then
        l_useparallelexec := '0';
    end;
    if l_useparallelexec = '1' then
      bars_login.set_long_session();
      begin
        l_parallel_level := to_number(trim(get_global_param('NUMPARLEVEL')));
      exception
        when others then
          l_parallel_level := 5;
      end;
      begin
        l_parallel_group := to_number(trim(get_global_param('NUMPARGROUP')));
      exception
        when others then
          l_parallel_group := 50;
      end;
    end if;
    l_files := get_file_list;

   if l_files.first is not null
     then
    -- Переведемо
    set_files_status(l_files, 11);
    if l_useparallelexec = '1' then

     for c_ch in 1 .. l_files.count loop
       l_sql_chunk := l_sql_chunk||' select '||l_files(c_ch).id||' start_id, '||l_files(c_ch).id||' end_id from dual ';
       if c_ch <> l_files.last then l_sql_chunk:= l_sql_chunk||'union'; end if;
     end loop;

      --Запуск
      l_sql_stmt := 'begin
                      bars_login.login_user(p_sessionid => substr(sys_guid(), 1, 32),
                                            p_userid    => '|| USER_ID||',
                                            p_hostname  => null,
                                            p_appname   => '' w4_parjob '');
                      bc.go('''||gl.amfo||''');
                      if ow_files_proc.lock_file(:start_id) then
                         ow_files_proc.parse_file(:end_id);
                      else
                         bars_audit.info(''ow_files_proc. parallel pars. '' || ''File ''|| :start_id ||'' is processed by another application'');
                      end if;
                      bars_login.logout_user;
                    exception
                      when others then
                        bars_login.logout_user;
                    end;';
        bars_ow.run_parallel(p_task           => DBMS_PARALLEL_EXECUTE.GENERATE_TASK_NAME('PARSE_FILES_'),
                             p_chunk          => l_sql_chunk,
                             p_stmt           => l_sql_stmt,
                             p_parallel_level => l_parallel_level);
    else
      for c_f in 1 .. l_files.count loop
        if lock_file(l_files(c_f).id) then
           parse_file(l_files(c_f).id);
           commit;
        else
           bars_audit.info(h || 'File ' || l_files(c_f).file_name || ' is processed by another application');
        end if;
      end loop;
    end if;

   end if;
    p_files := l_files;
  end;

  procedure pay_file(p_fileid in number) is
    l_offset       number;
    l_offsetexpire varchar2(8);
    l_expiredate   date;
    l_filetype     ow_file_type.file_type%type;
    l_current_bd   date := gl.bd;
    l_paydate      date;-- дата оплати файлу
    l_changbd      boolean := false;
    l_err          varchar2(254);
    l_status       ow_files.file_status%type;
    l_fn           ow_files.file_name%type;
    h varchar2(100) := 'ow_files_proc.pay_file. ';
  begin
    select tt.offset, trim(tt.offsetexpire), t.file_type, t.file_status, t.file_name
      into l_offset, l_offsetexpire, l_filetype, l_status, l_fn
      from ow_files t
      join ow_file_type tt
        on t.file_type = tt.file_type
     where t.id = p_fileid;
    begin
      if l_offsetexpire is not null then
        l_expiredate := to_date(to_char(sysdate, 'ddmmyyyy') || ' ' || l_offsetexpire, 'ddmmyyyy hh24:mi:ss');
      end if;
    exception
      when others then
        l_offsetexpire := null;
        l_expiredate   := null;
    end;

    if nvl(l_offset, 0) <> 0 and l_filetype <>  g_filetype_atrn then
      if l_offsetexpire is null or sysdate <= l_expiredate then
        l_paydate := dat_next_u(gl.bd, l_offset);
        gl.pl_dat(l_paydate);
        l_changbd := true;
      end if;
    elsif l_filetype = g_filetype_atrn and (l_offsetexpire is null or sysdate <= l_expiredate or (f_workday(trunc(sysdate)) is null))then
    -- Для ATRANSFERS намагаємось проплатити в дату постінгу
        begin
          select t.anl_postingdate
            into l_paydate
            from ow_oic_atransfers_data t
           where t.id = p_fileid
             and rownum = 1 and t.anl_postingdate is not null;
        exception
          when no_data_found then
            l_paydate := null;
        end;
        if l_paydate is not null then
          gl.pl_dat(l_paydate);
          l_changbd := true;
        end if;
      end if;

    bars_ow.pay_oic_file(p_fileid);

    if l_changbd then
      gl.pl_dat(l_current_bd);
    end if;
  exception
    when others then
      l_err := substr(dbms_utility.format_error_stack() || chr(10) ||
                dbms_utility.format_error_backtrace(), 1, 254);

      if l_status <> 3 then
        set_file_status(p_fileid, null, 3, substr('Pay error: ' || l_err, 1, 254));
      end if;

      bars_audit.info(h || 'Pay error#'||l_fn||'#: ' ||
         dbms_utility.format_error_stack() || chr(10) ||
         dbms_utility.format_error_backtrace());
  end;

  procedure pay_files(p_files in t_files, p_parallel_enable in boolean default true)
  is
    l_pay_files t_files := t_files();
    l_useparallelexec params$global.val%type;
    l_sql_chunk       varchar2(32000);
    l_sql_stmt        varchar2(32000);
    l_parallel_level  number;
    l_parallel_group  number;
    h          varchar2(100) := 'ow_files_proc.pay_files. ';
  begin
    begin
      l_useparallelexec := trim(get_global_param('USEPAREXEC'));
    exception
      when others then
        l_useparallelexec := '0';
    end;
    if l_useparallelexec = '1' then
      bars_login.set_long_session();
      begin
        l_parallel_level := to_number(trim(get_global_param('NUMPARLEVEL')));
      exception
        when others then
          l_parallel_level := 5;
      end;
      begin
        l_parallel_group := to_number(trim(get_global_param('NUMPARGROUP')));
      exception
        when others then
          l_parallel_group := 50;
      end;
    end if;

    -- відбираємо файли платежів
    for c_pf in 1 .. p_files.count loop
      if p_files(c_pf).type = 1 and get_file_state(p_files(c_pf).id) <> 3 then
        l_pay_files.extend;
        l_pay_files(l_pay_files.last) :=p_files(c_pf);
      end if;
    end loop;

    if l_useparallelexec = '1' and p_parallel_enable then

     for c_ch in 1 .. l_pay_files.count loop
       l_sql_chunk := l_sql_chunk||' select '||l_pay_files(c_ch).id||' start_id, '||l_pay_files(c_ch).id||' end_id from dual ';
       if c_ch <> l_pay_files.last then l_sql_chunk:= l_sql_chunk||'union'; end if;
     end loop;

      --Запуск
      l_sql_stmt := 'begin
                      bars_login.login_user(p_sessionid => substr(sys_guid(), 1, 32),
                                            p_userid    => '|| USER_ID||',
                                            p_hostname  => null,
                                            p_appname   => '' w4_parjob '');
                      bc.go('''||gl.amfo||''');
                      if ow_files_proc.lock_file(:start_id) then
                        ow_files_proc.pay_file(:end_id);
                      else
                         bars_audit.info(''ow_files_proc. parallel pars. '' || ''File ''|| :start_id ||'' is processed by another application'');
                      end if;
                      bars_login.logout_user;
                    exception
                      when others then
                        bars_login.logout_user;
                    end;';
        bars_ow.run_parallel(p_task           => DBMS_PARALLEL_EXECUTE.GENERATE_TASK_NAME('PAY_FILES_'),
                             p_chunk          => l_sql_chunk,
                             p_stmt           => l_sql_stmt,
                             p_parallel_level => l_parallel_level);

    else
      for c_f in 1 .. l_pay_files.count loop
        if lock_file(l_pay_files(c_f).id) then
           pay_file(l_pay_files(c_f).id);
           commit;
        else
           bars_audit.info(h || 'File ' || l_pay_files(c_f).file_name || ' is processed by another application');
        end if;
      end loop;
    end if;

  end;

  procedure files_processing(p_kf     in varchar2,
                             p_userid in number default 1) is
    l_files t_files := t_files();
  begin
    bars_login.login_user(sys_guid(), p_userid, null, null);

    -- встановлюється відділення, по якому працює регламентна процедура
    bars_context.go(p_kf);

    parse_files(l_files);

    if l_files.first is not null then

      pay_files(l_files);

        -- пробуємо доплатити послідовно всі файли.
      pay_files(l_files, false);

    end if;

    bars_login.logout_user;

  end;

  function get_docs_buffers (p_key in varchar2)
        return docs_buffers_set
        pipelined
  is
          l_docs_buffers_rec  docs_buffers_rec;

          l_buf_ext   varchar2(444);
          l_buf_int   varchar2(1024);
  begin

          for c in (select o.ref
                  from ow_files ow
                       join ow_oic_ref wr
                          on     ow.id = wr.id
                             and ow.file_date > sysdate - 10
                             and ow.file_type in ('DOCUMENTS', 'FTRANSFERS')
                             and wr.sign_state = 0
                       join oper o
                          on     wr.ref = o.ref
                             and o.sos between 0 and 4
                             --and o.mfoa <> o.mfob
                             and o.pdat >= trunc (sysdate) - 10
--------------COBUMMFO-6753 (операції OW4 з КБ)
                   union all
                   select o.ref from MWAY_MATCH mm
                       join oper o on mm.ref_tr = o.ref
                                  and o.sos between 0 and 4
                                  and o.pdat >= trunc (sysdate) - 10
------------------------                           
                 where rownum <= 1000
                   )
          loop


              chk.make_int_docbuf(c.ref, l_buf_int);
              docsign.retrievesepbuffer(c.ref, p_key, l_buf_ext);

              l_docs_buffers_rec.ref             := c.ref;
              l_docs_buffers_rec.doc_buffer_int  := rawtohex(utl_raw.cast_to_raw(l_buf_int));
              l_docs_buffers_rec.doc_buffer_ext  := rawtohex(utl_raw.cast_to_raw(l_buf_ext));

              pipe row (l_docs_buffers_rec);

          end loop;

  end get_docs_buffers;
  procedure put_doc_sign(p_ref      in integer,
                           p_key       in varchar2,
                           p_int_sign  in varchar2,
                           p_sep_sign  in varchar2)
  is
      l_oper   oper%rowtype;

      refA_  VARCHAR2(9);
      prty_  NUMBER;
      sos_   NUMBER;

      err_   NUMBER;    -- Return code
      rec_   NUMBER;    -- Record number
      mfoa_  VARCHAR2(12);   -- Sender's MFOs
      nlsa_  VARCHAR2(15);   -- Sender's account number
      mfob_  VARCHAR2(12);   -- Destination MFO
      nlsb_  VARCHAR2(15);   -- Target account number
      dk_    NUMBER;         -- Debet/Credit code
      s_     DECIMAL(24);    -- Amount
      vob_   NUMBER;         -- Document type
      nd_    VARCHAR2(10);   -- Document number
      kv_    NUMBER;         -- Currency code
      datD_  DATE;           -- Document date
      datP_  DATE;           -- Posting date
      nam_a_  VARCHAR2(38);  -- Sender's customer name
      nam_b_  VARCHAR2(38);  -- Target customer name
      nazn_   VARCHAR(160);  -- Narrative
      nazns_ CHAR(2);        -- Narrative contens type
      id_a_  VARCHAR2(14);   -- Sender's customer identifier
      id_b_  VARCHAR2(14);   -- Target's customer identifier
      id_o_  VARCHAR2(6);    -- Teller identifier
      sign_  OPER.SIGN%TYPE; -- Signature
      datA_  DATE;           -- Input file date/time
      d_rec_ VARCHAR2(80);   -- Additional parameters

      l_info      varchar2(4000);

      cur         crkr_ca_transfer%rowtype;

      l_rec_id    number;

	  l_p1      number;
      l_p2      number;
	  
      h          varchar2(100) := 'ow_files_proc.put_doc_sign. ';
  begin

      bars_audit.info(h || 'started . ref - '||p_ref);

      select * into l_oper from oper where ref=p_ref;

      if l_oper.sos between 0 and 4
      then
         savepoint sp_pay;

         chk.put_visa_out(p_ref, l_oper.tt, null, 0, null ,null , null, l_rec_id);

         --уточнить, нужно ли
         --p_fm_intdoccheck(p_ref);
         if (l_oper.mfoa <> l_oper.mfob ) then
            sgn_mgr.store_sep_sign(p_ref       => p_ref,
                                   p_sign_type => 'VG2',
                                   p_key_id    => p_key,
                                   p_sign_hex  => p_sep_sign);
         end if;

         sgn_mgr.store_int_sign(p_ref       => p_ref,
                                p_rec_id    => l_rec_id,
                                p_sign_type => 'VG2',
                                p_key_id    => p_key,
                                p_sign_hex  => p_int_sign);


         gl.pay( 2,p_ref,gl.bdate);

         select mfoa, nlsa, mfob, nlsb, dk, s, vob, nd, kv,
                    datd, datp, nam_a, nam_b, nazn, id_a, id_b,
                    id_o, sign, d_rec, sos, ref_a, prty
               into mfoa_,nlsa_,mfob_,nlsb_,dk_,s_,vob_,nd_,kv_,
                    datd_,datp_,nam_a_,nam_b_,nazn_,id_a_,id_b_,
                    id_o_,sign_,d_rec_, sos_, refa_, prty_
               from oper where ref=p_ref;

         if (sos_ = 5 and l_oper.mfoa <> l_oper.mfob ) then
            IF LENGTH(TRIM(NVL(d_rec_,'')))>0 THEN
               nazns_ := '11';
            ELSE
               nazns_ := '10';
            END IF;

            sep.in_sep(err_,rec_,mfoa_,nlsa_,mfob_,nlsb_,dk_,s_,
                       vob_,nd_,kv_,datD_,datP_,nam_a_,nam_b_,nazn_,
                       NULL,nazns_,id_a_,id_b_,id_o_,refA_,0,sign_,
                       NULL,NULL,datA_,d_rec_,0,p_ref,0);


           if err_ <> 0 then
              rollback to sp_pay;
              p_back_dok(p_ref, 5, null, l_p1, l_p2);
           end if;
        --уточнить, нужно ли
         --p_fm_extdoccheck(rec_);
         end if;

         update ow_oic_ref
         set sign_state=1
         where ref=p_ref;

      end if;
  exception
          when others then
            rollback to sp_pay;
            l_info := 'Помилка при накладані візи '||substr(sqlerrm || ' - ' || dbms_utility.format_error_backtrace, 1, 1024);
            bars_audit.error('ow_files_proc.put_doc_sign: ref = '||p_ref||', error - '||l_info);
  end;

begin
  init;
end;
/
 show err;
 
PROMPT *** Create  grants  OW_FILES_PROC ***
grant EXECUTE                                                                on OW_FILES_PROC   to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/ow_files_proc.sql =========*** End *
 PROMPT ===================================================================================== 
 
