MERGE INTO BARS.TICKETS_PAR A USING
 (SELECT
  'DEFAULT' as REP_PREFIX,
  'NMKNLS' as PAR,
  'select trim(substr(o.NAM_A,1,50)) from oper o where o.ref=:nRecID and o.tt in(''420'')' as TXT,
  'Наимен. сч.' as COMM,
  'TIC' as MOD_CODE
  FROM DUAL) B
ON (A.PAR = B.PAR)
WHEN NOT MATCHED THEN 
INSERT (
  REP_PREFIX, PAR, TXT, COMM, MOD_CODE)
VALUES (
  B.REP_PREFIX, B.PAR, B.TXT, B.COMM, B.MOD_CODE)
WHEN MATCHED THEN
UPDATE SET 
  A.TXT = B.TXT,
  A.COMM = B.COMM,
  A.MOD_CODE = B.MOD_CODE;
  
UPDATE TICKETS_PAR SET TXT = 'SELECT decode(t.fli,1,o2.nlsb,
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
        o.tt in (select tt from tts_vob where vob=6)
       )
   and o.tt not in (''015'',''101'',''445'',''KK1'',''PO3'',''ELT'',''I00'',''G02'',''420'')' WHERE PAR = 'U_ALK_NLSK';
   
COMMIT;