Prompt create table RECEIVERS;

begin
	execute immediate '
CREATE TABLE BILLS.RECEIVERS
(
  EXP_ID         INTEGER                        NOT NULL,
  RESOLUTION_ID  INTEGER                        NOT NULL,
  NAME           VARCHAR2(60)                   NOT NULL,
  INN            VARCHAR2(10),
  DOC_NO         VARCHAR2(30),
  DOC_DATE       DATE,
  DOC_WHO        VARCHAR2(100),
  CL_TYPE        NUMBER,
  CURRENCY       VARCHAR2(3),
  CUR_RATE       NUMBER(12,6),
  AMOUNT         NUMBER(12,2),
  STATUS         VARCHAR2(2),
  PHONE          VARCHAR2(100),
  BRANCH         VARCHAR2(100),
  ACCOUNT        VARCHAR2(14),
  REQ_ID         INTEGER,
  COMMENTS       CLOB,
  RNK            NUMBER,
  LAST_DT        DATE,
  LAST_USER      VARCHAR2(30),
  EXT_STATUS     NUMBER,
  SIGNER         VARCHAR2(32),
  SIGNATURE      CLOB,
  SIGN_DATE      TIMESTAMP,
  ADDRESS        VARCHAR2(250)
)';
exception
	when others then
		if sqlcode = -955 then null; else raise; end if;
end;
/

prompt add ext_status
begin
    execute immediate 'alter table receivers add ext_status number';
exception
    when others then
        if sqlcode = -1430 then null; else raise; end if;
end;
/

prompt add signature-related columns
begin
    execute immediate 'alter table receivers add signer varchar2(32)';
exception
    when others then
        if sqlcode = -1430 then null; else raise; end if;
end;
/
begin
    execute immediate 'alter table receivers add signature clob';
exception
    when others then
        if sqlcode = -1430 then null; else raise; end if;
end;
/
begin
    execute immediate 'alter table receivers add sign_date timestamp';
exception
    when others then
        if sqlcode = -1430 then null; else raise; end if;
end;
/

prompt add address column
begin
    execute immediate 'alter table receivers add address varchar2(250)';
exception
    when others then
        if sqlcode = -1430 then null; else raise; end if;
end;
/

COMMENT ON COLUMN BILLS.RECEIVERS.EXP_ID IS 'Ід очікуваного отримувача (з судового рішення)';
COMMENT ON COLUMN BILLS.RECEIVERS.RESOLUTION_ID IS 'Ід судового рішення';
COMMENT ON COLUMN BILLS.RECEIVERS.NAME IS 'ПІБ/Найменування отримувача';
COMMENT ON COLUMN BILLS.RECEIVERS.INN IS 'ІНН/ЄДРПО отримувача';
COMMENT ON COLUMN BILLS.RECEIVERS.DOC_NO IS 'Номер документа отримувача';
COMMENT ON COLUMN BILLS.RECEIVERS.DOC_DATE IS 'Дата документа отримувача';
COMMENT ON COLUMN BILLS.RECEIVERS.DOC_WHO IS 'Ким виданий документ отримувача';
COMMENT ON COLUMN BILLS.RECEIVERS.CL_TYPE IS 'Тип отримувача ';
COMMENT ON COLUMN BILLS.RECEIVERS.CURRENCY IS 'Валюта судового рішення';
COMMENT ON COLUMN BILLS.RECEIVERS.CUR_RATE IS 'Зафіксований курс валюти для запиту на виплату';
COMMENT ON COLUMN BILLS.RECEIVERS.AMOUNT IS 'Сума судового рішення';
COMMENT ON COLUMN BILLS.RECEIVERS.STATUS IS 'Поточний стан запису';
COMMENT ON COLUMN BILLS.RECEIVERS.PHONE IS 'Телефон отримувача';
COMMENT ON COLUMN BILLS.RECEIVERS.BRANCH IS 'Відділення ';
COMMENT ON COLUMN BILLS.RECEIVERS.ACCOUNT IS 'Номер рахунку отримувача';
COMMENT ON COLUMN BILLS.RECEIVERS.REQ_ID IS 'Ід запиту на виплату (з ДКСУ)';
COMMENT ON COLUMN BILLS.RECEIVERS.COMMENTS IS 'Коментарі по запиту';
COMMENT ON COLUMN BILLS.RECEIVERS.RNK IS 'РНК клієнта банка';
COMMENT ON COLUMN BILLS.RECEIVERS.LAST_DT IS 'Дата+час останніх змін запису';
COMMENT ON COLUMN BILLS.RECEIVERS.LAST_USER IS 'Користувач, який вносив останні зміни';
COMMENT ON COLUMN BILLS.RECEIVERS.EXT_STATUS IS 'Зовнішній статус запиту (в ДКСУ)';
COMMENT ON COLUMN BILLS.RECEIVERS.SIGNER IS 'ID ключа';
COMMENT ON COLUMN BILLS.RECEIVERS.SIGNATURE IS 'ЕЦП';
COMMENT ON COLUMN BILLS.RECEIVERS.SIGN_DATE IS 'Дата підпису';
COMMENT ON COLUMN BILLS.RECEIVERS.ADDRESS IS 'Адреса стягувача';

Prompt Index XPK_RECEIVERS;
begin
	execute immediate '
CREATE UNIQUE INDEX BILLS.XPK_RECEIVERS ON BILLS.RECEIVERS
(EXP_ID)';
exception
	when others then
		if sqlcode = -955 then null; else raise; end if;
end;
/

Prompt Index I_RECEIVERS_REQ;
begin
	execute immediate '
CREATE INDEX BILLS.I_RECEIVERS_REQ ON BILLS.RECEIVERS
(REQ_ID)';
exception
	when others then
		if sqlcode = -955 then null; else raise; end if;
end;
/

Prompt Index I_RECEIVERS_RES_ID;
begin
	execute immediate '
CREATE INDEX BILLS.I_RECEIVERS_RES_ID ON BILLS.RECEIVERS
(RESOLUTION_ID)';
exception
	when others then
		if sqlcode = -955 then null; else raise; end if;
end;
/

Prompt CONSTRAINT XPK_RECEIVERS;
begin
	execute immediate '
ALTER TABLE BILLS.RECEIVERS ADD (CONSTRAINT XPK_RECEIVERS PRIMARY KEY (EXP_ID) USING INDEX BILLS.XPK_RECEIVERS ENABLE VALIDATE)';
exception
	when others then
		if sqlcode = -2260 then null; else raise; end if;
end;
/

grant select on receivers to bars_access_defrole;
