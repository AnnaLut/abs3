

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BARSWEB_SESSION_DATA.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BARSWEB_SESSION_DATA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BARSWEB_SESSION_DATA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BARSWEB_SESSION_DATA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BARSWEB_SESSION_DATA ***
begin 
  execute immediate '
  CREATE TABLE BARS.BARSWEB_SESSION_DATA 
   (	STAFF_ID NUMBER, 
	SESSION_ID VARCHAR2(24), 
	VAR_NAME VARCHAR2(32), 
	VAR_VALUE VARCHAR2(4000), 
	MODIFIED DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BARSWEB_SESSION_DATA ***
 exec bpa.alter_policies('BARSWEB_SESSION_DATA');


COMMENT ON TABLE BARS.BARSWEB_SESSION_DATA IS '';
COMMENT ON COLUMN BARS.BARSWEB_SESSION_DATA.STAFF_ID IS '���������� ������������� (STAFF.ID)';
COMMENT ON COLUMN BARS.BARSWEB_SESSION_DATA.SESSION_ID IS '������������� web-������';
COMMENT ON COLUMN BARS.BARSWEB_SESSION_DATA.VAR_NAME IS '��� ����������';
COMMENT ON COLUMN BARS.BARSWEB_SESSION_DATA.VAR_VALUE IS '�������� ����������';
COMMENT ON COLUMN BARS.BARSWEB_SESSION_DATA.MODIFIED IS '���� ���������� ���������� ����������';




PROMPT *** Create  constraint FK_BARSWEB_SESSION_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.BARSWEB_SESSION_DATA ADD CONSTRAINT FK_BARSWEB_SESSION_STAFF FOREIGN KEY (STAFF_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BARSWEB_SESSION_DATA ***
begin   
 execute immediate '
  ALTER TABLE BARS.BARSWEB_SESSION_DATA ADD CONSTRAINT PK_BARSWEB_SESSION_DATA PRIMARY KEY (STAFF_ID, SESSION_ID, VAR_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009294 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BARSWEB_SESSION_DATA MODIFY (VAR_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009293 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BARSWEB_SESSION_DATA MODIFY (SESSION_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009292 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BARSWEB_SESSION_DATA MODIFY (STAFF_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BARSWEB_SESSION_DATA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BARSWEB_SESSION_DATA ON BARS.BARSWEB_SESSION_DATA (STAFF_ID, SESSION_ID, VAR_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BARSWEB_SESSION_DATA ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BARSWEB_SESSION_DATA to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BARSWEB_SESSION_DATA.sql =========*** 
PROMPT ===================================================================================== 
