

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_CONTRACTS_LICENCE.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_CONTRACTS_LICENCE ***

  CREATE OR REPLACE TRIGGER BARS.TBI_CONTRACTS_LICENCE 
BEFORE INSERT ON contracts_licence
FOR EACH ROW
DECLARE
  id_ NUMBER;
BEGIN
  IF :new.id IS NULL OR :new.id = 0 THEN
     SELECT s_contracts_licence.nextval INTO id_ FROM dual;
     :new.id := id_;
  END IF;
END;




/
ALTER TRIGGER BARS.TBI_CONTRACTS_LICENCE ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_CONTRACTS_LICENCE.sql =========*
PROMPT ===================================================================================== 
