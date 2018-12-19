

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/MaterializedViewLog/MLOG$_ASVO_IMMOBILE.sql =========*** Run *** ====
PROMPT ===================================================================================== 
begin
  execute immediate 'CREATE MATERIALIZED VIEW LOG ON asvo_immobile  WITH ROWID';
exception 
    when others then
        if sqlcode = -12000 then null; else raise; end if;
end;
/

