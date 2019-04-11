

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_DOCS.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_DOCS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_DOCS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_DOCS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CC_DOCS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_DOCS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_DOCS 
   (	ID VARCHAR2(35), 
	ND NUMBER(38,0), 
	ADDS NUMBER(10,0), 
	VERSION DATE DEFAULT SYSDATE, 
	STATE NUMBER(1,0) DEFAULT 1, 
	TEXT CLOB, 
	COMM VARCHAR2(254), 
	DONEBY VARCHAR2(30), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD 
 LOB (TEXT) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_DOCS ***
 exec bpa.alter_policies('CC_DOCS');


COMMENT ON TABLE BARS.CC_DOCS IS 'Тексты документов';
COMMENT ON COLUMN BARS.CC_DOCS.ID IS 'Идентификатор шаблона';
COMMENT ON COLUMN BARS.CC_DOCS.ND IS 'Номер договора';
COMMENT ON COLUMN BARS.CC_DOCS.ADDS IS 'Номер доп.соглашения';
COMMENT ON COLUMN BARS.CC_DOCS.VERSION IS 'Версия (дата и время создания)';
COMMENT ON COLUMN BARS.CC_DOCS.STATE IS 'Статус договора';
COMMENT ON COLUMN BARS.CC_DOCS.TEXT IS 'Текст договора';
COMMENT ON COLUMN BARS.CC_DOCS.COMM IS 'Комментарий';
COMMENT ON COLUMN BARS.CC_DOCS.DONEBY IS 'Исполнитель';
COMMENT ON COLUMN BARS.CC_DOCS.KF IS '';




PROMPT *** Create  constraint PK_CCDOCS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DOCS ADD CONSTRAINT PK_CCDOCS PRIMARY KEY (ID, ND, ADDS, VERSION)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCDOCS_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DOCS MODIFY (ID CONSTRAINT CC_CCDOCS_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCDOCS_ND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DOCS MODIFY (ND CONSTRAINT CC_CCDOCS_ND_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCDOCS_ADDS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DOCS MODIFY (ADDS CONSTRAINT CC_CCDOCS_ADDS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCDOCS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_DOCS MODIFY (KF CONSTRAINT CC_CCDOCS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCDOCS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCDOCS ON BARS.CC_DOCS (ID, ND, ADDS, VERSION) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_DOCS ***
grant SELECT                                                                 on CC_DOCS         to BARSREADER_ROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on CC_DOCS         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_DOCS         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_DOCS         to CC_DOC;
grant INSERT,SELECT                                                          on CC_DOCS         to DPT;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_DOCS         to DPT_ADMIN;
grant INSERT,SELECT                                                          on CC_DOCS         to DPT_ROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on CC_DOCS         to FOREX;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on CC_DOCS         to RCC_DEAL;
grant SELECT                                                                 on CC_DOCS         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_DOCS         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_DOCS.sql =========*** End *** =====
PROMPT ===================================================================================== 
