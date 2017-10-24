

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_CONTRACTS_TRADE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_CONTRACTS_TRADE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_CONTRACTS_TRADE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CONTRACTS_TRADE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_CONTRACTS_TRADE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_CONTRACTS_TRADE 
   (	CONTR_ID NUMBER, 
	SPEC_ID NUMBER, 
	SUBJECT_ID NUMBER, 
	DEADLINE NUMBER, 
	TRADE_DESC VARCHAR2(250), 
	WITHOUT_ACTS NUMBER DEFAULT 0, 
	P27_F531 NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_CONTRACTS_TRADE ***
 exec bpa.alter_policies('CIM_CONTRACTS_TRADE');


COMMENT ON TABLE BARS.CIM_CONTRACTS_TRADE IS '�������� ��� �� �������� ���������� v1.0';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_TRADE.CONTR_ID IS 'ID ���������';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_TRADE.SPEC_ID IS 'ID ������������ ���������';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_TRADE.SUBJECT_ID IS '������� ���������';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_TRADE.DEADLINE IS '����������� �����';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_TRADE.TRADE_DESC IS '��������� �������� ���������';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_TRADE.WITHOUT_ACTS IS '������ ��� ���� ������ ����������';
COMMENT ON COLUMN BARS.CIM_CONTRACTS_TRADE.P27_F531 IS '�������� 27 ���� 531 (#36)';




PROMPT *** Create  constraint FK_CIMCONTRTRADE_DLINE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_TRADE ADD CONSTRAINT FK_CIMCONTRTRADE_DLINE FOREIGN KEY (DEADLINE)
	  REFERENCES BARS.CIM_CONTRACT_DEADLINES (DEADLINE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CIMCONTRTRADE_SUBJ ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_TRADE ADD CONSTRAINT FK_CIMCONTRTRADE_SUBJ FOREIGN KEY (SUBJECT_ID)
	  REFERENCES BARS.CIM_CONTRACT_SUBJECTS (SUBJECT_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CIMCONTRTRADE_SPEC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_TRADE ADD CONSTRAINT FK_CIMCONTRTRADE_SPEC FOREIGN KEY (SPEC_ID)
	  REFERENCES BARS.CIM_CONTRACT_SPECS (SPEC_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CIMCONTRTRADE_CONTR ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_TRADE ADD CONSTRAINT FK_CIMCONTRTRADE_CONTR FOREIGN KEY (CONTR_ID)
	  REFERENCES BARS.CIM_CONTRACTS (CONTR_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCONTRTRADE_ID_UK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_TRADE ADD CONSTRAINT CC_CIMCONTRTRADE_ID_UK UNIQUE (CONTR_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCONTRTRADE_DEADLINE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_TRADE MODIFY (DEADLINE CONSTRAINT CC_CIMCONTRTRADE_DEADLINE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCONTRTRADE_SUBJ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_TRADE MODIFY (SUBJECT_ID CONSTRAINT CC_CIMCONTRTRADE_SUBJ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIMCONTRTRADE_SPEC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_CONTRACTS_TRADE MODIFY (SPEC_ID CONSTRAINT CC_CIMCONTRTRADE_SPEC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index CC_CIMCONTRTRADE_ID_UK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.CC_CIMCONTRTRADE_ID_UK ON BARS.CIM_CONTRACTS_TRADE (CONTR_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_CONTRACTS_TRADE ***
grant SELECT                                                                 on CIM_CONTRACTS_TRADE to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CONTRACTS_TRADE to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_CONTRACTS_TRADE.sql =========*** E
PROMPT ===================================================================================== 
