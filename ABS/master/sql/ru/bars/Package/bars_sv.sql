
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_sv.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_SV is

g_head_version constant varchar2(64)  := 'Version 2.0 17/01/2014';
g_head_defs    constant varchar2(512) := '';

/** header_version - возвращает версию заголовка пакета */
function header_version return varchar2;

/** body_version - возвращает версию тела пакета */
function body_version return varchar2;

procedure set_owner (
  p_id    number,
  p_nm1   sv_owner.nm1%type,
  p_nm2   sv_owner.nm2%type,
  p_nm3   sv_owner.nm3%type,
  p_type  sv_owner.type%type,
  p_cod   sv_owner.cod%type,
  p_ozn   sv_owner.ozn%type,
  p_pos   sv_owner.pos%type );

procedure set_ownerdoc (
  p_id        number,
  p_doc_ser   sv_owner.ps_sr%type,
  p_doc_num   sv_owner.ps_nm%type,
  p_doc_date  sv_owner.ps_dt%type,
  p_doc_organ sv_owner.ps_org%type,
  p_bdate     sv_owner.bdate%type,
  p_dorg      sv_owner.dorg%type );

procedure set_owneradr (
  p_id     number,
  p_cod_kr sv_owner.cod_kr%type,
  p_indx   sv_owner.indx%type,
  p_punkt  sv_owner.punkt%type,
  p_ul     sv_owner.ul%type,
  p_bud    sv_owner.bud%type,
  p_korp   sv_owner.korp%type,
  p_off    sv_owner.off%type );

procedure set_owneruch (
  p_id              number,
  p_pruch_vidsotok  sv_owner.pruch_vidsotok%type,
  p_pruch_nominal   sv_owner.pruch_nominal%type,
  p_pruch_golosi    sv_owner.pruch_golosi%type,
  p_opruch_vidsotok sv_owner.opruch_vidsotok%type,
  p_opruch_nominal  sv_owner.opruch_nominal%type,
  p_opruch_golosi   sv_owner.opruch_golosi%type,
  p_goluch_vidsotok sv_owner.goluch_vidsotok%type,
  p_goluch_golos    sv_owner.goluch_golos%type,
  p_zaguch_vidsotok sv_owner.zaguch_vidsotok%type,
  p_zaguch_golos    sv_owner.zaguch_golos%type );

procedure set_golos (
  p_id        number,
  p_to_nm1    sv_golos.to_nm1%type,
  p_to_nm2    sv_golos.to_nm2%type,
  p_to_nm3    sv_golos.to_nm3%type,
  p_to_cod    sv_golos.to_cod%type,
  p_from_nm1  sv_golos.from_nm1%type,
  p_from_nm2  sv_golos.from_nm2%type,
  p_from_nm3  sv_golos.from_nm3%type,
  p_from_cod  sv_golos.from_cod%type,
  p_vidsotok  sv_golos.vidsotok%type,
  p_golos     sv_golos.golos%type,
  p_nomer     sv_golos.nomer%type,
  p_dt        sv_golos.dt%type,
  p_prich     sv_golos.prich%type );

procedure set_bank (
  p_id           number,
  p_vidsotok     sv_bank.vidsotok%type,
  p_golos        sv_bank.golos%type,
  p_man_fio_nm1  sv_bank.man_fio_nm1%type,
  p_man_fio_nm2  sv_bank.man_fio_nm2%type,
  p_man_fio_nm3  sv_bank.man_fio_nm3%type,
  p_man_mb_pos   sv_bank.man_mb_pos%type,
  p_man_mb_dt    sv_bank.man_mb_dt%type,
  p_isp_fio_nm1  sv_bank.isp_fio_nm1%type,
  p_isp_fio_nm2  sv_bank.isp_fio_nm2%type,
  p_isp_fio_nm3  sv_bank.isp_fio_nm3%type,
  p_isp_mb_tlf   sv_bank.isp_mb_tlf%type );

procedure form_p7 (p_filename out varchar2);

procedure import_file (p_filename in varchar2, p_id in number);

procedure import_tick (p_filename in varchar2);

end;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_SV is

g_body_version constant varchar2(64)  := 'Version 2.3 11/02/2014';
g_body_defs    constant varchar2(512) := '';

g_date_format varchar2(10) := 'dd.mm.yyyy';

