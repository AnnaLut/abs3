
PROMPT *** DROP trigger TBIU_SPECPARAM ***

begin
	execute immediate q'[drop trigger bars.tbiu_specparam]';
exception
	when others then
		if sqlcode = -4080 then null; else raise; end if;
end;
/
