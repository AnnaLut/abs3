

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/KL_SMS_ON_OFF.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure KL_SMS_ON_OFF ***

  CREATE OR REPLACE PROCEDURE BARS.KL_SMS_ON_OFF (p_value int)
is
 procedure kl_sms_log(p_new_value int)
 is
 pragma autonomous_transaction;
 begin
   insert into SMS_CONFIRM_AUDIT (DATESTAMP, USER_ID, NEW_VALUE)
   values (sysdate, user_id, p_new_value);

   commit;
 end;

begin
 update cac_params
    set value = p_value
  where name='CELLPHONE_CONFIRMATION';

  kl_sms_log(p_value);
end;
/
show err;

PROMPT *** Create  grants  KL_SMS_ON_OFF ***
grant EXECUTE                                                                on KL_SMS_ON_OFF   to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/KL_SMS_ON_OFF.sql =========*** End
PROMPT ===================================================================================== 