/** header_version - возвращает версию заголовка пакета */
function header_version return varchar2 is
begin
  return 'Package header bars_owcrv ' || g_head_version || chr(10) ||
         'AWK definition: ' || chr(10) || g_head_defs;
end header_version;

/** body_version - возвращает версию тела пакета */
function body_version return varchar2 is
begin
  return 'Package body bars_owcrv ' || g_body_version ||  chr(10) ||
         'AWK definition: ' || chr(10) || g_body_defs;
end body_version;

-------------------------------------------------------------------------------
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
procedure check_data
is
  l_msg varchar2(2000) := null;
  l_sv_bank sv_bank%rowtype;
function set_msg (p_txt varchar2) return varchar2
is
begin
  return substr(l_msg || p_txt || ';' || chr(10), 1, 2000);
end set_msg;
procedure check_min_length (p_val varchar2, p_name varchar2, p_len number)
is
begin
  if p_val is not null and length(p_val) < p_len then
     l_msg := set_msg('Довжина поля "' || p_name || '" повинна бути не менше ' || to_char(p_len) ||'х символів');
  end if;
end check_min_length;
begin
  -- owner
  for z in ( select * from sv_owner )
  loop
     check_min_length(z.nm1, 'Прізвище/найменування', 2);
     check_min_length(z.nm2, 'Ім’я/скорочене найменування', 2);
     if z.type = 2 and (
        z.ps_sr is null
     or z.ps_nm is null
     or z.ps_dt is null
     or z.ps_org is null ) then
        l_msg := set_msg('Не заповнено Відомості про документ, що посвідчує ФО');
     end if;
     if z.cod_kr is null
     or z.indx is null
     or z.punkt is null
     or z.ul is null
     or z.bud is null then
        l_msg := set_msg('Не заповнено Місцезнаходження або місце проживання учасника');
     end if;
     check_min_length(z.indx, 'Поштовий індекс', 2);
     check_min_length(z.punkt, 'Назва населеного пункту ', 2);
     check_min_length(z.ul, 'Вулиця', 3);
/*
     if z.pruch_vidsotok is null
     or z.pruch_nominal is null
     or z.pruch_golosi is null then
        l_msg := set_msg('Не заповнено Пряма участь');
     end if;
     if z.opruch_vidsotok is null
     or z.opruch_nominal is null
     or z.opruch_golosi is null then
        l_msg := set_msg('Не заповнено Опосередкована участь');
     end if;
     if z.goluch_vidsotok is null
     or z.goluch_golos is null then
        l_msg := set_msg('Не заповнено Набуте право голосу');
     end if;
*/
     if z.zaguch_vidsotok is null
     or z.zaguch_golos is null then
        l_msg := set_msg('Не заповнено Загальний відсоток у статутному капіталі  та загальна кількість голосів');
     end if;
  end loop;
  -- golos
  for z in ( select * from sv_golos )
  loop
     check_min_length(z.to_nm1, 'Прізвище/найменування Особи, якій передали право голосу', 2);
     check_min_length(z.to_nm2, 'Ім’я/скорочене найменування Особи, якій передали право голосу', 2);
     check_min_length(z.from_nm1, 'Прізвище/найменування Особи, яка передала право голосу', 2);
     check_min_length(z.from_nm2, 'Ім’я/скорочене найменування Особи, яка передала право голосу', 2);
  end loop;
  -- bank
  begin
     select * into l_sv_bank from sv_bank where id = 1;
     if l_sv_bank.vidsotok is null and l_sv_bank.golos is not null
     or l_sv_bank.vidsotok is not null and l_sv_bank.golos is null then
        l_msg := set_msg('Не заповнено Відсотки статутного капіталу банку та кількість голосів');
     end if;
     check_min_length(l_sv_bank.man_fio_nm1, 'Прізвище керівника, що підписав анкету', 2);
     check_min_length(l_sv_bank.man_fio_nm2, 'Ім’я керівника, що підписав анкету', 2);
     check_min_length(l_sv_bank.man_fio_nm3, 'По батькові керівника, що підписав анкету', 2);
     check_min_length(l_sv_bank.isp_fio_nm1, 'Прізвище виконавця', 2);
     check_min_length(l_sv_bank.isp_fio_nm2, 'Ім’я виконавця', 2);
     check_min_length(l_sv_bank.isp_fio_nm3, 'По батькові виконавця', 2);
     check_min_length(l_sv_bank.isp_mb_tlf, 'Номер контактного телефону', 3);
  exception when no_data_found then
     l_msg := set_msg('Не заповнено Інформація про Відсотки статутного капіталу, кількість голосів, керівника банку');
  end;
  if l_msg is not null then
     raise_application_error(-20000, l_msg);
  end if;
