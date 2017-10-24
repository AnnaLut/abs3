

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_CIM_F504.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_CIM_F504 ***

  CREATE OR REPLACE TRIGGER BARS.TIU_CIM_F504 
  BEFORE INSERT OR UPDATE ON CIM_F504
  REFERENCING FOR EACH ROW
  begin
    if inserting then
     select
           bars_sqnc.get_nextval('s_cim_f504'), (select logname from staff$base where id=user_id())
     into
          :new.f504_id, :new.user_reg
     from dual;
   end if;
   if updating then
      :new.date_ch := sysdate;

      select logname into :new.user_ch

      from staff$base where id=user_id();

   end if;
end;


/
ALTER TRIGGER BARS.TIU_CIM_F504 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_CIM_F504.sql =========*** End **
PROMPT ===================================================================================== 
