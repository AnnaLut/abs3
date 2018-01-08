

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_LST_ERRORS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_LST_ERRORS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_LST_ERRORS'', ''FILIAL'' , ''M'', ''M'', null, null);
               bpa.alter_policy_info(''NBUR_LST_ERRORS'', ''WHOLE'' , null, ''E'', null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_LST_ERRORS ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_LST_ERRORS 
   (	REPORT_DATE DATE, 
	KF CHAR(6), 
	REPORT_CODE CHAR(3), 
	VERSION_ID NUMBER(3,0), 
	ERROR_ID NUMBER(38,0), 
	ERROR_TXT VARCHAR2(2000), 
	USERID NUMBER(38,0), 
	FILE_ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_LST_ERRORS ***
 exec bpa.alter_policies('NBUR_LST_ERRORS');


COMMENT ON TABLE BARS.NBUR_LST_ERRORS IS 'Список помилок при формуванні файлу';
COMMENT ON COLUMN BARS.NBUR_LST_ERRORS.REPORT_DATE IS 'Звiтна дата';
COMMENT ON COLUMN BARS.NBUR_LST_ERRORS.KF IS 'Код фiлiалу (МФО)';
COMMENT ON COLUMN BARS.NBUR_LST_ERRORS.REPORT_CODE IS 'Код файлу';
COMMENT ON COLUMN BARS.NBUR_LST_ERRORS.VERSION_ID IS 'Ід. версії (для кожного фiлiалу своя)';
COMMENT ON COLUMN BARS.NBUR_LST_ERRORS.ERROR_ID IS 'Iдентифiкатор повідомлення';
COMMENT ON COLUMN BARS.NBUR_LST_ERRORS.ERROR_TXT IS 'Текст повідомлення';
COMMENT ON COLUMN BARS.NBUR_LST_ERRORS.USERID IS 'Ініціатор формування';
COMMENT ON COLUMN BARS.NBUR_LST_ERRORS.FILE_ID IS 'Ід-р файлу';




PROMPT *** Create  constraint CC_NBURLSTERRS_REPORTDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_ERRORS MODIFY (REPORT_DATE CONSTRAINT CC_NBURLSTERRS_REPORTDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBURLSTERRS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_ERRORS MODIFY (KF CONSTRAINT CC_NBURLSTERRS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBURLSTERRS_REPORTCD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_ERRORS MODIFY (REPORT_CODE CONSTRAINT CC_NBURLSTERRS_REPORTCD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBURLSTERRS_VERSIONID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_ERRORS MODIFY (VERSION_ID CONSTRAINT CC_NBURLSTERRS_VERSIONID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBURLSTERRS_ERRORID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_ERRORS MODIFY (ERROR_ID CONSTRAINT CC_NBURLSTERRS_ERRORID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_NBURLSTERRS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_NBURLSTERRS ON BARS.NBUR_LST_ERRORS (REPORT_DATE, KF, REPORT_CODE, VERSION_ID, ERROR_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_LST_ERRORS ***
grant SELECT                                                                 on NBUR_LST_ERRORS to BARSUPL;
grant SELECT                                                                 on NBUR_LST_ERRORS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBUR_LST_ERRORS to BARS_DM;
grant SELECT                                                                 on NBUR_LST_ERRORS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_LST_ERRORS.sql =========*** End *
PROMPT ===================================================================================== 
