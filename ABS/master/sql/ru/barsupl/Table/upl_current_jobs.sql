

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/UPL_CURRENT_JOBS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  table UPL_CURRENT_JOBS ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.UPL_CURRENT_JOBS 
   (	JOB_ID NUMBER, 
	STAT_ID NUMBER, 
	GROUP_ID NUMBER, 
	GROUP_STATID NUMBER, 
	BANK_DATE DATE, 
	START_TIME DATE, 
	SID_ID NUMBER, 
	STATUS_ID NUMBER, 
	CURRENT_FILEID NUMBER, 
	LAST_FILENAME VARCHAR2(200)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSUPLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.UPL_CURRENT_JOBS IS '���������� � ������� ��������. �� ������ ������� ���� �������� ������� ������ ����� ������ ��������. ������ ��������� � ������� ���� ��� ��������� ������� � ���������� ����� ������ ��������';
COMMENT ON COLUMN BARSUPL.UPL_CURRENT_JOBS.GROUP_ID IS '��� ����������� ������';
COMMENT ON COLUMN BARSUPL.UPL_CURRENT_JOBS.GROUP_STATID IS '��� �� upl_stats.id ��� ������, ������� �������� ���� ����';
COMMENT ON COLUMN BARSUPL.UPL_CURRENT_JOBS.BANK_DATE IS '����. ���� ��������';
COMMENT ON COLUMN BARSUPL.UPL_CURRENT_JOBS.START_TIME IS '����� ������ ��������';
COMMENT ON COLUMN BARSUPL.UPL_CURRENT_JOBS.SID_ID IS 'Oraccle sid  ������, ������ ���������� ��������';
COMMENT ON COLUMN BARSUPL.UPL_CURRENT_JOBS.STATUS_ID IS '������� ������ ��������';
COMMENT ON COLUMN BARSUPL.UPL_CURRENT_JOBS.CURRENT_FILEID IS '������� ����������� ����';
COMMENT ON COLUMN BARSUPL.UPL_CURRENT_JOBS.LAST_FILENAME IS '��� ���������� ������������ �����';
COMMENT ON COLUMN BARSUPL.UPL_CURRENT_JOBS.JOB_ID IS '���������������� ���';
COMMENT ON COLUMN BARSUPL.UPL_CURRENT_JOBS.STAT_ID IS '��� �� upl_stats.id ��� ������ �� ����� �����';




PROMPT *** Create  constraint UK_UPLCURJOBS_GROUPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_CURRENT_JOBS ADD CONSTRAINT UK_UPLCURJOBS_GROUPDATE UNIQUE (GROUP_ID, BANK_DATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_UPLCURRENTJOBS ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_CURRENT_JOBS ADD CONSTRAINT PK_UPLCURRENTJOBS PRIMARY KEY (JOB_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_UPLCURRENTJOBS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.PK_UPLCURRENTJOBS ON BARSUPL.UPL_CURRENT_JOBS (JOB_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_UPLCURJOBS_GROUPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.UK_UPLCURJOBS_GROUPDATE ON BARSUPL.UPL_CURRENT_JOBS (GROUP_ID, BANK_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_CURRENT_JOBS.sql =========*** E
PROMPT ===================================================================================== 
