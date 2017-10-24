

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PRVN_FLOW_DEALS_OLD.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PRVN_FLOW_DEALS_OLD ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PRVN_FLOW_DEALS_OLD ***
begin 
  execute immediate '
  CREATE TABLE BARS.PRVN_FLOW_DEALS_OLD 
   (	ND NUMBER, 
	ACC NUMBER, 
	ID NUMBER, 
	DAT_ADD DATE, 
	VIDD NUMBER, 
	SDATE DATE, 
	KV8 NUMBER(*,0), 
	FL2 NUMBER(*,0), 
	ZDAT DATE, 
	OST NUMBER, 
	IR NUMBER, 
	IRR0 NUMBER, 
	RNK NUMBER, 
	WDATE DATE, 
	KV NUMBER(*,0), 
	I_CR9 NUMBER(*,0), 
	PR_TR NUMBER(*,0), 
	ACC8 NUMBER, 
	OST8 NUMBER, 
	K NUMBER, 
	OSTQ NUMBER, 
	OST8Q NUMBER, 
	TIP CHAR(3), 
	DAOS DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PRVN_FLOW_DEALS_OLD ***
 exec bpa.alter_policies('PRVN_FLOW_DEALS_OLD');


COMMENT ON TABLE BARS.PRVN_FLOW_DEALS_OLD IS '������� ��-���� ��� �������';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.ND IS '��� �� ���';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.ACC IS '��� ���� ���(���)';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.ID IS '�� � ���� ';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.DAT_ADD IS '���� ��������';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.VIDD IS '��� ��';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.SDATE IS '���� �������';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.KV8 IS '��� ��� ��';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.FL2 IS '1=% �� ��������� ����(anuitet)';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.ZDAT IS '���.����� ����';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.OST IS '������� �� ���';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.IR IS 'ĳ��� ���.������ �� ���.';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.IRR0 IS 'ĳ��� ��.������ �� ��';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.RNK IS '��� ������������';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.WDATE IS '���� ������';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.KV IS '��� ��� ���.';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.I_CR9 IS '���������=0, ����������� CR9=1';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.PR_TR IS '������� ������� (0-���/1-��)';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.ACC8 IS '���� ���(��)';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.OST8 IS '������� �� ���';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.K IS '���� = ���/����� ';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.OSTQ IS '�������-��� �� ���';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.OST8Q IS '�������-��� �� ���';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.TIP IS '';
COMMENT ON COLUMN BARS.PRVN_FLOW_DEALS_OLD.DAOS IS '���� ����.��� ';




PROMPT *** Create  constraint PK_PRVNFLOWDEALS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_FLOW_DEALS_OLD ADD CONSTRAINT PK_PRVNFLOWDEALS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PRVNFLOWDEALS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PRVNFLOWDEALS ON BARS.PRVN_FLOW_DEALS_OLD (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_PRVNFLOWDEALS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_PRVNFLOWDEALS ON BARS.PRVN_FLOW_DEALS_OLD (ND, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PRVN_FLOW_DEALS_OLD ***
grant SELECT,UPDATE                                                          on PRVN_FLOW_DEALS_OLD to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PRVN_FLOW_DEALS_OLD.sql =========*** E
PROMPT ===================================================================================== 
