

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EAD_DOCS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EAD_DOCS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EAD_DOCS'', ''CENTER'' , ''E'', ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''EAD_DOCS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EAD_DOCS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EAD_DOCS ***
begin 
  execute immediate '
  CREATE TABLE BARS.EAD_DOCS 
   (	ID NUMBER, 
	CRT_DATE DATE, 
	CRT_STAFF_ID NUMBER, 
	CRT_BRANCH VARCHAR2(30), 
	TYPE_ID VARCHAR2(100), 
	TEMPLATE_ID VARCHAR2(100), 
	SCAN_DATA BLOB, 
	EA_STRUCT_ID NUMBER, 
	SIGN_DATE DATE, 
	RNK NUMBER, 
	AGR_ID NUMBER, 
	PAGE_COUNT NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD 
 LOB (SCAN_DATA) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EAD_DOCS ***
 exec bpa.alter_policies('EAD_DOCS');


COMMENT ON TABLE BARS.EAD_DOCS IS 'Надруковані документи';
COMMENT ON COLUMN BARS.EAD_DOCS.ID IS 'Ідентифікатор (10... - АБС)';
COMMENT ON COLUMN BARS.EAD_DOCS.CRT_DATE IS 'Дата створення';
COMMENT ON COLUMN BARS.EAD_DOCS.CRT_STAFF_ID IS 'Ід. користувача';
COMMENT ON COLUMN BARS.EAD_DOCS.CRT_BRANCH IS 'Відділення';
COMMENT ON COLUMN BARS.EAD_DOCS.TYPE_ID IS 'Ід. типу';
COMMENT ON COLUMN BARS.EAD_DOCS.TEMPLATE_ID IS 'Ід. шаблону';
COMMENT ON COLUMN BARS.EAD_DOCS.SCAN_DATA IS 'Данні сканкопії';
COMMENT ON COLUMN BARS.EAD_DOCS.EA_STRUCT_ID IS 'Код структури документу за ЕА';
COMMENT ON COLUMN BARS.EAD_DOCS.SIGN_DATE IS 'Дата встановлення відмітки про підписання';
COMMENT ON COLUMN BARS.EAD_DOCS.RNK IS 'РНК клієнта';
COMMENT ON COLUMN BARS.EAD_DOCS.AGR_ID IS 'Ід. угоди';
COMMENT ON COLUMN BARS.EAD_DOCS.PAGE_COUNT IS 'Кіл-ть сторінок';
COMMENT ON COLUMN BARS.EAD_DOCS.KF IS '';




PROMPT *** Create  constraint СС_EADDOCS_TYPEID ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_DOCS ADD CONSTRAINT СС_EADDOCS_TYPEID CHECK ((type_id = ''DOC'' and template_id is not null and scan_data is null)
          or (type_id = ''SCAN'' and template_id is null and
          ((scan_data is not null and  EA_STRUCT_ID<>143) or (scan_data is null and  EA_STRUCT_ID=143)
          ))) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_EADDOCS ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_DOCS ADD CONSTRAINT PK_EADDOCS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EADDOCS_EASTRCID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_DOCS MODIFY (EA_STRUCT_ID CONSTRAINT CC_EADDOCS_EASTRCID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EADDOCS_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_DOCS MODIFY (ID CONSTRAINT CC_EADDOCS_ID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EADDOCS_CRTD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_DOCS MODIFY (CRT_DATE CONSTRAINT CC_EADDOCS_CRTD_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EADDOCS_CRTSID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_DOCS MODIFY (CRT_STAFF_ID CONSTRAINT CC_EADDOCS_CRTSID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EADDOCS_CRTB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_DOCS MODIFY (CRT_BRANCH CONSTRAINT CC_EADDOCS_CRTB_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EADDOCS_TID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_DOCS MODIFY (TYPE_ID CONSTRAINT CC_EADDOCS_TID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EADDOCS_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_DOCS MODIFY (RNK CONSTRAINT CC_EADDOCS_RNK_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EADDOCS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_DOCS MODIFY (KF CONSTRAINT CC_EADDOCS_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_EADDOCS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EADDOCS ON BARS.EAD_DOCS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EAD_DOCS ***
grant SELECT                                                                 on EAD_DOCS        to BARSREADER_ROLE;
grant SELECT                                                                 on EAD_DOCS        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EAD_DOCS        to BARS_DM;
grant SELECT                                                                 on EAD_DOCS        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EAD_DOCS.sql =========*** End *** ====
PROMPT ===================================================================================== 
