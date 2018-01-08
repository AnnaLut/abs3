

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/UPL_DM_OBJECTS_VERS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  table UPL_DM_OBJECTS_VERS ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.UPL_DM_OBJECTS_VERS 
   (	REPORT_DATE DATE, 
	KF CHAR(6), 
	OBJECT_ID NUMBER(38,0), 
	VERSION_ID NUMBER(2,0), 
	GROUP_ID NUMBER(38,0), 
	CREATED TIMESTAMP (6), 
	STATUS VARCHAR2(20), 
	OBJECT_NAME VARCHAR2(30)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSIMPDATA300465 ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.UPL_DM_OBJECTS_VERS IS '���� ���������, � ���� ��������� ������������';
COMMENT ON COLUMN BARSUPL.UPL_DM_OBJECTS_VERS.REPORT_DATE IS '��������� ����';
COMMENT ON COLUMN BARSUPL.UPL_DM_OBJECTS_VERS.KF IS '��� ������ (���)';
COMMENT ON COLUMN BARSUPL.UPL_DM_OBJECTS_VERS.OBJECT_ID IS 'DI ���������';
COMMENT ON COLUMN BARSUPL.UPL_DM_OBJECTS_VERS.VERSION_ID IS '����� ���������';
COMMENT ON COLUMN BARSUPL.UPL_DM_OBJECTS_VERS.GROUP_ID IS '������ ������������';
COMMENT ON COLUMN BARSUPL.UPL_DM_OBJECTS_VERS.CREATED IS '���� �� ��� ���������';
COMMENT ON COLUMN BARSUPL.UPL_DM_OBJECTS_VERS.STATUS IS '������';
COMMENT ON COLUMN BARSUPL.UPL_DM_OBJECTS_VERS.OBJECT_NAME IS '����� ���������';




PROMPT *** Create  constraint CC_UPLDMOBJVERS_REPORTDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_DM_OBJECTS_VERS MODIFY (REPORT_DATE CONSTRAINT CC_UPLDMOBJVERS_REPORTDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_UPLDMOBJVERS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_DM_OBJECTS_VERS MODIFY (KF CONSTRAINT CC_UPLDMOBJVERS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_UPLDMOBJVERS_OBJECTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_DM_OBJECTS_VERS MODIFY (OBJECT_ID CONSTRAINT CC_UPLDMOBJVERS_OBJECTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_UPLDMOBJVERS_VERSIONID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_DM_OBJECTS_VERS MODIFY (VERSION_ID CONSTRAINT CC_UPLDMOBJVERS_VERSIONID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_UPLDMOBJVERS ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_DM_OBJECTS_VERS ADD CONSTRAINT PK_UPLDMOBJVERS PRIMARY KEY (REPORT_DATE, KF, OBJECT_ID, GROUP_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSIMPDATA300465  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_UPLDMOBJVERS_CREATED_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_DM_OBJECTS_VERS MODIFY (CREATED CONSTRAINT CC_UPLDMOBJVERS_CREATED_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_UPLDMOBJVERS_STATUS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_DM_OBJECTS_VERS MODIFY (STATUS CONSTRAINT CC_UPLDMOBJVERS_STATUS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_UPLDMOBJVERS_OBJNM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_DM_OBJECTS_VERS MODIFY (OBJECT_NAME CONSTRAINT CC_UPLDMOBJVERS_OBJNM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_UPLDMOBJVERS_GROUPID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_DM_OBJECTS_VERS MODIFY (GROUP_ID CONSTRAINT CC_UPLDMOBJVERS_GROUPID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_UPLDMOBJVERS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.PK_UPLDMOBJVERS ON BARSUPL.UPL_DM_OBJECTS_VERS (REPORT_DATE, KF, OBJECT_ID, GROUP_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSIMPDATA300465 ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  UPL_DM_OBJECTS_VERS ***
grant SELECT                                                                 on UPL_DM_OBJECTS_VERS to BARS;
grant SELECT                                                                 on UPL_DM_OBJECTS_VERS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_DM_OBJECTS_VERS.sql =========**
PROMPT ===================================================================================== 
