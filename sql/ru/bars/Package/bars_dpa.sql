
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_dpa.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_DPA is

g_head_version constant varchar2(64)  := 'Version 1.1 02/11/2015';
g_head_defs    constant varchar2(512) := '';

/** header_version - ���������� ������ ��������� ������ */
function header_version return varchar2;

/** body_version - ���������� ������ ���� ������ */
function body_version return varchar2;

-------------------------------------------------------------------------------
-- form_file
--
procedure form_file (
  p_filetype  in varchar2,
  p_filename out varchar2 );

-------------------------------------------------------------------------------
-- form_ticket
-- ��������� ������������ ��������� �� ����� @R/@D
--
procedure form_ticket (
  p_filename  in varchar2,
  p_fileerr   in varchar2,
  p_tickname out varchar2 );

-------------------------------------------------------------------------------
-- import_ticket
-- ��������� ������� ��������� @R/@D
--
procedure import_ticket (
  p_filename  in varchar2,
  p_errcode  out varchar2 );

-------------------------------------------------------------------------------
-- check_files
-- ��������� ��������������� �������� ������
-- ��� ������������� ������. ������������ � ���
--
procedure check_files (p_mode number);

    -- ��������� �� ��� �������� ������ � ��� �� ���������� COBUMMFO-4028
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

g_body_version constant varchar2(64)  := 'Version 1.20 02/11/2015';
g_body_defs    constant varchar2(512) := '';

g_modcode      constant varchar2(3)   := 'DPA';

/** header_version - ���������� ������ ��������� ������ */
function header_version return varchar2 is
begin
  return 'Package header bars_dpa ' || g_head_version || chr(10) ||
         'AWK definition: ' || chr(10) || g_head_defs;
end header_version;

/** body_version - ���������� ������ ���� ������ */
function body_version return varchar2 is
begin
  return 'Package body bars_dpa ' || g_body_version ||  chr(10) ||
         'AWK definition: ' || chr(10) || g_body_defs;
end body_version;

-------------------------------------------------------------------------------
-- EXTRACT()
--
--   ������c�� �������� �������� �� XPath
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
  i number;
  p varchar2(100) := 'bars_dpa.get_file_name. ';
