

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/DISABLE_SIGNATURE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure DISABLE_SIGNATURE ***

  CREATE OR REPLACE PROCEDURE BARS.DISABLE_SIGNATURE (p_flag in boolean)
as 
begin
  bc.go('/');
  if (p_flag) then
    update tts set flags = substr(flags, 1, 1) || '0' || substr(flags, 3) where substr(flags, 2, 1) > 0; 
    update chklist set f_in_charge=0 where f_in_charge > 0;
    update chklist_tts set f_in_charge=0 where f_in_charge > 0;
  else 
    update tts t set t.flags = (select flags from tmp_backup_tts tbt where t.tt=tbt.tt) where exists (select flags from tmp_backup_tts tbt where t.tt=tbt.tt);
    update chklist t set t.f_in_charge = (select f_in_charge from tmp_backup_chklist tbt where t.idchk=tbt.idchk) where exists (select f_in_charge from tmp_backup_chklist tbt where t.idchk=tbt.idchk); 
    update chklist_tts t set t.f_in_charge = (select f_in_charge from tmp_backup_chklist_tts tbt where t.idchk=tbt.idchk and t.tt=tbt.tt) where exists (select f_in_charge from tmp_backup_chklist_tts tbt where t.idchk=tbt.idchk and t.tt=tbt.tt);
  end if;
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/DISABLE_SIGNATURE.sql =========***
PROMPT ===================================================================================== 
