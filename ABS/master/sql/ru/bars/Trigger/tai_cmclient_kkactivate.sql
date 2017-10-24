

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_CMCLIENT_KKACTIVATE.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_CMCLIENT_KKACTIVATE ***

  CREATE OR REPLACE TRIGGER BARS.TAI_CMCLIENT_KKACTIVATE 
  after insert on cm_client_que
  for each row
declare
  -- local variables here
  l_cnt number;
begin
  if :new.oper_type = 3 then
    select count(*)
      into l_cnt
      from kkforbk_data t
     where t.nls = :new.contractnumber and t.rnk = :new.rnk;
    if l_cnt > 0 then
      update accounts
         set daos = decode(dapp, null, bankdate, daos),
             dazs = null,
             nbs = '2625'
       where acc = :new.acc;
    end if;

  end if;
end tai_cmclient_kkactivate;
/
ALTER TRIGGER BARS.TAI_CMCLIENT_KKACTIVATE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_CMCLIENT_KKACTIVATE.sql ========
PROMPT ===================================================================================== 
