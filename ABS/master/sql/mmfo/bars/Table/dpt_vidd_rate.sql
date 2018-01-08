

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_VIDD_RATE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_VIDD_RATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_VIDD_RATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_VIDD_RATE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_VIDD_RATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_VIDD_RATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_VIDD_RATE 
   (	ID NUMBER(38,0), 
	VIDD NUMBER(38,0), 
	TERM_M NUMBER(10,0), 
	TERM_D NUMBER, 
	LIMIT NUMBER, 
	RATE NUMBER(20,4), 
	DAT DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_VIDD_RATE ***
 exec bpa.alter_policies('DPT_VIDD_RATE');


COMMENT ON TABLE BARS.DPT_VIDD_RATE IS 'Шкала процентных ставок по депозитам ФЛ';
COMMENT ON COLUMN BARS.DPT_VIDD_RATE.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.DPT_VIDD_RATE.VIDD IS 'Код вида вклада';
COMMENT ON COLUMN BARS.DPT_VIDD_RATE.TERM_M IS 'Срок вклада(мес.)';
COMMENT ON COLUMN BARS.DPT_VIDD_RATE.TERM_D IS 'Срок вклада(дни)';
COMMENT ON COLUMN BARS.DPT_VIDD_RATE.LIMIT IS 'Гран.сумма вклада';
COMMENT ON COLUMN BARS.DPT_VIDD_RATE.RATE IS '%-ная ставка';
COMMENT ON COLUMN BARS.DPT_VIDD_RATE.DAT IS 'Дата начала действия ставки';




PROMPT *** Create  constraint FK_DPTVIDDRATE_DPTVIDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_RATE ADD CONSTRAINT FK_DPTVIDDRATE_DPTVIDD FOREIGN KEY (VIDD)
	  REFERENCES BARS.DPT_VIDD (VIDD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPTVIDDRATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_RATE ADD CONSTRAINT PK_DPTVIDDRATE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDRATE_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_RATE MODIFY (ID CONSTRAINT CC_DPTVIDDRATE_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDRATE_VIDD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_RATE MODIFY (VIDD CONSTRAINT CC_DPTVIDDRATE_VIDD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDRATE_DAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_RATE MODIFY (DAT CONSTRAINT CC_DPTVIDDRATE_DAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDRATE_TERMD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_RATE MODIFY (TERM_D CONSTRAINT CC_DPTVIDDRATE_TERMD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDRATE_LIMIT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_RATE MODIFY (LIMIT CONSTRAINT CC_DPTVIDDRATE_LIMIT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDRATE_RATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_RATE MODIFY (RATE CONSTRAINT CC_DPTVIDDRATE_RATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDRATE_TERMM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_RATE MODIFY (TERM_M CONSTRAINT CC_DPTVIDDRATE_TERMM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTVIDDRATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTVIDDRATE ON BARS.DPT_VIDD_RATE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_VIDD_RATE ***
grant SELECT                                                                 on DPT_VIDD_RATE   to BARSAQ with grant option;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_VIDD_RATE   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_VIDD_RATE   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_VIDD_RATE   to DPT_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_VIDD_RATE   to DPT_ROLE;
grant SELECT,SELECT                                                          on DPT_VIDD_RATE   to KLBX;
grant SELECT                                                                 on DPT_VIDD_RATE   to REFSYNC_USR;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_VIDD_RATE   to VKLAD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_VIDD_RATE   to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DPT_VIDD_RATE   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_VIDD_RATE.sql =========*** End ***
PROMPT ===================================================================================== 
