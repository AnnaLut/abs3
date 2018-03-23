
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_owesk.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_OWESK 
is

g_header_version  constant varchar2(64)  := 'version 1.0 31/07/2014';
g_header_defs     constant varchar2(512) := '';

-- header_version - возвращает версию заголовка пакета
function header_version return varchar2;

-- body_version - возвращает версию тела пакета
function body_version return varchar2;


procedure w4_import_esk_file (
  p_filename  in varchar2,
  p_filebody  in clob,
  p_fileid   out number );

procedure w4_create_esk_deal (
  p_fileid      in number,
  p_proect_id   in number,
  p_card_code   in varchar2,
  p_branch      in varchar2,
  p_isp         in number,
  p_ticketname out varchar2,
  p_ticketbody out nocopy clob );

end;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_OWESK 
is

--
-- constants
--
g_body_version    constant varchar2(64)  := 'version 1.24 17/10/2017';
g_body_defs       constant varchar2(512) := '';
g_modcode         constant varchar2(3)   := 'BPK';
g_pkbcode         constant varchar2(100) := 'bars_owesk';

g_w4_fio_char     constant varchar2(100) := 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ'||'АБВГҐДЕЄЖЗИІЇЙКЛМНОПРСТУФХЦЧШЩЬЮЯ'||chr(39)||'-';
g_digit           constant varchar2(100) := '1234567890';

--
--  types
--
type t_salp is table of ow_salary_data%rowtype;


-- header_version - возвращает версию заголовка пакета
function header_version return varchar2 is
begin
  return 'Package header ' || g_pkbcode || ' ' || g_header_version || '.' || chr(10)
      || 'AWK definition: ' || chr(10)
      ||  g_header_defs;
end header_version;

-- body_version - возвращает версию тела пакета
function body_version return varchar2 is
begin
  return 'Package body ' || g_pkbcode || ' ' || g_body_version || '.' || chr(10)
      || 'AWK definition: ' || chr(10)
      || g_body_defs;
end body_version;

-------------------------------------------------------------------------------
-- EXTRACT()
--
--   безопаcно получает значение по XPath
--
--
function extract (p_xml in xmltype, p_xpath in varchar2, p_default in varchar2) return varchar2 is
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
function check_fio (p_str varchar2) return boolean
is
  b_check boolean := false;
  l_char  varchar2(1);
begin
  for i in 1..length(p_str)
  loop
     b_check := false;
     l_char  := substr(p_str, i, 1);
     for j in 1..length(g_w4_fio_char)
     loop
        if l_char = substr(g_w4_fio_char, j, 1) then
           b_check := true;
           exit;
        end if;
     end loop;
     if not b_check then
        exit;
     end if;
  end loop;
  return b_check;
end check_fio;

-------------------------------------------------------------------------------
function check_digit (p_str varchar2) return boolean
is
  b_check boolean := false;
  l_char  varchar2(1);
begin
  for i in 1..length(p_str)
  loop
     b_check := false;
     l_char  := substr(p_str, i, 1);
     for j in 1..length(g_digit)
     loop
        if l_char = substr(g_digit, j, 1) then
           b_check := true;
           exit;
        end if;
     end loop;
     if not b_check then
        exit;
     end if;
  end loop;
  return b_check;
end check_digit;

-------------------------------------------------------------------------------
-- found_client
-- функция поиска клиента по ОКПО
--
function found_client (
  p_okpo    in     varchar2,
  p_paspser in     varchar2,
  p_paspnum in     varchar2,
  p_err     in out varchar2 ) return number
is
  l_rnk         number := null;
  l_count_okpo  number;
  l_count_passp number;
  l_date_off    date;
  l_search      boolean := false;
