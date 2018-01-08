

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_QUEUE_OBJECTS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_QUEUE_OBJECTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_QUEUE_OBJECTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_QUEUE_OBJECTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_QUEUE_OBJECTS 
   (	ID NUMBER(38,0), 
	REPORT_DATE DATE, 
	KF VARCHAR2(6), 
	DATE_START DATE, 
	ROW_COUNT NUMBER(9,0), 
	STATUS NUMBER(1,0) DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_QUEUE_OBJECTS ***
 exec bpa.alter_policies('NBUR_QUEUE_OBJECTS');


COMMENT ON TABLE BARS.NBUR_QUEUE_OBJECTS IS 'Черга на завантаження об`ектiв';
COMMENT ON COLUMN BARS.NBUR_QUEUE_OBJECTS.ID IS 'Iдентифiкатор об^екту';
COMMENT ON COLUMN BARS.NBUR_QUEUE_OBJECTS.REPORT_DATE IS 'Звiтна дата';
COMMENT ON COLUMN BARS.NBUR_QUEUE_OBJECTS.KF IS 'Код фiлii';
COMMENT ON COLUMN BARS.NBUR_QUEUE_OBJECTS.DATE_START IS 'Дата вставки в чергу';
COMMENT ON COLUMN BARS.NBUR_QUEUE_OBJECTS.ROW_COUNT IS 'Кiлькiсть сформованих записiв';
COMMENT ON COLUMN BARS.NBUR_QUEUE_OBJECTS.STATUS IS 'Статус обробки файлів (0 - в черзі, 1 - в обробці)';




PROMPT *** Create  constraint CC_QUEUEOBJECTS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_QUEUE_OBJECTS MODIFY (ID CONSTRAINT CC_QUEUEOBJECTS_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_QUEUEOBJECTS_REPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_QUEUE_OBJECTS MODIFY (REPORT_DATE CONSTRAINT CC_QUEUEOBJECTS_REPDATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_QUEUEOBJECTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_QUEUE_OBJECTS ADD CONSTRAINT UK_QUEUEOBJECTS UNIQUE (ID, REPORT_DATE, KF, STATUS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_QUEUEOBJECTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_QUEUEOBJECTS ON BARS.NBUR_QUEUE_OBJECTS (ID, REPORT_DATE, KF, STATUS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_QUEUE_OBJECTS ***
grant SELECT                                                                 on NBUR_QUEUE_OBJECTS to BARSREADER_ROLE;
grant SELECT                                                                 on NBUR_QUEUE_OBJECTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBUR_QUEUE_OBJECTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_QUEUE_OBJECTS.sql =========*** En
PROMPT ===================================================================================== 
