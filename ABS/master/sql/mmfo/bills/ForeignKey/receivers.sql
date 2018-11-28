Prompt CONSTRAINT FK_RCV_RSL;
begin
	execute immediate '
ALTER TABLE BILLS.RECEIVERS ADD (CONSTRAINT FK_RCV_RSL FOREIGN KEY (RESOLUTION_ID) REFERENCES BILLS.RESOLUTIONS (RES_ID) ENABLE VALIDATE)';
exception
	when others then
		if sqlcode = -2275 then null; else raise; end if;
end;
/
begin
	execute immediate '
ALTER TABLE BILLS.RECEIVERS ADD (CONSTRAINT FK_RCV_TR_ST FOREIGN KEY (EXT_STATUS) REFERENCES BILLS.DICT_TREASURY_STATUS (STATUS_ID) ENABLE VALIDATE)';
exception
	when others then
		if sqlcode = -2275 then null; else raise; end if;
end;
/