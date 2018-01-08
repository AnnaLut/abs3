prompt  создание таблицы DPT_BONUS_REQUESTS_ARC
/
prompt  Архив запросов на получение льгот к депозитным договорам ФЛ
/
prompt -------------------------------------
/

exec bpa.alter_policy_info( 'DPT_BONUS_REQUESTS_ARC', 'WHOLE' , null, null, null, null ); 
exec bpa.alter_policy_info( 'DPT_BONUS_REQUESTS_ARC', 'FILIAL', null, null, null, null );

begin
  execute immediate 'CREATE TABLE DPT_BONUS_REQUESTS_ARC(
  DPT_ID            NUMBER(38),
  BONUS_ID          NUMBER(38),
  BONUS_VALUE_PLAN  NUMBER(9,6),
  BONUS_VALUE_FACT  NUMBER(9,6),
  REQUEST_DATE      DATE ,
  REQUEST_USER      NUMBER(38),
  REQUEST_AUTO      CHAR(1 BYTE),
  REQUEST_CONFIRM   CHAR(1 BYTE),
  REQUEST_RECALC    CHAR(1 BYTE),
  REQUEST_DELETED   CHAR(1 BYTE),
  REQUEST_STATE     VARCHAR2(5 BYTE),
  PROCESS_DATE      DATE,
  PROCESS_USER      NUMBER(38),
  REQ_ID            NUMBER(38),
  REQUEST_BDATE     DATE,
  KF                VARCHAR2(6 BYTE),
  BRANCH            VARCHAR2(30 BYTE)
) TABLESPACE brsmdld';
exception when others then if (sqlcode = -955) then null; else raise; end if;
end;
/

COMMENT ON TABLE DPT_BONUS_REQUESTS_ARC IS 'Архив запросов на получение льгот к депозитным договорам ФЛ';
COMMENT ON COLUMN DPT_BONUS_REQUESTS_ARC.DPT_ID IS 'Идентификатор договора';
COMMENT ON COLUMN DPT_BONUS_REQUESTS_ARC.BONUS_ID IS 'Идентификатор льготы';
COMMENT ON COLUMN DPT_BONUS_REQUESTS_ARC.BONUS_VALUE_PLAN IS 'Размер расчетной льготной %-ной ставки';
COMMENT ON COLUMN DPT_BONUS_REQUESTS_ARC.BONUS_VALUE_FACT IS 'Размер установленной льготной %-ной ставки';
COMMENT ON COLUMN DPT_BONUS_REQUESTS_ARC.REQUEST_DATE IS 'Дата и время формирования запроса';
COMMENT ON COLUMN DPT_BONUS_REQUESTS_ARC.REQUEST_USER IS 'Пользователь-инициатор запроса';
COMMENT ON COLUMN DPT_BONUS_REQUESTS_ARC.REQUEST_AUTO IS 'Признак автомат.формировнаия';
COMMENT ON COLUMN DPT_BONUS_REQUESTS_ARC.REQUEST_CONFIRM IS 'Признак необходимости подтверждения';
COMMENT ON COLUMN DPT_BONUS_REQUESTS_ARC.REQUEST_RECALC IS 'Признак необходимости перерасчета';
COMMENT ON COLUMN DPT_BONUS_REQUESTS_ARC.REQUEST_DELETED IS 'Признак исключения из обработки';
COMMENT ON COLUMN DPT_BONUS_REQUESTS_ARC.REQUEST_STATE IS 'Статус запроса';
COMMENT ON COLUMN DPT_BONUS_REQUESTS_ARC.PROCESS_DATE IS 'Дата и время обработки запроса';
COMMENT ON COLUMN DPT_BONUS_REQUESTS_ARC.PROCESS_USER IS 'Пользователь-обработчик запроса';
COMMENT ON COLUMN DPT_BONUS_REQUESTS_ARC.REQUEST_BDATE IS 'Банк.дата формирования запроса';
/


GRANT ALL ON DPT_BONUS_REQUESTS_ARC TO BARS_ACCESS_DEFROLE;
/
