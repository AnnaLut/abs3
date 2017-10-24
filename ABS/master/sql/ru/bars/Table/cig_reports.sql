

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIG_REPORTS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIG_REPORTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIG_REPORTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIG_REPORTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIG_REPORTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIG_REPORTS 
   (	ID NUMBER, 
	USER_ID NUMBER, 
	REP_DATE DATE DEFAULT sysdate, 
	REP_TYPE NUMBER, 
	DATA BLOB, 
	LINE_REQ VARCHAR2(200), 
	REQ_TYPE NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (DATA) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIG_REPORTS ***
 exec bpa.alter_policies('CIG_REPORTS');


COMMENT ON TABLE BARS.CIG_REPORTS IS '';
COMMENT ON COLUMN BARS.CIG_REPORTS.ID IS '���������� �������������';
COMMENT ON COLUMN BARS.CIG_REPORTS.USER_ID IS '��� ������������';
COMMENT ON COLUMN BARS.CIG_REPORTS.REP_DATE IS '���� ���������� ������';
COMMENT ON COLUMN BARS.CIG_REPORTS.REP_TYPE IS '��� ������';
COMMENT ON COLUMN BARS.CIG_REPORTS.DATA IS '���������� ���������� �� ����';
COMMENT ON COLUMN BARS.CIG_REPORTS.LINE_REQ IS '������ ������� � ����';
COMMENT ON COLUMN BARS.CIG_REPORTS.REQ_TYPE IS '2,3 - ������ �� ��; 12 - �� ��';




PROMPT *** Create  constraint FK_CIG_REPORTS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_REPORTS ADD CONSTRAINT FK_CIG_REPORTS_ID FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002153255 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_REPORTS ADD PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002153254 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_REPORTS MODIFY (USER_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002153253 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_REPORTS MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C002153255 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C002153255 ON BARS.CIG_REPORTS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIG_REPORTS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIG_REPORTS     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIG_REPORTS.sql =========*** End *** =
PROMPT ===================================================================================== 
