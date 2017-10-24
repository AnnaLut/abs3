

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TUID_TMP_RNK2RNK_LIST_CUSTOMER.sql =
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TUID_TMP_RNK2RNK_LIST_CUSTOMER ***

  CREATE OR REPLACE TRIGGER BARS.TUID_TMP_RNK2RNK_LIST_CUSTOMER 
BEFORE  INSERT OR UPDATE
ON BARS.TMP_RNK2RNK_LIST_CUSTOMER
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE
tmpVar NUMBER;
BEGIN
   tmpVar := 0;
-- rnk2rnk

:NEW.USERID:=USER_ID;
if updating then
 if nvl(:NEW.RNKFROM,-1)!=nvl(:OLD.RNKFROM,-1) or nvl(:NEW.RNKTO,-1)!=nvl(:OLD.RNKTO,-1) then
    :NEW.ERR:=null;
 end if;
end if;


   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END TUID_tmp_rnk2rnk_list_customer;
/
ALTER TRIGGER BARS.TUID_TMP_RNK2RNK_LIST_CUSTOMER ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TUID_TMP_RNK2RNK_LIST_CUSTOMER.sql =
PROMPT ===================================================================================== 
