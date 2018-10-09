
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_dpa.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_DPA is

g_head_version constant varchar2(64)  := 'Version 1.32 09/11/2017';
g_head_defs    constant varchar2(512) := '';

/** header_version - возвращает версию заголовка пакета */
function header_version return varchar2;

/** body_version - возвращает версию тела пакета */
function body_version return varchar2;

-------------------------------------------------------------------------------
-- form_file
--
procedure form_file (
  p_filetype  in varchar2,
  p_filename out varchar2 );

-------------------------------------------------------------------------------
-- form_ticket
-- процедура формирования квитанции на файлы @R/@D
--
procedure form_ticket (
  p_filename  in varchar2,
  p_fileerr   in varchar2,
  p_tickname out varchar2 );

-------------------------------------------------------------------------------
-- import_ticket
-- процедура импорта квитанций @R/@D
--
procedure import_ticket (
  p_filename  in varchar2,
  p_errcode  out varchar2 );

-------------------------------------------------------------------------------
-- check_files
-- процедура автоматического контроля файлов
-- для разблокировки счетов. отправленных в ДПА
--
procedure check_files (p_mode number);

-------------------------------------------------------------------------------
-- insert_to_temp
-- вставка во временную таблицу
--
procedure insert_data_to_temp(p_mfo varchar2, p_okpo varchar2, p_rp number, p_ot varchar2, p_odat date, p_nls varchar2, p_kv number, p_c_ag number , p_nmk varchar2,
                              p_adr varchar2, p_c_reg varchar2, p_c_dst varchar2, p_bic varchar2, p_country number);

-------------------------------------------------------------------------------
-- insert_to_temp
-- вставка во временную таблицу (@K)
--
procedure insert_data_to_temp(p_bic varchar2, p_nmk varchar2,p_ot varchar2, p_odat date, p_nls varchar2,p_kv number, p_c_ag number, p_country number, p_c_reg varchar2,p_okpo varchar2);

-------------------------------------------------------------------------------
-- insert_to_temp
-- вставка во временную таблицу
--
procedure insert_data_to_temp(p_ref number);

-------------------------------------------------------------------------------
-- get_cvk_file
-- Получить количество сформированных файлов ЦВК по типу файла
function get_cvk_file(p_filetype varchar2, p_file_number number, p_filename out varchar2) return clob;

-------------------------------------------------------------------------------
-- get_cvk_file_cont
-- Получить количество сформированных файлов ЦВК по типу файла
function get_cvk_file_count(p_filetype varchar2) return number;

-------------------------------------------------------------------------------
-- form_cvk_file
-- сформировать файлы и поместить во временное хранилище dpa_lob
-- в переменную p_file_count вернуть кол-во файлов

procedure form_cvk_file(p_filetype varchar2, p_filedate date, p_file_count out number);

procedure del_f_row(p_idrow varchar2);
procedure ins_ticket(p_filename varchar2, p_filedata clob);

procedure ins_r0(p_filename varchar2, p_filedata clob, p_tickname OUT varchar2);

    -- процедура на для отправки данных в дпа по нотариусам COBUMMFO-4028
  PROCEDURE accounts_tax(p_acc     accounts.acc%TYPE
                        ,p_daos    accounts.daos%TYPE
                        ,p_dazs    accounts.dazs%TYPE
                        ,p_kv      accounts.kv%TYPE
                        ,p_nbs     accounts.nbs%TYPE
                        ,p_nls     accounts.nls%TYPE
                        ,p_ob22    accounts.ob22%TYPE
                        ,p_pos     accounts.pos%TYPE
                        ,p_vid     accounts.vid%TYPE
                        ,p_rnk     accounts.rnk%TYPE
                        );
  FUNCTION dpa_nbs(p_nbs  varchar2
                 ,p_ob22 accounts.OB22%TYPE DEFAULT NULL) RETURN NUMBER;
end;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_DPA is

g_body_version constant varchar2(64)  := 'Version 1.27 27/08/2018';
g_body_defs    constant varchar2(512) := '';

g_modcode      constant varchar2(3)   := 'DPA';

/** header_version - возвращает версию заголовка пакета */
function header_version return varchar2 is
begin
  return 'Package header bars_dpa ' || g_head_version || chr(10) ||
         'AWK definition: ' || chr(10) || g_head_defs;
end header_version;

/** body_version - возвращает версию тела пакета */
function body_version return varchar2 is
begin
  return 'Package body bars_dpa ' || g_body_version ||  chr(10) ||
         'AWK definition: ' || chr(10) || g_body_defs;
end body_version;

-------------------------------------------------------------------------------
-- EXTRACT()
--
--   безопаcно получает значение по XPath
--
--
function extract(p_xml in xmltype, p_xpath in varchar2, p_default in varchar2) return varchar2 is
begin
  return p_xml.extract(p_xpath).getStringVal();
exception when others then
  if sqlcode = -30625 then
    return p_default;
  else
    raise;
  end if;
end extract;

-------------------------------------------------------------------------------
-- get_file_name
--
function get_file_name (
  p_filetype  in varchar2,
  p_filenum  out number ) return varchar2
is
  l_dps         params.val%type;
  l_filedate    date;
  l_filenum     number;
  l_filenumdef  number;
  l_filename    zag_f.fn%type := null;
  l_sab         varchar2(4);
  i number;
  p varchar2(100) := 'bars_dpa.get_file_name. ';
  l_kf varchar2(6) :=sys_context('bars_context','user_mfo');
begin

  bars_audit.info(p || 'Start.');

  l_dps := getglobaloption('DPA_REG');
  if l_dps is null then
     raise_application_error(-20000, 'Не вказано код органу ДПС регіонального рівня!', true);
  end if;
  begin
     select 1 into i from spr_obl where to_char(c_reg) = l_dps;
  exception when no_data_found then
     raise_application_error(-20000, 'Вказано неіснуючий код органу ДПС регіонального рівня!', true);
  end;


  begin
     select decode(p_filetype,
              'F', taxf_date,
              'P', taxp_date,
              'K', taxk_date,
              'CV', taxcv_date,
              'CA', taxca_date,
   			  null) file_date,
            decode(p_filetype,
               'F',    taxf_seq,
               'P',    taxp_seq,
               'K',    taxk_seq,
			   'CV',   taxcv_seq,
               'CA',   taxca_seq,
			    0) file_num,
            nvl(decode(p_filetype,
              'F',     taxf_seq_default,
              'P',     taxp_seq_default,
              'K',     taxk_seq_default,
  			  'CV',    taxcv_seq_default,
              'CA',    taxca_seq_default,
			  0),0) file_numdef
       into l_filedate, l_filenum, l_filenumdef
       from dpa_file_counters where kf = l_kf;
  exception when no_data_found then
     l_filedate   := null;
     l_filenum    := null;
     l_filenumdef := null;
  end;

  if l_filenum is null or trunc(l_filedate) <> trunc(sysdate) then
     l_filenum := l_filenumdef;
  end if;

  l_filenum := l_filenum + 1;

  -- @АTDxCхххххRxxхххххMDnnn.XML, де:
  -- @ - ознака приналежност_ файла до файл_в обм_ну в_домостями щодо в_дкриття/закриття рахунк_в м_ж ДПС України та ф_нансовими установами;
  -- А - функц_ональний п_дтип файла;
  -- Т - цифра, що визначає належн_сть файла до Файл_в пов_домлень чи Файл_в-в_дпов_дей або квитанц_й: 0 - Файл пов_домлень або Файл-в_дпов_дь, 1 - квитанц_я про одержання (перша квитанц_я) Файла пов_домлень, 2 - квитанц_я про прийняття до оброблення (друга квитанц_я) Файла пов_домлень або Файла-в_дпов_д_;
  -- Dx - код органу ДПС рег_онального р_вня за м_сцем розташування ф_нансової установи (доповнюється зл_ва нулями до 2 символ_в) зг_дно з дов_дкою про взяття ф_нансової установи на обл_к у орган_ ДПС;
  -- Cххххх - код ф_нансової установи, з якої/до якої надсилається файл (доповнюється зл_ва нулями до 6 символ_в). Для банк_вських установ та установ Державної казначейської служби України зазначається код банку, для небанк_вських ф_нансових установ - код ф_нансової установи;
  -- Rxxххххх - код за ЄДРПОУ ф_нансової установи, з якої/до якої надсилається файл (доповнюється зл_ва нулями до 8 символ_в);
  -- MD - дата формування файла (м_сяць, день в 36-знаков_й систем_ числення);
  -- nnn - порядковий номер файла протягом дня. Нумерац_я в 36-знаков_й систем_ числення.



  if p_filetype = 'CV' or p_filetype = 'CA' then
       select substr(sab,2,3) into l_sab from banks$base where mfo = gl.amfo;
	   l_filename := p_filetype||'*'||l_sab||
	                 f_chr36(extract(month from sysdate)) ||
		             f_chr36(extract(day from sysdate))||'.'|| lpadchr(l_filenum, '0',3);

  else
         l_filename := upper('@' || p_filetype || '0' ||
		 lpad(l_dps,2,'0') ||
		 lpad(f_ourmfo,6,'0') ||
		 lpad(f_ourokpo,8,'0') ||
		 f_chr36(extract(month from sysdate)) ||
		 f_chr36(extract(day from sysdate)) ||
		 lpad(f_conv36(l_filenum),3,'0') || '.XML');
  end if;

  p_filenum := l_filenum;

  bars_audit.info(p || 'Finish. l_filename=>' || l_filename);

  return l_filename;

end get_file_name;

-------------------------------------------------------------------------------
-- get_file_header
--
function get_file_header return xmltype
is
  l_header xmltype;
