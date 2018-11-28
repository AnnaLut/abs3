Prompt create table BILL_AUDIT_ACTION;
begin
	execute immediate '
CREATE TABLE BILLS.BILL_AUDIT_ACTION
(
  ACTION   VARCHAR2(30 BYTE) NOT NULL,
  DESCRIPT   VARCHAR2(250 BYTE),
  CONSTRAINT XPK_BILL_AUDIT_ACTION
  PRIMARY KEY
  (ACTION)
  ENABLE VALIDATE
)
ORGANIZATION INDEX';
exception
	when others then
		if sqlcode = -955 then null; else raise; end if;
end;
/
comment on table BILL_AUDIT_ACTION is 'Типы действий';
comment on column BILL_AUDIT_ACTION.ACTION is 'Действие';
comment on column BILL_AUDIT_ACTION.DESCRIPT is 'Описание';

grant select on bill_audit_action to bars_access_defrole;