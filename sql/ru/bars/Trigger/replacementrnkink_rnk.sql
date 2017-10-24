

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/REPLACEMENTRNKINK_RNK.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger REPLACEMENTRNKINK_RNK ***

  CREATE OR REPLACE TRIGGER BARS.REPLACEMENTRNKINK_RNK 
INSTEAD OF UPDATE ON BARS.REPLACEMENT_RNK_INK FOR EACH ROW
DECLARE
  cust customer%rowtype;
BEGIN

begin
select *
into cust
from customer
where rnk = :new.rnk
  and date_off is null;
  exception when NO_DATA_FOUND THEN
      raise_application_error(-(20001),'\ ' ||'  Кліента РНК №'||:new.rnk||' незнайдено, або закрито',TRUE);
end;




if :new.rnk is not null and :new.rnk != :old.rnk then
   UPDATE accounts
      SET rnk=:NEW.rnk
    WHERE acc=:OLD.acc and dazs is null;
end if;
null;
END;
/
ALTER TRIGGER BARS.REPLACEMENTRNKINK_RNK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/REPLACEMENTRNKINK_RNK.sql =========*
PROMPT ===================================================================================== 
