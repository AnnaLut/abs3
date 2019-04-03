prompt add FMPOS reqv
begin
insert into customer_field (TAG, NAME, B, U, F, TABNAME, BYISP, TYPE, OPT, TABCOLUMN_CHECK, SQLVAL, CODE, NOT_TO_EDIT, HIST, PARID, U_NREZ, F_NREZ, F_SPD)
values ('FMPOS', 'Висн. щодо наявн.у кл-та потенц. та реал. фін.можл.для провед. опер.', 1, 1, 1, 'FM_POSS', null, null, null, 'NAME', null, 'FM', 0, null, null, 0, 1, 1);
commit;
exception
when dup_val_on_index then null;
end;
/

begin
 update customer_field set F=2,F_SPD=2 where tag = 'FMPOS';
commit;
 end;
/

--COBUMMFO-9811
MERGE INTO BARS.CUSTOMER_FIELD A USING
 (SELECT
  'DEDR ' as TAG,
  'Дата запису в ЄДР' as NAME,
  0 as B,
  2 as U,
  0 as F,
  NULL as TABNAME,
  NULL as BYISP,
  'D' as TYPE,
  0 as OPT,
  NULL as TABCOLUMN_CHECK,
  NULL as SQLVAL,
  'GENERAL' as CODE,
  0 as NOT_TO_EDIT,
  NULL as HIST,
  292 as PARID,
  0 as U_NREZ,
  0 as F_NREZ,
  0 as F_SPD,
  NULL as CHKR,
  NULL as MASK
  FROM DUAL) B
ON (A.TAG = B.TAG)
WHEN NOT MATCHED THEN 
INSERT (
  TAG, NAME, B, U, F, 
  TABNAME, BYISP, TYPE, OPT, TABCOLUMN_CHECK, 
  SQLVAL, CODE, NOT_TO_EDIT, HIST, PARID, 
  U_NREZ, F_NREZ, F_SPD, CHKR, MASK)
VALUES (
  B.TAG, B.NAME, B.B, B.U, B.F, 
  B.TABNAME, B.BYISP, B.TYPE, B.OPT, B.TABCOLUMN_CHECK, 
  B.SQLVAL, B.CODE, B.NOT_TO_EDIT, B.HIST, B.PARID, 
  B.U_NREZ, B.F_NREZ, B.F_SPD, B.CHKR, B.MASK)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.B = B.B,
  A.U = B.U,
  A.F = B.F,
  A.TABNAME = B.TABNAME,
  A.BYISP = B.BYISP,
  A.TYPE = B.TYPE,
  A.OPT = B.OPT,
  A.TABCOLUMN_CHECK = B.TABCOLUMN_CHECK,
  A.SQLVAL = B.SQLVAL,
  A.CODE = B.CODE,
  A.NOT_TO_EDIT = B.NOT_TO_EDIT,
  A.HIST = B.HIST,
  A.PARID = B.PARID,
  A.U_NREZ = B.U_NREZ,
  A.F_NREZ = B.F_NREZ,
  A.F_SPD = B.F_SPD,
  A.CHKR = B.CHKR,
  A.MASK = B.MASK;

MERGE INTO BARS.CUSTOMER_FIELD A USING
 (SELECT
  'NEDR ' as TAG,
  'Номер запису в ЄДР' as NAME,
  0 as B,
  2 as U,
  0 as F,
  NULL as TABNAME,
  NULL as BYISP,
  'N' as TYPE,
  0 as OPT,
  NULL as TABCOLUMN_CHECK,
  NULL as SQLVAL,
  'GENERAL' as CODE,
  0 as NOT_TO_EDIT,
  NULL as HIST,
  293 as PARID,
  0 as U_NREZ,
  0 as F_NREZ,
  0 as F_SPD,
  NULL as CHKR,
  NULL as MASK
  FROM DUAL) B
