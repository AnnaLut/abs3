begin Insert into cc_sos (sos, name) Values (12, '����� ����������');
exception when dup_val_on_index then null;  
end;
/

COMMIT;

update cc_sos set name = '����� ����������' where sos = 12;
update cc_sos set name = '������� ���������' where sos = 11;
commit;


declare em ERR_MODULES%rowtype; 
begin suda; em.ERRMOD_CODE := 'OVR';       em.ERRMOD_name := '���������' ;
      update ERR_MODULES set ERRMOD_name = em.ERRMOD_name where ERRMOD_CODE = em.ERRMOD_CODE ; if SQL%rowcount=0 then insert into ERR_MODULES values em; end if;
      COMMIT;
end;
/
---------------------------------
declare ec ERR_CODES%rowtype; 
begin suda; ec.ERRMOD_CODE :='OVR'; ec.ERR_CODE :=  2600; ec.ERR_EXCPNUM := 20000;  ec.ERR_NAME := 'ALL_ERR_OVR';
      update ERR_CODES set ERR_NAME=ec.ERR_NAME where ERRMOD_CODE=ec.ERRMOD_CODE and ERR_CODE = ec.ERR_CODE; if SQL%rowcount=0 then insert into ERR_CODES values ec; end if;
      COMMIT;
end;
/
------------------------
declare ff ACCOUNTS_FIELD%rowtype;
begin ff.USE_IN_ARCH  := 0;
      ff.tag  := 'DONOR'         ;      ff.name := '������� ��� ����� ��� (�����)'; 
      update  ACCOUNTS_FIELD set name = ff.name where tag = ff.tag  ;    if SQL%rowcount=0 then insert into ACCOUNTS_FIELD Values ff ; end if;

      ff.tag  := 'PCR_CHKO'      ;      ff.name := '����� ���� (% �� ���)' ;
      update  ACCOUNTS_FIELD set name = ff.name where tag = ff.tag  ;    if SQL%rowcount=0 then insert into ACCOUNTS_FIELD Values ff ; end if;

      ff.tag  := 'TERM_OVR'      ;      ff.name := '����� ������������� ���, ��.���';
      update  ACCOUNTS_FIELD set name = ff.name where tag = ff.tag  ;    if SQL%rowcount=0 then insert into ACCOUNTS_FIELD Values ff ; end if;

      ff.tag  := 'TERM_DAY'      ;      ff.name := '�����(���� ��) ��� ������ %%';
      update  ACCOUNTS_FIELD set name = ff.name where tag = ff.tag  ;    if SQL%rowcount=0 then insert into ACCOUNTS_FIELD Values ff ; end if;

      ff.tag  := 'NEW_KL'        ;      ff.name := '<<�����>> �볺�� ��� ���';
      update  ACCOUNTS_FIELD set name = ff.name where tag = ff.tag  ;    if SQL%rowcount=0 then insert into ACCOUNTS_FIELD Values ff ; end if;

      ff.tag  := 'STOP_O'        ;      ff.name := '<<����>> ��� ����';
      update  ACCOUNTS_FIELD set name = ff.name where tag = ff.tag  ;    if SQL%rowcount=0 then insert into ACCOUNTS_FIELD Values ff ; end if;

      ff.tag  := 'DT_SOS'        ;      ff.name := '���� ���� ������� ���';
      update  ACCOUNTS_FIELD set name = ff.name where tag = ff.tag  ;    if SQL%rowcount=0 then insert into ACCOUNTS_FIELD Values ff ; end if;

      ff.tag  := 'NOT_DS'        ;      ff.name := '³����� �������� ��������';
      update  ACCOUNTS_FIELD set name = ff.name where tag = ff.tag  ;    if SQL%rowcount=0 then insert into ACCOUNTS_FIELD Values ff ; end if;

      ff.tag  := 'TERM_LIM'      ;      ff.name := '���� ��.��������� ����(��=20,����=10)';
      update  ACCOUNTS_FIELD set name = ff.name where tag = ff.tag  ;    if SQL%rowcount=0 then insert into ACCOUNTS_FIELD Values ff ; end if;

      ff.tag  := 'NOT_ZAL'       ;      ff.name := '����� ��� ������������';
      update  ACCOUNTS_FIELD set name = ff.name where tag = ff.tag  ;    if SQL%rowcount=0 then insert into ACCOUNTS_FIELD Values ff ; end if;

      ff.tag  := 'DEL_LIM'      ;       ff.name := 'Max ���������� % ��������� ������ ���� �� ������������';
      update  ACCOUNTS_FIELD set name = ff.name where tag = ff.tag  ;    if SQL%rowcount=0 then insert into ACCOUNTS_FIELD Values ff ; end if;

      ff.tag  := 'EXIT_ZN'      ;       ff.name := 'ҳ���� ������ ����� �� "���" =1';
      update  ACCOUNTS_FIELD set name = ff.name where tag = ff.tag  ;    if SQL%rowcount=0 then insert into ACCOUNTS_FIELD Values ff ; end if;


      COMMIT;

