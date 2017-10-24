

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBD_CMACCREQUEST.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBD_CMACCREQUEST ***

  CREATE OR REPLACE TRIGGER BARS.TBD_CMACCREQUEST 
before delete on cm_acc_request
for each row
begin
  insert into cm_acc_request_arc (oper_type, date_in, contract_number,
     product_code, card_type, okpo, okpo_n, card_expire,
     oper_date, abs_status, abs_msg, doneby)
  values (:old.oper_type, :old.date_in, :old.contract_number,
     :old.product_code, :old.card_type, :old.okpo, :old.okpo_n, :old.card_expire,
     :old.oper_date, nvl(:old.abs_status,3), :old.abs_msg, user);
end;


/
ALTER TRIGGER BARS.TBD_CMACCREQUEST ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBD_CMACCREQUEST.sql =========*** En
PROMPT ===================================================================================== 
