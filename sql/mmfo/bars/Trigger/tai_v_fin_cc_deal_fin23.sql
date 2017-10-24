

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_V_FIN_CC_DEAL_FIN23.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_V_FIN_CC_DEAL_FIN23 ***

  CREATE OR REPLACE TRIGGER BARS.TAI_V_FIN_CC_DEAL_FIN23 
INSTEAD OF update  ON BARS.v_fin_cc_deal for each row
declare

begin
if nvl(:old.fin23,0) != :new.fin23 then
if :old.tip in ( 'CCK', 'GAR')  then
update cc_deal
set fin23 = :new.fin23
where nd = :old.nd ;

elsif :old.tip = 'ACC'  then
update ACC_FIN_OBS_KAT
set fin = :new.fin23
where acc = :old.nd;

elsif :old.tip = 'OVR'  then
update acc_over
set fin23 = :new.fin23
where nd = :old.nd;

elsif :old.tip = 'BPK'  then
update bpk_acc
set fin23 = :new.fin23
where nd = :old.nd;

elsif :old.tip = 'OW4'  then
update w4_acc
set fin23 = :new.fin23
where nd = :old.nd;

else null;
end if;
end if;

end;
/
ALTER TRIGGER BARS.TAI_V_FIN_CC_DEAL_FIN23 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_V_FIN_CC_DEAL_FIN23.sql ========
PROMPT ===================================================================================== 
