

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIUD_CIM_F504_DETAIL.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIUD_CIM_F504_DETAIL ***

  CREATE OR REPLACE TRIGGER BARS.TIUD_CIM_F504_DETAIL 
  BEFORE INSERT OR UPDATE OR DELETE ON CIM_F504_DETAIL
  REFERENCING FOR EACH ROW
  begin
    if inserting then
     select
           nvl(:new.f504_det_id, s_cim_f504.nextval), (select logname from staff$base where id=user_id())
     into
          :new.f504_det_id, :new.user_reg
     from dual;
     update cim_f504 set date_ch = sysdate where f504_id = :new.f504_id;
   end if;
   if updating then
      :new.date_ch := sysdate;

      select logname into :new.user_ch
      from staff$base where id=user_id();

      update cim_f504 set date_ch = :new.date_ch where f504_id = :new.f504_id;
   end if;

   if deleting then
     update cim_f504 set date_ch = sysdate where f504_id = :old.f504_id;
   end if;

end;
/
ALTER TRIGGER BARS.TIUD_CIM_F504_DETAIL ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIUD_CIM_F504_DETAIL.sql =========**
PROMPT ===================================================================================== 
