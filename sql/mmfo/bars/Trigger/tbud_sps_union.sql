

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBUD_SPS_UNION.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBUD_SPS_UNION ***

  CREATE OR REPLACE TRIGGER BARS.TBUD_SPS_UNION 
BEFORE UPDATE OR DELETE ON BARS.SPS_UNION
FOR EACH ROW
DECLARE
  e_cannot_change exception;
BEGIN
  if deleting and :old.union_id in (1, 2) then
    raise e_cannot_change;
  elsif updating and :old.union_id in (1, 2) and (:old.union_id <> :new.union_id or :new.sps is not null) then
    raise e_cannot_change;
  end if;
exception
  when e_cannot_change then
    raise_application_error(-20010, 'Не можна змінювати/видаляти 1 та 2 групи.');
END;

/
ALTER TRIGGER BARS.TBUD_SPS_UNION ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBUD_SPS_UNION.sql =========*** End 
PROMPT ===================================================================================== 
