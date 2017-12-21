CREATE OR REPLACE PACKAGE CCK_DPK IS
  g_header_version CONSTANT VARCHAR2(64) := 'ver.1.0  21/12/2017 ';
  /*
   21.12.2017 ������������� ���� ������� ��� ���   
   07.04.2016 Sta   ��.����� TT_W4 ������� � "������" �������  ��� �������������  � �� �����������
   26.02.2016 ������ �������� �� ��������������� ������ �� ��������� ����
   22.02.2016 Sta cobupabs-4219 ������� ��.���
   12.06.2015 ������. ��������� �� ��� ���������: ������� ��� MODI_RET_GPK � ������ ���
   28.04.2015 COBUSUPABS-3441:   ���� 2620+2625+SG
   22.01.2014 ������ ����-���� ���
  */

  TT_W4 tts.tt%type := 'W4Y'; ---  W4.�������� � ��� ��� �����. ��������� ������. (������ W4X )

  --���� ����� ���.
  K0_      number; -- 1-�������. 0 - �����
  K1_      number; -- ����� ��� ���������� ���
  K2_      number; -- ��������� ����
  K3_      number; -- 1=� ����������� ����� ������ �������, 2=� ������������ ����� �� ��������� ����
  ACR_DAT_ date;
  ----------------------------------
  function Z8(p_nd cc_deal.nd%type) return int; -- �������� �� ��������������� ������ �� ��������� ����
  ----------------------------------------------------------------------
  function Day_PL(p_nd cc_deal.nd%type) return int; -- ����������� K2_ �� ���������   ;  -- ��������� ����
  ---------------------------------------
  -- �� ������������� ��� ��������� �������� � ������ �������
  PROCEDURE PROC1(p_ND IN number, p_datn date);
  ------------------------------------

  -- ������� ��� �� ����� ����� - ��� ��������
  PROCEDURE REST_GPK(p_ND IN number);
  ------------------------------------

  -- ������� �������������� ���-�� ���o����, ��������, ��������� ���� �������  � ����� ���������
  PROCEDURE PREV(p_ND IN number, p_acc2620 number);
  ---------------------------------------
  PROCEDURE REF_2620(p_ND  IN number, -- ��� ��
                     p_acc in out number -- acc 2620
                     );
  -- �������� � ��=p_ND  ��������� �����  ���_2620
  -- ��� � ����-�������� ����� (���� p_ac�2620 = 0 ��� null)
  -- � ��������� ���.

  -- cck_dpk.sum_SP_ALL (d.nd)         Z1,
  -- cck_dpk.sum_SN_all (a8.vid, d.nd) Z2,
  -- cck_dpk.sum_SS_next (d.nd)        Z3,
  ----------------------------------------------------------------------
  --DAT_MOD.����������� ���������� ���� ����������� ���
  function DAT_MOD(p_nd cc_deal.nd%type) return cc_lim_arc.MDAT%type;
  ----------------------------------------------------------------------

  --Z1.����������� ����� ������ ���������
  function sum_SP_all(p_nd cc_deal.nd%type) return number;

  -------------------------------------------------
  --Z2.����������� ����� ���� �������+�����������
  function sum_SN_all(p_vid int, p_nd cc_deal.nd%type) return number;

  -----------------------------------------
  --Z3.����������� ����� ����.������� �� ����
  function sum_SS_next(p_nd cc_deal.nd%type) return number;
  -----------------------------------------

  -- �������� ����.����� 1-�� �������
  function prev_SUM1(p_nd number) return number;
  ------------------------------------------------

  PROCEDURE PLAN_FAKT(p_nd number);
  ------------------------------------------------

  --����������� ��� ��� ����.�����

  PROCEDURE DPK(p_mode IN int, -- 0 - �������,
                -- 1 - �����������
                -- 2 - ������ ����������� ���
                p_ND      IN number, -- ��� ��
                p_acc2620 IN number, -- ���� ������� (2620/2625/SG)
                --=== ���� ����� ���.
                p_K0 IN OUT number, -- 1-�������. 0 - �����
                p_K1 IN number, -- <����� ��� ���������� ���>, �� ����� = R2,
                p_K2 IN number, -- <��������� ����>, �� ���� = DD �� �������� ����.���
                p_K3 IN number, -- 1=�� ,<� ����������� ����� ������ �������?>
                -- 2=��� (� ������������ ����� �� ��������� ��������� ����)
                --
                --==--����-���� <�������������>
                p_Z1 OUT number, -- ��������� z1 =SLN+SLK+SL+SPN+SK9+SP+SN8
                p_Z2 OUT number, -- ����.�������� � ����� z2 =SN+SN`+SK0
                p_Z3 OUT number, -- <�����������> ��� ��������� (�������, ���������) ������ �� ����
                p_Z4 OUT number, --�����  ������������� ������� = z4 =  z1 + z2 + z3
                p_Z5 OUT number, -- �������� ������� �� ����  z5 = (SS - z3)
                --
                --== ����-���� <�������>
                p_R1 OUT number, -- ����� ������ (��� �� SG(2620)
                p_R2 OUT number, --  ��������� ������ R2 =  R1 - z4
                p_P1 OUT number --  ���.�������
                );
  --------------------------------
  PROCEDURE MODI_INFO(p_mode IN int, -- 0 - �������, ��� ����������
                      -- 1 - ��������� ���.+����������� ���
                      -- 2 - ������ ����������� ���
                      p_ND      IN number, -- ��� ��
                      p_acc2620 IN number, -- ���� ������� (2620/2625/SG)
                      --==--����-���� <�������������>
                      p_Z1 OUT number, -- ��������� z1 =SLN+SLK+SL+SPN+SK9+SP+SN8
                      p_Z2 OUT number, -- ����.�������� � ����� z2 =SN+SN`+SK0
                      p_Z3 OUT number, -- <�����������> ��� ��������� (�������, ���������) ������ �� ����
                      p_Z4 OUT number, --�����  ������������� ������� = z4 =  z1 + z2 + z3
                      p_Z5 OUT number, -- �������� ������� �� ����  z5 = (SS - z3)
                      --
                      --== ����-���� <�������>
                      p_R1 OUT number, -- ����� ������ (��� �� SG(2620)
                      p_R2 OUT number --  ��������� ������ R2 =  R1 - z4
                      );
  --------------------------------------------------
  PROCEDURE MODI_pay(p_ND IN number, p_acc2620 IN number);
  --------------------------------------------------

  PROCEDURE MODI_gpk(p_ND IN number); -- ��� ��.
  ---------------------------------------------------
  procedure MODI_RET(p_Nd IN cc_deal.nd%type, p_REF IN OUT oper.ref%type);

  procedure MODI_RET_EX(p_Nd   IN cc_deal.nd%type,
                        p_REF  IN OUT oper.ref%type,
                        p_mdat IN date);

  procedure RET_GPK(p_Nd   IN cc_deal.nd%type,
                    p_REF  IN oper.ref%type,
                    p_mdat IN date);
  ---------------------------------------------------
END;
/
CREATE OR REPLACE PACKAGE BODY CCK_DPK IS

  /*
  10/09/2016 LSO COBUSUPABS-4327 ������ ��� ��������� �� ����������� �����
  06/09/2016 Sta COBUSUPABS-4219 ���� ��������� ������������ ��������� � ������� ���� � �������.
                 ����� ��.���  ������ � ���� ��
  
  31.05.2016 Sta ����������� CCK_DPK.NLS_6397 ��� ������ ������
  18.05.2016 Sta ������ commit
  07.04.2016 Sta   ��.����� TT_W4 ������� � "������" �������  ��� �������������  � �� �����������
  24.03.2016 Sta ������� ��������� (� ����� ��������� - ��� ������������)
     CCK_DPK.PREV �� CCK.CC_ASG( - ND )
  
  03-03-2016 Sta ���� ������� ����-���� ��� ��-1
  26.02.2016 ������ �������� �� ��������������� ������ �� ��������� ����
  22.02.2016 Sta cobupabs-4219 ������� ��.���
  21.10.2015 Sta ��������� ����� ��� �� �� ���� ����
  23-09-2015 Sta ����-���� =  �������� �����������. ��� �� ��������� ���� ������� !!!!
  12.06.2015 ������. ��������� �� ��� ���������:
                ������� ��� procedure RET_GPK  � ������ ���
                procedure RET_GPK (p_Nd  IN cc_deal.nd%type, p_mdat IN date ) is
  
  29.05.2015 Sta  ������  2752    +  �������� ��� ���������  Z1_ - ������ ��� ���  - ����� �� �����, ��� �� �������� ���������� �����
  28.05.2015 Sta  COBUSUPABS-3441. ���������, ��� �������� �����  =  'W4Y' = W4.�������� � ��� ��� �����. ��������� ������. (������ W4X )
  -------------------------------------
  15/05/2015 LitvinSO http://jira.unity-bars.com.ua:11000/browse/COBUSUPABS-3525
     ����������: � �������� %%1 ����������� ������� ��� ������������ ������� � ������ � ����������� ���������� ���������� �������� �� ������������ ���� ³�������� �� ���������, �������� ���� ���������� ��������� ����������� �����.
    � �������� MODI_pay ������ ���������� ������� RR2.nam_a, RR2.nam_b ��� ������� � �������� %%1
  --------------------------------
  29.04.2015 COBUSUPABS-3441:  p_acc2620 IN  number, -- ���� ������� (2620/2625/SG)
  1. ������������ ������� ����������� ��������� ��� ������� (���������� ���)�:
  ������ ��������� ������ ������� ���������� ������������ ���������:
  - 2620- SG=3739- 2625  ��� 2625 �������  ��������:
  > - �� ������� ���������� ������� ������� 2625 ��� �������� ��������� ��������� ������������ ���������;
  
  > - ���� ������������ ��������� ������� ���� � ������ ������ ��������� (� �������� ���-�� �������) � ������������� ����������� ������� 2924, � ����� ���� ������� ��� �������� � ������ �������� �2 ��������� ��������.;
  > - ���� ������������ ��������� �� ����� ������� SS (��� �������) ����������� �� ������ �� ����� ��� ������������ ���������, �� �������� �������� � ��� ����� ��� ������������ ���������� �� ����������� ��������;
  > - ��������� ����������� �� ����� ��������� �������� �� � ��� ����� ����;
  > - ��� �� ����������� �������� �� �������� �� ������ ��������� ����������� � ��� ����� ����;
  > - ����������� ������ ����� ������������ ��������� (�� �� ��� ��������� ���� �� ��);
  > - �� ��������� ���������� ���� ��� ������ ���� ��������� ������� ��������� �������� (� �. �. ���������� ���������� ������);
  
  23.02.2015 Sta http://jira.unity-bars.com.ua:11000/browse/COBUSUPABS-3283
             ����������� ��������� ������� �� � ����������� ��ʻ.
             ��� ������ ������� (��������� ���)  ������������  STP_DAT.
             ���������� �� �������� ��� �������� �������������.
  ���� ����������� ���� ���� � 2625*
  -------------------------------------
  */

  --cck_dpk.sum_SP_ALL (d.nd)         Z1,
  --cck_dpk.sum_SN_all (a8.vid, d.nd) Z2,
  --cck_dpk.sum_SS_next (d.nd)        Z3,

  ----------------------------------------
  II    int_accn%rowtype; -- ����.�������� ����� SS /II.basem=1 ��� �������. ����� ��������
  IR_   number; -- ����.������
  acc8_ accounts.accc%type;
  datn_ date; -- ���� ��� ��
  datk_ date; -- ���� ����� ��
  lim1_ number; -- ������ �����
  lim2_ number; -- ����� �����
  kol_  int;

  --����-���� <�������������>
  z1_  number; --��������� z1 =SLN+SLK+SL+SPN+SK9+SP+SN8(� ��_rang =10 ��� ����� ����� SS)
  z2K_ number; -- ����������            Z2K = �����  SK0
  z2N_ number; -- ����.��������         z2N = SN  + SN`
  z2_  number; -- ����.�������� � ����� z2  = Z2N + Z2K

  SS_ number; -- ������� �� ���� ����
  ZN_ number; -- (SN` ��������� ���� �� ��� ��� �� ����� SS + SP )
  Z3_ number; --<�����������> ��� ��������� (�������, ���������) ������ �� ����
  z4_ number; --�����  ������������� ������� = z4 =  z1 + z2 + z3
  z5_ number; -- �������� ������� �� ����  z5 = (SS - z3)  = TELO_  number;

  --����-���� <�������>
  R1_ number; -- ����� ������ (��� �� SG(2620/2625) R1
  R2_ number; -- ��������� ������ R2 =  R1 - z4
  RR1 oper%rowtype;
  --------------
  nls_8006 accounts.nls%type;
  nls_6397 accounts.nls%type;

  ---------------------------------------
  function Z8(p_nd cc_deal.nd%type) return int IS
    -- �������� �� ��������������� ������ �� ��������� ����
    ll      cc_lim%rowtype;
    PLAN_sp number;
    FAKT_sp number;
  begin
  
    begin
      select *
        into ll
        from cc_lim
       where nd = p_nd
         and fdat = (select max(fdat)
                       from cc_lim
                      where nd = p_nd
                        and fdat < gl.bdate);
      select LEAST(ostc + ll.lim2, 0)
        into PLAN_sp
        from accounts
       where acc = ll.acc;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        return 0; -- raise_application_error(-(20203), ' �� �������� ������������ ��� ��� �� ���=' || p_nd );
    end;
  
    select nvl(sum(a.ostc), 0)
      into FAKT_SP
      from accounts a, nd_acc n
     where a.acc = n.acc
       and n.nd = p_nd
       and tip = 'SP ';
    If PLAN_sp <> FAKT_sp then
      RETURN 0; --raise_application_error(-(20203), ' ������������ PLAN_SP �� FAKT_SP ��� �� ���=' || p_nd );
    end if;
    RETURN 1;
  end Z8;
  -----------------

  function Day_PL(p_nd cc_deal.nd%type) return int is
    -- ����������� K2_ number    ;  -- ��������� ����
    l_dat date;
    l_K2  int;
  begin
    begin
      select i.s
        into l_k2
        from int_accn i, accounts a, nd_acc n
       where n.nd = p_ND
         and n.acc = a.acc
         and a.tip = 'LIM'
         and a.acc = i.acc
         and i.id = 0
         and i.s > 0
         and i.s <= 31;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        Select max(fdat)
          into l_dat
          from cc_lim
         where nd = p_nd
           and fdat < gl.BD;
        If l_dat is null then
          Select NVL(min(fdat), gl.BD)
            into l_dat
            from cc_lim
           where nd = p_nd
             and fdat > gl.BD;
        end if;
        l_K2 := to_number(to_char(l_dat, 'DD'));
    end;
  
    RETURN l_K2;
  
  end Day_PL;

  ----------------------------
  -- �� ������������� ��� ��������� �������� � ������ �������
  PROCEDURE PROC1(p_ND IN number, p_datn date) is
    l_acc     number;
    l_acra    number;
    l_accc    number;
    l_sump    number := 0;
    l_ost_SN  number;
    l_ost_SS  number;
    l_adat    date;
    l_dat31   date;
    l_fdat2   date;
    l_int     number := 0;
    l_daos    date;
    l_STP_DAT date;
  begin
    begin
      --������� ���� � ��� ����.��������.
      select i.acc,
             i.acra,
             a.accc,
             greatest(nvl(i.acr_dat, a.daos - 1), a.daos - 1),
             a.daos,
             a.ostc,
             nvl(i.STP_DAT, a.mdate - 1)
        into l_acc, l_acra, l_accc, l_adat, l_daos, l_ost_SS, l_STP_DAT
        from accounts a, nd_acc n, int_accn i
       where n.nd = p_nd
         and n.acc = a.acc
         and a.tip = 'SS '
         and a.ostc < 0
         and a.ostb = a.ostc
         and i.acc = a.acc
         and i.id = 0
         and i.acra is not null;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        raise_application_error(- (20203),
                                ' �� �������� ���.SS ��� �� ���=' || p_nd ||
                                ', ��� ���� ����.������',
                                TRUE);
    end;
  
    begin
      select sumo - sumg - nvl(sumk, 0)
        into l_sump
        from cc_lim
       where nd = p_nd
         and fdat = p_datn;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        raise_application_error(- (20203),
                                '� ������ ��� �� �������� ��������� ��.���� ��� �� ���=' || p_nd,
                                TRUE);
    end;
  
    If cck_dpk.K0_ = 1 then
      ---------------------------------- 1-�������
    
      If l_adat < Least((p_datn - 1), l_STP_DAT) then
        CCK.INT_METR_A(l_Accc,
                       l_Acc,
                       0,
                       l_adat,
                       Least((p_datn - 1), l_STP_DAT),
                       l_Int,
                       Null,
                       0);
      end if; -- ���������� �� ��������
    
      l_ost_SN := fost(l_acra, gl.bdate) + l_int;
      update cc_lim
         set sumo = sumo - l_sump + (-l_ost_SN)
       where nd = p_nd
         and fdat = p_datn;
    else
      -- 0-�����
      -- ������ �� ���� � ���
      l_dat31 := trunc(gl.bdate, 'MM') - 1;
    
      If l_daos > l_dat31 then
        acrn.p_int(l_Acc,
                   0,
                   gl.bdate,
                   Least(add_months(l_dat31, 1), l_STP_DAT),
                   l_Int,
                   Null,
                   0); -- ���������� ����������
        l_ost_SN := fost(l_acra, gl.bdate) + round(l_int, 0);
        update cc_lim
           set sumo = sumo - l_sump + (-l_ost_SN)
         where nd = p_nd
           and fdat = p_datn; --�������� ��� ��� % 31� ������� ��� �����
        RETURN;
      end if;
    
      l_ost_SN := fost(l_acra, l_dat31);
      update cc_lim
         set sumo = sumo - l_sump + (-l_ost_SN)
       where nd = p_nd
         and fdat = p_datn; --�������� ��� ��� % 31� ������� ��� �����
    
      -- ������ �� ���� � ���
      acrn.p_int(l_Acc,
                 0,
                 (l_dat31 + 1),
                 least(add_months(l_dat31, 1), l_STP_DAT),
                 l_Int,
                 Null,
                 0); -- ���������� ����������
      l_int := round(l_int, 0);
      select nvl(min(fdat), p_datn)
        into l_fdat2
        from cc_lim
       where nd = p_nd
         and fdat > p_datn;
      select sumo - sumg - nvl(sumk, 0)
        into l_sump
        from cc_lim
       where nd = p_nd
         and fdat = l_fdat2;
      update cc_lim
         set sumo = sumo - l_sump + (-l_int)
       where nd = p_nd
         and fdat = l_fdat2;
    
    end if;
  
  end PROC1;
  ------------------------------------

  -- ������� ��� �� ������ ����� - ��� ��������
  PROCEDURE REST_GPK(p_ND IN number) is
    -- ������ ��.���� ������ ������� � ������� - ��� � ��. ����������� � ����������
    s_dd  char(2);
    nTmp_ int;
  
  begin
  
    --CCK_DPK.PREV ( p_nd)   ; -- �������� �� ����������
    --cck_dpk.K1_ :=  0      ;  -- ����� ��� ���������� ���
    --cck_dpk.K3_ :=  1      ;  -- � ����������� ����� ������ �������
    -----------------------------
    begin
    
      select a8.acc,
             least(-a8.ostx, -a8.ostc),
             a8.mdate,
             DECODE(a8.vid, 4, 1, 0)
        into acc8_, lim2_, datk_, cck_dpk.K0_
        from accounts a8, nd_acc n8
       where n8.nd = p_nd
         and n8.acc = a8.acc
         and a8.tip = 'LIM'
         and a8.ostc = a8.ostb
         and a8.ostb < 0;
    
      If datk_ < gl.bdate then
        raise_application_error(- (20203),
                                ' �� ���=' || p_nd || ' 100% ���������� ');
      end if;
    
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        raise_application_error(- (20203),
                                ' �� �������� ���.8999 ��� �� ���=' || p_nd ||
                                ', ��� ���� ��= ����');
    end;
  
    If Lim2_ = 0 then
      raise_application_error(- (20203),
                              ' �� ��������� ����� ��� ��� �� ���=' || p_nd,
                              TRUE);
    end if;
  
    begin
      select *
        into II
        from int_accn
       where acc = acc8_
         and id = 0;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        raise_application_error(- (20203),
                                ' �� �������� ����.������(id=0) ��� ���.8999_' || p_nd);
    end;
  
    select count(*), min(fdat)
      into nTmp_, datn_
      from cc_lim
     where nd = p_nd
       and fdat < gl.bdate;
  
    If nTmp_ > 1 then
      -- ������������ ��� ����� ������ ���� ���� ����
    
      select min(fdat)
        into datn_
        from cc_lim
       where nd = p_nd
         and fdat >= gl.bdate;
    
      if datn_ is null then
        raise_application_error(- (20203),
                                '� ������������ ��� �� �������� ��������� ��.���� ��� �� ���=' || p_nd,
                                TRUE);
      end if;
    
      -- 11.06.2014 � ������ ��� ��� ����� ���� ������ � ��������� � ����� ����� � ����� � ���������, �� ��� ��� ������������� ��� ��������� � ������ ������� ������ ( �� �� ������� )----
      If to_number(to_char(datn_, 'dd')) <> ii.s then
        datn_ := CCK.F_DAT(to_char(ii.s), trunc(gl.bdate, 'MM'));
      end if;
    
    end if;
  
    cck_dpk.modi_gpk(p_nd);
    select min(fdat)
      into datn_
      from cc_lim
     where nd = p_nd
       and fdat >= gl.bdate;
  
  end REST_GPK;
  ------------------------------------
  -- ������� �������������� ���-�� ���o����, ��������, ��������� ���� �������  � ����� ���������
  PROCEDURE PREV(p_ND IN number, p_acc2620 number) is
  
    -- ����������� ��������������� ������ ��� ������� ���������� ���������
    oo       oper%rowtype;
    l_rnk    number; --dd cc_deal%rowtype ;
    nls_2924 varchar2(15);
    S_       number := 0;
  begin
    CCK.CC_ASG(-p_ND);
  
    /* ********************************
      begin  select d.rnk, c.okpo into l_rnk, oo.id_a from cc_deal d, customer c where d.nd  = p_nd  and d.rnk = c.rnk  ;  EXCEPTION WHEN NO_DATA_FOUND THEN RETURN;  end;
    -- 1) ������ ����� ������� - ����� ���a �������� �� ���� �� �������
    -- ���� �� ������ ������� ��� ��������� ���� ������ 1 ����
    for g in ( select * from accounts where acc = p_acc2620 and (ostc > 0 and ostc = ostb  OR nbs='2625')  )
    loop oo.tt  := 'ASG';    oo.vob := 6 ;  oo.ref := null ;
       -- ���� �� ������ ������������� ����� ���� �� ������� �������
       for p in (select a.* from accounts a, nd_acc n, cc_deal d where d.rnk=l_rnk and d.sos >=10 and d.sos<14 and n.nd=d.nd and n.acc=a.acc and a.kv=g.kv and a.tip in ('SPN','SP ','SK9','SN8') and a.ostc<0 and a.ostc=a.ostb)
       loop     if g.ostc <= 0 then EXIT;    end if;
          ----------------------------------------------------------------------------------- � ������ ��� ����� 262*
          If  g.KV = p.KV then oo.s := least(g.ostc,                    -p.ostc            ); oo.s2 := gl.p_icurval (g.kv, oo.s, gl.bdate) ; -- ������������� � ������ ����� �������
          else                 oo.s := least(g.ostc, gl.p_Ncurval( g.KV,-p.ostc, gl.bdate) ); oo.s2 := -p.ostc                             ; -- ����. ��� ����� ����������� � ���
          end if;
          --------------------------------
          g.ostc :=  g.ostc  - oo.s;
          If oo.ref is null then      GL.REF (oo.ref);      oo.NAZN  := '�������� ���������� �������������i ��i��� ����/�����' ;
             if g.nbs in ('2600','2620','2625') then        oo.NAZN  := '�����i��� ' || oo.nazn ;     end if ;
             if g.nbs='2625' then   oo.tt := cck_dpk.TT_W4; nls_2924 := bpk_get_transit('20', p.nls, g.nls, g.kv  ) ;
             else                   oo.tt := 'ASG'        ; nls_2924 := g.nls ;
             end if ;
             gl.in_doc3(ref_  => oo.REF ,   tt_=>oo.tt, vob_=> oo.vob, nd_ => to_char(p_ND), pdat_ => SYSDATE, vdat_=>gl.BDATE, dk_ => 1, kv_ => g.kv , s_=> oo.s,
                        kv2_  => g.kv   ,   s2_=>oo.s , sk_ => null  , data_=> gl.BDATE, datp_ => gl.bdate,
                        nam_a_=>substr(g.nms,1,38) , nlsa_=> g.nls   , mfoa_=> gl.aMfo ,
                        nam_b_=>substr(p.nms,1,38) , nlsb_=> p.nls   , mfob_=> gl.aMfo , nazn_ => oo.nazn ,
                        d_rec_=> null   , id_a_ => oo.id_a, id_b_=>gl.aOkpo, id_o_ => null, sign_=> null, sos_  => 1, prty_ => null, uid_ => null) ;
          end if ;
          S_ := S_ - p.ostc ;
          If p.tip ='SN8' then  -- ������������ �������� ���� -- ���� ��� ��� 6397 �� ���� ���� ��
               --������������ ���� 8006 - 8008
               If g.kv  <> p.kv then   gl.payv(0, oo.REF, gl.bDATE, oo.tt, 1, p.kv, CCK_DPK.NLS_8006, oo.s2, p.kv,  p.nls, oo.s2 );
               else                    gl.payv(0, oo.REF, gl.bDATE, oo.tt, 1, p.kv, CCK_DPK.NLS_8006, oo.s , p.kv,  p.nls, oo.s  );
               end if;
               gl.payv ( 0, oo.REF, gl.bDATE, oo.TT, 1, g.kv, nls_2924, oo.s, gl.baseval, CCK_DPK.NLS_6397, oo.s2 );   ----\  -- ������� ��������
          else gl.PAYv ( 0, oo.REF, gl.bDATE, oo.tt, 1, g.kv, nls_2924, oo.s, g.kv      ,  p.nls          , oo.s  );   ----/
          end if;
       end loop; --- P
       if oo.ref is not null then
          Update oper set s = S_, s2 = S_ where ref =  oo.REF ;
          If oo.tt <> cck_dpk.TT_W4 then gl.pay ( 2, oo.REF, gl.bDATE);
          Else                           gl.payv (0, oo.REF, gl.bDATE, oo.TT, 0, g.kv, nls_2924, S_, g.kv, g.nls, S_ );   ------ �������� ��������
          end if ;
       end if    ;
    
    end loop;  -- G
    ****************************
    */
    -- 2) ����������� ���� �� �����
    null;
  end PREV;

  ---------------------------------------
  PROCEDURE REF_2620(p_ND  IN number, -- ��� ��
                     p_acc in out number -- acc 262*
                     ) is
    -- �������� � ��=p_ND  ��������� �����  ���_2620
    -- ��� � ����-�������� ����� (���� p_ac�2620 = 0 ��� null)
    -- � ��������� ���.
    l_acc number;
    nTmp_ int;
  
  begin
    l_acc := nvl(p_acc, 0);
    begin
      If l_acc > 0 then
        select 1
          into nTmp_
          from nd_acc
         where nd = p_nd
           and acc = l_acc;
        return;
      else
        SELECT a2.ACC
          into l_acc
          FROM accounts a2, nd_acc n8, accounts a8
         WHERE a2.rnk = a8.rnk
           and a2.kv = a8.kv
           and a2.dazs IS NULL
           AND a2.nbs in ('2620', '2625')
           AND n8.nd = p_nd
           and n8.acc = a8.acc
           AND a8.dazs IS NULL
           AND a8.tip = 'LIM'
           and rownum = 1;
      end if;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        null;
    end;
  
    If l_acc > 0 then
      insert into nd_acc (nd, acc) values (p_nd, l_acc);
      INSERT INTO cc_sob
        (ND, FDAT, ISP, TXT, otm)
        select p_nd,
               gl.bDATE,
               gl.aUID,
               '���`����� �� � ���.' || a2.nls || '/' || a2.kv,
               6
          from accounts a2
         where acc = l_acc;
      p_acc := l_acc;
    end if;
  
  end REF_2620;

  ---------------------------
  --DAT_MOD.����������� ���������� ���� ����������� ���
  function DAT_MOD(p_nd cc_deal.nd%type) return cc_lim_arc.MDAT%type is
    l_mdat cc_lim_arc.MDAT%type;
  begin
    select max(mdat)
      into l_mdat
      from cc_lim_arc
     where nd = p_ND
       and TYPM is not null;
    return l_mdat;
  end DAT_MOD;
  ------------------------------------------------------

  --Z1.����������� ����� ������ ���������
  function sum_SP_ALL(p_nd cc_deal.nd%type) return number IS
    -- Z1_- ��������� z1 =SLN+SLK+SL+SPN+SK9+SP+SN8
  begin
    select -NVL(sum(a.ostb), 0)
      into cck_dpk.Z1_
      from accounts a, nd_acc n
     where n.nd = p_ND
       and n.acc = a.acc
       and a.tip in ('SP ', 'SL ', 'SPN', 'SK9', 'SLN', 'SLK', 'SN8');
    -- ������������� �����
    Return(cck_dpk.Z1_);
  end sum_SP_ALL;

  -------------------------------------------------
  --Z2.����������� ����� ���� �������+����������� ( ��� ����� � ��� �����)
  function sum_SN_all(p_vid int, p_nd cc_deal.nd%type) return number is
    ko_ number := 1000000;
  begin
  
    begin
      -- Z2k_-  ����.�������� ������� �����
      select -nvl(sum(a.ostb), 0)
        into Z2K_
        from accounts a, nd_acc n
       where n.ACC = a.acc
         and n.nd = p_nd
         and a.tip = 'SK0';
    
      select i.*
        into II
        from int_accn i, nd_acc n, accounts ss
       where n.nd = p_ND
         and N.acc = ss.acc
         and ss.tip = 'SS '
         and i.id = 0
         and i.acc = ss.ACC
         and ss.ostb < 0;
    
      ii.STP_DAT := least(NVL(ii.STP_DAT, gl.bdate - 1), gl.bdate - 1);
    
      CCK_DPK.ACR_DAT_ := ii.acr_dat;
      -- Z2n_-  ����.��������   ������� �����
      select -ostb into Z2N_ from accounts where ACC = II.acra;
      Z2_ := Z2N_ + Z2K_;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        Z2N_ := 0;
        Z2_  := z2k_;
        return Z2_;
    end;
  
    -- ������� %
    If II.acr_dat >= ii.STP_DAT then
      RETURN Z2_;
    end if; -- �� ��� �� ���������
    IR_ := acrn.fprocn(II.acc, 0, gl.bdate);
    If IR_ <= 0 then
      RETURN Z2_;
    end if;
  
    --ZN_ -- SN` ������� �����,= ��������� ���� �� ��� ��� �����������
    ZN_ := 0;
  
    If ii.STP_DAT > II.acr_dat then
      If p_vid = 4 then
        -- ��� ��������
        begin
          select (lb.sumo - lb.sumg) * (ii.STP_DAT - II.acr_dat) /
                 (lb.fdat - lp.fdat)
            into Zn_
            from cc_lim lb,
                 (select max(fdat) fdat
                    from cc_lim
                   where nd = p_ND
                     and fdat <= ii.STP_DAT) lp
           where lb.nd = p_ND
             and lb.fdat > lp.fdat
             and lb.fdat = (select min(fdat)
                              from cc_lim
                             where nd = p_ND
                               and fdat > ii.STP_DAT);
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            ZN_ := 0;
        end;
      else
        select NVL(sum(calp(-fost(ii.acc, z.fdat) * ko_,
                            IR_,
                            z.fdat,
                            z.fdat,
                            ii.basey)),
                   0) / ko_
          into ZN_
          from (select (ii.acr_dat) + c.num fDAT
                  from conductor c
                 where ii.acr_dat + c.num <= ii.STP_DAT) z;
      end if;
      zn_ := round(zn_, 0);
    end if;
  
    -- �������-���� �� ������� ����
    declare
      jj   int_accn%rowtype;
      znp_ number;
    begin
      select j.*
        into jj
        from int_accn j, nd_acc n, accounts sp
       where n.nd = p_ND
         and N.acc = sp.acc
         and sp.tip = 'SP '
         and j.id = 0
         and j.acc = sp.ACC
         and sp.dazs is null;
    
      select NVL(sum(calp(-fost(jj.acc, z.fdat) * ko_,
                          IR_,
                          z.fdat,
                          z.fdat,
                          jj.basey)),
                 0) / ko_
        into ZNP_
        from (select (jj.acr_dat) + c.num fDAT
                from conductor c
               where jj.acr_dat + c.num <= ii.STP_DAT) z;
      zn_ := zn_ + round(znp_, 0);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        null;
    end;
  
    -- ����� �����
    Z2N_ := Z2N_ + ZN_;
    Z2_  := Z2N_ + Z2K_;
    Return Z2_;
  
  end sum_SN_all;
  -------------------------------------------------
  --Z3.����������� ����� ����.������� �� ����
  function sum_SS_next(p_nd cc_deal.nd%type) return number IS
    l_Del  number;
    l_SumG number;
  begin
    Z3_ := 0;
  
    begin
      select -a.ostx + a.ostb
        into l_Del
        from accounts a, nd_acc n
       where n.nd = p_ND
         and n.acc = a.acc
         and a.tip = 'LIM';
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        raise_application_error(- (20203),
                                ' �� ' || p_nd || ' �� �������� ���.LIM*');
    end;
  
    If l_Del < 0 then
      l_Del := -l_Del;
      begin
        select sumg
          into l_SumG
          from cc_lim
         where nd = p_ND
           and fdat = (select min(fdat)
                         from cc_lim
                        where nd = p_ND
                          and fdat >= gl.BDate);
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          l_SumG := 0;
      end;
      z3_ := Least(l_SumG, l_Del);
    end if;
  
    -- ����� �����
    Return(Z3_);
  
  end sum_SS_next;

  -----------------------------------------

  /*  �������� .����� 1-�� ������� - ������������ ��� ����������� ����� 1-�� �������.
       ���� ����� �� ��������� ������� (��� ���.���)-��� ���� �����,
       � ��������� ������� � ������ ��� ���.
       !!! ����� ��� ����� ����� �������� � �������� ������ ���
  */

  function prev_SUM1(p_nd number) return number IS
    CL   cc_lim%rowtype;
    so1_ number;
    vid_ number;
  begin
  
    select a.vid
      into vid_
      from accounts a, nd_acc n
     where n.nd = p_nd
       and n.acc = a.acc
       and a.tip = 'LIM';
  
    If vid_ = 4 then
      CCK_DPK.k0_ := 1;
    else
      CCK_DPK.k0_ := 0;
    end if;
  
    begin
      select *
        into CL
        from cc_lim
       where nd = p_ND
         and fdat = (select min(fdat)
                       from cc_lim
                      where nd = p_nd
                        and fdat >= gl.bdate);
      If so1_ <= 0 then
        select *
          into CL
          from cc_lim
         where nd = p_ND
           and fdat = (select max(fdat)
                         from cc_lim
                        where nd = p_nd
                          and fdat < gl.bdate);
      end if;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        null;
    end;
  
    if CCK_DPK.K0_ = 1 then
      so1_ := CL.sumo;
    else
      so1_ := CL.sumg;
    end if;
  
    RETURN NVL(so1_, 0);
  
  end prev_SUM1;
  -------------------------------------
  PROCEDURE PLAN_FAKT(p_nd number) is
    aa accounts%rowtype;
  begin
  
    begin
      select a.*
        into aa
        from nd_acc n, cc_deal d, accounts a
       where d.nd = p_nd
         and a.acc = n.acc
         and n.nd = d.nd
         and d.rnk = a.rnk
         and a.dazs is null
         and rownum = 1
         and a.ostc <> a.ostb
         and a.nbs <> '2625';
      raise_application_error(- (20203),
                              '���.' || aa.nls ||
                              ' ������� ���� �� = ���� ');
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        null;
    end;
  
  end plan_fakt;
  -----

  PROCEDURE DPK(p_mode IN int, -- 0 - �������,
                -- 1 - ��������� ���.+����������� ��� (121)
                -- 2 -         ������ ����������� ��� (122)
                p_ND      IN number, -- ��� ��
                p_acc2620 IN number, -- ���� ������� (2620/2625/SG)
                --=== ���� ����� ���.
                p_K0 IN OUT number, -- 1-�������. 0 - �����
                p_K1 IN number, -- <����� ��� ���������� ���>, �� ����� = R2,
                p_K2 IN number, -- <��������� ����>, �� ���� = DD �� �������� ����.���
                p_K3 IN number, -- 1=�� ,<� ����������� ����� ������ �������?>
                -- 2=��� (� ������������ ����� �� ��������� ��������� ����)
                --
                --==--����-���� <�������������>
                p_Z1 OUT number, -- ��������� z1 =SLN+SLK+SL+SPN+SK9+SP+SN8
                p_Z2 OUT number, -- ����.�������� � ����� z2 =SN+SN`+SK0
                p_Z3 OUT number, -- <�����������> ��� ��������� (�������, ���������) ������ �� ����
                p_Z4 OUT number, --�����  ������������� ������� = z4 =  z1 + z2 + z3
                p_Z5 OUT number, -- �������� ������� �� ����  z5 = (SS - z3)
                --
                --== ����-���� <�������>
                p_R1 OUT number, -- ����� ������ (��� �� SG(262*)
                p_R2 OUT number, --  ��������� ������ R2 =  R1 - z4
                p_P1 OUT number --  ���.�������
                ) is
    ------------------------
  begin
  
    /*
    declare p_mode int := 1; p_ND  number := 7688;  p_K0  number := 0; p_K1  number := 1000000; p_K2  number := 24; p_K3  number := 0;
     p_Z1  number; p_Z2  number;  p_Z3  number;  p_Z4  number; p_Z5  number;  p_R1  number;  p_R2  number;  p_P1  number ;
    begin tuda;  CCK_dpk.dpk ( p_mode, p_ND, p_K0, p_K1, p_K2, p_K3, p_Z1,  p_Z2,  p_Z3,  p_Z4,  p_Z5,  p_R1,  p_R2, p_P1) ;
    logger.info ( 'DPK*' || p_Z1 ||','||  p_Z2 ||','||  p_Z3 ||','||  p_Z4 ||','||  p_Z5 ||','|| p_R1 ||','||  p_R2  ||','||  p_P1);
    end;
    */
  
    p_P1        := null;
    CCK_DPK.k2_ := nvl(p_K2, to_number(to_char(gl.bdate, 'DD')));
    CCK_DPK.k3_ := nvl(p_K3, 1);
    CCK_DPK.MODI_INFO(p_mode,
                      p_ND,
                      p_acc2620,
                      p_Z1,
                      p_Z2,
                      p_Z3,
                      p_Z4,
                      p_Z5,
                      p_R1,
                      p_R2);
    p_K0 := CCK_DPK.K0_;
    ---------------------------------
    If p_mode = 0 then
      -- ������ �������.
      null;
      Return;
    end if;
  
    cck_dpk.PLAN_FAKT(p_nd); -- �������� �� ���������� �������� � ������ ��������
  
    If p_mode = 1 then
      -- ��������� ��������� + ��������� ���.
    
      If nvl(p_k1, 0) <= 1 then
        bars_error.raise_nerror(p_errmod  => 'CCK',
                                p_errname => 'SUM_POG',
                                p_param1  => to_char(p_nd),
                                p_param2  => to_char(p_K1 / 100));
      end if;
      CCK_DPK.K1_ := p_k1 + Z3_;
      lim2_       := Z5_ - p_K1;
    
      CCK_DPK.MODI_pay(p_ND, p_acc2620);
    
      If Z5_ > 0 then
        CCK_DPK.MODI_gpk(p_ND);
        p_P1 := RR1.ref;
      end if;
    
    ElsIf p_mode = 2 then
      -- ������ ��������� ���, ��� ���������� ���������.
      CCK_DPK.k1_ := 0; -- ����� ��� ���������� ���
      cck_dpk.REST_GPK(p_ND => p_nd);
    end if;
  
    Return;
  
  end DPK;
  -----------------
  PROCEDURE MODI_INFO(p_mode IN int, -- 0 - �������, ��� ����������
                      -- 1 - ��������� ���.+����������� ���
                      -- 2 - ������ ����������� ���
                      p_ND      IN number, -- ��� ��
                      p_acc2620 IN number, -- ���� ������� (2620/2625/SG)
                      --==--����-���� <�������������>
                      p_Z1 OUT number, -- ��������� z1 =SLN+SLK+SL+SPN+SK9+SP+SN8
                      p_Z2 OUT number, -- ����.�������� � ����� z2 =SN+SN`+SK0
                      p_Z3 OUT number, -- <�����������> ��� ��������� (�������, ���������) ������ �� ����
                      p_Z4 OUT number, --�����  ������������� ������� = z4 =  z1 + z2 + z3
                      p_Z5 OUT number, -- �������� ������� �� ����  z5 = (SS - z3)
                      --
                      --== ����-���� <�������>
                      p_R1 OUT number, -- ����� ������ (��� �� SG(262*)
                      p_R2 OUT number --  ��������� ������ R2 =  R1 - z4
                      ) IS
  
    mdat_    date;
    vid_     int;
    ostb_    number;
    ostc_    number;
    nbs_2620 accounts.nbs%type;
    nls_2620 accounts.nls%type;
    nls_8999 accounts.nls%type;
    nls_2203 accounts.nls%type;
  
  BEGIN
    --------------------------------------
    -- ������ �� �������� ������ ����� � ������� ���.
    /*
    ��� ����������� ����������� ������������� ������� cck_arc_cc_lim �������� REZ+CCK ���������� �������� ������� ��� ����������� �������� ��� �� ���� (mdate)  ��� ������� ������� CCK (�. ���������� ���������).
    �������� :�������� TYPM (��� ������) ����� ���� ������� ���  ���������� �� ���������� ���� : �CCKD� � ��������� ��������.
    �� ����� ���:
    - ����������� ��������� ��������� �� ����������� ������� (��� �� � ����������)
    - �� ���������� �������� ���������� ��������� � ������� ��.
    - ��� ������ ���������� ���������.
    
    2.� ������� ���������� ��������� ������ ��� �  cck_arc_cc_lim  ����� ���� �������� ������ ���������� ����.
    */
  
    select max(mdat)
      into mdat_
      from cc_lim_arc
     where nd = p_ND
       and TYPM = 'CCKD';
    If mdat_ >= gl.bdate and p_MODE > 0 then
      raise_application_error(- (20203),
                              ' �� ' || p_nd || ' ��� ��� � � ����� �� ' ||
                              to_char(gl.bdate, 'dd.mm.yyyy'));
    end if;
    --------------------------------------
    -- ����� ���
    begin
      -- R1. ����� ������ (��� �� 2620/2625/SG)
      select a.nbs, a.ostb, a.ostb, a.ostc, a.nls
        into nbs_2620, R1_, ostb_, ostc_, nls_2620
        from accounts a, nd_acc n
       where n.nd = p_ND
         and n.acc = a.acc
         and a.acc = p_acc2620;
      If nbs_2620 <> '2625' and p_MODE = 1 and ostb_ <> ostc_ then
        raise_application_error(- (20203),
                                ' �� ' || p_nd || ' ���.' || nls_2620 ||
                                ': ����.��� �� = ����.���');
      end if;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        raise_application_error(- (20203),
                                ' �� ' || p_nd ||
                                ' �� �������� ��� ��� �������� ACC=' ||
                                p_acc2620);
    end;
  
    begin
      --������������ �������� � ���� ��� 8999*
      select a.acc, a.vid, a.ostb, a.ostc, a.nls
        into acc8_, vid_, ostb_, ostc_, nls_8999
        from accounts a, nd_acc n
       where n.nd = p_nd
         and n.acc = a.acc
         and a.tip = 'LIM'
         and a.ostb < 0;
      if ostb_ <> ostc_ and p_MODE in (1, 2) and nbs_2620 <> '2625' then
        raise_application_error(- (20203),
                                ' �� ' || p_nd || ' ���.' || nls_8999 ||
                                ': ����.��� �� = ����.���');
      end if;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        raise_application_error(- (20203),
                                ' �� ' || p_nd || ' �� �������� ��� 8999*');
    end;
  
    begin
      -- SS. ������� �� ���� ����
      select -a.ostb, a.nls, a.ostb, a.ostc
        into SS_, nls_2203, ostb_, ostc_
        from accounts a, nd_acc n
       where n.nd = p_ND
         and n.acc = a.acc
         and a.tip = 'SS '
         and a.ostb < 0;
      if ostb_ <> ostc_ and p_MODE = 1 then
        raise_application_error(- (20203),
                                ' �� ' || p_nd || ' ���.' || nls_2203 ||
                                ': ����.��� �� = ����.���');
      end if;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        raise_application_error(- (20203),
                                ' �� ' || p_nd || ' �� �������� ���.SS*');
    end;
    select min(fdat), max(fdat)
      into datn_, datk_
      from cc_lim
     where nd = p_nd;
    ----------------------------
  
    -- ��������������� �������� �������� ��-������
    If vid_ = 4 then
      CCK_DPK.k0_ := 1;
      II.BASEM    := 1;
      II.BASEY    := 2;
    else
      CCK_DPK.k0_ := 0;
    end if;
    ---------------------------------
    -- �����  ������������� ������� = z4 =  z1 + z2 + z3
    -- (Z1_���������) + (Z2_��������_�_�����_����_�_�����) + (Z3_����.������)
    cck_dpk.Z1_ := cck_dpk.sum_SP_ALL(p_nd);
    cck_dpk.Z2_ := cck_dpk.sum_SN_all(vid_, p_nd);
    cck_dpk.Z3_ := cck_dpk.sum_SS_next(p_nd);
    cck_dpk.Z4_ := cck_dpk.Z1_ + cck_dpk.Z2_ + cck_dpk.Z3_;
  
    cck_dpk.Z5_ := cck_dpk.SS_ - cck_dpk.Z3_; -- �������� ������� �� ����  z5 = (SS - z3)
    cck_dpk.R2_ := cck_dpk.R1_ - cck_dpk.Z4_; -- ��������� ������ R2 =  R1 - z4
    ----------------------------------
    If cck_dpk.Z1_ < 0 and p_mode in (1) then
      -- �� ���=%s ���� ���������.��������.
      bars_error.raise_nerror(p_errmod  => 'CCK',
                              p_errname => 'YES_SP',
                              p_param1  => to_char(p_nd),
                              p_param2  => to_char(-cck_dpk.Z1_ / 100));
    end if;
    ----------------------------------
  
    If cck_dpk.R2_ <= 0 and p_mode in (1) and nbs_2620 <> '2625' then
      --�� ���=%s ��������� �������
      bars_error.raise_nerror(p_errmod  => 'CCK',
                              p_errname => 'FREE_SG',
                              p_param1  => to_char(p_nd),
                              p_param2  => '�i����� ���.=' ||
                                           to_char(cck_dpk.R2_ / 100));
    end if;
    ----------------------------
    p_Z1 := cck_dpk.Z1_;
    p_Z2 := cck_dpk.Z2_;
    p_Z3 := cck_dpk.Z3_;
    p_Z4 := cck_dpk.Z4_;
    p_Z5 := cck_dpk.Z5_;
    p_R1 := cck_dpk.R1_;
    p_R2 := cck_dpk.R2_;
  
  END MODI_INFO;
  ----------------------------------------
  PROCEDURE MODI_pay(p_ND IN number, p_acc2620 IN number) is
    RR2      oper%rowtype;
    dd       cc_deal%rowtype;
    ostc_    number;
    ostb_    number;
    l_tt     tts.tt%type; -- ��� �������� ��� ����.�����. ��������� ��������!
    nls_2924 accounts.nls%type;
    l_Z3     number;
  
  begin
    begin
      select d.cc_id,
             d.sdate,
             c.okpo,
             SG.nls,
             substr(SG.nms, 1, 38),
             sg.kv,
             SS.nls,
             substr(SS.nms, 1, 38),
             ss.ostc,
             ss.ostb,
             substr('���������� ����� �� � ' || d.cc_id || ' �i� ' ||
                    to_char(d.sdate, 'dd.mm.yyyy') || '. ( ǳ ����������� ' ||
                    Decode(CCK_DPK.k3_,
                           1,
                           '���� 1-�� �������',
                           '�i������� ����i��') || ' )',
                    1,
                    160)
        into dd.cc_id,
             dd.sdate,
             RR1.id_a,
             RR1.nlsa,
             RR1.nam_a,
             RR1.kv,
             RR1.nlsb,
             RR1.nam_b,
             ostc_,
             ostb_,
             RR1.nazn
        from accounts SG,
             nd_acc   NSG,
             accounts SS,
             nd_acc   NSS,
             customer c,
             cc_deal  d
       where d.nd = p_ND
         and d.rnk = c.rnk
         and NSG.nd = d.ND
         and NSG.acc = SG.acc
         and SG.acc = p_acc2620
         and SG.dazs is null
         and NSS.nd = d.ND
         and NSS.acc = SS.acc
         and SS.tip = 'SS '
         and SS.dazs is null;
    
      if ostc_ <> ostb_ then
        bars_error.raise_nerror(p_errmod  => 'CCK',
                                p_errname => 'PLAN#FAKT',
                                p_param1  => to_char(p_nd),
                                p_param2  => RR1.nlsb);
      end if;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        raise_application_error(- (20203),
                                '�� �������� ���. p_acc2620=' || p_acc2620 ||
                                ' ��� SS �� �� =' || p_ND);
    end;
  
    --- ��� ������� � ��� %
    begin
      select SN.nls,
             SD.nls,
             substr(SN.nms, 1, 38),
             substr(SD.nms, 1, 38),
             SN.KV,
             SD.KV,
             -SN.ostb
        into RR2.nlsa,
             RR2.nlsb,
             RR2.nam_a,
             RR2.nam_b,
             RR2.kv,
             RR2.kv2,
             RR2.s
        from accounts SN, accounts SD
       where SN.acc = II.acra
         and SD.acc = II.acrb
         and SN.dazs is null
         and SD.dazs is null;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        raise_application_error(- (20203),
                                '�� �������� ���. � ����.������ �� � ');
    end;
  
    If II.acr_dat < NVL(II.stp_dat, (gl.bdate - 1)) and ZN_ > 0 then
    
      -- ����������� %  ZN
      gl.ref(RR2.REF);
      gl.in_doc3(ref_   => RR2.REF,
                 tt_    => '%%1',
                 vob_   => 6,
                 nd_    => substr(to_char(RR2.REF), -10),
                 pdat_  => SYSDATE,
                 vdat_  => gl.BDATE,
                 dk_    => 1,
                 kv_    => RR2.kv,
                 s_     => ZN_,
                 kv2_   => RR2.kv,
                 s2_    => ZN_,
                 sk_    => null,
                 data_  => gl.BDATE,
                 datp_  => gl.bdate,
                 nam_a_ => RR2.nam_a,
                 nlsa_  => RR2.nlsa,
                 mfoa_  => gl.aMfo,
                 nam_b_ => RR2.nam_b,
                 nlsb_  => RR2.nlsb,
                 mfob_  => gl.aMfo,
                 nazn_  => Substr('������������� �i�����i� � ' ||
                                  to_char(II.acr_dat + 1, 'dd.mm.yyyy') ||
                                  ' �� ' ||
                                  to_char(ii.STP_dat, 'dd.mm.yyyy') ||
                                  ' � ��`���� � ����������� ����� �� � ' ||
                                  dd.cc_id || ' �i� ' ||
                                  to_char(dd.sdate, 'dd.mm.yyyy'),
                                  1,
                                  160),
                 d_rec_ => null,
                 id_a_  => RR1.id_a,
                 id_b_  => gl.aOkpo,
                 id_o_  => null,
                 sign_  => null,
                 sos_   => 1,
                 prty_  => null,
                 uid_   => null);
    
      gl.payv(0,
              RR2.REF,
              gl.bDATE,
              '%%1',
              1,
              RR2.kv,
              RR2.nlsa,
              ZN_,
              RR2.kv2,
              RR2.nlsb,
              ZN_);
    
      -- ���������� ����, �� ��� % ��� ���������
      update int_accn
         set acr_dat = NVL(II.stp_dat, (gl.bdate - 1))
       where id = 0
         and acc in (select a.acc
                       from nd_acc n, accounts a
                      where n.nd = p_nd
                        and n.acc = a.acc
                        and tip in ('SS ', 'SP '));
      gl.pay(2, RR2.REF, gl.bDATE);
    end if;
    -----------------------------------------------
    --- ����� ����� �������� �� ���� CCK_DPK.K1_
    --  +  �������� ��� %%                   Z2N_
    --  +  �������� ��� �����                Z2K_,
    --  +  �������� ��� ���������            Z1_ - ������ ��� ���  - ����� �� �����, ��� �� �������� ���������� �����
  
    If RR1.nlsa like '2625%' then
      l_tt  := cck_dpk.TT_W4;
      rr1.s := CCK_DPK.K1_ + cck_dpk.Z2N_ + cck_dpk.Z2K_ + cck_dpk.Z1_; -- 29.05.2015
    else
      l_tt  := 'ASD';
      rr1.s := CCK_DPK.K1_ + cck_dpk.Z2N_ + cck_dpk.Z2K_;
    end if;
    /*
    logger.info('AAAA ' || RR1.nlsa  ||' ' || l_tt ||
       ' K1_=' || CCK_DPK.K1_  ||
    ' + Z2N_=' || cck_dpk.Z2N_ ||
    ' + Z2K_=' || cck_dpk.Z2K_ ||
    ' + Z1_='  || cck_dpk.Z1_  ||
    '= rr1.S=' || rr1.S );
    */
  
    If rr1.S <= 0 then
      Return;
    end if;
  
    gl.ref(RR1.REF);
    gl.in_doc3(ref_   => RR1.REF,
               tt_    => l_tt,
               vob_   => 6,
               nd_    => substr(dd.cc_id, 1, 10),
               pdat_  => SYSDATE,
               vdat_  => gl.BDATE,
               dk_    => 1,
               kv_    => RR1.kv,
               s_     => rr1.s,
               kv2_   => RR1.kv,
               s2_    => rr1.s,
               sk_    => null,
               data_  => gl.BDATE,
               datp_  => gl.bdate,
               nam_a_ => RR1.nam_a,
               nlsa_  => RR1.nlsa,
               mfoa_  => gl.aMfo,
               nam_b_ => RR1.nam_b,
               nlsb_  => RR1.nlsb,
               mfob_  => gl.aMfo,
               nazn_  => RR1.nazn,
               d_rec_ => null,
               id_a_  => RR1.id_a,
               id_b_  => RR1.id_a,
               id_o_  => null,
               sign_  => null,
               sos_   => 1,
               prty_  => null,
               uid_   => null);
    insert into operw
      (REF, TAG, VALUE)
    values
      (RR1.REF, 'ND   ', to_char(p_ND)); -- ���� ������������ ��������� DD.MM.YYYY
    insert into operw
      (REF, TAG, VALUE)
    values
      (RR1.REF, 'MDATE', to_char(gl.bdate, 'dd.mm.yyyy')); -- ��� K�
  
    If l_tt = cck_dpk.TT_W4 then
      nls_2924 := bpk_get_transit('20', RR1.nlsb, RR1.nlsa, RR1.kv);
      gl.payv(0,
              RR1.REF,
              gl.BDATE,
              l_tt,
              1,
              RR1.kv,
              RR1.nlsa,
              rr1.s,
              RR1.kv,
              nls_2924,
              rr1.s); ---------- �������� ��������
    
      iF cck_dpk.Z1_ > 0 THEN
        -- 29.05.2015 ��������� � ��� �� ��� =  -NVL(sum(a.ostb),0) into cck_dpk.Z1_  -- ������������� �����
      
        for x in (select a.*
                    from accounts a, nd_acc n
                   where n.nd = p_ND
                     and n.acc = a.acc
                     and ostb < 0
                     and a.kv = RR1.kv
                     and (a.tip in
                         ('SP ', 'SL ', 'SPN', 'SK9', 'SLN', 'SLK') OR
                         a.tip in ('SN8') and RR1.kv = gl.baseval)) loop
          if x.TIP = 'SPN' then
            rr1.d_rec := '��������� ����������� �i�����i�';
          elsIF x.TIP = 'SK9' then
            rr1.d_rec := '��������� ���������� ���i�i�';
          elsIF x.TIP = 'SP ' then
            rr1.d_rec := '��������� ������������ ���.�����';
          elsIF x.TIP = 'SL ' then
            rr1.d_rec := '��������� ����i����� ���.�����';
          elsIF x.TIP = 'SLN' then
            rr1.d_rec := '��������� ����i����� ����.�����';
          elsIF x.TIP = 'SLK' then
            rr1.d_rec := '��������� ����i����� ���i�.�����';
          elsIF x.TIP = 'SN8' then
            rr1.d_rec := '��������� ���i';
            gl.payv(0,
                    RR1.REF,
                    GL.BDATE,
                    'ASG',
                    1,
                    x.kv,
                    cck_dpk.NLS_8006,
                    -x.ostb,
                    x.kv,
                    x.nls,
                    -x.ostb); -- ����������� ����
            x.nls := cck_dpk.NLS_6397;
          end if;
        
          gl.payv(0,
                  RR1.REF,
                  gl.BDATE,
                  l_tt,
                  1,
                  RR1.kv,
                  nls_2924,
                  -x.ostb,
                  RR1.kv,
                  x.nls,
                  -x.ostb);
          update opldok
             set txt = rr1.d_rec
           where ref = RR1.REF
             and stmt = gl.aStmt;
        
        end loop;
      end if;
    Else
      nls_2924 := RR1.nlsa;
    End if;
  
    If CCK_DPK.K1_ > 0 then
      ---- ������� �������� �� 2203
    
      l_Z3 := 0; --- -- �������� ����� ��� �� ���� �� "�������"? ��� �� ���� ��������� �����
    
      If cck_dpk.Z3_ > 0 then
        begin
          select cck_dpk.Z3_
            into l_Z3
            from dual
           where gl.BD in (select fdat from cc_lim where nd = p_ND);
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            null;
        end;
      end if;
    
      If l_Z3 > 0 then
        gl.payv(0,
                RR1.REF,
                gl.BDATE,
                l_tt,
                1,
                RR1.kv,
                nls_2924,
                l_Z3,
                RR1.kv,
                RR1.nlsb,
                l_Z3);
        update opldok
           set txt = 'Z3. ���� ��� ��������� ���������'
         where ref = RR1.REF
           and stmt = gl.aStmt;
      end if;
    
      If CCK_DPK.K1_ > l_Z3 then
        gl.payv(0,
                RR1.REF,
                gl.BDATE,
                l_tt,
                1,
                RR1.kv,
                nls_2924,
                (CCK_DPK.K1_ - l_Z3),
                RR1.kv,
                RR1.nlsb,
                (CCK_DPK.K1_ - l_Z3));
        update opldok
           set txt = 'K1. ���� ��� ������������ ���������'
         where ref = RR1.REF
           and stmt = gl.aStmt;
      end if;
    
    end if;
  
    If CCK_DPK.Z2N_ > 0 then
      ---- ������� �������� �� 2208
      gl.payv(0,
              RR1.REF,
              gl.BDATE,
              l_tt,
              1,
              RR1.kv,
              nls_2924,
              CCK_DPK.Z2N_,
              RR1.kv,
              RR2.nlsa,
              CCK_DPK.Z2N_);
      update opldok
         set txt = 'Z2N_. �������� ��� %%'
       where ref = RR1.REF
         and stmt = gl.aStmt;
    end if;
  
    If CCK_DPK.Z2K_ > 0 then
      ---- ������� �������� �� 3578
      begin
        select Sk.nls, Sk.KV, -Sk.ostb
          into RR2.nlsa, RR2.kv, RR2.s
          from accounts Sk, nd_acc n
         where Sk.acc = n.acc
           and sk.tip = 'SK0'
           and sk.ostb < 0
           and n.nd = p_ND
           and sk.kv = rr1.kv
           and rownum = 1;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          null;
          raise_application_error(- (20203),
                                  '�� �������� ���. � tip = SK0');
      end;
      gl.payv(0,
              RR1.REF,
              gl.BDATE,
              l_tt,
              1,
              RR1.kv,
              RR1.nlsa,
              CCK_DPK.Z2K_,
              RR1.kv,
              RR2.nlsa,
              CCK_DPK.Z2K_);
      update opldok
         set txt = 'Z2K_ �������� ��� �����'
       where ref = RR1.REF
         and stmt = gl.aStmt;
    End if;
  
  end MODI_pay;
  --------------

  PROCEDURE MODI_gpk(p_ND IN number) is
    -- ��� ��.
    sum1_    number;
    l_gpk    number;
    l_txt    char(2);
    l_basem  int;
    Datk_new date;
  begin
  
    If CCK_DPK.K0_ = 1 then
      l_gpk   := 4;
      l_txt   := '90';
      l_basem := 1; -- 1 -�������, ��� ������, % �� ��������� ����
    else
      l_gpk   := 2;
      l_txt   := '91';
      l_basem := 0; -- 0- �����, ��� ������, % �� ��������� �����
    end if;
  
    IR_ := acrn.fprocn(II.acc, 0, gl.bdate);
  
    If CCK_DPK.k1_ > 0 then
      -- ���� ����� ���������� ��������� ������� => ������ ������ gl.bdate = ������ ������ ���
      datn_ := greatest(datn_, gl.bdate);
    else
      --11.06.2014 �������
      select nvl(max(fdat), gl.bdate)
        into datn_
        from cc_lim
       where nd = p_nd
         and fdat <= gl.bdate;
    end if;
  
    ----- ����� 1-�� ��
    sum1_ := cck.f_pl1(p_nd   => p_nd,
                       p_lim2 => lim2_, -- ����� �����
                       p_gpk  => l_gpk, -- 4-�������. 2 - ����� ( -- 1-�������. 0 - �����   )
                       p_dd   => CCK_DPK.K2_, -- <��������� ����>, �� ���� = DD �� �������� ����.���
                       p_datn => datn_, -- ���� ��� ��
                       p_datk => datk_, -- ���� ����� ��
                       p_ir   => ir_, -- ����.������
                       p_ssr  => CCK_DPK.k3_ -- ������� =0= "� ����������� �����"
                       );
  
    -- ��������� ��� � �����
    delete from CC_LIM_ARC
     where nd = p_nd
       and mdat = gl.bdate;
  
    insert into CC_LIM_ARC
      (ND,
       MDAT,
       FDAT,
       LIM2,
       ACC,
       NOT_9129,
       SUMG,
       SUMO,
       OTM,
       SUMK,
       NOT_SN,
       TYPM)
      select ND,
             gl.bdate,
             FDAT,
             LIM2,
             ACC,
             NOT_9129,
             SUMG,
             SUMO,
             OTM,
             SUMK,
             NOT_SN,
             'CCKD'
        from cc_lim
       where nd = p_ND;
  
    If CCK_DPK.k1_ > 0 then
      -- ���� ����� ���������� ��������� ������� => ������ ������ gl.bdate = ������ ������ ���
      update cc_lim
         set sumg = sumg + CCK_DPK.k1_,
             sumo = sumo + CCK_DPK.k1_,
             lim2 = lim2_
       where nd = p_nd
         and fdat = gl.bdate;
      if SQL%rowcount = 0 then
        insert into CC_LIM
          (ND, FDAT, LIM2, ACC, SUMG, SUMO, OTM, SUMK)
        values
          (p_nd,
           gl.bdate,
           lim2_,
           acc8_,
           CCK_DPK.k1_,
           CCK_DPK.k1_ + z2N_,
           1,
           0);
      end if;
    end if;
  
    delete from cc_lim
     where nd = p_nd
       and fdat > gl.bdate;
  
    --�������� ����� ����� �� ���� ����
    cck.UNI_GPK_FL(p_lim2  => lim2_, -- ����� �����
                   p_gpk   => l_gpk, -- 4-�������. 2 - ����� ( -- 1-�������. 0 - �����   )
                   p_dd    => CCK_DPK.K2_, -- <��������� ����>, �� ���� = DD �� �������� ����.���
                   p_datn  => datn_, -- ���� ��� ��
                   p_datk  => datk_, -- ���� ����� ��
                   p_ir    => ir_, -- ����.������
                   p_pl1   => sum1_, -- ����� 1 ��
                   p_ssr   => CCK_DPK.k3_, -- ������� =0= "� ����������� �����"
                   p_ss    => ss_, -- ������� �� ���� ����
                   p_acrd  => II.acr_dat + 1, -- � ����� ���� ��������� % acr_dat+1
                   p_basey => II.BASEY -- ���� ��� ��� %%;
                   );
    --commit;
  
    insert into cc_lim
      (ND, FDAT, LIM2, ACC, SUMG, SUMO, SUMK)
      select p_nd, fdat, lim2, acc8_, sumg, sumo, nvl(sumk, 0)
        from tmp_gpk
       where fdat > gl.bdate;
  
    -- 11.06.2014 + 21.11.2014 + 02.12.2014 �������� ���� � ������ ��.������
    If CCK_DPK.k1_ = 0 and datn_ <= gl.bdate then
    
      declare
        dTmpG_ date;
        dTmp1_ date; -- 01.10.2014 (21.10.2014) \
        dTmp2_ date; -- 31.10.2014              / ������� ���
        dTmp3_ date; -- 01.11.2014 \
        dTmp4_ date; -- 04.11.2014 / ���.��� ����� - 1
        dTmp5_ date; -- 05 11.2014 \
        dTmp6_ date; -- 30.11.2014 / ���.��� ����� -2
      
        gg  cc_lim%rowtype;
        si_ number;
        s1_ number;
        s2_ number;
      begin
      
        If l_gpk = 2 then
          -- 4-�������. 2 - ����� ( -- 1-�������. 0 - �����   )
        
          -- ��� 1-� �� ���� -- ������ �� ��������, �.�. ������ ���������� - ������ � �������
          dTmp1_ := trunc(add_months(gl.bdate, -1), 'MM'); -- 01 ����� ���� ���
          dTmp2_ := trunc(gl.bdate, 'MM') - 1; -- 31 ����� ����.���
          acrn.p_int(acc8_, 0, dTmp1_, dTmp2_, si_, NULL, 0);
          si_ := -Round(si_, 0);
          select min(fdat)
            into dTmpG_
            from cc_lim
           where nd = p_nd
             and fdat > dTmp2_;
          update cc_lim
             set sumo = sumg + si_
           where nd = p_nd
             and fdat = dTmpG_;
        
          -- ��� 2-� �� ����
          ------------------ ����� 1 -- ������ �� ��������
          dTmp3_ := dTmp2_ + 1; -- 01 ����� ���.���
          select min(fdat) - 1
            into dTmp4_
            from cc_lim
           where nd = p_nd
             and fdat > dTmp3_; -- ��.����-1  ���.���
          acrn.p_int(acc8_, 0, dTmp3_, dTmp4_, si_, NULL, 0);
          s1_ := -Round(si_, 0);
        
          ------------------ ����� 2 -- ������
          dTmp5_ := dTmp4_ + 1; -- ���.��� ��.����
          dTmp6_ := add_months(dTmp2_, 1); -- 31 ����� ��� ���
          select min(fdat)
            into dTmpG_
            from cc_lim
           where nd = p_nd
             and fdat > dTmp6_;
          If dTmp5_ > gl.bdate then
            ---2.2.1 - �� ������, ���� ��.���� �������� ������ ��� � �������, �.� ���.02.11.2014, � ��.���� 05.11.2014,  �� ������ 05.11.2014
            select lim2
              into gg.LIM2
              from cc_lim
             where nd = p_nd
               and fdat = dTmp5_;
            s2_ := calp_AR(gg.LIM2, ir_, dTmp5_, dTmp6_, ii.basey);
          Else
            ---2.2.2 - �� ��������. ���� ��.���� �������� ������ ��� ������� ��� � �������, �.�. ���.28.11.2014 ��� 05.11.2014, � ��.���� 05.11.2014
            acrn.p_int(acc8_, 0, dTmp5_, dTmp6_, s2_, NULL, 0);
            s2_ := -Round(s2_, 0);
          end if;
          si_ := s1_ + s2_;
          update cc_lim
             set sumo = sumg + si_
           where nd = p_nd
             and fdat = dTmpG_;
        Else
          /* �.��� �������� - ���� �� ���� ����  - (  ��� ����������� � ����������� 11.06.2014)
               �������� ��������� ���� ������ ��� 1-� ������� ����,
               � �� ����� ��������� ����� ���� + ����������� .
               �� ��� ���� �� ��������� ��� ���. ��������, ���.
          */
        
          dTmp1_ := datn_; -- ���� ��.����
          dTmp2_ := add_months(datn_, 1); -- ���� ��.����
          si_    := calp_AR(lim2_, ir_, datn_, dTmp2_ - 1, ii.basey); -- ���� ���� ��� ���� ��.����
          update cc_lim
             set sumo = sumo + si_
           where nd = p_nd
             and fdat = dTmp2_
             and sumg = sumo - nvl(sumk, 0);
        End if;
      end;
    end if;
  
    -- 28.03.2014 Sta ����������� � ����������� �����
    select max(fdat) into Datk_new from tmp_gpk;
    if Datk_new < Datk_ then
      update cc_deal set wdate = Datk_new where nd = p_ND;
      for k in (select a.acc
                  from nd_acc n, accounts a
                 where n.nd = p_nd
                   and n.acc = a.acc
                   and a.tip in ('SS ',
                                 'SN ',
                                 'SL ',
                                 'SDI',
                                 'SK0',
                                 'S9N',
                                 'SN8',
                                 'SG ',
                                 'LIM',
                                 'CR9',
                                 'SP ',
                                 'SPN',
                                 'SLN',
                                 'SPI',
                                 'SK9',
                                 'S9K',
                                 'SNO')) loop
        update accounts set mdate = Datk_new where acc = k.acc;
      end loop;
    end if;
  
    cck_app.set_nd_txt(P_ND, 'FLAGS', l_txt);
    --cck_app.set_nd_txt(P_ND, 'CCRNG', '10');
  
    /*
    rang|name
    ----|-----------------------------------------------|CUSTTYPE| BLK
    0    ��� ����-�������
    1    �����������
    2    ҳ���� �������� ���� (�����������) 3
    5    �� ����i���� ���� (�� ���. SG) ��������� ����� 3      2
    10   �� ����i���� ���� � 262* ��� ���. ��������� SG 3      14
    11   ������, ������� �������������               3      14
    */
  
    update int_accn i
       set i.basem = l_basem, i.basey = decode(l_basem, 1, 2, i.basey)
     where id = 0
       and acc in (select a.acc
                     from nd_acc n, accounts a
                    where n.nd = p_nd
                      and n.acc = a.acc
                      and a.tip in ('LIM', 'SS '));
  
    LOGGER.financial('�����.��� ���.' || p_ND || ' ��� ����.����� ����=' ||
                     CCK_DPK.k1_);
  
  end modi_gpk;

  ---------------------
  procedure MODI_RET(p_Nd IN cc_deal.nd%type, p_REF IN OUT oper.ref%type) is
  begin
    CCK_DPK.MODI_RET_EX(p_Nd => p_ND, p_REF => p_REF, p_mdat => gl.bdate);
  end MODI_RET;
  ---------------------
  procedure MODI_RET_EX(p_Nd   IN cc_deal.nd%type,
                        p_REF  IN OUT oper.ref%type,
                        p_mdat IN date) is
    l_p1 number;
    l_p2 number;
  begin
    CCK_DPK.RET_GPK(p_ND, p_ref, p_mdat); -- ����� ���
    If p_ref is not null then
      p_back_dok(p_ref, 5, null, l_p1, l_p2);
      p_REF := null;
    end if; -- ����� ��������
  end MODI_RET_EX;
  -------------------
  procedure RET_GPK(p_Nd   IN cc_deal.nd%type,
                    p_REF  IN oper.ref%type,
                    p_mdat IN date) is
    l_mdat cc_lim_arc.mdat%type;
    B_mdat date := NVL(p_mdat, gl.bdate);
    l_nd   number := p_ND;
  begin
  
    If l_nd is null and p_ref is not null then
      begin
        select n.nd
          into l_nd
          from nd_acc n, accounts a, oper o
         where n.acc = a.acc
           and a.kv = o.kv2
           and a.nls = o.nlsb
           and o.ref = p_ref;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          null;
      end;
    end if;
    if l_nd is null then
      return;
    end if;
    ------------------------------------
  
    select max(mdat)
      into l_mdat
      from cc_lim_arc
     where nd = L_ND
       and TYPM = 'CCKD';
  
    If l_mdat = B_mdat then
      delete from cc_lim where nd = L_nd;
      insert into CC_LIM
        (ND, FDAT, LIM2, ACC, NOT_9129, SUMG, SUMO, OTM, SUMK, NOT_SN)
        select ND, FDAT, LIM2, ACC, NOT_9129, SUMG, SUMO, OTM, SUMK, NOT_SN
          from cc_lim_arc
         where nd = L_nd
           and mdat = l_mdat;
    
      -- 11.06.2014 ������� ----
      declare
        dat_end date;
        dd      cc_deal%rowtype;
      begin
        select max(fdat) into dat_end from cc_lim where nd = L_nd;
        select * into dd from cc_deal where nd = L_nd;
        if dd.wdate <> dat_end then
          update cc_deal set wdate = dat_end where nd = L_nd;
          for k in (select acc
                      from accounts
                     where rnk = dd.rnk
                       and dazs is null
                       and mdate != dat_end
                       and acc in (select acc from nd_acc where nd = L_nd)) loop
            update accounts set mdate = dat_end where acc = k.acc;
          end loop;
        end if;
      end;
    
      --   ��� ������ ���������� ��������� 01 ����� ������  �� cck_arc_cc_lim  �� �������,
      --   � ������ ������� ������� ���������� ���������.
      If to_number(to_char(l_mdat, 'DD')) = 1 then
        update cc_lim_arc
           set typm = null
         where nd = L_nd
           and mdat = l_mdat;
      else
        delete from cc_lim_arc
         where nd = L_nd
           and mdat = l_mdat;
      end if;
    
      -- else ----��� � ������ �� B_mdat
      ---  bars_error.raise_nerror(p_errmod=>'CCK',p_errname=>'��� � ������ �� '||to_char(B_mdat,'dd.mm.yyyy'), p_param1=> to_char(L_nd), p_param2=> to_char(B_mdat,'dd.mm.yyyy'));
    
    end if;
  
  end RET_GPK;

---��������� ���� --------------
begin

  begin
    select nls
      into CCK_DPK.nls_8006
      from accounts
     where tip = 'SD8'
       and nvl(nbs, '8006') = '8006'
       and dazs is null
       and kv = gl.baseval
       and rownum = 1;
  EXCEPTION
    WHEN OTHERS THEN
      raise_application_error(- (20203),
                              ' �� �������� ����� ���. �� ���i 8006*SD8');
  end;

  CCK_DPK.NLS_6397 := nbs_ob22_bra('6397',
                                   '01',
                                   sys_context('bars_context', 'user_branch'));

end CCK_DPK;
/
