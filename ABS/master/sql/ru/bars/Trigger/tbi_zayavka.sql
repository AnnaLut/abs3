

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_ZAYAVKA.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_ZAYAVKA ***

  CREATE OR REPLACE TRIGGER BARS.TBI_ZAYAVKA 
before insert on zayavka for each row
declare
  id_ number;
begin
   -- ������������� ������
   if ( :new.id = 0 or :new.id is null ) then
       select s_zayavka.nextval into id_ from dual;
       :new.id := id_;
   end if;
   -- ����
   if ( :new.viza is null ) then
        :new.viza := 0;
   end if;
   -- ��������� ������
   :new.isp  := user_id;
   --:new.tobo := tobopack.gettobo;
   -- ����� ����������� ������
   if :new.datedokkb is null then
      :new.datedokkb := sysdate;
   end if;
end;
/
ALTER TRIGGER BARS.TBI_ZAYAVKA ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_ZAYAVKA.sql =========*** End ***
PROMPT ===================================================================================== 
