

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_BONUS_REQUESTS_ARC.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_BONUS_REQUESTS_ARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_BONUS_REQUESTS_ARC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_BONUS_REQUESTS_ARC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_BONUS_REQUESTS_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_BONUS_REQUESTS_ARC 
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
	KF VARCHAR2(6), 
	BRANCH VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_BONUS_REQUESTS_ARC ***
 exec bpa.alter_policies('DPT_BONUS_REQUESTS_ARC');


COMMENT ON TABLE BARS.DPT_BONUS_REQUESTS_ARC IS 'Архив запросов на получение льгот к депозитным договорам ФЛ';
COMMENT ON COLUMN BARS.DPT_BONUS_REQUESTS_ARC.DPT_ID IS 'Идентификатор договора';
COMMENT ON COLUMN BARS.DPT_BONUS_REQUESTS_ARC.BONUS_ID IS 'Идентификатор льготы';
COMMENT ON COLUMN BARS.DPT_BONUS_REQUESTS_ARC.BONUS_VALUE_PLAN IS 'Размер расчетной льготной %-ной ставки';
COMMENT ON COLUMN BARS.DPT_BONUS_REQUESTS_ARC.BONUS_VALUE_FACT IS 'Размер установленной льготной %-ной ставки';
COMMENT ON COLUMN BARS.DPT_BONUS_REQUESTS_ARC.REQUEST_DATE IS 'Дата и время формирования запроса';
COMMENT ON COLUMN BARS.DPT_BONUS_REQUESTS_ARC.REQUEST_USER IS 'Пользователь-инициатор запроса';
COMMENT ON COLUMN BARS.DPT_BONUS_REQUESTS_ARC.REQUEST_AUTO IS 'Признак автомат.формировнаия';
COMMENT ON COLUMN BARS.DPT_BONUS_REQUESTS_ARC.REQUEST_CONFIRM IS 'Признак необходимости подтверждения';
COMMENT ON COLUMN BARS.DPT_BONUS_REQUESTS_ARC.REQUEST_RECALC IS 'Признак необходимости перерасчета';
COMMENT ON COLUMN BARS.DPT_BONUS_REQUESTS_ARC.REQUEST_DELETED IS 'Признак исключения из обработки';
COMMENT ON COLUMN BARS.DPT_BONUS_REQUESTS_ARC.REQUEST_STATE IS 'Статус запроса';
COMMENT ON COLUMN BARS.DPT_BONUS_REQUESTS_ARC.PROCESS_DATE IS 'Дата и время обработки запроса';
COMMENT ON COLUMN BARS.DPT_BONUS_REQUESTS_ARC.PROCESS_USER IS 'Пользователь-обработчик запроса';
COMMENT ON COLUMN BARS.DPT_BONUS_REQUESTS_ARC.REQ_ID IS '';
COMMENT ON COLUMN BARS.DPT_BONUS_REQUESTS_ARC.REQUEST_BDATE IS 'Банк.дата формирования запроса';
COMMENT ON COLUMN BARS.DPT_BONUS_REQUESTS_ARC.KF IS '';
COMMENT ON COLUMN BARS.DPT_BONUS_REQUESTS_ARC.BRANCH IS '';



PROMPT *** Create  grants  DPT_BONUS_REQUESTS_ARC ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on DPT_BONUS_REQUESTS_ARC to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_BONUS_REQUESTS_ARC to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_BONUS_REQUESTS_ARC.sql =========**
PROMPT ===================================================================================== 