begin

  select
     XmlElement("DECLARHEAD",
        XmlForest(
           getglobaloption('NAME') "C_ORG_NAME",
           f_ourokpo "TIN",
           f_ourmfo "C_FIN"
         )
     )
  into l_header from dual;


  return l_header;

end get_file_header;

-------------------------------------------------------------------------------
-- get_ffile_body
--
function get_ffile_body (
  p_filename  in varchar2,
  p_filedate  in date,
  p_count    out number ) return xmltype
is
  l_rownum  number  := 0;
  l_data    xmltype := null;
  l_xml_tmp xmltype := null;
  l_mfo     varchar2(6);
  p varchar2(100) := 'bars_dpa.get_ffile_body. ';
begin

  bars_audit.info(p || 'Start.');

  l_mfo  := f_ourmfo;

  for v in ( select DISTINCT * from DPA_ACC_USERID where userid = user_id )
  loop

     l_rownum := l_rownum + 1;

     select XmlElement("ROWS", XmlAttributes(l_rownum "ROWNUM"),
               XmlElement("BANK_ID", l_mfo),
--               XmlElement("FIN_ID", l_mfo),
               XmlElement("NUM", v.okpo),
               XmlElement("RST_TYPE", v.rt),
               XmlElement("OPER_TYPE", v.ot),
               XmlElement("OPER_DATE", to_char(v.odat,'yymmdd')),
               XmlElement("ACCOUNT", v.nls),
               XmlElement("CURRENCY", v.kv),
               XmlElement("RESIDENT", v.c_ag),
               XmlElement("CLIENT_NAME", v.nmk),
               XmlElement("CLIENT_ADDR", v.adr),
               XmlElement("STS_REG", v.c_reg),
               XmlElement("STS_RAI", v.c_dst)
            )
       into l_xml_tmp
       from dual;

     select XmlConcat(l_data, l_xml_tmp) into l_data from dual;

     insert into lines_f (fn, dat, n, mfo, okpo, rtype, otype, odate, nls, kv, resid, nmkk, adr, c_reg, ntax)
     values (p_filename, p_filedate, l_rownum, l_mfo, v.okpo, v.rt, v.ot, v.odat, v.nls, v.kv, v.c_ag, v.nmk, v.adr, v.c_reg, v.c_dst);

     update ree_tmp
        set fn_o  = p_filename,
            dat_o = p_filedate,
            rec_o = l_rownum
      where nls = v.nls
        and kv  = v.kv
        and ot  = v.ot
        and fn_o is null;

  end loop;

  p_count := l_rownum;

  bars_audit.info(p || 'Finish. l_rownum=>' || to_char(l_rownum));

  return l_data;

end get_ffile_body;

-------------------------------------------------------------------------------
-- get_pfile_body
--
function get_pfile_body (
  p_filename  in varchar2,
  p_filedate  in date,
  p_count    out number ) return xmltype
is
  l_rownum  number  := 0;
  l_data    xmltype := null;
  l_xml_tmp xmltype := null;
  l_mfo     varchar2(6);
  l_okpo    varchar2(10);
  l_nb      varchar2(100);
  p varchar2(100) := 'bars_dpa.get_pfile_body. ';
begin

  bars_audit.info(p || 'Start.');

  l_mfo  := f_ourmfo;
  l_okpo := f_ourokpo;
  l_nb   := getglobaloption('NAME');

  for v in ( select DISTINCT * from DPA_ACC_USERID )
  loop

     l_rownum := l_rownum + 1;

     select XmlElement("ROWS", XmlAttributes(l_rownum "ROWNUM"),
               XmlElement("BANK_ID", l_mfo),
               XmlElement("FIN_ID", l_mfo),
               XmlElement("FIN_EDRPOU", l_okpo),
               XmlElement("FIN_NAME", l_nb),
               XmlElement("NUM", v.okpo),
               XmlElement("RST_TYPE", v.rt),
               XmlElement("OPER_TYPE", v.ot),
               XmlElement("OPER_DATE", to_char(v.odat,'yymmdd')),
               XmlElement("ACCOUNT", v.nls),
               XmlElement("RESIDENT", v.c_ag),
               XmlElement("CLIENT_NAME", v.nmk),
               XmlElement("CLIENT_ADDR", v.adr),
               XmlElement("STS_REG", v.c_reg),
               XmlElement("STS_RAI", v.c_dst)
            )
       into l_xml_tmp
       from dual;

     select XmlConcat(l_data, l_xml_tmp) into l_data from dual;

     execute immediate '
     insert into lines_p (fn, dat, n, mfo, bank_okpo, nb, okpo, rtype, otype, odate, nls, resid, nmkk, adr, c_reg, ntax)
     values (:filename, :filedate, :rown, :mfo, :okpo, :nb, :okpo, :rt, :ot, :odat, :nls, :c_ag, :nmk, :adr, :c_reg, :c_dst)'
     using p_filename, p_filedate, l_rownum, l_mfo, l_okpo, l_nb, v.okpo, v.rt, v.ot, v.odat, v.nls, v.c_ag, v.nmk, v.adr, v.c_reg, v.c_dst;

     update ree_tmp
        set fn_o  = p_filename,
            dat_o = p_filedate,
            rec_o = l_rownum
      where nls = v.nls
        and ot  = v.ot
        and fn_o is null;

  end loop;

  p_count := l_rownum;

  bars_audit.info(p || 'Finish. l_rownum=>' || to_char(l_rownum));

  return l_data;

end get_pfile_body;

-------------------------------------------------------------------------------
-- get_kfile_body
--
function get_kfile_body (
  p_filename  in varchar2,
  p_filedate  in date,
  p_count    out number ) return xmltype
is
  l_rownum  number  := 0;
  l_data    xmltype := null;
  l_xml_tmp xmltype := null;
  l_okpo    varchar2(10);
  p varchar2(100) := 'bars_dpa.get_kfile_body. ';
begin

  bars_audit.info(p || 'Start.');

  l_okpo := f_ourokpo;

  for v in ( select DISTINCT * from DPA_ACC_USERID )/*lypskykh 19.08.2016*/
  loop

     l_rownum := l_rownum + 1;

     select XmlElement("ROWS", XmlAttributes(l_rownum "ROWNUM"),
               XmlElement("BANK_CODE", v.bic),
               XmlElement("BANK_NAME", v.nmk),
               XmlElement("OPER_TYPE", v.ot),
               XmlElement("OPER_DATE", to_char(v.odat,'yymmdd')),
               XmlElement("CORR_ACCOUNT", v.nls),
               XmlElement("CURRENCY", v.kv),
               XmlElement("RESIDENT", v.c_ag),
               XmlElement("COUNTRY_CODE", v.country),
               XmlElement("STS_REG", v.c_reg),
               XmlElement("BANK_EDRPOU", l_okpo)
            )
       into l_xml_tmp
       from dual;

     select XmlConcat(l_data, l_xml_tmp) into l_data from dual;

     execute immediate '
     insert into lines_k (fn, dat, n, mfo, okpo, otype, odate, nls, kv, resid, nmkk, country, c_reg)
     values (:filename, :filedate, :rown, :bic, :okpo, :ot, :odat, :nls, :kv, :c_ag, :nmk, :country, :reg)'
     using p_filename, p_filedate, l_rownum, v.bic, l_okpo, v.ot, v.odat, v.nls, v.kv, v.c_ag, v.nmk, v.country, v.c_reg;

     update ree_tmp
        set fn_o  = p_filename,
            dat_o = p_filedate,
            rec_o = l_rownum
      where nls = v.nls
        and kv  = v.kv
        and ot  = v.ot
        and fn_o is null;

  end loop;

  p_count := l_rownum;

  bars_audit.info(p || 'Finish. l_rownum=>' || to_char(l_rownum));

  return l_data;

end get_kfile_body;

-------------------------------------------------------------------------------
-- form_file
--
procedure form_file (
  p_filetype  in varchar2,
  p_filename out varchar2 )
is
  l_file_name    varchar2(30);
  l_file_date    date := sysdate;
  l_file_num     number;
  l_file_header  xmltype;
  l_file_body    xmltype;
  l_file_trailer xmltype;
  l_xml_data     xmltype;
  l_xml_schema   varchar2(12);
  l_clob_data    clob;
  l_count        number;
  p varchar2(100) := 'bars_dpa.form_file. ';
  l_kf varchar2(6) :=sys_context('bars_context','user_mfo');
