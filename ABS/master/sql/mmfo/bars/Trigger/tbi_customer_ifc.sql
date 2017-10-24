

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_CUSTOMER_IFC.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_CUSTOMER_IFC ***

  CREATE OR REPLACE TRIGGER BARS.TBI_CUSTOMER_IFC 
  BEFORE INSERT ON "BARS"."CUSTOMER_IFC"
  REFERENCING FOR EACH ROW
  DECLARE bars NUMBER;
BEGIN
   IF ( :new.ifc = 0 ) THEN
       SELECT s_customer_ifc.NEXTVAL
       INTO   bars FROM DUAL;
       :new.ifc := bars;
    END IF;
END;



/
ALTER TRIGGER BARS.TBI_CUSTOMER_IFC ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_CUSTOMER_IFC.sql =========*** En
PROMPT ===================================================================================== 
