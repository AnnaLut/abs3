
PROMPT *** DROP TABLE PRVN_FIN_DEB_ERRLOG ***
begin
   execute immediate 'drop table bars.PRVN_FIN_DEB_ERRLOG cascade constraint purge';
exception when others then
   if sqlcode = -942 then null; else raise; end if;
end;
/
