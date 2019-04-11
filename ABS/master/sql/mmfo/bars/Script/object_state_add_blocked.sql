PROMPT =================================================================================
PROMPT *** Run *** = Scripts /Sql/Bars/Script/object_state_add_blocked.sql = *** Run ***
PROMPT =================================================================================

declare
   l_id integer;
begin
   l_id := object_utl.cor_object_state(
                                         p_object_type_code => 'CUSTOMER_FUNDS'
                                         , p_state_code     => 'BLOCKED'
                                         , p_state_name     => 'Заблоковано'
                                         , p_is_active      => 'Y'
                                      );
   commit;
end;
/

PROMPT =================================================================================
PROMPT *** End *** = Scripts /Sql/Bars/Script/object_state_add_blocked.sql = *** End ***
PROMPT =================================================================================