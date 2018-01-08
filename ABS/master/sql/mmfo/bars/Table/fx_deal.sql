

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FX_DEAL.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FX_DEAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FX_DEAL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FX_DEAL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FX_DEAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FX_DEAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.FX_DEAL 
   (	DEAL_TAG NUMBER(*,0), 
	NTIK VARCHAR2(15), 
	DAT DATE, 
	KVA NUMBER(*,0), 
	DAT_A DATE, 
	SUMA NUMBER(*,0), 
	KVB NUMBER(*,0), 
	DAT_B DATE, 
	SUMB NUMBER(*,0), 
	REF NUMBER(*,0), 
	REFA NUMBER(*,0), 
	REFB NUMBER(*,0), 
	KODB VARCHAR2(12), 
	REFB2 NUMBER(*,0), 
	SWI_BIC CHAR(11), 
	SWI_ACC VARCHAR2(34), 
	SWI_REF NUMBER(38,0), 
	SWO_BIC CHAR(11), 
	SWO_ACC VARCHAR2(34), 
	SWO_REF NUMBER(38,0), 
	SWO_F57A VARCHAR2(250), 
	SWI_F56A VARCHAR2(250), 
	SWO_F56A VARCHAR2(250), 
	AGRMNT_NUM VARCHAR2(10), 
	AGRMNT_DATE DATE, 
	BICB CHAR(11), 
	INTERM_B VARCHAR2(250), 
	CURR_BASE CHAR(1), 
	ALT_PARTYB VARCHAR2(250), 
	TELEXNUM VARCHAR2(35), 
	REF1 NUMBER, 
	SUMP NUMBER(*,0), 
	SUMPB NUMBER(*,0), 
	SUMPA NUMBER(*,0), 
	REFB2_SPTOD NUMBER(38,0), 
	REFB_SPTOD NUMBER(38,0), 
	REFA_SPTOD NUMBER(38,0), 
	NETA NUMBER(*,0), 
	NETB NUMBER(*,0), 
	RNK NUMBER, 
	DETALI VARCHAR2(20), 
	SWAP_TAG NUMBER(*,0), 
	ACC9A NUMBER(38,0), 
	ACC9B NUMBER(38,0), 
	NLSA VARCHAR2(14), 
	NLSB VARCHAR2(14), 
	B_PAYFLAG NUMBER(1,0), 
	SUMC NUMBER(22,0), 
	SUMB1 NUMBER(22,0), 
	SUMB2 NUMBER(22,0), 
	KOD_NA VARCHAR2(7), 
	KOD_NB VARCHAR2(7), 
	FIELD_58D VARCHAR2(250), 
	VN_FLAG NUMBER(1,0), 
	SOS NUMBER(*,0), 
	NB VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FX_DEAL ***
 exec bpa.alter_policies('FX_DEAL');


COMMENT ON TABLE BARS.FX_DEAL IS '';
COMMENT ON COLUMN BARS.FX_DEAL.DEAL_TAG IS '������������� ������';
COMMENT ON COLUMN BARS.FX_DEAL.NTIK IS '����� ��������(������)';
COMMENT ON COLUMN BARS.FX_DEAL.DAT IS '���� ���������� ������';
COMMENT ON COLUMN BARS.FX_DEAL.KVA IS '������ ������� (�)';
COMMENT ON COLUMN BARS.FX_DEAL.DAT_A IS '���� ������ ��� (�������)';
COMMENT ON COLUMN BARS.FX_DEAL.SUMA IS '����� �������';
COMMENT ON COLUMN BARS.FX_DEAL.KVB IS '������ �������';
COMMENT ON COLUMN BARS.FX_DEAL.DAT_B IS '���� �������� ��� (�������)';
COMMENT ON COLUMN BARS.FX_DEAL.SUMB IS '����� �������';
COMMENT ON COLUMN BARS.FX_DEAL.REF IS '��������� 35/36 ����� ���� ����� + 9 ����� ��� ����(��������)';
COMMENT ON COLUMN BARS.FX_DEAL.REFA IS ' �� ����� �������-�';
COMMENT ON COLUMN BARS.FX_DEAL.REFB IS ' �� �������� �������-� (�����-1)';
COMMENT ON COLUMN BARS.FX_DEAL.KODB IS '��� ����� -��������';
COMMENT ON COLUMN BARS.FX_DEAL.REFB2 IS ' �� �������� �������-� (�����-2)';
COMMENT ON COLUMN BARS.FX_DEAL.SWI_BIC IS '�������� ������. ��� �����';
COMMENT ON COLUMN BARS.FX_DEAL.SWI_ACC IS '�������� ������. ����� �����';
COMMENT ON COLUMN BARS.FX_DEAL.SWI_REF IS '�������� ��������� SWIFT-���������';
COMMENT ON COLUMN BARS.FX_DEAL.SWO_BIC IS '��������� ������. ��� �����';
COMMENT ON COLUMN BARS.FX_DEAL.SWO_ACC IS '��������� ������. ����� �����';
COMMENT ON COLUMN BARS.FX_DEAL.SWO_REF IS '�������� ���������� SWIFT-���������';
COMMENT ON COLUMN BARS.FX_DEAL.SWO_F57A IS '����ୠ⨢��� ���� ��� ��室�饩 �����';
COMMENT ON COLUMN BARS.FX_DEAL.SWI_F56A IS '��������� ���������� �� ������� �';
COMMENT ON COLUMN BARS.FX_DEAL.SWO_F56A IS '��������� ���������� �� ������� �';
COMMENT ON COLUMN BARS.FX_DEAL.AGRMNT_NUM IS '����� ���. ����������';
COMMENT ON COLUMN BARS.FX_DEAL.AGRMNT_DATE IS '���� ���. ����������';
COMMENT ON COLUMN BARS.FX_DEAL.BICB IS 'BIC ��� ��������';
COMMENT ON COLUMN BARS.FX_DEAL.INTERM_B IS '��������� ���������� �� ������� � (56A)';
COMMENT ON COLUMN BARS.FX_DEAL.CURR_BASE IS '������� ������ ������ A/B';
COMMENT ON COLUMN BARS.FX_DEAL.ALT_PARTYB IS '�������������� ���� ��� ��������� ������';
COMMENT ON COLUMN BARS.FX_DEAL.TELEXNUM IS '����� ������� ��������';
COMMENT ON COLUMN BARS.FX_DEAL.REF1 IS '9 ����� ��� ���������� (��������)';
COMMENT ON COLUMN BARS.FX_DEAL.SUMP IS '������� ������(+)�������(-) �i� ������i���';
COMMENT ON COLUMN BARS.FX_DEAL.SUMPB IS '������� ���� ������i��� ��� �';
COMMENT ON COLUMN BARS.FX_DEAL.SUMPA IS '������� ���� ������i��� ��� �';
COMMENT ON COLUMN BARS.FX_DEAL.REFB2_SPTOD IS '���-�2 ��� ������ ����';
COMMENT ON COLUMN BARS.FX_DEAL.REFB_SPTOD IS '���-� ��� ������ ����';
COMMENT ON COLUMN BARS.FX_DEAL.REFA_SPTOD IS '���-� ��� ������ ����';
COMMENT ON COLUMN BARS.FX_DEAL.NETA IS '';
COMMENT ON COLUMN BARS.FX_DEAL.NETB IS '';
COMMENT ON COLUMN BARS.FX_DEAL.RNK IS '��� � �������';
COMMENT ON COLUMN BARS.FX_DEAL.DETALI IS '';
COMMENT ON COLUMN BARS.FX_DEAL.SWAP_TAG IS '������� ����-������';
COMMENT ON COLUMN BARS.FX_DEAL.ACC9A IS '������� 9��. �� ���-�';
COMMENT ON COLUMN BARS.FX_DEAL.ACC9B IS '������� 9��. �� ���-�';
COMMENT ON COLUMN BARS.FX_DEAL.NLSA IS '������� ��� ����� ������ �';
COMMENT ON COLUMN BARS.FX_DEAL.NLSB IS '������� ��� �������� ������ � (���� ��������)';
COMMENT ON COLUMN BARS.FX_DEAL.B_PAYFLAG IS '���� ������ ��������� �� ������-� (0-�� �������, 1-���(FX1), 2-SWIFT(FX4), 3-��(FX6))';
COMMENT ON COLUMN BARS.FX_DEAL.SUMC IS '���������� ������������ �����-A';
COMMENT ON COLUMN BARS.FX_DEAL.SUMB1 IS '����-1 ���-�';
COMMENT ON COLUMN BARS.FX_DEAL.SUMB2 IS '����-2 ���-�';
COMMENT ON COLUMN BARS.FX_DEAL.KOD_NA IS '��� ������.��� 1_��';
COMMENT ON COLUMN BARS.FX_DEAL.KOD_NB IS '��� ������.��� 1_��';
COMMENT ON COLUMN BARS.FX_DEAL.FIELD_58D IS '���� 58D ��� ������';
COMMENT ON COLUMN BARS.FX_DEAL.VN_FLAG IS '1-������ 9��.(���������)';
COMMENT ON COLUMN BARS.FX_DEAL.SOS IS '����  �����';
COMMENT ON COLUMN BARS.FX_DEAL.NB IS '������������ ����� ��������';




PROMPT *** Create  constraint SYS_C009828 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_DEAL MODIFY (DEAL_TAG NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_FX_DEAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_DEAL ADD CONSTRAINT XPK_FX_DEAL PRIMARY KEY (DEAL_TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FX_DEAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FX_DEAL ON BARS.FX_DEAL (DEAL_TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FX_DEAL ***
grant SELECT                                                                 on FX_DEAL         to BARSREADER_ROLE;
grant SELECT                                                                 on FX_DEAL         to BARSUPL;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on FX_DEAL         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FX_DEAL         to BARS_DM;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on FX_DEAL         to FOREX;
grant SELECT                                                                 on FX_DEAL         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FX_DEAL         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FX_DEAL.sql =========*** End *** =====
PROMPT ===================================================================================== 
