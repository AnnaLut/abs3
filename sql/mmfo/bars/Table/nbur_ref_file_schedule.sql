

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_REF_FILE_SCHEDULE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_REF_FILE_SCHEDULE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_REF_FILE_SCHEDULE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_REF_FILE_SCHEDULE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_REF_FILE_SCHEDULE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_REF_FILE_SCHEDULE ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_REF_FILE_SCHEDULE 
   (	FILE_ID NUMBER(38,0), 
	DAYS_FORM NUMBER(2,0), 
	DATE_START DATE, 
	DATE_FINISH DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_REF_FILE_SCHEDULE ***
 exec bpa.alter_policies('NBUR_REF_FILE_SCHEDULE');


COMMENT ON TABLE BARS.NBUR_REF_FILE_SCHEDULE IS 'Зв`язок мiж глобальним файлом НБУ та перiодичнiстю формування';
COMMENT ON COLUMN BARS.NBUR_REF_FILE_SCHEDULE.FILE_ID IS 'Iдентифiкатор файлу НБУ';
COMMENT ON COLUMN BARS.NBUR_REF_FILE_SCHEDULE.DAYS_FORM IS 'Кiлькiсть днiв для формування з початку звітного періоду';
COMMENT ON COLUMN BARS.NBUR_REF_FILE_SCHEDULE.DATE_START IS 'Дата включення';
COMMENT ON COLUMN BARS.NBUR_REF_FILE_SCHEDULE.DATE_FINISH IS 'Дата виключення';




PROMPT *** Create  constraint SYS_C0084953 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_FILE_SCHEDULE MODIFY (FILE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_NBUR_REF_FILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_FILE_SCHEDULE ADD CONSTRAINT FK_NBUR_REF_FILES FOREIGN KEY (FILE_ID)
	  REFERENCES BARS.NBUR_REF_FILES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_NBUR_REF_FILE_SCHEDULE ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_FILE_SCHEDULE ADD CONSTRAINT UK_NBUR_REF_FILE_SCHEDULE UNIQUE (FILE_ID, DATE_START)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0084954 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_FILE_SCHEDULE MODIFY (DAYS_FORM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_NBUR_REF_FILE_SCHEDULE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_NBUR_REF_FILE_SCHEDULE ON BARS.NBUR_REF_FILE_SCHEDULE (FILE_ID, DATE_START) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_REF_FILE_SCHEDULE ***
grant SELECT                                                                 on NBUR_REF_FILE_SCHEDULE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_REF_FILE_SCHEDULE.sql =========**
PROMPT ===================================================================================== 
