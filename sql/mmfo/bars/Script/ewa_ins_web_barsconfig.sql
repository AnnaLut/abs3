merge into bars.web_barsconfig a using
 (select
  1 as grouptype,
  'EWA.URL_SEND_REF_STATUS' as key,
  null as csharptype,
  'https://10.7.98.11/barsroot/webservices/EWAService.asmx?wsdl' as val,
  'URL ��� ������ ����������' as comm
  from dual) b
on (a.key = b.key)
when not matched then 
insert (
  grouptype, key, csharptype, val, comm)
values (
  b.grouptype, b.key, b.csharptype, b.val, b.comm);
/
merge into bars.web_barsconfig a using
 (select
  1 as grouptype,
  'EWA.Wallet_dir' as key,
  null as csharptype,
  'file:/u01/oracle/ssl' as val,
  'Wallet_dir' as comm
  from dual) b
on (a.key = b.key)
when not matched then 
insert (
  grouptype, key, csharptype, val, comm)
values (
  b.grouptype, b.key, b.csharptype, b.val, b.comm);
/
merge into bars.web_barsconfig a using
 (select
  1 as grouptype,
  'EWA.Wallet_pass' as key,
  null as csharptype,
  'wallet123' as val,
  'Wallet_pass' as comm
  from dual) b
on (a.key = b.key)
when not matched then 
insert (
  grouptype, key, csharptype, val, comm)
values (
  b.grouptype, b.key, b.csharptype, b.val, b.comm);
/
merge into bars.web_barsconfig a using
 (select
  1 as grouptype,
  'EWA.ABS_login' as key,
  null as csharptype,
  'absadm' as val,
  'EWA_REF_STATUS: ���� ��������� �����������' as comm
  from dual) b
on (a.key = b.key)
when not matched then 
insert (
  grouptype, key, csharptype, val, comm)
values (
  b.grouptype, b.key, b.csharptype, b.val, b.comm);
/
merge into bars.web_barsconfig a using
 (select
  1 as grouptype,
  'EWA.ABS_pass' as key,
  null as csharptype,
  'qwerty' as val,
  'EWA_REF_STATUS: ������ ��������� �����������' as comm
  from dual) b
on (a.key = b.key)
when not matched then 
insert (
  grouptype, key, csharptype, val, comm)
values (
  b.grouptype, b.key, b.csharptype, b.val, b.comm);
/
merge into bars.web_barsconfig a using
 (select
  1 as grouptype,
  'EWA.EWAEMAIL' as key,
  null as csharptype,
  'bars@unity-bars.com' as val,
  '����� � ���' as comm
  from dual) b
on (a.key = b.key)
when not matched then 
insert (
  grouptype, key, csharptype, val, comm)
values (
  b.grouptype, b.key, b.csharptype, b.val, b.comm);
/
merge into bars.web_barsconfig a using
 (select
  1 as grouptype,
  'EWA.EWAHASH' as key,
  null as csharptype,
  '3f2774623a1e0aec808df1ba3000fdc679c6693b' as val,
  '��� ������ ��� ������ � ���' as comm
  from dual) b
on (a.key = b.key)
when not matched then 
insert (
  grouptype, key, csharptype, val, comm)
values (
  b.grouptype, b.key, b.csharptype, b.val, b.comm);
/
merge into bars.web_barsconfig a using
 (select
  1 as grouptype,
  'EWA.EWAURL' as key,
  null as csharptype,
  'https://oschadbank.ewa.ua/ewa/api/v3/' as val,
  'URL � ���' as comm
  from dual) b
on (a.key = b.key)
when not matched then 
insert (
  grouptype, key, csharptype, val, comm)
values (
  b.grouptype, b.key, b.csharptype, b.val, b.comm);
/
commit;
/
