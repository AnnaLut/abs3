

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_VIDD_BONUSES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_VIDD_BONUSES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_VIDD_BONUSES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_VIDD_BONUSES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_VIDD_BONUSES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_VIDD_BONUSES ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_VIDD_BONUSES 
   (	VIDD NUMBER(38,0), 
	BONUS_ID NUMBER(38,0), 
	REC_CONDITION VARCHAR2(4000), 
	REC_RANG NUMBER(38,0), 
	REC_ACTIVITY CHAR(1), 
	REC_FINALLY CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_VIDD_BONUSES ***
 exec bpa.alter_policies('DPT_VIDD_BONUSES');


COMMENT ON TABLE BARS.DPT_VIDD_BONUSES IS 'Допустимые льготы для видов депозитных договоров ФЛ';
COMMENT ON COLUMN BARS.DPT_VIDD_BONUSES.VIDD IS 'Код вида вклада';
COMMENT ON COLUMN BARS.DPT_VIDD_BONUSES.BONUS_ID IS 'Идентификатор льготы';
COMMENT ON COLUMN BARS.DPT_VIDD_BONUSES.REC_CONDITION IS 'SQL-выражение для расчета активности привязки';
COMMENT ON COLUMN BARS.DPT_VIDD_BONUSES.REC_RANG IS 'Ранг льготы (№ п/п)';
COMMENT ON COLUMN BARS.DPT_VIDD_BONUSES.REC_ACTIVITY IS 'Признак активности привязки';
COMMENT ON COLUMN BARS.DPT_VIDD_BONUSES.REC_FINALLY IS 'Признак окончания просмотра';




PROMPT *** Create  constraint FK_DPTVIDDBONUS_DPTBONUS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_BONUSES ADD CONSTRAINT FK_DPTVIDDBONUS_DPTBONUS FOREIGN KEY (BONUS_ID)
	  REFERENCES BARS.DPT_BONUSES (BONUS_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPTVIDDBONUS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_BONUSES ADD CONSTRAINT PK_DPTVIDDBONUS PRIMARY KEY (VIDD, BONUS_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDBONUS_RECFINALLY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_BONUSES MODIFY (REC_FINALLY CONSTRAINT CC_DPTVIDDBONUS_RECFINALLY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDBONUS_RECACTIVITY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_BONUSES MODIFY (REC_ACTIVITY CONSTRAINT CC_DPTVIDDBONUS_RECACTIVITY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDBONUS_RECRANG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_BONUSES MODIFY (REC_RANG CONSTRAINT CC_DPTVIDDBONUS_RECRANG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDBONUS_BONUSID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_BONUSES MODIFY (BONUS_ID CONSTRAINT CC_DPTVIDDBONUS_BONUSID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDBONUS_VIDD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_BONUSES MODIFY (VIDD CONSTRAINT CC_DPTVIDDBONUS_VIDD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDDBONUS_DPTVIDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_BONUSES ADD CONSTRAINT FK_DPTVIDDBONUS_DPTVIDD FOREIGN KEY (VIDD)
	  REFERENCES BARS.DPT_VIDD (VIDD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDBONUS_RECFINALLY ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_BONUSES ADD CONSTRAINT CC_DPTVIDDBONUS_RECFINALLY CHECK (rec_finally IN (''Y'',''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDBONUS_RECACTIVITY ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_BONUSES ADD CONSTRAINT CC_DPTVIDDBONUS_RECACTIVITY CHECK (rec_activity IN (''Y'',''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_DPTVIDDBONUS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_BONUSES ADD CONSTRAINT UK_DPTVIDDBONUS UNIQUE (VIDD, REC_RANG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTVIDDBONUS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTVIDDBONUS ON BARS.DPT_VIDD_BONUSES (VIDD, BONUS_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DPTVIDDBONUS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DPTVIDDBONUS ON BARS.DPT_VIDD_BONUSES (VIDD, REC_RANG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_VIDD_BONUSES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_VIDD_BONUSES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_VIDD_BONUSES to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_VIDD_BONUSES to DPT_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_VIDD_BONUSES to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_VIDD_BONUSES.sql =========*** End 
PROMPT ===================================================================================== 
