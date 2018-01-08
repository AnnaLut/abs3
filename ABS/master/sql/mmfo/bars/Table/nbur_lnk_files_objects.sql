

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_LNK_FILES_OBJECTS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_LNK_FILES_OBJECTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_LNK_FILES_OBJECTS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_LNK_FILES_OBJECTS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_LNK_FILES_OBJECTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_LNK_FILES_OBJECTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_LNK_FILES_OBJECTS 
   (	FILE_ID NUMBER(5,0), 
	OBJECT_ID NUMBER(5,0), 
	START_DATE DATE, 
	FINISH_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_LNK_FILES_OBJECTS ***
 exec bpa.alter_policies('NBUR_LNK_FILES_OBJECTS');


COMMENT ON TABLE BARS.NBUR_LNK_FILES_OBJECTS IS 'Зв`язок мiж об`єктами та файлами НБУ';
COMMENT ON COLUMN BARS.NBUR_LNK_FILES_OBJECTS.FILE_ID IS 'Iдентифiкатор файлу НБУ';
COMMENT ON COLUMN BARS.NBUR_LNK_FILES_OBJECTS.OBJECT_ID IS 'Iдентифiкатор об`єкту';
COMMENT ON COLUMN BARS.NBUR_LNK_FILES_OBJECTS.START_DATE IS 'Дата початку дii зв`язку';
COMMENT ON COLUMN BARS.NBUR_LNK_FILES_OBJECTS.FINISH_DATE IS 'Дата закiнчення дii зв`язку';




PROMPT *** Create  constraint CC_REFLNKFILEOBJS_FILEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LNK_FILES_OBJECTS MODIFY (FILE_ID CONSTRAINT CC_REFLNKFILEOBJS_FILEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REFLNKFILEOBJS_OBJECTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LNK_FILES_OBJECTS MODIFY (OBJECT_ID CONSTRAINT CC_REFLNKFILEOBJS_OBJECTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_REFLNKFILEOBJS_OBJECTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LNK_FILES_OBJECTS ADD CONSTRAINT FK_REFLNKFILEOBJS_OBJECTS FOREIGN KEY (OBJECT_ID)
	  REFERENCES BARS.NBUR_REF_OBJECTS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_REFLNKFILEOBJS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LNK_FILES_OBJECTS ADD CONSTRAINT UK_REFLNKFILEOBJS UNIQUE (FILE_ID, OBJECT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_REFLNKFILEOBJS_FILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LNK_FILES_OBJECTS ADD CONSTRAINT FK_REFLNKFILEOBJS_FILES FOREIGN KEY (FILE_ID)
	  REFERENCES BARS.NBUR_REF_FILES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REFLNKFILEOBJS_STARTDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LNK_FILES_OBJECTS MODIFY (START_DATE CONSTRAINT CC_REFLNKFILEOBJS_STARTDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_REFLNKFILEOBJS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_REFLNKFILEOBJS ON BARS.NBUR_LNK_FILES_OBJECTS (FILE_ID, OBJECT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_LNK_FILES_OBJECTS ***
grant SELECT                                                                 on NBUR_LNK_FILES_OBJECTS to BARSUPL;
grant SELECT                                                                 on NBUR_LNK_FILES_OBJECTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBUR_LNK_FILES_OBJECTS to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_LNK_FILES_OBJECTS.sql =========**
PROMPT ===================================================================================== 
