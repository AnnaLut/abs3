update tickets_par p
   set p.txt = 'SELECT decode(t.fli,1,o2.nlsb,
         decode(o.tt,''901'',o2.nlsb,
           decode(o.tt,''PK7'',o2.nlsb,
             decode(o.tt,''PKR'',o2.nlsb,
               decode(o.tt,''PKX'',o2.nlsb,
                 decode(o.tt,''PKS'',o2.nlsb,
                   decode(o.tt,''PKA'',o2.nlsb,a.nls)))))))
  from opldok o, accounts a, oper o2, tts t
 where o.ref=:nRecID
   and a.acc=o.acc
   and o.ref=o2.ref
   and o.dk=1
   and o.tt=t.tt
   and (o.tt in (''8K2'',''8K3'',''8K7'',''8K8'',
                 ''ALK'',
                 ''DU%'',
                 ''FX7'',''FX8'',''FXM'',''FXP'',
                 ''K27'',
                 ''MB1'',''MBO'',
                 ''NM1'',
                 ''OW3'')
        or
        o.tt in (select tt from tts_vob where vob=6 and tt not in (''SN1'', ''SN3'',''D66''))
       )
   and o.tt not in (''015'',''101'',''445'',''KK1'',''PO3'',''ELT'',''I00'',''G02'', ''SN1'', ''SN3'', ''420'')'
 where p.par = 'U_ALK_NLSK'
   and p.rep_prefix = 'DEFAULT';

update tickets_par p
   set p.txt = 'SELECT a.NLS 
  from opldok o,accounts a 
 where ref=:nRecID  
   and a.acc=o.acc 
   and o.dk=1 
   and tt in (''015'',
              ''101'',
              ''445'',
              ''DPJ'',
              ''ELT'',
              ''KK1'',
              ''G02'',
              ''ELA'',
	          ''SN1'',
	          ''SN3'')'
 where p.par = 'U_015_tts'
   and p.rep_prefix = 'DEFAULT';
   commit;
/


begin 
insert into tickets_par (REP_PREFIX, PAR, TXT, COMM, MOD_CODE)
values ('MEMORDD', 'MUO', 'select 1 from oper where ref=:nRecID and tt in (''MUO'',''MUN'')', null, 'TIC'); 
commit;
exception when others then null;
end;
/
begin 
insert into tickets_par (REP_PREFIX, PAR, TXT, COMM, MOD_CODE)
values ('MEMORDD', 'LUO_NLSA', 'select a.nls from opldok o, accounts a  where o.ref = :nRecID and a.acc = o.acc and ((o.tt = ''LUN'' and o.dk = 0) or (o.tt = ''LUO'' and o.dk = 1))', null, 'TIC');
commit;
exception when others then null;
end;
/
begin 
insert into tickets_par (REP_PREFIX, PAR, TXT, COMM, MOD_CODE)
values ('MEMORDD', 'LUO_NLSB', 'select a.nls from opldok o, accounts a  where o.ref = :nRecID and a.acc = o.acc and ((o.tt = ''LUN'' and o.dk = 1) or (o.tt = ''LUO'' and o.dk = 0))', null, 'TIC');
commit;
exception when others then null;
end;
/


