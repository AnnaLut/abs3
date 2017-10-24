

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BPK_CREDIT_DEAL_VAR.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BPK_CREDIT_DEAL_VAR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BPK_CREDIT_DEAL_VAR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BPK_CREDIT_DEAL_VAR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BPK_CREDIT_DEAL_VAR ***
begin 
  execute immediate '
  CREATE TABLE BARS.BPK_CREDIT_DEAL_VAR 
   (	REPORT_DT DATE, 
	DEAL_ND NUMBER(24,0), 
	DEAL_SUM NUMBER(24,0), 
	DEAL_RNK NUMBER(24,0), 
	RATE NUMBER(5,3), 
	MATUR_DT DATE, 
	SS NUMBER(24,0), 
	SN NUMBER(24,0), 
	SP NUMBER(24,0), 
	SPN NUMBER(24,0), 
	CR9 NUMBER(24,0), 
	CREATE_DT DATE, 
	ADJ_FLG NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BPK_CREDIT_DEAL_VAR ***
 exec bpa.alter_policies('BPK_CREDIT_DEAL_VAR');


COMMENT ON TABLE BARS.BPK_CREDIT_DEAL_VAR IS '�������� ��������� ���.��������� ���� ��� �� ����� ����';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL_VAR.ADJ_FLG IS '������ ��������� ���������� ������� (0-ͳ/1-���)';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL_VAR.REPORT_DT IS '����� ����';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL_VAR.DEAL_ND IS '����� �������� ���������� ����';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL_VAR.DEAL_SUM IS '���� �������� (��������� ���)';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL_VAR.DEAL_RNK IS '���';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL_VAR.RATE IS '³�������� ������ �� ��������';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL_VAR.MATUR_DT IS '���� ��������� (�� ����� ����)';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL_VAR.SS IS '���� ������������� ���������� ����';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL_VAR.SN IS '���� ����������� �������';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL_VAR.SP IS '���� ������������� �����';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL_VAR.SPN IS '���� ������������ �������';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL_VAR.CR9 IS '���� ��������������� ���������� ����';
COMMENT ON COLUMN BARS.BPK_CREDIT_DEAL_VAR.CREATE_DT IS '���� ��������� ������';




PROMPT *** Create  constraint FK_BPKCRDTDEALVAR_BPKCRDTDEAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_CREDIT_DEAL_VAR ADD CONSTRAINT FK_BPKCRDTDEALVAR_BPKCRDTDEAL FOREIGN KEY (DEAL_ND)
	  REFERENCES BARS.BPK_CREDIT_DEAL (DEAL_ND) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BPKCRDTDEALVAR ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_CREDIT_DEAL_VAR ADD CONSTRAINT PK_BPKCRDTDEALVAR PRIMARY KEY (REPORT_DT, ADJ_FLG, DEAL_ND)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKCRDTDEALVAR_CREATDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_CREDIT_DEAL_VAR MODIFY (CREATE_DT CONSTRAINT CC_BPKCRDTDEALVAR_CREATDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKCRDTDEALVAR_RATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_CREDIT_DEAL_VAR MODIFY (RATE CONSTRAINT CC_BPKCRDTDEALVAR_RATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKCRDTDEALVAR_DEALRNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_CREDIT_DEAL_VAR MODIFY (DEAL_RNK CONSTRAINT CC_BPKCRDTDEALVAR_DEALRNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKCRDTDEALVAR_DEALSUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_CREDIT_DEAL_VAR MODIFY (DEAL_SUM CONSTRAINT CC_BPKCRDTDEALVAR_DEALSUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKCRDTDEALVAR_DEALND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_CREDIT_DEAL_VAR MODIFY (DEAL_ND CONSTRAINT CC_BPKCRDTDEALVAR_DEALND_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKCRDTDEALVAR_REPDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_CREDIT_DEAL_VAR MODIFY (REPORT_DT CONSTRAINT CC_BPKCRDTDEALVAR_REPDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKCRDTDEALVAR_ADJFLG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_CREDIT_DEAL_VAR MODIFY (ADJ_FLG CONSTRAINT CC_BPKCRDTDEALVAR_ADJFLG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BPKCRDTDEALVAR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BPKCRDTDEALVAR ON BARS.BPK_CREDIT_DEAL_VAR (REPORT_DT, ADJ_FLG, DEAL_ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BPK_CREDIT_DEAL_VAR ***
grant SELECT                                                                 on BPK_CREDIT_DEAL_VAR to BARSUPL;
grant SELECT                                                                 on BPK_CREDIT_DEAL_VAR to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BPK_CREDIT_DEAL_VAR.sql =========*** E
PROMPT ===================================================================================== 