begin

  bars_audit.info(p || 'Start.');
  bars_audit.info(p || 'p_filetype => ' || p_filetype);

  delete from dpa_lob;

  -- FileName
  l_file_name := get_file_name(p_filetype, l_file_num);
  bars_audit.info(p || 'File name formed with name - ' || l_file_name);

  insert into zag_f (fn, dat)
  values (l_file_name, l_file_date);

  -- FileHeader
  l_file_header := get_file_header;
  bars_audit.trace(p || 'File header formed');

  -- FileBody
  if p_filetype = 'F' then
     l_file_body := get_ffile_body(l_file_name, l_file_date, l_count);
  elsif p_filetype = 'P' then
     l_file_body := get_pfile_body(l_file_name, l_file_date, l_count);
  elsif p_filetype = 'K' then
     l_file_body := get_kfile_body(l_file_name, l_file_date, l_count);
  else
     raise_application_error(-20000, 'Нев?домий тип файлу ' || p_filetype, true);
  end if;
  bars_audit.info(p || 'File body formed. l_count=>' || to_char(l_count));

  if l_count = 0 then

     delete from zag_f where fn = l_file_name and dat = l_file_date;
     l_file_name := null;

  else

     update zag_f set n = l_count where fn = l_file_name and dat = l_file_date;

     if p_filetype = 'F' then
        l_xml_schema := 'DPI20101.XSD';
        update dpa_file_counters
           set taxf_date =  trunc(l_file_date),
               taxf_seq  = l_file_num
         where kf = l_kf;
     elsif p_filetype = 'P' then
        l_xml_schema := 'DPI20201.XSD';
        update dpa_file_counters
           set taxp_date =  trunc(l_file_date),
               taxp_seq  = l_file_num
         where kf = l_kf;
     elsif p_filetype = 'K' then
        l_xml_schema := 'DPI20301.XSD';
        update dpa_file_counters
           set taxk_date =  trunc(l_file_date),
               taxk_seq  = l_file_num
         where kf = l_kf;
     end if;

     -- компоновка всего отчета
     select
       XmlElement("DECLAR",
          XmlAttributes('http://www.w3.org/2001/XMLSchema-instance' as "xmlns:xsi",
                        l_xml_schema as "xsi:noNamespaceSchemaLocation"),
          XmlConcat(
             l_file_header,
             XmlElement("DECLARBODY",
                XmlConcat(
                   XmlElement("C_DOC_FNAME", l_file_name),
                   XmlElement("C_DOC_CRTDATE", to_char(l_file_date,'yymmdd')),
                   XmlElement("C_DOC_CRTTIME", to_char(l_file_date,'hh24mi')),
                   XmlElement("C_DOC_QTREC", l_count),
                   l_file_body
                )
             )
          )
       )
     into l_xml_data
     from dual;

     dbms_lob.createtemporary(l_clob_data,FALSE);
     dbms_lob.append(l_clob_data, '<?xml version="1.0" encoding="windows-1251"?>');
     dbms_lob.append(l_clob_data, l_xml_data.getClobVal());

     insert into dpa_lob (file_data, file_name, userid)
     values (l_clob_data, l_file_name, user_id);

  end if;

  l_file_header := null;
  l_file_body   := null;
  l_xml_data    := null;

  p_filename := l_file_name;

  delete from dpa_acc_userid  where userid = user_id;

  bars_audit.info(p || 'Finish.');

end form_file;

-------------------------------------------------------------------------------
-- form_cvk_file
--   Файл реестра докуменотв для ЦВК (p_filetype = CV)
--
procedure form_cvk_file (
  p_filetype  in varchar2,
  p_filename out varchar2 )
is
  l_file_name    varchar2(30);
  l_file_date    date := sysdate;
  l_file_num     number;
  l_clob_data    clob;
  l_count        number;
  l_vid       varchar2(1);
  p varchar2(100) := 'bars_dpa.form_file. ';
begin

  bars_audit.info(p || 'Start.');
  bars_audit.info(p || 'p_filetype => ' || p_filetype);

  delete from dpa_lob;

  -- прочитать весь нвбор данных для данного файла и разбить на столько, сколько разных видов счетов.
/*
  select
  c.vid,
        c.fdat,
        c.mfo_d,
        c.nls_d,
        c.mfo_k,
        c.nls_k,
        c.dk     ,
        c.s     ,
        c.vob     ,
        c.nd     ,
        c.kv     ,
        c.datd,
        c.datp,
        c.nam_a,
        c.nam_b,
        c.nazn,
        c.d_rec,
        c.naznk,
        c.nazns,
        c.id_d,
        c.id_k,
        c.ref     ,
        c.dat_a,
        c.dat_b
    from dpa_acc_userid d, v_dpa_cv c
	where d.userid = user_id
	  and d.ref = c.ref
order by d.nls;

*/

  -- FileName
  l_file_name := get_file_name(p_filetype, l_file_num);
  bars_audit.info(p || 'File name formed');


  -- получим кол-во записей для файла
  select count(*) into l_count from dpa_acc_userid where userid = user_id;

/*
  l_sys_line := lpadchr(' ', ' ',100)||chr(13)||chr(10);
  l_header_line :=  substr(p_filename,1,12)||to_char(sysdate,'yymmddmiss')||lpadchr(l_count, '0', 6)||lpachr('',' ', 166)||chr(13)||chr(10);

  -- записать  в таблицу заголовков
  insert into zag_tb(fn, dat, n) values(l_filename, sysdate, l_count );


  -- FileBody
  if p_filetype = 'F' then
     l_file_body := get_ffile_body(l_file_name, l_file_date, l_count);
  elsif p_filetype = 'P' then
     l_file_body := get_pfile_body(l_file_name, l_file_date, l_count);
  elsif p_filetype = 'K' then
     l_file_body := get_kfile_body(l_file_name, l_file_date, l_count);
  else
     raise_application_error(-20000, 'Нев?домий тип файлу ' || p_filetype, true);
  end if;
  bars_audit.trace(p || 'File body formed. l_count=>' || to_char(l_count));

  if l_count = 0 then

     delete from zag_f where fn = l_file_name and dat = l_file_date;
     l_file_name := null;

  else

     update zag_f set n = l_count where fn = l_file_name and dat = l_file_date;

     dbms_lob.createtemporary(l_clob_data,FALSE);
     dbms_lob.append(l_clob_data, '<?xml version="1.0" encoding="windows-1251"?>');
     dbms_lob.append(l_clob_data, l_xml_data.getClobVal());

     insert into dpa_lob (id, file_data)
     values (1, l_clob_data);

  end if;

  l_file_header := null;
  l_file_body   := null;
  l_xml_data    := null;

  p_filename := l_file_name;

  bars_audit.trace(p || 'Finish.');
*/

end form_cvk_file;



-------------------------------------------------------------------------------
-- get_tick_body
function get_tick_body (
  p_filename  in varchar2,
  p_rows     out number ) return xmltype
is
  l_rownum  number  := 0;
  l_data    xmltype := null;
  l_xml_tmp xmltype := null;
  p varchar2(100) := 'bars_dpa.get_tick_body. ';
begin

  bars_audit.info(p || 'Start. p_filename - ' || p_filename);

  for v in ( select n, err from lines_r where fn = p_filename and err is not null and err <> '0000' )
  loop

     l_rownum := l_rownum + 1;

     select XmlElement("ROWS", XmlAttributes(l_rownum "ROWNUM"),
               XmlElement("ROWNUM_FILE_ISH", v.n),
               XmlElement("ERROR_CODE", v.err)
            )
       into l_xml_tmp
       from dual;

     select XmlConcat(l_data, l_xml_tmp) into l_data from dual;

  end loop;

  p_rows := l_rownum;

  bars_audit.info(p || 'Finish. l_rownum=>' || to_char(l_rownum));

  return l_data;

end get_tick_body;

-------------------------------------------------------------------------------
-- form_ticket
-- процедура формирования квитанции на файлы @R/@D
--
procedure form_ticket (
  p_filename  in varchar2,
  p_fileerr   in varchar2,
  p_tickname out varchar2 )
is
  l_tick_name    varchar2(30);
  l_tick_date    date := sysdate;
  l_file_date    date;
  l_file_n       number;
  l_rows         number := 0;
  l_xml_schema   varchar2(12) := 'DPI21001.XSD';
  l_file_header  xmltype := null;
  l_file_body    xmltype := null;
  l_xml_data     xmltype;
  l_clob_data    clob;

  p varchar2(100) := 'bars_dpa.form_ticket. ';

begin

  bars_audit.info(p || 'Start. p_filename - ' || p_filename);

  delete from dpa_lob;

  -- FileName
  l_tick_name := substr(p_filename,1,2) || '2' || substr(p_filename,4);

  update zag_f
     set fnk = l_tick_name,
         datk = l_tick_date
   where fn = p_filename
     and dat > sysdate-30
  returning dat, n into l_file_date, l_file_n;

  -- FileHeader
  l_file_header := get_file_header;
  bars_audit.info(p || 'File header formed');

  -- FileBody
  l_file_body := get_tick_body(p_filename, l_rows);
  bars_audit.info(p || 'File body formed.');

  -- компоновка всего отчета
  select XmlElement("DECLAR",
            XmlAttributes('http://www.w3.org/2001/XMLSchema-instance' as "xmlns:xsi",
                          l_xml_schema as "xsi:noNamespaceSchemaLocation"),
            XmlConcat(
               l_file_header,
               XmlElement("DECLARBODY",
                  XmlConcat(
                     XmlElement("C_DOC_FNAME", l_tick_name),
                     XmlElement("C_DOC_CRTDATE", to_char(l_tick_date, 'yymmdd')),
                     XmlElement("C_DOC_CRTTIME", to_char(l_tick_date, 'hh24mi')),
                     XmlElement("C_DOC_QTREC", l_rows),
                     XmlElement("PROC_FILE_NAME", p_filename),
                     XmlElement("PROC_FILE_CRTDATE", to_char(l_file_date, 'yymmdd')),
                     XmlElement("PROC_FILE_QTREC", l_file_n),
                     XmlElement("PROC_FILE_ERROR_CODE", p_fileerr),
                     l_file_body
                  )
               )
            )
         )
  into l_xml_data
  from dual;

  dbms_lob.createtemporary(l_clob_data,FALSE);
  dbms_lob.append(l_clob_data, '<?xml version="1.0" encoding="windows-1251"?>');
  dbms_lob.append(l_clob_data, l_xml_data.getClobVal());

    insert into dpa_lob (file_data, file_name, userid)
     values (l_clob_data, l_tick_name, user_id);

  l_file_header := null;
  l_file_body   := null;
  l_xml_data    := null;

  p_tickname := l_tick_name;

  bars_audit.info(p || 'Finish.');

end form_ticket;

-------------------------------------------------------------------------------
-- iparse_ticket
-- процедура разбора квитанции
--
procedure iparse_ticket (
  p_filename  in varchar2,
  p_xml       in xmltype,
  p_errcode  out varchar2 )
