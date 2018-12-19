

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/MaterializedViewLog/MLOG$_ASVO_IMMOBILE.sql =========*** Run *** ====
PROMPT ===================================================================================== 
begin
  execute immediate 'create materialized view log on ASVO_IMMOBILE with rowid, primary key';
exception 
    when others then
        if sqlcode = -12000 then null; else raise; end if;
end;
/

