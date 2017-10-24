CREATE OR REPLACE PACKAGE cck_dpk IS

  /*
   07.04.2016 Sta   ��.����� TT_W4 ������� � "������" �������  ��� �������������  � �� �����������
   26.02.2016 ������ �������� �� ��������������� ������ �� ��������� ����
   22.02.2016 Sta cobupabs-4219 ������� ��.���
   12.06.2015 ������. ��������� �� ��� ���������: ������� ��� MODI_RET_GPK � ������ ���
   28.04.2015 COBUSUPABS-3441:   ���� 2620+2625+SG
   22.01.2014 ������ ����-���� ���
  */

  tt_w4 tts.tt%TYPE := 'W4Y'; ---  W4.�������� � ��� ��� �����. ��������� ������. (������ W4X )

  --���� ����� ���.
  k0_      NUMBER; -- 1-�������. 0 - �����
  k1_      NUMBER; -- ����� ��� ���������� ���
  k2_      NUMBER; -- ��������� ����
  k3_      NUMBER; -- 1=� ����������� ����� ������ �������, 2=� ������������ ����� �� ��������� ����
  acr_dat_ DATE;
  ----------------------------------
  FUNCTION z8(p_nd cc_deal.nd%TYPE) RETURN INT; -- �������� �� ��������������� ������ �� ��������� ����
  ----------------------------------------------------------------------
  FUNCTION day_pl(p_nd cc_deal.nd%TYPE) RETURN INT; -- ����������� K2_ �� ���������   ;  -- ��������� ����
  ---------------------------------------
  -- �� ������������� ��� ��������� �������� � ������ �������
  PROCEDURE proc1
  (
    p_nd   IN NUMBER
   ,p_datn DATE
  );
  ------------------------------------

  -- ������� ��� �� ����� ����� - ��� ��������
  PROCEDURE rest_gpk(p_nd IN NUMBER);
  ------------------------------------

  -- ������� �������������� ���-�� ���o����, ��������, ��������� ���� �������  � ����� ���������
  PROCEDURE prev
  (
    p_nd      IN NUMBER
   ,p_acc2620 NUMBER
  );
  ---------------------------------------
  PROCEDURE ref_2620
  (
    p_nd  IN NUMBER
   , -- ��� ��
    p_acc IN OUT NUMBER -- acc 2620
  );
  -- �������� � ��=p_ND  ��������� �����  ���_2620
  -- ��� � ����-�������� ����� (���� p_ac�2620 = 0 ��� null)
  -- � ��������� ���.

  -- cck_dpk.sum_SP_ALL (d.nd)         Z1,
  -- cck_dpk.sum_SN_all (a8.vid, d.nd) Z2,
  -- cck_dpk.sum_SS_next (d.nd)        Z3,
  ----------------------------------------------------------------------
  --DAT_MOD.����������� ���������� ���� ����������� ���
  FUNCTION dat_mod(p_nd cc_deal.nd%TYPE) RETURN cc_lim_arc.mdat%TYPE;
  ----------------------------------------------------------------------

  --Z1.����������� ����� ������ ���������
  FUNCTION sum_sp_all(p_nd cc_deal.nd%TYPE) RETURN NUMBER;

  -------------------------------------------------
  --Z2.����������� ����� ���� �������+�����������
  FUNCTION sum_sn_all
  (
    p_vid INT
   ,p_nd  cc_deal.nd%TYPE
  ) RETURN NUMBER;

  -----------------------------------------
  --Z3.����������� ����� ����.������� �� ����
  FUNCTION sum_ss_next(p_nd cc_deal.nd%TYPE) RETURN NUMBER;
  -----------------------------------------

  -- �������� ����.����� 1-�� �������
  FUNCTION prev_sum1(p_nd NUMBER) RETURN NUMBER;
  ------------------------------------------------

  PROCEDURE plan_fakt(p_nd NUMBER);
  ------------------------------------------------

  --����������� ��� ��� ����.�����

  PROCEDURE dpk(p_mode IN INT
               , -- 0 - �������,
                -- 1 - �����������
                -- 2 - ������ ����������� ���
                p_nd      IN NUMBER
               , -- ��� ��
                p_acc2620 IN NUMBER
               , -- ���� ������� (2620/2625/SG)
                --=== ���� ����� ���.
                p_k0 IN OUT NUMBER
               , -- 1-�������. 0 - �����
                p_k1 IN NUMBER
               , -- <����� ��� ���������� ���>, �� ����� = R2,
                p_k2 IN NUMBER
               , -- <��������� ����>, �� ���� = DD �� �������� ����.���
                p_k3 IN NUMBER
               , -- 1=�� ,<� ����������� ����� ������ �������?>
                -- 2=��� (� ������������ ����� �� ��������� ��������� ����)
                --
                --==--����-���� <�������������>
                p_z1 OUT NUMBER
               , -- ��������� z1 =SLN+SLK+SL+SPN+SK9+SP+SN8
                p_z2 OUT NUMBER
               , -- ����.�������� � ����� z2 =SN+SN`+SK0
                p_z3 OUT NUMBER
               , -- <�����������> ��� ��������� (�������, ���������) ������ �� ����
                p_z4 OUT NUMBER
               , --�����  ������������� ������� = z4 =  z1 + z2 + z3
                p_z5 OUT NUMBER
               , -- �������� ������� �� ����  z5 = (SS - z3)
                --
                --== ����-���� <�������>
                p_r1 OUT NUMBER
               , -- ����� ������ (��� �� SG(2620)
                p_r2 OUT NUMBER
               , --  ��������� ������ R2 =  R1 - z4
                p_p1 OUT NUMBER --  ���.�������
                , p_p2      OUT NUMBER
                );
  --------------------------------
  PROCEDURE modi_info(p_mode IN INT
                     , -- 0 - �������, ��� ����������
                      -- 1 - ��������� ���.+����������� ���
                      -- 2 - ������ ����������� ���
                      p_nd      IN NUMBER
                     , -- ��� ��
                      p_acc2620 IN NUMBER
                     , -- ���� ������� (2620/2625/SG)
                      --==--����-���� <�������������>
                      p_z1 OUT NUMBER
                     , -- ��������� z1 =SLN+SLK+SL+SPN+SK9+SP+SN8
                      p_z2 OUT NUMBER
                     , -- ����.�������� � ����� z2 =SN+SN`+SK0
                      p_z3 OUT NUMBER
                     , -- <�����������> ��� ��������� (�������, ���������) ������ �� ����
                      p_z4 OUT NUMBER
                     , --�����  ������������� ������� = z4 =  z1 + z2 + z3
                      p_z5 OUT NUMBER
                     , -- �������� ������� �� ����  z5 = (SS - z3)
                      --
                      --== ����-���� <�������>
                      p_r1 OUT NUMBER
                     , -- ����� ������ (��� �� SG(2620)
                      p_r2 OUT NUMBER --  ��������� ������ R2 =  R1 - z4
                      );
  --------------------------------------------------
  PROCEDURE modi_pay
  (
    p_nd      IN NUMBER
   ,p_acc2620 IN NUMBER
  );
  --------------------------------------------------

  PROCEDURE modi_gpk(p_nd IN NUMBER); -- ��� ��.
  ---------------------------------------------------
   ---------------------
  PROCEDURE modi_ret
  (
    p_nd  IN cc_deal.nd%TYPE
   ,p_ref IN OUT oper.ref%TYPE
   ,p_ref2 IN OUT oper.ref%TYPE 
  ) ;

 PROCEDURE modi_ret_ex
  (
    p_nd   IN cc_deal.nd%TYPE
   ,p_ref  IN OUT oper.ref%TYPE
   ,p_mdat IN DATE
   ,p_ref2 IN OUT oper.ref%TYPE 
  ) ;

  PROCEDURE ret_gpk
  (
    p_nd   IN cc_deal.nd%TYPE
   ,p_ref  IN oper.ref%TYPE
   ,p_mdat IN DATE
  );
  ---------------------------------------------------
END;
/
CREATE OR REPLACE PACKAGE BODY cck_dpk IS

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
  ii    int_accn%ROWTYPE; -- ����.�������� ����� SS /II.basem=1 ��� �������. ����� ��������
  ir_   NUMBER; -- ����.������
  acc8_ accounts.accc%TYPE;
  datn_ DATE; -- ���� ��� ��
  datk_ DATE; -- ���� ����� ��
  lim1_ NUMBER; -- ������ �����
  lim2_ NUMBER; -- ����� �����
  kol_  INT;

  --����-���� <�������������>
  z1_  NUMBER; --��������� z1 =SLN+SLK+SL+SPN+SK9+SP+SN8(� ��_rang =10 ��� ����� ����� SS)
  z2k_ NUMBER; -- ����������            Z2K = �����  SK0
  z2n_ NUMBER; -- ����.��������         z2N = SN  + SN`
  z2_  NUMBER; -- ����.�������� � ����� z2  = Z2N + Z2K

  ss_ NUMBER; -- ������� �� ���� ����
  zn_ NUMBER; -- (SN` ��������� ���� �� ��� ��� �� ����� SS + SP )
  z3_ NUMBER; --<�����������> ��� ��������� (�������, ���������) ������ �� ����
  z4_ NUMBER; --�����  ������������� ������� = z4 =  z1 + z2 + z3
  z5_ NUMBER; -- �������� ������� �� ����  z5 = (SS - z3)  = TELO_  number;

  --����-���� <�������>
  r1_ NUMBER; -- ����� ������ (��� �� SG(2620/2625) R1
  r2_ NUMBER; -- ��������� ������ R2 =  R1 - z4
  rr1 oper%ROWTYPE;
  rr3 oper%ROWTYPE;
  --------------
  nls_8006 accounts.nls%TYPE;
  nls_6397 accounts.nls%TYPE;

  ---------------------------------------
  FUNCTION z8(p_nd cc_deal.nd%TYPE) RETURN INT IS
    -- �������� �� ��������������� ������ �� ��������� ����
    ll      cc_lim%ROWTYPE;
    plan_sp NUMBER;
    fakt_sp NUMBER;
  BEGIN
  
    BEGIN
      SELECT *
        INTO ll
        FROM cc_lim
       WHERE nd = p_nd
         AND fdat = (SELECT MAX(fdat)
                       FROM cc_lim
                      WHERE nd = p_nd
                        AND fdat < gl.bdate);
      SELECT least(ostc + ll.lim2, 0)
        INTO plan_sp
        FROM accounts
       WHERE acc = ll.acc;
    EXCEPTION
      WHEN no_data_found THEN
        RETURN 0; -- raise_application_error(-(20203), ' �� �������� ������������ ��� ��� �� ���=' || p_nd );
    END;
  
    SELECT nvl(SUM(a.ostc), 0)
      INTO fakt_sp
      FROM accounts a, nd_acc n
     WHERE a.acc = n.acc
       AND n.nd = p_nd
       AND tip = 'SP ';
    IF plan_sp <> fakt_sp THEN
      RETURN 0; --raise_application_error(-(20203), ' ������������ PLAN_SP �� FAKT_SP ��� �� ���=' || p_nd );
    END IF;
    RETURN 1;
  END z8;
  -----------------

  FUNCTION day_pl(p_nd cc_deal.nd%TYPE) RETURN INT IS
    -- ����������� K2_ number    ;  -- ��������� ����
    l_dat DATE;
    l_k2  INT;
  BEGIN
    BEGIN
      SELECT i.s
        INTO l_k2
        FROM int_accn i, accounts a, nd_acc n
       WHERE n.nd = p_nd
         AND n.acc = a.acc
         AND a.tip = 'LIM'
         AND a.acc = i.acc
         AND i.id = 0
         AND i.s > 0
         AND i.s <= 31;
    EXCEPTION
      WHEN no_data_found THEN
        SELECT MAX(fdat)
          INTO l_dat
          FROM cc_lim
         WHERE nd = p_nd
           AND fdat < gl.bd;
        IF l_dat IS NULL THEN
          SELECT nvl(MIN(fdat), gl.bd)
            INTO l_dat
            FROM cc_lim
           WHERE nd = p_nd
             AND fdat > gl.bd;
        END IF;
        l_k2 := to_number(to_char(l_dat, 'DD'));
    END;
  
    RETURN l_k2;
  
  END day_pl;

  ----------------------------
  -- �� ������������� ��� ��������� �������� � ������ �������
  PROCEDURE proc1
  (
    p_nd   IN NUMBER
   ,p_datn DATE
  ) IS
    l_acc     NUMBER;
    l_acra    NUMBER;
    l_accc    NUMBER;
    l_sump    NUMBER := 0;
    l_ost_sn  NUMBER;
    l_ost_ss  NUMBER;
    l_adat    DATE;
    l_dat31   DATE;
    l_fdat2   DATE;
    l_int     NUMBER := 0;
    l_daos    DATE;
    l_stp_dat DATE;
  BEGIN
    BEGIN
      --������� ���� � ��� ����.��������.
      SELECT i.acc
            ,i.acra
            ,a.accc
            ,greatest(nvl(i.acr_dat, a.daos - 1), a.daos - 1)
            ,a.daos
            ,a.ostc
            ,nvl(i.stp_dat, a.mdate - 1)
        INTO l_acc, l_acra, l_accc, l_adat, l_daos, l_ost_ss, l_stp_dat
        FROM accounts a, nd_acc n, int_accn i
       WHERE n.nd = p_nd
         AND n.acc = a.acc
         AND a.tip = 'SS '
         AND a.ostc < 0
         AND a.ostb = a.ostc
         AND i.acc = a.acc
         AND i.id = 0
         AND i.acra IS NOT NULL;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(- (20203)
                               ,' �� �������� ���.SS ��� �� ���=' || p_nd ||
                                ', ��� ���� ����.������'
                               ,TRUE);
    END;
  
    BEGIN
      SELECT sumo - sumg - nvl(sumk, 0)
        INTO l_sump
        FROM cc_lim
       WHERE nd = p_nd
         AND fdat = p_datn;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(- (20203)
                               ,'� ������ ��� �� �������� ��������� ��.���� ��� �� ���=' || p_nd
                               ,TRUE);
    END;
  
    IF cck_dpk.k0_ = 1 THEN
      ---------------------------------- 1-�������
    
      IF l_adat < least((p_datn - 1), l_stp_dat) THEN
        cck.int_metr_a(l_accc
                      ,l_acc
                      ,0
                      ,l_adat
                      ,least((p_datn - 1), l_stp_dat)
                      ,l_int
                      ,NULL
                      ,0);
      END IF; -- ���������� �� ��������
    
      l_ost_sn := fost(l_acra, gl.bdate) + l_int;
      UPDATE cc_lim
         SET sumo = sumo - l_sump + (-l_ost_sn)
       WHERE nd = p_nd
         AND fdat = p_datn;
    ELSE
      -- 0-�����
      -- ������ �� ���� � ���
      l_dat31 := trunc(gl.bdate, 'MM') - 1;
    
      IF l_daos > l_dat31 THEN
        acrn.p_int(l_acc
                  ,0
                  ,gl.bdate
                  ,least(add_months(l_dat31, 1), l_stp_dat)
                  ,l_int
                  ,NULL
                  ,0); -- ���������� ����������
        l_ost_sn := fost(l_acra, gl.bdate) + round(l_int, 0);
        UPDATE cc_lim
           SET sumo = sumo - l_sump + (-l_ost_sn)
         WHERE nd = p_nd
           AND fdat = p_datn; --�������� ��� ��� % 31� ������� ��� �����
        RETURN;
      END IF;
    
      l_ost_sn := fost(l_acra, l_dat31);
      UPDATE cc_lim
         SET sumo = sumo - l_sump + (-l_ost_sn)
       WHERE nd = p_nd
         AND fdat = p_datn; --�������� ��� ��� % 31� ������� ��� �����
    
      -- ������ �� ���� � ���
      acrn.p_int(l_acc
                ,0
                ,(l_dat31 + 1)
                ,least(add_months(l_dat31, 1), l_stp_dat)
                ,l_int
                ,NULL
                ,0); -- ���������� ����������
      l_int := round(l_int, 0);
      SELECT nvl(MIN(fdat), p_datn)
        INTO l_fdat2
        FROM cc_lim
       WHERE nd = p_nd
         AND fdat > p_datn;
      SELECT sumo - sumg - nvl(sumk, 0)
        INTO l_sump
        FROM cc_lim
       WHERE nd = p_nd
         AND fdat = l_fdat2;
      UPDATE cc_lim
         SET sumo = sumo - l_sump + (-l_int)
       WHERE nd = p_nd
         AND fdat = l_fdat2;
    
    END IF;
  
  END proc1;
  ------------------------------------

  -- ������� ��� �� ������ ����� - ��� ��������
  PROCEDURE rest_gpk(p_nd IN NUMBER) IS
    -- ������ ��.���� ������ ������� � ������� - ��� � ��. ����������� � ����������
    s_dd  CHAR(2);
    ntmp_ INT;
  
  BEGIN
  
    --CCK_DPK.PREV ( p_nd)   ; -- �������� �� ����������
    --cck_dpk.K1_ :=  0      ;  -- ����� ��� ���������� ���
    --cck_dpk.K3_ :=  1      ;  -- � ����������� ����� ������ �������
    -----------------------------
    BEGIN
    
      SELECT a8.acc
            ,least(-a8.ostx, -a8.ostc)
            ,a8.mdate
            ,decode(a8.vid, 4, 1, 0)
        INTO acc8_, lim2_, datk_, cck_dpk.k0_
        FROM accounts a8, nd_acc n8
       WHERE n8.nd = p_nd
         AND n8.acc = a8.acc
         AND a8.tip = 'LIM'
         AND a8.ostc = a8.ostb
         AND a8.ostb < 0;
    
      IF datk_ < gl.bdate THEN
        raise_application_error(- (20203)
                               ,' �� ���=' || p_nd || ' 100% ���������� ');
      END IF;
    
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(- (20203)
                               ,' �� �������� ���.8999 ��� �� ���=' || p_nd ||
                                ', ��� ���� ��= ����');
    END;
  
    IF lim2_ = 0 THEN
      raise_application_error(- (20203)
                             ,' �� ��������� ����� ��� ��� �� ���=' || p_nd
                             ,TRUE);
    END IF;
  
    BEGIN
      SELECT *
        INTO ii
        FROM int_accn
       WHERE acc = acc8_
         AND id = 0;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(- (20203)
                               ,' �� �������� ����.������(id=0) ��� ���.8999_' || p_nd);
    END;
  
    SELECT COUNT(*), MIN(fdat)
      INTO ntmp_, datn_
      FROM cc_lim
     WHERE nd = p_nd
       AND fdat < gl.bdate;
  
    IF ntmp_ > 1 THEN
      -- ������������ ��� ����� ������ ���� ���� ����
    
      SELECT MIN(fdat)
        INTO datn_
        FROM cc_lim
       WHERE nd = p_nd
         AND fdat >= gl.bdate;
    
      IF datn_ IS NULL THEN
        raise_application_error(- (20203)
                               ,'� ������������ ��� �� �������� ��������� ��.���� ��� �� ���=' || p_nd
                               ,TRUE);
      END IF;
    
      -- 11.06.2014 � ������ ��� ��� ����� ���� ������ � ��������� � ����� ����� � ����� � ���������, �� ��� ��� ������������� ��� ��������� � ������ ������� ������ ( �� �� ������� )----
      IF to_number(to_char(datn_, 'dd')) <> ii.s THEN
        datn_ := cck.f_dat(to_char(ii.s), trunc(gl.bdate, 'MM'));
      END IF;
    
    END IF;
  
    cck_dpk.modi_gpk(p_nd);
    SELECT MIN(fdat)
      INTO datn_
      FROM cc_lim
     WHERE nd = p_nd
       AND fdat >= gl.bdate;
  
  END rest_gpk;
  ------------------------------------
  -- ������� �������������� ���-�� ���o����, ��������, ��������� ���� �������  � ����� ���������
  PROCEDURE prev
  (
    p_nd      IN NUMBER
   ,p_acc2620 NUMBER
  ) IS
  
    -- ����������� ��������������� ������ ��� ������� ���������� ���������
    oo       oper%ROWTYPE;
    l_rnk    NUMBER; --dd cc_deal%rowtype ;
    nls_2924 VARCHAR2(15);
    s_       NUMBER := 0;
  BEGIN
    cck.cc_asg(-p_nd);
  
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
    NULL;
  END prev;

  ---------------------------------------
  PROCEDURE ref_2620
  (
    p_nd  IN NUMBER
   , -- ��� ��
    p_acc IN OUT NUMBER -- acc 262*
  ) IS
    -- �������� � ��=p_ND  ��������� �����  ���_2620
    -- ��� � ����-�������� ����� (���� p_ac�2620 = 0 ��� null)
    -- � ��������� ���.
    l_acc NUMBER;
    ntmp_ INT;
  
  BEGIN
    l_acc := nvl(p_acc, 0);
    BEGIN
      IF l_acc > 0 THEN
        SELECT 1
          INTO ntmp_
          FROM nd_acc
         WHERE nd = p_nd
           AND acc = l_acc;
        RETURN;
      ELSE
        SELECT a2.acc
          INTO l_acc
          FROM accounts a2, nd_acc n8, accounts a8
         WHERE a2.rnk = a8.rnk
           AND a2.kv = a8.kv
           AND a2.dazs IS NULL
           AND a2.nbs IN ('2620', '2625')
           AND n8.nd = p_nd
           AND n8.acc = a8.acc
           AND a8.dazs IS NULL
           AND a8.tip = 'LIM'
           AND rownum = 1;
      END IF;
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;
  
    IF l_acc > 0 THEN
      INSERT INTO nd_acc (nd, acc) VALUES (p_nd, l_acc);
      INSERT INTO cc_sob
        (nd, fdat, isp, txt, otm)
        SELECT p_nd
              ,gl.bdate
              ,gl.auid
              ,'���`����� �� � ���.' || a2.nls || '/' || a2.kv
              ,6
          FROM accounts a2
         WHERE acc = l_acc;
      p_acc := l_acc;
    END IF;
  
  END ref_2620;

  ---------------------------
  --DAT_MOD.����������� ���������� ���� ����������� ���
  FUNCTION dat_mod(p_nd cc_deal.nd%TYPE) RETURN cc_lim_arc.mdat%TYPE IS
    l_mdat cc_lim_arc.mdat%TYPE;
  BEGIN
    SELECT MAX(mdat)
      INTO l_mdat
      FROM cc_lim_arc
     WHERE nd = p_nd
       AND typm IS NOT NULL;
    RETURN l_mdat;
  END dat_mod;
  ------------------------------------------------------

  --Z1.����������� ����� ������ ���������
  FUNCTION sum_sp_all(p_nd cc_deal.nd%TYPE) RETURN NUMBER IS
    -- Z1_- ��������� z1 =SLN+SLK+SL+SPN+SK9+SP+SN8
  BEGIN
    SELECT -nvl(SUM(a.ostb), 0)
      INTO cck_dpk.z1_
      FROM accounts a, nd_acc n
     WHERE n.nd = p_nd
       AND n.acc = a.acc
       AND a.tip IN ('SP ', 'SL ', 'SPN', 'SK9', 'SLN', 'SLK', 'SN8');
    -- ������������� �����
    RETURN(cck_dpk.z1_);
  END sum_sp_all;

  -------------------------------------------------
  --Z2.����������� ����� ���� �������+����������� ( ��� ����� � ��� �����)
  FUNCTION sum_sn_all
  (
    p_vid INT
   ,p_nd  cc_deal.nd%TYPE
  ) RETURN NUMBER IS
    ko_ NUMBER := 1000000;
  BEGIN
  
    BEGIN
      -- Z2k_-  ����.�������� ������� �����
      SELECT -nvl(SUM(a.ostb), 0)
        INTO z2k_
        FROM accounts a, nd_acc n
       WHERE n.acc = a.acc
         AND n.nd = p_nd
         AND a.tip = 'SK0';
    
      SELECT i.*
        INTO ii
        FROM int_accn i, nd_acc n, accounts ss
       WHERE n.nd = p_nd
         AND n.acc = ss.acc
         AND ss.tip = 'SS '
         AND i.id = 0
         AND i.acc = ss.acc
         AND ss.ostb < 0;
    
      ii.stp_dat := least(nvl(ii.stp_dat, gl.bdate - 1), gl.bdate - 1);
    
      cck_dpk.acr_dat_ := ii.acr_dat;
      -- Z2n_-  ����.��������   ������� �����
      SELECT -ostb INTO z2n_ FROM accounts WHERE acc = ii.acra;
      z2_ := z2n_ + z2k_;
    EXCEPTION
      WHEN no_data_found THEN
        z2n_ := 0;
        z2_  := z2k_;
        RETURN z2_;
    END;
  
    -- ������� %
    IF ii.acr_dat >= ii.stp_dat THEN
      RETURN z2_;
    END IF; -- �� ��� �� ���������
    ir_ := acrn.fprocn(ii.acc, 0, gl.bdate);
    IF ir_ <= 0 THEN
      RETURN z2_;
    END IF;
  
    --ZN_ -- SN` ������� �����,= ��������� ���� �� ��� ��� �����������
    zn_ := 0;
  
    IF ii.stp_dat > ii.acr_dat THEN
      IF p_vid = 4 THEN
        -- ��� ��������
        BEGIN
          SELECT (lb.sumo - lb.sumg) * (ii.stp_dat - ii.acr_dat) /
                 (lb.fdat - lp.fdat)
            INTO zn_
            FROM cc_lim lb
                ,(SELECT MAX(fdat) fdat
                    FROM cc_lim
                   WHERE nd = p_nd
                     AND fdat <= ii.stp_dat) lp
           WHERE lb.nd = p_nd
             AND lb.fdat > lp.fdat
             AND lb.fdat = (SELECT MIN(fdat)
                              FROM cc_lim
                             WHERE nd = p_nd
                               AND fdat > ii.stp_dat);
        EXCEPTION
          WHEN no_data_found THEN
            zn_ := 0;
        END;
      ELSE
        SELECT nvl(SUM(calp(-fost(ii.acc, z.fdat) * ko_
                           ,ir_
                           ,z.fdat
                           ,z.fdat
                           ,ii.basey))
                  ,0) / ko_
          INTO zn_
          FROM (SELECT (ii.acr_dat) + c.num fdat
                  FROM conductor c
                 WHERE ii.acr_dat + c.num <= ii.stp_dat) z;
      END IF;
      zn_ := round(zn_, 0);
    END IF;
  
    -- �������-���� �� ������� ����
    DECLARE
      jj   int_accn%ROWTYPE;
      znp_ NUMBER;
    BEGIN
      SELECT j.*
        INTO jj
        FROM int_accn j, nd_acc n, accounts sp
       WHERE n.nd = p_nd
         AND n.acc = sp.acc
         AND sp.tip = 'SP '
         AND j.id = 0
         AND j.acc = sp.acc
         AND sp.dazs IS NULL;
    
      SELECT nvl(SUM(calp(-fost(jj.acc, z.fdat) * ko_
                         ,ir_
                         ,z.fdat
                         ,z.fdat
                         ,jj.basey))
                ,0) / ko_
        INTO znp_
        FROM (SELECT (jj.acr_dat) + c.num fdat
                FROM conductor c
               WHERE jj.acr_dat + c.num <= ii.stp_dat) z;
      zn_ := zn_ + round(znp_, 0);
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;
  
    -- ����� �����
    z2n_ := z2n_ + zn_;
    z2_  := z2n_ + z2k_;
    RETURN z2_;
  
  END sum_sn_all;
  -------------------------------------------------
  --Z3.����������� ����� ����.������� �� ����
  FUNCTION sum_ss_next(p_nd cc_deal.nd%TYPE) RETURN NUMBER IS
    l_del  NUMBER;
    l_sumg NUMBER;
  BEGIN
    z3_ := 0;
  
    BEGIN
      SELECT -a.ostx + a.ostb
        INTO l_del
        FROM accounts a, nd_acc n
       WHERE n.nd = p_nd
         AND n.acc = a.acc
         AND a.tip = 'LIM';
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(- (20203)
                               ,' �� ' || p_nd || ' �� �������� ���.LIM*');
    END;
  
    IF l_del < 0 THEN
      l_del := -l_del;
      BEGIN
        SELECT sumg
          INTO l_sumg
          FROM cc_lim
         WHERE nd = p_nd
           AND fdat = (SELECT MIN(fdat)
                         FROM cc_lim
                        WHERE nd = p_nd
                          AND fdat >= gl.bdate);
      EXCEPTION
        WHEN no_data_found THEN
          l_sumg := 0;
      END;
      z3_ := least(l_sumg, l_del);
    END IF;
  
    -- ����� �����
    RETURN(z3_);
  
  END sum_ss_next;

  -----------------------------------------

  /*  �������� .����� 1-�� ������� - ������������ ��� ����������� ����� 1-�� �������.
       ���� ����� �� ��������� ������� (��� ���.���)-��� ���� �����,
       � ��������� ������� � ������ ��� ���.
       !!! ����� ��� ����� ����� �������� � �������� ������ ���
  */

  FUNCTION prev_sum1(p_nd NUMBER) RETURN NUMBER IS
    cl   cc_lim%ROWTYPE;
    so1_ NUMBER;
    vid_ NUMBER;
  BEGIN
  
    SELECT a.vid
      INTO vid_
      FROM accounts a, nd_acc n
     WHERE n.nd = p_nd
       AND n.acc = a.acc
       AND a.tip = 'LIM';
  
    IF vid_ = 4 THEN
      cck_dpk.k0_ := 1;
    ELSE
      cck_dpk.k0_ := 0;
    END IF;
  
    BEGIN
      SELECT *
        INTO cl
        FROM cc_lim
       WHERE nd = p_nd
         AND fdat = (SELECT MIN(fdat)
                       FROM cc_lim
                      WHERE nd = p_nd
                        AND fdat >= gl.bdate);
      IF so1_ <= 0 THEN
        SELECT *
          INTO cl
          FROM cc_lim
         WHERE nd = p_nd
           AND fdat = (SELECT MAX(fdat)
                         FROM cc_lim
                        WHERE nd = p_nd
                          AND fdat < gl.bdate);
      END IF;
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;
  
    IF cck_dpk.k0_ = 1 THEN
      so1_ := cl.sumo;
    ELSE
      so1_ := cl.sumg;
    END IF;
  
    RETURN nvl(so1_, 0);
  
  END prev_sum1;
  -------------------------------------
  PROCEDURE plan_fakt(p_nd NUMBER) IS
    aa accounts%ROWTYPE;
  BEGIN
  
    BEGIN
      SELECT a.*
        INTO aa
        FROM nd_acc n, cc_deal d, accounts a
       WHERE d.nd = p_nd
         AND a.acc = n.acc
         AND n.nd = d.nd
         AND d.rnk = a.rnk
         AND a.dazs IS NULL
         AND rownum = 1
         AND a.ostc <> a.ostb
         AND a.nbs <> '2625';
      raise_application_error(- (20203)
                             ,'���.' || aa.nls ||
                              ' ������� ���� �� = ���� ');
    EXCEPTION
      WHEN no_data_found THEN
        NULL;
    END;
  
  END plan_fakt;
  -----

  PROCEDURE dpk(p_mode IN INT
               , -- 0 - �������,
                -- 1 - ��������� ���.+����������� ��� (121)
                -- 2 -         ������ ����������� ��� (122)
                p_nd      IN NUMBER
               , -- ��� ��
                p_acc2620 IN NUMBER
               , -- ���� ������� (2620/2625/SG)
                --=== ���� ����� ���.
                p_k0 IN OUT NUMBER
               , -- 1-�������. 0 - �����
                p_k1 IN NUMBER
               , -- <����� ��� ���������� ���>, �� ����� = R2,
                p_k2 IN NUMBER
               , -- <��������� ����>, �� ���� = DD �� �������� ����.���
                p_k3 IN NUMBER
               , -- 1=�� ,<� ����������� ����� ������ �������?>
                -- 2=��� (� ������������ ����� �� ��������� ��������� ����)
                --
                --==--����-���� <�������������>
                p_z1 OUT NUMBER
               , -- ��������� z1 =SLN+SLK+SL+SPN+SK9+SP+SN8
                p_z2 OUT NUMBER
               , -- ����.�������� � ����� z2 =SN+SN`+SK0
                p_z3 OUT NUMBER
               , -- <�����������> ��� ��������� (�������, ���������) ������ �� ����
                p_z4 OUT NUMBER
               , --�����  ������������� ������� = z4 =  z1 + z2 + z3
                p_z5 OUT NUMBER
               , -- �������� ������� �� ����  z5 = (SS - z3)
                --
                --== ����-���� <�������>
                p_r1 OUT NUMBER
               , -- ����� ������ (��� �� SG(262*)
                p_r2 OUT NUMBER
               , --  ��������� ������ R2 =  R1 - z4
                p_p1 OUT NUMBER --  ���.�������
                , p_p2      OUT NUMBER
                ) IS
    ------------------------
  BEGIN
  
    /*
    declare p_mode int := 1; p_ND  number := 7688;  p_K0  number := 0; p_K1  number := 1000000; p_K2  number := 24; p_K3  number := 0;
     p_Z1  number; p_Z2  number;  p_Z3  number;  p_Z4  number; p_Z5  number;  p_R1  number;  p_R2  number;  p_P1  number ;
    begin tuda;  CCK_dpk.dpk ( p_mode, p_ND, p_K0, p_K1, p_K2, p_K3, p_Z1,  p_Z2,  p_Z3,  p_Z4,  p_Z5,  p_R1,  p_R2, p_P1) ;
    logger.info ( 'DPK*' || p_Z1 ||','||  p_Z2 ||','||  p_Z3 ||','||  p_Z4 ||','||  p_Z5 ||','|| p_R1 ||','||  p_R2  ||','||  p_P1);
    end;
    */
  
    p_p1        := NULL;
    p_p2        := NULL;
    cck_dpk.k2_ := nvl(p_k2, to_number(to_char(gl.bdate, 'DD')));
    cck_dpk.k3_ := nvl(p_k3, 1);
    cck_dpk.modi_info(p_mode
                     ,p_nd
                     ,p_acc2620
                     ,p_z1
                     ,p_z2
                     ,p_z3
                     ,p_z4
                     ,p_z5
                     ,p_r1
                     ,p_r2);
    p_k0 := cck_dpk.k0_;
    ---------------------------------
    IF p_mode = 0 THEN
      -- ������ �������.
      NULL;
      RETURN;
    END IF;
  
    cck_dpk.plan_fakt(p_nd); -- �������� �� ���������� �������� � ������ ��������
  
    IF p_mode = 1 THEN
      -- ��������� ��������� + ��������� ���.
    
      IF nvl(p_k1, 0) <= 1 THEN
        bars_error.raise_nerror(p_errmod  => 'CCK'
                               ,p_errname => 'SUM_POG'
                               ,p_param1  => to_char(p_nd)
                               ,p_param2  => to_char(p_k1 / 100));
      END IF;
      cck_dpk.k1_ := p_k1 + z3_;
      lim2_       := z5_ - p_k1;
    
      cck_dpk.modi_pay(p_nd, p_acc2620);
    
      IF z5_ > 0 THEN
        cck_dpk.modi_gpk(p_nd);
        p_p1 := rr1.ref;
      END IF;
      IF z5_ > 0 THEN
        cck_dpk.modi_gpk(p_nd);
        p_p2 := rr3.ref;
      END IF;
    ELSIF p_mode = 2 THEN
      -- ������ ��������� ���, ��� ���������� ���������.
      cck_dpk.k1_ := 0; -- ����� ��� ���������� ���
      cck_dpk.rest_gpk(p_nd => p_nd);
    END IF;
  
    RETURN;
  
  END dpk;
  -----------------
  PROCEDURE modi_info(p_mode IN INT
                     , -- 0 - �������, ��� ����������
                      -- 1 - ��������� ���.+����������� ���
                      -- 2 - ������ ����������� ���
                      p_nd      IN NUMBER
                     , -- ��� ��
                      p_acc2620 IN NUMBER
                     , -- ���� ������� (2620/2625/SG)
                      --==--����-���� <�������������>
                      p_z1 OUT NUMBER
                     , -- ��������� z1 =SLN+SLK+SL+SPN+SK9+SP+SN8
                      p_z2 OUT NUMBER
                     , -- ����.�������� � ����� z2 =SN+SN`+SK0
                      p_z3 OUT NUMBER
                     , -- <�����������> ��� ��������� (�������, ���������) ������ �� ����
                      p_z4 OUT NUMBER
                     , --�����  ������������� ������� = z4 =  z1 + z2 + z3
                      p_z5 OUT NUMBER
                     , -- �������� ������� �� ����  z5 = (SS - z3)
                      --
                      --== ����-���� <�������>
                      p_r1 OUT NUMBER
                     , -- ����� ������ (��� �� SG(262*)
                      p_r2 OUT NUMBER --  ��������� ������ R2 =  R1 - z4
                      ) IS
  
    mdat_    DATE;
    vid_     INT;
    ostb_    NUMBER;
    ostc_    NUMBER;
    nbs_2620 accounts.nbs%TYPE;
    nls_2620 accounts.nls%TYPE;
    nls_8999 accounts.nls%TYPE;
    nls_2203 accounts.nls%TYPE;
  
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
  
    SELECT MAX(mdat)
      INTO mdat_
      FROM cc_lim_arc
     WHERE nd = p_nd
       AND typm = 'CCKD';
    IF mdat_ >= gl.bdate
       AND p_mode > 0 THEN
      raise_application_error(- (20203)
                             ,' �� ' || p_nd || ' ��� ��� � � ����� �� ' ||
                              to_char(gl.bdate, 'dd.mm.yyyy'));
    END IF;
    --------------------------------------
    -- ����� ���
    BEGIN
      -- R1. ����� ������ (��� �� 2620/2625/SG)
      SELECT a.nbs, a.ostb, a.ostb, a.ostc, a.nls
        INTO nbs_2620, r1_, ostb_, ostc_, nls_2620
        FROM accounts a, nd_acc n
       WHERE n.nd = p_nd
         AND n.acc = a.acc
         AND a.acc = p_acc2620;
      IF nbs_2620 <> '2625'
         AND p_mode = 1
         AND ostb_ <> ostc_ THEN
        raise_application_error(- (20203)
                               ,' �� ' || p_nd || ' ���.' || nls_2620 ||
                                ': ����.��� �� = ����.���');
      END IF;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(- (20203)
                               ,' �� ' || p_nd ||
                                ' �� �������� ��� ��� �������� ACC=' ||
                                p_acc2620);
    END;
  
    BEGIN
      --������������ �������� � ���� ��� 8999*
      SELECT a.acc, a.vid, a.ostb, a.ostc, a.nls
        INTO acc8_, vid_, ostb_, ostc_, nls_8999
        FROM accounts a, nd_acc n
       WHERE n.nd = p_nd
         AND n.acc = a.acc
         AND a.tip = 'LIM'
         AND a.ostb < 0;
      IF ostb_ <> ostc_
         AND p_mode IN (1, 2)
         AND nbs_2620 <> '2625' THEN
        raise_application_error(- (20203)
                               ,' �� ' || p_nd || ' ���.' || nls_8999 ||
                                ': ����.��� �� = ����.���');
      END IF;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(- (20203)
                               ,' �� ' || p_nd || ' �� �������� ��� 8999*');
    END;
  
    BEGIN
      -- SS. ������� �� ���� ����
      SELECT -a.ostb, a.nls, a.ostb, a.ostc
        INTO ss_, nls_2203, ostb_, ostc_
        FROM accounts a, nd_acc n
       WHERE n.nd = p_nd
         AND n.acc = a.acc
         AND a.tip = 'SS '
         AND a.ostb < 0;
      IF ostb_ <> ostc_
         AND p_mode = 1 THEN
        raise_application_error(- (20203)
                               ,' �� ' || p_nd || ' ���.' || nls_2203 ||
                                ': ����.��� �� = ����.���');
      END IF;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(- (20203)
                               ,' �� ' || p_nd || ' �� �������� ���.SS*');
    END;
    SELECT MIN(fdat), MAX(fdat)
      INTO datn_, datk_
      FROM cc_lim
     WHERE nd = p_nd;
    ----------------------------
  
    -- ��������������� �������� �������� ��-������
    IF vid_ = 4 THEN
      cck_dpk.k0_ := 1;
      ii.basem    := 1;
      ii.basey    := 2;
    ELSE
      cck_dpk.k0_ := 0;
    END IF;
    ---------------------------------
    -- �����  ������������� ������� = z4 =  z1 + z2 + z3
    -- (Z1_���������) + (Z2_��������_�_�����_����_�_�����) + (Z3_����.������)
    cck_dpk.z1_ := cck_dpk.sum_sp_all(p_nd);
    cck_dpk.z2_ := cck_dpk.sum_sn_all(vid_, p_nd);
    cck_dpk.z3_ := cck_dpk.sum_ss_next(p_nd);
    cck_dpk.z4_ := cck_dpk.z1_ + cck_dpk.z2_ + cck_dpk.z3_;
  
    cck_dpk.z5_ := cck_dpk.ss_ - cck_dpk.z3_; -- �������� ������� �� ����  z5 = (SS - z3)
    cck_dpk.r2_ := cck_dpk.r1_ - cck_dpk.z4_; -- ��������� ������ R2 =  R1 - z4
    ----------------------------------
    IF cck_dpk.z1_ < 0
       AND p_mode IN (1) THEN
      -- �� ���=%s ���� ���������.��������.
      bars_error.raise_nerror(p_errmod  => 'CCK'
                             ,p_errname => 'YES_SP'
                             ,p_param1  => to_char(p_nd)
                             ,p_param2  => to_char(-cck_dpk.z1_ / 100));
    END IF;
    ----------------------------------
  
    IF cck_dpk.r2_ <= 0
       AND p_mode IN (1)
       AND nbs_2620 <> '2625' THEN
      --�� ���=%s ��������� �������
      bars_error.raise_nerror(p_errmod  => 'CCK'
                             ,p_errname => 'FREE_SG'
                             ,p_param1  => to_char(p_nd)
                             ,p_param2  => '�i����� ���.=' ||
                                           to_char(cck_dpk.r2_ / 100));
    END IF;
    ----------------------------
    p_z1 := cck_dpk.z1_;
    p_z2 := cck_dpk.z2_;
    p_z3 := cck_dpk.z3_;
    p_z4 := cck_dpk.z4_;
    p_z5 := cck_dpk.z5_;
    p_r1 := cck_dpk.r1_;
    p_r2 := cck_dpk.r2_;
  
  END modi_info;
  ----------------------------------------
 PROCEDURE modi_pay
  (
    p_nd      IN NUMBER
   ,p_acc2620 IN NUMBER
  ) IS
    rr2      oper%ROWTYPE;
    dd       cc_deal%ROWTYPE;
    ostc_    NUMBER;
    ostb_    NUMBER;
    l_tt     tts.tt%TYPE; -- ��� �������� ��� ����.�����. ��������� ��������!
    nls_2924 accounts.nls%TYPE;
  BEGIN
    BEGIN
      SELECT d.cc_id
            ,d.sdate
            ,c.okpo
            ,sg.nls
            ,substr(sg.nms, 1, 38)
            ,sg.kv
            ,ss.nls
            ,substr(ss.nms, 1, 38)
            ,ss.ostc
            ,ss.ostb
            ,substr('���������� ����� �� � ' || d.cc_id || ' �i� ' ||
                    to_char(d.sdate, 'dd.mm.yyyy') ||
                    '. ( ǳ ����������� ' ||
                    decode(cck_dpk.k3_
                          ,1
                          ,'���� 1-�� �������'
                          ,'�i������� ����i��') || ' )'
                   ,1
                   ,160)
                   ,substr('���������� ����� �����%'
                                 ,1
                                 ,160)
        INTO dd.cc_id
            ,dd.sdate
            ,rr1.id_a
            ,rr1.nlsa
            ,rr1.nam_a
            ,rr1.kv
            ,rr1.nlsb
            ,rr1.nam_b
            ,ostc_
            ,ostb_
            ,rr1.nazn
            ,rr3.nazn
        FROM accounts sg
            ,nd_acc   nsg
            ,accounts ss
            ,nd_acc   nss
            ,customer c
            ,cc_deal  d
       WHERE d.nd = p_nd
         AND d.rnk = c.rnk
         AND nsg.nd = d.nd
         AND nsg.acc = sg.acc
         AND sg.acc = p_acc2620
         AND sg.dazs IS NULL
         AND nss.nd = d.nd
         AND nss.acc = ss.acc
         AND ss.tip = 'SS '
         AND ss.dazs IS NULL;
    
      IF ostc_ <> ostb_ THEN
        bars_error.raise_nerror(p_errmod  => 'CCK'
                               ,p_errname => 'PLAN#FAKT'
                               ,p_param1  => to_char(p_nd)
                               ,p_param2  => rr1.nlsb);
      END IF;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(- (20203)
                               ,'�� �������� ���. p_acc2620=' || p_acc2620 ||
                                ' ��� SS �� �� =' || p_nd);
    END;
  
    --- ��� ������� � ��� %
    BEGIN
      SELECT sn.nls
            ,sd.nls
            ,substr(sn.nms, 1, 38)
            ,substr(sd.nms, 1, 38)
            ,sn.kv
            ,sd.kv
            ,-sn.ostb
        INTO rr2.nlsa
            ,rr2.nlsb
            ,rr2.nam_a
            ,rr2.nam_b
            ,rr2.kv
            ,rr2.kv2
            ,rr2.s
        FROM accounts sn, accounts sd
       WHERE sn.acc = ii.acra
         AND sd.acc = ii.acrb
         AND sn.dazs IS NULL
         AND sd.dazs IS NULL;
    EXCEPTION
      WHEN no_data_found THEN
        raise_application_error(- (20203)
                               ,'�� �������� ���. � ����.������ �� � ');
    END;
  
    IF ii.acr_dat < nvl(ii.stp_dat, (gl.bdate - 1))
       AND zn_ > 0 THEN
    
      -- ����������� %  ZN
      gl.ref(rr2.ref);
      gl.in_doc3(ref_   => rr2.ref
                ,tt_    => '%%1'
                ,vob_   => 6
                ,nd_    => substr(to_char(rr2.ref), -10)
                ,pdat_  => SYSDATE
                ,vdat_  => gl.bdate
                ,dk_    => 1
                ,kv_    => rr2.kv
                ,s_     => zn_
                ,kv2_   => rr2.kv
                ,s2_    => zn_
                ,sk_    => NULL
                ,data_  => gl.bdate
                ,datp_  => gl.bdate
                ,nam_a_ => rr2.nam_a
                ,nlsa_  => rr2.nlsa
                ,mfoa_  => gl.amfo
                ,nam_b_ => rr2.nam_b
                ,nlsb_  => rr2.nlsb
                ,mfob_  => gl.amfo
                ,nazn_  => substr('������������� �i�����i� � ' ||
                                  to_char(ii.acr_dat + 1, 'dd.mm.yyyy') ||
                                  ' �� ' ||
                                  to_char(ii.stp_dat, 'dd.mm.yyyy') ||
                                  ' � ��`���� � ����������� ����� �� � ' ||
                                  dd.cc_id || ' �i� ' ||
                                  to_char(dd.sdate, 'dd.mm.yyyy')
                                 ,1
                                 ,160)
                ,d_rec_ => NULL
                ,id_a_  => rr1.id_a
                ,id_b_  => gl.aokpo
                ,id_o_  => NULL
                ,sign_  => NULL
                ,sos_   => 1
                ,prty_  => NULL
                ,uid_   => NULL);
    rr3.nazn:=substr(rr3.nazn||' � ' ||
                                  to_char(ii.acr_dat + 1, 'dd.mm.yyyy') ||
                                  ' �� ' ||
                                  to_char(ii.stp_dat, 'dd.mm.yyyy') ||
                                  ' � ��`���� � ����������� ����� �� � ' ||
                                  dd.cc_id || ' �i� ' ||
                                  to_char(dd.sdate, 'dd.mm.yyyy'),1,160);
      gl.payv(0
             ,rr2.ref
             ,gl.bdate
             ,'%%1'
             ,1
             ,rr2.kv
             ,rr2.nlsa
             ,zn_
             ,rr2.kv2
             ,rr2.nlsb
             ,zn_);
    
      -- ���������� ����, �� ��� % ��� ���������
      UPDATE int_accn
         SET acr_dat = nvl(ii.stp_dat, (gl.bdate - 1))
       WHERE id = 0
         AND acc IN (SELECT a.acc
                       FROM nd_acc n, accounts a
                      WHERE n.nd = p_nd
                        AND n.acc = a.acc
                        AND tip IN ('SS ', 'SP '));
      gl.pay(2, rr2.ref, gl.bdate);
    END IF;
    -----------------------------------------------
    --- ����� ����� �������� �� ���� CCK_DPK.K1_
    --  +  �������� ��� %%                   Z2N_
    --  +  �������� ��� �����                Z2K_,
    --  +  �������� ��� ���������            Z1_ - ������ ��� ���  - ����� �� �����, ��� �� �������� ���������� �����
  
    IF rr1.nlsa LIKE '2625%' THEN
      l_tt  := cck_dpk.tt_w4;
      rr1.s := cck_dpk.k1_ +/* cck_dpk.z2n_ +*/ cck_dpk.z2k_ + cck_dpk.z1_; -- 29.05.2015*/
      
      rr3.s := cck_dpk.z2n_ ; 
    ELSE
      l_tt  := 'ASD';
      rr1.s := cck_dpk.k1_ /*+ cck_dpk.z2n_ */+ cck_dpk.z2k_;
      rr3.s := /*cck_dpk.k1_ + */cck_dpk.z2n_ ;
    END IF;
    /*
    logger.info('AAAA ' || RR1.nlsa  ||' ' || l_tt ||
       ' K1_=' || CCK_DPK.K1_  ||
    ' + Z2N_=' || cck_dpk.Z2N_ ||
    ' + Z2K_=' || cck_dpk.Z2K_ ||
    ' + Z1_='  || cck_dpk.Z1_  ||
    '= rr1.S=' || rr1.S );
    */
  
    IF rr1.s <= 0 THEN
      RETURN;
    END IF;
