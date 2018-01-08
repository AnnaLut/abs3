

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_DELOIT_CCK.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_DELOIT_CCK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_DELOIT_CCK ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_DELOIT_CCK 
   (	DAT DATE, 
	BRANCH VARCHAR2(30), 
	VIDD NUMBER(*,0), 
	ND NUMBER(38,0), 
	CC_ID VARCHAR2(70), 
	RNK NUMBER, 
	NMK VARCHAR2(70), 
	OKPO VARCHAR2(14), 
	KV NUMBER(*,0), 
	SDATE DATE, 
	WDATE DATE, 
	IR NUMBER(20,4), 
	SS NUMBER, 
	SDI NUMBER, 
	SN NUMBER, 
	CR9 NUMBER, 
	DAT_SP DATE, 
	DAT_SPN DATE, 
	FIN23 NUMBER(*,0), 
	OBS23 NUMBER(*,0), 
	KAT23 NUMBER(*,0), 
	DAZS DATE, 
	ACC NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_DELOIT_CCK ***
 exec bpa.alter_policies('TMP_DELOIT_CCK');


COMMENT ON TABLE BARS.TMP_DELOIT_CCK IS '';
COMMENT ON COLUMN BARS.TMP_DELOIT_CCK.DAT IS '';
COMMENT ON COLUMN BARS.TMP_DELOIT_CCK.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_DELOIT_CCK.VIDD IS '';
COMMENT ON COLUMN BARS.TMP_DELOIT_CCK.ND IS '';
COMMENT ON COLUMN BARS.TMP_DELOIT_CCK.CC_ID IS '';
COMMENT ON COLUMN BARS.TMP_DELOIT_CCK.RNK IS '';
COMMENT ON COLUMN BARS.TMP_DELOIT_CCK.NMK IS '';
COMMENT ON COLUMN BARS.TMP_DELOIT_CCK.OKPO IS '';
COMMENT ON COLUMN BARS.TMP_DELOIT_CCK.KV IS '';
COMMENT ON COLUMN BARS.TMP_DELOIT_CCK.SDATE IS '';
COMMENT ON COLUMN BARS.TMP_DELOIT_CCK.WDATE IS '';
COMMENT ON COLUMN BARS.TMP_DELOIT_CCK.IR IS '';
COMMENT ON COLUMN BARS.TMP_DELOIT_CCK.SS IS '';
COMMENT ON COLUMN BARS.TMP_DELOIT_CCK.SDI IS '';
COMMENT ON COLUMN BARS.TMP_DELOIT_CCK.SN IS '';
COMMENT ON COLUMN BARS.TMP_DELOIT_CCK.CR9 IS '';
COMMENT ON COLUMN BARS.TMP_DELOIT_CCK.DAT_SP IS '';
COMMENT ON COLUMN BARS.TMP_DELOIT_CCK.DAT_SPN IS '';
COMMENT ON COLUMN BARS.TMP_DELOIT_CCK.FIN23 IS '';
COMMENT ON COLUMN BARS.TMP_DELOIT_CCK.OBS23 IS '';
COMMENT ON COLUMN BARS.TMP_DELOIT_CCK.KAT23 IS '';
COMMENT ON COLUMN BARS.TMP_DELOIT_CCK.DAZS IS '';
COMMENT ON COLUMN BARS.TMP_DELOIT_CCK.ACC IS '';




PROMPT *** Create  constraint PK_TMP_DELOIT_CCK ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DELOIT_CCK ADD CONSTRAINT PK_TMP_DELOIT_CCK PRIMARY KEY (DAT, ND)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMP_DELOIT_CCK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMP_DELOIT_CCK ON BARS.TMP_DELOIT_CCK (DAT, ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_DELOIT_CCK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_DELOIT_CCK  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_DELOIT_CCK  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_DELOIT_CCK  to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_DELOIT_CCK.sql =========*** End **
PROMPT ===================================================================================== 