end check_data;

-------------------------------------------------------------------------------
procedure set_owner (
  p_id    number,
  p_nm1   sv_owner.nm1%type,
  p_nm2   sv_owner.nm2%type,
  p_nm3   sv_owner.nm3%type,
  p_type  sv_owner.type%type,
  p_cod   sv_owner.cod%type,
  p_ozn   sv_owner.ozn%type,
  p_pos   sv_owner.pos%type )
is
  l_id number;
begin
  -- удаление
  if p_nm1 = 'DELETE' then
     delete from sv_owner where id = p_id;
  -- нова особа
  elsif p_id is null then
     select s_svperson.nextval into l_id from dual;
     insert into sv_owner (id, nm1, nm2, nm3, type, cod, ozn, pos)
     values (l_id, p_nm1, p_nm2, p_nm3, p_type, p_cod, p_ozn, p_pos);
  -- обновление
  else
     update sv_owner
        set nm1  = p_nm1,
            nm2  = p_nm2,
            nm3  = p_nm3,
            type = p_type,
            cod  = p_cod,
            ozn  = p_ozn,
            pos  = p_pos
      where id = p_id;
  end if;
end set_owner;

-------------------------------------------------------------------------------
procedure set_ownerdoc (
  p_id        number,
  p_doc_ser   sv_owner.ps_sr%type,
  p_doc_num   sv_owner.ps_nm%type,
  p_doc_date  sv_owner.ps_dt%type,
  p_doc_organ sv_owner.ps_org%type,
  p_bdate     sv_owner.bdate%type,
  p_dorg      sv_owner.dorg%type )
is
begin
  update sv_owner
     set ps_sr  = p_doc_ser,
         ps_nm  = p_doc_num,
         ps_dt  = p_doc_date,
         ps_org = p_doc_organ,
         bdate  = p_bdate,
         dorg   = p_dorg
   where id = p_id;
end set_ownerdoc;

-------------------------------------------------------------------------------
procedure set_owneradr (
  p_id     number,
  p_cod_kr sv_owner.cod_kr%type,
  p_indx   sv_owner.indx%type,
  p_punkt  sv_owner.punkt%type,
  p_ul     sv_owner.ul%type,
  p_bud    sv_owner.bud%type,
  p_korp   sv_owner.korp%type,
  p_off    sv_owner.off%type )
is
begin
  update sv_owner
     set cod_kr = p_cod_kr,
         indx   = p_indx,
         punkt  = p_punkt,
         ul     = p_ul,
         bud    = p_bud,
         korp   = p_korp,
         off    = p_off
   where id = p_id;
end set_owneradr;

-------------------------------------------------------------------------------
procedure set_owneruch (
  p_id              number,
  p_pruch_vidsotok  sv_owner.pruch_vidsotok%type,
  p_pruch_nominal   sv_owner.pruch_nominal%type,
  p_pruch_golosi    sv_owner.pruch_golosi%type,
  p_opruch_vidsotok sv_owner.opruch_vidsotok%type,
  p_opruch_nominal  sv_owner.opruch_nominal%type,
  p_opruch_golosi   sv_owner.opruch_golosi%type,
  p_goluch_vidsotok sv_owner.goluch_vidsotok%type,
  p_goluch_golos    sv_owner.goluch_golos%type,
  p_zaguch_vidsotok sv_owner.zaguch_vidsotok%type,
  p_zaguch_golos    sv_owner.zaguch_golos%type )
is
begin
  update sv_owner
     set pruch_vidsotok  = p_pruch_vidsotok,
         pruch_nominal   = p_pruch_nominal,
         pruch_golosi    = p_pruch_golosi,
         opruch_vidsotok = p_opruch_vidsotok,
         opruch_nominal  = p_opruch_nominal,
         opruch_golosi   = p_opruch_golosi,
         goluch_vidsotok = p_goluch_vidsotok,
         goluch_golos    = p_goluch_golos,
         zaguch_vidsotok = p_zaguch_vidsotok,
         zaguch_golos    = p_zaguch_golos
   where id = p_id;
end set_owneruch;

