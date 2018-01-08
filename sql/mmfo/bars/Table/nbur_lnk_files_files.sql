

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_LNK_FILES_FILES.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_LNK_FILES_FILES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_LNK_FILES_FILES'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_LNK_FILES_FILES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_LNK_FILES_FILES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_LNK_FILES_FILES ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_LNK_FILES_FILES 
   (	FILE_ID NUMBER(5,0), 
	FILE_DEP_ID NUMBER(5,0), 
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




PROMPT *** ALTER_POLICIES to NBUR_LNK_FILES_FILES ***
 exec bpa.alter_policies('NBUR_LNK_FILES_FILES');


COMMENT ON TABLE BARS.NBUR_LNK_FILES_FILES IS 'Зв`язок мiж файлами НБУ (перехресний контроль)';
COMMENT ON COLUMN BARS.NBUR_LNK_FILES_FILES.FILE_ID IS 'Iдентифiкатор файлу НБУ';
COMMENT ON COLUMN BARS.NBUR_LNK_FILES_FILES.FILE_DEP_ID IS 'Iдентифiкатор залежного файлу';
COMMENT ON COLUMN BARS.NBUR_LNK_FILES_FILES.START_DATE IS 'Дата початку дii зв`язку';
COMMENT ON COLUMN BARS.NBUR_LNK_FILES_FILES.FINISH_DATE IS 'Дата закiнчення дii зв`язку';




PROMPT *** Create  constraint CC_REFLNKFILFILS_FILID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LNK_FILES_FILES MODIFY (FILE_ID CONSTRAINT CC_REFLNKFILFILS_FILID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REFLNKFILFILS_FILDEPID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LNK_FILES_FILES MODIFY (FILE_DEP_ID CONSTRAINT CC_REFLNKFILFILS_FILDEPID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REFLNKFILFILS_STARTDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LNK_FILES_FILES MODIFY (START_DATE CONSTRAINT CC_REFLNKFILFILS_STARTDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_REFLNKFILFILS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LNK_FILES_FILES ADD CONSTRAINT UK_REFLNKFILFILS UNIQUE (FILE_ID, FILE_DEP_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_REFLNKFILFILS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_REFLNKFILFILS ON BARS.NBUR_LNK_FILES_FILES (FILE_ID, FILE_DEP_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_LNK_FILES_FILES ***
grant SELECT                                                                 on NBUR_LNK_FILES_FILES to BARSREADER_ROLE;
grant SELECT                                                                 on NBUR_LNK_FILES_FILES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBUR_LNK_FILES_FILES to BARS_DM;
grant SELECT                                                                 on NBUR_LNK_FILES_FILES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_LNK_FILES_FILES.sql =========*** 
PROMPT ===================================================================================== 
