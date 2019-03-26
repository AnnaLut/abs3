begin
  execute immediate 'begin bpa.alter_policy_info(''ow_inst_totals'', ''WHOLE'',  null, ''E'', ''E'', ''E''); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/
 begin
  execute immediate 'begin bpa.alter_policy_info(''ow_inst_totals'', ''FILIAL'', ''M'', ''M'', ''M'' , ''M''); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/ 
begin
  execute immediate 'begin bpa.alter_policy_info(''ow_inst_totals'', ''CENTER'', null, ''E'', ''E'' , ''E''); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/ 
BEGIN
execute immediate 'create table ow_inst_totals (
id number,
idn number,
nd number,
contract number,
contract_idt varchar2(30),
scheme number,
plan_id number,
chain_idt number,
document_id number,
status varchar2(30),
total_amount number,
amount_to_pay number,
written_off_amount number,
overdue_amount number,
sub_int_rate number,
sub_fee_rate number,
eff_rate number,
tenor number,
posting_date date,
pay_b_date date,
end_date_p date,
end_date_f date,
ovd_90_days date,
plans_in_history number,
kf varchar2(6 BYTE) default sys_context(''bars_context'',''user_mfo'') CONSTRAINT CC_OW_INST_TOTALS_KF_NN NOT NULL) 
tablespace BRSMDLD
PARTITION BY LIST (KF) 
 (PARTITION P_01_300465  VALUES (''300465'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_02_324805  VALUES (''324805'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_03_302076  VALUES (''302076'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_04_303398  VALUES (''303398'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_05_305482  VALUES (''305482'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_06_335106  VALUES (''335106'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_07_311647  VALUES (''311647'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_08_312356  VALUES (''312356'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_09_313957  VALUES (''313957'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_10_336503  VALUES (''336503'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_11_322669  VALUES (''322669'') SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_12_323475  VALUES (''323475'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_13_304665  VALUES (''304665'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_14_325796  VALUES (''325796'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_15_326461  VALUES (''326461'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_16_328845  VALUES (''328845'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_17_331467  VALUES (''331467'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_18_333368  VALUES (''333368'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_19_337568  VALUES (''337568'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_20_338545  VALUES (''338545'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_21_351823  VALUES (''351823'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_22_352457  VALUES (''352457'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_23_315784  VALUES (''315784'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_24_354507  VALUES (''354507'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_25_356334  VALUES (''356334'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD , 
 PARTITION P_26_353553  VALUES (''353553'') SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSBIGD )';
  exception when others then
  if sqlcode = -955 then null;
  else raise;
  end if;
 END;
/
COMMENT ON TABLE BARS.OW_INST_TOTALS IS '������ ������ ����������';

COMMENT ON COLUMN BARS.OW_INST_TOTALS.ID IS '�� ����� � ���';

COMMENT ON COLUMN BARS.OW_INST_TOTALS.IDN IS '�� ������ � ����';

COMMENT ON COLUMN BARS.OW_INST_TOTALS.ND IS '����� �������� ���';

COMMENT ON COLUMN BARS.OW_INST_TOTALS.CONTRACT IS '�� ��������';

COMMENT ON COLUMN BARS.OW_INST_TOTALS.CONTRACT_IDT IS '������� 2625XX � ���';

COMMENT ON COLUMN BARS.OW_INST_TOTALS.SCHEME IS '�� ����������� �����';

COMMENT ON COLUMN BARS.OW_INST_TOTALS.PLAN_ID IS '�� �������';

COMMENT ON COLUMN BARS.OW_INST_TOTALS.CHAIN_IDT IS '�� ���������(�������) �������';

COMMENT ON COLUMN BARS.OW_INST_TOTALS.DOCUMENT_ID IS '�� ���������';

COMMENT ON COLUMN BARS.OW_INST_TOTALS.STATUS IS '������ �������: 
Waiting-������ �� ��������
Open - �������
Paid - ��������
Partially Paid - �������� ��������
Overdue - �����������
Closed - �������
Revised - �����������������';

COMMENT ON COLUMN BARS.OW_INST_TOTALS.TOTAL_AMOUNT IS '�������� ���� �� �������';

COMMENT ON COLUMN BARS.OW_INST_TOTALS.AMOUNT_TO_PAY IS '���� �� ������';

COMMENT ON COLUMN BARS.OW_INST_TOTALS.WRITTEN_OFF_AMOUNT IS '���� ��������';

COMMENT ON COLUMN BARS.OW_INST_TOTALS.OVERDUE_AMOUNT IS '���� ����������';

COMMENT ON COLUMN BARS.OW_INST_TOTALS.SUB_INT_RATE IS '³�������� ������';

COMMENT ON COLUMN BARS.OW_INST_TOTALS.SUB_FEE_RATE IS '����� %%';

COMMENT ON COLUMN BARS.OW_INST_TOTALS.EFF_RATE IS '��������� ������';

COMMENT ON COLUMN BARS.OW_INST_TOTALS.TENOR IS 'ʳ������ ������ � �������';

COMMENT ON COLUMN BARS.OW_INST_TOTALS.POSTING_DATE IS '���������� ���� ������ 9900->9129 � ��';

COMMENT ON COLUMN BARS.OW_INST_TOTALS.PAY_B_DATE IS '���������� ���� ������ 9900->9129 � ���';

COMMENT ON COLUMN BARS.OW_INST_TOTALS.END_DATE_P IS '������� ���� �������� �����������';

COMMENT ON COLUMN BARS.OW_INST_TOTALS.END_DATE_F IS '�������� ���� �������� �����������';

COMMENT ON COLUMN BARS.OW_INST_TOTALS.OVD_90_DAYS IS '���� �������� �������� ����������';

COMMENT ON COLUMN BARS.OW_INST_TOTALS.PLANS_IN_HISTORY IS 'ʳ������ ������� � ���������� ��������';

COMMENT ON COLUMN BARS.OW_INST_TOTALS.KF IS '���';
/
begin
  execute immediate 'begin BARS_POLICY_ADM.ALTER_POLICIES(''ow_inst_totals''); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/
begin   
 execute immediate 'ALTER TABLE BARS.OW_INST_TOTALS ADD 
CONSTRAINT OW_INST_TOTALS_PK
 PRIMARY KEY (chain_idt)
 ENABLE
 VALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  index IND_OW_INST_TOTALS_STAT ***
begin   
 execute immediate '
  CREATE INDEX IND_OW_INST_TOTALS_STAT ON OW_INST_TOTALS(STATUS, OVD_90_DAYS) LOCAL
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

begin   
 execute immediate '
  CREATE INDEX IND_OW_INST_TOTALS_ND ON OW_INST_TOTALS(ND) LOCAL
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

grant all on ow_inst_totals to bars_access_defrole;
/
grant all on ow_inst_totals to bars;
/