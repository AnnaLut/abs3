create or replace view v_cust_extern as
select ce.id         as rnk,
       ce.name,
       ce.doc_type,
       p.name        as doc_name,
       ce.doc_serial,
       ce.doc_number,
       ce.doc_date,
       ce.doc_issuer,
       ce.birthday,
       ce.birthplace,
       ce.sex,
       sx.name       as sex_name,
       ce.adr,
       ce.tel,
       ce.email,
       ce.custtype,
       ce.okpo,
       ce.country,
       c.name        as country_name,
       ce.region,
       ce.fs,
       f.name        as fs_name,
       ce.ved,
       v.name        as ved_name,
       ce.sed,
       s.name        as sed_name,
       ce.ise,
       i.name        as ise_name,
       ce.notes,
       ce.date_photo,
       ce.eddr_id,
       ce.actual_date
  from customer_extern ce,
       country         c,
       fs              f,
       ise             i,
       passp           p,
       sed             s,
       sex             sx,
       ved             v
 where ce.doc_type = p.passp(+)
   and ce.sex = sx.id(+)
   and ce.country = c.country(+)
   and ce.fs = f.fs(+)
   and ce.ved = v.ved(+)
   and ce.sed = s.sed(+)
   and ce.ise = i.ise(+)
 order by ce.id;
comment on table V_CUST_EXTERN is 'Не клиенты банка (Представление)';
comment on column V_CUST_EXTERN.RNK is 'РНК НЕ клиента';
comment on column V_CUST_EXTERN.NAME is 'Наименование/ФИО';
comment on column V_CUST_EXTERN.DOC_TYPE is 'Тип документа';
comment on column V_CUST_EXTERN.DOC_NAME is 'Наименование документа';
comment on column V_CUST_EXTERN.DOC_SERIAL is 'Серия документв';
comment on column V_CUST_EXTERN.DOC_NUMBER is 'Номер документа';
comment on column V_CUST_EXTERN.DOC_DATE is 'Дата выдачи документа';
comment on column V_CUST_EXTERN.DOC_ISSUER is 'Место выдачи документа';
comment on column V_CUST_EXTERN.BIRTHDAY is 'Дата рождения';
comment on column V_CUST_EXTERN.BIRTHPLACE is 'Место рождения';
comment on column V_CUST_EXTERN.SEX is 'Пол';
comment on column V_CUST_EXTERN.SEX_NAME is 'Пол наименование';
comment on column V_CUST_EXTERN.ADR is 'Адрес';
comment on column V_CUST_EXTERN.TEL is 'Телефон';
comment on column V_CUST_EXTERN.EMAIL is 'E_mail';
comment on column V_CUST_EXTERN.CUSTTYPE is 'Признак (1-ЮЛ, 2-ФЛ)';
comment on column V_CUST_EXTERN.OKPO is 'ОКПО';
comment on column V_CUST_EXTERN.COUNTRY is 'Код страны';
comment on column V_CUST_EXTERN.COUNTRY_NAME is 'Наименование страны';
comment on column V_CUST_EXTERN.REGION is 'Код региона';
comment on column V_CUST_EXTERN.FS is 'Форма собственности (K081)';
comment on column V_CUST_EXTERN.FS_NAME is 'Форма собственности (K081) наименование';
comment on column V_CUST_EXTERN.VED is 'Вид эк. деят-ти (K110)';
comment on column V_CUST_EXTERN.VED_NAME is 'Вид эк. деят-ти (K110) наименование';
comment on column V_CUST_EXTERN.SED is 'Орг.-правовая форма (K051)';
comment on column V_CUST_EXTERN.SED_NAME is 'Орг.-правовая форма (K051) наименование';
comment on column V_CUST_EXTERN.ISE is 'Инст. сектор экономики (K070)';
comment on column V_CUST_EXTERN.ISE_NAME is 'Инст. сектор экономики (K070) наименование';
comment on column V_CUST_EXTERN.NOTES is 'Комментарий';


PROMPT *** Create  grants  V_CUST_EXTERN ***
grant SELECT                                                                 on V_CUST_EXTERN   to BARSREADER_ROLE;
grant SELECT                                                                 on V_CUST_EXTERN   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CUST_EXTERN   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUST_EXTERN.sql =========*** End *** 
PROMPT ===================================================================================== 

