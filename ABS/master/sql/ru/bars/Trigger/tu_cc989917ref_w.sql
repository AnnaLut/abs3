

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_CC989917REF_W.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_CC989917REF_W ***

  CREATE OR REPLACE TRIGGER BARS.TU_CC989917REF_W 
before update of ref2 on CC_989917_REF for each row
 WHEN (
new.ref2 is not null --and old.ref2 is null
      ) begin

for c in ( select * from operw where ref = :old.ref1)
loop
   begin
     insert into operw(ref, tag, value)   values(:new.ref2, c.tag, c.value) ;
   exception when dup_val_on_index then null;
   end;
end loop;

end;
/
ALTER TRIGGER BARS.TU_CC989917REF_W ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_CC989917REF_W.sql =========*** En
PROMPT ===================================================================================== 
