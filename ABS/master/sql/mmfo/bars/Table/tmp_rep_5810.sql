

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_REP_5810.sql =========*** Run *** 
PROMPT ===================================================================================== 



PROMPT *** Create  table TMP_REP_5810 ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_REP_5810 
   (	RNUM NUMBER, 
	MFOA VARCHAR2(12), 
	B VARCHAR2(70), 
	PDAT VARCHAR2(254), 
	ODAT VARCHAR2(254), 
	S NUMBER, 
	PRCNT NUMBER, 
	DATD VARCHAR2(254), 
	ND VARCHAR2(10), 
	SFDAT1 VARCHAR2(254), 
	SFDAT2 VARCHAR2(254), 
	NAM_B VARCHAR2(38), 
	ID_B VARCHAR2(14)
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then 
    execute immediate '
       ALTER TABLE BARS.TMP_REP_5810 MODIFY
         (  RNUM NUMBER, 
          MFOA VARCHAR2(12), 
          B VARCHAR2(70), 
          PDAT VARCHAR2(254), 
          ODAT VARCHAR2(254), 
          S NUMBER, 
          PRCNT NUMBER, 
          DATD VARCHAR2(254), 
          ND VARCHAR2(10), 
          SFDAT1 VARCHAR2(254), 
          SFDAT2 VARCHAR2(254), 
          NAM_B VARCHAR2(38), 
          ID_B VARCHAR2(14)
         )'; else raise; 
         end if; 
end; 
/



PROMPT *** Create  grants  TMP_REP_5810 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_REP_5810    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_REP_5810.sql =========*** End *** 
PROMPT ===================================================================================== 