is

  l_tick_name  zag_f.fn%type;        -- Назва файла
  l_tick_date  zag_f.dat%type;        -- Дата створення файла
  l_tick_rec   zag_f.n%type;        -- К_льк_сть _нформац_йних рядк_в у файл_

  l_tick_n       lines_r.n%type;
  l_bank_mfo     lines_r.mfo%type;
  l_bank_okpo    lines_r.bank_okpo%type;
  l_okpo         lines_r.okpo%type;
  l_rtype        lines_r.rtype%type;
  l_nmkk         lines_r.nmkk%type;
  l_odate        lines_r.odate%type;
  l_account      lines_r.nls%type;
  l_currency     lines_r.kv%type;
  l_resid        lines_r.resid%type;
  l_receive_date lines_r.dat_in_dpa%type;    -- Дата отримання ДПС України Пов_домлення
  l_sts_date     lines_r.dat_acc_dpa%type;    -- Дата взяття рахунка на обл_к в орган_ ДПС
  l_reason       lines_r.id_pr%type;        -- Код причини в_дмови у взятт_ на обл_к рахунка
  l_sts_reg      lines_r.id_dpa%type;        -- Код органу ДПС рег_онального р_вня
  l_sts_rai      lines_r.id_dps%type;        -- Код органу ДПС районного р_вня
  l_rec_id       lines_r.id_rec%type;        -- _дентиф_катор запису
  l_f_name       lines_r.fn_f%type;        -- Назва файла, що квитується
  l_f_rec        lines_r.n_f%type;        -- К_льк_сть _нформац_йних рядк_в у файл_, що квитується

  l_err_code    varchar2(4);
  l_err         varchar2(4);
  l_dpablk      number;

  c_declarbody  varchar2(100) := '/DECLAR/DECLARBODY/';
  c_row         varchar2(100);
  l_xml         xmltype;
  l_tmp  varchar2(2000);
  l_tmp2 varchar2(2000);
  l_tmpn number;
  l_acc number;
  i number;

  p varchar2(100) := 'bars_dpa.iparse_ticket. ';

  l_tip    accounts.tip%type; -- COBUMMFO-7501
  l_nlsalt accounts.nlsalt%type; -- COBUMMFO-7501
