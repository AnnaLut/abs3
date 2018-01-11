

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Trigger/TBI_PERSON_BANK_BRANCH.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_PERSON_BANK_BRANCH ***

  CREATE OR REPLACE TRIGGER FINMON.TBI_PERSON_BANK_BRANCH 
BEFORE INSERT
ON FINMON.PERSON_BANK
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
begin
    :new.BRANCH_ID := get_branch_id;
end;
/
ALTER TRIGGER FINMON.TBI_PERSON_BANK_BRANCH ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Trigger/TBI_PERSON_BANK_BRANCH.sql =======
PROMPT ===================================================================================== 