begin

  if p_okpo is null
  or substr(p_okpo,1,5) = '99999'
  or substr(p_okpo,1,5) = '00000'
  or (p_paspser is null and length(p_paspnum)<>9)
  or p_paspnum is null then

     l_rnk := null;

  else

     -- ищем клиента по ОКПО
     begin
        select c.rnk into l_rnk
          from customer c
         where c.okpo = p_okpo
           and nvl(trim(c.sed),'00') <> '91';
        l_search := true;
     exception
        when no_data_found then
           l_rnk := null;
        when too_many_rows then
           l_search := true;
     end;

     -- ищем клиента по ОКПО и паспортным данным
     if l_search = true then
        begin
           select c.rnk, c.date_off into l_rnk, l_date_off
             from customer c, person p
            where c.okpo   = p_okpo
              and nvl(trim(c.sed),'00') <> '91'
              and nvl(p.ser,'0') = nvl(p_paspser,'0')
              and p.numdoc = p_paspnum
              and c.rnk = p.rnk;
           if l_date_off is not null then
              -- реанимируем клиента
              update customer set date_off = null where rnk = l_rnk;
           end if;
        exception
           when no_data_found then
              l_rnk := null;
              p_err := 'Клієнт з ЗКПО ' || p_okpo || ' з іншими паспортними даними';
           when too_many_rows then
              -- ищем среди открытых клиентов
              select max(c.rnk) into l_rnk
                from customer c, person p
               where c.okpo   = p_okpo
                 and nvl(trim(c.sed),'00') <> '91'
                 and nvl(p.ser,'0') = nvl(p_paspser,'0')
                 and p.numdoc = p_paspnum
                 and c.rnk = p.rnk
                 and c.date_off is null;
              if l_rnk is null then
                 -- ищем среди закрытых клиентов
                 select max(c.rnk) into l_rnk
                   from customer c, person p
                  where c.okpo   = p_okpo
                    and nvl(trim(c.sed),'00') <> '91'
                    and nvl(p.ser,'0') = nvl(p_paspser,'0')
                    and p.numdoc = p_paspnum
                    and c.rnk = p.rnk
                    and c.date_off is not null;
                 if l_rnk is not null then
                    -- реанимируем клиента
                    update customer set date_off = null where rnk = l_rnk;
                 end if;
              end if;
        end;
     end if;

  end if;

  return l_rnk;

end found_client;

-------------------------------------------------------------------------------
-- icheck_project
-- процедура проверки корректности данных для открытия карт
--
procedure icheck_project (p_project in out ow_salary_data%rowtype)
is
  l_rnk number;
  l_customer   customer%rowtype;
  l_msg        varchar2(254) := null;
  procedure append_msg ( p_txt varchar2 )
  is
  begin
     if l_msg is not null then
        l_msg := substr(l_msg || ';' || p_txt, 1, 254);
     else
        l_msg := substr(p_txt, 1, 254);
     end if;
  end;
begin

  p_project.str_err := null;

  p_project.eng_first_name := substr(f_translate_kmu(p_project.first_name),1,30);
  p_project.eng_last_name  := substr(f_translate_kmu(p_project.last_name),1,30);
  if p_project.type_doc = 1 and p_project.paspseries is not null then
     p_project.paspseries := upper(kl.recode_passport_serial(p_project.paspseries));
  end if;
  p_project.country        := 804;
  p_project.resident       := 1;
  p_project.mname          := to_char(p_project.paspdate, 'dd.mm.yyyy');
  p_project.phone_home     := null;
  p_project.phone_mob      := null;
  p_project.email          := null;
--  p_project.addr1_pcode    := null;
--  p_project.addr2_pcode    := null;
  p_project.addr2_domain   := null;
  p_project.addr2_region   := null;
  p_project.addr2_cityname := null;
  p_project.addr2_street   := null;
  p_project.work           := null;
  p_project.office         := 'студент';
  p_project.okpo_w         := null;
  p_project.pers_cat       := null;
  p_project.aver_sum       := null;

  if p_project.first_name is null
  or p_project.last_name is null
  or p_project.type_doc is null
  or (p_project.paspseries is null and nvl(p_project.type_doc,0) = 1)
  or p_project.paspnum is null
  or p_project.paspissuer is null
  or p_project.paspdate is null
  or p_project.bday is null
  or p_project.gender is null
  or p_project.mname is null
  or p_project.addr1_cityname is null
  or p_project.addr1_street is null
  or p_project.addr1_pcode is null
  or p_project.addr2_pcode is null then
     append_msg('Не заповнено обов''язкові поля');
  end if;
  if length(trim(p_project.eng_first_name||' '||p_project.eng_last_name)) > 24 then
     append_msg('Кількість знаків Прізвище та І''мя для ембосування перевищує 24 символи');
  end if;
  if p_project.paspdate >= sysdate then
     append_msg('Дата видачі паспорту повинна бути менше поточної дати');
  end if;
  if p_project.paspdate < p_project.bday then
     append_msg('Дата видачі паспорту повинна бути більше дати народження');
  end if;
  if instr(p_project.paspseries,' ') > 0 then
     append_msg('Серія паспорту містить пробіли');
  end if;
  if nvl(p_project.type_doc,0) = 1 and
     (p_project.paspseries <> upper(p_project.paspseries) or length(p_project.paspseries) <> 2) then
     append_msg('Невірно заповнено серію паспорту');
  end if;
  if (nvl(p_project.type_doc,0) = 1 and
     (not check_digit(p_project.paspnum) or length(p_project.paspnum) <> 6)) or 
     (nvl(p_project.type_doc,0) = 7 and
     (not check_digit(p_project.paspnum) or length(p_project.paspnum) > 9)) then
     append_msg('Невірно заповнено номер паспорту');
  end if;
  if not check_fio(upper(p_project.first_name)) then
     append_msg('Ім''я повинно містити тільки українські/російські літери');
  end if;
  if not check_fio(upper(p_project.last_name)) then
     append_msg('Прізвище повинно містити тільки українські/російські літери');
  end if;
  if p_project.middle_name is not null and not check_fio(upper(p_project.middle_name)) then
     append_msg('По-батькові повинно містити тільки українські/російські літери');
  end if;
  p_project.str_err := l_msg;

