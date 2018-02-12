declare  ff SPARAM_LIST%rowtype;
--------------------------------
begin 

  begin Insert into SPARAM_CODES   (CODE, NAME, ORD) Values   ('OVRN', '���������', 8);
  exception when dup_val_on_index then null;  
  end;

  ff.name := 'VALUE' ;  ff.TABNAME  := 'ACCOUNTSW' ;  ff.CODE := 'OVRN' ;  ff.INUSE := 1;  ff.BRANCH := '/300465/' ;
  
--for k in (select * from mv_kf)
--loop bc.go ( k.KF);
  -----------------------------------------------------------------------------------------------------------------------------------------------
  --2600
  ff.tag := 'DONOR'  ; ff.semantic  := '���:������� ��� ����� ���';  
  update SPARAM_LIST  set semantic   = ff.semantic where  TABNAME = ff.TABNAME and tag = ff.tag ;
  if SQL%rowcount=0 then select max(SPID) + 1 into ff.SPID from SPARAM_LIST ;  ff.TYPE := 'N'  ; insert into SPARAM_LIST Values ff ; end if;

  --2600
  ff.tag := 'TERM_OVR'; ff.semantic := '���:����� ��������.䳿, ��.���';  
  update SPARAM_LIST   set semantic  = ff.semantic where  TABNAME = ff.TABNAME and tag = ff.tag ;
  if SQL%rowcount=0 then select max(SPID) + 1 into ff.SPID from SPARAM_LIST ;  ff.TYPE := 'N'  ; insert into SPARAM_LIST Values ff ; end if;

  --2600
  ff.tag := 'NOT_DS'; ff.semantic := '���:³����� �������� ��������';  
  update SPARAM_LIST   set semantic  = ff.semantic where  TABNAME = ff.TABNAME and tag = ff.tag ;
  if SQL%rowcount=0 then select max(SPID) + 1 into ff.SPID from SPARAM_LIST ;  ff.TYPE := 'N'  ; insert into SPARAM_LIST Values ff ; end if;
  --2600
  ff.tag := 'NEW_KL'; ff.semantic := '���:<<�����>> �볺��';  
  update SPARAM_LIST   set semantic  = ff.semantic where  TABNAME = ff.TABNAME and tag = ff.tag ;
  if SQL%rowcount=0 then select max(SPID) + 1 into ff.SPID from SPARAM_LIST ;  ff.TYPE := 'N'  ; insert into SPARAM_LIST Values ff ; end if;
  -----------------------------------------------------------------------------------------------------------------------------------------------
  --8998
  -----------------------------------------------------------------------------------------------------------------------------------------------
  ff.tag := 'PCR_CHKO'; ff.semantic := '���:����� ���� (% �� ���)';  
  update SPARAM_LIST   set semantic  = ff.semantic where  TABNAME = ff.TABNAME and tag = ff.tag ;
  if SQL%rowcount=0 then select max(SPID) + 1 into ff.SPID from SPARAM_LIST ;  ff.TYPE := 'N'  ; insert into SPARAM_LIST Values ff ; end if;
  -----------------------------------------------------------------------------------------------------------------------------------------------

  ff.tag := 'TERM_DAY'; ff.semantic := '���:�����(���� ��) ��� ������ %%';  
  update SPARAM_LIST   set semantic  = ff.semantic where  TABNAME = ff.TABNAME and tag = ff.tag ;
  if SQL%rowcount=0 then select max(SPID) + 1 into ff.SPID from SPARAM_LIST ;  ff.TYPE := 'N'  ; insert into SPARAM_LIST Values ff ; end if;
  -----------------------------------------------------------------------------------------------------------------------------------------------
  ff.tag := 'STOP_O'; ff.semantic := '���:<<����>> ';  
  update SPARAM_LIST   set semantic  = ff.semantic where  TABNAME = ff.TABNAME and tag = ff.tag ;
  if SQL%rowcount=0 then select max(SPID) + 1 into ff.SPID from SPARAM_LIST ;  ff.TYPE := 'N'  ; insert into SPARAM_LIST Values ff ; end if;

  -----------------------------------------------------------------------------------------------------------------------------------------------
  ff.tag := 'DT_SOS'; ff.semantic := '���:���� ���� ������� ���';  
  update SPARAM_LIST   set semantic  = ff.semantic where  TABNAME = ff.TABNAME and tag = ff.tag ;
  if SQL%rowcount=0 then select max(SPID) + 1 into ff.SPID from SPARAM_LIST ;  ff.TYPE := 'D'  ; insert into SPARAM_LIST Values ff ; end if;
  -----------------------------------------------------------------------------------------------------------------------------------------------
  ff.tag := 'TERM_LIM'; ff.semantic := '���:���� ��.��������� ����';  
  update SPARAM_LIST   set semantic  = ff.semantic where  TABNAME = ff.TABNAME and tag = ff.tag ;
  if SQL%rowcount=0 then select max(SPID) + 1 into ff.SPID from SPARAM_LIST ;  ff.TYPE := 'N'  ; insert into SPARAM_LIST Values ff ; end if;
  -----------------------------------------------------------------------------------------------------------------------------------------------
  ff.tag := 'NOT_ZAL'; ff.semantic := '���:����� ��� ������������';  
  update SPARAM_LIST   set semantic  = ff.semantic where  TABNAME = ff.TABNAME and tag = ff.tag ;
  if SQL%rowcount=0 then select max(SPID) + 1 into ff.SPID from SPARAM_LIST ;  ff.TYPE := 'N'  ; insert into SPARAM_LIST Values ff ; end if;
  -----------------------------------------------------------------------------------------------------------------------------------------------
  ff.tag := 'DEL_LIM'; ff.semantic := '���:Max % ���.���� ���� �� �������';  
  update SPARAM_LIST   set semantic  = ff.semantic where  TABNAME = ff.TABNAME and tag = ff.tag ;
  if SQL%rowcount=0 then select max(SPID) + 1 into ff.SPID from SPARAM_LIST ;  ff.TYPE := 'N'  ; insert into SPARAM_LIST Values ff ; end if;
  -----------------------------------------------------------------------------------------------------------------------------------------------
  ff.tag := 'EXIT_ZN'; ff.semantic := '���:ҳ���� ������ ����� �� "���"=1';  
  update SPARAM_LIST   set semantic  = ff.semantic where  TABNAME = ff.TABNAME and tag = ff.tag ;
  if SQL%rowcount=0 then select max(SPID) + 1 into ff.SPID from SPARAM_LIST ;  ff.TYPE := 'N'  ; insert into SPARAM_LIST Values ff ; end if;
  -----------------------------------------------------------------------------------------------------------------------------------------------
--end loop;
-- suda;
end;
/
COMMIT;
---------------------------------
delete from PS_SPARAM where spid in (select spid from SPARAM_LIST where code ='OVRN');

insert into PS_SPARAM( NBS ,   SPID ) 
               select p.nbs, l.spid 
               from ps p, SPARAM_LIST l
               where p.nbs in ( '2600', '2650', '2602', '2603', '2604' )
                 and l.TABNAME ='ACCOUNTSW' and l.tag in ( 'DONOR', 'TERM_OVR', 'NOT_DS', 'NEW_KL' ) ;
commit;
