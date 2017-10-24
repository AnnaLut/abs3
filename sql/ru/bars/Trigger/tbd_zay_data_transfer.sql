

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBD_ZAY_DATA_TRANSFER.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBD_ZAY_DATA_TRANSFER ***

  CREATE OR REPLACE TRIGGER BARS.TBD_ZAY_DATA_TRANSFER 
before delete on zay_data_transfer
for each row

declare
  l_id ZAYAVKA.ID%TYPE;
begin

begin
  insert into zay_data_transfer_log values
  (:old.id,
   :old.req_id,
   :old.url,
   :old.mfo,
   :old.transfer_type,
   :old.transfer_date,
   :old.transfer_result,
   :old.comm
  );
exception when others then
  bars_audit.error('zay_data_transfer error: ' ||  substr(sqlerrm, 1, 2000));
end;

end tbd_zay_data_transfer;
/
ALTER TRIGGER BARS.TBD_ZAY_DATA_TRANSFER ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBD_ZAY_DATA_TRANSFER.sql =========*
PROMPT ===================================================================================== 
