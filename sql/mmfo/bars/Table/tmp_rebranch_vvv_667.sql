

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_REBRANCH_VVV_667.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_REBRANCH_VVV_667 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_REBRANCH_VVV_667 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_REBRANCH_VVV_667 
   (	ACC NUMBER(38,0), 
	NLS VARCHAR2(15), 
	KV NUMBER(3,0), 
	NMS VARCHAR2(70), 
	BRANCH_OLD VARCHAR2(30), 
	BRANCH_NEW VARCHAR2(30), 
	CHGDATE VARCHAR2(19), 
	IDUPD NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_REBRANCH_VVV_667 ***
 exec bpa.alter_policies('TMP_REBRANCH_VVV_667');


COMMENT ON TABLE BARS.TMP_REBRANCH_VVV_667 IS '';
COMMENT ON COLUMN BARS.TMP_REBRANCH_VVV_667.ACC IS '';
COMMENT ON COLUMN BARS.TMP_REBRANCH_VVV_667.NLS IS '';
COMMENT ON COLUMN BARS.TMP_REBRANCH_VVV_667.KV IS '';
COMMENT ON COLUMN BARS.TMP_REBRANCH_VVV_667.NMS IS '';
COMMENT ON COLUMN BARS.TMP_REBRANCH_VVV_667.BRANCH_OLD IS '';
COMMENT ON COLUMN BARS.TMP_REBRANCH_VVV_667.BRANCH_NEW IS '';
COMMENT ON COLUMN BARS.TMP_REBRANCH_VVV_667.CHGDATE IS '';
COMMENT ON COLUMN BARS.TMP_REBRANCH_VVV_667.IDUPD IS '';



PROMPT *** Create  grants  TMP_REBRANCH_VVV_667 ***
grant SELECT                                                                 on TMP_REBRANCH_VVV_667 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_REBRANCH_VVV_667.sql =========*** 
PROMPT ===================================================================================== 
