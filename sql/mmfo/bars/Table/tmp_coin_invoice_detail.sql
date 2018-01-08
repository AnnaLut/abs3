

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_COIN_INVOICE_DETAIL.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_COIN_INVOICE_DETAIL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_COIN_INVOICE_DETAIL ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_COIN_INVOICE_DETAIL 
   (	RN NUMBER(38,0), 
	ND VARCHAR2(64), 
	CODE VARCHAR2(11), 
	NAME VARCHAR2(256), 
	METAL VARCHAR2(128), 
	NOMINAL NUMBER(38,0), 
	CNT NUMBER(38,0), 
	NOMINAL_PRICE NUMBER(38,0), 
	UNIT_PRICE_VAT NUMBER(38,0), 
	UNIT_PRICE NUMBER(38,0), 
	NOMINAL_SUM NUMBER(38,0), 
	USERID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_COIN_INVOICE_DETAIL ***
 exec bpa.alter_policies('TMP_COIN_INVOICE_DETAIL');


COMMENT ON TABLE BARS.TMP_COIN_INVOICE_DETAIL IS '����� ��������� ��� �������������� �����';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE_DETAIL.RN IS '����� �����';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE_DETAIL.ND IS '����� ��������';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE_DETAIL.CODE IS '���';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE_DETAIL.NAME IS '�����';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE_DETAIL.METAL IS '�����';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE_DETAIL.NOMINAL IS '�������� ������';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE_DETAIL.CNT IS 'ʳ������';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE_DETAIL.NOMINAL_PRICE IS '���� �� ��������';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE_DETAIL.UNIT_PRICE_VAT IS '���� �� �������� � ���';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE_DETAIL.UNIT_PRICE IS 'ֳ�� �� 1 �� ��� ��� �� ���';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE_DETAIL.NOMINAL_SUM IS '���� ��� ��� �� ���';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE_DETAIL.USERID IS '';



PROMPT *** Create  grants  TMP_COIN_INVOICE_DETAIL ***
grant SELECT                                                                 on TMP_COIN_INVOICE_DETAIL to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_COIN_INVOICE_DETAIL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_COIN_INVOICE_DETAIL to BARS_DM;
grant SELECT                                                                 on TMP_COIN_INVOICE_DETAIL to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_COIN_INVOICE_DETAIL.sql =========*
PROMPT ===================================================================================== 
