

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_CC989917REF_ACC.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_CC989917REF_ACC ***

  CREATE OR REPLACE TRIGGER BARS.TU_CC989917REF_ACC 
before insert or update of ref1 on CC_989917_REF for each row
begin
for k in
                (
                select acc, s from opldok where ref = :new.ref1 and dk = 0 and rownum = 1
                )
loop
begin
 :new.acc := k.acc;
 end;

 /*            -- кількість цінностей допреквізити
  begin
     insert into operw(ref, tag, value)   values(:new.ref1, 'SUMGD', k.s/100) ;
   exception when dup_val_on_index then null;
   end;

  */



end loop;

end;
/
ALTER TRIGGER BARS.TU_CC989917REF_ACC ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_CC989917REF_ACC.sql =========*** 
PROMPT ===================================================================================== 
