

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SSP_TRANS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SSP_TRANS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SSP_TRANS ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_SSP_TRANS 
   (	TRANS_ID VARCHAR2(12), 
	MFOA VARCHAR2(6), 
	MFOB VARCHAR2(6), 
	DK NUMBER(1,0), 
	S NUMBER, 
	RECV_FLAG VARCHAR2(1)
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SSP_TRANS ***
 exec bpa.alter_policies('TMP_SSP_TRANS');


COMMENT ON TABLE BARS.TMP_SSP_TRANS IS 'Список транзакций ССП по запросу 4.18?';
COMMENT ON COLUMN BARS.TMP_SSP_TRANS.TRANS_ID IS '';
COMMENT ON COLUMN BARS.TMP_SSP_TRANS.MFOA IS '';
COMMENT ON COLUMN BARS.TMP_SSP_TRANS.MFOB IS '';
COMMENT ON COLUMN BARS.TMP_SSP_TRANS.DK IS '';
COMMENT ON COLUMN BARS.TMP_SSP_TRANS.S IS '';
COMMENT ON COLUMN BARS.TMP_SSP_TRANS.RECV_FLAG IS '';



PROMPT *** Create  grants  TMP_SSP_TRANS ***
grant SELECT                                                                 on TMP_SSP_TRANS   to BARSREADER_ROLE;
grant INSERT,SELECT                                                          on TMP_SSP_TRANS   to BARS_ACCESS_DEFROLE;
grant INSERT,SELECT                                                          on TMP_SSP_TRANS   to TOSS;
grant SELECT                                                                 on TMP_SSP_TRANS   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_SSP_TRANS   to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to TMP_SSP_TRANS ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_SSP_TRANS FOR BARS.TMP_SSP_TRANS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SSP_TRANS.sql =========*** End ***
PROMPT ===================================================================================== 