end icheck_project;

-------------------------------------------------------------------------------
-- iparse_esk_file
-- процедура разбора файла
--
procedure iparse_esk_file (
  p_filename  in varchar2,
  p_xml       in xmltype,
  p_id       out number )
is

  l_id      number;
  l_project ow_salary_data%rowtype;

  i number;
  l_tmp varchar2(2000);

  c_rowset  varchar2(100) := '/ROWSET/';
  c_row     varchar2(100);
  l_xml     xmltype;

  h varchar2(100) := g_pkbcode || '.iparse_esk_file. ';

begin

  bars_audit.info(h || 'Start.');

  select s_owfiles.nextval into l_id from dual;

  insert into ow_salary_files (id, file_name)
  values (l_id, upper(p_filename));

  i := 0;

  loop

     -- счетчик карт
     i := i + 1;

     -- выход при отсутствии карт
     if p_xml.existsnode('/ROWSET/ROW['||i||']') = 0 then
        exit;
     end if;

     l_project.okpo           := extract(p_xml, '/ROWSET/ROW['||i||']/IPN/text()', null);
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/FIRST_NAME/text()', null);
     l_project.first_name     := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,70);
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/LAST_NAME/text()', null);
     l_project.last_name      := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,70);
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/MIDDLE_NAME/text()', null);
     l_project.middle_name    := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,70);
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/PASSPORT_KIND/text()', null);
                        l_tmp := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,100);
     l_project.type_doc       := case when l_tmp = 'Паспорт' then 1
                                      when l_tmp = 'Військовий квиток' then 2
                                      when l_tmp = 'Свідоцтво про народження' then 3
                                      when l_tmp = 'Паспорт іноземця' then 14
                                      when l_tmp = 'Паспорт ID карта' then 7
                                      else 99
                                 end;
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/PASSPORT_SERIA/text()', null);
     l_project.paspseries     := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,16);
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/PASSPORT_NUM/text()', null);
     l_project.paspnum        := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,16);
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/PASSPORT_ISSUED_BY/text()', null);
     l_project.paspissuer     := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,128);
     l_project.paspdate       := to_date(extract(p_xml, '/ROWSET/ROW['||i||']/PASSPORT_ISSUED_DATE/text()', null),'dd.mm.yyyy');
     l_project.bday           := to_date(extract(p_xml, '/ROWSET/ROW['||i||']/BIRTHDAY/text()', null),'dd.mm.yyyy');
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/SEX/text()', null);
                        l_tmp := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,100);
     l_project.gender         := case when upper(substr(l_tmp,1,1)) = 'Ч' then 1
                                      when upper(substr(l_tmp,1,1)) = 'Ж' then 2
                                      else null
                                 end;
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/ADDR_REGION/text()', null);
     l_project.addr1_domain   := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,48);

                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/ADDR_DISTRICT/text()', null);
     l_project.addr1_region   := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,48);

                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/ADDR_CITY/text()', null);
     l_project.addr1_cityname := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,100);

                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/ADDR_STREET/text()', null);
     l_project.addr1_street   := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,100);
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/ADDR_HOUSE/text()', null);
     l_project.addr1_street   := case when l_tmp is null then l_project.addr1_street
                                      else substr(l_project.addr1_street || ' '|| trim(dbms_xmlgen.convert(l_tmp,1)),1,100)
                                 end;
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/ADDR_BUILDING/text()', null);
     l_project.addr1_street   := case when l_tmp is null then trim(l_project.addr1_street)
                                      else substr(l_project.addr1_street || trim(dbms_xmlgen.convert(l_tmp,1)),1,100)
                                 end;
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/ADDR_FLAT/text()', null);
     l_project.addr1_street   := case when l_tmp is null then trim(l_project.addr1_street)
                                      else substr(l_project.addr1_street || ' '|| trim(dbms_xmlgen.convert(l_tmp,1)),1,100)
                                 end;
     l_project.date_w         := to_date(extract(p_xml, '/ROWSET/ROW['||i||']/BEGIN_DATE/text()', null),'dd.mm.yyyy');
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/DOCUMENT_SERIA/text()', null);
     l_project.tabn           := substr(trim(dbms_xmlgen.convert(l_tmp,1)),1,32);
                        l_tmp := extract(p_xml, '/ROWSET/ROW['||i||']/DOCUMENT_NUM/text()', null);
     l_project.tabn           := substr(l_project.tabn || ' ' || trim(dbms_xmlgen.convert(l_tmp,1)),1,32);
     l_project.addr1_pcode    := extract(p_xml, '/ROWSET/ROW['||i||']/ADDR_PCODE/text()', null);
     l_project.addr2_pcode    := extract(p_xml, '/ROWSET/ROW['||i||']/ADDR2_PCODE/text()', null);
     l_project.pasp_end_date  := to_date(extract(p_xml, '/ROWSET/ROW['||i||']/PASSPORT_END_DATE/text()', null),'dd.mm.yyyy');
     l_project.pasp_eddrid_id := substr(extract(p_xml, '/ROWSET/ROW['||i||']/PASSPORT_EDDR_ID/text()', null), 1, 14);

     icheck_project(l_project);

     if l_project.str_err is null and
        l_project.okpo is not null and
        l_project.okpo <> '000000000' and
        l_project.okpo <> '0000000000' then
        l_project.rnk := found_client(l_project.okpo, l_project.paspseries, l_project.paspnum, l_project.str_err);
     else
        l_project.rnk := null;
     end if;
     l_project.nd  := null;
     l_project.id  := l_id;
     l_project.idn := i;
     l_project.kf  := sys_context('bars_context','user_mfo');
     -- вставка в таблицу
     insert into ow_salary_data values l_project;

  end loop;

  bars_audit.info(h || to_char(i-1) || ' rows parsed.');

  update ow_salary_files set file_n = i where id = l_id;

  p_id := l_id;

  bars_audit.info(h || 'p_id=>' || to_char(p_id));
  bars_audit.info(h || 'Finish.');

