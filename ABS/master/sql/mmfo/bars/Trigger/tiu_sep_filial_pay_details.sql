

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_SEP_FILIAL_PAY_DETAILS.sql =====
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_SEP_FILIAL_PAY_DETAILS ***

  CREATE OR REPLACE TRIGGER BARS.TIU_SEP_FILIAL_PAY_DETAILS 
  BEFORE INSERT OR UPDATE ON "BARS"."SEP_FILIAL_PAY_DETAILS"
  REFERENCING FOR EACH ROW
  begin
    select sort_code into :new.sort_code from v_banks_mod3 where mfo=:new.mfo;
end;



/
ALTER TRIGGER BARS.TIU_SEP_FILIAL_PAY_DETAILS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_SEP_FILIAL_PAY_DETAILS.sql =====
PROMPT ===================================================================================== 
