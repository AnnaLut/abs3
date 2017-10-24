

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_OPER_SOS_C14.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_OPER_SOS_C14 ***

  CREATE OR REPLACE TRIGGER BARS.TU_OPER_SOS_C14 
  BEFORE UPDATE OF SOS ON "BARS"."OPER"
  REFERENCING FOR EACH ROW
    WHEN (
old.sos>0 and new.sos<0 and old.tt ='C14' and new.nlsa='2906401201'
      ) declare
begin
    execute immediate 'begin ussr_payoff.deassign_c14_from_ssr@depdb(:p_ref_ssr, :p_ref_c14); end;'
    using to_number(:new.nd), :new.ref;
end tu_oper_sos_c14;


/
ALTER TRIGGER BARS.TU_OPER_SOS_C14 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_OPER_SOS_C14.sql =========*** End
PROMPT ===================================================================================== 