exception when others then
   if ( sqlcode = -19202 or sqlcode = -31011 ) then
      p_id := -1;
      bars_audit.info(h || 'p_id=>' || to_char(p_id));
   else
      raise_application_error(-20000,
         dbms_utility.format_error_stack() || chr(10) ||
         dbms_utility.format_error_backtrace());
   end if;
end iparse_esk_file;

-------------------------------------------------------------------------------
-- w4_import_esk_file
-- процедура импорта файла "електронний студентський квиток"
--
procedure w4_import_esk_file (
  p_filename  in varchar2,
  p_filebody  in clob,
  p_fileid   out number )
is
  l_clob     clob;
  l_xml_full xmltype;
  l_id       number;
  h varchar2(100) := g_pkbcode || '.w4_import_esk_file. ';
begin

  bars_audit.info(h || 'Start.');

  delete from ow_salary_data where id in ( select id from ow_salary_files where trunc(file_date) < trunc(sysdate)-30);

  l_clob := p_filebody;

  l_xml_full := xmltype(l_clob);

  iparse_esk_file(p_filename, l_xml_full, l_id);

  p_fileid := l_id;

  bars_audit.info(h || 'p_fileid=>' || to_char(p_fileid));
  bars_audit.info(h || 'Finish.');

end w4_import_esk_file;

