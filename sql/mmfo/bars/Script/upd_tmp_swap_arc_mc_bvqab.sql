PROMPT ==========================================================================================
PROMPT *** Run *** ========== Scripts /Sql/BARS/Script/upd_tmp_swap_arc_mc_bvqab.sql =========***
PROMPT ==========================================================================================

declare
  v_sql varchar2(4000);
begin
  v_sql := '
            update meta_columns mc
               set mc.semantic = replace(mc.semantic, ''валютування'', ''звіту'')
             where mc.tabid = 1011920
               and mc.colid in (25, 26)
               and mc.semantic <> replace(mc.semantic, ''валютування'', ''звіту'')';
  
  execute immediate v_sql;
  
  --dbms_output.put_line(sql%rowcount);
  commit;
end;
/

PROMPT ==========================================================================================
PROMPT *** Run *** ========== Scripts /Sql/BARS/Script/upd_tmp_swap_arc_mc_bvqab.sql =========***
PROMPT ==========================================================================================
