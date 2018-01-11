

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_LST_OBJECTS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_LST_OBJECTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_LST_OBJECTS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_LST_OBJECTS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''E'');
               bpa.alter_policy_info(''NBUR_LST_OBJECTS'', ''WHOLE'' , null, null, null, ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_LST_OBJECTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_LST_OBJECTS 
   (	REPORT_DATE DATE, 
	KF CHAR(6), 
	VERSION_ID NUMBER(3,0), 
	OBJECT_ID NUMBER(38,0), 
	START_TIME TIMESTAMP (6), 
	FINISH_TIME TIMESTAMP (6), 
	OBJECT_STATUS VARCHAR2(20), 
	ROW_COUNT NUMBER(9,0), 
	ERR_REC_ID NUMBER(38,0), 
	VLD NUMBER(3,0) GENERATED ALWAYS AS (DECODE(OBJECT_STATUS,''FINISHED'',0,''BLOCKED'',0,VERSION_ID)) VIRTUAL VISIBLE 
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_LST_OBJECTS ***
 exec bpa.alter_policies('NBUR_LST_OBJECTS');


COMMENT ON TABLE BARS.NBUR_LST_OBJECTS IS 'Список завантажених об^ектiв';
COMMENT ON COLUMN BARS.NBUR_LST_OBJECTS.REPORT_DATE IS 'Звiтна дата';
COMMENT ON COLUMN BARS.NBUR_LST_OBJECTS.KF IS 'Код фiлiалу (МФО)';
COMMENT ON COLUMN BARS.NBUR_LST_OBJECTS.VERSION_ID IS 'Ід. версії (для кожного фiлiалу своя)';
COMMENT ON COLUMN BARS.NBUR_LST_OBJECTS.OBJECT_ID IS 'Iдентифiкатор об^екту';
COMMENT ON COLUMN BARS.NBUR_LST_OBJECTS.START_TIME IS 'Дата початку завантаження';
COMMENT ON COLUMN BARS.NBUR_LST_OBJECTS.FINISH_TIME IS 'Дата закiнчення завантаження';
COMMENT ON COLUMN BARS.NBUR_LST_OBJECTS.OBJECT_STATUS IS 'Статус об`екту';
COMMENT ON COLUMN BARS.NBUR_LST_OBJECTS.ROW_COUNT IS 'Кiлькiсть записiв';
COMMENT ON COLUMN BARS.NBUR_LST_OBJECTS.ERR_REC_ID IS 'Ід. запису про помилку в журналі подій АБС';
COMMENT ON COLUMN BARS.NBUR_LST_OBJECTS.VLD IS 'Valid version';




PROMPT *** Create  constraint CC_NBURLSTOBJECTS_REPORTDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_OBJECTS MODIFY (REPORT_DATE CONSTRAINT CC_NBURLSTOBJECTS_REPORTDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBURLSTOBJECTS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_OBJECTS MODIFY (KF CONSTRAINT CC_NBURLSTOBJECTS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBURLSTOBJECTS_VERSIONID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_OBJECTS MODIFY (VERSION_ID CONSTRAINT CC_NBURLSTOBJECTS_VERSIONID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBURLSTOBJECTS_OBJECTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_OBJECTS MODIFY (OBJECT_ID CONSTRAINT CC_NBURLSTOBJECTS_OBJECTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBURLSTOBJECTS_STARTTM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_OBJECTS MODIFY (START_TIME CONSTRAINT CC_NBURLSTOBJECTS_STARTTM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBURLSTOBJECTS_OBJSTATUS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_OBJECTS MODIFY (OBJECT_STATUS CONSTRAINT CC_NBURLSTOBJECTS_OBJSTATUS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBURLSTOBJECTS_FINISHTM ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_OBJECTS ADD CONSTRAINT CC_NBURLSTOBJECTS_FINISHTM CHECK ( FINISH_TIME > START_TIME ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_NBURLSTOBJECTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_OBJECTS ADD CONSTRAINT UK_NBURLSTOBJECTS UNIQUE (REPORT_DATE, KF, VERSION_ID, OBJECT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_NBURLSTOBJECTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_NBURLSTOBJECTS ON BARS.NBUR_LST_OBJECTS (REPORT_DATE, KF, VERSION_ID, OBJECT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_NBURLSTOBJECTS_OBJECTSTATUS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_NBURLSTOBJECTS_OBJECTSTATUS ON BARS.NBUR_LST_OBJECTS (REPORT_DATE, KF, OBJECT_ID, VLD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 3 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_LST_OBJECTS ***
grant SELECT                                                                 on NBUR_LST_OBJECTS to BARSREADER_ROLE;
grant SELECT                                                                 on NBUR_LST_OBJECTS to BARSUPL;
grant SELECT                                                                 on NBUR_LST_OBJECTS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBUR_LST_OBJECTS to BARS_DM;
grant SELECT                                                                 on NBUR_LST_OBJECTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_LST_OBJECTS.sql =========*** End 
PROMPT ===================================================================================== 
