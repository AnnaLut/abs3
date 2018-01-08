

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIUD_ACCOVER_MIGR.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIUD_ACCOVER_MIGR ***

  CREATE OR REPLACE TRIGGER BARS.TBIUD_ACCOVER_MIGR 
                          BEFORE DELETE OR INSERT OR UPDATE ON ACC_OVER 
                          REFERENCING NEW AS New OLD AS Old
                          FOR EACH ROW
        BEGIN  raise_application_error(-20203, ' Заборонено модифікувати табл ACC_OVER, Її мігровао в нові OVRN' );
        END TBIUD_ACCOVER_MIGR;
/
ALTER TRIGGER BARS.TBIUD_ACCOVER_MIGR DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIUD_ACCOVER_MIGR.sql =========*** 
PROMPT ===================================================================================== 