-------------------------------------------------------------------------------
-- form_esk_ticket
--
procedure form_esk_ticket (
  p_fileid      in number,
  p_ticketname out varchar2,
  p_ticketbody out clob )
is
  l_count     number  := 0;
  l_data      xmltype := null;
  l_xml_tmp   xmltype := null;
  l_clob_data clob;
  h varchar2(100) := g_pkbcode || '.form_esk_ticket. ';
begin

  bars_audit.info(h || 'Start.');

  begin
     select 'R_' || file_name into p_ticketname from ow_salary_files where id = p_fileid;
  exception when no_data_found then
     bars_audit.info(h || 'File not found p_fileid=>' || to_char(p_fileid));
     bars_error.raise_nerror(g_modcode, 'FILE_NOT_FOUND');
  end;

  for v in ( select p.okpo, p.first_name,
                    p.last_name, p.middle_name, p.paspseries,
                    p.paspnum, to_char(p.bday,'dd/mm/yyyy') bday,
                    substr(p.tabn,1,instr(p.tabn,' ')-1) doc_ser, substr(p.tabn,instr(p.tabn,' ')+1) doc_num,
                    a.nls, p.str_err
               from ow_salary_data p, w4_acc w, accounts a
              where p.id = p_fileid and p.nd = w.nd(+) and w.acc_pk = a.acc(+) )
  loop

     l_count := l_count + 1;

     select
        XmlElement("ROW",
           XmlElement("LAST_NAME", v.last_name),
           XmlElement("FIRST_NAME", v.first_name),
           XmlElement("MIDDLE_NAME", v.middle_name),
           XmlElement("BIRTHDAY", v.bday),
           XmlElement("IPN", v.okpo),
           XmlElement("PASSPORT_SERIA", v.paspseries),
           XmlElement("PASSPORT_NUM", v.paspnum),
           XmlElement("DOCUMENT_SERIA", v.doc_ser),
           XmlElement("DOCUMENT_NUM", v.doc_num),
           XmlElement("ACC", v.nls),
           XmlElement("ERR", v.str_err)
        )
     into l_xml_tmp
     from dual;

     select XmlConcat(l_data, l_xml_tmp) into l_data from dual;

  end loop;

  if l_count > 0 then

     select XmlElement("ROWSET", l_data) into l_data from dual;

     dbms_lob.createtemporary(l_clob_data,FALSE);
     dbms_lob.append(l_clob_data, '<?xml version="1.0" encoding="windows-1251"?>');
     dbms_lob.append(l_clob_data, l_data.getClobVal());

     p_ticketbody := l_clob_data;

  else

     p_ticketname := null;
     p_ticketbody := null;

  end if;

  bars_audit.info(h || 'p_ticketname=>' || p_ticketname);
  bars_audit.info(h || 'Finish.');

end form_esk_ticket;

-------------------------------------------------------------------------------
-- create_esk_deal
-- Процедура регистрации клиента и карты по файлу
--
procedure create_esk_deal (
  p_fileid    in number,
  p_proect_id in number,
  p_card_code in varchar2,
  p_branch    in varchar2,
  p_isp       in number )
is
  l_proect_name    bpk_proect.name%type;
  l_client_array   t_salp;
  l_rnk            number;
  l_reqid          number;
  l_nd             number;
  l_nls            varchar2(14);
  l_card           w4_acc.card_code%type;
  l_err            ow_salary_data.str_err%type;
  h varchar2(100) := g_pkbcode || '.create_esk_deal. ';
