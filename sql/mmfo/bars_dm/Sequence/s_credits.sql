PROMPT Create  sequence S_CREDITS

begin
	execute immediate q'[CREATE SEQUENCE  BARS_DM.S_CREDITS  MINVALUE 1 MAXVALUE 999999999999 INCREMENT BY 1 START WITH 28811301 CACHE 100000 NOORDER NOCYCLE]';
exception
	when others then
		if sqlcode = -955 then null; else raise; end if;
end;
/
prompt set cache 100000
alter sequence bars_dm.s_credits cache 100000;
