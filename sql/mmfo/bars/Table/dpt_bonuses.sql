

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_BONUSES.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_BONUSES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_BONUSES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_BONUSES'', ''FILIAL'' , null, null, null, ''E'');
               bpa.alter_policy_info(''DPT_BONUSES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_BONUSES ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_BONUSES 
   (	BONUS_ID NUMBER(38,0), 
	BONUS_NAME VARCHAR2(100), 
	BONUS_CODE CHAR(4), 
	BONUS_ACTIVITY CHAR(1), 
	BONUS_MULTIPLY CHAR(1), 
	BONUS_CONFIRM CHAR(1), 
	BONUS_QUERY VARCHAR2(4000), 
	BONUS_ON DATE, 
	BONUS_OFF DATE, 
	DELETED DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_BONUSES ***
 exec bpa.alter_policies('DPT_BONUSES');


COMMENT ON TABLE BARS.DPT_BONUSES IS 'Справочник льгот для депозитных договоров ФЛ';
COMMENT ON COLUMN BARS.DPT_BONUSES.BONUS_ID IS 'Идентификатор льготы';
COMMENT ON COLUMN BARS.DPT_BONUSES.BONUS_NAME IS 'Наименование льготы';
COMMENT ON COLUMN BARS.DPT_BONUSES.BONUS_CODE IS 'Символьный код льготы';
COMMENT ON COLUMN BARS.DPT_BONUSES.BONUS_ACTIVITY IS 'Признак активности льготы';
COMMENT ON COLUMN BARS.DPT_BONUSES.BONUS_MULTIPLY IS 'Признак сложной льготы';
COMMENT ON COLUMN BARS.DPT_BONUSES.BONUS_CONFIRM IS 'Признак подтверждения льготы';
COMMENT ON COLUMN BARS.DPT_BONUSES.BONUS_QUERY IS 'SQL-выражение для расчета величины льготы';
COMMENT ON COLUMN BARS.DPT_BONUSES.BONUS_ON IS 'Дата вступления в силу льготы';
COMMENT ON COLUMN BARS.DPT_BONUSES.BONUS_OFF IS 'Дата окончания действия льготы';
COMMENT ON COLUMN BARS.DPT_BONUSES.DELETED IS 'Дата удаления льготы';




PROMPT *** Create  constraint CC_DPTBONUS_BONUSMULTIPLY ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUSES ADD CONSTRAINT CC_DPTBONUS_BONUSMULTIPLY CHECK (bonus_multiply IN (''Y'',''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPTBONUS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUSES ADD CONSTRAINT PK_DPTBONUS PRIMARY KEY (BONUS_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBONUS_BONUSACTIVITY ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUSES ADD CONSTRAINT CC_DPTBONUS_BONUSACTIVITY CHECK (bonus_activity IN (''Y'',''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBONUS_BONUSCONFIRM ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUSES ADD CONSTRAINT CC_DPTBONUS_BONUSCONFIRM CHECK (bonus_confirm IN (''Y'',''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBONUS_BONUSID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUSES MODIFY (BONUS_ID CONSTRAINT CC_DPTBONUS_BONUSID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBONUS_BONUSNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUSES MODIFY (BONUS_NAME CONSTRAINT CC_DPTBONUS_BONUSNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBONUS_BONUSACTIVITY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUSES MODIFY (BONUS_ACTIVITY CONSTRAINT CC_DPTBONUS_BONUSACTIVITY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBONUS_BONUSMULTIPLY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUSES MODIFY (BONUS_MULTIPLY CONSTRAINT CC_DPTBONUS_BONUSMULTIPLY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBONUS_BONUSCONFIRM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUSES MODIFY (BONUS_CONFIRM CONSTRAINT CC_DPTBONUS_BONUSCONFIRM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBONUS_BONUSQUERY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUSES MODIFY (BONUS_QUERY CONSTRAINT CC_DPTBONUS_BONUSQUERY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBONUS_DATEON_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUSES MODIFY (BONUS_ON CONSTRAINT CC_DPTBONUS_DATEON_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTBONUS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTBONUS ON BARS.DPT_BONUSES (BONUS_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_BONUSES ***
grant SELECT                                                                 on DPT_BONUSES     to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_BONUSES     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_BONUSES     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_BONUSES     to DPT_ADMIN;
grant SELECT                                                                 on DPT_BONUSES     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_BONUSES     to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DPT_BONUSES     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_BONUSES.sql =========*** End *** =
PROMPT ===================================================================================== 
