

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_BPKNBSOB22.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_BPKNBSOB22 ***

  CREATE OR REPLACE TRIGGER BARS.TAI_BPKNBSOB22 
after insert on bpk_nbs_ob22
for each row
begin
  begin
     insert into bpk_nbs (nbs, ob22, custtype, tip)
     values (:new.nbs, :new.ob22, decode(:new.nbs,'2625',1,2), :new.tip);
  exception
     when dup_val_on_index then null;
     when others then if sqlcode = -2291 then null; else raise; end if;
  end;
  begin
    insert into obpc_tips (tip, ob22)
    values (:new.tip, :new.ob22);
  exception
     when dup_val_on_index then null;
     when others then if sqlcode = -2291 then null; else raise; end if;
  end;
end;
/
ALTER TRIGGER BARS.TAI_BPKNBSOB22 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_BPKNBSOB22.sql =========*** End 
PROMPT ===================================================================================== 
