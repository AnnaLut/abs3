

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAG_B.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAG_B ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAG_B'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ZAG_B'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ZAG_B'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAG_B ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAG_B 
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
	SSP_SIGN_KEY CHAR(6), 
	SSP_SIGN RAW(128), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	K_ER NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAG_B ***
 exec bpa.alter_policies('ZAG_B');


COMMENT ON TABLE BARS.ZAG_B IS 'Заголовки исходящих файлов (РРП)';
COMMENT ON COLUMN BARS.ZAG_B.FN IS 'Имя файла $B (на участника РРП)';
COMMENT ON COLUMN BARS.ZAG_B.DAT IS 'Дата/время формирования файла $B в нашей РРП';
COMMENT ON COLUMN BARS.ZAG_B.REF IS 'Референс документа';
COMMENT ON COLUMN BARS.ZAG_B.KV IS 'Код валюты';
COMMENT ON COLUMN BARS.ZAG_B.N IS 'Кол-во строк';
COMMENT ON COLUMN BARS.ZAG_B.SDE IS 'Сумма дебета';
COMMENT ON COLUMN BARS.ZAG_B.SKR IS 'Сумма кредита';
COMMENT ON COLUMN BARS.ZAG_B.DATK IS 'Дата квитовки (зачисления на коррсчет)';
COMMENT ON COLUMN BARS.ZAG_B.DAT_2 IS 'Дата/время получения $B в банке Б (по квитанции ^S)';
COMMENT ON COLUMN BARS.ZAG_B.OTM IS 'Флаг формирования файла $B (=1), сквитованности (=2)';
COMMENT ON COLUMN BARS.ZAG_B.SIGN IS 'Подпись';
COMMENT ON COLUMN BARS.ZAG_B.SIGN_KEY IS 'Идентификатор ключа подписи';
COMMENT ON COLUMN BARS.ZAG_B.SSP_SIGN_KEY IS 'Идентификатор ключа подписи ССП';
COMMENT ON COLUMN BARS.ZAG_B.SSP_SIGN IS 'Подпись ССП';
COMMENT ON COLUMN BARS.ZAG_B.KF IS '';
COMMENT ON COLUMN BARS.ZAG_B.K_ER IS 'Код ошибки по файлу';




PROMPT *** Create  constraint CC_ZAGB_FN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_B MODIFY (FN CONSTRAINT CC_ZAGB_FN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAGB_DAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_B MODIFY (DAT CONSTRAINT CC_ZAGB_DAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAGB_SDE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_B MODIFY (SDE CONSTRAINT CC_ZAGB_SDE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAGB_SKR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_B MODIFY (SKR CONSTRAINT CC_ZAGB_SKR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAGB_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_B MODIFY (KF CONSTRAINT CC_ZAGB_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAGB_OTM ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_B ADD CONSTRAINT CC_ZAGB_OTM CHECK (otm between 0 and 7) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ZAGB ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAG_B ADD CONSTRAINT PK_ZAGB PRIMARY KEY (KF, DAT, FN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ZAGB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ZAGB ON BARS.ZAG_B (KF, DAT, FN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_ZAG_B_DECODE_OTM ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_ZAG_B_DECODE_OTM ON BARS.ZAG_B (DECODE(OTM,0,0,1,1,2,2,3,3,NULL)) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAG_B ***
grant UPDATE                                                                 on ZAG_B           to BARS014;
grant SELECT                                                                 on ZAG_B           to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on ZAG_B           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ZAG_B           to BARS_DM;
grant SELECT                                                                 on ZAG_B           to START1;
grant SELECT,UPDATE                                                          on ZAG_B           to TOSS;
grant SELECT                                                                 on ZAG_B           to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ZAG_B           to WR_ALL_RIGHTS;
grant SELECT                                                                 on ZAG_B           to WR_DOCVIEW;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAG_B.sql =========*** End *** =======
PROMPT ===================================================================================== 
