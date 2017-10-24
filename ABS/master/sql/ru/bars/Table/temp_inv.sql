

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TEMP_INV.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TEMP_INV ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TEMP_INV'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''TEMP_INV'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TEMP_INV ***
begin 
  execute immediate '
  CREATE TABLE BARS.TEMP_INV 
   (	BRANCH_NAM VARCHAR2(100), 
	MFO NUMBER(6,0), 
	NAME VARCHAR2(70), 
	OKPO NUMBER(14,0), 
	S NUMBER(24,2), 
	KV NUMBER(3,0), 
	CC_ID VARCHAR2(20), 
	DAT3 DATE, 
	DAT4 DATE, 
	NBS VARCHAR2(4), 
	OB22 VARCHAR2(2), 
	IR NUMBER(20,4), 
	CRISK VARCHAR2(1), 
	S080 VARCHAR2(1), 
	OBS VARCHAR2(1), 
	PAWN NUMBER(20,5), 
	NLS VARCHAR2(15), 
	GPK_A NUMBER(24,2), 
	GPK_R NUMBER(24,2), 
	SUM_SDI NUMBER(24,2), 
	IR_PEN NUMBER(24,4), 
	IR_KOM NUMBER(24,4), 
	IR_9129 NUMBER(24,4), 
	BASE VARCHAR2(30), 
	DOUBLE NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TEMP_INV ***
 exec bpa.alter_policies('TEMP_INV');


COMMENT ON TABLE BARS.TEMP_INV IS '';
COMMENT ON COLUMN BARS.TEMP_INV.BRANCH_NAM IS '';
COMMENT ON COLUMN BARS.TEMP_INV.MFO IS '';
COMMENT ON COLUMN BARS.TEMP_INV.NAME IS '';
COMMENT ON COLUMN BARS.TEMP_INV.OKPO IS '';
COMMENT ON COLUMN BARS.TEMP_INV.S IS '';
COMMENT ON COLUMN BARS.TEMP_INV.KV IS '';
COMMENT ON COLUMN BARS.TEMP_INV.CC_ID IS '';
COMMENT ON COLUMN BARS.TEMP_INV.DAT3 IS '';
COMMENT ON COLUMN BARS.TEMP_INV.DAT4 IS '';
COMMENT ON COLUMN BARS.TEMP_INV.NBS IS '';
COMMENT ON COLUMN BARS.TEMP_INV.OB22 IS '';
COMMENT ON COLUMN BARS.TEMP_INV.IR IS '';
COMMENT ON COLUMN BARS.TEMP_INV.CRISK IS '';
COMMENT ON COLUMN BARS.TEMP_INV.S080 IS '';
COMMENT ON COLUMN BARS.TEMP_INV.OBS IS '';
COMMENT ON COLUMN BARS.TEMP_INV.PAWN IS '';
COMMENT ON COLUMN BARS.TEMP_INV.NLS IS '';
COMMENT ON COLUMN BARS.TEMP_INV.GPK_A IS '';
COMMENT ON COLUMN BARS.TEMP_INV.GPK_R IS '';
COMMENT ON COLUMN BARS.TEMP_INV.SUM_SDI IS '';
COMMENT ON COLUMN BARS.TEMP_INV.IR_PEN IS '';
COMMENT ON COLUMN BARS.TEMP_INV.IR_KOM IS '';
COMMENT ON COLUMN BARS.TEMP_INV.IR_9129 IS '';
COMMENT ON COLUMN BARS.TEMP_INV.BASE IS '';
COMMENT ON COLUMN BARS.TEMP_INV.DOUBLE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TEMP_INV.sql =========*** End *** ====
PROMPT ===================================================================================== 