begin

  bars_audit.info(p || 'Start.');

  l_dps := getglobaloption('DPA_REG');
  if l_dps is null then
     raise_application_error(-20000, '�� ������� ��� ������ ��� ������������ ����!', true);
  end if;
  begin
     select 1 into i from spr_obl where to_char(c_reg) = l_dps;
  exception when no_data_found then
     raise_application_error(-20000, '������� ��������� ��� ������ ��� ������������ ����!', true);
  end;

  begin
     select decode(p_filetype,
              'F', taxf_date,
              'P', taxp_date,
              'K', taxk_date, null) file_date,
            decode(p_filetype,
              'F', taxf_seq,
              'P', taxp_seq,
              'K', taxk_seq, 0) file_num,
            nvl(decode(p_filetype,
              'F', taxf_seq_default,
              'P', taxp_seq_default,
              'K', taxk_seq_default, 0),0) file_numdef
       into l_filedate, l_filenum, l_filenumdef
       from dpa_file_counters;
  exception when no_data_found then
     l_filedate   := null;
     l_filenum    := null;
     l_filenumdef := null;
  end;

  if l_filenum is null or trunc(l_filedate) <> trunc(sysdate) then
     l_filenum := l_filenumdef;
  end if;

  l_filenum := l_filenum + 1;

  -- @�TDxC�����Rxx�����MDnnn.XML, ��:
  -- @ - ������ ������������_ ����� �� ����_� ���_�� �_��������� ���� �_�������/�������� ������_� �_� ��� ������ �� �_��������� ����������;
  -- � - �����_�������� �_���� �����;
  -- � - �����, �� ������� ������_��� ����� �� ����_� ���_������� �� ����_�-�_����_��� ��� �������_�: 0 - ���� ���_������� ��� ����-�_����_��, 1 - �������_� ��� ��������� (����� �������_�) ����� ���_�������, 2 - �������_� ��� ��������� �� ���������� (����� �������_�) ����� ���_������� ��� �����-�_����_�_;
  -- Dx - ��� ������ ��� ���_��������� �_��� �� �_���� ������������ �_������� �������� (������������ ��_�� ������ �� 2 ������_�) ��_��� � ���_���� ��� ������ �_������� �������� �� ���_� � �����_ ���;
  -- C����� - ��� �_������� ��������, � ���/�� ��� ����������� ���� (������������ ��_�� ������ �� 6 ������_�). ��� ����_������ ������� �� ������� �������� ������������ ������ ������ ����������� ��� �����, ��� ������_������ �_�������� ������� - ��� �_������� ��������;
  -- Rxx����� - ��� �� ������ �_������� ��������, � ���/�� ��� ����������� ���� (������������ ��_�� ������ �� 8 ������_�);
  -- MD - ���� ���������� ����� (�_����, ���� � 36-������_� ������_ ��������);
  -- nnn - ���������� ����� ����� �������� ���. �������_� � 36-������_� ������_ ��������.
  l_filename := upper('@' || p_filetype || '0' ||
     lpad(l_dps,2,'0') ||
     lpad(f_ourmfo,6,'0') ||
     lpad(f_ourokpo,8,'0') ||
     f_chr36(extract(month from sysdate)) ||
     f_chr36(extract(day from sysdate)) ||
     lpad(f_conv36(l_filenum),3,'0') || '.XML');

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

  for v in ( select * from dpa_acc )
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

  for v in ( select * from dpa_acc )
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

  for v in ( select * from dpa_acc )
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
begin

  bars_audit.info(p || 'Start.');
  bars_audit.trace(p || 'p_filetype => ' || p_filetype);

  delete from dpa_lob;

  -- FileName
  l_file_name := get_file_name(p_filetype, l_file_num);
  bars_audit.trace(p || 'File name formed');

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
     raise_application_error(-20000, '���?����� ��� ����� ' || p_filetype, true);
  end if;
  bars_audit.trace(p || 'File body formed. l_count=>' || to_char(l_count));

  if l_count = 0 then

     delete from zag_f where fn = l_file_name and dat = l_file_date;
     l_file_name := null;

  else

     update zag_f set n = l_count where fn = l_file_name and dat = l_file_date;

     if p_filetype = 'F' then
        l_xml_schema := 'DPI20101.XSD';
        update dpa_file_counters
           set taxf_date =  trunc(l_file_date),
               taxf_seq  = l_file_num;
     elsif p_filetype = 'P' then
        l_xml_schema := 'DPI20201.XSD';
        update dpa_file_counters
           set taxp_date =  trunc(l_file_date),
               taxp_seq  = l_file_num;
     elsif p_filetype = 'K' then
        l_xml_schema := 'DPI20301.XSD';
        update dpa_file_counters
           set taxk_date =  trunc(l_file_date),
               taxk_seq  = l_file_num;
     end if;

     -- ���������� ����� ������
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

     insert into dpa_lob (id, file_data)
     values (1, l_clob_data);

  end if;

  l_file_header := null;
  l_file_body   := null;
  l_xml_data    := null;

  p_filename := l_file_name;

  bars_audit.info(p || 'Finish.');

end form_file;

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

  bars_audit.info(p || 'Start.');

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
-- ��������� ������������ ��������� �� ����� @R/@D
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

  bars_audit.info(p || 'Start.');

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
  bars_audit.trace(p || 'File header formed');

  -- FileBody
  l_file_body := get_tick_body(p_filename, l_rows);
  bars_audit.trace(p || 'File body formed.');

  -- ���������� ����� ������
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

  insert into dpa_lob (id, file_data)
  values (1, l_clob_data);

  l_file_header := null;
  l_file_body   := null;
  l_xml_data    := null;

  p_tickname := l_tick_name;

  bars_audit.info(p || 'Finish.');

end form_ticket;

-------------------------------------------------------------------------------
-- iparse_ticket
-- ��������� ������� ���������
--
procedure iparse_ticket (
  p_filename  in varchar2,
  p_xml       in xmltype,
  p_errcode  out varchar2 )
