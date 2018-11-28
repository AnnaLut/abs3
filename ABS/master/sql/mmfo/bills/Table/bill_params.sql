Prompt create table BILL_PARAMS;
begin
	execute immediate '
CREATE TABLE BILLS.BILL_PARAMS
(
  PAR   VARCHAR2(30 BYTE) NOT NULL,
  VAL   VARCHAR2(250 BYTE),
  COMM  VARCHAR2(250 BYTE), 
  CONSTRAINT XPK_BILL_PARAMS
  PRIMARY KEY
  (PAR)
  ENABLE VALIDATE
)
ORGANIZATION INDEX';
exception
	when others then
		if sqlcode = -955 then null; else raise; end if;
end;
/
comment on table bill_params is 'Параметры';
comment on column bill_params.par is 'Код параметра';
comment on column bill_params.val is 'Значение параметра';
comment on column bill_params.comm is 'Семантика / описание';