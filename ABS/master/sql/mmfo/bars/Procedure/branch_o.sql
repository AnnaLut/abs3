CREATE OR REPLACE PROCEDURE BARS.BRANCH_O 
(  MODE_        int,
   branch_      varchar2,
   sRNK_ IN OUT VARCHAR2,
   isp_         int,
   grp_         int,
   NBS_         char,
   OB22_        char,
   MASK_        varchar2,
   kv_     OUT  int,
   NLS_    out  varchar2,
   NMS_ IN OUT  varchar2,
   ACC_    out  int
) is
  errk SMALLINT;  ern  CONSTANT POSITIVE := 333;  err  EXCEPTION; erm  VARCHAR2(180);
  ret_ int;
  tip_nls_  accounts.TIP%TYPE ;
  tip_      accounts.TIP%TYPE ;
  ACC3800_  accounts.ACC%TYPE ;
  RNK_      accounts.RNK%TYPE := to_number(sRNK_);
  ntmp_     int; n_ int;
  X_MASK_   NLSMASK.MASK%type := '1002_NNNNNNNNN';
  NMK_      customer.NMK%TYPE ;
  AB22_1    int;
  AB22_2    int;
begin

   -- прикинуться MFO
   bars_context.subst_branch(substr(branch_,1,8) );  -- прикинуться

  If MODE_  = 1 then

    If sRNK_ is null then
      If length(branch_) <15 then
          bars_context.set_context;  -- вернуться
          return;
      end if;
      -------------
      begin
         select rnk into RNK_ from customer where branch=branch_
           and okpo=gl.aOKPO and date_off is null and custtype=1 and rownum=1;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         select name into NMK_ from branch where branch=branch_;
         -- регистрация подразделения как клиента - лю.лица(банк)
         kl.setCustomerAttr (Rnk_    => RNK_,
                         Custtype_   => 1,
                         Nd_         => null,
                         Nmk_        => NMK_,
                         Nmkv_       => null,
                         Nmkk_       => substr(NMK_,1,38),
                         Adr_        => 'adr',
                         Codcagent_  => 1,
                         Country_    => 804,
                         Prinsider_  => 0,
                         Tgr_        => 1,
                         Okpo_       => gl.aOKPO,
                         DateOn_     => gl.BDATE,
                         Tobo_       => branch_,
                         Isp_        => ISP_,
                         Stmt_       => null,
                         Sab_        => null,
                         Taxf_       => null,
                         CReg_       => null,
                         CDst_       => null,
                         Adm_        => null,
                         RgTax_      => null,
                         RgAdm_      => null,
                         DateT_      => null,
                         DateA_      => null,
                         Ise_        => null,
                         Fs_         => null,
                         Oe_         => null,
                         Ved_        => null,
                         Sed_        => null,
                         Notes_      => null,
                         Notesec_    => null,
                         CRisk_      => null,
                         Pincode_    => null,
                         RnkP_       => null,
                         Lim_        => null,
                         NomPDV_     => null,
                         MB_         => null,
                         BC_         => null) ;
         kl.setBankAttr(Rnk_    => RNK_,
                    Mfo_    => gl.aMFO,
                    Bic_    => null,
                    BicAlt_ => null,
                    Rating_ => null,
                    Kod_b_  => null,
                    Ruk_    => null,
                    Telr_   => null,
                    Buh_    => null,
                    Telb_   => null,
                    k190_   => null);
--       dbms_output.put_line('3. зарегистрирован клиент № '||to_char(RNK_));
      end;
      branch_edit.setBranchParams( branch_, 'RNK', to_char(RNK_) );
      sRNK_ := to_char(RNK_);
   end if;
   bars_context.set_context;  -- вернуться
   RETURN;
end if;
----------------------------------
  begin
    select 1 into n_ from ps      where d_close is null and nbs=nbs_ ;
    select 1 into n_ from sb_ob22 where d_close is null and r020=nbs_ and ob22=OB22_;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN  return;
  end;

  If nbs_ in ('3800','3801')
  then
    if length(branch_)<>15
    then
      return;
    end if;
    xm_3800 (gl.aMFO, branch_, gl.BDATE );
    xv_3800 (gl.aMFO, branch_, gl.BDATE );
    return;
  end if;
----------------------------------
  Tip_ := iif_s (nbs_,'1004', 'KAS','KAS','ODB') ;
  kv_  := 980;
  begin
    -- найти счет c нужным ОБ22
    select a.acc, a.tip, a.nls, a.nms
      into acc_, tip_nls_, nls_, nms_
      from ACCOUNTS a
     where a.nbs=NBS_
       and a.dazs is null
       and a.branch=branch_
       and a.kv =kv_
       and a.ob22=OB22_;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      begin
        -- найти счет c пустым или отсутствующим ОБ22
        select acc , tip,      nls , nms
          into acc_, tip_nls_, nls_, nms_
          from ACCOUNTS a
         where a.nbs=NBS_
           and a.dazs is null
           and a.branch=branch_
           and a.kv=kv_
           and a.ob22 is null
           and rownum=1;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN acc_:= null;
      end;
  end;

  If ACC_ is not null and tip_nls_ <> TIP_ 
  then -- установить тип счета
    update ACCOUNTS
       set tip=tip_ 
     where acc=ACC_;
  elsIf ACC_ is null
  then -- открытие счета
    AB22_1 :=to_char(instr('0123456789ABCDEF',substr(OB22_,1,1))-1);
    AB22_2 :=to_char(instr('0123456789ABCDEF',substr(OB22_,2,1))-1);
    PUL.Set_Mas_Ini('OB22',AB22_1||AB22_2, 'Тек.ОБ22 преобр в число' );
    NLS_ := substr(f_newnls2(null,null,nbs_,RNK_,null,kv_,mask_) ||'', 1, 14);

    OP_REG( 99, 0, 0, GRP_, RET_, RNK_, NLS_, KV_, nms_, tip_,isp_,ACC_ );

    update ACCOUNTS
       set tobo = branch_
         , ob22 = OB22_
     where acc=ACC_;

  end if;

end BRANCH_O;
/

show err;

grant EXECUTE on BRANCH_O to BARS_ACCESS_DEFROLE;
grant EXECUTE on BRANCH_O to CUST001;
grant EXECUTE on BRANCH_O to WR_ALL_RIGHTS;
