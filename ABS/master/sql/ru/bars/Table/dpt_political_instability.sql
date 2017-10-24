

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_POLITICAL_INSTABILITY.sql ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_POLITICAL_INSTABILITY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_POLITICAL_INSTABILITY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_POLITICAL_INSTABILITY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_POLITICAL_INSTABILITY ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_POLITICAL_INSTABILITY 
   (	OLD_DPT_ID NUMBER, 
	NEW_DPT_ID NUMBER, 
	PENALTY_SUM NUMBER, 
	CRT_DATE DATE, 
	CRT_STAFF_ID NUMBER, 
	CRT_BRANCH VARCHAR2(30), 
	REF NUMBER, 
	ACC_2636 NUMBER, 
	ACC_3648 NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_POLITICAL_INSTABILITY ***
 exec bpa.alter_policies('DPT_POLITICAL_INSTABILITY');


COMMENT ON TABLE BARS.DPT_POLITICAL_INSTABILITY IS '������ �� ���������� ��������� ��������� ��� ����� �� ������ "�������� ������������"';
COMMENT ON COLUMN BARS.DPT_POLITICAL_INSTABILITY.REF IS '��� �� ��������� ����� ������ - ���������� �� ��������� ������';
COMMENT ON COLUMN BARS.DPT_POLITICAL_INSTABILITY.ACC_2636 IS '��������������� ������� �� �������� �������';
COMMENT ON COLUMN BARS.DPT_POLITICAL_INSTABILITY.ACC_3648 IS '������������ ������������� �� ������� ������';
COMMENT ON COLUMN BARS.DPT_POLITICAL_INSTABILITY.OLD_DPT_ID IS '��. ���������� ���������� ���.';
COMMENT ON COLUMN BARS.DPT_POLITICAL_INSTABILITY.NEW_DPT_ID IS '��. ������ ���.';
COMMENT ON COLUMN BARS.DPT_POLITICAL_INSTABILITY.PENALTY_SUM IS '���� ������';
COMMENT ON COLUMN BARS.DPT_POLITICAL_INSTABILITY.CRT_DATE IS '���� ���������';
COMMENT ON COLUMN BARS.DPT_POLITICAL_INSTABILITY.CRT_STAFF_ID IS '��. �����������, �� �������';
COMMENT ON COLUMN BARS.DPT_POLITICAL_INSTABILITY.CRT_BRANCH IS '�����';




PROMPT *** Create  constraint UK_DPTPI_NEWDPTID ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_POLITICAL_INSTABILITY ADD CONSTRAINT UK_DPTPI_NEWDPTID UNIQUE (NEW_DPT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPTPI ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_POLITICAL_INSTABILITY ADD CONSTRAINT PK_DPTPI PRIMARY KEY (OLD_DPT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTPI_CRTBRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_POLITICAL_INSTABILITY MODIFY (CRT_BRANCH CONSTRAINT CC_DPTPI_CRTBRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTPI_CRTSTAFFID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_POLITICAL_INSTABILITY MODIFY (CRT_STAFF_ID CONSTRAINT CC_DPTPI_CRTSTAFFID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTPI_CRTDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_POLITICAL_INSTABILITY MODIFY (CRT_DATE CONSTRAINT CC_DPTPI_CRTDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTPI_PSUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_POLITICAL_INSTABILITY MODIFY (PENALTY_SUM CONSTRAINT CC_DPTPI_PSUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTPI_NEWDPTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_POLITICAL_INSTABILITY MODIFY (NEW_DPT_ID CONSTRAINT CC_DPTPI_NEWDPTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTPI_OLDDPTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_POLITICAL_INSTABILITY MODIFY (OLD_DPT_ID CONSTRAINT CC_DPTPI_OLDDPTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTPI ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTPI ON BARS.DPT_POLITICAL_INSTABILITY (OLD_DPT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DPTPI_NEWDPTID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DPTPI_NEWDPTID ON BARS.DPT_POLITICAL_INSTABILITY (NEW_DPT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_POLITICAL_INSTABILITY ***
grant SELECT                                                                 on DPT_POLITICAL_INSTABILITY to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_POLITICAL_INSTABILITY.sql ========
PROMPT ===================================================================================== 
