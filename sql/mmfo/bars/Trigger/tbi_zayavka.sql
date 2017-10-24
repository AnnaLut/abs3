

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_ZAYAVKA.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_ZAYAVKA ***

  CREATE OR REPLACE TRIGGER BARS.TBI_ZAYAVKA 
before insert ON BARS.ZAYAVKA for each row
declare
  id_ number;
begin
   -- идентификатор заявки
   if ( :new.id = 0 or :new.id is null ) then
       id_ := bars_sqnc.get_nextval('s_zayavka');
       :new.id := id_;
   end if;
   -- виза
   if ( :new.viza is null ) then
        :new.viza := 0;
   end if;
   -- инициатор заявки
   :new.isp  := user_id;
   --:new.tobo := tobopack.gettobo;
   -- время поступления заявки
   if :new.datedokkb is null then
      :new.datedokkb := sysdate;
   end if;
end;
/
ALTER TRIGGER BARS.TBI_ZAYAVKA ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_ZAYAVKA.sql =========*** End ***
PROMPT ===================================================================================== 
