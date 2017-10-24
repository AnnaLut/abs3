

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_CUST_RIZIK.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_CUST_RIZIK ***

  CREATE OR REPLACE TRIGGER BARS.TAI_CUST_RIZIK 
after insert on customer for each row
begin
  insert into customerw (rnk, tag, value, isp)
   values (:new.rnk, 'RIZIK', 'Низький', 0);
end;
/
ALTER TRIGGER BARS.TAI_CUST_RIZIK ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_CUST_RIZIK.sql =========*** End 
PROMPT ===================================================================================== 
