

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CBIREP_QUERIES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CBIREP_QUERIES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CBIREP_QUERIES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CBIREP_QUERIES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CBIREP_QUERIES ***
begin 
  execute immediate '
  CREATE TABLE BARS.CBIREP_QUERIES 
   (	ID NUMBER, 
	BRANCH VARCHAR2(30), 
	USERID NUMBER, 
	REP_ID NUMBER, 
	KEY_PARAMS VARCHAR2(4000), 
	XML_PARAMS VARCHAR2(4000), 
	CREATION_TIME DATE DEFAULT sysdate, 
	STATUS_ID VARCHAR2(100), 
	STATUS_DATE DATE, 
	SESSION_ID NUMBER, 
	JOB_ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CBIREP_QUERIES ***
 exec bpa.alter_policies('CBIREP_QUERIES');


COMMENT ON TABLE BARS.CBIREP_QUERIES IS '������ �� ������������ ������';
COMMENT ON COLUMN BARS.CBIREP_QUERIES.ID IS '�� �������';
COMMENT ON COLUMN BARS.CBIREP_QUERIES.BRANCH IS '��� ������ ����������';
COMMENT ON COLUMN BARS.CBIREP_QUERIES.USERID IS '�� ������������';
COMMENT ON COLUMN BARS.CBIREP_QUERIES.REP_ID IS '�� ������';
COMMENT ON COLUMN BARS.CBIREP_QUERIES.KEY_PARAMS IS '���� ����������� �� ���������� ������';
COMMENT ON COLUMN BARS.CBIREP_QUERIES.XML_PARAMS IS 'XML � �������� �������� ����������';
COMMENT ON COLUMN BARS.CBIREP_QUERIES.CREATION_TIME IS '���� �������� ������';
COMMENT ON COLUMN BARS.CBIREP_QUERIES.STATUS_ID IS '������� ������ ������';
COMMENT ON COLUMN BARS.CBIREP_QUERIES.STATUS_DATE IS '���� �������� ������� ������';
COMMENT ON COLUMN BARS.CBIREP_QUERIES.SESSION_ID IS '���������� �� ������';
COMMENT ON COLUMN BARS.CBIREP_QUERIES.JOB_ID IS '�� ����� ��������������� ������';




PROMPT *** Create  constraint FK_CBIREPQS_RSTMPSESDATA_SESID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CBIREP_QUERIES ADD CONSTRAINT FK_CBIREPQS_RSTMPSESDATA_SESID FOREIGN KEY (SESSION_ID)
	  REFERENCES BARS.RS_TMP_SESSION_DATA (SESSION_ID) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CBIREPQS_CBIREPQSTATS_STSID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CBIREP_QUERIES ADD CONSTRAINT FK_CBIREPQS_CBIREPQSTATS_STSID FOREIGN KEY (STATUS_ID)
	  REFERENCES BARS.CBIREP_QUERY_STATUSES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CBIREPQS_REPORTS_REPID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CBIREP_QUERIES ADD CONSTRAINT FK_CBIREPQS_REPORTS_REPID FOREIGN KEY (REP_ID)
	  REFERENCES BARS.REPORTS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CBIREPQS_STAFF_USERID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CBIREP_QUERIES ADD CONSTRAINT FK_CBIREPQS_STAFF_USERID FOREIGN KEY (USERID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_CBIREPQUERIES ***
begin   
 execute immediate '
  ALTER TABLE BARS.CBIREP_QUERIES ADD CONSTRAINT UK_CBIREPQUERIES UNIQUE (USERID, REP_ID, KEY_PARAMS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 165 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CBIREPQUERIES ***
begin   
 execute immediate '
  ALTER TABLE BARS.CBIREP_QUERIES ADD CONSTRAINT PK_CBIREPQUERIES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CBIREPQUERIES_STSDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CBIREP_QUERIES MODIFY (STATUS_DATE CONSTRAINT CC_CBIREPQUERIES_STSDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CBIREPQUERIES_STATUSID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CBIREP_QUERIES MODIFY (STATUS_ID CONSTRAINT CC_CBIREPQUERIES_STATUSID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CBIREPQUERIES_CRTTIME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CBIREP_QUERIES MODIFY (CREATION_TIME CONSTRAINT CC_CBIREPQUERIES_CRTTIME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CBIREPQUERIES_XMLPARS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CBIREP_QUERIES MODIFY (XML_PARAMS CONSTRAINT CC_CBIREPQUERIES_XMLPARS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CBIREPQUERIES_KEYPARS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CBIREP_QUERIES MODIFY (KEY_PARAMS CONSTRAINT CC_CBIREPQUERIES_KEYPARS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CBIREPQUERIES_REPID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CBIREP_QUERIES MODIFY (REP_ID CONSTRAINT CC_CBIREPQUERIES_REPID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CBIREPQUERIES_USERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CBIREP_QUERIES MODIFY (USERID CONSTRAINT CC_CBIREPQUERIES_USERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CBIREPQUERIES_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CBIREP_QUERIES MODIFY (BRANCH CONSTRAINT CC_CBIREPQUERIES_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CBIREPQUERIES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CBIREPQUERIES ON BARS.CBIREP_QUERIES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_CBIREPQUERIES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_CBIREPQUERIES ON BARS.CBIREP_QUERIES (USERID, REP_ID, KEY_PARAMS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 165 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_CBIREPQURIES ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_CBIREPQURIES ON BARS.CBIREP_QUERIES (SESSION_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_CBIREPQURIES_STATUS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_CBIREPQURIES_STATUS ON BARS.CBIREP_QUERIES (STATUS_ID, STATUS_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CBIREP_QUERIES.sql =========*** End **
PROMPT ===================================================================================== 
