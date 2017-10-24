

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_CUSTOMERW.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_CUSTOMERW ***

  CREATE OR REPLACE TRIGGER BARS.TIU_CUSTOMERW 
  AFTER INSERT OR UPDATE OF VALUE ON "BARS"."CUSTOMERW"
  REFERENCING FOR EACH ROW
    WHEN (
new.tag in ('WORK')
      ) declare
  work_         VARCHAR2(30);
  office_       VARCHAR2(25);
BEGIN

  work_   := trim(substr(substr(:new.value,1,instr(:new.value,',')-1),1,30));
  office_ := trim(substr(substr(:new.value,instr(:new.value,',')+1,100),1,25));

  FOR i IN (select acc from accounts where rnk=:new.rnk and dazs is null)
  LOOP
     begin
        insert into accountsw (acc, tag, value)
        values (i.acc, 'PK_WORK', work_);
     exception when dup_val_on_index then
        update accountsw set value = work_
        where acc = i.acc and tag = 'PK_WORK';
     end;

     begin
        insert into accountsw (acc, tag, value)
        values (i.acc, 'PK_OFFIC', office_);
     exception when dup_val_on_index then
        update accountsw set value = office_
        where acc = i.acc and tag = 'PK_OFFIC';
     end;
  END LOOP;

END TIU_CUSTOMERW;
/
ALTER TRIGGER BARS.TIU_CUSTOMERW ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_CUSTOMERW.sql =========*** End *
PROMPT ===================================================================================== 