ON (A.TAG = B.TAG)
WHEN NOT MATCHED THEN 
INSERT (
  TAG, NAME, B, U, F, 
  TABNAME, BYISP, TYPE, OPT, TABCOLUMN_CHECK, 
  SQLVAL, CODE, NOT_TO_EDIT, HIST, PARID, 
  U_NREZ, F_NREZ, F_SPD, CHKR, MASK)
VALUES (
  B.TAG, B.NAME, B.B, B.U, B.F, 
  B.TABNAME, B.BYISP, B.TYPE, B.OPT, B.TABCOLUMN_CHECK, 
  B.SQLVAL, B.CODE, B.NOT_TO_EDIT, B.HIST, B.PARID, 
  B.U_NREZ, B.F_NREZ, B.F_SPD, B.CHKR, B.MASK)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.B = B.B,
  A.U = B.U,
  A.F = B.F,
  A.TABNAME = B.TABNAME,
  A.BYISP = B.BYISP,
  A.TYPE = B.TYPE,
  A.OPT = B.OPT,
  A.TABCOLUMN_CHECK = B.TABCOLUMN_CHECK,
  A.SQLVAL = B.SQLVAL,
  A.CODE = B.CODE,
  A.NOT_TO_EDIT = B.NOT_TO_EDIT,
  A.HIST = B.HIST,
  A.PARID = B.PARID,
  A.U_NREZ = B.U_NREZ,
  A.F_NREZ = B.F_NREZ,
  A.F_SPD = B.F_SPD,
  A.CHKR = B.CHKR,
  A.MASK = B.MASK;

MERGE INTO BARS.CUSTOMER_FIELD A USING
 (SELECT
  'VVORG' as TAG,
  'Відомості про виконавчий орган' as NAME,
  0 as B,
  2 as U,
  0 as F,
  NULL as TABNAME,
  NULL as BYISP,
  'S' as TYPE,
  0 as OPT,
  NULL as TABCOLUMN_CHECK,
  NULL as SQLVAL,
  'FM' as CODE,
  0 as NOT_TO_EDIT,
  NULL as HIST,
  294 as PARID,
  2 as U_NREZ,
  0 as F_NREZ,
  0 as F_SPD,
  NULL as CHKR,
  NULL as MASK
  FROM DUAL) B
ON (A.TAG = B.TAG)
WHEN NOT MATCHED THEN 
INSERT (
  TAG, NAME, B, U, F, 
  TABNAME, BYISP, TYPE, OPT, TABCOLUMN_CHECK, 
  SQLVAL, CODE, NOT_TO_EDIT, HIST, PARID, 
  U_NREZ, F_NREZ, F_SPD, CHKR, MASK)
VALUES (
  B.TAG, B.NAME, B.B, B.U, B.F, 
  B.TABNAME, B.BYISP, B.TYPE, B.OPT, B.TABCOLUMN_CHECK, 
  B.SQLVAL, B.CODE, B.NOT_TO_EDIT, B.HIST, B.PARID, 
  B.U_NREZ, B.F_NREZ, B.F_SPD, B.CHKR, B.MASK)
WHEN MATCHED THEN
UPDATE SET 
  A.NAME = B.NAME,
  A.B = B.B,
  A.U = B.U,
  A.F = B.F,
  A.TABNAME = B.TABNAME,
  A.BYISP = B.BYISP,
  A.TYPE = B.TYPE,
  A.OPT = B.OPT,
  A.TABCOLUMN_CHECK = B.TABCOLUMN_CHECK,
  A.SQLVAL = B.SQLVAL,
  A.CODE = B.CODE,
  A.NOT_TO_EDIT = B.NOT_TO_EDIT,
  A.HIST = B.HIST,
  A.PARID = B.PARID,
  A.U_NREZ = B.U_NREZ,
  A.F_NREZ = B.F_NREZ,
  A.F_SPD = B.F_SPD,
  A.CHKR = B.CHKR,
  A.MASK = B.MASK;

COMMIT;	
