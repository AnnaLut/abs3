Prompt CONSTRAINT FK_CA_RCV_EXTR;
begin
	execute immediate '
ALTER TABLE BILLS.CA_RECEIVERS ADD (CONSTRAINT FK_CA_RCV_EXTR FOREIGN KEY (EXTRACT_NUMBER_ID) REFERENCES BILLS.EXTRACTS (EXTRACT_NUMBER_ID) ENABLE VALIDATE)';
exception
	when others then
		if sqlcode = -2275 then null; else raise; end if;
end;
/
begin
	execute immediate '
ALTER TABLE BILLS.CA_RECEIVERS ADD (CONSTRAINT FK_CA_RCV_TR_ST FOREIGN KEY (EXT_STATUS) REFERENCES BILLS.DICT_TREASURY_STATUS (STATUS_ID) ENABLE VALIDATE)';
exception
	when others then
		if sqlcode = -2275 then null; else raise; end if;
end;
/