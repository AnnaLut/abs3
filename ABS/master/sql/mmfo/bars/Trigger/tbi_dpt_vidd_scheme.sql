

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DPT_VIDD_SCHEME.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DPT_VIDD_SCHEME ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DPT_VIDD_SCHEME 
BEFORE INSERT ON DPT_VIDD_SCHEME
FOR EACH ROW
BEGIN
  IF ((:new.TYPE_ID Is Null) And (:new.VIDD is Not Null)) THEN
     select TYPE_ID
       into :new.TYPE_ID
       from DPT_VIDD
      where VIDD = :new.VIDD;
  END IF;
END;


/
ALTER TRIGGER BARS.TBI_DPT_VIDD_SCHEME ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DPT_VIDD_SCHEME.sql =========***
PROMPT ===================================================================================== 
