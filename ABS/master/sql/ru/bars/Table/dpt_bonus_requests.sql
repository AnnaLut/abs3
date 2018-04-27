PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_BONUS_REQUESTS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_BONUS_REQUESTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_BONUS_REQUESTS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DPT_BONUS_REQUESTS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_BONUS_REQUESTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_BONUS_REQUESTS 
   (	DPT_ID NUMBER(38,0), 
	BONUS_ID NUMBER(38,0), 
	BONUS_VALUE_PLAN NUMBER(9,6), 
	BONUS_VALUE_FACT NUMBER(9,6), 
	REQUEST_DATE DATE, 
	REQUEST_USER NUMBER(38,0), 
	REQUEST_AUTO CHAR(1), 
	REQUEST_CONFIRM CHAR(1), 
	REQUEST_RECALC CHAR(1), 
	REQUEST_DELETED CHAR(1), 
	REQUEST_STATE VARCHAR2(5), 
	PROCESS_DATE DATE, 
	PROCESS_USER NUMBER(38,0), 
	REQ_ID NUMBER(38,0), 
	REQUEST_BDATE DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_BONUS_REQUESTS ***
 exec bpa.alter_policies('DPT_BONUS_REQUESTS');


COMMENT ON TABLE BARS.DPT_BONUS_REQUESTS IS 'Архив запросов на получение льгот к депозитным договорам ФЛ';
COMMENT ON COLUMN BARS.DPT_BONUS_REQUESTS.DPT_ID IS 'Идентификатор договора';
COMMENT ON COLUMN BARS.DPT_BONUS_REQUESTS.BONUS_ID IS 'Идентификатор льготы';
COMMENT ON COLUMN BARS.DPT_BONUS_REQUESTS.BONUS_VALUE_PLAN IS 'Размер расчетной льготной %-ной ставки';
COMMENT ON COLUMN BARS.DPT_BONUS_REQUESTS.BONUS_VALUE_FACT IS 'Размер установленной льготной %-ной ставки';
COMMENT ON COLUMN BARS.DPT_BONUS_REQUESTS.REQUEST_DATE IS 'Дата и время формирования запроса';
COMMENT ON COLUMN BARS.DPT_BONUS_REQUESTS.REQUEST_USER IS 'Пользователь-инициатор запроса';
COMMENT ON COLUMN BARS.DPT_BONUS_REQUESTS.REQUEST_AUTO IS 'Признак автомат.формировнаия';
COMMENT ON COLUMN BARS.DPT_BONUS_REQUESTS.REQUEST_CONFIRM IS 'Признак необходимости подтверждения';
COMMENT ON COLUMN BARS.DPT_BONUS_REQUESTS.REQUEST_RECALC IS 'Признак необходимости перерасчета';
COMMENT ON COLUMN BARS.DPT_BONUS_REQUESTS.REQUEST_DELETED IS 'Признак исключения из обработки';
COMMENT ON COLUMN BARS.DPT_BONUS_REQUESTS.REQUEST_STATE IS 'Статус запроса';
COMMENT ON COLUMN BARS.DPT_BONUS_REQUESTS.PROCESS_DATE IS 'Дата и время обработки запроса';
COMMENT ON COLUMN BARS.DPT_BONUS_REQUESTS.PROCESS_USER IS 'Пользователь-обработчик запроса';
COMMENT ON COLUMN BARS.DPT_BONUS_REQUESTS.REQ_ID IS '';
COMMENT ON COLUMN BARS.DPT_BONUS_REQUESTS.REQUEST_BDATE IS 'Банк.дата формирования запроса';
COMMENT ON COLUMN BARS.DPT_BONUS_REQUESTS.KF IS '';
COMMENT ON COLUMN BARS.DPT_BONUS_REQUESTS.BRANCH IS '';




PROMPT *** Create  constraint FK_DPTBONUSREQ_DPTREQS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS ADD CONSTRAINT FK_DPTBONUSREQ_DPTREQS2 FOREIGN KEY (KF, REQ_ID)
	  REFERENCES BARS.DPT_REQUESTS (KF, REQ_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTBONUSREQ_DPTDPTALL2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS ADD CONSTRAINT FK_DPTBONUSREQ_DPTDPTALL2 FOREIGN KEY (KF, DPT_ID)
	  REFERENCES BARS.DPT_DEPOSIT_ALL (KF, DEPOSIT_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTBONUSREQ_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS ADD CONSTRAINT FK_DPTBONUSREQ_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTBONUSREQ_DPTBONUS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS ADD CONSTRAINT FK_DPTBONUSREQ_DPTBONUS FOREIGN KEY (BONUS_ID)
	  REFERENCES BARS.DPT_BONUSES (BONUS_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTBONUSREQ_STAFF2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS ADD CONSTRAINT FK_DPTBONUSREQ_STAFF2 FOREIGN KEY (PROCESS_USER)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTBONUSREQ_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS ADD CONSTRAINT FK_DPTBONUSREQ_STAFF FOREIGN KEY (REQUEST_USER)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTBONUSREQ_REQSTATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS ADD CONSTRAINT FK_DPTBONUSREQ_REQSTATE FOREIGN KEY (REQUEST_STATE)
	  REFERENCES BARS.DPT_BONUS_REQUEST_STATES (STATE_CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTBONUSREQ_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS ADD CONSTRAINT FK_DPTBONUSREQ_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBONUSREQ_BONUSVALFC ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS ADD CONSTRAINT CC_DPTBONUSREQ_BONUSVALFC CHECK ( (request_state = ''ALLOW'' AND bonus_value_fact IS NOT NULL) OR request_state != ''ALLOW'') ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBONUSREQ_BONUSVALPL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS ADD CONSTRAINT CC_DPTBONUSREQ_BONUSVALPL CHECK ( (request_auto = ''Y'' AND bonus_value_plan IS NOT NULL) OR request_auto = ''N'') ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBONUSREQ_REQDATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS ADD CONSTRAINT CC_DPTBONUSREQ_REQDATES CHECK (process_date IS NULL OR process_date >= request_date) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBONUSREQ_REQDELETED ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS ADD CONSTRAINT CC_DPTBONUSREQ_REQDELETED CHECK (request_deleted IN (''Y'',''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBONUSREQ_REQRECALC ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS ADD CONSTRAINT CC_DPTBONUSREQ_REQRECALC CHECK (request_recalc IN (''Y'',''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBONUSREQ_REQCONFIRM ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS ADD CONSTRAINT CC_DPTBONUSREQ_REQCONFIRM CHECK (request_confirm IN (''Y'',''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBONUSREQ_REQAUTO ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS ADD CONSTRAINT CC_DPTBONUSREQ_REQAUTO CHECK (request_auto IN (''Y'',''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPTBONUSREQ ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS ADD CONSTRAINT PK_DPTBONUSREQ PRIMARY KEY (DPT_ID, BONUS_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBONUSREQ_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS MODIFY (BRANCH CONSTRAINT CC_DPTBONUSREQ_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBONUSREQ_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS MODIFY (KF CONSTRAINT CC_DPTBONUSREQ_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBONUSREQ_REQBDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS MODIFY (REQUEST_BDATE CONSTRAINT CC_DPTBONUSREQ_REQBDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBONUSREQ_REQID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS MODIFY (REQ_ID CONSTRAINT CC_DPTBONUSREQ_REQID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBONUSREQ_REQSTATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS MODIFY (REQUEST_STATE CONSTRAINT CC_DPTBONUSREQ_REQSTATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBONUSREQ_REQDELETED_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS MODIFY (REQUEST_DELETED CONSTRAINT CC_DPTBONUSREQ_REQDELETED_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBONUSREQ_REQRECALC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS MODIFY (REQUEST_RECALC CONSTRAINT CC_DPTBONUSREQ_REQRECALC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBONUSREQ_REQCONFIRM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS MODIFY (REQUEST_CONFIRM CONSTRAINT CC_DPTBONUSREQ_REQCONFIRM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBONUSREQ_REQAUTO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS MODIFY (REQUEST_AUTO CONSTRAINT CC_DPTBONUSREQ_REQAUTO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBONUSREQ_REQUSER_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS MODIFY (REQUEST_USER CONSTRAINT CC_DPTBONUSREQ_REQUSER_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBONUSREQ_REQDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS MODIFY (REQUEST_DATE CONSTRAINT CC_DPTBONUSREQ_REQDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBONUSREQ_BONUSID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS MODIFY (BONUS_ID CONSTRAINT CC_DPTBONUSREQ_BONUSID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTBONUSREQ_DPTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_BONUS_REQUESTS MODIFY (DPT_ID CONSTRAINT CC_DPTBONUSREQ_DPTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTBONUSREQ ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTBONUSREQ ON BARS.DPT_BONUS_REQUESTS (DPT_ID, BONUS_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_BONUS_REQUESTS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_BONUS_REQUESTS to WR_ALL_RIGHTS;
grant SELECT                                                                 on DPT_BONUS_REQUESTS to BARS_ACCESS_DEFROLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_BONUS_REQUESTS.sql =========*** En
PROMPT ===================================================================================== 