begin

  bars_audit.info(h || 'Start: p_fileid=>' || to_char(p_fileid) || ' p_proect_id=>' || to_char(p_proect_id) ||
     ' p_card_code=>' || p_card_code || ' p_branch=>' || p_branch || ' p_isp=>' || to_char(p_isp));

  begin
     select name into l_proect_name from bpk_proect where id = p_proect_id;
  exception when no_data_found then
     bars_audit.info(h || 'Не найден З/П проект с кодом '||to_char(p_proect_id));
     bars_error.raise_nerror(g_modcode, 'PROECT_NOT_FOUND', to_char(p_proect_id));
  end;

  select *
    bulk collect
    into l_client_array
    from ow_salary_data
   where id = p_fileid and nd is null and str_err is null;

  for i in 1..l_client_array.count loop

     l_err := null;
     l_nd  := null;
     l_rnk := l_client_array(i).rnk;

     if l_rnk is null then
        -- регистрация клиента
        bars_ow.create_customer(l_client_array(i), p_branch);
     else
        -- проверка: у клиента уже есть такая карта
        begin
           select a.nls, o.card_code into l_nls, l_card
             from w4_acc o, accounts a, accountsw w
            where o.acc_pk = a.acc and a.dazs is null
              and a.acc = w.acc and w.tag = 'PK_PRCT'
              and w.value = to_char(p_proect_id)
              and regexp_like(o.card_code,'(VECCST)|(MSTDEBPID)')
              and a.rnk = l_rnk;
           l_err := 'Клієнту вже відкрито картку ' || l_card || ' ' || l_nls;
        exception
           when no_data_found then
              -- обновление реквизитов клиента
              bars_ow.alter_client(l_rnk, l_client_array(i));
           when too_many_rows then
              l_err := 'Клієнту вже відкрито картки %VECCST% або %MSTDEBPID%';
        end;
     end if;

     if l_err is null then

        -- регистрация БПК
        bars_ow.open_card (
          p_rnk           => l_client_array(i).rnk,
          p_nls           => null,
          p_cardcode      => p_card_code,
          p_branch        => p_branch,
          p_embfirstname  => l_client_array(i).eng_first_name,
          p_emblastname   => l_client_array(i).eng_last_name,
          p_secname       => l_client_array(i).mname,
          p_work          => l_proect_name,
          p_office        => l_client_array(i).office,
          p_wdate         => l_client_array(i).date_w,
          p_salaryproect  => p_proect_id,
          p_term          => null,
          p_branchissue   => p_branch,
          p_nd            => l_nd,
          p_reqid         => l_reqid);
        update accounts set isp = p_isp where acc = (select acc_pk from w4_acc where nd = l_nd);
        -- Параметри <DOCUMENT_SERIA> + <DOCUMENT_NUM> передавати в Кардмейк в поле "Номер відділення, де буде видаватися картка"
        update cm_client_que
           set card_br_iss = l_client_array(i).tabn
         where rnk = l_client_array(i).rnk
           and acc = (select acc_pk from w4_acc where nd = l_nd);

     end if;

     -- сохранение данных
     update ow_salary_data
        set rnk = l_client_array(i).rnk,
            nd = l_nd,
            str_err = l_err
      where id = p_fileid and idn = l_client_array(i).idn;

  end loop;

  update ow_salary_files
     set card_code = p_card_code,
         branch = p_branch,
         isp = p_isp,
         proect_id = p_proect_id
   where id = p_fileid;

  bars_audit.info(h || 'Finish.');

end create_esk_deal;

-------------------------------------------------------------------------------
-- w4_create_esk_deal
-- процедура создания БПК по файлу З/П проекта - для WEB
--
procedure w4_create_esk_deal (
  p_fileid      in number,
  p_proect_id   in number,
  p_card_code   in varchar2,
  p_branch      in varchar2,
  p_isp         in number,
  p_ticketname out varchar2,
  p_ticketbody out nocopy clob )
is
  l_ticketname varchar2(100);
  l_clob       clob;
  h varchar2(100) := g_pkbcode || '.w4_create_esk_deal. ';
begin

  bars_audit.trace(h || 'Start.');

  if not regexp_like(p_card_code,'(VECCST)|(MSTDEBPID)') then
     raise_application_error(-20000, 'Заборонено відкривати картку ' || p_card_code || ' для Електронний студентський квиток');
  end if;

  create_esk_deal (
     p_fileid    => p_fileid,
     p_proect_id => p_proect_id,
     p_card_code => p_card_code,
     p_branch    => p_branch,
     p_isp       => p_isp );

  form_esk_ticket (
     p_fileid     => p_fileid,
     p_ticketname => l_ticketname,
     p_ticketbody => l_clob );

  p_ticketname := l_ticketname;
  p_ticketbody := l_clob;

  bars_audit.trace(h || 'Finish.');

end w4_create_esk_deal;

end;
/
 show err;
 
PROMPT *** Create  grants  BARS_OWESK ***
grant EXECUTE                                                                on BARS_OWESK      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_OWESK      to OW;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_owesk.sql =========*** End *** 
 PROMPT ===================================================================================== 
 