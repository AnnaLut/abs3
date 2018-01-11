

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SALDODSW.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SALDODSW ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SALDODSW ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_SALDODSW 
   (	FDAT DATE, 
	RNK NUMBER, 
	KV NUMBER(*,0), 
	SHORT_S1 NUMBER, 
	SHORT_I1 NUMBER, 
	LONG_S1 NUMBER, 
	LONG_I1 NUMBER, 
	SHORT_S2 NUMBER, 
	SHORT_I2 NUMBER, 
	LONG_S2 NUMBER, 
	LONG_I2 NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SALDODSW ***
 exec bpa.alter_policies('TMP_SALDODSW');


COMMENT ON TABLE BARS.TMP_SALDODSW IS '';
COMMENT ON COLUMN BARS.TMP_SALDODSW.FDAT IS '';
COMMENT ON COLUMN BARS.TMP_SALDODSW.RNK IS '';
COMMENT ON COLUMN BARS.TMP_SALDODSW.KV IS '';
COMMENT ON COLUMN BARS.TMP_SALDODSW.SHORT_S1 IS '';
COMMENT ON COLUMN BARS.TMP_SALDODSW.SHORT_I1 IS '';
COMMENT ON COLUMN BARS.TMP_SALDODSW.LONG_S1 IS '';
COMMENT ON COLUMN BARS.TMP_SALDODSW.LONG_I1 IS '';
COMMENT ON COLUMN BARS.TMP_SALDODSW.SHORT_S2 IS '';
COMMENT ON COLUMN BARS.TMP_SALDODSW.SHORT_I2 IS '';
COMMENT ON COLUMN BARS.TMP_SALDODSW.LONG_S2 IS '';
COMMENT ON COLUMN BARS.TMP_SALDODSW.LONG_I2 IS '';



PROMPT *** Create  grants  TMP_SALDODSW ***
grant SELECT                                                                 on TMP_SALDODSW    to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_SALDODSW    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SALDODSW.sql =========*** End *** 
PROMPT ===================================================================================== 
