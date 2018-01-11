

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_LST_FILES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_LST_FILES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_LST_FILES'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_LST_FILES'', ''FILIAL'' , ''M'', ''M'', ''M'', ''E'');
               bpa.alter_policy_info(''NBUR_LST_FILES'', ''WHOLE'' , null, null, null, ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_LST_FILES ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_LST_FILES 
   (	REPORT_DATE DATE, 
	KF CHAR(6), 
	VERSION_ID NUMBER(3,0), 
	FILE_ID NUMBER(5,0), 
	FILE_NAME CHAR(12), 
	FILE_BODY CLOB, 
	FILE_HASH RAW(20), 
	FILE_STATUS VARCHAR2(20), 
	START_TIME TIMESTAMP (6), 
	FINISH_TIME TIMESTAMP (6), 
	USER_ID NUMBER(12,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD 
 LOB (FILE_BODY) STORE AS BASICFILE (
  TABLESPACE BRSMDLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_LST_FILES ***
 exec bpa.alter_policies('NBUR_LST_FILES');


COMMENT ON TABLE BARS.NBUR_LST_FILES IS 'Список сформованих звітних файлiв';
COMMENT ON COLUMN BARS.NBUR_LST_FILES.REPORT_DATE IS 'Звiтна дата';
COMMENT ON COLUMN BARS.NBUR_LST_FILES.KF IS 'Код фiлiалу (МФО)';
COMMENT ON COLUMN BARS.NBUR_LST_FILES.VERSION_ID IS 'Ід. версії (для кожного фiлiалу своя)';
COMMENT ON COLUMN BARS.NBUR_LST_FILES.FILE_ID IS 'Iдентифiкатор файлу';
COMMENT ON COLUMN BARS.NBUR_LST_FILES.FILE_NAME IS 'Ім`я сформованого файлу';
COMMENT ON COLUMN BARS.NBUR_LST_FILES.FILE_BODY IS '';
COMMENT ON COLUMN BARS.NBUR_LST_FILES.FILE_HASH IS '';
COMMENT ON COLUMN BARS.NBUR_LST_FILES.FILE_STATUS IS 'Статус файлу';
COMMENT ON COLUMN BARS.NBUR_LST_FILES.START_TIME IS 'Дата початку формування';
COMMENT ON COLUMN BARS.NBUR_LST_FILES.FINISH_TIME IS 'Дата закiнчення формування';
COMMENT ON COLUMN BARS.NBUR_LST_FILES.USER_ID IS 'Iдентифiкатор користувача';




PROMPT *** Create  constraint CC_NBURLSTFILES_REPORTDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_FILES MODIFY (REPORT_DATE CONSTRAINT CC_NBURLSTFILES_REPORTDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBURLSTFILES_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_FILES MODIFY (KF CONSTRAINT CC_NBURLSTFILES_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBURLSTFILES_VERSIONID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_FILES MODIFY (VERSION_ID CONSTRAINT CC_NBURLSTFILES_VERSIONID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBURLSTFILES_FILEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_FILES MODIFY (FILE_ID CONSTRAINT CC_NBURLSTFILES_FILEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBURLSTFILES_FILENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_FILES MODIFY (FILE_NAME CONSTRAINT CC_NBURLSTFILES_FILENAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBURLSTFILES_FILESTATUS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_FILES MODIFY (FILE_STATUS CONSTRAINT CC_NBURLSTFILES_FILESTATUS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBURLSTFILES_STARTTM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_FILES MODIFY (START_TIME CONSTRAINT CC_NBURLSTFILES_STARTTM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBURLSTFILES_USERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_FILES MODIFY (USER_ID CONSTRAINT CC_NBURLSTFILES_USERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBURLSTFILES_FILEHASH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_FILES ADD CONSTRAINT CC_NBURLSTFILES_FILEHASH_NN CHECK (FILE_HASH IS NOT NULL) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBURLSTFILES_FINISHTM ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_FILES ADD CONSTRAINT CC_NBURLSTFILES_FINISHTM CHECK ( FINISH_TIME > START_TIME ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_NBURLSTFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_FILES ADD CONSTRAINT UK_NBURLSTFILES UNIQUE (REPORT_DATE, KF, VERSION_ID, FILE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_NBURLSTFILES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_NBURLSTFILES ON BARS.NBUR_LST_FILES (REPORT_DATE, KF, VERSION_ID, FILE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_LST_FILES ***
grant SELECT                                                                 on NBUR_LST_FILES  to BARSREADER_ROLE;
grant SELECT                                                                 on NBUR_LST_FILES  to BARSUPL;
grant SELECT                                                                 on NBUR_LST_FILES  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBUR_LST_FILES  to BARS_DM;
grant SELECT                                                                 on NBUR_LST_FILES  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_LST_FILES.sql =========*** End **
PROMPT ===================================================================================== 
