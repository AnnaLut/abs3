

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_DEAL.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_DEAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_DEAL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_DEAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_DEAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_DEAL 
   (	ID NUMBER, 
	RYN NUMBER, 
	ACC NUMBER, 
	ACCD NUMBER, 
	ACCP NUMBER, 
	ACCR NUMBER, 
	ACCS NUMBER, 
	REF NUMBER, 
	ERAT NUMBER, 
	ACCR2 NUMBER, 
	ERATE NUMBER, 
	DAZS DATE, 
	REF_OLD NUMBER(*,0), 
	REF_NEW NUMBER(*,0), 
	OP NUMBER(*,0), 
	DAT_UG DATE, 
	PF NUMBER(*,0), 
	ACTIVE NUMBER(1,0) DEFAULT 0, 
	INITIAL_REF NUMBER(38,0), 
	ACCS5 NUMBER(*,0), 
	ACCS6 NUMBER(*,0), 
	DAT_BAY DATE, 
	ACCEXPN NUMBER, 
	ACCEXPR NUMBER, 
	ACCR3 NUMBER, 
	ACCUNREC NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_DEAL ***
 exec bpa.alter_policies('CP_DEAL');


COMMENT ON TABLE BARS.CP_DEAL IS '';
COMMENT ON COLUMN BARS.CP_DEAL.ACCR3 IS 'ACC �� "�������" ������ R3';
COMMENT ON COLUMN BARS.CP_DEAL.ACCUNREC IS 'ACC �� ������������ �������';
COMMENT ON COLUMN BARS.CP_DEAL.ACCS5 IS '���.���.���� 5121.';
COMMENT ON COLUMN BARS.CP_DEAL.ACCS6 IS '���.���.���� 6300.';
COMMENT ON COLUMN BARS.CP_DEAL.DAT_BAY IS '���� ��������� ������';
COMMENT ON COLUMN BARS.CP_DEAL.ACCEXPN IS 'ACC �� ��������� ��������';
COMMENT ON COLUMN BARS.CP_DEAL.ACCEXPR IS 'ACC �� ��������� ������';
COMMENT ON COLUMN BARS.CP_DEAL.ACTIVE IS '������ ��������� �������� (0 - � / 1 - ���)';
COMMENT ON COLUMN BARS.CP_DEAL.ID IS '��� ��';
COMMENT ON COLUMN BARS.CP_DEAL.RYN IS '��� �����������';
COMMENT ON COLUMN BARS.CP_DEAL.ACC IS 'ACC ������� �������';
COMMENT ON COLUMN BARS.CP_DEAL.ACCD IS 'ACC ������� ��������';
COMMENT ON COLUMN BARS.CP_DEAL.ACCP IS 'ACC ������� ���쳿';
COMMENT ON COLUMN BARS.CP_DEAL.ACCR IS 'ACC ������� ������ R';
COMMENT ON COLUMN BARS.CP_DEAL.ACCS IS 'ACC ������� ����������';
COMMENT ON COLUMN BARS.CP_DEAL.REF IS '�������� �����';
COMMENT ON COLUMN BARS.CP_DEAL.ERAT IS '�������� ��.�� ������ ���';
COMMENT ON COLUMN BARS.CP_DEAL.ACCR2 IS 'ACC ������� ������ R2';
COMMENT ON COLUMN BARS.CP_DEAL.ERATE IS '��������� ��.�� ������ ���';
COMMENT ON COLUMN BARS.CP_DEAL.DAZS IS '���� �������� �����';
COMMENT ON COLUMN BARS.CP_DEAL.REF_OLD IS '';
COMMENT ON COLUMN BARS.CP_DEAL.REF_NEW IS '';
COMMENT ON COLUMN BARS.CP_DEAL.OP IS '��� ��������� (1 - �������, 3 - �����������)';
COMMENT ON COLUMN BARS.CP_DEAL.DAT_UG IS '���� ���������� ��������';
COMMENT ON COLUMN BARS.CP_DEAL.PF IS '��� ��������';
COMMENT ON COLUMN BARS.CP_DEAL.INITIAL_REF IS '������������� ���������� �������� ����� �� (���� ��� ������ � OP = 3))';




PROMPT *** Create  constraint FK_CP_DEAL_RYN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DEAL ADD CONSTRAINT FK_CP_DEAL_RYN FOREIGN KEY (RYN)
	  REFERENCES BARS.CP_RYN (RYN) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CP_DEAL_REF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DEAL ADD CONSTRAINT FK_CP_DEAL_REF FOREIGN KEY (REF)
	  REFERENCES BARS.OPER (REF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CP_DEAL_KOD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DEAL ADD CONSTRAINT FK_CP_DEAL_KOD FOREIGN KEY (ID)
	  REFERENCES BARS.CP_KOD (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CP_DEAL_ACCS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DEAL ADD CONSTRAINT FK_CP_DEAL_ACCS FOREIGN KEY (ACCS)
	  REFERENCES BARS.ACCOUNTS (ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CP_DEAL_ACCR2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DEAL ADD CONSTRAINT FK_CP_DEAL_ACCR2 FOREIGN KEY (ACCR2)
	  REFERENCES BARS.ACCOUNTS (ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CP_DEAL_ACCR ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DEAL ADD CONSTRAINT FK_CP_DEAL_ACCR FOREIGN KEY (ACCR)
	  REFERENCES BARS.ACCOUNTS (ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CP_DEAL_ACCP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DEAL ADD CONSTRAINT FK_CP_DEAL_ACCP FOREIGN KEY (ACCP)
	  REFERENCES BARS.ACCOUNTS (ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CP_DEAL_ACCD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DEAL ADD CONSTRAINT FK_CP_DEAL_ACCD FOREIGN KEY (ACCD)
	  REFERENCES BARS.ACCOUNTS (ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CP_DEAL_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DEAL ADD CONSTRAINT FK_CP_DEAL_ACC FOREIGN KEY (ACC)
	  REFERENCES BARS.ACCOUNTS (ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CPDEAL_ACCS6 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DEAL ADD CONSTRAINT FK_CPDEAL_ACCS6 FOREIGN KEY (ACCS6)
	  REFERENCES BARS.ACCOUNTS (ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CPDEAL_ACCS5 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DEAL ADD CONSTRAINT FK_CPDEAL_ACCS5 FOREIGN KEY (ACCS5)
	  REFERENCES BARS.ACCOUNTS (ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CPDEAL_INITREF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DEAL ADD CONSTRAINT CC_CPDEAL_INITREF CHECK ((OP = 1 and INITIAL_REF is Null) or (OP = 3 and INITIAL_REF is Not Null)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CPDEAL_INITREF_OP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DEAL ADD CONSTRAINT CC_CPDEAL_INITREF_OP CHECK (OP = NVL2(INITIAL_REF, 3, 1)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CPDEAL_INITREF_REF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DEAL ADD CONSTRAINT CC_CPDEAL_INITREF_REF CHECK ( INITIAL_REF <> REF ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CPDEAL_ACTIVE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DEAL ADD CONSTRAINT CC_CPDEAL_ACTIVE CHECK (ACTIVE in (-1,0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CPDEAL_ACTIVE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DEAL MODIFY (ACTIVE CONSTRAINT CC_CPDEAL_ACTIVE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_CP_ACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DEAL ADD CONSTRAINT XPK_CP_ACC PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002438474 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DEAL MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_CPDEAL_REF ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DEAL ADD CONSTRAINT UK_CPDEAL_REF UNIQUE (REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_CPDEAL_REF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_CPDEAL_REF ON BARS.CP_DEAL (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CP_ACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CP_ACC ON BARS.CP_DEAL (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_DEAL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_DEAL         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_DEAL         to CP_ROLE;
grant SELECT                                                                 on CP_DEAL         to RPBN001;
grant SELECT                                                                 on CP_DEAL         to RPBN002;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_DEAL         to START1;



PROMPT *** Create SYNONYM  to CP_DEAL ***

  CREATE OR REPLACE PUBLIC SYNONYM CP_DEAL FOR BARS.CP_DEAL;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_DEAL.sql =========*** End *** =====
PROMPT ===================================================================================== 
