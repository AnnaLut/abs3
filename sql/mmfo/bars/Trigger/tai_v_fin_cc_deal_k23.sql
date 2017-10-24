

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_V_FIN_CC_DEAL_K23.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_V_FIN_CC_DEAL_K23 ***

  CREATE OR REPLACE TRIGGER BARS.TAI_V_FIN_CC_DEAL_K23 
INSTEAD OF update ON BARS.v_fin_cc_deal for each row  follows tai_v_fin_cc_deal_fin23
declare

begin
if nvl(:old.kat23,0) != :new.kat23 or nvl(:old.k23,0) != :new.k23 then
if :old.tip in ('CCK', 'GAR')  then
update cc_deal
set kat23 = :new.kat23, k23 = :new.k23
where nd = :old.nd ;

elsif :old.tip = 'ACC'  then
update ACC_FIN_OBS_KAT
set kat =:new.kat23, k = :new.k23
where acc = :old.nd;

elsif :old.tip = 'OVR'  then
update acc_over
set kat23 =:new.kat23, k23 = :new.k23
where nd = :old.nd;

elsif :old.tip = 'BPK'  then
update bpk_acc
set kat23 =:new.kat23, k23 = :new.k23
where nd = :old.nd;

elsif :old.tip = 'OW4'  then
update w4_acc
set kat23 =:new.kat23, k23 = :new.k23
where nd = :old.nd;

else null;
end if;
end if;


end;
/
ALTER TRIGGER BARS.TAI_V_FIN_CC_DEAL_K23 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_V_FIN_CC_DEAL_K23.sql =========*
PROMPT ===================================================================================== 
