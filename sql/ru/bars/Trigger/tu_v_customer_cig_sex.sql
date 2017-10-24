

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_V_CUSTOMER_CIG_SEX.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_V_CUSTOMER_CIG_SEX ***

  CREATE OR REPLACE TRIGGER BARS.TU_V_CUSTOMER_CIG_SEX 
INSTEAD OF UPDATE
ON BARS.V_CUSTOMER_CIG_SEX
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE
BEGIN
   if :NEW.b_chg=1 then
      if :NEW.sex not in (1,2) or  :NEW.sex is null then
       RAISE_APPLICATION_ERROR(-20111,'\8999 Для клієнта RNK='||to_char(:NEW.RNK)||'  не вірно вказана стать - ' ||nvl(to_char(:NEW.SEX),'Пусто'));
      end if;
    update person set sex=:NEW.SEX where rnk=:NEW.RNK;
   end if;
END u_v_customer_cig_sex;
/
ALTER TRIGGER BARS.TU_V_CUSTOMER_CIG_SEX ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_V_CUSTOMER_CIG_SEX.sql =========*
PROMPT ===================================================================================== 
