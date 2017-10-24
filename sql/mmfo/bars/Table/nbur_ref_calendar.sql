

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_REF_CALENDAR.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_REF_CALENDAR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_REF_CALENDAR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NBUR_REF_CALENDAR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_REF_CALENDAR ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_REF_CALENDAR 
   (	ID NUMBER(38,0), 
	CALENDAR_DATE DATE, 
	REPORT_DATE DATE, 
	FILE_ID NUMBER(5,0), 
	KF CHAR(6), 
	STATUS VARCHAR2(20)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_REF_CALENDAR ***
 exec bpa.alter_policies('NBUR_REF_CALENDAR');


COMMENT ON TABLE BARS.NBUR_REF_CALENDAR IS 'Календар формування файлiв НБУ';
COMMENT ON COLUMN BARS.NBUR_REF_CALENDAR.ID IS 'Iдентифiкатор запису';
COMMENT ON COLUMN BARS.NBUR_REF_CALENDAR.CALENDAR_DATE IS 'Календарна дата';
COMMENT ON COLUMN BARS.NBUR_REF_CALENDAR.REPORT_DATE IS 'Звiтна дата';
COMMENT ON COLUMN BARS.NBUR_REF_CALENDAR.FILE_ID IS 'Iдентифiкатор файлу НБУ';
COMMENT ON COLUMN BARS.NBUR_REF_CALENDAR.KF IS 'Код фiлii';
COMMENT ON COLUMN BARS.NBUR_REF_CALENDAR.STATUS IS 'Статус';




PROMPT *** Create  constraint SYS_C0084966 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_CALENDAR MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0084967 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_CALENDAR MODIFY (CALENDAR_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_FILES_CALENDAR ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_CALENDAR ADD CONSTRAINT FK_FILES_CALENDAR FOREIGN KEY (FILE_ID)
	  REFERENCES BARS.NBUR_REF_FILES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0084969 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_CALENDAR MODIFY (FILE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_NBUR_REF_CALENDAR ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_CALENDAR ADD CONSTRAINT PK_NBUR_REF_CALENDAR PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0084968 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_CALENDAR MODIFY (REPORT_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NBUR_REF_CALENDAR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NBUR_REF_CALENDAR ON BARS.NBUR_REF_CALENDAR (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_REF_CALENDAR ***
grant SELECT                                                                 on NBUR_REF_CALENDAR to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_REF_CALENDAR.sql =========*** End
PROMPT ===================================================================================== 
