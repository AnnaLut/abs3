

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_DEAL_UPDATE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_DEAL_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_DEAL_UPDATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_DEAL_UPDATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_DEAL_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_DEAL_UPDATE 
   (	IDUPD NUMBER(15,0), 
	CHGACTION CHAR(1), 
	EFFECTDATE DATE, 
	CHGDATE DATE, 
	DONEBY NUMBER, 
	ID NUMBER, 
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
	ACTIVE NUMBER(1,0), 
	INITIAL_REF NUMBER(38,0), 
	DAT_BAY DATE, 
	ACCEXPN NUMBER, 
	ACCEXPR NUMBER, 
	ACCS5 NUMBER, 
	ACCS6 NUMBER, 
	ACCR3 NUMBER(*,0), 
	ACCUNREC NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_DEAL_UPDATE ***
 exec bpa.alter_policies('CP_DEAL_UPDATE');


COMMENT ON TABLE BARS.CP_DEAL_UPDATE IS '';
COMMENT ON COLUMN BARS.CP_DEAL_UPDATE.DAT_BAY IS '���� ��������� ������';
COMMENT ON COLUMN BARS.CP_DEAL_UPDATE.ACCR3 IS 'ACC ����� "�������" ������';
COMMENT ON COLUMN BARS.CP_DEAL_UPDATE.ACCEXPN IS 'ACC �� ��������� ��������';
COMMENT ON COLUMN BARS.CP_DEAL_UPDATE.ACCEXPR IS 'ACC �� ��������� ������';
COMMENT ON COLUMN BARS.CP_DEAL_UPDATE.ACCUNREC IS 'ACC ����� ������������ �������';
COMMENT ON COLUMN BARS.CP_DEAL_UPDATE.ACCS5 IS '���.���.���� 5121.';
COMMENT ON COLUMN BARS.CP_DEAL_UPDATE.ACCS6 IS '���.���.���� 6300.';
COMMENT ON COLUMN BARS.CP_DEAL_UPDATE.ACTIVE IS '������ ��������� �������� (0 - � / 1 - ���)';
COMMENT ON COLUMN BARS.CP_DEAL_UPDATE.IDUPD IS '��������� ���� ��� ������� ����������';
COMMENT ON COLUMN BARS.CP_DEAL_UPDATE.CHGACTION IS '��� ���������� (I/U/D)';
COMMENT ON COLUMN BARS.CP_DEAL_UPDATE.EFFECTDATE IS '���������� ���� ������ �������� ����������';
COMMENT ON COLUMN BARS.CP_DEAL_UPDATE.CHGDATE IS '���������� ���� ����������';
COMMENT ON COLUMN BARS.CP_DEAL_UPDATE.DONEBY IS '��� ������������. ��� ���� ����������(���� � ������� ��� ���� ��������� ���������� - �������� ������ ���������)';
COMMENT ON COLUMN BARS.CP_DEAL_UPDATE.ID IS '';
COMMENT ON COLUMN BARS.CP_DEAL_UPDATE.RYN IS '';
COMMENT ON COLUMN BARS.CP_DEAL_UPDATE.ACC IS '';
COMMENT ON COLUMN BARS.CP_DEAL_UPDATE.ACCD IS '';
COMMENT ON COLUMN BARS.CP_DEAL_UPDATE.ACCP IS '';
COMMENT ON COLUMN BARS.CP_DEAL_UPDATE.ACCR IS '';
COMMENT ON COLUMN BARS.CP_DEAL_UPDATE.ACCS IS '';
COMMENT ON COLUMN BARS.CP_DEAL_UPDATE.REF IS '';
COMMENT ON COLUMN BARS.CP_DEAL_UPDATE.ERAT IS '';
COMMENT ON COLUMN BARS.CP_DEAL_UPDATE.ACCR2 IS '';
COMMENT ON COLUMN BARS.CP_DEAL_UPDATE.ERATE IS '';
COMMENT ON COLUMN BARS.CP_DEAL_UPDATE.DAZS IS '';
COMMENT ON COLUMN BARS.CP_DEAL_UPDATE.REF_OLD IS '';
COMMENT ON COLUMN BARS.CP_DEAL_UPDATE.REF_NEW IS '';
COMMENT ON COLUMN BARS.CP_DEAL_UPDATE.OP IS '��� ��������';
COMMENT ON COLUMN BARS.CP_DEAL_UPDATE.DAT_UG IS '���� �����';
COMMENT ON COLUMN BARS.CP_DEAL_UPDATE.PF IS '��� ��������';
COMMENT ON COLUMN BARS.CP_DEAL_UPDATE.INITIAL_REF IS '������������� ���������� �������� ����� �� (���� ��� ������ � OP = 3))';




PROMPT *** Create  constraint PK_CPDEAL_UPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DEAL_UPDATE ADD CONSTRAINT PK_CPDEAL_UPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002438472 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DEAL_UPDATE MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CPDEAL_UPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CPDEAL_UPDATE ON BARS.CP_DEAL_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_CPDEAL_UPDATEEFFDAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_CPDEAL_UPDATEEFFDAT ON BARS.CP_DEAL_UPDATE (EFFECTDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAI_CPDEAL_UPDATEPK ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAI_CPDEAL_UPDATEPK ON BARS.CP_DEAL_UPDATE (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_DEAL_UPDATE ***
grant SELECT                                                                 on CP_DEAL_UPDATE  to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on CP_DEAL_UPDATE  to CP_ROLE;
grant SELECT                                                                 on CP_DEAL_UPDATE  to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_DEAL_UPDATE.sql =========*** End **
PROMPT ===================================================================================== 
