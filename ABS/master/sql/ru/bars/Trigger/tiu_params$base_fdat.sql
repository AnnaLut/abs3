

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_PARAMS$BASE_FDAT.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_PARAMS$BASE_FDAT ***

  CREATE OR REPLACE TRIGGER BARS.TIU_PARAMS$BASE_FDAT 
before insert or update of val on params$base
for each row  WHEN (new.par = 'BANKDATE') declare
    l_bdate   date;  
begin
    --
    -- вставка открываемой даты в fdat
    -- для мульти-мфо базы с полем 'KF'
    --
    l_bdate := to_date(:new.val, 'mm/dd/yyyy');
    begin
        insert into fdat (kf, fdat) values (:new.kf, l_bdate);
    exception when dup_val_on_index then
        null;
    end;
end tiu_params$base_fdat; 
/
ALTER TRIGGER BARS.TIU_PARAMS$BASE_FDAT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_PARAMS$BASE_FDAT.sql =========**
PROMPT ===================================================================================== 
