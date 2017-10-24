

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CASH_OPEN.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CASH_OPEN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CASH_OPEN'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CASH_OPEN'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CASH_OPEN ***
begin 
  execute immediate '
  CREATE TABLE BARS.CASH_OPEN 
   (	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	OPDATE DATE, 
	SHIFT NUMBER(*,0), 
	USERID NUMBER, 
	LASTREF NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CASH_OPEN ***
 exec bpa.alter_policies('CASH_OPEN');


COMMENT ON TABLE BARS.CASH_OPEN IS '�������� ������� �������� ����� ��� ������������� ���';
COMMENT ON COLUMN BARS.CASH_OPEN.BRANCH IS '';
COMMENT ON COLUMN BARS.CASH_OPEN.OPDATE IS '������������ ���� + ����� �������� �����';
COMMENT ON COLUMN BARS.CASH_OPEN.SHIFT IS '����� (���������� ������ ����� � ��������� ����)';
COMMENT ON COLUMN BARS.CASH_OPEN.USERID IS '��� ������������ ��� �������� �����';
COMMENT ON COLUMN BARS.CASH_OPEN.LASTREF IS '������������ ��� � ������� �� ������ ��������';
COMMENT ON COLUMN BARS.CASH_OPEN.KF IS '';




PROMPT *** Create  constraint FK_CASHOPEN_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_OPEN ADD CONSTRAINT FK_CASHOPEN_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_CASHOPEN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_OPEN ADD CONSTRAINT XPK_CASHOPEN PRIMARY KEY (BRANCH, OPDATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CASHOPEN_BR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_OPEN MODIFY (BRANCH CONSTRAINT CC_CASHOPEN_BR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CASHOPEN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CASHOPEN ON BARS.CASH_OPEN (BRANCH, OPDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XUK_CASHOPEN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XUK_CASHOPEN ON BARS.CASH_OPEN (BRANCH, TRUNC(OPDATE), SHIFT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CASH_OPEN ***
grant SELECT                                                                 on CASH_OPEN       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CASH_OPEN       to RPBN001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CASH_OPEN       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CASH_OPEN.sql =========*** End *** ===
PROMPT ===================================================================================== 
