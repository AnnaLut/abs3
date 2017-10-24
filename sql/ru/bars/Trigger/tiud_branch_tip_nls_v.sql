

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIUD_BRANCH_TIP_NLS_V.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIUD_BRANCH_TIP_NLS_V ***

  CREATE OR REPLACE TRIGGER BARS.TIUD_BRANCH_TIP_NLS_V 
INSTEAD OF INSERT OR UPDATE OR DELETE  ON BARS.BRANCH_TIP_NLS_V  FOR EACH ROW
BEGIN

if deleting     then
   delete from BRANCH_TIP_NLS
          where tip=:old.tip and nbs=:old.nbs and ob22=:old.ob22;
elsif inserting then
   insert into BRANCH_TIP_NLS(tip,     nbs,     ob22,     mask)
                 values (:new.tip,:new.nbs,:new.ob22,:new.mask);
elsIf updating  then
   update BRANCH_TIP_NLS
      set mask = :new.mask
    where tip  = :old.tip
     and  nbs  = :old.nbs
     and  ob22 = :old.ob22;
end if;

END TIUD_BRANCH_TIP_NLS_V;
/
ALTER TRIGGER BARS.TIUD_BRANCH_TIP_NLS_V ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIUD_BRANCH_TIP_NLS_V.sql =========*
PROMPT ===================================================================================== 
