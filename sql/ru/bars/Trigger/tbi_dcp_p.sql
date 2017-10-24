

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_DCP_P.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_DCP_P ***

  CREATE OR REPLACE TRIGGER BARS.TBI_DCP_P 
before insert on dcp_p for each row
begin
  if :new.id is null then
     select s_dcp_p.nextval into :new.id from dual;
  end if;
end;
/
ALTER TRIGGER BARS.TBI_DCP_P ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_DCP_P.sql =========*** End *** =
PROMPT ===================================================================================== 
