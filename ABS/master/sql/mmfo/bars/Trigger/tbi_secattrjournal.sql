

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_SECATTRJOURNAL.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_SECATTRJOURNAL ***

  CREATE OR REPLACE TRIGGER BARS.TBI_SECATTRJOURNAL 
before insert on sec_attr_journal
for each row
begin
  select s_secattrjournal.nextval into :new.rec_id from dual;
end;



/
ALTER TRIGGER BARS.TBI_SECATTRJOURNAL ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_SECATTRJOURNAL.sql =========*** 
PROMPT ===================================================================================== 
