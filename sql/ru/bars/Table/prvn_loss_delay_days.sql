

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PRVN_LOSS_DELAY_DAYS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PRVN_LOSS_DELAY_DAYS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PRVN_LOSS_DELAY_DAYS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''PRVN_LOSS_DELAY_DAYS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PRVN_LOSS_DELAY_DAYS ***
begin 
  execute immediate '
  CREATE TABLE BARS.PRVN_LOSS_DELAY_DAYS 
   (	REPORTING_DATE DATE, 
	REF_AGR NUMBER(38,0), 
	DAYS NUMBER(10,0), 
	EVENT_DATE DATE, 
	OBJECT_TYPE VARCHAR2(5), 
	DAYS_CORR NUMBER(10,0), 
	LANCH_MONTHLY NUMBER(1,0), 
	ZO NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PRVN_LOSS_DELAY_DAYS ***
 exec bpa.alter_policies('PRVN_LOSS_DELAY_DAYS');


COMMENT ON TABLE BARS.PRVN_LOSS_DELAY_DAYS IS '������� ��� ʳ������ ��� ��������� �� ��������';
COMMENT ON COLUMN BARS.PRVN_LOSS_DELAY_DAYS.REPORTING_DATE IS '����� ����';
COMMENT ON COLUMN BARS.PRVN_LOSS_DELAY_DAYS.REF_AGR IS '�������� �����';
COMMENT ON COLUMN BARS.PRVN_LOSS_DELAY_DAYS.DAYS IS 'ʳ������ ���';
COMMENT ON COLUMN BARS.PRVN_LOSS_DELAY_DAYS.EVENT_DATE IS '���� ���������� ��䳿 �������';
COMMENT ON COLUMN BARS.PRVN_LOSS_DELAY_DAYS.OBJECT_TYPE IS '��� �������';
COMMENT ON COLUMN BARS.PRVN_LOSS_DELAY_DAYS.DAYS_CORR IS 'ʳ������ ��� � ����������� ����������';
COMMENT ON COLUMN BARS.PRVN_LOSS_DELAY_DAYS.LANCH_MONTHLY IS '������ ���������(1), �� ����������(0)';
COMMENT ON COLUMN BARS.PRVN_LOSS_DELAY_DAYS.ZO IS '=0 ��� ����, =1-� ����';
COMMENT ON COLUMN BARS.PRVN_LOSS_DELAY_DAYS.KF IS '��� �i�i��� (���)';




PROMPT *** Create  constraint CC_PRVNLOSSDELAYDYS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_LOSS_DELAY_DAYS MODIFY (KF CONSTRAINT CC_PRVNLOSSDELAYDYS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRVNLOSSDELAY_REPORTDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_LOSS_DELAY_DAYS MODIFY (REPORTING_DATE CONSTRAINT CC_PRVNLOSSDELAY_REPORTDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_PRVNLOSSDELAYDYS_REPDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_PRVNLOSSDELAYDYS_REPDATE ON BARS.PRVN_LOSS_DELAY_DAYS (REPORTING_DATE, KF, ZO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 3 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PRVN_LOSS_DELAY_DAYS.sql =========*** 
PROMPT ===================================================================================== 
