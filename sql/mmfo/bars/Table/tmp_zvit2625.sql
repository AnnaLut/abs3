

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ZVIT2625.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ZVIT2625 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_ZVIT2625'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_ZVIT2625'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_ZVIT2625'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ZVIT2625 ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_ZVIT2625 
   (	ZVIT_PERIOD VARCHAR2(35), 
	USER_ID NUMBER, 
	USER_FIO VARCHAR2(70), 
	RNK NUMBER, 
	NMK VARCHAR2(70), 
	INSIDER NUMBER, 
	ND VARCHAR2(10), 
	KV NUMBER, 
	NLSD VARCHAR2(14), 
	NLSK VARCHAR2(14), 
	VAL_SUMMA1 NUMBER, 
	UAH_SUMMA1 NUMBER, 
	VAL_SUMMA2 NUMBER, 
	UAH_SUMMA2 NUMBER, 
	NAZN VARCHAR2(160)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_ZVIT2625 ***
 exec bpa.alter_policies('TMP_ZVIT2625');


COMMENT ON TABLE BARS.TMP_ZVIT2625 IS '';
COMMENT ON COLUMN BARS.TMP_ZVIT2625.VAL_SUMMA2 IS '';
COMMENT ON COLUMN BARS.TMP_ZVIT2625.UAH_SUMMA2 IS '';
COMMENT ON COLUMN BARS.TMP_ZVIT2625.NAZN IS '';
COMMENT ON COLUMN BARS.TMP_ZVIT2625.ZVIT_PERIOD IS '';
COMMENT ON COLUMN BARS.TMP_ZVIT2625.USER_ID IS '';
COMMENT ON COLUMN BARS.TMP_ZVIT2625.USER_FIO IS '';
COMMENT ON COLUMN BARS.TMP_ZVIT2625.RNK IS '';
COMMENT ON COLUMN BARS.TMP_ZVIT2625.NMK IS '';
COMMENT ON COLUMN BARS.TMP_ZVIT2625.INSIDER IS '';
COMMENT ON COLUMN BARS.TMP_ZVIT2625.ND IS '';
COMMENT ON COLUMN BARS.TMP_ZVIT2625.KV IS '';
COMMENT ON COLUMN BARS.TMP_ZVIT2625.NLSD IS '';
COMMENT ON COLUMN BARS.TMP_ZVIT2625.NLSK IS '';
COMMENT ON COLUMN BARS.TMP_ZVIT2625.VAL_SUMMA1 IS '';
COMMENT ON COLUMN BARS.TMP_ZVIT2625.UAH_SUMMA1 IS '';



PROMPT *** Create  grants  TMP_ZVIT2625 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_ZVIT2625    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_ZVIT2625    to START1;



PROMPT *** Create SYNONYM  to TMP_ZVIT2625 ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_ZVIT2625 FOR BARS.TMP_ZVIT2625;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ZVIT2625.sql =========*** End *** 
PROMPT ===================================================================================== 
