

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAG_K.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAG_K ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAG_K'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ZAG_K'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ZAG_K'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAG_K ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAG_K 
   (	REF NUMBER(*,0), 
	KV NUMBER(*,0), 
	FN CHAR(12), 
	DAT DATE, 
	N NUMBER(*,0), 
	SDE NUMBER(24,0), 
	SKR NUMBER(24,0), 
	DATK DATE, 
	DAT_2 DATE, 
	K_ER NUMBER(*,0), 
	OTM NUMBER(*,0), 
	SIGN RAW(128), 
	SIGN_KEY CHAR(6), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAG_K ***
 exec bpa.alter_policies('ZAG_K');


COMMENT ON TABLE BARS.ZAG_K IS 'Реестры документов для квитанций на файлы.';
COMMENT ON COLUMN BARS.ZAG_K.REF IS '';
COMMENT ON COLUMN BARS.ZAG_K.KV IS '';
COMMENT ON COLUMN BARS.ZAG_K.FN IS '';
COMMENT ON COLUMN BARS.ZAG_K.DAT IS '';
COMMENT ON COLUMN BARS.ZAG_K.N IS '';
COMMENT ON COLUMN BARS.ZAG_K.SDE IS '';
COMMENT ON COLUMN BARS.ZAG_K.SKR IS '';
COMMENT ON COLUMN BARS.ZAG_K.DATK IS '';
COMMENT ON COLUMN BARS.ZAG_K.DAT_2 IS '';
COMMENT ON COLUMN BARS.ZAG_K.K_ER IS '';
COMMENT ON COLUMN BARS.ZAG_K.OTM IS '';
COMMENT ON COLUMN BARS.ZAG_K.SIGN IS '';
COMMENT ON COLUMN BARS.ZAG_K.SIGN_KEY IS '';
COMMENT ON COLUMN BARS.ZAG_K.KF IS '';




PROMPT *** Create  constraint PK_ZAGK ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_K ADD CONSTRAINT PK_ZAGK PRIMARY KEY (KF, DAT, FN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAGK_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_K MODIFY (KF CONSTRAINT CC_ZAGK_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ZAGK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ZAGK ON BARS.ZAG_K (KF, DAT, FN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_ZAGK_OTM ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_ZAGK_OTM ON BARS.ZAG_K (OTM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_ZAGK_REF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.I_ZAGK_REF ON BARS.ZAG_K (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAG_K ***
grant UPDATE                                                                 on ZAG_K           to BARS014;
grant SELECT                                                                 on ZAG_K           to BARSREADER_ROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on ZAG_K           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ZAG_K           to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on ZAG_K           to TOSS;
grant SELECT                                                                 on ZAG_K           to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ZAG_K           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAG_K.sql =========*** End *** =======
PROMPT ===================================================================================== 