end;
/

----------------------------------------
declare vv CC_VIDD%rowtype;
begin   vv.name := '<<���������>> ���������/���.';  vv.vidd := 10;
update  cc_vidd set name = vv.name where vidd = vv.vidd ; if SQL%rowcount = 0 then Insert into CC_VIDD(VIDD,CUSTTYPE,TIPD,NAME) values (vv.vidd,2,1,vv.name); end if;
        COMMIT;
end;
/

declare vv CC_VIDD%rowtype;
begin   vv.name := '<<���������>> ���������/�����.';  vv.vidd := 110;
update  cc_vidd set name = vv.name where vidd = vv.vidd ; if SQL%rowcount = 0 then Insert into CC_VIDD(VIDD,CUSTTYPE,TIPD,NAME) values (vv.vidd,2,1,vv.name); end if;
        COMMIT;
end;
/

declare tt tips%rowtype ;
begin   tt.name := '<<���������>> ���������';        tt.tip  := 'OVN';
        update  tips set name = tt.name where tip = tt.tip ; if SQL%rowcount = 0 then    Insert into tips (tip,NAME) values (tt.tip, tt.name) ; end if;
        COMMIT;
end;
/

-------------------------------------------
begin Insert into TARIF (KOD, KV, NAME, TAR, PR, SMIN, TIP, kf ) Values   (141, 980, '����� �� ������� ���������� (% �� ����)', 0, 1,   0, 0, '300465');
exception when dup_val_on_index then null;  
end;
/
begin Insert into TARIF (KOD, KV, NAME, TAR, PR, SMIN, TIP, kf ) Values   (142, 980, '����� �� ���������� ���������� �������', 100000, 0,  0, 0, '300465');
exception when dup_val_on_index then null;  
end;
/
begin Insert into TARIF (KOD, KV, NAME, TAR, PR, SMIN, TIP, kf ) Values    (143, 980, '����� �� ���������� ������� NPP', 100000, 0,  0, 0, '300465');
exception when dup_val_on_index then null;  
end;
/
begin Insert into TARIF (KOD, KV, NAME, TAR, PR, SMIN, TIP, kf ) Values    (144, 980, '����� �� ������.������ ��� (% �� ����.���.���.)', 0, 0.06,     0, 0, '300465');
exception when dup_val_on_index then null;  
end;
/
begin Insert into TARIF (KOD, KV, NAME, TAR, PR, SMIN, TIP, kf ) Values   (145, 980, '�� ������������ ����������� ��������', 10000, 0,  0, 0,'300465');
exception when dup_val_on_index then null;  
end;
/
begin Insert into TARIF (KOD, KV, NAME, TAR, PR, SMIN, TIP, kf) Values    (146, 980, '�� ������������ �������� NPP', 20000, 0,  0, 0, '300465');
exception when dup_val_on_index then null;  
end;
/

COMMIT;



