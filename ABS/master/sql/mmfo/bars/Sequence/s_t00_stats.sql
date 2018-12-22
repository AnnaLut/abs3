PROMPT ===================================================================================== 
PROMPT *** Run *** ======= Scripts /Sql/BARS/Sequence/s_t00_stats.sql 
PROMPT ===================================================================================== 
begin
execute immediate
'create sequence s_t00_stats
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20';
 exception
    when others then null;
end;
/
