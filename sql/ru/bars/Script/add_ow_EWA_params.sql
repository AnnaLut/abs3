insert into params$global
  (par, val, comm, srv_flag)
  select 'OWEWAURL', 'http://10.10.10.96:4623/barsroot/api/createdealewa', '������ ���-������� ��� ��������� �������� �����������', 1
    from dual
   where not exists
   (select 1 from params$global t where t.par = 'OWEWAURL')
   union
  select 'OWEWAWALLETPATH', '', '���� �� ����� �����������', 1
    from dual
   where not exists
   (select 1 from params$global t where t.par = 'OWEWAWALLETPATH')
   union
  select 'OWEWAWALETPWD', '', '������ �� Wallet', 1
    from dual
   where not exists
   (select 1 from params$global t where t.par = 'OWEWAWALETPWD');
/ 
commit;
/