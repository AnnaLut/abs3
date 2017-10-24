create or replace trigger TU_ACC_87_NEW
instead of update on ACC_87_NEW
for each row
declare
  l_tmp    integer:=null;
  l_acc    accounts.acc%type:=null;
  p_rnk    accounts.rnk%type;
  l_pap    ps.pap%type;
  p_grp    accounts.grp%type;
  MODCODE  constant varchar2(3) := 'NAL';
begin
  
  begin
    select RNK, GRP
      into p_rnk, p_grp
      from accounts
     where nls = ( select val from params where par='NU_KS7' );
  exception
    when no_data_found then
      bars_error.raise_nerror( MODCODE, 'NAL_NU_KS7' );
  end;

  -- определим pap по плану счетов
  begin
    select pap into l_pap from ps where nbs=:new.r020;
  exception
    when no_data_found then
      bars_error.raise_nerror( MODCODE, 'NAL_NBS_PS' );
  end;

  -- откроем счет
  begin
  
    accreg.SetAccountAttr
    ( mod_     => 99
    , p1_      => 0
    , p2_      => 0
    , p3_      => p_grp
    , p4_      => l_tmp
    , rnk_     => p_rnk
    , nls_     => vkrzn(substr(f_ourmfo,1,5),:new.nls)
    , kv_      => 980
    , nms_     => :new.nmsn
    , tip_     => 'ODB'
    , isp_     => USER_ID
    , accR_    => l_acc
    , nbsnull_ => '1'
    , ob22_    => :new.OB22
    , pap_     => l_pap
    , vid_     => 0
    , pos_     => null
    , seci_    => null
    , seco_    => null
    , blkd_    => null
    , blkk_    => null
    , nlsalt_  => null
    , branch_  => substr(SYS_CONTEXT('bars_context','user_branch'),1,8)
    );
    
  end;
  
  if l_acc is null
  then
    bars_error.raise_nerror( MODCODE, 'NAL_ACC_ERR' );
  else
    
    -- замена даты открытия счета, если открываем после даты ввода показателя
    update accounts
       set daos = :new.d_open
     where acc  = l_acc;
    
    -- установка спецпараметров
    begin
      insert
        into specparam_int
           ( ACC, P080, R020_FA, KF )
      values
           ( l_acc, :new.P080, :new.R020_FA, sys_context('bars_context','user_mfo') );
    exception
      when dup_val_on_index then
       update SPECPARAM_INT
          set p080    = :new.P080
            , r020_fa = :new.R020_FA
        where ACC = l_acc;
    end;
        
  end if;
  
end TU_ACC_87_NEW;
/

show errors
