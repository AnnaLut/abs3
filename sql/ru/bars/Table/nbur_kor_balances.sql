

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_KOR_BALANCES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_KOR_BALANCES *** 


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_KOR_BALANCES'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_KOR_BALANCES'', ''FILIAL'' , null, ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''NBUR_KOR_BALANCES'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_KOR_BALANCES ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_KOR_BALANCES 
   (REPORT_DATE DATE, 
	KF NUMBER DEFAULT sys_context(''bars_context'',''user_mfo''), 
	CUST_ID NUMBER, 
	ACC_ID NUMBER, 
	ACC_NUM VARCHAR2(15), 
	KV NUMBER, 
	ACC_OB22 VARCHAR2(2), 
	ACC_TYPE VARCHAR2(3), 
	DOS_BAL  NUMBER, 
	DOSQ_BAL  NUMBER, 
	KOS_BAL  NUMBER, 
    KOSQ_BAL  NUMBER, 
    OST_BAL  NUMBER, 
    OSTQ_BAL  NUMBER,    
	DOS_REPD  NUMBER, 
	DOSQ_REPD  NUMBER, 
	KOS_REPD  NUMBER, 
	KOSQ_REPD  NUMBER, 
	DOS_REPM  NUMBER, 
	DOSQ_REPM  NUMBER, 
	KOS_REPM  NUMBER, 
	KOSQ_REPM  NUMBER, 
	OST_REP  NUMBER, 
	OSTQ_REP  NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to NBUR_KOR_BALANCES ***
 exec bpa.alter_policies('NBUR_KOR_BALANCES');


COMMENT ON TABLE BARS.NBUR_KOR_BALANCES IS '������� ��� �������� �� ����� ���� �������';

COMMENT ON COLUMN BARS.NBUR_KOR_BALANCES.REPORT_DATE IS '����� ���� (���� �������� �� ��� ��)';
COMMENT ON COLUMN BARS.NBUR_KOR_BALANCES.KF IS '��� ��볿';
COMMENT ON COLUMN BARS.NBUR_KOR_BALANCES.CUST_ID IS '��. �볺���';
COMMENT ON COLUMN BARS.NBUR_KOR_BALANCES.ACC_ID IS '��. �������';
COMMENT ON COLUMN BARS.NBUR_KOR_BALANCES.ACC_NUM IS '����� �������';
COMMENT ON COLUMN BARS.NBUR_KOR_BALANCES.KV IS '��� ������';
COMMENT ON COLUMN BARS.NBUR_KOR_BALANCES.ACC_OB22 IS '��22 �������';
COMMENT ON COLUMN BARS.NBUR_KOR_BALANCES.ACC_TYPE IS '������/�����';

COMMENT ON COLUMN BARS.NBUR_KOR_BALANCES.OST_BAL IS '������� (���) � ���� ��������';
COMMENT ON COLUMN BARS.NBUR_KOR_BALANCES.OSTQ_BAL IS '������� (���) � ���� ��������';

COMMENT ON COLUMN BARS.NBUR_KOR_BALANCES.OST_REP IS '������� (���) ��� ����';
COMMENT ON COLUMN BARS.NBUR_KOR_BALANCES.OSTQ_REP IS '������� (���) lkz pdsne ';

COMMENT ON COLUMN BARS.NBUR_KOR_BALANCES.DOS_BAL IS '���� �������� ���. ������� (���) � ���� ��������';
COMMENT ON COLUMN BARS.NBUR_KOR_BALANCES.DOSQ_BAL IS '���� �������� ���. ������� (���) � ���� ��������';
COMMENT ON COLUMN BARS.NBUR_KOR_BALANCES.KOS_BAL IS '���� �������� ����. ������� (���) � ���� ��������';
COMMENT ON COLUMN BARS.NBUR_KOR_BALANCES.KOSQ_BAL IS '���� �������� ����. ������� (���) � ���� ��������';

COMMENT ON COLUMN BARS.NBUR_KOR_BALANCES.DOS_REPD IS '���� ���. ������� (���) ��� ��������� ���� � ���� ��������';
COMMENT ON COLUMN BARS.NBUR_KOR_BALANCES.DOSQ_REPD IS '���� ���. ������� (���) ��� ��������� ���� � ���� ��������';
COMMENT ON COLUMN BARS.NBUR_KOR_BALANCES.KOS_REPD IS '���� ����. ������� (���) ��� ��������� ���� � ���� ��������';
COMMENT ON COLUMN BARS.NBUR_KOR_BALANCES.KOSQ_REPD IS '���� ����. ������� (���) ��� ��������� ���� � ���� ��������';

COMMENT ON COLUMN BARS.NBUR_KOR_BALANCES.DOS_REPM IS '���� ���. ������� (���) ��� �������� ���� � ���� ��������';
COMMENT ON COLUMN BARS.NBUR_KOR_BALANCES.DOSQ_REPM IS '���� ���. ������� (���) ��� �������� ���� � ���� ��������';
COMMENT ON COLUMN BARS.NBUR_KOR_BALANCES.KOS_REPM IS '���� ����. ������� (���) ��� �������� ���� � ���� ��������';
COMMENT ON COLUMN BARS.NBUR_KOR_BALANCES.KOSQ_REPM IS '���� ����. ������� (���) ��� �������� ���� � ���� ��������';


PROMPT *** Create  constraint CC_KORBALANCE_DATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_BALANCES MODIFY (REPORT_DATE CONSTRAINT CC_KORBALANCE_DATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint CC_KORBALANCE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_BALANCES MODIFY (KF CONSTRAINT CC_KORBALANCE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint CC_KORBALANCE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_BALANCES MODIFY (KF CONSTRAINT CC_KORBALANCE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint CC_KORBALANCE_CUSTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_BALANCES MODIFY (CUST_ID CONSTRAINT CC_KORBALANCE_CUSTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint CC_KORBALANCE_ACCID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_BALANCES MODIFY (ACC_ID CONSTRAINT CC_KORBALANCE_ACCID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint CC_KORBALANCE_ACCNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_BALANCES MODIFY (ACC_NUM CONSTRAINT CC_KORBALANCE_ACCNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint CC_KORBALANCE_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_BALANCES MODIFY (KV CONSTRAINT CC_KORBALANCE_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint PK_KORBALANCE ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_KOR_BALANCES ADD CONSTRAINT PK_KORBALANCE PRIMARY KEY (REPORT_DATE, KF, CUST_ID, ACC_ID, ACC_NUM, KV)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  index PK_KORBALANCE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KORBALANCE ON BARS.NBUR_KOR_BALANCES (REPORT_DATE, KF, CUST_ID, ACC_ID, ACC_NUM, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  grants  NBUR_KOR_BALANCES ***
grant SELECT                                                                 on NBUR_KOR_BALANCES to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on NBUR_KOR_BALANCES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NBUR_KOR_BALANCES to RPBN002;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_KOR_BALANCES.sql =========*** End
PROMPT ===================================================================================== 
