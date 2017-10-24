

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_CIM_F503.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_CIM_F503 ***

  CREATE OR REPLACE TRIGGER BARS.TIU_CIM_F503 
  BEFORE INSERT OR UPDATE ON CIM_F503
  REFERENCING FOR EACH ROW
  declare
    l_prizn           varchar2(3) := pul.get_mas_ini_val('cim_work_prepare_f503_change');
  begin
    if inserting then
     select
           s_cim_f503.nextval, (select logname from staff$base where id=user_id())
     into
          :new.f503_id, :new.user_reg
     from dual;

     :new.branch := nvl(:new.branch, sys_context('bars_context','user_branch'));
     :new.kf     := nvl(:new.kf, sys_context('bars_context','user_mfo'));

     if l_prizn != 'YES' then --приходить по суті з веба(не з процки короче кажучи)
       :new.contr_id  := null;
       :new.p_date_to := sysdate;
       :new.date_reg  := sysdate;
       :new.date_ch   := null;
       :new.user_ch   := null;
     end if;
   end if;
   if updating then
      :new.date_ch := sysdate;
      select logname into :new.user_ch
      from staff$base where id=user_id();
   end if;
end;
/
ALTER TRIGGER BARS.TIU_CIM_F503 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_CIM_F503.sql =========*** End **
PROMPT ===================================================================================== 
