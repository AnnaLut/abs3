Prompt create table EXPECTED_RECEIVERS;

begin
	execute immediate '
CREATE TABLE BILLS.EXPECTED_RECEIVERS
(
  EXP_ID           INTEGER                 NOT NULL,
  RESOLUTION_ID    NUMBER,
  RECEIVER_NAME    VARCHAR2(60)            NOT NULL,
  RECEIVER_CODE    VARCHAR2(10),
  RECEIVER_DOC_NO  VARCHAR2(30),
  CURRENCY_ID      VARCHAR2(3),
  AMOUNT           NUMBER,
  STATE            VARCHAR2(2)
)';
exception
	when others then
		if sqlcode = -955 then null; else raise; end if;
end;
/

Prompt Index PK_EXPECTED_RCV;
begin
	execute immediate '
CREATE UNIQUE INDEX BILLS.PK_EXPECTED_RCV ON BILLS.EXPECTED_RECEIVERS
(EXP_ID)';
exception
	when others then
		if sqlcode = -955 then null; else raise; end if;
end;
/

Prompt Index I_RES_ID_EXPECTED_RCV;
begin
	execute immediate '
CREATE INDEX BILLS.I_RES_ID_EXPECTED_RCV ON BILLS.EXPECTED_RECEIVERS
(RESOLUTION_ID)';
exception
	when others then
		if sqlcode = -955 then null; else raise; end if;
end;
/

Prompt CONSTRAINT PK_EXPECTED_RCV;
begin
	execute immediate '
ALTER TABLE BILLS.EXPECTED_RECEIVERS ADD (CONSTRAINT PK_EXPECTED_RCV PRIMARY KEY (EXP_ID) USING INDEX BILLS.PK_EXPECTED_RCV ENABLE VALIDATE)';
exception
	when others then
		if sqlcode = -2260 then null; else raise; end if;
end;
/