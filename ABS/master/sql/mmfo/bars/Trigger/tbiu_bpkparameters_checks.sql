

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_BPKPARAMETERS_CHECKS.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_BPKPARAMETERS_CHECKS ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_BPKPARAMETERS_CHECKS 
before insert or update on BARS.BPK_PARAMETERS
for each row
   WHEN ( new.tag in ('VNCRR','VNCRP') ) begin

  if regexp_like(:new.VALUE,'^[�]{1,3}|[�]{1,3}|[�]{1,3}|[�]{1,3}$')
  then
    null;
  else
    raise_application_error(-20666,'�� ��������� �������� "'||nvl(:new.VALUE,'null')||'" ��� ��������� ���!',true);
  End If;

end TBIU_BPKPARAMETERS_CHECKS;


/
ALTER TRIGGER BARS.TBIU_BPKPARAMETERS_CHECKS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_BPKPARAMETERS_CHECKS.sql ======
PROMPT ===================================================================================== 
