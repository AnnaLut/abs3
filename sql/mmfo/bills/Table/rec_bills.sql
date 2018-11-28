prompt create table REC_BILLS;

begin
	execute immediate '
CREATE TABLE BILLS.REC_BILLS
(
  REC_ID      INTEGER,
  BILL_NO     VARCHAR2(30),
  DT_ISSUE    DATE,
  DT_PAYMENT  DATE,
  AMOUNT      NUMBER,
  STATUS      VARCHAR2(2),
  LAST_DT     DATE,
  LAST_USER   VARCHAR2(30),
  HANDOUT_DATE DATE
)';
exception
	when others then
		if sqlcode = -955 then null; else raise; end if;
end;
/
prompt add handout_date
begin
    execute immediate 'alter table rec_bills add handout_date date';    
exception
    when others then
        if sqlcode = -1430 then null; else raise; end if;
end;
/

COMMENT ON TABLE BILLS.REC_BILLS IS 'Векселя, які було випущено ДКСУ під отримувача';
COMMENT ON COLUMN BILLS.REC_BILLS.REC_ID IS 'посилання на id отримувача коштів';
COMMENT ON COLUMN BILLS.REC_BILLS.BILL_NO IS 'Номер векселя';
COMMENT ON COLUMN BILLS.REC_BILLS.DT_ISSUE IS 'Дата випуску векселя';
COMMENT ON COLUMN BILLS.REC_BILLS.DT_PAYMENT IS 'Дата погашення векселя';
COMMENT ON COLUMN BILLS.REC_BILLS.AMOUNT IS 'Номінал векселя';
COMMENT ON COLUMN BILLS.REC_BILLS.STATUS IS 'Поточний статус векселя';
COMMENT ON COLUMN BILLS.REC_BILLS.LAST_DT IS 'Дата зміни поточного стану';
COMMENT ON COLUMN BILLS.REC_BILLS.LAST_USER IS 'Користувач, якив вносив останню зміну';
comment on column rec_bills.handout_date is 'Дата выдачи векселя на руки (банковская)';
Prompt Index XPK_REC_BILLS;
begin
	execute immediate '
CREATE UNIQUE INDEX BILLS.XPK_REC_BILLS ON BILLS.REC_BILLS
(REC_ID, BILL_NO)';
exception
	when others then
		if sqlcode = -955 then null; else raise; end if;
end;
/

Prompt CONSTRAINT PK_EXPECTED_RCV;
begin
	execute immediate '
ALTER TABLE BILLS.REC_BILLS ADD (CONSTRAINT XPK_REC_BILLS PRIMARY KEY (REC_ID, BILL_NO) USING INDEX BILLS.XPK_REC_BILLS ENABLE VALIDATE)';
exception
	when others then
		if sqlcode = -2260 then null; else raise; end if;
end;
/
prompt index I_REC_BILLS_HANDOUT_DATE
begin
    execute immediate 'create index I_REC_BILLS_HANDOUT_DATE on rec_bills (handout_date)';    
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/