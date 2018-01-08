

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_CNG_FILES.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_CNG_FILES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_CNG_FILES'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OW_CNG_FILES'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OW_CNG_FILES'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_CNG_FILES ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_CNG_FILES 
   (	ID NUMBER(22,0), 
	FILE_NAME VARCHAR2(100), 
	FILE_DATE DATE DEFAULT sysdate, 
	STATUS NUMBER(1,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_CNG_FILES ***
 exec bpa.alter_policies('OW_CNG_FILES');


COMMENT ON TABLE BARS.OW_CNG_FILES IS 'OpenWay. Імпортовані файли CNGEXPORT';
COMMENT ON COLUMN BARS.OW_CNG_FILES.KF IS '';
COMMENT ON COLUMN BARS.OW_CNG_FILES.ID IS 'Ід.';
COMMENT ON COLUMN BARS.OW_CNG_FILES.FILE_NAME IS 'Ім'я файлу';
COMMENT ON COLUMN BARS.OW_CNG_FILES.FILE_DATE IS 'Дата імпорту файлу';
COMMENT ON COLUMN BARS.OW_CNG_FILES.STATUS IS '0-файл загружен
1-файл обработан
-1-ошибка при обработке';




PROMPT *** Create  constraint CC_OWCNGFILES_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_CNG_FILES MODIFY (KF CONSTRAINT CC_OWCNGFILES_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWCNGFILES_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_CNG_FILES MODIFY (ID CONSTRAINT CC_OWCNGFILES_ID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWCNGFILES_FILENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_CNG_FILES MODIFY (FILE_NAME CONSTRAINT CC_OWCNGFILES_FILENAME_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWCNGFILES_FILEDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_CNG_FILES MODIFY (FILE_DATE CONSTRAINT CC_OWCNGFILES_FILEDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OWCNGFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_CNG_FILES ADD CONSTRAINT PK_OWCNGFILES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OWCNGFILES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OWCNGFILES ON BARS.OW_CNG_FILES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_CNG_FILES ***
grant SELECT                                                                 on OW_CNG_FILES    to BARSREADER_ROLE;
grant INSERT,SELECT                                                          on OW_CNG_FILES    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OW_CNG_FILES    to BARS_DM;
grant INSERT,SELECT                                                          on OW_CNG_FILES    to OW;
grant SELECT                                                                 on OW_CNG_FILES    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_CNG_FILES.sql =========*** End *** 
PROMPT ===================================================================================== 
