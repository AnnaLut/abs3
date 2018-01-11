

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAY_CURRENCY_INCOME.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAY_CURRENCY_INCOME ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAY_CURRENCY_INCOME'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ZAY_CURRENCY_INCOME'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''ZAY_CURRENCY_INCOME'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAY_CURRENCY_INCOME ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAY_CURRENCY_INCOME 
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




PROMPT *** ALTER_POLICIES to ZAY_CURRENCY_INCOME ***
 exec bpa.alter_policies('ZAY_CURRENCY_INCOME');


COMMENT ON TABLE BARS.ZAY_CURRENCY_INCOME IS '';
COMMENT ON COLUMN BARS.ZAY_CURRENCY_INCOME.MFO IS '';
COMMENT ON COLUMN BARS.ZAY_CURRENCY_INCOME.BRANCH IS '';
COMMENT ON COLUMN BARS.ZAY_CURRENCY_INCOME.PDAT IS '';
COMMENT ON COLUMN BARS.ZAY_CURRENCY_INCOME.TT IS '';
COMMENT ON COLUMN BARS.ZAY_CURRENCY_INCOME.REF IS '';
COMMENT ON COLUMN BARS.ZAY_CURRENCY_INCOME.NAZN IS '';
COMMENT ON COLUMN BARS.ZAY_CURRENCY_INCOME.KV IS '';
COMMENT ON COLUMN BARS.ZAY_CURRENCY_INCOME.LCV IS '';
COMMENT ON COLUMN BARS.ZAY_CURRENCY_INCOME.RNK IS '';
COMMENT ON COLUMN BARS.ZAY_CURRENCY_INCOME.OKPO IS '';
COMMENT ON COLUMN BARS.ZAY_CURRENCY_INCOME.NMK IS '';
COMMENT ON COLUMN BARS.ZAY_CURRENCY_INCOME.S IS '';
COMMENT ON COLUMN BARS.ZAY_CURRENCY_INCOME.S_OBZ IS '';
COMMENT ON COLUMN BARS.ZAY_CURRENCY_INCOME.TXT IS '';



PROMPT *** Create  grants  ZAY_CURRENCY_INCOME ***
grant SELECT                                                                 on ZAY_CURRENCY_INCOME to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAY_CURRENCY_INCOME to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ZAY_CURRENCY_INCOME to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAY_CURRENCY_INCOME to START1;
grant SELECT                                                                 on ZAY_CURRENCY_INCOME to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAY_CURRENCY_INCOME.sql =========*** E
PROMPT ===================================================================================== 
