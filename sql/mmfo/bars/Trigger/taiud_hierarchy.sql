

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_HIERARCHY.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_HIERARCHY ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_HIERARCHY 
AFTER DELETE OR INSERT OR UPDATE
OF HIERARCHY_ID
ON BARS.CP_KOD
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW

BEGIN
 if :new.hierarchy_id != :old.hierarchy_id and :new.id is not null
 then
     begin
      insert into cp_hierarchy_hist (cp_id, fdat, hierarchy_id)
      values (:old.id, bankdate, :new.hierarchy_id);
     exception when dup_val_on_index then
      update cp_hierarchy_hist
         set hierarchy_id = :new.hierarchy_id
       where fdat = bankdate
         and cp_id = :new.id;
     end;
 end if;

END TAIUD_HIERARCHY;


/
ALTER TRIGGER BARS.TAIUD_HIERARCHY ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_HIERARCHY.sql =========*** End
PROMPT ===================================================================================== 
