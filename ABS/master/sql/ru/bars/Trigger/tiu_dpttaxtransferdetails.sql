

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_DPTTAXTRANSFERDETAILS.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_DPTTAXTRANSFERDETAILS ***

  CREATE OR REPLACE TRIGGER BARS.TIU_DPTTAXTRANSFERDETAILS 
before  insert or update of NLS_TAX on DPT_TAX_TRANSFER_DETAILS
for each row
declare
  l_acc  accounts.acc%type;
begin

  begin
    select acc
     into l_acc
     from accounts
    where nls  = :new.nls_tax
      and kv   = 980
      and nbs  = '3622'
      and ob22 = '23'
      and dazs is null;
      --and a.branch = like SubStr(:new.branch,1,15)||'%';
  exception
    when no_data_found then
      BARS_ERROR.raise_nerror('DPT', 'ACC_NOT_FOUND_2', :new.nls_tax, '980 (3622/23)');
  end;
end;
/
ALTER TRIGGER BARS.TIU_DPTTAXTRANSFERDETAILS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_DPTTAXTRANSFERDETAILS.sql ======
PROMPT ===================================================================================== 
