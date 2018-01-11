

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PRVN_FV_REZ.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PRVN_FV_REZ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PRVN_FV_REZ'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PRVN_FV_REZ'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PRVN_FV_REZ'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PRVN_FV_REZ ***
begin 
  execute immediate '
  CREATE TABLE BARS.PRVN_FV_REZ 
   (	ID_CALC_SET NUMBER(14,0), 
	ID_BRANCH VARCHAR2(30), 
	UNIQUE_BARS_IS VARCHAR2(100), 
	BARS_BRANCH_ID VARCHAR2(100), 
	RNK_CLIENT VARCHAR2(100), 
	ID_CURRENCY VARCHAR2(30), 
	PROV_BALANCE_CCY NUMBER(24,2), 
	PROV_OFFBALANCE_CCY NUMBER(24,2), 
	ID_PROV_TYPE VARCHAR2(2), 
	ID_RISK_GROUP_PD VARCHAR2(30), 
	ID_COMMITMENT VARCHAR2(100), 
	ID_CONTRACT VARCHAR2(100), 
	ID_RISK_STATUS VARCHAR2(30), 
	IS_DEFAULT NUMBER(1,0), 
	ID_RISK_PORTF_PD VARCHAR2(30), 
	PD NUMBER(13,8), 
	LGD NUMBER(13,8), 
	AIRC_CCY NUMBER(24,2), 
	IRC_CCY NUMBER(24,2), 
	OK_BARS NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PRVN_FV_REZ ***
 exec bpa.alter_policies('PRVN_FV_REZ');


COMMENT ON TABLE BARS.PRVN_FV_REZ IS '�������, ������� ���������� ��� FV � ���������.';
COMMENT ON COLUMN BARS.PRVN_FV_REZ.OK_BARS IS '';
COMMENT ON COLUMN BARS.PRVN_FV_REZ.ID_CALC_SET IS '������������� ������ ��������. �.�. ������ �� ������� ����.
                                                           ������ ���� ���������: XXYYZZWW. ���:
                                                             XX - �������� ����, ����. 2014 ����� ���������, ��� 14
                                                             YY - �������� ������
                                                             ZZ - �������� ����� ������
                                                             WW - ���������� ����� ������� �� ������� ����';
COMMENT ON COLUMN BARS.PRVN_FV_REZ.ID_BRANCH IS '���.����.���.                          ��� ������� �������� DSA_CONTRACT';
COMMENT ON COLUMN BARS.PRVN_FV_REZ.UNIQUE_BARS_IS IS '���.k���.������������� �������� � ���. ��� ������� �������� DSA_CONTRACT_CUSTOM';
COMMENT ON COLUMN BARS.PRVN_FV_REZ.BARS_BRANCH_ID IS '���.���� ������� ��� ������ (���������) � ��� (� ������ �������). ��� ������� �������� DSA_CONTRACT_CUSTOM';
COMMENT ON COLUMN BARS.PRVN_FV_REZ.RNK_CLIENT IS '���.���� ��� ������� �� ������ ��������';
COMMENT ON COLUMN BARS.PRVN_FV_REZ.ID_CURRENCY IS '���.���� ��� ������ �������';
COMMENT ON COLUMN BARS.PRVN_FV_REZ.PROV_BALANCE_CCY IS '������ �� ���������� ����� ��������.    ��������� �������� Finevare';
COMMENT ON COLUMN BARS.PRVN_FV_REZ.PROV_OFFBALANCE_CCY IS '������ �� ������������� ����� ��������. ��������� �������� Finevare';
COMMENT ON COLUMN BARS.PRVN_FV_REZ.ID_PROV_TYPE IS '����� ������� ������� �� �������������� ��� ������������ ������:
                                                           "�" - ������������, "�" - ��������������.
                                                           ��������� �������� Finevare';
COMMENT ON COLUMN BARS.PRVN_FV_REZ.ID_RISK_GROUP_PD IS '������ ����� �� �������� �������� ������������ �����������. ��������� �������� Finevare';
COMMENT ON COLUMN BARS.PRVN_FV_REZ.ID_COMMITMENT IS '???';
COMMENT ON COLUMN BARS.PRVN_FV_REZ.ID_CONTRACT IS '���������� ������������� �������� � Finevare, ��������������� � �� � ������� CKGK ���������. ��� ������� �������� DSA_CONTRACT';
COMMENT ON COLUMN BARS.PRVN_FV_REZ.ID_RISK_STATUS IS '��������� ����� �� ���.���������� �������� ������������� �������.  ��� ������� �������� DSA_CONTRACT';
COMMENT ON COLUMN BARS.PRVN_FV_REZ.IS_DEFAULT IS '����� ������� ������� �� ��������. 1 - ������, 0 - ��� �������. ��������� �������� Finevare';
COMMENT ON COLUMN BARS.PRVN_FV_REZ.ID_RISK_PORTF_PD IS '�������� ����� �� �������� �������� ������������ �����������. ��������� �������� Finevare';
COMMENT ON COLUMN BARS.PRVN_FV_REZ.PD IS '���������� ����������� ������� �� ��������.             ��������� �������� Finevare';
COMMENT ON COLUMN BARS.PRVN_FV_REZ.LGD IS '���������� ������ ������� � ������ ������� �� ��������. ��������� �������� Finevare';
COMMENT ON COLUMN BARS.PRVN_FV_REZ.AIRC_CCY IS '����������� ������������� ���������� ������� �� �������� � ������� �������� ������� ������� �� ��������.';
COMMENT ON COLUMN BARS.PRVN_FV_REZ.IRC_CCY IS '������������� �� ����� (�� ���� ����� �� ���, �� ������ ����� ������ �� ������� � ������������)';



PROMPT *** Create  grants  PRVN_FV_REZ ***
grant SELECT                                                                 on PRVN_FV_REZ     to BARSREADER_ROLE;
grant INSERT,SELECT,UPDATE                                                   on PRVN_FV_REZ     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PRVN_FV_REZ     to BARS_DM;
grant SELECT                                                                 on PRVN_FV_REZ     to START1;
grant SELECT                                                                 on PRVN_FV_REZ     to UPLD;



PROMPT *** Create SYNONYM  to PRVN_FV_REZ ***

  CREATE OR REPLACE SYNONYM BARS.OSA_V_PROV_RESULTS_OSH FOR BARS.PRVN_FV_REZ;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PRVN_FV_REZ.sql =========*** End *** =
PROMPT ===================================================================================== 