-------------------------------------------------------------------------------
procedure set_golos (
  p_id        number,
  p_to_nm1    sv_golos.to_nm1%type,
  p_to_nm2    sv_golos.to_nm2%type,
  p_to_nm3    sv_golos.to_nm3%type,
  p_to_cod    sv_golos.to_cod%type,
  p_from_nm1  sv_golos.from_nm1%type,
  p_from_nm2  sv_golos.from_nm2%type,
  p_from_nm3  sv_golos.from_nm3%type,
  p_from_cod  sv_golos.from_cod%type,
  p_vidsotok  sv_golos.vidsotok%type,
  p_golos     sv_golos.golos%type,
  p_nomer     sv_golos.nomer%type,
  p_dt        sv_golos.dt%type,
  p_prich     sv_golos.prich%type )
as
  l_id number;
begin
  -- удаление
  if p_to_nm1 = 'DELETE' then
     delete from sv_golos where id = p_id;
  -- новвый участник
  elsif p_id is null then
     select s_svperson.nextval into l_id from dual;
     insert into sv_golos (id, to_nm1, to_nm2, to_nm3, to_cod, from_nm1, from_nm2, from_nm3, from_cod,
        vidsotok, golos, nomer, dt, prich)
     values (l_id, p_to_nm1, p_to_nm2, p_to_nm3, p_to_cod, p_from_nm1, p_from_nm2, p_from_nm3, p_from_cod,
        p_vidsotok, p_golos, p_nomer, p_dt, p_prich);
  -- обновление
  else
     update sv_golos
        set to_nm1   = to_nm1,
            to_nm2   = to_nm2,
            to_nm3   = to_nm3,
            to_cod   = to_cod,
            from_nm1 = from_nm1,
            from_nm2 = from_nm2,
            from_nm3 = from_nm3,
            from_cod = from_cod,
            vidsotok = vidsotok,
            golos    = golos,
            nomer    = nomer,
            dt       = dt,
            prich    = prich
      where id = p_id;
  end if;
end set_golos;

-------------------------------------------------------------------------------
procedure set_bank (
  p_id           number,
  p_vidsotok     sv_bank.vidsotok%type,
  p_golos        sv_bank.golos%type,
  p_man_fio_nm1  sv_bank.man_fio_nm1%type,
  p_man_fio_nm2  sv_bank.man_fio_nm2%type,
  p_man_fio_nm3  sv_bank.man_fio_nm3%type,
  p_man_mb_pos   sv_bank.man_mb_pos%type,
  p_man_mb_dt    sv_bank.man_mb_dt%type,
  p_isp_fio_nm1  sv_bank.isp_fio_nm1%type,
  p_isp_fio_nm2  sv_bank.isp_fio_nm2%type,
  p_isp_fio_nm3  sv_bank.isp_fio_nm3%type,
  p_isp_mb_tlf   sv_bank.isp_mb_tlf%type )
is
begin
  delete from sv_bank;
  if p_id = 1 then
     insert into sv_bank (id, vidsotok, golos, man_fio_nm1, man_fio_nm2, man_fio_nm3, man_mb_pos, man_mb_dt,
        isp_fio_nm1, isp_fio_nm2, isp_fio_nm3, isp_mb_tlf)
     values (1, p_vidsotok, p_golos, p_man_fio_nm1, p_man_fio_nm2, p_man_fio_nm3, p_man_mb_pos, p_man_mb_dt,
        p_isp_fio_nm1, p_isp_fio_nm2, p_isp_fio_nm3, p_isp_mb_tlf);
  end if;
end set_bank;

-------------------------------------------------------------------------------
function iget_pic (p_id number) return xmltype
is
  l_blob blob;
  l_clob clob;
  l_xml  xmltype := null;
  procedure EncodeBlob( blobSource in blob, clobBase64 in out clob ) is
     step constant number := 3 * 1024;
  begin
     for i in 0..trunc( (DBMS_LOB.GetLength(blobSource) - 1)/step )
     loop
        clobBase64 := clobBase64 ||
           UTL_RAW.cast_to_varchar2(
              UTL_ENCODE.base64_encode(
                 DBMS_LOB.SubStr(blobSource, step, i * step + 1)));
     end loop;
  end;
begin
  begin
     select file_data into l_blob from sv_pic where id = p_id;
     EncodeBlob(l_blob, l_clob);
     select case when p_id = 1 then
                 XmlElement("TABLE_PIC", l_clob) else
                 XmlElement("PICTURE", l_clob) end
       into l_xml from dual;
  exception when no_data_found then
     select case when p_id = 1 then
                 XmlElement("TABLE_PIC", XmlAttributes('true' "xsi:nil")) else
                 XmlElement("PICTURE", XmlAttributes('true' "xsi:nil")) end
       into l_xml from dual;
  end;
  return l_xml;
