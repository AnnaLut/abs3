

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TABVAL$GLOBAL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TABVAL$GLOBAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TABVAL$GLOBAL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TABVAL$GLOBAL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TABVAL$GLOBAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TABVAL$GLOBAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.TABVAL$GLOBAL 
   (	KV NUMBER(3,0), 
	GRP NUMBER(1,0), 
	NAME VARCHAR2(35), 
	LCV CHAR(3), 
	NOMINAL NUMBER(10,0), 
	SV CHAR(1), 
	DIG NUMBER(10,0), 
	UNIT CHAR(3), 
	COUNTRY NUMBER(3,0), 
	BASEY NUMBER(*,0), 
	GENDER CHAR(1), 
	D_CLOSE DATE, 
	DENOM NUMBER, 
	THRESHOLD NUMBER, 
	PRV NUMBER(1,0) DEFAULT 0, 
	COIN NUMBER(10,0), 
	FX_BASE NUMBER(5,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TABVAL$GLOBAL ***
 exec bpa.alter_policies('TABVAL$GLOBAL');


COMMENT ON TABLE BARS.TABVAL$GLOBAL IS 'Справочник валют';
COMMENT ON COLUMN BARS.TABVAL$GLOBAL.KV IS 'Код валюты';
COMMENT ON COLUMN BARS.TABVAL$GLOBAL.GRP IS 'Группа валюты';
COMMENT ON COLUMN BARS.TABVAL$GLOBAL.NAME IS 'Наименование валюты';
COMMENT ON COLUMN BARS.TABVAL$GLOBAL.LCV IS 'Симв Код';
COMMENT ON COLUMN BARS.TABVAL$GLOBAL.NOMINAL IS 'Номинал';
COMMENT ON COLUMN BARS.TABVAL$GLOBAL.SV IS 'Символ валюты (для СЭП НБУ)';
COMMENT ON COLUMN BARS.TABVAL$GLOBAL.DIG IS 'Коп';
COMMENT ON COLUMN BARS.TABVAL$GLOBAL.UNIT IS 'Название коп';
COMMENT ON COLUMN BARS.TABVAL$GLOBAL.COUNTRY IS 'Страна эмитент';
COMMENT ON COLUMN BARS.TABVAL$GLOBAL.BASEY IS '';
COMMENT ON COLUMN BARS.TABVAL$GLOBAL.GENDER IS '';
COMMENT ON COLUMN BARS.TABVAL$GLOBAL.D_CLOSE IS 'Дата закрытия валюты';
COMMENT ON COLUMN BARS.TABVAL$GLOBAL.DENOM IS 'Делитель валюты - 10^dig';
COMMENT ON COLUMN BARS.TABVAL$GLOBAL.THRESHOLD IS 'Порог чистоты металла';
COMMENT ON COLUMN BARS.TABVAL$GLOBAL.PRV IS 'Признак валюты (1-металл)';
COMMENT ON COLUMN BARS.TABVAL$GLOBAL.COIN IS 'Нерозмiнний залишок';
COMMENT ON COLUMN BARS.TABVAL$GLOBAL.FX_BASE IS '';




PROMPT *** Create  constraint FK_TABVAL_COUNTRY ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABVAL$GLOBAL ADD CONSTRAINT FK_TABVAL_COUNTRY FOREIGN KEY (COUNTRY)
	  REFERENCES BARS.COUNTRY (COUNTRY) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TABVAL_BASEY ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABVAL$GLOBAL ADD CONSTRAINT FK_TABVAL_BASEY FOREIGN KEY (BASEY)
	  REFERENCES BARS.BASEY (BASEY) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABVAL$GLOBAL ADD CONSTRAINT PK_TABVAL PRIMARY KEY (KV)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABVAL$GLOBAL ADD CONSTRAINT UK_TABVAL UNIQUE (LCV)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TABVAL_GENDER ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABVAL$GLOBAL ADD CONSTRAINT CC_TABVAL_GENDER CHECK (gender in (''F'', ''M'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TABVAL_PRV ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABVAL$GLOBAL ADD CONSTRAINT CC_TABVAL_PRV CHECK (prv in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TABVAL_PRV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABVAL$GLOBAL MODIFY (PRV CONSTRAINT CC_TABVAL_PRV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TABVAL_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABVAL$GLOBAL MODIFY (NAME CONSTRAINT CC_TABVAL_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TABVAL_LCV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABVAL$GLOBAL MODIFY (LCV CONSTRAINT CC_TABVAL_LCV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TABVAL_NOMINAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABVAL$GLOBAL MODIFY (NOMINAL CONSTRAINT CC_TABVAL_NOMINAL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TABVAL_DIG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABVAL$GLOBAL MODIFY (DIG CONSTRAINT CC_TABVAL_DIG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TABVAL_DENOM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABVAL$GLOBAL MODIFY (DENOM CONSTRAINT CC_TABVAL_DENOM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TABVAL_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABVAL$GLOBAL MODIFY (KV CONSTRAINT CC_TABVAL_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_TABVAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_TABVAL ON BARS.TABVAL$GLOBAL (LCV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TABVAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TABVAL ON BARS.TABVAL$GLOBAL (KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TABVAL$GLOBAL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TABVAL$GLOBAL   to ABS_ADMIN;
grant SELECT                                                                 on TABVAL$GLOBAL   to BARS010;
grant FLASHBACK,REFERENCES,SELECT                                            on TABVAL$GLOBAL   to BARSAQ with grant option;
grant REFERENCES,SELECT                                                      on TABVAL$GLOBAL   to BARSAQ_ADM with grant option;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on TABVAL$GLOBAL   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TABVAL$GLOBAL   to BARS_DM;
grant SELECT                                                                 on TABVAL$GLOBAL   to CC_DOC;
grant SELECT                                                                 on TABVAL$GLOBAL   to CUST001;
grant SELECT                                                                 on TABVAL$GLOBAL   to DEP_SKRN;
grant SELECT                                                                 on TABVAL$GLOBAL   to DPT;
grant SELECT                                                                 on TABVAL$GLOBAL   to DPT_ADMIN;
grant SELECT                                                                 on TABVAL$GLOBAL   to DPT_ROLE;
grant SELECT                                                                 on TABVAL$GLOBAL   to OBPC;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on TABVAL$GLOBAL   to RCC_DEAL;
grant SELECT                                                                 on TABVAL$GLOBAL   to RPBN001;
grant SELECT                                                                 on TABVAL$GLOBAL   to START1;
grant SELECT                                                                 on TABVAL$GLOBAL   to TOSS;
grant SELECT                                                                 on TABVAL$GLOBAL   to WEB_BALANS;
grant SELECT                                                                 on TABVAL$GLOBAL   to WR_ACRINT;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TABVAL$GLOBAL   to WR_ALL_RIGHTS;
grant SELECT                                                                 on TABVAL$GLOBAL   to WR_CUSTLIST;
grant SELECT                                                                 on TABVAL$GLOBAL   to WR_DEPOSIT_U;
grant SELECT                                                                 on TABVAL$GLOBAL   to WR_DOCHAND;
grant SELECT                                                                 on TABVAL$GLOBAL   to WR_DOCVIEW;
grant SELECT                                                                 on TABVAL$GLOBAL   to WR_DOC_INPUT;
grant FLASHBACK,SELECT                                                       on TABVAL$GLOBAL   to WR_REFREAD;
grant SELECT                                                                 on TABVAL$GLOBAL   to WR_TOBO_ACCOUNTS_LIST;
grant SELECT                                                                 on TABVAL$GLOBAL   to WR_USER_ACCOUNTS_LIST;
grant SELECT                                                                 on TABVAL$GLOBAL   to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TABVAL$GLOBAL.sql =========*** End ***
PROMPT ===================================================================================== 
