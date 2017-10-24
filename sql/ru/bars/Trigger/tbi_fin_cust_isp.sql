

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_FIN_CUST_ISP.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_FIN_CUST_ISP ***

  CREATE OR REPLACE TRIGGER BARS.TBI_FIN_CUST_ISP 
BEFORE INSERT ON BARS.FIN_CUST FOR EACH ROW
BEGIN
   :NEW.ISP     := nvl(:NEW.ISP     , gl.aUID);
   :NEW.CustType:= nvl(:NEW.CustType, 2      );
END;
/
ALTER TRIGGER BARS.TBI_FIN_CUST_ISP ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_FIN_CUST_ISP.sql =========*** En
PROMPT ===================================================================================== 