end iget_pic;

-------------------------------------------------------------------------------
function iget_xml_owner return xmltype
is
  l_xml  xmltype := null;
begin

  select XmlAgg(
            XmlElement("OWNER", XmlAttributes(rownum "ROWNUM"),
               XmlElement("OWNER_TYPE", w.type),
               XmlElement("OWNER_NAZVA",
                  XmlElement("NT_COD", w.cod),
                  XmlElement("NT_NM1", w.nm1),
                  XmlElement("NT_NM2", w.nm2),
                  case when w.nm3 is null then
                       XmlElement("NT_NM3", XmlAttributes('true' "xsi:nil")) else
                       XmlElement("NT_NM3", w.nm3) end
               ),
               XmlElement("OWNER_OZN", w.ozn),
               case when w.pos is null then
                    XmlElement("OWNER_POS", XmlAttributes('true' "xsi:nil")) else
                    XmlElement("OWNER_POS", w.pos) end,
               XmlElement("OWNER_ADR",
                  XmlElement("ADR_COD_KR", lpad(w.cod_kr,3,'0')),
                  XmlElement("ADR_INDEX", w.indx),
                  XmlElement("ADR_PUNKT", w.punkt),
                  XmlElement("ADR_UL", w.ul),
                  XmlElement("ADR_BUD", w.bud),
                  case when w.korp is null then
                       XmlElement("ADR_KORP", XmlAttributes('true' "xsi:nil")) else
                       XmlElement("ADR_KORP", w.korp) end,
                  case when w.off is null then
                       XmlElement("ADR_OFF", XmlAttributes('true' "xsi:nil")) else
                       XmlElement("ADR_OFF", w.off) end
               ),
               case when coalesce(w.ps_sr, w.ps_nm, w.ps_org) is null and w.ps_dt is null then
                    XmlElement("OWNER_PASS", XmlAttributes('true' "xsi:nil")) else
                    XmlElement("OWNER_PASS",
                       XmlElement("PS_SR", w.ps_sr),
                       XmlElement("PS_NM", w.ps_nm),
                       XmlElement("PS_DT", to_char(w.ps_dt,g_date_format)),
                       XmlElement("PS_ORG", w.ps_org)
                    ) end,
               case when w.bdate is null then
                    XmlElement("OWNER_DATE", XmlAttributes('true' "xsi:nil")) else
                    XmlElement("OWNER_DATE", to_char(w.bdate,g_date_format)) end,
               case when w.dorg is null then
                    XmlElement("OWNER_DORG", XmlAttributes('true' "xsi:nil")) else
                    XmlElement("OWNER_DORG", w.dorg) end,
               case when coalesce(w.pruch_vidsotok, w.pruch_nominal, w.pruch_golosi) is null then
                    XmlElement("PR_UCH", XmlAttributes('true' "xsi:nil")) else
                    XmlElement("PR_UCH",
                       case when w.pruch_vidsotok is null then
                            XmlElement("UT_VIDSOTOK", XmlAttributes('true' "xsi:nil")) else
                            XmlElement("UT_VIDSOTOK", w.pruch_vidsotok) end,
                       case when w.pruch_nominal is null then
                            XmlElement("UT_NOMINAL", XmlAttributes('true' "xsi:nil")) else
                            XmlElement("UT_NOMINAL", w.pruch_nominal) end,
                       case when w.pruch_golosi is null then
                            XmlElement("UT_GOLOSI", XmlAttributes('true' "xsi:nil")) else
                            XmlElement("UT_GOLOSI", w.pruch_golosi) end
                    ) end,
               case when coalesce(w.opruch_vidsotok, w.opruch_nominal, w.opruch_golosi) is null then
                    XmlElement("OPR_UCH", XmlAttributes('true' "xsi:nil")) else
                    XmlElement("OPR_UCH",
                       case when w.opruch_vidsotok is null then
                            XmlElement("UT_VIDSOTOK", XmlAttributes('true' "xsi:nil")) else
                            XmlElement("UT_VIDSOTOK", w.opruch_vidsotok) end,
                       case when w.opruch_nominal is null then
                            XmlElement("UT_NOMINAL", XmlAttributes('true' "xsi:nil")) else
                            XmlElement("UT_NOMINAL", w.opruch_nominal) end,
                       case when w.opruch_golosi is null then
                            XmlElement("UT_GOLOSI", XmlAttributes('true' "xsi:nil")) else
                            XmlElement("UT_GOLOSI", w.opruch_golosi) end
                    ) end,
               case when coalesce(w.goluch_vidsotok, w.goluch_golos) is null then
                    XmlElement("GOL_UCH", XmlAttributes('true' "xsi:nil")) else
                    XmlElement("GOL_UCH",
                       case when w.goluch_vidsotok is null then
                            XmlElement("GT_VIDSOTOK", XmlAttributes('true' "xsi:nil")) else
                            XmlElement("GT_VIDSOTOK", w.goluch_vidsotok) end,
                       case when w.goluch_golos is null then
                            XmlElement("GT_GOLOS", XmlAttributes('true' "xsi:nil")) else
                            XmlElement("GT_GOLOS", w.goluch_golos) end
                    ) end,
               XmlElement("ZAG_UCH",
                  XmlElement("GT_VIDSOTOK", w.zaguch_vidsotok),
                  XmlElement("GT_GOLOS", w.zaguch_golos)
               )
            )
         )
    into l_xml
    from sv_owner w;

  if l_xml is null then
     select XmlElement("OWNER", XmlAttributes('0' "ROWNUM", 'true' "xsi:nil")) into l_xml from dual;
  end if;

  return l_xml;