--��������� �� ��� ����������  
    gl.ref(rr1.ref);
    gl.ref(rr3.ref);
    gl.in_doc3(ref_   => rr1.ref
              ,tt_    => l_tt
              ,vob_   => 1
              ,nd_    => substr(dd.cc_id, 1, 10)
              ,pdat_  => SYSDATE
              ,vdat_  => gl.bdate
              ,dk_    => 1
              ,kv_    => rr1.kv
              ,s_     => rr1.s
              ,kv2_   => rr1.kv
              ,s2_    => rr1.s
              ,sk_    => NULL
              ,data_  => gl.bdate
              ,datp_  => gl.bdate
              ,nam_a_ => rr1.nam_a
              ,nlsa_  => rr1.nlsa
              ,mfoa_  => gl.amfo
              ,nam_b_ => rr1.nam_b
              ,nlsb_  => rr1.nlsb
              ,mfob_  => gl.amfo
              ,nazn_  => rr1.nazn
              ,d_rec_ => NULL
              ,id_a_  => rr1.id_a
              ,id_b_  => rr1.id_a
              ,id_o_  => NULL
              ,sign_  => NULL
              ,sos_   => 1
              ,prty_  => NULL
              ,uid_   => NULL);
  gl.in_doc3(ref_   => rr3.ref
              ,tt_    => l_tt
              ,vob_   => 1
              ,nd_    => substr(dd.cc_id, 1, 10)
              ,pdat_  => SYSDATE
              ,vdat_  => gl.bdate
              ,dk_    => 1
              ,kv_    => rr1.kv
              ,s_     => rr3.s
              ,kv2_   => rr1.kv
              ,s2_    => rr3.s
              ,sk_    => NULL
              ,data_  => gl.bdate
              ,datp_  => gl.bdate
              ,nam_a_ => rr1.nam_a
              ,nlsa_  => rr1.nlsa
              ,mfoa_  => gl.amfo
              ,nam_b_ => rr1.nam_b
              ,nlsb_  => rr1.nlsb
              ,mfob_  => gl.amfo
              ,nazn_  => rr3.nazn
              ,d_rec_ => NULL
              ,id_a_  => rr1.id_a
              ,id_b_  => rr1.id_a
              ,id_o_  => NULL
              ,sign_  => NULL
              ,sos_   => 1
              ,prty_  => NULL
              ,uid_   => NULL);             
    INSERT INTO operw
      (REF, tag, VALUE)
    VALUES
      (rr1.ref, 'ND   ', to_char(p_nd)); -- ���� ������������ ��������� DD.MM.YYYY
    INSERT INTO operw
      (REF, tag, VALUE)
    VALUES
      (rr1.ref, 'MDATE', to_char(gl.bdate, 'dd.mm.yyyy')); -- ��� K�
  
    IF l_tt = cck_dpk.tt_w4 THEN
      nls_2924 := bpk_get_transit('20', rr1.nlsb, rr1.nlsa, rr1.kv);
      gl.payv(0
             ,rr1.ref
             ,gl.bdate
             ,l_tt
             ,1
             ,rr1.kv
             ,rr1.nlsa
             ,rr1.s
             ,rr1.kv
             ,nls_2924
             ,rr1.s); ---------- �������� ��������
    
      IF cck_dpk.z1_ > 0 THEN
        -- 29.05.2015 ��������� � ��� �� ��� =  -NVL(sum(a.ostb),0) into cck_dpk.Z1_  -- ������������� �����
      
        FOR x IN (SELECT a.*
                    FROM accounts a, nd_acc n
                   WHERE n.nd = p_nd
                     AND n.acc = a.acc
                     AND ostb < 0
                     AND a.kv = rr1.kv
                     AND (a.tip IN
                         ('SP ', 'SL ', 'SPN', 'SK9', 'SLN', 'SLK') OR
                         a.tip IN ('SN8') AND rr1.kv = gl.baseval))
        LOOP
          IF x.tip = 'SPN' THEN
            rr1.d_rec := '��������� ����������� �i�����i�';
          ELSIF x.tip = 'SK9' THEN
            rr1.d_rec := '��������� ���������� ���i�i�';
          ELSIF x.tip = 'SP ' THEN
            rr1.d_rec := '��������� ������������ ���.�����';
          ELSIF x.tip = 'SL ' THEN
            rr1.d_rec := '��������� ����i����� ���.�����';
          ELSIF x.tip = 'SLN' THEN
            rr1.d_rec := '��������� ����i����� ����.�����';
          ELSIF x.tip = 'SLK' THEN
            rr1.d_rec := '��������� ����i����� ���i�.�����';
          ELSIF x.tip = 'SN8' THEN
            rr1.d_rec := '��������� ���i';
            gl.payv(0
                   ,rr1.ref
                   ,gl.bdate
                   ,'ASG'
                   ,1
                   ,x.kv
                   ,cck_dpk.nls_8006
                   ,-x.ostb
                   ,x.kv
                   ,x.nls
                   ,-x.ostb); -- ����������� ����
            x.nls := cck_dpk.nls_6397;
          END IF;
        
          gl.payv(0
                 ,rr1.ref
                 ,gl.bdate
                 ,l_tt
                 ,1
                 ,rr1.kv
                 ,nls_2924
                 ,-x.ostb
                 ,rr1.kv
                 ,x.nls
                 ,-x.ostb);
          UPDATE opldok
             SET txt = rr1.d_rec
           WHERE REF = rr1.ref
             AND stmt = gl.astmt;
        
        END LOOP;
      END IF;
    ELSE
      nls_2924 := rr1.nlsa;
    END IF;
  
    IF cck_dpk.k1_ > 0 THEN
      ---- ������� �������� �� 2203
      gl.payv(0
             ,rr1.ref
             ,gl.bdate
             ,l_tt
             ,1
             ,rr1.kv
             ,nls_2924
             ,rr1.s
             ,rr1.kv
             ,rr1.nlsb
             ,rr1.s);
      UPDATE opldok
         SET txt = 'K1. ���� ��� ������������ ���������'
       WHERE REF = rr1.ref
         AND stmt = gl.astmt;
    END IF;
  
    IF cck_dpk.z2n_ > 0 THEN
      ---- ������� �������� �� 2208
      gl.payv(0
             ,rr3.ref
             ,gl.bdate
             ,l_tt
             ,1
             ,rr1.kv
             ,nls_2924
             ,rr3.s
             ,rr1.kv
             ,rr2.nlsa
             ,rr3.s);
      UPDATE opldok
         SET txt = 'Z2N_. �������� ��� %%'
       WHERE REF = rr3.ref
         AND stmt = gl.astmt;
    END IF;
  
    IF cck_dpk.z2k_ > 0 THEN
      ---- ������� �������� �� 3578
      BEGIN
        SELECT sk.nls, sk.kv, -sk.ostb
          INTO rr2.nlsa, rr2.kv, rr2.s
          FROM accounts sk, nd_acc n
         WHERE sk.acc = n.acc
           AND sk.tip = 'SK0'
           AND sk.ostb < 0
           AND n.nd = p_nd
           AND sk.kv = rr1.kv
           AND rownum = 1;
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
          raise_application_error(- (20203)
                                 ,'�� �������� ���. � tip = SK0');
      END;
       
        gl.payv(0
             ,rr1.ref
             ,gl.bdate
             ,l_tt
             ,1
             ,rr1.kv
             ,rr1.nlsa
             ,cck_dpk.z2k_
             ,rr1.kv
             ,rr2.nlsa
             ,cck_dpk.z2k_);      
      UPDATE opldok
         SET txt = 'Z2K_ �������� ��� �����'
       WHERE REF = rr1.ref
         AND stmt = gl.astmt;
    END IF;
  
  END modi_pay;
  --------------

  PROCEDURE modi_gpk(p_nd IN NUMBER) IS
    -- ��� ��.
    sum1_    NUMBER;
    l_gpk    NUMBER;
    l_txt    CHAR(2);
    l_basem  INT;
    datk_new DATE;
  BEGIN
  
    IF cck_dpk.k0_ = 1 THEN
      l_gpk   := 4;
      l_txt   := '90';
      l_basem := 1; -- 1 -�������, ��� ������, % �� ��������� ����
    ELSE
      l_gpk   := 2;
      l_txt   := '91';
      l_basem := 0; -- 0- �����, ��� ������, % �� ��������� �����
    END IF;
  
    ir_ := acrn.fprocn(ii.acc, 0, gl.bdate);
  
    IF cck_dpk.k1_ > 0 THEN
      -- ���� ����� ���������� ��������� ������� => ������ ������ gl.bdate = ������ ������ ���
      datn_ := greatest(datn_, gl.bdate);
    ELSE
      --11.06.2014 �������
      SELECT nvl(MAX(fdat), gl.bdate)
        INTO datn_
        FROM cc_lim
       WHERE nd = p_nd
         AND fdat <= gl.bdate;
    END IF;
  
    ----- ����� 1-�� ��
    sum1_ := cck.f_pl1(p_nd   => p_nd
                      ,p_lim2 => lim2_
                      , -- ����� �����
                       p_gpk  => l_gpk
                      , -- 4-�������. 2 - ����� ( -- 1-�������. 0 - �����   )
                       p_dd   => cck_dpk.k2_
                      , -- <��������� ����>, �� ���� = DD �� �������� ����.���
                       p_datn => datn_
                      , -- ���� ��� ��
                       p_datk => datk_
                      , -- ���� ����� ��
                       p_ir   => ir_
                      , -- ����.������
                       p_ssr  => cck_dpk.k3_ -- ������� =0= "� ����������� �����"
                       );
  
    -- ��������� ��� � �����
    DELETE FROM cc_lim_arc
     WHERE nd = p_nd
       AND mdat = gl.bdate;
  
    INSERT INTO cc_lim_arc
      (nd
      ,mdat
      ,fdat
      ,lim2
      ,acc
      ,not_9129
      ,sumg
      ,sumo
      ,otm
      ,sumk
      ,not_sn
      ,typm)
      SELECT nd
            ,gl.bdate
            ,fdat
            ,lim2
            ,acc
            ,not_9129
            ,sumg
            ,sumo
            ,otm
            ,sumk
            ,not_sn
            ,'CCKD'
        FROM cc_lim
       WHERE nd = p_nd;
  
    IF cck_dpk.k1_ > 0 THEN
      -- ���� ����� ���������� ��������� ������� => ������ ������ gl.bdate = ������ ������ ���
      UPDATE cc_lim
         SET sumg = sumg + cck_dpk.k1_
            ,sumo = sumo + cck_dpk.k1_
            ,lim2 = lim2_
       WHERE nd = p_nd
         AND fdat = gl.bdate;
      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO cc_lim
          (nd, fdat, lim2, acc, sumg, sumo, otm, sumk)
        VALUES
          (p_nd
          ,gl.bdate
          ,lim2_
          ,acc8_
          ,cck_dpk.k1_
          ,cck_dpk.k1_ + z2n_
          ,1
          ,0);
      END IF;
    END IF;
  
    DELETE FROM cc_lim
     WHERE nd = p_nd
       AND fdat > gl.bdate;
  
    --�������� ����� ����� �� ���� ����
    cck.uni_gpk_fl(p_lim2  => lim2_
                  , -- ����� �����
                   p_gpk   => l_gpk
                  , -- 4-�������. 2 - ����� ( -- 1-�������. 0 - �����   )
                   p_dd    => cck_dpk.k2_
                  , -- <��������� ����>, �� ���� = DD �� �������� ����.���
                   p_datn  => datn_
                  , -- ���� ��� ��
                   p_datk  => datk_
                  , -- ���� ����� ��
                   p_ir    => ir_
                  , -- ����.������
                   p_pl1   => sum1_
                  , -- ����� 1 ��
                   p_ssr   => cck_dpk.k3_
                  , -- ������� =0= "� ����������� �����"
                   p_ss    => ss_
                  , -- ������� �� ���� ����
                   p_acrd  => ii.acr_dat + 1
                  , -- � ����� ���� ��������� % acr_dat+1
                   p_basey => ii.basey -- ���� ��� ��� %%;
                   );
    --commit;
  
    INSERT INTO cc_lim
      (nd, fdat, lim2, acc, sumg, sumo, sumk)
      SELECT p_nd, fdat, lim2, acc8_, sumg, sumo, nvl(sumk, 0)
        FROM tmp_gpk
       WHERE fdat > gl.bdate;
  
    -- 11.06.2014 + 21.11.2014 + 02.12.2014 �������� ���� � ������ ��.������
    IF cck_dpk.k1_ = 0
       AND datn_ <= gl.bdate THEN
    
      DECLARE
        dtmpg_ DATE;
        dtmp1_ DATE; -- 01.10.2014 (21.10.2014) \
        dtmp2_ DATE; -- 31.10.2014              / ������� ���
        dtmp3_ DATE; -- 01.11.2014 \
        dtmp4_ DATE; -- 04.11.2014 / ���.��� ����� - 1
        dtmp5_ DATE; -- 05 11.2014 \
        dtmp6_ DATE; -- 30.11.2014 / ���.��� ����� -2
      
        gg  cc_lim%ROWTYPE;
        si_ NUMBER;
        s1_ NUMBER;
        s2_ NUMBER;
      BEGIN
      
        IF l_gpk = 2 THEN
          -- 4-�������. 2 - ����� ( -- 1-�������. 0 - �����   )
        
          -- ��� 1-� �� ���� -- ������ �� ��������, �.�. ������ ���������� - ������ � �������
          dtmp1_ := trunc(add_months(gl.bdate, -1), 'MM'); -- 01 ����� ���� ���
          dtmp2_ := trunc(gl.bdate, 'MM') - 1; -- 31 ����� ����.���
          acrn.p_int(acc8_, 0, dtmp1_, dtmp2_, si_, NULL, 0);
          si_ := -round(si_, 0);
          SELECT MIN(fdat)
            INTO dtmpg_
            FROM cc_lim
           WHERE nd = p_nd
             AND fdat > dtmp2_;
          UPDATE cc_lim
             SET sumo = sumg + si_
           WHERE nd = p_nd
             AND fdat = dtmpg_;
        
          -- ��� 2-� �� ����
          ------------------ ����� 1 -- ������ �� ��������
          dtmp3_ := dtmp2_ + 1; -- 01 ����� ���.���
          SELECT MIN(fdat) - 1
            INTO dtmp4_
            FROM cc_lim
           WHERE nd = p_nd
             AND fdat > dtmp3_; -- ��.����-1  ���.���
          acrn.p_int(acc8_, 0, dtmp3_, dtmp4_, si_, NULL, 0);
          s1_ := -round(si_, 0);
        
          ------------------ ����� 2 -- ������
          dtmp5_ := dtmp4_ + 1; -- ���.��� ��.����
          dtmp6_ := add_months(dtmp2_, 1); -- 31 ����� ��� ���
          SELECT MIN(fdat)
            INTO dtmpg_
            FROM cc_lim
           WHERE nd = p_nd
             AND fdat > dtmp6_;
          IF dtmp5_ > gl.bdate THEN
            ---2.2.1 - �� ������, ���� ��.���� �������� ������ ��� � �������, �.� ���.02.11.2014, � ��.���� 05.11.2014,  �� ������ 05.11.2014
            SELECT lim2
              INTO gg.lim2
              FROM cc_lim
             WHERE nd = p_nd
               AND fdat = dtmp5_;
            s2_ := calp_ar(gg.lim2, ir_, dtmp5_, dtmp6_, ii.basey);
          ELSE
            ---2.2.2 - �� ��������. ���� ��.���� �������� ������ ��� ������� ��� � �������, �.�. ���.28.11.2014 ��� 05.11.2014, � ��.���� 05.11.2014
            acrn.p_int(acc8_, 0, dtmp5_, dtmp6_, s2_, NULL, 0);
            s2_ := -round(s2_, 0);
          END IF;
          si_ := s1_ + s2_;
          UPDATE cc_lim
             SET sumo = sumg + si_
           WHERE nd = p_nd
             AND fdat = dtmpg_;
        ELSE
          /* �.��� �������� - ���� �� ���� ����  - (  ��� ����������� � ����������� 11.06.2014)
               �������� ��������� ���� ������ ��� 1-� ������� ����,
               � �� ����� ��������� ����� ���� + ����������� .
               �� ��� ���� �� ��������� ��� ���. ��������, ���.
          */
        
          dtmp1_ := datn_; -- ���� ��.����
          dtmp2_ := add_months(datn_, 1); -- ���� ��.����
          si_    := calp_ar(lim2_, ir_, datn_, dtmp2_ - 1, ii.basey); -- ���� ���� ��� ���� ��.����
          UPDATE cc_lim
             SET sumo = sumo + si_
           WHERE nd = p_nd
             AND fdat = dtmp2_
             AND sumg = sumo - nvl(sumk, 0);
        END IF;
      END;
    END IF;
  
    -- 28.03.2014 Sta ����������� � ����������� �����
    SELECT MAX(fdat) INTO datk_new FROM tmp_gpk;
    IF datk_new < datk_ THEN
      UPDATE cc_deal SET wdate = datk_new WHERE nd = p_nd;
      FOR k IN (SELECT a.acc
                  FROM nd_acc n, accounts a
                 WHERE n.nd = p_nd
                   AND n.acc = a.acc
                   AND a.tip IN ('SS '
                                ,'SN '
                                ,'SL '
                                ,'SDI'
                                ,'SK0'
                                ,'S9N'
                                ,'SN8'
                                ,'SG '
                                ,'LIM'
                                ,'CR9'
                                ,'SP '
                                ,'SPN'
                                ,'SLN'
                                ,'SPI'
                                ,'SK9'
                                ,'S9K'
                                ,'SNO'))
      LOOP
        UPDATE accounts SET mdate = datk_new WHERE acc = k.acc;
      END LOOP;
    END IF;
  
    cck_app.set_nd_txt(p_nd, 'FLAGS', l_txt);
    cck_app.set_nd_txt(p_nd, 'CCRNG', '10');
  
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
  
    UPDATE int_accn i
       SET i.basem = l_basem, i.basey = decode(l_basem, 1, 2, i.basey)
     WHERE id = 0
       AND acc IN (SELECT a.acc
                     FROM nd_acc n, accounts a
                    WHERE n.nd = p_nd
                      AND n.acc = a.acc
                      AND a.tip IN ('LIM', 'SS '));
  
    logger.financial('�����.��� ���.' || p_nd || ' ��� ����.����� ����=' ||
                     cck_dpk.k1_);
  
  END modi_gpk;

  ---------------------
  PROCEDURE modi_ret
  (
    p_nd  IN cc_deal.nd%TYPE
   ,p_ref IN OUT oper.ref%TYPE
   ,p_ref2 IN OUT oper.ref%TYPE 
  ) IS
  BEGIN
    cck_dpk.modi_ret_ex(p_nd => p_nd, p_ref => p_ref, p_mdat => gl.bdate,p_ref2=>p_ref2);
  END modi_ret;
  ---------------------
  PROCEDURE modi_ret_ex
  (
    p_nd   IN cc_deal.nd%TYPE
   ,p_ref  IN OUT oper.ref%TYPE
   ,p_mdat IN DATE
   ,p_ref2 IN OUT oper.ref%TYPE 
  ) IS
    l_p1 NUMBER;
    l_p2 NUMBER;
  BEGIN
    cck_dpk.ret_gpk(p_nd, p_ref, p_mdat); -- ����� ���
    IF p_ref IS NOT NULL
       AND p_ref <> 0 THEN
      p_back_dok(p_ref, 5, NULL, l_p1, l_p2);
      p_ref := NULL;
    END IF; -- ����� ��������
    IF p_ref2 IS NOT NULL
       AND p_ref2 <> 0 THEN
      p_back_dok(p_ref2, 5, NULL, l_p1, l_p2);
      p_ref2 := NULL;
    END IF; 
 END modi_ret_ex;
  -------------------
  PROCEDURE ret_gpk
  (
    p_nd   IN cc_deal.nd%TYPE
   ,p_ref  IN oper.ref%TYPE
   ,p_mdat IN DATE
  ) IS
    l_mdat cc_lim_arc.mdat%TYPE;
    b_mdat DATE := nvl(p_mdat, gl.bdate);
    l_nd   NUMBER := p_nd;
  BEGIN
  
    IF l_nd IS NULL
       AND p_ref IS NOT NULL THEN
      BEGIN
        SELECT n.nd
          INTO l_nd
          FROM nd_acc n, accounts a, oper o
         WHERE n.acc = a.acc
           AND a.kv = o.kv2
           AND a.nls = o.nlsb
           AND o.ref = p_ref;
      EXCEPTION
        WHEN no_data_found THEN
          NULL;
      END;
    END IF;
    IF l_nd IS NULL THEN
      RETURN;
    END IF;
    ------------------------------------
  
    SELECT MAX(mdat)
      INTO l_mdat
      FROM cc_lim_arc
     WHERE nd = l_nd
       AND typm = 'CCKD';
  
    IF l_mdat = b_mdat THEN
      DELETE FROM cc_lim WHERE nd = l_nd;
      INSERT INTO cc_lim
        (nd, fdat, lim2, acc, not_9129, sumg, sumo, otm, sumk, not_sn)
        SELECT nd, fdat, lim2, acc, not_9129, sumg, sumo, otm, sumk, not_sn
          FROM cc_lim_arc
         WHERE nd = l_nd
           AND mdat = l_mdat;
    
      -- 11.06.2014 ������� ----
      DECLARE
        dat_end DATE;
        dd      cc_deal%ROWTYPE;
      BEGIN
        SELECT MAX(fdat) INTO dat_end FROM cc_lim WHERE nd = l_nd;
        SELECT * INTO dd FROM cc_deal WHERE nd = l_nd;
        IF dd.wdate <> dat_end THEN
          UPDATE cc_deal SET wdate = dat_end WHERE nd = l_nd;
          FOR k IN (SELECT acc
                      FROM accounts
                     WHERE rnk = dd.rnk
                       AND dazs IS NULL
                       AND mdate != dat_end
                       AND acc IN (SELECT acc FROM nd_acc WHERE nd = l_nd))
          LOOP
            UPDATE accounts SET mdate = dat_end WHERE acc = k.acc;
          END LOOP;
        END IF;
      END;
    
      --   ��� ������ ���������� ��������� 01 ����� ������  �� cck_arc_cc_lim  �� �������,
      --   � ������ ������� ������� ���������� ���������.
      IF to_number(to_char(l_mdat, 'DD')) = 1 THEN
        UPDATE cc_lim_arc
           SET typm = NULL
         WHERE nd = l_nd
           AND mdat = l_mdat;
      ELSE
        DELETE FROM cc_lim_arc
         WHERE nd = l_nd
           AND mdat = l_mdat;
      END IF;
    
      -- else ----��� � ������ �� B_mdat
      ---  bars_error.raise_nerror(p_errmod=>'CCK',p_errname=>'��� � ������ �� '||to_char(B_mdat,'dd.mm.yyyy'), p_param1=> to_char(L_nd), p_param2=> to_char(B_mdat,'dd.mm.yyyy'));
    
    END IF;
  
  END ret_gpk;

---��������� ���� --------------
BEGIN

  BEGIN
    SELECT nls
      INTO cck_dpk.nls_8006
      FROM accounts
     WHERE tip = 'SD8'
       AND nvl(nbs, '8006') = '8006'
       AND dazs IS NULL
       AND kv = gl.baseval
       AND rownum = 1;
  EXCEPTION
    WHEN OTHERS THEN
      raise_application_error(- (20203)
                             ,' �� �������� ����� ���. �� ���i 8006*SD8');
  END;

  cck_dpk.nls_6397 := nbs_ob22_bra('6397'
                                  ,'01'
                                  ,sys_context('bars_context'
                                              ,'user_branch'));

END cck_dpk;
/
