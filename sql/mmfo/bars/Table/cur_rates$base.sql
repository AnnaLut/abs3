

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUR_RATES$BASE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUR_RATES$BASE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUR_RATES$BASE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CUR_RATES$BASE'', ''FILIAL'' , null, null, ''B'', null);
               bpa.alter_policy_info(''CUR_RATES$BASE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUR_RATES$BASE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUR_RATES$BASE 
   (	KV NUMBER(3,0), 
	VDATE DATE, 
	BSUM NUMBER(9,4), 
	RATE_O NUMBER(9,4), 
	RATE_B NUMBER(9,4), 
	RATE_S NUMBER(9,4), 
	RATE_SPOT NUMBER(9,4), 
	RATE_FORWARD NUMBER(9,4), 
	LIM_POS NUMBER(24,0), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	OTM VARCHAR2(1) DEFAULT ''Y'', 
	OFFICIAL VARCHAR2(1) DEFAULT ''N''
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUR_RATES$BASE ***
 exec bpa.alter_policies('CUR_RATES$BASE');


COMMENT ON TABLE BARS.CUR_RATES$BASE IS 'Официальные курсы валют';
COMMENT ON COLUMN BARS.CUR_RATES$BASE.KV IS 'Код валюты';
COMMENT ON COLUMN BARS.CUR_RATES$BASE.VDATE IS 'Дата валютирования (установки курса)';
COMMENT ON COLUMN BARS.CUR_RATES$BASE.BSUM IS 'Базовая сумма';
COMMENT ON COLUMN BARS.CUR_RATES$BASE.RATE_O IS 'Официальный курс';
COMMENT ON COLUMN BARS.CUR_RATES$BASE.RATE_B IS 'Курс покупки';
COMMENT ON COLUMN BARS.CUR_RATES$BASE.RATE_S IS 'Курс продажи';
COMMENT ON COLUMN BARS.CUR_RATES$BASE.RATE_SPOT IS 'SPOT-курс';
COMMENT ON COLUMN BARS.CUR_RATES$BASE.RATE_FORWARD IS 'Курс для форвардных сделок';
COMMENT ON COLUMN BARS.CUR_RATES$BASE.LIM_POS IS 'Лимит';
COMMENT ON COLUMN BARS.CUR_RATES$BASE.BRANCH IS 'Ид. подразделения';
COMMENT ON COLUMN BARS.CUR_RATES$BASE.OTM IS 'Отметка о визировании (Y-завизировано, N-нет)';
COMMENT ON COLUMN BARS.CUR_RATES$BASE.OFFICIAL IS 'Y-принят офф.курс, N-не принят офф.курс';




PROMPT *** Create  constraint CC_CURRATES$BASE_OFFICIAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUR_RATES$BASE ADD CONSTRAINT CC_CURRATES$BASE_OFFICIAL CHECK (OFFICIAL in (''Y'',''N'')) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CURRATES$BASE_VDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUR_RATES$BASE ADD CONSTRAINT CC_CURRATES$BASE_VDATE CHECK (vdate = trunc(vdate)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CURRATES$BASE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUR_RATES$BASE ADD CONSTRAINT PK_CURRATES$BASE PRIMARY KEY (BRANCH, VDATE, KV)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CURRATES$BASE_OTM ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUR_RATES$BASE ADD CONSTRAINT CC_CURRATES$BASE_OTM CHECK (OTM in (''Y'',''N'')) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CURRATES$BASE_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUR_RATES$BASE MODIFY (KV CONSTRAINT CC_CURRATES$BASE_KV_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CURRATES$BASE_VDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUR_RATES$BASE MODIFY (VDATE CONSTRAINT CC_CURRATES$BASE_VDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CURRATES$BASE_BSUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUR_RATES$BASE MODIFY (BSUM CONSTRAINT CC_CURRATES$BASE_BSUM_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CURRATES$BASE_RATEO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUR_RATES$BASE MODIFY (RATE_O CONSTRAINT CC_CURRATES$BASE_RATEO_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CURRATES$BASE_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUR_RATES$BASE MODIFY (BRANCH CONSTRAINT CC_CURRATES$BASE_BRANCH_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005804 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CUR_RATES$BASE MODIFY (OTM NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CURRATES$BASE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CURRATES$BASE ON BARS.CUR_RATES$BASE (BRANCH, VDATE, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUR_RATES$BASE ***
grant SELECT                                                                 on CUR_RATES$BASE  to BARSAQ with grant option;
grant SELECT                                                                 on CUR_RATES$BASE  to BARSREADER_ROLE;
grant SELECT                                                                 on CUR_RATES$BASE  to BARSUPL;
grant INSERT,SELECT,UPDATE                                                   on CUR_RATES$BASE  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUR_RATES$BASE  to BARS_DM;
grant SELECT                                                                 on CUR_RATES$BASE  to JBOSS_USR;
grant INSERT,SELECT,UPDATE                                                   on CUR_RATES$BASE  to PYOD001;
grant SELECT                                                                 on CUR_RATES$BASE  to REFSYNC_USR;
grant INSERT,SELECT,UPDATE                                                   on CUR_RATES$BASE  to TECH005;
grant SELECT                                                                 on CUR_RATES$BASE  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CUR_RATES$BASE  to WR_ALL_RIGHTS;
grant SELECT                                                                 on CUR_RATES$BASE  to WR_RATES;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUR_RATES$BASE.sql =========*** End **
PROMPT ===================================================================================== 
