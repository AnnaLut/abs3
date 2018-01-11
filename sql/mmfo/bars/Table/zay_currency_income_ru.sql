

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAY_CURRENCY_INCOME_RU.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAY_CURRENCY_INCOME_RU ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAY_CURRENCY_INCOME_RU'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ZAY_CURRENCY_INCOME_RU'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ZAY_CURRENCY_INCOME_RU'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAY_CURRENCY_INCOME_RU ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAY_CURRENCY_INCOME_RU 
   (	MFO VARCHAR2(6), 
	BRANCH VARCHAR2(30), 
	PDAT DATE, 
	TT VARCHAR2(3), 
	REF NUMBER, 
	NAZN VARCHAR2(160), 
	KV NUMBER(3,0), 
	LCV VARCHAR2(3), 
	RNK NUMBER, 
	OKPO VARCHAR2(14), 
	NMK VARCHAR2(70), 
	S NUMBER, 
	S_OBZ NUMBER, 
	TXT VARCHAR2(60)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAY_CURRENCY_INCOME_RU ***
 exec bpa.alter_policies('ZAY_CURRENCY_INCOME_RU');


COMMENT ON TABLE BARS.ZAY_CURRENCY_INCOME_RU IS '';
COMMENT ON COLUMN BARS.ZAY_CURRENCY_INCOME_RU.MFO IS '';
COMMENT ON COLUMN BARS.ZAY_CURRENCY_INCOME_RU.BRANCH IS '';
COMMENT ON COLUMN BARS.ZAY_CURRENCY_INCOME_RU.PDAT IS '';
COMMENT ON COLUMN BARS.ZAY_CURRENCY_INCOME_RU.TT IS '';
COMMENT ON COLUMN BARS.ZAY_CURRENCY_INCOME_RU.REF IS '';
COMMENT ON COLUMN BARS.ZAY_CURRENCY_INCOME_RU.NAZN IS '';
COMMENT ON COLUMN BARS.ZAY_CURRENCY_INCOME_RU.KV IS '';
COMMENT ON COLUMN BARS.ZAY_CURRENCY_INCOME_RU.LCV IS '';
COMMENT ON COLUMN BARS.ZAY_CURRENCY_INCOME_RU.RNK IS '';
COMMENT ON COLUMN BARS.ZAY_CURRENCY_INCOME_RU.OKPO IS '';
COMMENT ON COLUMN BARS.ZAY_CURRENCY_INCOME_RU.NMK IS '';
COMMENT ON COLUMN BARS.ZAY_CURRENCY_INCOME_RU.S IS '';
COMMENT ON COLUMN BARS.ZAY_CURRENCY_INCOME_RU.S_OBZ IS '';
COMMENT ON COLUMN BARS.ZAY_CURRENCY_INCOME_RU.TXT IS '';



PROMPT *** Create  grants  ZAY_CURRENCY_INCOME_RU ***
grant SELECT                                                                 on ZAY_CURRENCY_INCOME_RU to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAY_CURRENCY_INCOME_RU to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ZAY_CURRENCY_INCOME_RU to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAY_CURRENCY_INCOME_RU to START1;
grant SELECT                                                                 on ZAY_CURRENCY_INCOME_RU to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAY_CURRENCY_INCOME_RU.sql =========**
PROMPT ===================================================================================== 
