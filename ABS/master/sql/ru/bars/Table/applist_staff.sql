

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/APPLIST_STAFF.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to APPLIST_STAFF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''APPLIST_STAFF'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''APPLIST_STAFF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table APPLIST_STAFF ***
begin 
  execute immediate '
  CREATE TABLE BARS.APPLIST_STAFF 
   (	ID NUMBER(38,0), 
	CODEAPP CHAR(4), 
	APPROVE NUMBER(1,0), 
	ADATE1 DATE, 
	ADATE2 DATE, 
	RDATE1 DATE, 
	RDATE2 DATE, 
	REVOKED NUMBER(1,0), 
	GRANTOR NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to APPLIST_STAFF ***
 exec bpa.alter_policies('APPLIST_STAFF');


COMMENT ON TABLE BARS.APPLIST_STAFF IS '������������ <-> ���-�';
COMMENT ON COLUMN BARS.APPLIST_STAFF.ID IS '��� ������������';
COMMENT ON COLUMN BARS.APPLIST_STAFF.CODEAPP IS '��� ����������
';
COMMENT ON COLUMN BARS.APPLIST_STAFF.APPROVE IS '������� �������������';
COMMENT ON COLUMN BARS.APPLIST_STAFF.ADATE1 IS '���� ������ �������� ����������';
COMMENT ON COLUMN BARS.APPLIST_STAFF.ADATE2 IS '���� ��������� �������� ����������';
COMMENT ON COLUMN BARS.APPLIST_STAFF.RDATE1 IS '���� ������ ����������� ����������';
COMMENT ON COLUMN BARS.APPLIST_STAFF.RDATE2 IS '���� ��������� ����������� ����������';
COMMENT ON COLUMN BARS.APPLIST_STAFF.REVOKED IS '������� �� �������� �������';
COMMENT ON COLUMN BARS.APPLIST_STAFF.GRANTOR IS '��� ����� ������';




PROMPT *** Create  constraint FK_APPLISTSTAFF_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.APPLIST_STAFF ADD CONSTRAINT FK_APPLISTSTAFF_STAFF FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_APPLISTSTAFF_APPLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.APPLIST_STAFF ADD CONSTRAINT FK_APPLISTSTAFF_APPLIST FOREIGN KEY (CODEAPP)
	  REFERENCES BARS.APPLIST (CODEAPP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_APPLISTSTAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.APPLIST_STAFF ADD CONSTRAINT PK_APPLISTSTAFF PRIMARY KEY (ID, CODEAPP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_APPLISTSTAFF_CODEAPP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.APPLIST_STAFF MODIFY (CODEAPP CONSTRAINT CC_APPLISTSTAFF_CODEAPP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_APPLISTSTAFF_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.APPLIST_STAFF MODIFY (ID CONSTRAINT CC_APPLISTSTAFF_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_APPLISTSTAFF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_APPLISTSTAFF ON BARS.APPLIST_STAFF (ID, CODEAPP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  APPLIST_STAFF ***
grant DELETE,INSERT,SELECT,UPDATE                                            on APPLIST_STAFF   to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on APPLIST_STAFF   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on APPLIST_STAFF   to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on APPLIST_STAFF   to WR_ALL_RIGHTS;
grant DELETE,INSERT,SELECT,UPDATE                                            on APPLIST_STAFF   to WR_DIAGNOSTICS;
grant SELECT                                                                 on APPLIST_STAFF   to WR_METATAB;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/APPLIST_STAFF.sql =========*** End ***
PROMPT ===================================================================================== 
