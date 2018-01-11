

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_REF_XSD.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_REF_XSD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_REF_XSD'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_REF_XSD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_REF_XSD ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_REF_XSD 
   (	FILE_ID NUMBER(5,0), 
	SCM_DT DATE, 
	SCM_URL VARCHAR2(512), 
	CHG_USR NUMBER(38,0), 
	CHG_DT DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_REF_XSD ***
 exec bpa.alter_policies('NBUR_REF_XSD');


COMMENT ON TABLE BARS.NBUR_REF_XSD IS 'Довідник XSD схем для файлів звітності НБУ';
COMMENT ON COLUMN BARS.NBUR_REF_XSD.FILE_ID IS 'Ід файлу';
COMMENT ON COLUMN BARS.NBUR_REF_XSD.SCM_DT IS 'Date of the XML Schema document';
COMMENT ON COLUMN BARS.NBUR_REF_XSD.SCM_URL IS 'The XML Schema document';
COMMENT ON COLUMN BARS.NBUR_REF_XSD.CHG_USR IS 'Change user id';
COMMENT ON COLUMN BARS.NBUR_REF_XSD.CHG_DT IS 'Change date';




PROMPT *** Create  constraint CC_NBURREFXSD_FILEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_XSD MODIFY (FILE_ID CONSTRAINT CC_NBURREFXSD_FILEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBURREFXSD_SCMDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_XSD MODIFY (SCM_DT CONSTRAINT CC_NBURREFXSD_SCMDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBURREFXSD_SCMURL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_XSD MODIFY (SCM_URL CONSTRAINT CC_NBURREFXSD_SCMURL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBURREFXSD_CHGUSR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_XSD MODIFY (CHG_USR CONSTRAINT CC_NBURREFXSD_CHGUSR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBURREFXSD_CHGDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_XSD MODIFY (CHG_DT CONSTRAINT CC_NBURREFXSD_CHGDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_NBURREFXSD ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_XSD ADD CONSTRAINT PK_NBURREFXSD PRIMARY KEY (FILE_ID, SCM_DT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_NBURREFXSD_SCMURL ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_XSD ADD CONSTRAINT UK_NBURREFXSD_SCMURL UNIQUE (SCM_URL)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NBURREFXSD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NBURREFXSD ON BARS.NBUR_REF_XSD (FILE_ID, SCM_DT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_NBURREFXSD_SCMURL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_NBURREFXSD_SCMURL ON BARS.NBUR_REF_XSD (SCM_URL) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_REF_XSD ***
grant SELECT                                                                 on NBUR_REF_XSD    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBUR_REF_XSD    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_REF_XSD.sql =========*** End *** 
PROMPT ===================================================================================== 
