

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TEMP_INV1.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TEMP_INV1 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TEMP_INV1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TEMP_INV1 
   (	BRANCH_NAM VARCHAR2(254), 
	MFO NUMBER(20,5), 
	NAME VARCHAR2(254), 
	OKPO NUMBER(20,5), 
	S NUMBER(20,5), 
	KV NUMBER(20,5), 
	CC_ID NUMBER(20,5), 
	DAT3 VARCHAR2(254), 
	DAT4 VARCHAR2(254), 
	OB22 VARCHAR2(254), 
	IR NUMBER(20,5), 
	CRISK VARCHAR2(254), 
	S080 VARCHAR2(254), 
	OBS VARCHAR2(254), 
	PAWN NUMBER(20,5), 
	TIP_GPK VARCHAR2(254), 
	SUM_GPK VARCHAR2(254), 
	NLS VARCHAR2(254), 
	IR_PEN VARCHAR2(254), 
	DOUBLE NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TEMP_INV1 ***
 exec bpa.alter_policies('TEMP_INV1');


COMMENT ON TABLE BARS.TEMP_INV1 IS '';
COMMENT ON COLUMN BARS.TEMP_INV1.BRANCH_NAM IS '';
COMMENT ON COLUMN BARS.TEMP_INV1.MFO IS '';
COMMENT ON COLUMN BARS.TEMP_INV1.NAME IS '';
COMMENT ON COLUMN BARS.TEMP_INV1.OKPO IS '';
COMMENT ON COLUMN BARS.TEMP_INV1.S IS '';
COMMENT ON COLUMN BARS.TEMP_INV1.KV IS '';
COMMENT ON COLUMN BARS.TEMP_INV1.CC_ID IS '';
COMMENT ON COLUMN BARS.TEMP_INV1.DAT3 IS '';
COMMENT ON COLUMN BARS.TEMP_INV1.DAT4 IS '';
COMMENT ON COLUMN BARS.TEMP_INV1.OB22 IS '';
COMMENT ON COLUMN BARS.TEMP_INV1.IR IS '';
COMMENT ON COLUMN BARS.TEMP_INV1.CRISK IS '';
COMMENT ON COLUMN BARS.TEMP_INV1.S080 IS '';
COMMENT ON COLUMN BARS.TEMP_INV1.OBS IS '';
COMMENT ON COLUMN BARS.TEMP_INV1.PAWN IS '';
COMMENT ON COLUMN BARS.TEMP_INV1.TIP_GPK IS '';
COMMENT ON COLUMN BARS.TEMP_INV1.SUM_GPK IS '';
COMMENT ON COLUMN BARS.TEMP_INV1.NLS IS '';
COMMENT ON COLUMN BARS.TEMP_INV1.IR_PEN IS '';
COMMENT ON COLUMN BARS.TEMP_INV1.DOUBLE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TEMP_INV1.sql =========*** End *** ===
PROMPT ===================================================================================== 
