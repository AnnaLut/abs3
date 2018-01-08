

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_REF_FILES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_REF_FILES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_REF_FILES'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_REF_FILES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_REF_FILES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_REF_FILES ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_REF_FILES 
   (	ID NUMBER(5,0), 
	FILE_CODE VARCHAR2(3), 
	SCHEME_CODE VARCHAR2(1), 
	FILE_TYPE VARCHAR2(1), 
	FILE_NAME VARCHAR2(255), 
	SCHEME_NUMBER VARCHAR2(2), 
	UNIT_CODE VARCHAR2(2), 
	PERIOD_TYPE VARCHAR2(1), 
	LOCATION_CODE VARCHAR2(1), 
	FILE_CODE_ALT VARCHAR2(2), 
	CONSOLIDATION_TYPE NUMBER(2,0), 
	VALUE_TYPE_IND VARCHAR2(1), 
	VIEW_NM VARCHAR2(30), 
	FLAG_TURNS NUMBER(1,0), 
	FILE_FMT VARCHAR2(3) DEFAULT ''TXT''
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_REF_FILES ***
 exec bpa.alter_policies('NBUR_REF_FILES');


COMMENT ON TABLE BARS.NBUR_REF_FILES IS 'Список файлiв та їх властивостей';
COMMENT ON COLUMN BARS.NBUR_REF_FILES.ID IS 'Iдентифiкатор файлу';
COMMENT ON COLUMN BARS.NBUR_REF_FILES.FILE_CODE IS 'Код файлу';
COMMENT ON COLUMN BARS.NBUR_REF_FILES.SCHEME_CODE IS 'Код схеми надання (A017)';
COMMENT ON COLUMN BARS.NBUR_REF_FILES.FILE_TYPE IS 'Тип файлу 1/2 [НБУ/внутрiшнiй]';
COMMENT ON COLUMN BARS.NBUR_REF_FILES.FILE_NAME IS 'Назва файлу';
COMMENT ON COLUMN BARS.NBUR_REF_FILES.SCHEME_NUMBER IS 'Номер схеми надання (A011)';
COMMENT ON COLUMN BARS.NBUR_REF_FILES.UNIT_CODE IS 'Код одиницi вимiру даних';
COMMENT ON COLUMN BARS.NBUR_REF_FILES.PERIOD_TYPE IS 'Код перiодичностi (A013)';
COMMENT ON COLUMN BARS.NBUR_REF_FILES.LOCATION_CODE IS 'Код розрiзу за мiсцем розташування (A012)';
COMMENT ON COLUMN BARS.NBUR_REF_FILES.FILE_CODE_ALT IS 'Альтернативний код файлу';
COMMENT ON COLUMN BARS.NBUR_REF_FILES.CONSOLIDATION_TYPE IS 'Тип консолiдацii';
COMMENT ON COLUMN BARS.NBUR_REF_FILES.VALUE_TYPE_IND IS 'Тип значення показника';
COMMENT ON COLUMN BARS.NBUR_REF_FILES.VIEW_NM IS 'Назва в`юхи (для БМД)';
COMMENT ON COLUMN BARS.NBUR_REF_FILES.FLAG_TURNS IS 'Ознака наявності оборотів у файлі (1-Так,0-Ні)';
COMMENT ON COLUMN BARS.NBUR_REF_FILES.FILE_FMT IS 'Формат файлу (TXT/XML)';




PROMPT *** Create  constraint CC_REFFILES_FILEFMT ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_FILES ADD CONSTRAINT CC_REFFILES_FILEFMT CHECK ( FILE_FMT in (''TXT'',''XML'') ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REFFILES_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_FILES MODIFY (ID CONSTRAINT CC_REFFILES_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REFFILES_FILECD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_FILES MODIFY (FILE_CODE CONSTRAINT CC_REFFILES_FILECD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REFFILES_SCHEMECD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_FILES MODIFY (SCHEME_CODE CONSTRAINT CC_REFFILES_SCHEMECD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REFFILES_FILETP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_FILES MODIFY (FILE_TYPE CONSTRAINT CC_REFFILES_FILETP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REFFILES_FILENM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_FILES MODIFY (FILE_NAME CONSTRAINT CC_REFFILES_FILENM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REFFILES_SCHEMENUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_FILES MODIFY (SCHEME_NUMBER CONSTRAINT CC_REFFILES_SCHEMENUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REFFILES_UNITCD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_FILES MODIFY (UNIT_CODE CONSTRAINT CC_REFFILES_UNITCD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REFFILES_PERIODTP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_FILES MODIFY (PERIOD_TYPE CONSTRAINT CC_REFFILES_PERIODTP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REFFILES_LOCATIONCD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_FILES MODIFY (LOCATION_CODE CONSTRAINT CC_REFFILES_LOCATIONCD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_NBURREFFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_FILES ADD CONSTRAINT PK_NBURREFFILES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_NBURREFFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_FILES ADD CONSTRAINT UK_NBURREFFILES UNIQUE (FILE_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NBURREFFILES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NBURREFFILES ON BARS.NBUR_REF_FILES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_NBURREFFILES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_NBURREFFILES ON BARS.NBUR_REF_FILES (FILE_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_REF_FILES ***
grant SELECT                                                                 on NBUR_REF_FILES  to BARSREADER_ROLE;
grant SELECT                                                                 on NBUR_REF_FILES  to BARSUPL;
grant SELECT                                                                 on NBUR_REF_FILES  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBUR_REF_FILES  to BARS_DM;
grant SELECT                                                                 on NBUR_REF_FILES  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_REF_FILES.sql =========*** End **
PROMPT ===================================================================================== 
