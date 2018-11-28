Prompt CONSTRAINT FK_DOC_TYPE;
begin
	execute immediate '
ALTER TABLE BILLS.DOCUMENTS ADD (CONSTRAINT FK_DOC_TYPE FOREIGN KEY (DOC_TYPE) REFERENCES BILLS.DICT_DOC_TYPES (ID) ENABLE VALIDATE)';
exception
	when others then
		if sqlcode = -2275 then null; else raise; end if;
end;
/