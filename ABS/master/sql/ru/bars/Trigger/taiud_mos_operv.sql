

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_MOS_OPERV.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_MOS_OPERV ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_MOS_OPERV 
  after insert or update or delete on mos_operw
  for each row
declare
  l_dog_id number;
begin

  if updating and gl.aUID is not null then
    bars_audit.info(bars_msg.get_msg('CIG', 'CIG_ATTR_UPD', to_char(:old.nd), :old.tag, :new.value));
  elsif inserting then
    bars_audit.info(bars_msg.get_msg('CIG', 'CIG_ATTR_INS', to_char(:new.nd), :new.tag, :new.value));
  elsif deleting then
    bars_audit.info(bars_msg.get_msg('CIG', 'CIG_ATTR_DEL', to_char(:old.nd), :old.tag));
  end if;

  if (:new.tag = 'CIG_D13' or :old.tag = 'CIG_D13') and (:new.value = '0') then

    select max(id) into l_dog_id from cig_dog_general where nd = :old.nd and contract_type not in (3,4);

    if (l_dog_id is not null) then

      delete from cig_sync_data sd where sd.data_type = 2
        and sd.data_id = l_dog_id;

      delete from cig_sync_data sd where sd.data_type = 3
        and sd.data_id in (select ci.id from cig_dog_instalment ci where ci.dog_id = l_dog_id);

      delete from cig_sync_data sd where sd.data_type = 4
        and sd.data_id in (select ci.id from cig_dog_credit ci where ci.dog_id = l_dog_id);

    end if;

  end if;
end taiud_mos_operv;
/
ALTER TRIGGER BARS.TAIUD_MOS_OPERV ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_MOS_OPERV.sql =========*** End
PROMPT ===================================================================================== 
