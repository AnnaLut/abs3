

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/FGA_DROP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure FGA_DROP ***

  CREATE OR REPLACE PROCEDURE BARS.FGA_DROP (p_object_name varchar2) is
    --
    -- удаление политики трассировки
    --
    l_object_name varchar2(30);
    l_policy_name varchar2(30);
begin
    l_object_name := upper(p_object_name);
    l_policy_name := substr('PLC_'||l_object_name,1,30);
    dbms_fga.drop_policy(
        object_schema   => 'BARS',
        object_name     => l_object_name,
        policy_name     => l_policy_name);
end fga_drop;
 
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/FGA_DROP.sql =========*** End *** 
PROMPT ===================================================================================== 
