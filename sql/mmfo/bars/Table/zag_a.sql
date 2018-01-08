

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAG_A.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAG_A ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAG_A'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ZAG_A'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ZAG_A'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAG_A ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAG_A 
   (	FN CHAR(12), 
	DAT DATE, 
	REF NUMBER(38,0), 
	KV NUMBER(3,0), 
	N NUMBER(10,0), 
	SDE NUMBER(24,0), 
	SKR NUMBER(24,0), 
	DATK DATE, 
	DAT_2 DATE, 
	OTM NUMBER(1,0), 
	SIGN RAW(128), 
	SIGN_KEY CHAR(6), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAG_A ***
 exec bpa.alter_policies('ZAG_A');


COMMENT ON TABLE BARS.ZAG_A IS 'Заголовки входящих файлов (РРП)';
COMMENT ON COLUMN BARS.ZAG_A.FN IS 'Имя принятого файла $A';
COMMENT ON COLUMN BARS.ZAG_A.DAT IS 'Дата/время создания файла $A';
COMMENT ON COLUMN BARS.ZAG_A.REF IS 'Референс документа';
COMMENT ON COLUMN BARS.ZAG_A.KV IS 'Код валюты';
COMMENT ON COLUMN BARS.ZAG_A.N IS 'Кол-во строк в файле';
COMMENT ON COLUMN BARS.ZAG_A.SDE IS 'Сумма дебета';
COMMENT ON COLUMN BARS.ZAG_A.SKR IS 'Сумма кредита';
COMMENT ON COLUMN BARS.ZAG_A.DATK IS 'Дата квитовки';
COMMENT ON COLUMN BARS.ZAG_A.DAT_2 IS 'Дата/время получения в РРП';
COMMENT ON COLUMN BARS.ZAG_A.OTM IS 'Состояние';
COMMENT ON COLUMN BARS.ZAG_A.SIGN IS 'Подпись';
COMMENT ON COLUMN BARS.ZAG_A.SIGN_KEY IS 'Идентификатор ключа подписи';
COMMENT ON COLUMN BARS.ZAG_A.KF IS '';




PROMPT *** Create  constraint CC_ZAGA_SKR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_A MODIFY (SKR CONSTRAINT CC_ZAGA_SKR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAGA_FN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_A MODIFY (FN CONSTRAINT CC_ZAGA_FN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAGA_DAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_A MODIFY (DAT CONSTRAINT CC_ZAGA_DAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAGA_SDE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_A MODIFY (SDE CONSTRAINT CC_ZAGA_SDE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAGA_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_A MODIFY (KF CONSTRAINT CC_ZAGA_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAGA_OTM ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_A ADD CONSTRAINT CC_ZAGA_OTM CHECK (otm between 0 and 7) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ZAGA ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_A ADD CONSTRAINT PK_ZAGA PRIMARY KEY (KF, DAT, FN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ZAGA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ZAGA ON BARS.ZAG_A (KF, DAT, FN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_ZAG_A_DECODE_OTM ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_ZAG_A_DECODE_OTM ON BARS.ZAG_A (DECODE(OTM,0,0,1,1,2,2,3,3,NULL)) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAG_A ***
grant SELECT                                                                 on ZAG_A           to BARSREADER_ROLE;
grant DELETE,SELECT,UPDATE                                                   on ZAG_A           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ZAG_A           to BARS_DM;
grant INSERT                                                                 on ZAG_A           to SBB_NC;
grant DELETE                                                                 on ZAG_A           to TECH001;
grant DELETE                                                                 on ZAG_A           to TECH002;
grant SELECT,UPDATE                                                          on ZAG_A           to TOSS;
grant SELECT                                                                 on ZAG_A           to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ZAG_A           to WR_ALL_RIGHTS;
grant SELECT                                                                 on ZAG_A           to WR_DOCVIEW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAG_A.sql =========*** End *** =======
PROMPT ===================================================================================== 
