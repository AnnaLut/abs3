

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_REP_101052.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  table TMP_REP_101052 ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_REP_101052 
   (	REF NUMBER(38,0), 
	TT CHAR(3), 
	NAM_A VARCHAR2(38), 
	NAM_B VARCHAR2(38), 
	DEBIT NUMBER, 
	CREDIT NUMBER, 
	NAZN VARCHAR2(160), 
	PDAT DATE, 
	VDAT DATE, 
	EDESC VARCHAR2(220), 
	EDATE VARCHAR2(220), 
	EREF VARCHAR2(220)
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


PROMPT *** Create  grants  TMP_REP_101052 ***
grant ALL PRIVILEGES ON TMP_REP_101052 to BARS_ACCESS_DEFROLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_REP_101052.sql =========*** End **
PROMPT ===================================================================================== 
