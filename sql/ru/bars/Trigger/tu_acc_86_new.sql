

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_ACC_86_NEW.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_ACC_86_NEW ***

  CREATE OR REPLACE TRIGGER BARS.TU_ACC_86_NEW 
instead of update ON BARS.ACC_86_NEW for each row
declare
 l_tmp    integer:=null;
 l_acc    accounts.acc%type:=null;
 p_tip    accounts.tip%type:='ODB';
 p_branch accounts.branch%type:=substr(SYS_CONTEXT('bars_context','user_branch_mask'),1,8);
 l_nms    accounts.nms%type;
 l_nls    accounts.nls%type;
 p_rnk    accounts.rnk%type;
 l_pap    ps.pap%type;
 p_grp    accounts.grp%type;

MODCODE   constant varchar2(3) := 'NAL';
begin
   begin
     select rnk  into p_rnk
          from accounts
          where nls=(select val from params where par='NU_KS7');
     exception when no_data_found then
                    bars_error.raise_nerror(MODCODE, 'NAL_NU_KS7');
   end;
-- ��������� pap �� ����� ������
   begin
     select pap into l_pap from ps where nbs=:new.r020;
     exception when no_data_found then
                    bars_error.raise_nerror(MODCODE, 'NAL_NBS_PS');
   end;
-- ������� ����
   begin
        op_reg_lock (99, 0, 0, p_grp,  l_tmp,  p_rnk,
                vkrzn(substr(f_ourmfo,1,5),substr(:new.nls,1,14)),
                980, :old.nmsn, 'ODB',
                USER_ID, l_acc, '1', l_pap,  0, null, null, null, null, null,
                null, null, null, null
, p_branch
);
   end;

   if l_acc is null
      then bars_error.raise_nerror(MODCODE, 'NAL_ACC_ERR');
   end if;
/* ������ ���� �������� �����, ���� ��������� ����� ���� ����� ���������� */
   update accounts
      set daos=:new.d_open,
           nms=substr(:new.nmsn,1,70)
     where acc=l_acc;
/* ��������� �������������� */
   begin
   insert into specparam_int ( acc, p080, ob88,  kf)
   values (    l_acc, :new.P080, :new.OB88,  sys_context('bars_context','user_mfo'));
   exception when dup_val_on_index then
       update  specparam_int
          set p080=:new.P080, ob88=:new.OB88
        where acc=l_acc;
   end;
end;
/
ALTER TRIGGER BARS.TU_ACC_86_NEW ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_ACC_86_NEW.sql =========*** End *
PROMPT ===================================================================================== 