begin

  bars_audit.info(p || 'Start. p_filename - ' || p_filename);

        l_tmp := extract(p_xml, c_declarbody || 'C_DOC_FNAME/text()', null);
  l_tick_name := upper(l_tmp);
        l_tmp := extract(p_xml, c_declarbody || 'C_DOC_CRTDATE/text()', null);
        l_tmp2:= extract(p_xml, c_declarbody || 'C_DOC_CRTTIME/text()', null);
  l_tick_date := to_date(substr(l_tmp,1,6) || substr(l_tmp2,1,4), 'yymmddhh24mi');
        l_tmp := extract(p_xml, c_declarbody || 'C_DOC_QTREC/text()', null);
  l_tick_rec  := to_number(l_tmp);

  if p_filename <> l_tick_name then
     -- _м`я у заголовку не в_дпов_дає найменуванню Файла
     l_err_code := '2105';
  else
     l_err_code := '0000';
  end if;

  -- сохраняем информацию о файле
  insert into zag_f (fn, dat, n, otm, datk, err)
  values (p_filename, l_tick_date, l_tick_rec, null, sysdate, l_err_code);
  bars_audit.info(p || 'ins - zag_f - ok');
  if l_err_code = '0000' then

  l_dpablk := to_number(getglobaloption('DPA_BLK'));

  i := 0;

  loop

     -- счетчик строк
     i := i + 1;
     bars_audit.info(p || 'i = ' || to_char(i));
     c_row := c_declarbody || 'ROWS[' || i || ']';

     -- выход при отсутствии транзакций
     if p_xml.existsnode(c_row) = 0 then
        exit;
     end if;

     l_xml := xmltype(extract(p_xml,c_row,null));

              l_tmp := extract(l_xml, '/ROWS/@ROWNUM', null);
     l_tick_n       := to_number(l_tmp);
              l_tmp := extract(l_xml, '/ROWS/BANK_ID/text()', null);
     l_bank_mfo     := substr(l_tmp,1,6);
              l_tmp := extract(l_xml, '/ROWS/FIN_ID/text()', null);
     l_bank_okpo    := substr(l_tmp,1,14);
              l_tmp := extract(l_xml, '/ROWS/NUM/text()', null);
     l_okpo         := substr(l_tmp,1,14);
              l_tmp := extract(l_xml, '/ROWS/RST_TYPE/text()', null);
     l_rtype        := to_number(l_tmp);
              l_tmp := extract(l_xml, '/ROWS/CLIENT_NAME/text()', null);
              l_tmp := trim(dbms_xmlgen.convert(l_tmp,1));
     l_nmkk         := substr(l_tmp,1,38);
              l_tmp := extract(l_xml, '/ROWS/OPER_DATE/text()', null);
     l_odate        := to_date(substr(l_tmp,1,6), 'yymmdd');
              l_tmp := extract(l_xml, '/ROWS/ACCOUNT/text()', null);
     l_account      := substr(l_tmp,1,14);
              l_tmp := extract(l_xml, '/ROWS/CURRENCY/text()', null);
     l_currency     := to_number(l_tmp);
              l_tmp := extract(l_xml, '/ROWS/RESIDENT/text()', null);
     l_resid        := to_number(l_tmp);
              l_tmp := extract(l_xml, '/ROWS/RECEIVE_DATE/text()', null);
     l_receive_date := to_date(substr(l_tmp,1,6), 'yymmdd');
              l_tmp := extract(l_xml, '/ROWS/STS_DATE/text()', null);
     l_sts_date     := to_date(substr(l_tmp,1,6), 'yymmdd');
              l_tmp := extract(l_xml, '/ROWS/REASON/text()', null);
     l_reason       := nvl(to_number(l_tmp),0);
              l_tmp := extract(l_xml, '/ROWS/STS_REG/text()', null);
     l_sts_reg      := to_number(l_tmp);
              l_tmp := extract(l_xml, '/ROWS/STS_RAI/text()', null);
     l_sts_rai      := to_number(l_tmp);
              l_tmp := extract(l_xml, '/ROWS/REC_ID/text()', null);
     l_rec_id       := l_tmp;
              l_tmp := extract(l_xml, '/ROWS/PROC_FILE_NAME/text()', null);
     l_f_name       := substr(upper(l_tmp),1,30);
              l_tmp := extract(l_xml, '/ROWS/REC_NUM/text()', null);
     l_f_rec        := to_number(l_tmp);

     -- код ошибки
     l_err := '0000';
     bars_audit.info(p || 'l_f_rec = ' || to_char(l_f_rec));
     -- проверки
     begin
        -- 2126 - имя файла @F
        select fn into l_tmp from zag_f where fn = l_f_name and dat > sysdate-30;
        bars_audit.info(p || 'fn = ' || to_char(l_tmp));
        begin
           -- 2124 - имя файла @F для данного счета
           if substr(p_filename,1,2) = '@R' then
              select n into l_tmpn
                from lines_f
               where fn  = l_f_name
                 and dat > sysdate-30
                 and nls = l_account
                 and kv  = l_currency
                 and otype in (1,6);

           else
              select n into l_tmpn
                from lines_p
               where fn  = l_f_name
                 and dat > sysdate-30
                 and nls = l_account
                 and otype in (1,6);

           end if;
            bars_audit.info(p || 'l_tmpn = ' || to_char(l_tmpn));
           -- 2125 - номер строки в файле @F
           if l_f_rec <> l_tmpn then
              -- Помилка в рекв_зит_ "Порядковий номер Пов_домлення, на яке надається в_дпов_дь, у Файл_ пов_домлень F або P"
              l_err := '2125';
           -- 2122 - код причины отказа
           else
              begin
                 select err_code into l_tmpn from dpa_reject_codes where err_code = l_reason;
              exception when no_data_found then
                 -- Помилка в рекв_зит_ "Код причини в_дмови у взятт_ на обл_к рахунка"
                 l_err := '2122';
              end;
           end if;
        exception when no_data_found then
           -- Помилка рекв_зиту "Найменування файла F або P, у якому була надана _нформац_я про рахунок"
           l_err := '2124';
        end;
     exception when no_data_found then
        -- Ця ф_нансова установа не в_дправляла файл F або P, на який над_слано в_дпов_дь
        l_err := '2126';
     end;

     -- квитовка строк
     if substr(p_filename,1,2) = '@R' then

        update lines_f
           set dat_in_dpa  = l_receive_date,
               dat_acc_dpa = l_sts_date,
               id_pr       = l_reason,
               id_dpa      = l_sts_reg,
               id_dps      = l_sts_rai,
               id_rec      = l_rec_id,
               fn_r        = p_filename,
               date_r      = l_tick_date,
               n_r         = l_tick_n,
               err         = l_err
         where fn  = l_f_name
           and dat > sysdate-30
           and nls = l_account
           and kv  = l_currency
           and otype in (1,6)
           and fn_r like '@F2%';

        -- разблокируем счет
        if l_dpablk is not null and
           -- 0-без помилок
           -- 5-Рахунок вже перебуває на обліку
           l_reason in (0, 5) and
           --  0000-без помилок
           l_err = '0000' then
           --
           bars_audit.info('DPI info ' || l_account || ' - l_account '
                                        || l_currency || ' - l_currency '
                                        || l_dpablk || ' - l_dpablk ' );
           update accounts
              set blkd = 0
            where nls = l_account
              and kv = l_currency
              and dazs is null
              and blkd = l_dpablk
           returning acc, tip, nlsalt into l_acc, l_tip, l_nlsalt; -- COBUMMFO-7501

         -- если біла изменена строка - сохраняем информаци
          if sql%rowcount != 0 then
            bars_audit.info('DPI rowcount' || sql%rowcount || ' l_account - ' ||l_account || 'acc - '  );
          end if;

          -- COBUMMFO-7501 Begin
          -- Блокируем трансформированный счет по дебиту и кредиту
          if l_acc is not null and l_tip like 'OW%' and regexp_like(l_nlsalt, '^26[0,5]5') then
             update accounts a
             set a.blkd = 99
                 , a.blkk = 99
             where acc = l_acc;
          end if;
          -- COBUMMFO-7501 End

           select count(*)
             into l_tmpn
             from w4_acc_instant
            where acc = l_acc and state = 2;

           if l_tmpn > 0 then
             select reqid
               into l_tmpn
               from w4_acc_instant
              where acc = l_acc and state = 2;

              if l_tmpn is not null then
                update cm_client_que t
                   set t.oper_status = 1
                 where t.id = l_tmpn;
              end if;
           end if;
        end if;

     elsif substr(p_filename,1,2) = '@D' then

        update lines_p
           set dat_in_dpa  = l_receive_date,
               dat_acc_dpa = l_sts_date,
               id_pr       = l_reason,
               id_dpa      = l_sts_reg,
               id_dps      = l_sts_rai,
               id_rec      = l_rec_id,
               fn_r        = p_filename,
               date_r      = l_tick_date,
               n_r         = l_tick_n,
               err         = l_err
         where fn  = l_f_name
           and dat > sysdate-30
           and n   = l_f_rec
           and nls = l_account
           and otype in (1,6)
           and fn_r like '@P2%';

     end if;

     -- сохраняем строки
     insert into lines_r (fn, dat, n, mfo, bank_okpo, okpo, rtype, nmkk, odate, nls, kv, resid,
        dat_in_dpa, dat_acc_dpa, id_pr, id_dpa, id_dps, id_rec, fn_f, n_f, err)
     values (p_filename, l_tick_date, l_tick_n, l_bank_mfo, l_bank_okpo,
        l_okpo, l_rtype, l_nmkk, l_odate, l_account, l_currency, l_resid,
        l_receive_date, l_sts_date, l_reason, l_sts_reg, l_sts_rai, l_rec_id,
        l_f_name, l_f_rec, l_err);

  end loop;
  end if;

  p_errcode := l_err_code;

  bars_audit.info(p || 'Finish.');

end iparse_ticket;

-------------------------------------------------------------------------------
-- iparse_ticket1
-- процедура разбора квитанции-1
--
procedure iparse_ticket1 (
  p_filename  in varchar2,
  p_xml       in xmltype,
  p_errcode  out varchar2 )
is

  l_f_name    varchar2(30);    -- Назва файла, що квитується
  l_err_code  varchar2(4);    -- Код помилки за файлом
  l_resp_text varchar2(254);    -- _нформац_йний текст квитанц_ї
  l_tick_date date;

  c_declarbody  varchar2(100) := '/DECLAR/DECLARBODY/';
  l_tmp  varchar2(2000);
  l_tmp2  varchar2(2000);

  p varchar2(100) := 'bars_dpa.iparse_ticket1. ';

begin

  bars_audit.info (p || 'Start. p_filename - ' || p_filename);

  -- declarbody
        l_tmp := extract(p_xml, c_declarbody || 'C_DOC_CRTDATE/text()', null);
        l_tmp2:= extract(p_xml, c_declarbody || 'C_DOC_CRTTIME/text()', null);
  l_tick_date := to_date(substr(l_tmp,1,6) || substr(l_tmp2,1,4), 'yymmddhh24mi');
        l_tmp := extract(p_xml, c_declarbody || 'PROC_FILE_NAME/text()', null);
  l_f_name    := substr(l_tmp,1,30);
        l_tmp := extract(p_xml, c_declarbody || 'PROC_FILE_ERROR_CODE/text()', null);
  l_err_code  := substr(l_tmp,1,4);
        l_tmp := extract(p_xml, c_declarbody || 'RESPONSE_TEXT/text()', null);
  l_resp_text := substr(l_tmp,1,254);

  -- квитовка файла
  update zag_f
     set otm  = 5,
         err  = l_err_code,
         datk = l_tick_date,
         fnk  = p_filename,
         txtk = l_resp_text
   where fn = l_f_name
     and fnk is null
     and dat > sysdate-30;

  -- квитовка строк
  if substr(p_filename,1,2) = '@F' then
     update lines_f
        set err    = l_err_code,
            fn_r   = p_filename,
            date_r = l_tick_date
      where fn = l_f_name
        and dat > sysdate-30
        and fn_r is null;
  elsif substr(p_filename,1,2) = '@P' then
     update lines_p
        set err    = l_err_code,
            fn_r   = p_filename,
            date_r = l_tick_date
      where fn = l_f_name
        and dat > sysdate-30
        and fn_r is null;
  elsif substr(p_filename,1,2) = '@K' then
     update lines_k
        set err    = l_err_code,
            fn_r   = p_filename,
            date_r = l_tick_date
      where fn = l_f_name
        and dat > sysdate-30
        and fn_r is null;
  end if;

  p_errcode := l_err_code;

  bars_audit.info(p || 'Finish.');

end iparse_ticket1;

-------------------------------------------------------------------------------
-- iparse_ticket2
-- процедура разбора квитанции-2
--
procedure iparse_ticket2 (
  p_filename  in varchar2,
  p_xml       in xmltype,
  p_errcode  out varchar2 )
is

  l_tick_date date;        -- Дата створення файла
  l_tick_rec  number;        -- К_льк_сть _нформац_йних рядк_в у файл_
  l_f_name    varchar2(30);    -- Назва файла, що квитується
  l_f_rec     number;        -- К_льк_сть _нформац_йних рядк_в у файл_, що квитується
  l_err_code  varchar2(4);    -- Код помилки за файлом
  l_f_rownum  number;
  l_f_rowerr  varchar2(4);

  c_declarbody  varchar2(100) := '/DECLAR/DECLARBODY/';
  c_row         varchar2(100);
  l_xml         xmltype;
  l_tmp  varchar2(2000);
  l_tmp2 varchar2(2000);
  i number;

  p varchar2(100) := 'bars_dpa.iparse_ticket2. ';

begin

  bars_audit.info(p || 'Start.');

        l_tmp := extract(p_xml, c_declarbody || 'C_DOC_CRTDATE/text()', null);
        l_tmp2:= extract(p_xml, c_declarbody || 'C_DOC_CRTTIME/text()', null);
  l_tick_date := to_date(substr(l_tmp,1,6) || substr(l_tmp2,1,4), 'yymmddhh24mi');
        l_tmp := extract(p_xml, c_declarbody || 'C_DOC_QTREC/text()', null);
  l_tick_rec  := to_number(l_tmp);
        l_tmp := extract(p_xml, c_declarbody || 'PROC_FILE_NAME/text()', null);
  l_f_name    := substr(l_tmp,1,30);
        l_tmp := extract(p_xml, c_declarbody || 'PROC_FILE_QTREC/text()', null);
  l_f_rec     := to_number(l_tmp);
        l_tmp := extract(p_xml, c_declarbody || 'PROC_FILE_ERROR_CODE/text()', null);
  l_err_code  := substr(l_tmp,1,4);

  bars_audit.info(p || 'l_tick_rec(C_DOC_QTREC)=>' || to_char(l_tick_rec) ||
       ' l_f_name(PROC_FILE_NAME)=>' || l_f_name ||
       ' l_f_rec(PROC_FILE_QTREC)=>' || to_char(l_f_rec) ||
       ' l_err_code(PROC_FILE_ERROR_CODE)=>' || l_err_code);

  -- квитовка файла
  update zag_f
     set otm  = 5,
         err  = l_err_code,
         fnk  = p_filename,
         datk = l_tick_date,
         fnk1 = fnk,
         datk1 = datk
   where fn = l_f_name
     and fnk like '@_1%'
     and dat > sysdate-30;

  -- Якщо друга квитанц_я не м_стить _нформац_йних рядк_в,
  --   то значення рекв_зиту "C_DOC_QTREC" дор_внює нулю.
  -- У раз_ неможливост_ прочитання Файла пов_домлень чи Файла-в_дпов_д_
  --   рекв_зити "PROC_FILE_CRTDATE" та "PROC_FILE_QTREC" мають пусте значення.
  if l_tick_rec is null then
     null;
  -- квитовка строк с ошибками
  elsif l_tick_rec > 0 then

     i := 0;

     loop

        -- счетчик строк
        i := i + 1;

        c_row := c_declarbody || 'ROWS[' || i || ']';

        -- выход при отсутствии транзакций
        if p_xml.existsnode(c_row) = 0 then
           exit;
        end if;

        l_xml := xmltype(extract(p_xml,c_row,null));

             l_tmp := extract(l_xml, '/ROWS/ROWNUM_FILE_ISH/text()', null);
        l_f_rownum := to_number(l_tmp);
             l_tmp := extract(l_xml, '/ROWS/ERROR_CODE/text()', null);
        l_f_rowerr := substr(l_tmp,1,4);

        -- квитовка строк
        if substr(p_filename,1,2) = '@F' then
           update lines_f
              set err    = l_f_rowerr,
                  fn_r   = p_filename,
                  date_r = l_tick_date
            where fn = l_f_name
              and dat > sysdate-30
              and n  = l_f_rownum
              and fn_r like '@F1%';
        elsif substr(p_filename,1,2) = '@P' then
           update lines_p
              set err    = l_f_rowerr,
                  fn_r   = p_filename,
                  date_r = l_tick_date
            where fn = l_f_name
              and dat > sysdate-30
              and n  = l_f_rownum
              and fn_r like '@P1%';
        elsif substr(p_filename,1,2) = '@K' then
           update lines_k
              set err    = l_f_rowerr,
                  fn_r   = p_filename,
                  date_r = l_tick_date
            where fn = l_f_name
              and dat > sysdate-30
              and n  = l_f_rownum
              and fn_r like '@K1%';
        end if;

        -- сохраняем строки
        insert into lines_i (fn, dat, n, err)
        values (p_filename, l_tick_date, l_f_rownum, l_f_rowerr);

     end loop;

  end if;

  -- если есть строки с ошибками (они уже сквитованы выше),
  --   для остальных строк ставим квитовку 0000
  if l_tick_rec > 0 then
     l_f_rowerr := '0000';
  -- иначе - для всех строк ставим код ошибки по файлу
  else
     l_f_rowerr := l_err_code;
  end if;

  -- квитовка остальных строк
  if substr(p_filename,1,2) = '@F' then
     update lines_f
        set err    = l_f_rowerr,
            fn_r   = p_filename,
            date_r = l_tick_date
      where fn = l_f_name
        and dat > sysdate-30
        and fn_r like '@F1%';
  elsif substr(p_filename,1,2) = '@P' then
     update lines_p
        set err    = l_f_rowerr,
            fn_r   = p_filename,
            date_r = l_tick_date
      where fn = l_f_name
        and dat > sysdate-30
        and fn_r like '@P1%';
  elsif substr(p_filename,1,2) = '@K' then
     update lines_k
        set err    = l_f_rowerr,
            fn_r   = p_filename,
            date_r = l_tick_date
      where fn = l_f_name
        and dat > sysdate-30
        and fn_r like '@K1%';
  end if;

  p_errcode := l_err_code;

  bars_audit.info(p || 'Finish.');

end iparse_ticket2;

-------------------------------------------------------------------------------
-- import_ticket
-- процедура импорта квитанций @F1/@F2/@R/@D
--
procedure import_ticket (
  p_filename  in varchar2,
  p_errcode  out varchar2 )
is
  l_filetype  varchar2(1);
  l_filedigit varchar2(1);
  l_filek     zag_f.fnk%type;
  l_err       zag_f.err%type;
  l_clob      clob;
  l_xml_full  xmltype;
  l_err_code  varchar2(4) := null;

  p varchar2(100) := 'bars_dpa.import_ticket. ';
begin

  bars_audit.info(p || 'Start. p_filename=>' || p_filename);

      l_filetype  := substr(p_filename,2,1);
  l_filedigit := substr(p_filename,3,1);

  bars_audit.info(p || 'l_filetype=>' || l_filetype || ' l_filedigit=>' || l_filedigit);

  if l_filetype in ('R', 'D') then
     begin
        select fnk into l_filek from zag_f where fn = p_filename and dat > sysdate-30;
        bars_audit.info(p ||'Квитанція вже приймалась!');
        raise_application_error(-20000, 'Квитанція вже приймалась!', true);        
     exception when no_data_found then null;
     end;
  end if;
  bars_audit.info(p ||'point 1');
  begin
     select fnk, err into l_filek, l_err
       from zag_f
      where ( -- для файлов-ответов @R0/@D0
              l_filedigit = '0' and substr(fn,2,1) = decode(substr(p_filename,2,1),'R','F','P')
              -- для файлов-квитанций @F1/@F2
           or l_filedigit in ('1','2') and substr(fn,2,1) = l_filetype
            )
        and substr(fn,2,1) in ('F', 'P', 'K')
        and substr(fn,4) = substr(p_filename,4)
        and dat > sysdate-30;
        bars_audit.info(p ||'point2  select fnk, err into l_filek, l_err');
  exception when no_data_found then
     bars_audit.info(p ||'Квитанція на неіснуючий файл!');
     raise_application_error(-20000, 'Квитанція на неіснуючий файл', true);     
  end;
 bars_audit.info(p ||' l_filedigit='||l_filedigit||', l_filek='||l_filek);
  if l_filedigit = '0' and l_filek is null then
     bars_audit.info(p ||'Квитанція першого типу ще не приймалася!');
     raise_application_error(-20000, 'Квитанція першого типу ще не приймалася!', true);     
  elsif l_filedigit = '0' and substr(l_filek,3,1) = '1' then
     bars_audit.info(p ||'Квитанція другого типу ще не приймалася!');
     raise_application_error(-20000, 'Квитанція другого типу ще не приймалася!', true);
  elsif l_filedigit = '0' and substr(l_filek,3,1) = '0' and l_err = '0000' then
     bars_audit.info(p ||'Файл вже сквитовано!');
     raise_application_error(-20000, 'Файл вже сквитовано!', true);
  elsif l_filedigit = '1' and substr(l_filek,3,1) = '1' and l_err = '0000' then
     bars_audit.info(p ||'Файл вже сквитовано квитанцією першого типу!');
     raise_application_error(-20000, 'Файл вже сквитовано квитанцією першого типу!', true);
  elsif l_filedigit = '1' and substr(l_filek,3,1) = '2' and l_err = '0000' then
     bars_audit.info(p ||'Файл вже сквитовано квитанцією другого типу!');
     raise_application_error(-20000, 'Файл вже сквитовано квитанцією другого типу!', true);
  elsif l_filedigit = '1' and substr(l_filek,3,1) = '0' and l_err = '0000' then
     bars_audit.info(p ||'Файл вже сквитовано!');
     raise_application_error(-20000, 'Файл вже сквитовано!', true);
  elsif l_filedigit = '2' and l_filek is null then
     bars_audit.info(p ||'Квитанція першого типу ще не приймалася!');
     raise_application_error(-20000, 'Квитанція першого типу ще не приймалася!', true);
  elsif l_filedigit = '2' and substr(l_filek,3,1) = '2' and l_err = '0000' then
     bars_audit.info(p ||'Файл вже сквитовано квитанцією другого типу!');
     raise_application_error(-20000, 'Файл вже сквитовано квитанцією другого типу!', true);
  elsif l_filedigit = '2' and substr(l_filek,3,1) = '0' and l_err = '0000' then
     raise_application_error(-20000, 'Файл вже сквитовано!', true);
  end if;
  bars_audit.info(p ||'point 4');

  begin
  select file_data into l_clob from dpa_lob where file_name = p_filename;
  exception when no_data_found then
   bars_audit.info(p ||'Файл для id= '|| to_char(user_id) || ' не знайдено!');
   raise_application_error(-20000, 'Файл для id= '|| to_char(user_id) || ' не знайдено!', true);
  end;

  l_xml_full := xmltype(l_clob);
  bars_audit.info(p ||'point 1');
  -- Файл-в_дпов_дь R / Файл-в_дпов_дь D
  if substr(p_filename,3,1) = '0' then
     iparse_ticket(p_filename, l_xml_full, l_err_code);
      bars_audit.info(p ||'iparse_ticket');
  -- Квитанц_я про одержання файла (перша квитанц_я)
  elsif substr(p_filename,3,1) = '1' then
     bars_audit.info(p ||'iparse_ticket1 start');
     iparse_ticket1(p_filename, l_xml_full, l_err_code);
     bars_audit.info(p ||'iparse_ticket1 end');
  -- Квитанц_я про прийняття файла (друга квитанц_я)
  elsif substr(p_filename,3,1) = '2' then
     iparse_ticket2(p_filename, l_xml_full, l_err_code);
     bars_audit.info(p ||'iparse_ticket2');
  end if;

  p_errcode := l_err_code;
  bars_audit.info(p ||p_errcode);

  bars_audit.info(p || 'Finish.');

exception when others then
  if ( sqlcode = -19202 or sqlcode = -31011 ) then
     p_errcode := '-1';
  else raise_application_error(-20000, sqlerrm, true);
  end if;
end import_ticket;

-------------------------------------------------------------------------------
-- check_files
-- процедура автоматического контроля файлов
-- для разблокировки счетов. отправленных в ДПА
--
procedure check_files (p_mode number)
is
  l_dpablk number;
  l_tmpn number;
  l_acc number;
begin

  l_dpablk := to_number(getglobaloption('DPA_BLK'));

  -- проверка по файлам, отправленным вчера в ДПА, на которые не пришла квитанция @R
  for z in ( select f.fn, f.dat, f.datk, l.nls, l.kv, a.acc, a.blkd, a.dazs
               from zag_f f, lines_f l, accounts a
              where f.fn like '@F%'
                 -- файлы, сфлрмированные вчера
                and trunc(f.dat) = dat_next_u(bankdate, -1)
                 -- на файл есть квитанция @F2
                and f.fnk like '@F2%'
                 -- без ощибок
                and f.err = '0000'
                and f.fn = l.fn
                and f.dat = l.dat
                 -- по открытым счетам
                and l.otype in (1, 6)
                 -- есть квитанция @F2
                and l.fn_r like '@F2%'
                 -- без ошибки
                and l.err = '0000'
                and l.nls = a.nls
                and l.kv  = a.kv
                and l.mfo = a.kf )
  loop
     -- ставим отметку о взятии на учет в ДПА
     update lines_f
        set dat_in_dpa  = trunc(z.datk),
            dat_acc_dpa = trunc(z.datk),
            id_pr       = 0
      where fn  = z.fn
        and dat = z.dat
        and nls = z.nls
        and kv  = z.kv
        and otype in (1,6)
        and fn_r like '@F2%';

     -- разблокируем счет
     if l_dpablk is not null and
        z.blkd = l_dpablk and
        z.dazs is null then
        update accounts
           set blkd = 0
         where acc = z.acc
        returning acc into l_acc;

        -- Отправим заявку на СМ по карточному счету после снятия блокировки
        select count(*)
          into l_tmpn
          from w4_acc_instant
         where acc = l_acc and state = 2;

        if l_tmpn > 0 then
           select reqid
            into l_tmpn
            from w4_acc_instant
           where acc = l_acc and state = 2;

           if l_tmpn is not null then
              update cm_client_que t
                 set t.oper_status = 1
               where t.id = l_tmpn;
           end if;
        end if;

      end if;
  end loop;

end check_files;

-------------------------------------------------------------------------------
-- insert_to_temp
-- вставка во временную таблицу информации для @F фала
procedure insert_data_to_temp(p_mfo varchar2, p_okpo varchar2, p_rp number, p_ot varchar2, p_odat date,
                              p_nls varchar2, p_kv number, p_c_ag number , p_nmk varchar2,
                              p_adr varchar2, p_c_reg varchar2, p_c_dst varchar2, p_bic varchar2, p_country number)
is
begin
 bars_audit.info('insert_data_to_temp starts');

     if LENGTH(p_nmk) > 38 then
        raise_application_error(-20000, 'Длина имени клиента должна быть в рамках 38-х символов');
     end if;

     insert into dpa_acc_userid (mfo, okpo, rt, ot, odat, nls, kv, c_ag, nmk, adr, c_reg, c_dst, bic, country, userid)
     values(p_mfo, p_okpo, p_rp, p_ot, p_odat, p_nls, p_kv, p_c_ag, p_nmk, p_adr, p_c_reg, p_c_dst, p_bic, p_country, user_id);

 bars_audit.info('insert_data_to_temp finised');
end insert_data_to_temp;

-------------------------------------------------------------------------------
-- insert_to_temp
-- вставка во временную таблицу информации для @K фала
procedure insert_data_to_temp(p_bic varchar2, p_nmk varchar2,p_ot varchar2, p_odat date, p_nls varchar2,p_kv number, p_c_ag number, p_country number, p_c_reg varchar2,p_okpo varchar2)
is
begin
 bars_audit.info('insert_data_to_temp_k starts');
     insert into dpa_acc_userid (bic, nmk, ot, odat, nls, kv, c_ag, country, c_reg, okpo, userid)
     values(p_bic, p_nmk, p_ot, p_odat, p_nls, p_kv, p_c_ag, p_country, p_c_reg, p_okpo, user_id);

 bars_audit.info('insert_data_to_temp_k finised');
end insert_data_to_temp;

-------------------------------------------------------------------------------
-- insert_cvk_data_to_temp
-- вставка во временную таблицу информации для фалов CVK
procedure insert_data_to_temp(p_ref number)
is
begin

     insert into dpa_acc_userid (ref, userid)
     values(p_ref, user_id);
end insert_data_to_temp;

-------------------------------------------------------------------------------
-- get_cvk_file_cont
-- Получить количество сформированных файлов ЦВК по типу файла
function get_cvk_file_count(p_filetype varchar2) return number
is
   l_cnt number;
begin
   select count(*) into l_cnt from dpa_lob;
   return l_cnt;
end;


-------------------------------------------------------------------------------
-- form_cvk_file
-- сформировать файлы и поместить во временное хранилище dpa_lob
-- в переменную p_file_count вернуть кол-во файлов

procedure form_cvk_file(p_filetype varchar2, p_filedate date, p_file_count out number)
is
   l_clob clob;
   l_file_line   varchar2(32000);
   l_file_name   varchar2(50);
   l_file_num    number;
   l_nl          varchar2(2) := chr(13)||chr(10);
   l_header_info varchar2(32000);
   l_system_info varchar2(32000);
   i  number := 0;
   l_lines_count number;
   l_trace   varchar2(1000) := 'get_cvk_file';

begin
   bars_audit.info(l_trace||'старт формирования файлов');
   delete from dpa_lob where userid = user_id;

   if p_filetype = 'CA'  then

         for c in (


         select  row_number() over (order by nls) rown,
                            count(*)     over()  cnt,
                            MFO,   NB,   NLS,   DAOS,   VID,   TVO,   NAME_BLOK as name_block,   FIO_BLOK as fio_block,
                            FIO_ISP,   INF_ISP,   ADDR,   OKPO
                      from  v_cvk_ca
                   ) loop

          --првая запись
          if c.rown = 1 then
             bars_audit.info(l_trace||'старт формирования файла');
             l_file_name   := get_file_name(p_filetype, l_file_num);
             l_system_info  := lpad(' ', 100) || l_nl;
             l_header_info :=  substr(l_file_name,1,12)||to_char(sysdate,'yymmddhhmi')||lpadchr(c.cnt, '0', 6)||lpadchr('',' ', 166)||l_nl;
             bars_audit.info(l_trace||'сформировано имя файла '||l_file_name);
             -- вставка записи в заголовок
             insert into zag_tb(fn, dat, n) values(l_file_name, sysdate,c.cnt);
             dbms_lob.createtemporary(l_clob,FALSE);
             dbms_lob.append(l_clob, l_system_info||l_header_info);
          end if;

          l_file_line := rpad (c.nb, 38)||
                         lpad (c.mfo, 9)||
                         rpad (c.addr, 250)||
                         rpad (c.vid, 1)||
                         lpad (c.nls, 14)||
                         lpad (c.tvo, 3)||
                         to_char(c.daos, 'yymmdd')||
                         rpad (c.name_block, 38)||
                         lpad (c.okpo, 10)||
                         rpad (c.fio_block, 76)||
                         rpad (c.inf_isp, 38)||l_nl;

           dbms_lob.append(l_clob, l_file_line);
           bars_audit.info(l_trace||'строка:'||l_file_line);
         end loop;


        insert into dpa_lob(file_data, file_name, userid) values(l_clob, l_file_name, user_id);
        bars_audit.trace(l_trace||'вставлен файл размером :'||dbms_lob.getlength(l_clob));
        p_file_count := 1;

   else

      for c in (
                 select count(v.nls) over (partition by decode(vid, 13, '1', 14, '2', '3') ) cnt_vid,
                        row_number() over (partition by decode(vid, 13, '1', 14, '2', '3') order by v.nls ) vid_rank,
                        v.nls, decode(vid, 13, '1', 14, '2', '3') vid, fdat, mfo_d as mfoa, nls_d as nlsa, mfo_k as mfob, nls_k as nlsb,
                        dk, s, vob, nd,
                        v.kv, datd, datp, nam_a, nam_b, nazn, d_rec, naznk, nazns, id_d as id_a, id_k as id_b, v.ref, dat_a, dat_b
                   from v_dpa_cv v
                         --,
                         --( select ref from dpa_acc_userid d where userid = user_id) d
                  where
                  --d.ref = v.opldok_ref
                     --and
                     v.fdat = p_filedate
                  order     by vid, nls
               ) loop



          --новый вид счета, делаем новый файл
          if c.vid_rank = 1 then
             bars_audit.info(l_trace||'старт формирования файлов для группы '||c.vid);
             l_file_name   := replace(get_file_name(p_filetype, l_file_num),'*',c.vid);
             l_system_info  := lpad(' ', 100) || l_nl;
             l_header_info :=  substr(l_file_name,1,12)||to_char(sysdate,'yymmddhhmi')||lpadchr(c.cnt_vid, '0', 6)||lpadchr('',' ', 166)||l_nl;
             bars_audit.info(l_trace||'сформировано имя файла '||l_file_name);
             -- вставка записи в заголовок
             insert into zag_tb(fn, dat, n) values(l_file_name, sysdate,c.cnt_vid );

             -- если клоб наполнен предыдущим файлом
             --    if dbms_lob.isopen(l_clob) = 1 and dbms_lob.getlength(l_clob) > 0 then
             --       dbms_lob.close(l_clob);
             --    end if;

             -- кол-во файлов
             i := i+1;

             dbms_lob.createtemporary(l_clob,FALSE);
             dbms_lob.append(l_clob, l_system_info||l_header_info);
          end if;

          l_file_line :=  lpad(c.mfoa, 9) || lpad(c.nlsa,14) ||
                          lpad(c.mfob, 9) || lpad(c.nlsb,14) ||
                          to_char(c.dk)||
                          lpad(c.s,16) ||
                          lpad(c.vob, 2)||
                          rpad(c.nd,10) ||
                          lpad(c.kv, 3) ||
                          to_char(c.datd, 'yyMMdd') ||
                          to_char(c.datp, 'yyMMdd') ||
                          rpad(c.nam_a,38) ||
                          rpad(c.nam_b,38) ||
                          rpad(c.nazn,160)||
                          rpad(c.d_rec,60) ||
                          rpad(c.naznk,3) ||
                          rpad(c.nazns,2) ||
                          rpad(c.id_a,14)||
                          rpad(c.id_b,14)||
                          substr(lpad(c.ref,9),-9) ||
                          to_char(c.dat_a, 'yyMMdd') ||
                          to_char(c.dat_b, 'yyMMdd') || l_nl;
                      l_lines_count := l_lines_count + 1;
           dbms_lob.append(l_clob, l_file_line);


          --прочитали последню строку для данного вида счета
          if c.vid_rank = c.cnt_vid then
             insert into dpa_lob(file_data, file_name, userid) values(l_clob, l_file_name, user_id);
             l_lines_count := 0;
          end if;

         end loop;

         --if dbms_lob.isopen(l_clob) = 1 then dbms_lob.close(l_clob); end if;

         p_file_count := i;
         bars_audit.info(l_trace||'на выходе процедуры возвращаем кол-во файлов::'||p_file_count);


    end if;

end;


-------------------------------------------------------------------------------
-- get_cvk_file
-- Получить количество сформированных файлов ЦВК по типу файла
function get_cvk_file(p_filetype varchar2, p_file_number number, p_filename out varchar2) return clob
is
   l_clob clob;
begin
   select file_data, file_name into l_clob,  p_filename from dpa_lob where id = p_file_number and userid = user_id;
   return l_clob;
end;

procedure del_f_row(p_idrow varchar2)
is
begin
  begin
   delete ree_tmp where rowid = p_idrow;
   commit;
  exception when others then raise_application_error(-20000, 'Не вдалося видалити строку!' || substr(sqlerrm,1,400), true);
  end;
end;

procedure ins_ticket(p_filename varchar2, p_filedata clob)
is
 p varchar2(100) := 'bars_dpa.';
begin
 bars_audit.info(p|| 'ins_ticket start with parameters: p_filename = '||p_filename||', p_filedata='||p_filedata );
 delete dpa_lob where file_name = p_filename;
 begin
  insert into dpa_lob (file_data, file_name, userid)
       values (p_filedata, p_filename, user_id);
 exception when dup_val_on_index then raise_application_error(-20000, 'Не вдалося імпортувати файл! (Повторний прийом?)', true);
 end;
 bars_audit.info(p|| 'ins_ticket finished with mess:' ||sqlcode);
end;

procedure ins_r0(p_filename varchar2, p_filedata clob, p_tickname OUT varchar2)
is
 p varchar2(100) := 'bars_dpa.';
 l_filename  varchar2(100);
 p_ErrCode varchar2(500);
begin
 bars_audit.info(p|| 'ins_ticket start with parameters: p_filename = '||p_filename||', p_filedata='||substrb(p_filedata, 1, 4000) );
 -- проверка, не принимался ли файл ранее
 begin
 select max(fn)
   into l_filename
   from zag_f
  where
     substr(fn,1) = substr(p_filename,1)
    /*

    || 2017_06_14
    || изменено условие отбора файла с substr(fn,4) на substr(fn,2)
    || 2017_09_13
    || изменено условие отбора файла с substr(fn,4) на substr(fn,1)
    || т.к. при поиске файла (біл он загружен ранее или нет) мог уже отбраться
    || файл @F, хотя должен біл біть загружен файл @R
    -- оригинальное условие substr(fn,4) = substr(p_filename,4)

    */
    and dat > sysdate-364;
 exception when no_data_found then null;
 end;
 bars_audit.info(p||'l_filename = '|| l_filename);
 if nvl(l_filename,'') != ''
 then
  raise_application_error(-20000, 'Не вдалося імпортувати файл! (Повторний прийом ' ||p_filename||')', true);
  return;
 else
     delete dpa_lob where file_name = p_filename;
     begin
      insert into dpa_lob (file_data, file_name, userid)
           values (p_filedata, p_filename, user_id);
     exception when dup_val_on_index then raise_application_error(-20000, 'Не вдалося імпортувати файл! (Повторний прийом?)', true);
     end;

     begin
      import_ticket(p_filename, p_ErrCode);
      
     exception when others then 
         bars_audit.error( p || ': ' || p_ErrCode || chr(10)|| dbms_utility.format_error_stack() );
         raise_application_error(-20000, p_ErrCode || chr(10)|| dbms_utility.format_error_stack() , true);
     end;
     bars_audit.info(p||'p_ErrCode = '|| p_ErrCode);
     if (p_ErrCode = -1)
     then
      form_ticket (p_filename, '2103', p_tickname);
     else
      form_ticket (p_filename, '0000', p_tickname);
     end if;


 end if;
 bars_audit.info(p|| 'ins_ticket finished with mess:' ||sqlcode);
end;

    -- процедура на для отправки данных в дпа по нотариусам COBUMMFO-4028
     -- в дополнению триггеру tai_accounts_tax. не вставленно в триггер т.к. какая-то процедура затирает параметр ob22
    PROCEDURE accounts_tax(p_acc     accounts.acc%TYPE
                          ,p_daos    accounts.daos%TYPE
                          ,p_dazs    accounts.dazs%TYPE
                          ,p_kv      accounts.kv%TYPE
                          ,p_nbs     accounts.nbs%TYPE
                          ,p_nls     accounts.nls%TYPE
                          ,p_ob22    accounts.ob22%TYPE
                          ,p_pos     accounts.pos%TYPE
                          ,p_vid     accounts.vid%TYPE
                          ,p_rnk     accounts.rnk%TYPE
                          )
    IS
       nbs_             VARCHAR2(4);
       mfo_             VARCHAR2(12);
       okpo_            VARCHAR2(14);
       tgr_             NUMBER(1);
       bank_date        DATE;
       acct_open_date   DATE;
       nls_             VARCHAR2(15);
       pos_             NUMBER(1);
       kv_              NUMBER;
       rez_in           NUMBER;
       rez_out          NUMBER;
       nmk_             VARCHAR2(38);
       creg_            NUMBER(38);
       cdst_            NUMBER(38);
       ot_              NUMBER;
       acc_             NUMBER;
       l_adr            customer.adr%TYPE;
       l_custtype       customer.custtype%TYPE;
       l_passp          VARCHAR2(14);
       l_notarius       NUMBER;
    BEGIN
       -- Account already closed, do nothing
       IF p_dazs IS NOT NULL THEN
          RETURN;
       END IF;

       -- Account type don't interest Tax Police, do nothing...
       IF p_vid = 0
       OR p_vid IS NULL THEN
          RETURN;
       END IF;

       -- если счёт отностися к ДПА, то продолжам с ним работать
       IF  bars_dpa.dpa_nbs(p_nbs, p_ob22) = 1 THEN
         NULL;
       ELSE
         RETURN;
       END IF;

       bank_date       := COALESCE(NVL(gl.bd, glb_bankdate), TRUNC(SYSDATE));
       mfo_            := gl.amfo;
       nls_            := p_nls;
       pos_            := p_pos;
       kv_             := p_kv;
       acc_            := p_acc;
       ot_             := 1;
       acct_open_date  := p_daos;

       -- данные клиента
       SELECT okpo
             ,tgr
             ,NVL(nmkk, SUBSTR(nmk, 1, 38))
             ,c_reg
             ,c_dst
             ,codcagent
             ,adr
             ,custtype
         INTO okpo_
             ,tgr_
             ,nmk_
             ,creg_
             ,cdst_
             ,rez_in
             ,l_adr
             ,l_custtype
         FROM customer
        WHERE rnk = p_rnk;

       -- резидентность
       SELECT rezid
         INTO rez_out
         FROM codcagent
        WHERE codcagent = rez_in;

       -- для религиозных берутся данные паспорта
       IF l_custtype = 3
      AND SUBSTR(okpo_, 1, 5) IN ('99999', '00000') THEN
          BEGIN
             SELECT case 
                      when passp in (1) 
                        then 
                          SUBSTR(TRIM(ser) || TRIM(numdoc), 1, 14) 
                        else 
                          SUBSTR(TRIM(numdoc), 1, 14) 
                      end
               INTO l_passp
               FROM person
              WHERE rnk = p_rnk
                AND passp in (1,7);
          EXCEPTION
             WHEN NO_DATA_FOUND THEN
                l_passp  := NULL;
          END;

          IF l_passp IS NULL THEN
             RETURN;
          ELSE
             okpo_  := l_passp;
             tgr_   := 4;
          -- tgr = 4 - сер_я та номер паспорта ф_зичної особи, яка через свої
          -- рел_г_йн_ переконання в_дмовилась в_д прийняття реєстрац_йного
          -- номера обл_кової картки платника податк_в та пов_домила про це
          -- в_дпов_дний орган ДПС _ має в_дм_тку у паспорт_
          END IF;
       END IF;

       INSERT INTO ree_tmp(mfo
                          ,id_a
                          ,rt
                          ,ot
                          ,nls
                          ,odat
                          ,kv
                          ,c_ag
                          ,nmk
                          ,nmkw
                          ,c_reg
                          ,c_dst
                          ,prz)
            VALUES (mfo_
                   ,okpo_
                   ,tgr_
                   ,ot_
                   ,nls_
                   ,NVL(acct_open_date, TRUNC(SYSDATE))
                   ,kv_
                   ,rez_out
                   ,nmk_
                   ,nmk_
                   ,creg_
                   ,cdst_
                   ,pos_);
        -- установим блокировку счёта
      IF SQL%rowcount > 0 THEN
        UPDATE accounts a
           SET a.blkd = nvl(trim(getglobaloption('DPA_BLK')), 0)
         WHERE a.acc = p_acc;
      END IF;
    EXCEPTION
       WHEN NO_DATA_FOUND THEN
          RETURN;
    END accounts_tax;

  -- функция определения относится относится ли балансовый к счетам на отправку в налоговую
  -- параметр p_ob22 необходим чтобы для счетов 2620 с ob22 in (07,32) отправлять в налоговую COBUMMFO-5343
  FUNCTION dpa_nbs(p_nbs  varchar2 --DPA_NBS.NBS%TYPE
                  ,p_ob22 accounts.OB22%TYPE DEFAULT NULL) RETURN NUMBER IS
    l_dpa NUMBER;
  BEGIN
    l_dpa := 0; -- 0 - не относится к счетам ДПА, 1 - относится

    IF p_nbs = '2620' AND p_ob22 IN ('07'
                                    ,'32') THEN
      l_dpa := 1;
    ELSE
      BEGIN
        SELECT UNIQUE 1
          INTO l_dpa
          FROM dpa_nbs
         WHERE TYPE IN ('DPA'
                       ,'DPK'
                       ,'DPP')
           AND nbs = p_nbs;
      EXCEPTION
        WHEN no_data_found THEN
          l_dpa := 0;
      END;
    END IF;
    RETURN l_dpa;
  END dpa_nbs;

end bars_dpa;
/
 show err;
 
PROMPT *** Create  grants  BARS_DPA ***
grant EXECUTE                                                                on BARS_DPA        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_DPA        to RPBN002;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_dpa.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 
