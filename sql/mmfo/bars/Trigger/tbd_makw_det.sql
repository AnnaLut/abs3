

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBD_MAKW_DET.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBD_MAKW_DET ***

  CREATE OR REPLACE TRIGGER BARS.TBD_MAKW_DET 
  BEFORE DELETE
  ON "BARS"."MAKW_GRP"
 FOR EACH ROW
  BEGIN
 DELETE MAKW_DET
    WHERE GRP = :OLD.GRP;
END   ;


/
ALTER TRIGGER BARS.TBD_MAKW_DET ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBD_MAKW_DET.sql =========*** End **
PROMPT ===================================================================================== 
