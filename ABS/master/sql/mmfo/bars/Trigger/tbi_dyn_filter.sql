

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DYN_FILTER.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DYN_FILTER ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DYN_FILTER 
BEFORE INSERT  ON dyn_filter
FOR EACH ROW
DECLARE bars NUMBER;
BEGIN
   IF ( :new.filter_id = 0 or :new.filter_id is null ) THEN
       SELECT bars_sqnc.get_nextval('s_dyn_filter')
       INTO   bars FROM DUAL;
       :new.filter_id := bars;
    END IF;
END;





/
ALTER TRIGGER BARS.TBI_DYN_FILTER ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DYN_FILTER.sql =========*** End 
PROMPT ===================================================================================== 
