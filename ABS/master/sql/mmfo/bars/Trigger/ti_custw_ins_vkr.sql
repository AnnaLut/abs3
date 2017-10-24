

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TI_CUSTW_INS_VKR.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TI_CUSTW_INS_VKR ***

  CREATE OR REPLACE TRIGGER BARS.TI_CUSTW_INS_VKR 
-- before insert           on customerw  referencing NEW as new for each row
   before insert or update ON BARS.CUSTOMERW                         for each row
  WHEN (
new.tag = 'VNCRR'
      ) declare  cw customerw_update%Rowtype;
procedure set_vkr(p_rnk number, p_tag varchar2, p_value varchar2)
  is
    pragma autonomous_transaction;
  begin
    kl.setCustomerElement(p_rnk, p_tag, p_value, 0);
    commit;
end;
begin

-- Создание начальной записи по доп.рекв "Начальный вн.кнр рейтинг"
begin cw.tag := 'VNCRP'; --  доп.рекв "Начальный вн.кнр рейтинг"
       select * into cw from customerw_update where rnk = :new.rnk and tag = cw.tag and rownum = 1; -- уже естьь
EXCEPTION WHEN NO_DATA_FOUND THEN
      set_vkr(:new.rnk, cw.tag, :new.value);
--insert into customerw(rnk, tag, value, isp)  values (:new.rnk, cw.tag, :new.value, gl.aUid);
end;

-- Наследование в МБК доп.рекв "Текущий кр рейтинг"
for k in (select nd from cc_deal where ( vidd >= 1500 and vidd < 1600 OR vidd =150 ) and sos < 15 and rnk=:new.rnk )
loop   cck_app.Set_ND_TXT(k.nd, :new.tag, :new.value );   end loop ;

end TI_CUSTW_INS_VKR;
/
ALTER TRIGGER BARS.TI_CUSTW_INS_VKR ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TI_CUSTW_INS_VKR.sql =========*** En
PROMPT ===================================================================================== 
