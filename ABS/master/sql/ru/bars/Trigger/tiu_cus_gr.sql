

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_CUS_GR.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_CUS_GR ***

  CREATE OR REPLACE TRIGGER BARS.TIU_CUS_GR 
after insert ON BARS.CUSTOMER for each row
declare
  gr_  varchar2(70);
begin
  select name into gr_ from country where country=:new.country;
  begin
    insert into customerw (rnk, tag, value, isp)
    values (:new.rnk, 'GR', gr_, 0);
  exception
    when OTHERS then
      if (sqlcode = -02291)
      then
        insert into customerw (rnk, tag, value, isp)
        values (:new.rnk, 'GR   ', gr_, 0);
      else
        raise;
      end if;
  end;
end;
/
ALTER TRIGGER BARS.TIU_CUS_GR ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_CUS_GR.sql =========*** End *** 
PROMPT ===================================================================================== 
