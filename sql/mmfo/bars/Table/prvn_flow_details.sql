

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PRVN_FLOW_DETAILS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PRVN_FLOW_DETAILS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PRVN_FLOW_DETAILS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''PRVN_FLOW_DETAILS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''PRVN_FLOW_DETAILS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PRVN_FLOW_DETAILS ***
begin 
  execute immediate '
  CREATE TABLE BARS.PRVN_FLOW_DETAILS 
   (	ID NUMBER(38,0), 
	ND NUMBER(38,0), 
	FDAT DATE, 
	MDAT DATE, 
	SS NUMBER(38,0), 
	SPD NUMBER(38,0), 
	SN NUMBER(38,0), 
	SK NUMBER(38,0), 
	LIM1 NUMBER(38,0), 
	LIM2 NUMBER(38,0), 
	DAT1 DATE, 
	DAT2 DATE, 
	SPN NUMBER(38,0), 
	SNO NUMBER(38,0), 
	SP NUMBER(38,0), 
	SN1 NUMBER(38,0), 
	SN2 NUMBER(38,0), 
	IR NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PRVN_FLOW_DETAILS ***
 exec bpa.alter_policies('PRVN_FLOW_DETAILS');


COMMENT ON TABLE BARS.PRVN_FLOW_DETAILS IS '������� ����.������ ��� �������';
COMMENT ON COLUMN BARS.PRVN_FLOW_DETAILS.ID IS '�� � ���.���� ';
COMMENT ON COLUMN BARS.PRVN_FLOW_DETAILS.ND IS '��� ��';
COMMENT ON COLUMN BARS.PRVN_FLOW_DETAILS.FDAT IS '���� ����';
COMMENT ON COLUMN BARS.PRVN_FLOW_DETAILS.MDAT IS '����� ����';
COMMENT ON COLUMN BARS.PRVN_FLOW_DETAILS.SS IS '����.ҳ�� SS';
COMMENT ON COLUMN BARS.PRVN_FLOW_DETAILS.SPD IS '����/������';
COMMENT ON COLUMN BARS.PRVN_FLOW_DETAILS.SN IS '���.³������ SN';
COMMENT ON COLUMN BARS.PRVN_FLOW_DETAILS.SK IS '�����';
COMMENT ON COLUMN BARS.PRVN_FLOW_DETAILS.LIM1 IS '��. ����-�������';
COMMENT ON COLUMN BARS.PRVN_FLOW_DETAILS.LIM2 IS '���. ����-�������';
COMMENT ON COLUMN BARS.PRVN_FLOW_DETAILS.DAT1 IS '�������� "�"';
COMMENT ON COLUMN BARS.PRVN_FLOW_DETAILS.DAT2 IS '�������� "��"';
COMMENT ON COLUMN BARS.PRVN_FLOW_DETAILS.SPN IS '����.³������ SPN';
COMMENT ON COLUMN BARS.PRVN_FLOW_DETAILS.SNO IS '³�����.³������';
COMMENT ON COLUMN BARS.PRVN_FLOW_DETAILS.SP IS '������.ҳ�� SP';
COMMENT ON COLUMN BARS.PRVN_FLOW_DETAILS.SN1 IS '������.³������ �� SS';
COMMENT ON COLUMN BARS.PRVN_FLOW_DETAILS.SN2 IS '������.³������ �� SP';
COMMENT ON COLUMN BARS.PRVN_FLOW_DETAILS.IR IS '����������� % ��';
COMMENT ON COLUMN BARS.PRVN_FLOW_DETAILS.KF IS '��� �i�i��� (���)';




PROMPT *** Create  constraint PK_PRVNFLOWDETAILS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_FLOW_DETAILS ADD CONSTRAINT PK_PRVNFLOWDETAILS PRIMARY KEY (ID, MDAT, FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PRVNDEALSFLOW_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PRVN_FLOW_DETAILS MODIFY (KF CONSTRAINT CC_PRVNDEALSFLOW_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PRVNFLOWDETAILS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PRVNFLOWDETAILS ON BARS.PRVN_FLOW_DETAILS (ID, MDAT, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_PRVNDEALSFLOW ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_PRVNDEALSFLOW ON BARS.PRVN_FLOW_DETAILS (MDAT, KF, ID, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 3 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PRVN_FLOW_DETAILS ***
grant SELECT,UPDATE                                                          on PRVN_FLOW_DETAILS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PRVN_FLOW_DETAILS to BARS_DM;
grant SELECT,UPDATE                                                          on PRVN_FLOW_DETAILS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PRVN_FLOW_DETAILS.sql =========*** End
PROMPT ===================================================================================== 
