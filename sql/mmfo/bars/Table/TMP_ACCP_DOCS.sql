

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ACCP_DOCS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ACCP_DOCS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ACCP_DOCS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_ACCP_DOCS 
   (	OKPO_ORG VARCHAR2(10), 
	TYPEPL NUMBER(2,0), 
	REF NUMBER, 
	BRANCH VARCHAR2(30), 
	FDAT DATE, 
	NLSA VARCHAR2(15), 
	NLSB VARCHAR2(15), 
	MFOA VARCHAR2(6), 
	MFOB VARCHAR2(6), 
	NAM_A VARCHAR2(38), 
	NAM_B VARCHAR2(38), 
	ID_A VARCHAR2(18), 
	ID_B VARCHAR2(18), 
	S NUMBER, 
	S_FEE NUMBER(15,0), 
	ORDER_FEE NUMBER(2,0), 
	AMOUNT_FEE NUMBER, 
	NAZN VARCHAR2(160), 
	CHECK_ON NUMBER(2,0) DEFAULT 1, 
	PERIOD_START DATE, 
	PERIOD_END DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_ACCP_DOCS ***
 exec bpa.alter_policies('TMP_ACCP_DOCS');


COMMENT ON TABLE BARS.TMP_ACCP_DOCS IS '';
COMMENT ON COLUMN BARS.TMP_ACCP_DOCS.OKPO_ORG IS '';
COMMENT ON COLUMN BARS.TMP_ACCP_DOCS.TYPEPL IS '';
COMMENT ON COLUMN BARS.TMP_ACCP_DOCS.REF IS '';
COMMENT ON COLUMN BARS.TMP_ACCP_DOCS.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_ACCP_DOCS.FDAT IS '';
COMMENT ON COLUMN BARS.TMP_ACCP_DOCS.NLSA IS '';
COMMENT ON COLUMN BARS.TMP_ACCP_DOCS.NLSB IS '';
COMMENT ON COLUMN BARS.TMP_ACCP_DOCS.MFOA IS '';
COMMENT ON COLUMN BARS.TMP_ACCP_DOCS.MFOB IS '';
COMMENT ON COLUMN BARS.TMP_ACCP_DOCS.NAM_A IS '';
COMMENT ON COLUMN BARS.TMP_ACCP_DOCS.NAM_B IS '';
COMMENT ON COLUMN BARS.TMP_ACCP_DOCS.ID_A IS '';
COMMENT ON COLUMN BARS.TMP_ACCP_DOCS.ID_B IS '';
COMMENT ON COLUMN BARS.TMP_ACCP_DOCS.S IS '';
COMMENT ON COLUMN BARS.TMP_ACCP_DOCS.S_FEE IS '';
COMMENT ON COLUMN BARS.TMP_ACCP_DOCS.ORDER_FEE IS '';
COMMENT ON COLUMN BARS.TMP_ACCP_DOCS.AMOUNT_FEE IS '';
COMMENT ON COLUMN BARS.TMP_ACCP_DOCS.NAZN IS '';
COMMENT ON COLUMN BARS.TMP_ACCP_DOCS.CHECK_ON IS '';
COMMENT ON COLUMN BARS.TMP_ACCP_DOCS.PERIOD_START IS '';
COMMENT ON COLUMN BARS.TMP_ACCP_DOCS.PERIOD_END IS '';




PROMPT *** Create  constraint PK_ACCPDOCS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ACCP_DOCS ADD CONSTRAINT PK_ACCPDOCS PRIMARY KEY (REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCPDOCS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCPDOCS ON BARS.TMP_ACCP_DOCS (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_ACCP_DOCS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_ACCP_DOCS   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_ACCP_DOCS   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ACCP_DOCS.sql =========*** End ***
PROMPT ===================================================================================== 
