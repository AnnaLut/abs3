

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/IKFDBLINK.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure IKFDBLINK ***

  CREATE OR REPLACE PROCEDURE BARS.IKFDBLINK (p_schema varchar2,  p_dblink varchar2)
is
begin
    -- устанавливаем g_schema, g_dblink
    mgr_utl.set_dblink(p_schema, p_dblink);
end ikfdblink;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/IKFDBLINK.sql =========*** End ***
PROMPT ===================================================================================== 