end iget_xml_owner;

-------------------------------------------------------------------------------
function iget_xml_golos return xmltype
is
  l_xml  xmltype := null;
begin

  select XmlAgg(
            XmlElement("PERE_GOLOS", XmlAttributes(rownum "ROWNUM"),
               XmlElement("TO_GL_OSOBA",
                  XmlElement("NT_COD", w.to_cod),
                  XmlElement("NT_NM1", w.to_nm1),
                  XmlElement("NT_NM2", w.to_nm2),
                  case when w.to_nm3 is null then
                       XmlElement("NT_NM3", XmlAttributes('true' "xsi:nil")) else
                       XmlElement("NT_NM3", w.to_nm3) end
               ),
               XmlElement("FROM_GL_OSOBA",
                  XmlElement("NT_COD", w.from_cod),
                  XmlElement("NT_NM1", w.from_nm1),
                  XmlElement("NT_NM2", w.from_nm2),
                  case when w.from_nm3 is null then
                       XmlElement("NT_NM3", XmlAttributes('true' "xsi:nil")) else
                       XmlElement("NT_NM3", w.from_nm3) end
               ),
               XmlElement("GL_NABUT",
                  XmlElement("GT_VIDSOTOK", w.vidsotok),
                  XmlElement("GT_GOLOS", w.golos)
               ),
               XmlElement("GL_NOMER", w.nomer),
               XmlElement("GL_DT", to_char(w.dt,g_date_format)),
               XmlElement("GL_PRICH", w.prich)
            )
         )
    into l_xml
    from sv_golos w;

  if l_xml is null then
     select XmlElement("PERE_GOLOS", XmlAttributes('0' "ROWNUM", 'true' "xsi:nil")) into l_xml from dual;
  end if;

  return l_xml;

end iget_xml_golos;

-------------------------------------------------------------------------------
function iget_xml_sumbank return xmltype
is
  l_xml  xmltype := null;
begin

  begin
     select case when w.vidsotok is null and w.golos is null then
                 XmlElement("SUM_BANK", XmlAttributes('true' "xsi:nil")) else
                 XmlElement("SUM_BANK",
                    XmlElement("GT_VIDSOTOK", w.vidsotok),
                    XmlElement("GT_GOLOS", w.golos)
                 ) end
       into l_xml
       from sv_bank w where id = 1;
  exception when no_data_found then
     raise_application_error(-20000, 'Не заповнено Інформація про Відсотки статутного капіталу, кількість голосів, керівника банку');
  end;

  return l_xml;

end iget_xml_sumbank;

-------------------------------------------------------------------------------
function iget_xml_manbank return xmltype
is
  l_xml  xmltype := null;
