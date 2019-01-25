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
comment on table V_CUST_EXTERN is '�� ������� ����� (�������������)';
comment on column V_CUST_EXTERN.RNK is '��� �� �������';
comment on column V_CUST_EXTERN.NAME is '������������/���';
comment on column V_CUST_EXTERN.DOC_TYPE is '��� ���������';
comment on column V_CUST_EXTERN.DOC_NAME is '������������ ���������';
comment on column V_CUST_EXTERN.DOC_SERIAL is '����� ���������';
comment on column V_CUST_EXTERN.DOC_NUMBER is '����� ���������';
comment on column V_CUST_EXTERN.DOC_DATE is '���� ������ ���������';
comment on column V_CUST_EXTERN.DOC_ISSUER is '����� ������ ���������';
comment on column V_CUST_EXTERN.BIRTHDAY is '���� ��������';
comment on column V_CUST_EXTERN.BIRTHPLACE is '����� ��������';
comment on column V_CUST_EXTERN.SEX is '���';
comment on column V_CUST_EXTERN.SEX_NAME is '��� ������������';
comment on column V_CUST_EXTERN.ADR is '�����';
comment on column V_CUST_EXTERN.TEL is '�������';
comment on column V_CUST_EXTERN.EMAIL is 'E_mail';
comment on column V_CUST_EXTERN.CUSTTYPE is '������� (1-��, 2-��)';
comment on column V_CUST_EXTERN.OKPO is '����';
comment on column V_CUST_EXTERN.COUNTRY is '��� ������';
comment on column V_CUST_EXTERN.COUNTRY_NAME is '������������ ������';
comment on column V_CUST_EXTERN.REGION is '��� �������';
comment on column V_CUST_EXTERN.FS is '����� ������������� (K081)';
comment on column V_CUST_EXTERN.FS_NAME is '����� ������������� (K081) ������������';
comment on column V_CUST_EXTERN.VED is '��� ��. ����-�� (K110)';
comment on column V_CUST_EXTERN.VED_NAME is '��� ��. ����-�� (K110) ������������';
comment on column V_CUST_EXTERN.SED is '���.-�������� ����� (K051)';
comment on column V_CUST_EXTERN.SED_NAME is '���.-�������� ����� (K051) ������������';
comment on column V_CUST_EXTERN.ISE is '����. ������ ��������� (K070)';
comment on column V_CUST_EXTERN.ISE_NAME is '����. ������ ��������� (K070) ������������';
comment on column V_CUST_EXTERN.NOTES is '�����������';


PROMPT *** Create  grants  V_CUST_EXTERN ***
grant SELECT                                                                 on V_CUST_EXTERN   to BARSREADER_ROLE;
grant SELECT                                                                 on V_CUST_EXTERN   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CUST_EXTERN   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUST_EXTERN.sql =========*** End *** 
PROMPT ===================================================================================== 

