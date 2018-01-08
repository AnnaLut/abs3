

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_DYNAMIC_LAYOUT.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_DYNAMIC_LAYOUT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_DYNAMIC_LAYOUT ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_DYNAMIC_LAYOUT 
   (	ND VARCHAR2(10), 
	DATD DATE, 
	DK NUMBER(1,0), 
	SUMM NUMBER(38,0), 
	KV_A NUMBER(3,0), 
	NLS_A VARCHAR2(15), 
	OSTC NUMBER(38,0), 
	NMS VARCHAR2(70), 
	NAZN VARCHAR2(256), 
	DATE_FROM DATE, 
	DATE_TO DATE, 
	DATES_TO_NAZN NUMBER(1,0), 
	CORRECTION NUMBER(1,0), 
	REF NUMBER(38,0), 
	TYPED_PERCENT NUMBER(5,2), 
	TYPED_SUMM NUMBER(38,0), 
	BRANCH_COUNT NUMBER(38,0), 
	USERID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_DYNAMIC_LAYOUT ***
 exec bpa.alter_policies('TMP_DYNAMIC_LAYOUT');


COMMENT ON TABLE BARS.TMP_DYNAMIC_LAYOUT IS '����� ��������� �������� (���������)';
COMMENT ON COLUMN BARS.TMP_DYNAMIC_LAYOUT.ND IS '����� ���������(�������������)';
COMMENT ON COLUMN BARS.TMP_DYNAMIC_LAYOUT.DATD IS '���� ���������(�������������)';
COMMENT ON COLUMN BARS.TMP_DYNAMIC_LAYOUT.DK IS '1 - �����, 0 - ������';
COMMENT ON COLUMN BARS.TMP_DYNAMIC_LAYOUT.SUMM IS '�������� ���� ��� ���������';
COMMENT ON COLUMN BARS.TMP_DYNAMIC_LAYOUT.KV_A IS '��� ������ ������� �';
COMMENT ON COLUMN BARS.TMP_DYNAMIC_LAYOUT.NLS_A IS '����� ������� �';
COMMENT ON COLUMN BARS.TMP_DYNAMIC_LAYOUT.OSTC IS '������� ������� �';
COMMENT ON COLUMN BARS.TMP_DYNAMIC_LAYOUT.NMS IS ' ������������ ������� �';
COMMENT ON COLUMN BARS.TMP_DYNAMIC_LAYOUT.NAZN IS '����������� �������';
COMMENT ON COLUMN BARS.TMP_DYNAMIC_LAYOUT.DATE_FROM IS '���� �';
COMMENT ON COLUMN BARS.TMP_DYNAMIC_LAYOUT.DATE_TO IS '���� ��';
COMMENT ON COLUMN BARS.TMP_DYNAMIC_LAYOUT.DATES_TO_NAZN IS '������ ��������� ���� � �� ���� �� �� ����������� �������(0 - �, 1 - ���)';
COMMENT ON COLUMN BARS.TMP_DYNAMIC_LAYOUT.CORRECTION IS '������ ��������� ������� �������������� ���������';
COMMENT ON COLUMN BARS.TMP_DYNAMIC_LAYOUT.REF IS '���';
COMMENT ON COLUMN BARS.TMP_DYNAMIC_LAYOUT.TYPED_PERCENT IS '������� %';
COMMENT ON COLUMN BARS.TMP_DYNAMIC_LAYOUT.TYPED_SUMM IS ' ������� ����';
COMMENT ON COLUMN BARS.TMP_DYNAMIC_LAYOUT.BRANCH_COUNT IS '������� �������';
COMMENT ON COLUMN BARS.TMP_DYNAMIC_LAYOUT.USERID IS '';



PROMPT *** Create  grants  TMP_DYNAMIC_LAYOUT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_DYNAMIC_LAYOUT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_DYNAMIC_LAYOUT to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_DYNAMIC_LAYOUT.sql =========*** En
PROMPT ===================================================================================== 
