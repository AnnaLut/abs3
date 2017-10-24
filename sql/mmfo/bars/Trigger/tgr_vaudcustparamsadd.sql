

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TGR_VAUDCUSTPARAMSADD.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TGR_VAUDCUSTPARAMSADD ***

  CREATE OR REPLACE TRIGGER BARS.TGR_VAUDCUSTPARAMSADD 
        INSTEAD OF UPDATE  ON BARS.V_AUD_CUST_PARAMS_ADD REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
begin
  update customerw  set value=:new.UUCG
  where rnk=:old.rnk and tag='UUCG';

  if SQL%rowcount = 0 then
     insert into customerw (rnk,   tag,     value, isp )
     values           (:old.rnk, 'UUCG', :new.UUCG, 0 );
  end if;


  update customerw  set value= :new.UUDV
  where rnk=:old.rnk and tag='UUDV';

  if SQL%rowcount = 0 then
     insert into customerw (rnk,   tag,     value, isp )
     values           (:old.rnk, 'UUDV',:new.UUDV,  0 );
  end if;


END TGR_VAUDCUSTPARAMSADD;



/
ALTER TRIGGER BARS.TGR_VAUDCUSTPARAMSADD ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TGR_VAUDCUSTPARAMSADD.sql =========*
PROMPT ===================================================================================== 