is

  l_tick_name  zag_f.fn%type;   -- ����� �����
  l_tick_date  zag_f.dat%type;    -- ���� ��������� �����
  l_tick_rec   zag_f.n%type;    -- �_���_��� _�������_���� ����_� � ����_

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
  l_receive_date lines_r.dat_in_dpa%type; -- ���� ��������� ��� ������ ���_��������
  l_sts_date     lines_r.dat_acc_dpa%type;  -- ���� ������ ������� �� ���_� � �����_ ���
  l_reason       lines_r.id_pr%type;    -- ��� ������� �_����� � �����_ �� ���_� �������
  l_sts_reg      lines_r.id_dpa%type;   -- ��� ������ ��� ���_��������� �_���
  l_sts_rai      lines_r.id_dps%type;   -- ��� ������ ��� ��������� �_���
  l_rec_id       lines_r.id_rec%type;   -- _������_����� ������
  l_f_name       lines_r.fn_f%type;   -- ����� �����, �� ���������
  l_f_rec        lines_r.n_f%type;    -- �_���_��� _�������_���� ����_� � ����_, �� ���������

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

begin

  bars_audit.info(p || 'Start.');

        l_tmp := extract(p_xml, c_declarbody || 'C_DOC_FNAME/text()', null);
  l_tick_name := upper(l_tmp);
        l_tmp := extract(p_xml, c_declarbody || 'C_DOC_CRTDATE/text()', null);
        l_tmp2:= extract(p_xml, c_declarbody || 'C_DOC_CRTTIME/text()', null);
  l_tick_date := to_date(substr(l_tmp,1,6) || substr(l_tmp2,1,4), 'yymmddhh24mi');
        l_tmp := extract(p_xml, c_declarbody || 'C_DOC_QTREC/text()', null);
  l_tick_rec  := to_number(l_tmp);

  if p_filename <> l_tick_name then
     -- _�`� � ��������� �� �_����_�� ������������ �����
     l_err_code := '2105';
  else
     l_err_code := '0000';
  end if;

  -- ��������� ���������� � �����
  insert into zag_f (fn, dat, n, otm, datk, err)
  values (p_filename, l_tick_date, l_tick_rec, null, sysdate, l_err_code);

  if l_err_code = '0000' then

  l_dpablk := to_number(getglobaloption('DPA_BLK'));

  i := 0;

  loop

     -- ������� �����
     i := i + 1;

     c_row := c_declarbody || 'ROWS[' || i || ']';

     -- ����� ��� ���������� ����������
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
     l_reason       := to_number(l_tmp);
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

     -- ��� ������
     l_err := '0000';

     -- ��������
     begin
        -- 2126 - ��� ����� @F
        select fn into l_tmp from zag_f where fn = l_f_name and dat > sysdate-30;
        begin
           -- 2124 - ��� ����� @F ��� ������� �����
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
           -- 2125 - ����� ������ � ����� @F
           if l_f_rec <> l_tmpn then
              -- ������� � ����_���_ "���������� ����� ���_��������, �� ��� �������� �_����_��, � ����_ ���_������� F ��� P"
              l_err := '2125';
           -- 2122 - ��� ������� ������
           else
              begin
                 select err_code into l_tmpn from dpa_reject_codes where err_code = l_reason;
              exception when no_data_found then
                 -- ������� � ����_���_ "��� ������� �_����� � �����_ �� ���_� �������"
                 l_err := '2122';
              end;
           end if;
        exception when no_data_found then
           -- ������� ����_���� "������������ ����� F ��� P, � ����� ���� ������ _�������_� ��� �������"
           l_err := '2124';
        end;
     exception when no_data_found then
        -- �� �_������� �������� �� �_��������� ���� F ��� P, �� ���� ���_����� �_����_��
        l_err := '2126';
     end;

     -- �������� �����
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

        -- ������������ ����
        if l_dpablk is not null and
           -- 0-��� �������
           -- 5-������� ��� �������� �� �����
           l_reason in (0, 5) and
           --  0000-��� �������
           l_err = '0000' then
           update accounts
              set blkd = 0
            where nls = l_account
              and kv = l_currency
              and dazs is null
              and blkd = l_dpablk
           returning acc into l_acc;
           
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

     -- ��������� ������
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
-- ��������� ������� ���������-1
--
procedure iparse_ticket1 (
  p_filename  in varchar2,
  p_xml       in xmltype,
  p_errcode  out varchar2 )
is

  l_f_name    varchar2(30); -- ����� �����, �� ���������
  l_err_code  varchar2(4);  -- ��� ������� �� ������
  l_resp_text varchar2(254);  -- _�������_���� ����� �������_�

  c_declarbody  varchar2(100) := '/DECLAR/DECLARBODY/';
  l_tmp  varchar2(2000);

  p varchar2(100) := 'bars_dpa.iparse_ticket1. ';

begin

  bars_audit.info(p || 'Start.');

  -- declarbody
        l_tmp := extract(p_xml, c_declarbody || 'PROC_FILE_NAME/text()', null);
  l_f_name    := substr(l_tmp,1,30);
        l_tmp := extract(p_xml, c_declarbody || 'PROC_FILE_ERROR_CODE/text()', null);
  l_err_code  := substr(l_tmp,1,4);
        l_tmp := extract(p_xml, c_declarbody || 'RESPONSE_TEXT/text()', null);
  l_resp_text := substr(l_tmp,1,254);

  -- �������� �����
  update zag_f
     set otm  = 5,
         err  = l_err_code,
         datk = sysdate,
         fnk  = p_filename,
         txtk = l_resp_text
   where fn = l_f_name
     and fnk is null
     and dat > sysdate-30;

  -- �������� �����
  if substr(p_filename,1,2) = '@F' then
     update lines_f
        set err    = l_err_code,
            fn_r   = p_filename,
            date_r = sysdate
      where fn = l_f_name
        and dat > sysdate-30
        and fn_r is null;
  elsif substr(p_filename,1,2) = '@P' then
     update lines_p
        set err    = l_err_code,
            fn_r   = p_filename,
            date_r = sysdate
      where fn = l_f_name
        and dat > sysdate-30
        and fn_r is null;
  elsif substr(p_filename,1,2) = '@K' then
     update lines_k
        set err    = l_err_code,
            fn_r   = p_filename,
            date_r = sysdate
      where fn = l_f_name
        and dat > sysdate-30
        and fn_r is null;
  end if;

  p_errcode := l_err_code;

  bars_audit.info(p || 'Finish.');

end iparse_ticket1;

-------------------------------------------------------------------------------
-- iparse_ticket2
-- ��������� ������� ���������-2
--
procedure iparse_ticket2 (
  p_filename  in varchar2,
  p_xml       in xmltype,
  p_errcode  out varchar2 )
is

  l_tick_date date;   -- ���� ��������� �����
  l_tick_rec  number;   -- �_���_��� _�������_���� ����_� � ����_
  l_f_name    varchar2(30); -- ����� �����, �� ���������
  l_f_rec     number;   -- �_���_��� _�������_���� ����_� � ����_, �� ���������
  l_err_code  varchar2(4);  -- ��� ������� �� ������
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

  -- �������� �����
  update zag_f
     set otm  = 5,
         err  = l_err_code,
         fnk  = p_filename,
         datk = l_tick_date
   where fn = l_f_name
     and fnk like '@_1%'
     and dat > sysdate-30;

  -- ���� ����� �������_� �� �_����� _�������_���� ����_�,
  --   �� �������� ����_���� "C_DOC_QTREC" ���_���� ����.
  -- � ���_ �����������_ ���������� ����� ���_������� �� �����-�_����_�_
  --   ����_���� "PROC_FILE_CRTDATE" �� "PROC_FILE_QTREC" ����� ����� ��������.
  if l_tick_rec is null then
     null;
  -- �������� ����� � ��������
  elsif l_tick_rec > 0 then

     i := 0;

     loop

        -- ������� �����
        i := i + 1;

        c_row := c_declarbody || 'ROWS[' || i || ']';

        -- ����� ��� ���������� ����������
        if p_xml.existsnode(c_row) = 0 then
           exit;
        end if;

        l_xml := xmltype(extract(p_xml,c_row,null));

             l_tmp := extract(l_xml, '/ROWS/ROWNUM_FILE_ISH/text()', null);
        l_f_rownum := to_number(l_tmp);
             l_tmp := extract(l_xml, '/ROWS/ERROR_CODE/text()', null);
        l_f_rowerr := substr(l_tmp,1,4);

        -- �������� �����
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

        -- ��������� ������
        insert into lines_i (fn, dat, n, err)
        values (p_filename, l_tick_date, l_f_rownum, l_f_rowerr);

     end loop;

  end if;

  -- ���� ���� ������ � �������� (��� ��� ���������� ����),
  --   ��� ��������� ����� ������ �������� 0000
  if l_tick_rec > 0 then
     l_f_rowerr := '0000';
  -- ����� - ��� ���� ����� ������ ��� ������ �� �����
  else
     l_f_rowerr := l_err_code;
  end if;

  -- �������� ��������� �����
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
-- ��������� ������� ��������� @F1/@F2/@R/@D
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
        raise_application_error(-20000, '��������� ��� ����������!', true);
     exception when no_data_found then null;
     end;
  end if;

  begin
     select fnk, err into l_filek, l_err
       from zag_f
      where ( -- ��� ������-������� @R0/@D0
              l_filedigit = '0' and substr(fn,2,1) = decode(substr(p_filename,2,1),'R','F','P')
              -- ��� ������-��������� @F1/@F2
           or l_filedigit in ('1','2') and substr(fn,2,1) = l_filetype
            )
        and substr(fn,2,1) in ('F', 'P', 'K')
        and substr(fn,4) = substr(p_filename,4)
        and dat > sysdate-30;
  exception when no_data_found then
     raise_application_error(-20000, '��������� �� ��������� ����', true);
  end;

  if l_filedigit = '0' and l_filek is null then
     raise_application_error(-20000, '��������� ������� ���� �� �� ����������!', true);
  elsif l_filedigit = '0' and substr(l_filek,3,1) = '1' then
     raise_application_error(-20000, '��������� ������� ���� �� �� ����������!', true);
  elsif l_filedigit = '0' and substr(l_filek,3,1) = '0' and l_err = '0000' then
     raise_application_error(-20000, '���� ��� ����������!', true);
  elsif l_filedigit = '1' and substr(l_filek,3,1) = '1' and l_err = '0000' then
     raise_application_error(-20000, '���� ��� ���������� ���������� ������� ����!', true);
  elsif l_filedigit = '1' and substr(l_filek,3,1) = '2' and l_err = '0000' then
     raise_application_error(-20000, '���� ��� ���������� ���������� ������� ����!', true);
  elsif l_filedigit = '1' and substr(l_filek,3,1) = '0' and l_err = '0000' then
     raise_application_error(-20000, '���� ��� ����������!', true);
  elsif l_filedigit = '2' and l_filek is null then
     raise_application_error(-20000, '��������� ������� ���� �� �� ����������!', true);
  elsif l_filedigit = '2' and substr(l_filek,3,1) = '2' and l_err = '0000' then
     raise_application_error(-20000, '���� ��� ���������� ���������� ������� ����!', true);
  elsif l_filedigit = '2' and substr(l_filek,3,1) = '0' and l_err = '0000' then
     raise_application_error(-20000, '���� ��� ����������!', true);
  end if;

  select file_data into l_clob from dpa_lob where id = 1;

  l_xml_full := xmltype(l_clob);

  -- ����-�_����_�� R / ����-�_����_�� D
  if substr(p_filename,3,1) = '0' then
     iparse_ticket(p_filename, l_xml_full, l_err_code);

  -- �������_� ��� ��������� ����� (����� �������_�)
  elsif substr(p_filename,3,1) = '1' then
     iparse_ticket1(p_filename, l_xml_full, l_err_code);

  -- �������_� ��� ��������� ����� (����� �������_�)
  elsif substr(p_filename,3,1) = '2' then
     iparse_ticket2(p_filename, l_xml_full, l_err_code);
  end if;

  p_errcode := l_err_code;

  bars_audit.info(p || 'Finish.');

exception when others then
  if ( sqlcode = -19202 or sqlcode = -31011 ) then
     p_errcode := '-1';
  else
  bars_audit.error( 'BARS_DPA.IMPORT_TICKET: ' || dbms_utility.format_error_stack() || 
                                       CHR(10) || dbms_utility.format_error_backtrace() );
  raise_application_error( -20000, sqlerrm || CHR(10) || dbms_utility.format_error_backtrace(), true );
  end if;
end import_ticket;

-------------------------------------------------------------------------------
-- check_files
-- ��������� ��������������� �������� ������
-- ��� ������������� ������. ������������ � ���
--
procedure check_files (p_mode number)
is
  l_dpablk number;
  l_tmpn number;
  l_acc number;
begin

  l_dpablk := to_number(getglobaloption('DPA_BLK'));

  -- �������� �� ������, ������������ ����� � ���, �� ������� �� ������ ��������� @R
  for z in ( select f.fn, f.dat, f.datk, l.nls, l.kv, a.acc, a.blkd, a.dazs
               from zag_f f, lines_f l, accounts a
              where f.fn like '@F%'
                 -- �����, �������������� �����
                and trunc(f.dat) = dat_next_u(bankdate, -1)
                 -- �� ���� ���� ��������� @F2
                and f.fnk like '@F2%'
                 -- ��� ������
                and f.err = '0000'
                and f.fn = l.fn
                and f.dat = l.dat
                 -- �� �������� ������
                and l.otype in (1, 6)
                 -- ���� ��������� @F2
                and l.fn_r like '@F2%'
                 -- ��� ������
                and l.err = '0000'
                and l.nls = a.nls
                and l.kv  = a.kv
                and l.mfo = a.kf )
  loop
     -- ������ ������� � ������ �� ���� � ���
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

     -- ������������ ����
     if l_dpablk is not null and
        z.blkd = l_dpablk and
        z.dazs is null then
        update accounts
           set blkd = 0
         where acc = z.acc
        returning acc into l_acc;
        
        -- �������� ������ �� �� �� ���������� ����� ����� ������ ����������
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

    -- ��������� �� ��� �������� ������ � ��� �� ���������� COBUMMFO-4028
     -- � ���������� �������� tai_accounts_tax. �� ���������� � ������� �.�. �����-�� ��������� �������� �������� ob22
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

       -- ���� ���� ��������� � ���, �� ��������� � ��� ��������
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

       -- ������ �������
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

       -- �������������
       SELECT rezid
         INTO rez_out
         FROM codcagent
        WHERE codcagent = rez_in;

       -- ��� ����������� ������� ������ ��������
       IF l_custtype = 3
      AND SUBSTR(okpo_, 1, 5) IN ('99999', '00000') THEN
          BEGIN
             SELECT SUBSTR(TRIM(ser) || TRIM(numdoc), 1, 14)
               INTO l_passp
               FROM person
              WHERE rnk = p_rnk
                AND passp = 1;
          EXCEPTION
             WHEN NO_DATA_FOUND THEN
                l_passp  := NULL;
          END;

          IF l_passp IS NULL THEN
             RETURN;
          ELSE
             okpo_  := l_passp;
             tgr_   := 4;
          -- tgr = 4 - ���_� �� ����� �������� �_����� �����, ��� ����� ���
          -- ���_�_��_ ����������� �_��������� �_� ��������� �������_�����
          -- ������ ���_���� ������ �������� ������_� �� ���_������ ��� ��
          -- �_����_���� ����� ��� _ �� �_��_��� � �������_
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
        -- ��������� ���������� �����
      IF SQL%rowcount > 0 THEN
        UPDATE accounts a
           SET a.blkd = nvl(trim(getglobaloption('DPA_BLK')), 0)
         WHERE a.acc = p_acc;
      END IF;
    EXCEPTION
       WHEN NO_DATA_FOUND THEN
          RETURN;
    END accounts_tax;

  -- ������� ����������� ��������� ��������� �� ���������� � ������ �� �������� � ���������
  -- �������� p_ob22 ��������� ����� ��� ������ 2620 � ob22 in (07,32) ���������� � ��������� COBUMMFO-5343
  FUNCTION dpa_nbs(p_nbs  varchar2 --DPA_NBS.NBS%TYPE
                  ,p_ob22 accounts.OB22%TYPE DEFAULT NULL) RETURN NUMBER IS
    l_dpa NUMBER;
  BEGIN
    l_dpa := 0; -- 0 - �� ��������� � ������ ���, 1 - ���������

    IF p_nbs = '2620' AND p_ob22 IN ('07'
                                    ,'32') THEN
      l_dpa := 0; -- ��� ���� 1, ��� �� ������ ����������� �� ����, ��������� ��� ���� �����
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
 