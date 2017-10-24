

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPU_VIDD_RATE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPU_VIDD_RATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPU_VIDD_RATE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPU_VIDD_RATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DPU_VIDD_RATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPU_VIDD_RATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPU_VIDD_RATE 
   (	ID NUMBER(38,0), 
	VIDD NUMBER(38,0), 
	TERM NUMBER DEFAULT 0, 
	LIMIT NUMBER(24,0), 
	RATE NUMBER(20,4), 
	TERM_DAYS NUMBER(38,0) DEFAULT 0, 
	TERM_INCLUDE NUMBER(1,0) DEFAULT 0, 
	SUMM_INCLUDE NUMBER(1,0) DEFAULT 0, 
	MAX_RATE NUMBER(20,4), 
	TYPE_ID NUMBER(38,0), 
	KV NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPU_VIDD_RATE ***
 exec bpa.alter_policies('DPU_VIDD_RATE');


COMMENT ON TABLE BARS.DPU_VIDD_RATE IS 'Шкала процентных ставок по депозитам ЮЛ';
COMMENT ON COLUMN BARS.DPU_VIDD_RATE.ID IS 'Идентификатор';
COMMENT ON COLUMN BARS.DPU_VIDD_RATE.VIDD IS 'Код вида договора';
COMMENT ON COLUMN BARS.DPU_VIDD_RATE.TERM IS 'Гран.срок договора (в мес.)';
COMMENT ON COLUMN BARS.DPU_VIDD_RATE.LIMIT IS 'Гран.сумма договора';
COMMENT ON COLUMN BARS.DPU_VIDD_RATE.RATE IS '%-ная ставка';
COMMENT ON COLUMN BARS.DPU_VIDD_RATE.TERM_DAYS IS 'Гран.срок договора (в днях)';
COMMENT ON COLUMN BARS.DPU_VIDD_RATE.TERM_INCLUDE IS '';
COMMENT ON COLUMN BARS.DPU_VIDD_RATE.SUMM_INCLUDE IS '';
COMMENT ON COLUMN BARS.DPU_VIDD_RATE.MAX_RATE IS 'Макс.допустимая ставка для диапазона';
COMMENT ON COLUMN BARS.DPU_VIDD_RATE.TYPE_ID IS 'Тип договора (тип продукта)';
COMMENT ON COLUMN BARS.DPU_VIDD_RATE.KV IS 'Валюта';
COMMENT ON COLUMN BARS.DPU_VIDD_RATE.KF IS 'Код фiлiалу (МФО)';




PROMPT *** Create  constraint CC_DPUVIDDRATE_POSITIVES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD_RATE ADD CONSTRAINT CC_DPUVIDDRATE_POSITIVES CHECK ((term between 0 and 99) and (term_days between 0 and 9999)  and nvl(limit, 0) >= 0 and rate >= 0 and nvl(max_rate,0) >= 0) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_DPUVIDDRATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD_RATE ADD CONSTRAINT UK_DPUVIDDRATE UNIQUE (KF, TYPE_ID, KV, VIDD, TERM, TERM_DAYS, LIMIT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDDRATE_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD_RATE MODIFY (KV CONSTRAINT CC_DPUVIDDRATE_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDDRATE_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD_RATE MODIFY (TYPE_ID CONSTRAINT CC_DPUVIDDRATE_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDDRATE_SUMMINCLUDE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD_RATE MODIFY (SUMM_INCLUDE CONSTRAINT CC_DPUVIDDRATE_SUMMINCLUDE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDDRATE_TERMINCLUDE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD_RATE MODIFY (TERM_INCLUDE CONSTRAINT CC_DPUVIDDRATE_TERMINCLUDE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDDRATE_TERMDAYS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD_RATE MODIFY (TERM_DAYS CONSTRAINT CC_DPUVIDDRATE_TERMDAYS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDDRATE_RATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD_RATE MODIFY (RATE CONSTRAINT CC_DPUVIDDRATE_RATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDDRATE_TERM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD_RATE MODIFY (TERM CONSTRAINT CC_DPUVIDDRATE_TERM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDDRATE_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD_RATE MODIFY (ID CONSTRAINT CC_DPUVIDDRATE_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDDRATE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD_RATE MODIFY (KF CONSTRAINT CC_DPUVIDDRATE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUVIDDRATE_DPUVIDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD_RATE ADD CONSTRAINT FK_DPUVIDDRATE_DPUVIDD FOREIGN KEY (VIDD, TYPE_ID)
	  REFERENCES BARS.DPU_VIDD (VIDD, TYPE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUVIDDRATE_DPUTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD_RATE ADD CONSTRAINT FK_DPUVIDDRATE_DPUTYPES FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.DPU_TYPES (TYPE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPUVIDDRATE_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD_RATE ADD CONSTRAINT FK_DPUVIDDRATE_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDDRATE_TERMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD_RATE ADD CONSTRAINT CC_DPUVIDDRATE_TERMS CHECK (term * term_days = 0) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPUVIDDRATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD_RATE ADD CONSTRAINT PK_DPUVIDDRATE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDDRATE_TERMINCLUDE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD_RATE ADD CONSTRAINT CC_DPUVIDDRATE_TERMINCLUDE CHECK (term_include in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDDRATE_RATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD_RATE ADD CONSTRAINT CC_DPUVIDDRATE_RATES CHECK (max_rate is null or (max_rate is not null and max_rate >= rate)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUVIDDRATE_SUMMINCLUDE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_VIDD_RATE ADD CONSTRAINT CC_DPUVIDDRATE_SUMMINCLUDE CHECK (summ_include in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPUVIDDRATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPUVIDDRATE ON BARS.DPU_VIDD_RATE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_DPUVIDDRATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_DPUVIDDRATE ON BARS.DPU_VIDD_RATE (KF, TYPE_ID, KV, VIDD, TERM, TERM_DAYS, LIMIT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPU_VIDD_RATE ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPU_VIDD_RATE   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPU_VIDD_RATE   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_VIDD_RATE   to DPT_ADMIN;
grant SELECT                                                                 on DPU_VIDD_RATE   to DPT_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPU_VIDD_RATE   to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DPU_VIDD_RATE   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPU_VIDD_RATE.sql =========*** End ***
PROMPT ===================================================================================== 
