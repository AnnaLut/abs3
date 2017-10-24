

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DWH_CBIREP_QUERIES.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DWH_CBIREP_QUERIES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DWH_CBIREP_QUERIES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DWH_CBIREP_QUERIES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DWH_CBIREP_QUERIES ***
begin 
  execute immediate '
  CREATE TABLE BARS.DWH_CBIREP_QUERIES 
   (	ID NUMBER, 
	USERID NUMBER, 
	REP_ID NUMBER, 
	KEY_PARAMS VARCHAR2(4000), 
	FILE_NAMES VARCHAR2(4000) DEFAULT ''reports.zip'', 
	CREATION_TIME DATE DEFAULT sysdate, 
	STATUS_ID VARCHAR2(100), 
	STATUS_DATE DATE, 
	SESSION_ID NUMBER, 
	JOB_ID NUMBER, 
	COMM VARCHAR2(4000), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'', ''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DWH_CBIREP_QUERIES ***
 exec bpa.alter_policies('DWH_CBIREP_QUERIES');


COMMENT ON TABLE BARS.DWH_CBIREP_QUERIES IS '������ �� ������������ ������';
COMMENT ON COLUMN BARS.DWH_CBIREP_QUERIES.ID IS '�� �������';
COMMENT ON COLUMN BARS.DWH_CBIREP_QUERIES.USERID IS '�� ������������';
COMMENT ON COLUMN BARS.DWH_CBIREP_QUERIES.REP_ID IS '�� ������';
COMMENT ON COLUMN BARS.DWH_CBIREP_QUERIES.KEY_PARAMS IS '���� ����������� �� ���������� ������';
COMMENT ON COLUMN BARS.DWH_CBIREP_QUERIES.FILE_NAMES IS '';
COMMENT ON COLUMN BARS.DWH_CBIREP_QUERIES.CREATION_TIME IS '���� �������� ������';
COMMENT ON COLUMN BARS.DWH_CBIREP_QUERIES.STATUS_ID IS '������� ������ ������';
COMMENT ON COLUMN BARS.DWH_CBIREP_QUERIES.STATUS_DATE IS '���� �������� ������� ������';
COMMENT ON COLUMN BARS.DWH_CBIREP_QUERIES.SESSION_ID IS '���������� �� ������';
COMMENT ON COLUMN BARS.DWH_CBIREP_QUERIES.JOB_ID IS '�� ����� ��������������� ������';
COMMENT ON COLUMN BARS.DWH_CBIREP_QUERIES.COMM IS '';
COMMENT ON COLUMN BARS.DWH_CBIREP_QUERIES.BRANCH IS '';




PROMPT *** Create  constraint FK_DWHBIREPQUER_STATUS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.DWH_CBIREP_QUERIES ADD CONSTRAINT FK_DWHBIREPQUER_STATUS_ID FOREIGN KEY (STATUS_ID)
	  REFERENCES BARS.DWH_CBIREP_QUERY_STATUSES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DWHCBIREPQUER_CRTTIME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DWH_CBIREP_QUERIES MODIFY (CREATION_TIME CONSTRAINT CC_DWHCBIREPQUER_CRTTIME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DWHCBIREPQUERIES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DWH_CBIREP_QUERIES ADD CONSTRAINT PK_DWHCBIREPQUERIES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DWHCBIREPQUER_STSDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DWH_CBIREP_QUERIES MODIFY (STATUS_DATE CONSTRAINT CC_DWHCBIREPQUER_STSDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DWHCBIREPQUER_STATUSID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DWH_CBIREP_QUERIES MODIFY (STATUS_ID CONSTRAINT CC_DWHCBIREPQUER_STATUSID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CBIREPQUER_FILENAMES_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DWH_CBIREP_QUERIES MODIFY (FILE_NAMES CONSTRAINT CC_CBIREPQUER_FILENAMES_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DWHCBIREPQUER_KEYPARS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DWH_CBIREP_QUERIES MODIFY (KEY_PARAMS CONSTRAINT CC_DWHCBIREPQUER_KEYPARS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DWHCBIREPQUER_REPID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DWH_CBIREP_QUERIES MODIFY (REP_ID CONSTRAINT CC_DWHCBIREPQUER_REPID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DWHCBIREPQUER_USERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DWH_CBIREP_QUERIES MODIFY (USERID CONSTRAINT CC_DWHCBIREPQUER_USERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DWHCBIREPQUERIES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DWHCBIREPQUERIES ON BARS.DWH_CBIREP_QUERIES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_DWHCBIREPQ_REPID ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_DWHCBIREPQ_REPID ON BARS.DWH_CBIREP_QUERIES (REP_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DWH_CBIREP_QUERIES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DWH_CBIREP_QUERIES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DWH_CBIREP_QUERIES.sql =========*** En
PROMPT ===================================================================================== 
