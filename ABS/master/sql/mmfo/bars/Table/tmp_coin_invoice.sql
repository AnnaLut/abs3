

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_COIN_INVOICE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_COIN_INVOICE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_COIN_INVOICE ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_COIN_INVOICE 
   (	TYPE_ID NUMBER(1,0), 
	ND VARCHAR2(64), 
	DAT DATE, 
	REASON VARCHAR2(256), 
	BAILEE VARCHAR2(128), 
	PROXY VARCHAR2(128), 
	TOTAL_COUNT NUMBER(38,0), 
	TOTAL_NOMINAL NUMBER(38,0), 
	TOTAL_SUM NUMBER(38,0), 
	TOTAL_WITHOUT_VAT NUMBER(38,0), 
	VAT_PERCENT NUMBER(38,0), 
	VAT_SUM NUMBER(38,0), 
	TOTAL_NOMINAL_PRICE NUMBER(38,0), 
	TOTAL_WITH_VAT NUMBER(38,0), 
	USERID NUMBER(38,0), 
	REF NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_COIN_INVOICE ***
 exec bpa.alter_policies('TMP_COIN_INVOICE');


COMMENT ON TABLE BARS.TMP_COIN_INVOICE IS '������� ��� �������������� �����';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE.TYPE_ID IS '��� �������� (0 - ��������/ 1 - �������)';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE.ND IS '����� ��������';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE.DAT IS '���� ��������';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE.REASON IS 'ϳ������';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE.BAILEE IS '�����';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE.PROXY IS '���������';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE.TOTAL_COUNT IS '������';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE.TOTAL_NOMINAL IS '������ �� ��������';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE.TOTAL_SUM IS '�������� ����';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE.TOTAL_WITHOUT_VAT IS '����� ��� ���';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE.VAT_PERCENT IS '% ���';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE.VAT_SUM IS '���� ���';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE.TOTAL_NOMINAL_PRICE IS '��������� �������';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE.TOTAL_WITH_VAT IS '����� � ��� �� ������';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE.USERID IS '';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE.REF IS '';



PROMPT *** Create  grants  TMP_COIN_INVOICE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_COIN_INVOICE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_COIN_INVOICE to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_COIN_INVOICE.sql =========*** End 
PROMPT ===================================================================================== 
