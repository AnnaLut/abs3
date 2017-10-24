

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_META_COL_INTL_FILTERS.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_META_COL_INTL_FILTERS ***

  CREATE OR REPLACE TRIGGER BARS.TBI_META_COL_INTL_FILTERS 
before insert ON BARS.META_COL_INTL_FILTERS
for each row
begin
    if (:NEW.FILTER_ID is null) then
        select S_META_COL_INTL_FILTERS.NEXTVAL into :NEW.FILTER_ID from dual;
    end if;
end;
/
ALTER TRIGGER BARS.TBI_META_COL_INTL_FILTERS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_META_COL_INTL_FILTERS.sql ======
PROMPT ===================================================================================== 
