

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/FGA_ADD.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure FGA_ADD ***

  CREATE OR REPLACE PROCEDURE BARS.FGA_ADD (p_object_name varchar2) is
    --
    -- добавление политики трассировки
    --
    l_object_name varchar2(30);
    l_policy_name varchar2(30);
begin
    l_object_name := upper(p_object_name);
    l_policy_name := substr('PLC_'||l_object_name,1,30);
    dbms_fga.add_policy(
        object_schema   => 'BARS',
        object_name     => l_object_name,
        policy_name     => l_policy_name,
        handler_schema  => 'BARS',
        handler_module  => 'FGA_TRACER',
        enable          => TRUE
    );
end fga_add;
 
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/FGA_ADD.sql =========*** End *** =
PROMPT ===================================================================================== 
