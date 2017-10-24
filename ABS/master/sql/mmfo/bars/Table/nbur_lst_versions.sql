

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_LST_VERSIONS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_LST_VERSIONS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_LST_VERSIONS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_LST_VERSIONS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''E'');
               bpa.alter_policy_info(''NBUR_LST_VERSIONS'', ''WHOLE'' , null, null, null, ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_LST_VERSIONS ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_LST_VERSIONS 
   (	ID NUMBER(38,0), 
	REPORT_DATE DATE, 
	KF CHAR(6), 
	VERSION_ID NUMBER(3,0), 
	CREATED_TIME TIMESTAMP (6) DEFAULT SysTimeStamp, 
	STATUS VARCHAR2(20) DEFAULT ''NEW''
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_LST_VERSIONS ***
 exec bpa.alter_policies('NBUR_LST_VERSIONS');


COMMENT ON TABLE BARS.NBUR_LST_VERSIONS IS 'Список версій датамартів для файлiв звiтностi';
COMMENT ON COLUMN BARS.NBUR_LST_VERSIONS.ID IS '';
COMMENT ON COLUMN BARS.NBUR_LST_VERSIONS.REPORT_DATE IS 'Звітна дата';
COMMENT ON COLUMN BARS.NBUR_LST_VERSIONS.KF IS 'Код фiлiалу (МФО)';
COMMENT ON COLUMN BARS.NBUR_LST_VERSIONS.VERSION_ID IS 'Ід. версії (для кожного фiлiалу своя)';
COMMENT ON COLUMN BARS.NBUR_LST_VERSIONS.CREATED_TIME IS 'Час створення версії';
COMMENT ON COLUMN BARS.NBUR_LST_VERSIONS.STATUS IS 'Статус версії';




PROMPT *** Create  constraint CC_NBURLSTVERSIONS_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_VERSIONS MODIFY (ID CONSTRAINT CC_NBURLSTVERSIONS_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBURLSTVERSIONS_REPORTDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_VERSIONS MODIFY (REPORT_DATE CONSTRAINT CC_NBURLSTVERSIONS_REPORTDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBURLSTVERSIONS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_VERSIONS MODIFY (KF CONSTRAINT CC_NBURLSTVERSIONS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_NBURLSTVERSIONS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_VERSIONS ADD CONSTRAINT UK_NBURLSTVERSIONS UNIQUE (REPORT_DATE, KF, VERSION_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0032806 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_VERSIONS MODIFY (CREATED_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0032807 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_VERSIONS MODIFY (STATUS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_NBURLSTVERSIONS ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_VERSIONS ADD CONSTRAINT PK_NBURLSTVERSIONS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NBURLSTVERSIONS_VERSNID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LST_VERSIONS MODIFY (VERSION_ID CONSTRAINT CC_NBURLSTVERSIONS_VERSNID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NBURLSTVERSIONS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NBURLSTVERSIONS ON BARS.NBUR_LST_VERSIONS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_NBURLSTVERSIONS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_NBURLSTVERSIONS ON BARS.NBUR_LST_VERSIONS (REPORT_DATE, KF, VERSION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_LST_VERSIONS ***
grant SELECT                                                                 on NBUR_LST_VERSIONS to BARSUPL;
grant SELECT                                                                 on NBUR_LST_VERSIONS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBUR_LST_VERSIONS to BARS_DM;



PROMPT *** Create SYNONYM  to NBUR_LST_VERSIONS ***

  CREATE OR REPLACE SYNONYM BARS.DM_VERSIONS_LIST FOR BARS.NBUR_LST_VERSIONS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_LST_VERSIONS.sql =========*** End
PROMPT ===================================================================================== 
