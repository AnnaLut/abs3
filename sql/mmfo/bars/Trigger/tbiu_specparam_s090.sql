

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_SPECPARAM_S090.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_SPECPARAM_S090 ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_SPECPARAM_S090 
  BEFORE INSERT OR UPDATE ON specparam
  FOR EACH ROW
declare
  V_ int; T_ int;
BEGIN
  If :NEW.S090 is not null OR :NEW.S080 is null then RETURN; end if;
  ---------------------------------------------
  select a.kv,c.custtype into V_,T_
  from accounts a, customer c where a.acc=:NEW.acc and a.rnk=c.rnk;
  If    T_=1 and v_= 980                         then /* аЮ Ц */ :NEW.S090:='1';
  ElsIf T_=1 and v_<>980                         then /* аЮ Б */ :NEW.S090:='5';
  ElsIf T_=3 and v_= 980                         then /* тк Ц */ :NEW.S090:='1';
  ElsIf T_=3 and v_<>980                         then /* тк Б */ :NEW.S090:='3';
  ElsIf T_=2 and v_= 980                         then /* чк Ц */ :NEW.S090:='1';
  ElsIf T_=2 and v_<>980 and :NEW.ISTVAL is NULL then /* чк-Б */ :NEW.S090:='3';
  ElsIf T_=2 and v_<>980                         then /* чк+Б */ :NEW.S090:='2';
  end if;
  RETURN;
END TBIU_specparam_s090; 




/
ALTER TRIGGER BARS.TBIU_SPECPARAM_S090 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_SPECPARAM_S090.sql =========***
PROMPT ===================================================================================== 
