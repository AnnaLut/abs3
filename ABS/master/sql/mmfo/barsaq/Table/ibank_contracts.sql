

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/IBANK_CONTRACTS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  table IBANK_CONTRACTS ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.IBANK_CONTRACTS 
   (	OPERATION VARCHAR2(6), 
	KF VARCHAR2(12), 
	PID NUMBER, 
	IMPEXP NUMBER(1,0), 
	RNK NUMBER(*,0), 
	NAME VARCHAR2(50), 
	DATEOPEN DATE, 
	DATECLOSE DATE, 
	S NUMBER, 
	KV NUMBER(3,0), 
	ID_OPER NUMBER, 
	BENEFCOUNTRY NUMBER(3,0), 
	BENEFNAME VARCHAR2(50), 
	BENEFBANK VARCHAR2(50), 
	BENEFACC VARCHAR2(50), 
	AIM VARCHAR2(100), 
	CONTINUED VARCHAR2(80), 
	COND VARCHAR2(100), 
	DETAILS VARCHAR2(250), 
	BANKCOUNTRY NUMBER(3,0), 
	EXIST_IMPEXP VARCHAR2(1), 
	EXIST_RNK VARCHAR2(1), 
	EXIST_NAME VARCHAR2(1), 
	EXIST_DATEOPEN VARCHAR2(1), 
	EXIST_DATECLOSE VARCHAR2(1), 
	EXIST_S VARCHAR2(1), 
	EXIST_KV VARCHAR2(1), 
	EXIST_ID_OPER VARCHAR2(1), 
	EXIST_BENEFCOUNTRY VARCHAR2(1), 
	EXIST_BENEFNAME VARCHAR2(1), 
	EXIST_BENEFBANK VARCHAR2(1), 
	EXIST_BENEFACC VARCHAR2(1), 
	EXIST_AIM VARCHAR2(1), 
	EXIST_CONTINUED VARCHAR2(1), 
	EXIST_COND VARCHAR2(1), 
	EXIST_DETAILS VARCHAR2(1), 
	EXIST_BANKCOUNTRY VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.IBANK_CONTRACTS IS '��������/�������� ���������';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.OPERATION IS '';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.KF IS '��� �����';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.PID IS 'ID ���������';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.IMPEXP IS '0-�������, 1-������';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.RNK IS 'ID �볺���, �������� ���������';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.NAME IS '� ���������';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.DATEOPEN IS '���� ����������';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.DATECLOSE IS '���� ��������';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.S IS '���� ���������(� ������� ������ ���������)';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.KV IS '������ ���������';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.ID_OPER IS '1-�������� ������, 2-������� ������';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.BENEFCOUNTRY IS '��� ����� �����������';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.BENEFNAME IS '����� �����������';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.BENEFBANK IS '���� �����������';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.BENEFACC IS '������� �����������';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.AIM IS '������� ���������';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.CONTINUED IS '˳����� �� ����������� ���������';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.COND IS '����� ���������';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.DETAILS IS '����� ���������';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.BANKCOUNTRY IS '��� ����� ���������� �����';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.EXIST_IMPEXP IS '';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.EXIST_RNK IS '';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.EXIST_NAME IS '';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.EXIST_DATEOPEN IS '';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.EXIST_DATECLOSE IS '';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.EXIST_S IS '';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.EXIST_KV IS '';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.EXIST_ID_OPER IS '';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.EXIST_BENEFCOUNTRY IS '';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.EXIST_BENEFNAME IS '';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.EXIST_BENEFBANK IS '';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.EXIST_BENEFACC IS '';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.EXIST_AIM IS '';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.EXIST_CONTINUED IS '';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.EXIST_COND IS '';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.EXIST_DETAILS IS '';
COMMENT ON COLUMN BARSAQ.IBANK_CONTRACTS.EXIST_BANKCOUNTRY IS '';




PROMPT *** Create  constraint PK_ICONTRACTS ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.IBANK_CONTRACTS ADD CONSTRAINT PK_ICONTRACTS PRIMARY KEY (KF, PID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ICONTRACTS_OPERATION_CC ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.IBANK_CONTRACTS ADD CONSTRAINT CC_ICONTRACTS_OPERATION_CC CHECK (operation in (''INSERT'',''UPDATE'',''DELETE'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ICONTRACTS_IMPEXP_CC ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.IBANK_CONTRACTS ADD CONSTRAINT CC_ICONTRACTS_IMPEXP_CC CHECK (impexp in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ICONTRACTS_IDOPER_CC ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.IBANK_CONTRACTS ADD CONSTRAINT CC_ICONTRACTS_IDOPER_CC CHECK (id_oper in (1,2)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ICONTRACTS_OPERATION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.IBANK_CONTRACTS MODIFY (OPERATION CONSTRAINT CC_ICONTRACTS_OPERATION_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ICONTRACTS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.IBANK_CONTRACTS MODIFY (KF CONSTRAINT CC_ICONTRACTS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ICONTRACTS_PID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.IBANK_CONTRACTS MODIFY (PID CONSTRAINT CC_ICONTRACTS_PID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ICONTRACTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.PK_ICONTRACTS ON BARSAQ.IBANK_CONTRACTS (KF, PID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  IBANK_CONTRACTS ***
grant SELECT                                                                 on IBANK_CONTRACTS to BARSREADER_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/IBANK_CONTRACTS.sql =========*** End
PROMPT ===================================================================================== 
