

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TEMP_INV_LOAD.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TEMP_INV_LOAD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TEMP_INV_LOAD'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''TEMP_INV_LOAD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TEMP_INV_LOAD ***
begin 
  execute immediate '
  CREATE TABLE BARS.TEMP_INV_LOAD 
   (	BRANCH_NAM VARCHAR2(20), 
	MFO NUMBER(20,5), 
	NAME VARCHAR2(50), 
	OKPO NUMBER(20,5), 
	S NUMBER(20,5), 
	KV NUMBER(20,5), 
	CC_ID NUMBER(20,5), 
	DAT3 DATE, 
	DAT4 DATE, 
	NBS VARCHAR2(4), 
	OB22 VARCHAR2(2), 
	IR NUMBER(20,5), 
	CRISK VARCHAR2(1), 
	S080 NUMBER(20,5), 
	OBS NUMBER(20,5), 
	PAWN NUMBER(20,5), 
	IR_KOM NUMBER(20,5), 
	NLS VARCHAR2(20), 
	IR_PEN NUMBER(20,5), 
	GPK_R NUMBER(20,5), 
	GPK_A NUMBER(20,5), 
	BASE VARCHAR2(3), 
	SUM_SDI VARCHAR2(3), 
	IR_9129 VARCHAR2(3), 
	DOUBLE NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TEMP_INV_LOAD ***
 exec bpa.alter_policies('TEMP_INV_LOAD');


COMMENT ON TABLE BARS.TEMP_INV_LOAD IS '';
COMMENT ON COLUMN BARS.TEMP_INV_LOAD.BRANCH_NAM IS '';
COMMENT ON COLUMN BARS.TEMP_INV_LOAD.MFO IS '';
COMMENT ON COLUMN BARS.TEMP_INV_LOAD.NAME IS '';
COMMENT ON COLUMN BARS.TEMP_INV_LOAD.OKPO IS '';
COMMENT ON COLUMN BARS.TEMP_INV_LOAD.S IS '';
COMMENT ON COLUMN BARS.TEMP_INV_LOAD.KV IS '';
COMMENT ON COLUMN BARS.TEMP_INV_LOAD.CC_ID IS '';
COMMENT ON COLUMN BARS.TEMP_INV_LOAD.DAT3 IS '';
COMMENT ON COLUMN BARS.TEMP_INV_LOAD.DAT4 IS '';
COMMENT ON COLUMN BARS.TEMP_INV_LOAD.NBS IS '';
COMMENT ON COLUMN BARS.TEMP_INV_LOAD.OB22 IS '';
COMMENT ON COLUMN BARS.TEMP_INV_LOAD.IR IS '';
COMMENT ON COLUMN BARS.TEMP_INV_LOAD.CRISK IS '';
COMMENT ON COLUMN BARS.TEMP_INV_LOAD.S080 IS '';
COMMENT ON COLUMN BARS.TEMP_INV_LOAD.OBS IS '';
COMMENT ON COLUMN BARS.TEMP_INV_LOAD.PAWN IS '';
COMMENT ON COLUMN BARS.TEMP_INV_LOAD.IR_KOM IS '';
COMMENT ON COLUMN BARS.TEMP_INV_LOAD.NLS IS '';
COMMENT ON COLUMN BARS.TEMP_INV_LOAD.IR_PEN IS '';
COMMENT ON COLUMN BARS.TEMP_INV_LOAD.GPK_R IS '';
COMMENT ON COLUMN BARS.TEMP_INV_LOAD.GPK_A IS '';
COMMENT ON COLUMN BARS.TEMP_INV_LOAD.BASE IS '';
COMMENT ON COLUMN BARS.TEMP_INV_LOAD.SUM_SDI IS '';
COMMENT ON COLUMN BARS.TEMP_INV_LOAD.IR_9129 IS '';
COMMENT ON COLUMN BARS.TEMP_INV_LOAD.DOUBLE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TEMP_INV_LOAD.sql =========*** End ***
PROMPT ===================================================================================== 
