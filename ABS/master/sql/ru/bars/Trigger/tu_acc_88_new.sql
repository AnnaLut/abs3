

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_ACC_88_NEW.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_ACC_88_NEW ***

  CREATE OR REPLACE TRIGGER BARS.TU_ACC_88_NEW 
instead of update ON BARS.acc_88_new for each row
declare
 l_tmp    integer:=null;
 l_acc    accounts.acc%type:=null;
 p_tip    accounts.tip%type:='ODB';
 p_branch accounts.branch%type:=substr(SYS_CONTEXT('bars_context','user_branch_mask'),1,8);
 l_nms    accounts.nms%type;
 l_nls    accounts.nls%type;
 p_rnk    accounts.rnk%type;
 l_pap    ps.pap%type;
MODCODE   constant varchar2(3) := 'NAL';
begin
   begin
     select rnk  into p_rnk
          from accounts
          where nls=(select val from params where par='NU_KS7');
     exception when no_data_found then
                    bars_error.raise_nerror(MODCODE, 'NAL_NU_KS7');
   end;
-- определим pap по плану счетов
   begin
     select pap into l_pap from ps where nbs=:new.r020;
     exception when no_data_found then
                    bars_error.raise_nerror(MODCODE, 'NAL_NBS_PS');
   end;
-- откроем счет
   begin
        op_reg_lock (99, 0, 0, 28,  l_tmp,  p_rnk,
                vkrzn(substr(f_ourmfo,1,5),:new.nls),   980, :old.nmsn, 'ODB',
                USER_ID, l_acc, '1', l_pap,  0, null, null, null, null, null,
                null, null, null, null, p_branch );
   end;

   if l_acc is null
      then bars_error.raise_nerror(MODCODE, 'NAL_ACC_ERR');
   end if;

/* замена даты открытия счета, если открываем после даты ввода показателя */
   update accounts set daos=:new.d_open,
                       nms=:new.nmsn    where acc=l_acc;

/* установка спецпараметров */
   begin
   insert into specparam_int ( acc, p080, ob22, r020_fa, kf)
   values (    l_acc, :new.P080, :new.OB22, :new.R020_FA,
               sys_context('bars_context','user_mfo'));
   exception when dup_val_on_index then
       update  specparam_int set p080=:new.P080, r020_fa=:new.R020_FA,
                                 ob22=:new.OB22 where acc=l_acc;
   end;
end;
/
ALTER TRIGGER BARS.TU_ACC_88_NEW ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_ACC_88_NEW.sql =========*** End *
PROMPT ===================================================================================== 
