Prompt Sequence S_DOCUMENTS;

begin
	execute immediate '
CREATE SEQUENCE BILLS.S_DOCUMENTS
  START WITH 1
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER';
exception
	when others then
		if sqlcode = -955 then null; else raise; end if;
end;
/