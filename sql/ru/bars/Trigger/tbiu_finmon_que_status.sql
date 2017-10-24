

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBIU_FINMON_QUE_STATUS.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_FINMON_QUE_STATUS ***

  CREATE OR REPLACE TRIGGER BARS.TBIU_FINMON_QUE_STATUS 
  before insert or update of status on finmon_que
  for each row
--  статус 'N' (к отправке) меняем на 'T' для террористов
declare
  l_otm number;
begin
  -- Дата поступления/получения сообщения об операции должна отражаться дата,
  --когда сотрудник банка сообщил об финансовой операции, тоисть операция
  --стала в статусе "повідомлена"
  if :new.status = 'I' then
    :new.dat_i := sysdate;
  end if;
  if :new.status = 'N' then
    if :new.ref is null and :new.rec is not null then
      :new.status := 'T';
    elsif :new.ref is not null then
      begin
        select otm into l_otm from fm_ref_que where ref=:new.ref and otm>0;
        :new.status := 'T';
      exception when no_data_found then null;
      end;
    end if;
  end if;
end;
/
ALTER TRIGGER BARS.TBIU_FINMON_QUE_STATUS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBIU_FINMON_QUE_STATUS.sql =========
PROMPT ===================================================================================== 
