

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_VBPKDOCPARAMS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_VBPKDOCPARAMS ***

  CREATE OR REPLACE TRIGGER BARS.TU_VBPKDOCPARAMS 
instead of update on v_bpk_docparams for each row
declare
procedure chg_val (p_branch varchar2, p_tag varchar2, p_val varchar2)
is
begin
  if p_val is null then
     delete from branch_parameters
      where branch = p_branch and tag = p_tag;
  else
     begin
        insert into branch_parameters (branch, tag, val)
        values (p_branch, p_tag, p_val);
     exception when dup_val_on_index then null;
        update branch_parameters
           set val = p_val
         where branch = p_branch
           and tag = p_tag;
     end;
  end if;
end;
begin
  chg_val(:old.branch, 'BPK_BOSS_FIO', :new.fio);
  chg_val(:old.branch, 'BPK_BOSS_FIOR', :new.fior);
  chg_val(:old.branch, 'BPK_DOVER', :new.dover);
  chg_val(:old.branch, 'BPK_POSADA', :new.posada);
  chg_val(:old.branch, 'BPK_POSADAR', :new.posadar);
  chg_val(:old.branch, 'BPK_PHONE', :new.phone);
end;
/
ALTER TRIGGER BARS.TU_VBPKDOCPARAMS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_VBPKDOCPARAMS.sql =========*** En
PROMPT ===================================================================================== 
