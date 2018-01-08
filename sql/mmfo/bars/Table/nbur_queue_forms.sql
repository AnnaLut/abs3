

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_QUEUE_FORMS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_QUEUE_FORMS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_QUEUE_FORMS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_QUEUE_FORMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_QUEUE_FORMS 
   (	ID NUMBER(38,0), 
	REPORT_DATE DATE, 
	KF VARCHAR2(6), 
	DATE_START DATE, 
	USER_ID NUMBER(12,0), 
	STATUS NUMBER(1,0) DEFAULT 0, 
	PROC_TYPE NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS NOLOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_QUEUE_FORMS ***
 exec bpa.alter_policies('NBUR_QUEUE_FORMS');


COMMENT ON TABLE BARS.NBUR_QUEUE_FORMS IS 'Черга на формування файлiв';
COMMENT ON COLUMN BARS.NBUR_QUEUE_FORMS.ID IS 'Iдентифiкатор запису';
COMMENT ON COLUMN BARS.NBUR_QUEUE_FORMS.REPORT_DATE IS 'Звiтна дата';
COMMENT ON COLUMN BARS.NBUR_QUEUE_FORMS.KF IS 'Код фiлii';
COMMENT ON COLUMN BARS.NBUR_QUEUE_FORMS.DATE_START IS 'Дата вставки в чергу';
COMMENT ON COLUMN BARS.NBUR_QUEUE_FORMS.USER_ID IS 'Iдентифiкатор користувача';
COMMENT ON COLUMN BARS.NBUR_QUEUE_FORMS.STATUS IS 'Статус обробки файлів (0 - в черзі, 1 - в обробці)';
COMMENT ON COLUMN BARS.NBUR_QUEUE_FORMS.PROC_TYPE IS 'Тип процедури (0 - без, 1 - нова, 2 - стара)';




PROMPT *** Create  constraint CC_QUEUEFORMS_STATUS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_QUEUE_FORMS ADD CONSTRAINT CC_QUEUEFORMS_STATUS CHECK ( STATUS in ( 0, 1 ) ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_QUEUEFORMS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_QUEUE_FORMS MODIFY (ID CONSTRAINT CC_QUEUEFORMS_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_QUEUEFORMS_RPTDT ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_QUEUE_FORMS MODIFY (REPORT_DATE CONSTRAINT CC_QUEUEFORMS_RPTDT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_QUEUEFORMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_QUEUE_FORMS ADD CONSTRAINT UK_QUEUEFORMS UNIQUE (ID, REPORT_DATE, KF, STATUS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS NOLOGGING 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_QUEUEFORMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_QUEUEFORMS ON BARS.NBUR_QUEUE_FORMS (ID, REPORT_DATE, KF, STATUS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS NOLOGGING 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_QUEUE_FORMS ***
grant SELECT                                                                 on NBUR_QUEUE_FORMS to BARSREADER_ROLE;
grant SELECT                                                                 on NBUR_QUEUE_FORMS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBUR_QUEUE_FORMS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_QUEUE_FORMS.sql =========*** End 
PROMPT ===================================================================================== 
