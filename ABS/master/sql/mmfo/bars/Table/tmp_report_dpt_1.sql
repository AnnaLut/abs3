

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_REPORT_DPT_1.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_REPORT_DPT_1 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_REPORT_DPT_1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_REPORT_DPT_1 
   (	L_DEPOSITID NUMBER, 
	L_KV VARCHAR2(10), 
	L_RNK VARCHAR2(200), 
	L_NLS VARCHAR2(200), 
	ACC VARCHAR2(200), 
	L_VIDD VARCHAR2(200), 
	L_SUMMA VARCHAR2(200), 
	L_IRSTART VARCHAR2(200), 
	L_SUMMLONG VARCHAR2(200), 
	L_FOST_LIST VARCHAR2(200), 
	L_FDAT_LIST VARCHAR2(200), 
	L_NON VARCHAR2(200), 
	L_DATEND VARCHAR2(200), 
	L_DATBEGIN VARCHAR2(200), 
	L_BDAT_LIST VARCHAR2(200), 
	L_IR_ID_S VARCHAR2(200), 
	L_IR_BON_S VARCHAR2(200), 
	L_BDAT_S VARCHAR2(200), 
	L_IR_ID_E VARCHAR2(200), 
	L_IR_BON_E VARCHAR2(200), 
	L_SUMM_PERIOD VARCHAR2(200), 
	L_SUMM_PER VARCHAR2(200), 
	L_PERIOD VARCHAR2(200), 
	L_NON2 VARCHAR2(200), 
	L_KOS_LIST VARCHAR2(200), 
	L_OST_2638 VARCHAR2(200), 
	L_NON3 VARCHAR2(200), 
	L_OST_NLSP VARCHAR2(200), 
	L_NLSP VARCHAR2(200), 
	L_BRANCH VARCHAR2(200), 
	L_KF VARCHAR2(200), 
	L_KOL_SAL NUMBER, 
	L_CNT_DUBL NUMBER, 
	L_DAT_BEGIN DATE, 
	L_WB VARCHAR2(200), 
	L_BDAT_IR VARCHAR2(200), 
	L_BDAT_BR VARCHAR2(200), 
	L_BR_TP NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_REPORT_DPT_1 ***
 exec bpa.alter_policies('TMP_REPORT_DPT_1');


COMMENT ON TABLE BARS.TMP_REPORT_DPT_1 IS '';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_DEPOSITID IS '� ���.';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_KV IS '������';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_RNK IS '��� �������';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_NLS IS '� �����';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.ACC IS '��. �����';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_VIDD IS '��� ���� ������ ';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_SUMMA IS '���� ������ �� ������ ���������';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_IRSTART IS '����� �� ������ �������� ������ ';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_SUMMLONG IS '���� ������ ����� ��������, ����� �������';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_FOST_LIST IS '���� ������ ����� ����������, ����� �������';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_FDAT_LIST IS '����  ���������� , ����� �������';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_NON IS '����� �� ������ ��������, ����� �������';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_DATEND IS '���� ��������� ��������';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_DATBEGIN IS '���� ��������, ����� �������';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_BDAT_LIST IS '���� ��������� ����� ����� �������';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_IR_ID_S IS '������ �� ������ ����� (���������� ������ �';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_IR_BON_S IS '����� �� ������ ����� (���������� ������ �';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_BDAT_S IS '���� �������� ������ ��� ������� " O"';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_IR_ID_E IS '������� ������ (�����������)';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_IR_BON_E IS '������� ����� (�����������)';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_SUMM_PERIOD IS '����� ����������� %%, ����� �������';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_SUMM_PER IS '����� ������������� %%';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_PERIOD IS '������ ����������';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_NON2 IS '�����, ������� ����� ���� ���������� �� ���������� ������';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_KOS_LIST IS '����� ���������� (����� �������)';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_OST_2638 IS '������� �� 2638';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_NON3 IS '������� �� 2630(2635),  �� ������ ����� �������.';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_OST_NLSP IS '������� �� ����� ������������';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_NLSP IS '���� ������������';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_KF IS '';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_KOL_SAL IS '';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_CNT_DUBL IS '';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_DAT_BEGIN IS '';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_WB IS '';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_BDAT_IR IS '';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_BDAT_BR IS '';
COMMENT ON COLUMN BARS.TMP_REPORT_DPT_1.L_BR_TP IS '';



PROMPT *** Create  grants  TMP_REPORT_DPT_1 ***
grant SELECT                                                                 on TMP_REPORT_DPT_1 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_REPORT_DPT_1.sql =========*** End 
PROMPT ===================================================================================== 