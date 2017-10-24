

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_CUST_NAL.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_CUST_NAL ***

  CREATE OR REPLACE TRIGGER BARS.TBI_CUST_NAL 
before insert on cust_nal for each row
declare bars number;
begin
   if ( :new.nal_id = 0 or :new.nal_id is null ) then
       select s_cust_nal.nextval into bars from dual;
       :new.nal_id := bars;
   end if;
end;



/
ALTER TRIGGER BARS.TBI_CUST_NAL ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_CUST_NAL.sql =========*** End **
PROMPT ===================================================================================== 