begin

  begin
     select XmlElement("MAN_BANK",
               XmlElement("MB_NAZVA",
                  XmlElement("FIO_NM1", w.man_fio_nm1),
                  XmlElement("FIO_NM2", w.man_fio_nm2),
                  XmlElement("FIO_NM3", w.man_fio_nm3)
               ),
               XmlElement("MB_POS", w.man_mb_pos),
               XmlElement("MB_DT", to_char(w.man_mb_dt,g_date_format)),
               XmlElement("MB_ISP_NAZVA",
                  XmlElement("FIO_NM1", w.isp_fio_nm1),
                  XmlElement("FIO_NM2", w.isp_fio_nm2),
                  XmlElement("FIO_NM3", w.isp_fio_nm3)
               ),
               XmlElement("MB_TLF", w.isp_mb_tlf)
            )
       into l_xml
       from sv_bank w where id = 1;
  exception when no_data_found then
     raise_application_error(-20000, 'Не заповнено Інформація про Відсотки статутного капіталу, кількість голосів, керівника банку');
  end;

  return l_xml;

end iget_xml_manbank;

-------------------------------------------------------------------------------
function get_sv_param (p_par varchar2, p_def varchar2, p_err varchar2) return varchar2
is
  l_value sv_params.val%type;
begin
  begin
     select val into l_value from sv_params where par = p_par;
  exception when no_data_found then
     l_value := null;
  end;
  if l_value is null and p_def is not null then
     l_value := p_def;
  end if;
  if l_value is null and p_err is not null then
     raise_application_error(-20000, p_err);
  end if;
  return l_value;
end get_sv_param;

-------------------------------------------------------------------------------
procedure get_file_body (p_filepath in varchar2, p_filename out varchar2, p_fileclob out clob)
is
  l_filename    varchar2(100) := null;
  l_file_head   xmltype := null;
  l_table_pic   xmltype := null;
  l_picture     xmltype := null;
  l_xml_owner   xmltype := null;
  l_xml_golos   xmltype := null;
  l_xml_sumbank xmltype := null;
  l_xml_manbank xmltype := null;
  l_xml_data    xmltype := null;
  l_clob_data   clob;
  l_rownum      number  := 0;
  l_infdt       varchar2(10);
  l_mfo         varchar2(6);
  l_rxx         varchar2(3);
  l_idbank      varchar2(3);
  l_ku          varchar2(2);
begin

  l_infdt  := substr(get_sv_param('INF_DT', to_char(sysdate, g_date_format), null), 1, 10);
  l_mfo    := substr(get_sv_param('P7_MFO', f_ourmfo, null), 1, 6);
  l_idbank := substr(get_sv_param('IDBANK', null, 'Не вказано Ідентифікатор банку'), 1, 3);
  l_ku     := substr(get_sv_param('KU', null, 'Не вказано Код територіального управління'), 1, 2);

  begin
     select substr(sab,2,3) into l_rxx from banks where mfo = l_mfo;
  exception when no_data_found then
     l_rxx := 'Rxx';
  end;

  check_data;

  -- Pt0RxxMD.Ynn
  select 'P70' || l_rxx ||
         f_conv36(to_number(to_char(sysdate,'mm'))) ||
         f_conv36(to_number(to_char(sysdate,'dd'))) || '.' ||
         to_char(sysdate,'y') ||
         lpad(nvl(max(to_number(substr(file_name,-2))),0)+1, 2, '00')
    into l_filename
    from sv_files
   where trunc(file_date) = trunc(sysdate);

  -- HEAD
  select XmlElement("HEAD",
            XmlElement("FNAME", l_filename),
            XmlElement("EDRPOU", f_ourokpo),
            XmlElement("IDBANK", l_idbank),
            XmlElement("MFO", l_mfo),
            XmlElement("CDTASK", '002'),
            XmlElement("CDSUB", '00001'),
            XmlElement("CDFORM", 'NBU_01SV'),
            XmlElement("FILL_DATE", to_char(sysdate, g_date_format)),
            XmlElement("FILL_TIME", to_char(sysdate, 'hh24mi')),
            XmlElement("EI", XmlAttributes('true' "xsi:nil")),
            XmlElement("KU", l_ku) )
    into l_file_head
    from dual;

  -- PICTURE
  l_table_pic := iget_pic(1);
  l_picture   := iget_pic(2);

  -- BODY
  l_xml_owner := iget_xml_owner;
  l_xml_golos := iget_xml_golos;
  l_xml_sumbank  := iget_xml_sumbank;
  l_xml_manbank  := iget_xml_manbank;

  -- компоновка всего отчета
  select
    XmlElement("DECLARATION",
       XmlAttributes('NBU00701.xsd' as "xsi:noNamespaceSchemaLocation",
                     'http://www.w3.org/2001/XMLSchema-instance' as "xmlns:xsi"),
       l_file_head,
       XmlElement("INF_DT", l_infdt),
       l_table_pic,
       l_picture,
       l_xml_owner,
       l_xml_golos,
       l_xml_sumbank,
       l_xml_manbank
    )
  into l_xml_data
  from dual;

  dbms_lob.createtemporary(l_clob_data,FALSE);
  dbms_lob.append(l_clob_data, '<?xml version="1.0" encoding="windows-1251" ?>');
  dbms_lob.append(l_clob_data, l_xml_data.getClobVal());

  insert into sv_files (file_name, file_date) values (l_filename, sysdate);

  p_filename := p_filepath || '\' || l_filename;
  p_fileclob := l_clob_data;

