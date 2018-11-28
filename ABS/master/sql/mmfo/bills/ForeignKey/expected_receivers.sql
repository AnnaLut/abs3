Prompt CONSTRAINT FK_EXP_RCV_RSL;
begin
	execute immediate '
ALTER TABLE BILLS.EXPECTED_RECEIVERS ADD (CONSTRAINT FK_EXP_RCV_RSL FOREIGN KEY (RESOLUTION_ID) REFERENCES BILLS.RESOLUTIONS (RES_ID) ENABLE VALIDATE)';
exception
	when others then
		if sqlcode = -2275 then null; else raise; end if;
end;
/