begin 
Insert into BARS.TICKETS_PAR
   (REP_PREFIX, PAR, TXT, COMM, MOD_CODE)
 Values
   ('DEFAULT', 'MO2', 'SELECT  *
from oper o
where o.ref=:nRecID
 and (o.tt not in (''03B'', ''00J''))', 'исключения 03B и 00J', 'TIC');
COMMIT;
exception when others then null;
end;
/
begin
Insert into BARS.TICKETS_PAR
   (REP_PREFIX, PAR, TXT, COMM, MOD_CODE)
 Values
   ('DEFAULT', 'MO1', 'SELECT  *
from oper o
where o.ref=:nRecID
 and (o.tt in (''03B''))', 'Меморільного ордеру 03B', 'TIC');
COMMIT;
exception when others then null;
end;
/


begin
Insert into BARS.TICKETS_PAR
   (REP_PREFIX, PAR, TXT, COMM, MOD_CODE)
 Values
   ('DEFAULT', 'MO4', 'SELECT  *
from oper o
where o.ref=:nRecID
 and (o.tt not in (''00J''))', 'Меморільного ордеру 00j исключения', 'TIC');
COMMIT;
exception when others then null;
end;
/

begin
Insert into BARS.TICKETS_PAR
   (REP_PREFIX, PAR, TXT, COMM, MOD_CODE)
 Values
   ('DEFAULT', 'M00J', 'SELECT  *
from oper o
where o.ref=:nRecID
 and (o.tt in (''00J''))', 'Меморільного ордеру 00J', 'TIC');
COMMIT;
exception when others then null;
end;
/

begin
Insert into BARS.TICKETS_PAR
   (REP_PREFIX, PAR, TXT, COMM, MOD_CODE)
 Values
   ('DEFAULT', 'VLASN2', 'select b.value from oper a, operw b where b.ref=a.ref  and  a.ref=:nRecID  and  b.tag=''FIO''
', 'ФИО+данние', 'TIC');
COMMIT;
exception when others then null;
end;
/



begin
Insert into BARS.TICKETS_PAR
   (REP_PREFIX, PAR, TXT, COMM, MOD_CODE)
 Values
   ('DEFAULT', 'VLASN3', 'select b.value from oper a, operw b where b.ref=a.ref  and  a.ref=:nRecID  and  b.tag=''FIOP''
', 'ФИО+данние', 'TIC');
COMMIT;
exception when others then null;
end;
/


begin
Insert into BARS.TICKETS_PAR
   (REP_PREFIX, PAR, TXT, COMM, MOD_CODE)
 Values
   ('DEFAULT', 'DR_PO_N10', 'select b.value from oper a, operw b where b.ref=a.ref  and  a.ref=:nRecID  and  b.tag=''VA_KC''
', 'ФИО+данние', 'TIC');
COMMIT;
exception when others then null;
end;
/

begin
Insert into BARS.TICKETS_PAR
   (REP_PREFIX, PAR, TXT, COMM, MOD_CODE)
 Values
   ('DEFAULT', 'VLASN4', 'select value from oper a, operw b 
where b.ref=a.ref  and  a.ref=:nRecID  and  b.tag=''VA_KC'' and  b.ref=(select ref from  operw c where c.ref=a.ref and tag in (''FIOP''))
', 'ФИО+данние', 'TIC');
COMMIT;
exception when others then null;
end;
/

begin
Insert into BARS.TICKETS_PAR
      (REP_PREFIX, PAR, TXT, MOD_CODE)
 Values
   ('DEFAULT', 'PASP1', 'select b.value from oper a, operw b 
where b.ref=a.ref  and  a.ref=:nRecID  and  b.tag=''PASP'' and a.s2>14999999', 'TIC');
COMMIT;
exception when others then null;
end;
/

begin
Insert into BARS.TICKETS_PAR
      (REP_PREFIX, PAR, TXT, MOD_CODE)
 Values
   ('DEFAULT', 'DR_POKPO1', 'select b.value from oper a, operw b 
where b.ref=a.ref  and  a.ref=:nRecID  and  b.tag=''POKPO'' and a.s2>14999999', 'TIC');
COMMIT;
exception when others then null;
end;
/

begin
Insert into BARS.TICKETS_PAR
     (REP_PREFIX, PAR, TXT, MOD_CODE)
 Values
   ('DEFAULT', 'DR_PASPN1', 'select b.value from oper a, operw b 
where b.ref=a.ref  and  a.ref=:nRecID  and  b.tag=''PASPN'' and a.s2>14999999', 'TIC');
COMMIT;
exception when others then null;
end;
/

begin
Insert into BARS.TICKETS_PAR
    (REP_PREFIX, PAR, TXT, MOD_CODE)
 Values
   ('DEFAULT', 'DR_ATRT1', 'select b.value from oper a, operw b 
where b.ref=a.ref  and  a.ref=:nRecID  and  b.tag=''ATRT'' and a.s2>14999999', 'TIC');
COMMIT;
exception when others then null;
end;
/

begin
Insert into BARS.TICKETS_PAR
      (REP_PREFIX, PAR, TXT, MOD_CODE)
 Values
   ('DEFAULT', 'DR_PASP21', 'select b.value from oper a, operw b 
where b.ref=a.ref  and  a.ref=:nRecID  and  b.tag=''PASP2'' and a.s2>14999999', 'TIC');
COMMIT;
exception when others then null;
end;
/

update TICKETS_PAR SET txt='SELECT trim(to_char(to_number(w.value),''999990D99'')) FROM operw w WHERE w.ref=:nRecID AND w.tag in(''BM__R'')' where PAR='USL_BM';
COMMIT;