end get_file_body;

-------------------------------------------------------------------------------
procedure form_p7 (p_filename out varchar2)
is
  l_id        number := 2;
  l_filepath  varchar2(100);
  l_filename  varchar2(100);
  l_fileclob  clob;
begin

  begin
     select val into l_filepath from sv_params where par = 'SV_OUT';
  exception when no_data_found then
     l_filepath := null;
  end;
  if l_filepath is null then
     raise_application_error(-20000, 'Не вказано каталог експорту файлу P7');
  end if;

  get_file_body (l_filepath, l_filename, l_fileclob);

  if l_filename is not null then

     insert into imp_file (file_name, file_clob)
     values (l_filename, l_fileclob);

  end if;

  p_filename := l_filename;

end form_p7;

-------------------------------------------------------------------------------
procedure import_file (p_filename in varchar2, p_id in number)
is
  l_blob blob;
begin
  select file_blob into l_blob from imp_file where file_name = p_filename;
  delete from sv_pic where id = p_id;
  insert into sv_pic (id, file_data) values (p_id, l_blob);
exception when no_data_found then null;
end import_file;

-------------------------------------------------------------------------------
procedure import_tick (p_filename in varchar2)
is
  l_clob     clob;
  l_xml      xmltype;
  l_kresult  number;
  l_kerr     sv_files.k_err%type;
  l_kcomment sv_files.k_comment%type;
  l_err_rek  sv_tick.err_rek%type;
  l_err_kod  sv_tick.err_kod%type;
  i          number;
  l_decl     varchar2(100) := '/DECLARATION/DECLARBODY/';
begin

  begin
     select 1 into i from sv_files where file_name = 'P7' || substr(p_filename,-10);
  exception when no_data_found then
     raise_application_error(-20000, p_filename || ' - квитанція на неіснуючий файл.');
  end;

  delete from sv_tick where tick_name = p_filename;

  select file_clob into l_clob from imp_file where file_name = p_filename;
  l_xml := xmltype(l_clob);

  l_kresult := to_number(extract(l_xml, '/DECLARATION/KVIHEAD/RESULT/text()', null));
  if l_kresult = 2 then
     l_kerr := substr(extract(l_xml, l_decl || 'KVI_ERROR/text()', null),1,4);
     l_kcomment := substr(trim(dbms_xmlgen.convert(extract(l_xml, l_decl || 'KVI_COMMENT/text()', null))),1,100);
  end if;

  update sv_files
     set k_name = p_filename,
         k_date = sysdate,
         k_err = l_kerr,
         k_comment = l_kcomment
   where file_name = 'P7' || substr(p_filename,-10);

  if l_kresult = 2 then

     i := 0;

     loop

        i := i + 1;
        -- выход при отсутствии
        if l_xml.existsnode(l_decl || 'INF_ERR['||i||']') = 0 then
           exit;
        end if;

        l_err_rek := substr(extract(l_xml, l_decl || 'INF_ERR['||i||']/ERR_REK/text()', null),1,20);
        l_err_kod := substr(extract(l_xml, l_decl || 'INF_ERR['||i||']/ERR_KOD/text()', null),1,4);

        insert into sv_tick (tick_name, id_row, err_rek, err_kod)
        values (p_filename, i, l_err_rek, l_err_kod);

     end loop;

  end if;

exception when no_data_found then null;
end import_tick;

end;
/
 show err;
 
PROMPT *** Create  grants  BARS_SV ***
grant EXECUTE                                                                on BARS_SV         to RPBN002;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_sv.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 