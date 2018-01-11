

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


COMMENT ON TABLE BARS.TMP_COIN_INVOICE_DETAIL IS 'Деталі накладних для оприбуткування монет';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE_DETAIL.RN IS 'Номер рядку';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE_DETAIL.ND IS 'Номер накладної';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE_DETAIL.CODE IS 'Код';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE_DETAIL.NAME IS 'Назва';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE_DETAIL.METAL IS 'Метал';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE_DETAIL.NOMINAL IS 'Платіжний номінал';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE_DETAIL.CNT IS 'Кількість';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE_DETAIL.NOMINAL_PRICE IS 'Сума за номіналом';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE_DETAIL.UNIT_PRICE_VAT IS 'Сума за номіналом З ПДВ';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE_DETAIL.UNIT_PRICE IS 'Ціна за 1 шт без ПДВ та НОМ';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE_DETAIL.NOMINAL_SUM IS 'Сума без ПДВ та НОМ';
COMMENT ON COLUMN BARS.TMP_COIN_INVOICE_DETAIL.USERID IS '';



PROMPT *** Create  grants  TMP_COIN_INVOICE_DETAIL ***
grant SELECT                                                                 on TMP_COIN_INVOICE_DETAIL to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_COIN_INVOICE_DETAIL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_COIN_INVOICE_DETAIL to BARS_DM;
grant SELECT                                                                 on TMP_COIN_INVOICE_DETAIL to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_COIN_INVOICE_DETAIL.sql =========*
PROMPT ===================================================================================== 
