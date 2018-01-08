PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Sequence/S_CP_REFW_UPDATE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  sequence S_CP_REFW_UPDATE ***

begin
  execute immediate 'create sequence S_CP_REFW_UPDATE
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20';
exception
  when others then
  if sqlcode=-955 then null; else raise; end if;
end;
/

grant SELECT   on S_CP_REFW_UPDATE to BARS_ACCESS_DEFROLE;
