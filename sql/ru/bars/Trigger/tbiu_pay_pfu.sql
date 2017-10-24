

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_PAY_PFU.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_PAY_PFU ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_PAY_PFU 
before insert ON BARS.PAY_PFU
FOR EACH ROW
begin

  select S_PAY_PFU.nextval
    into :new.ID
    from dual;

  :NEW.ISP := USER_ID;

  :NEW.DATD := GL.BDATE;

end TBIU_PAY_PFU;
/
ALTER TRIGGER BARS.TBIU_PAY_PFU ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_PAY_PFU.sql =========*** End **
PROMPT ===================================================================================== 
