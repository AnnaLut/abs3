

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBU_CUSTOMER_SPD.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBU_CUSTOMER_SPD ***

  CREATE OR REPLACE TRIGGER BARS.TBU_CUSTOMER_SPD 
before update on customer
for each row
 WHEN ( old.country IN (11,900) and new.country IN (11,900) and old.k050 = '910' ) begin
  -- Заборонено змінювати реквізити ФО-СПД, зареєстрованого в АР Крим
  bars_error.raise_nerror('CAC', 'ERROR_CUSTOMER_SPD');
end;
/
ALTER TRIGGER BARS.TBU_CUSTOMER_SPD ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBU_CUSTOMER_SPD.sql =========*** En
PROMPT ===================================================================================== 
