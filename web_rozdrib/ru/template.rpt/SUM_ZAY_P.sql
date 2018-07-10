SET DEFINE OFF;
Insert into BARS.TICKETS_PAR
   (REP_PREFIX, PAR, TXT, COMM, MOD_CODE)
 Values
   ('DEFAULT', 'SUM_ZAY_P', 'SELECT trim(to_char(o.s/100,''99999999999990D99''))  FROM opldok o,accounts a,accounts b WHERE a.acc=o.acc AND o.ref=:nRecID AND o.dk=0 AND a.kv<>980 AND b.acc(+)=a.accc AND o.tt in(''AA4'',''AA6'')', 'Сумма без заявы на пер гот', 'TIC');
COMMIT;
