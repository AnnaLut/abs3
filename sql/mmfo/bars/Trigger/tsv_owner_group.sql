

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TSV_OWNER_GROUP.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TSV_OWNER_GROUP ***

  CREATE OR REPLACE TRIGGER BARS.TSV_OWNER_GROUP 
before insert on sv_owner_group
for each row

begin
    :new.id := s_svownergroup.nextval;
end;


/
ALTER TRIGGER BARS.TSV_OWNER_GROUP ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TSV_OWNER_GROUP.sql =========*** End
PROMPT ===================================================================================== 
