

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/DROP_TABLE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure DROP_TABLE ***

  CREATE OR REPLACE PROCEDURE BARS.DROP_TABLE 
  (p_table varchar2) is
begin
  begin
    execute immediate 'drop table '||p_table;
  exception when others then
    if sqlcode=-942 then
      null;
    end if;
  end;
end drop_table;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/DROP_TABLE.sql =========*** End **
PROMPT ===================================================================================== 
