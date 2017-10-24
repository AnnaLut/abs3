
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/cp_kb.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.CP_KB IS
/*
  5/11-15  ��������� �400
 15.03.2013 Sta   ������ �� ������� �����
                  ������������� ������ ������ �������
                  ��� ������������ ���������� - ����� ������������ ����

 06-12-2010 Sta - ������� "����/������" ��� ������ ����� �� ����� ������.
                  CP_RATES.PRO :   1=������ (� ���), �����(0)=�����

 27.06.2006 Sta - ������� �� ���� �� ��� ���� ���� ��� ����� �����,
                  �� gl.BDATE >= DAT_ROZ
                  ������.�������-������ �� ���������
 23.05.2006
 31.03.2005  ������������� � ���.����������
 28.03.2005  Sta �������-����������
 15.02.2006 �������� �� � ������� CP_CUR_ = 0 ���������� ����� ������� (���)
 29.12.2005 ������
 ����� - ����� ����� ������� ��� ����������� ���.������., �����
*/

   ern  CONSTANT POSITIVE := 021; erm  VARCHAR2(80); err  EXCEPTION;
   NBUBNK_   varchar2(1);
---------------------------------
-- ��������� ����������

--1) �������, �i� ��i�� �����.        mode_ > 0 , + mode_ = REF ������
PROCEDURE NB_cur
(mode_ int,
 DAT_ date,
 ID_    IN int,
 B_4621 IN VARCHAR2,
 P_1819 IN VARCHAR2,
 P_1919 IN VARCHAR2,
 sErr OUT varchar2 );

--2) ���������, ��������� ����������
PROCEDURE NB_curF
(mode_ int,
 DAT_ date,
 ID_    IN int,
 B_4621 IN VARCHAR2,
 P_1819 IN VARCHAR2,
 P_1919 IN VARCHAR2,
 sErr OUT varchar2 );

--------------------------------
END CP_KB;
/
CREATE OR REPLACE PACKAGE BODY BARS.CP_KB IS
---------------------------------------------
/* ������ �.�. �. 253-14-38 larysa@bank.gov.ua */
---------------------------------------------------------------------------
 TT_ oper.tt%type:='FXO'; VOB_ oper.vob%type     ;
 FL_ int ; DK_ int      ; NAZN_    varchar2(160) ; S_  number; SQ_ number ;
 NLS_3811_ varchar2(15) ; NMS_3811_ varchar2(38) ; VDAT_ date; dTmp_ date ;
 NLS_6203_ varchar2(15) ; OPL_6203_ varchar2(15) ; NMS_6203_  varchar2(38);
 NLS_3115_d varchar2(15); NLS_3115_r varchar2(15); NMS_3115_r varchar2(38);

 l_1819 VARCHAR2(15); NMS_1819 varchar2(38);
 l_1919 VARCHAR2(15); NMS_1919 varchar2(38);
 kk cp_kod%rowtype;
 fl_400 int:=1;
 l_sql varchar2(200);  nls_f varchar2(15);

 --��: 0=���������� ����� �������, 1= � ������ �������
 CP_CUR_   char(1)     :='0' ;
 sPEREOP   VARCHAR(70) := '�����.���.������i���';
 sPEREOV   VARCHAR(70) := '�i�`���.���.������i���';
 -----------------------
 TEKU_PEREOC number    ; -- ���� ������� ������.�������
 oo oper%rowtype;
 ---=====================================================================--------------------
/*       ����� 3.4  4/12-15  23/11-15   15/05-14

 4/12-15 ������� 3811/3702 �� NBUBANK
23/11-15 ������ ����-� ������� ���. �������
20/11-15 CNBUSUP-79
 6/11-15 -- ��������� �400
15/05-14 KDI ���� ��������� ��������� �� 4/11-13
04.11.13 Sta 0-����� ����������- �� ������ ��������

31/05-13 KDI ��������� �� ���-�� OPER.nlsa ��� �� ���-�� ���������.
18/04/13 ³���� �� ������������ �������.
         ϳ��� ��������� ������������
         ��������� ������ � ����������� ��������� ��������
         ��� ���� �� ������� ����� � ����� ����������.
15/04/13 ������ - KDI:
������ ���� ����������� ��� ���������� ��� ������� � ����� �����.
��������� ���� ����� - 31/01/2013 ���� ���������� - 4/02/2013
���������� 1/02 �� ����� �� 31/01 - ���� �����������  31/01 (�� ���� 1/02)
����������.
*/

procedure opl1 (  oo IN OUT oper%rowtype) is
begin
  if oo.ref is null then

     gl.ref    (oo.REF);
     GL.in_doc3
       (ref_  => oo.REF  , tt_   => cp_kb.tt_, vob_ =>oo.vob  , nd_ =>substr(to_char(oo.REF),1,10), pdat_=> sysdate,
        vdat_ => oo.vdat , dk_   => oo.dk    , kv_  =>oo.kv   , s_  =>oo.s,   kv2_   =>oo.kv2,   s2_  => oo.S2,
        sk_   => null    , data_ => gl.bdate , datp_=>gl.bdate,
        nam_a_=> oo.nam_a, nlsa_ => oo.nlsa  , mfoa_=>gl.AMFO ,
        nam_b_=> oo.nam_b, nlsb_ => oo.nlsb  , mfob_=>gl.AMFO ,
        nazn_ => oo.nazn , d_rec_=> null     , id_a_=>gl.aOKPO, id_b_ =>gl.aOKPO,   id_o_ =>null,
        sign_ => null    , sos_  => 1        , prty_=>null,     uid_  =>null );
  end if;

end opl1;

PROCEDURE NB_cur
(mode_  IN int,
 DAT_   IN date,
 ID_    IN int,
 B_4621 IN VARCHAR2,
 P_1819 IN VARCHAR2,
 P_1919 IN VARCHAR2,
 sErr OUT varchar2 ) IS
  -- ��������� ����������
  --1) �������, �i� ��i�� �����.        mode_ > 0 , + mode_ = REF ������

BEGIN

  if NBUBNK_ = 1 then fl_400 := 0; end if;

  if gl.AMFO = '300465' then tt_ := 'FXP'; end if;

  begin
    select decode(substr(flags,38,1),'1',2,0) into FL_ from tts where tt=tt_;
  EXCEPTION WHEN NO_DATA_FOUND THEN   raise_application_error(-(20203), '  �� �������� ��.'||tt_,TRUE);
  end ;


  sERR:=NULL;

  FOR k in (select b.KV, decode(b.KV,gl.baseval,6,16) VOB, b.CP_ID, b.EMI, a.REF, a.DAT_UG, a.DAT_ROZ,
                   c.VDATE,
                   c.RATE_O, c.BSUM,
                   round((a.N*c.RATE_O/c.BSUM),0)  TEKU_CLEAR ,  -- ����� ������ ����,
               --    ( a.SUMB-nvl(a.R,0) )           PERV_CLEAR ,  -- �������������� ������ ����
                   (a.N + a.D + a.P + nvl(a.VD,0) + nvl(a.VP,0))  PERV_CLEAR ,
                   nvl(a.SN,0)                     PRIV_PEREOC,   -- ��������������� ����� ���������� ����������
                   nvl(a.sn_1,0) SN_1,     -- ��������� �� ����������
                   dat_sn, dat_sn_1
            from  cp_arch a, cp_kod b, oper o, CP_RATES c
            where a.op   = 1     and  a.DAT_UG <= DAT_  and a.DAT_ROZ >= DAT_
              and a.ID   = b.ID  and  o.ref     = a.ref and (o.sos=3  or a.DAT_ROZ<=gl.BDATE)
              and a.DAT_ROZ > a.DAT_UG                  and o.sos >0
              and c.id   = b.ID
              AND c.VDATE = (select max(VDATE) from CP_RATES where id=c.id and VDATE<=DAT_ and vdate >= a.DAT_UG )
              and MODE_ in (0, a.REF)
            )
  LOOP

     logger.info('NB_CUR: �����='||mode_||' '||k.dat_roz||' '||gl.bdate);

     sERR:=NULL;  nls_f:=null;

     If k.DAT_ROZ < gl.BDATE then

        --���� �������� ��� � ������� � ��� ���� ������� ����.
        -- ��������, ��� ���������� ��� �������     -- ?  �� ��������
        begin
          select fdat into dTmp_ from fdat where fdat = k.DAT_ROZ;
          GOTO KIN1_;
        exception WHEN NO_DATA_FOUND THEN  null;
        end;
     end if;

     if k.dat_sn >= k.vdate then
        logger.error('NB_CUR: ���������� ��� ������������ �� ���� '||k.vdate);
        sERR := 'cp_kb.NB_cur: ������_��� ��� ������������ �� ���� '||k.vdate;
        if MODE_!=0 then RETURN; end if;
        GOTO KIN1_;
     end if;

     TEKU_PEREOC := k.TEKU_CLEAR - k.PERV_CLEAR ;  -- ����� �.�. ������� ����� ����������
     If k.PRIV_PEREOC = TEKU_PEREOC   then
        GOTO KIN1_;  -- ������ ������  �� ����
     end if;

     -- 1) ���� ������� ��������� ����� ���������� �� = ����������
     -- ���-�� �������� ������

     begin
       -- ����� ����� ��� �������� 3811, 6203, 3115, 3541, 3641
       -- �� CP_ACCC  ����� CP_DEAL (����� ��� ���� ��������)
       select  u.nlsSN,  u.nls_FXP,      ad.nls,      ar.nls, Substr(ar.nms,1,38),
               nvl(u.nls_1819,p_1819), nvl(u.nls_1919,p_1919)
       into  NLS_3811_,  nls_6203_,  NLS_3115_d,  NLS_3115_r, nMs_3115_r,
             l_1819, l_1919
       from accounts ar, accounts ad, cp_deal d, cp_accc u
       where d.ref = k.REF and d.accS = ad.acc and ad.accc = ar.acc
             -- and u.nlsSN  is not null
             and d.ryn = u.ryn and u.emi  = k.emi
             and ar.nls  = u.nlsS and u.nls_FXP is not null
             and rownum = 1 ;

       OPL_6203_ := NLS_6203_;

       begin
         select a.nls  INTO OPL_6203_
         from accounts a, cp_deal d
         where a.dazs is null and d.ref = k.REF and d.accs6 = a.acc ;
       exception WHEN NO_DATA_FOUND THEN null;
       end;

       --����� ������������ ������������ ������ 3811/3702, 6203/5102
       --  3811 - ��� ���� ������ 2009����, � 2013 ���� ���� ���� ������ �� ����� ������.
       --  3702 - ���������� � ���

       if NBUBNK_ = 1 then
          nls_f:=NlS_3811_;
          select Substr(a3.nms,1,38) into NMS_3811_
          from accounts a3
          where a3.nls = NlS_3811_  and  a3.kv = k.KV;
       end if;

       nls_f:=NlS_6203_;
       select Substr(a6.nms,1,38) into nMs_6203_
       from accounts a6
       where a6.nls = nLs_6203_  and  a6.kv = gl.baseval;

       nls_f:='3541/3641';
       if l_1819 is not null and l_1919 is not null then
          --����� ������������ ������������ ������ 3541, 3641
       select Substr(a3.nms,1,38), Substr(a6.nms,1,38) into NMS_1819, NMS_1919
       from accounts a3, accounts a6
       where a3.nls = l_1819  and  a3.kv = k.KV
         and a6.nls = l_1919  and  a6.kv = k.kv;
       end if;

     exception
       WHEN NO_DATA_FOUND THEN  sERR :='cp_kb.NB_cur: �� ������� ��.��� ������. � CP_ACCC(Accounts) '||nls_f; RETURN;
       WHEN TOO_MANY_ROWS THEN  sERR :='cp_kb.NB_cur: ������� ����� ��.��� ������. � CP_ACCC';        RETURN;
     end;

     If DAT_ < k.DAT_ROZ then
        NLS_3115_d := NLS_3811_;   NLS_3115_r := NLS_3811_;   NmS_3115_r := NmS_3811_;
     end if;

     ----  OPER  -------------------------
     If CP_CUR_ = '1'  then  --������������ � ��
        -- � ������ �������, �� ����� ����� .������ ����� �����
        If TEKU_PEREOC > 0  then DK_ := 1 ; NAZN_ := '����i��� �� ' ; S_ :=   TEKU_PEREOC;
        else                     DK_ := 0 ; NAZN_ := '��i��� �� '   ; S_ := - TEKU_PEREOC;
        end if;
     else
        --������ �������, �� ������ . ������ ������ --������������ � ���
        S_ := TEKU_PEREOC - k.PRIV_PEREOC ;
        If S_ > 0           then DK_ := 1 ; NAZN_ := '����i��� �� ' ;
        else                     DK_ := 0 ; NAZN_ := '��i��� �� '   ; S_ := -S_ ;
        end if;
     end if;

     NAZN_ := '������i��� �� ';

     -- � ������ �� �� ������� (�� ����� �����.���)
     If gl.baseval=980 and to_char(gl.bdate,'yyMM') > to_char(k.VDATE,'yyMM')
        then VOB_:=96   ; VDAT_:= cp.F_VDAT_ZO(k.VDATE);
        else VOB_:=k.VOB; VDAT_:= gl.bdate;
     end if;

/*  ³���� �������� ���
15.04.2013 STA
����� k.VDATE = ���� �����.
��� ���� � �����. ������ ��� ����� ����� �������� ?
������, ��������� ������ VDAT_:= gl.bdate;
   --  VOB_:=k.VOB; VDAT_:= gl.bdate;    -- 18/04-13
*/

     SQ_   := gl.p_icurval(k.kv, S_, VDAT_ );
     NAZN_ := substr( NAZN_ ||
              k.CP_ID ||'. '|| k.REF ||'. ���� ' || k.RATE_O || '/' ||k.BSUM ||', ���� ����� '|| to_char(k.VDATE,'dd/mm/yyyy')
                             ,  1,160);
     --����� ���
     oo.ref  := null  ;
     oo.vob  := vob_  ;
     oo.vdat := vdat_ ;
     oo.kv   :=  k.kv ;
     oo.kv2  :=gl.baseval;
     oo.nam_a:=NMS_3115_r;
     oo.nlsa :=NLS_3115_r;
     oo.nam_b:=NMS_6203_ ;
     oo.nlsb :=NLS_6203_ ;
     oo.nazn :=NAZN_     ;
     oo.s    := s_  ;
     oo.dk   := dk_ ;
     oo.s2   := SQ_ ;

    logger.trace('NB_CUR: 400 �����='||mode_);
     ---- OPLDOK --------------------------------------------
           --- ��������� � 400
     if fl_400 = 1 then
        If k.PRIV_PEREOC   <> 0 then
           If k.PRIV_PEREOC > 0 then DK_ := 0;  S_ :=   k.PRIV_PEREOC ; nls_3811_:=l_1819;
                                     oo.nam_a:=NMS_1819; oo.nlsa :=l_1819;
           else                      DK_ := 1;  S_ := - k.PRIV_PEREOC ; nls_3811_:=l_1919;
                                     oo.nam_a:=NMS_1919; oo.nlsa :=l_1919;
           end if;
           SQ_   := gl.p_icurval(k.kv, S_, VDAT_ );
           cp_kb.opl1( oo );
           PAYTT  (0, oo.ref, VDAT_,TT_, DK_, k.kv, NLS_3811_, S_, gl.baseval, OPL_6203_, SQ_ );
           update opldok set txt='��������� ������������ '||decode(DK_,1, sPEREOV, sPEREOP) where ref=oo.ref and stmt=gl.ASTMT;
        end if;

        --�� ����� ����� (�� �����) - ����������
        If TEKU_PEREOC   <> 0 then
         --  cp_kb.opl1( oo );
           If TEKU_PEREOC > 0 then   DK_ := 1;  S_ :=   TEKU_PEREOC ; nls_3811_:=l_1819;
                                     oo.nam_a:=NMS_1819; oo.nlsa :=l_1819;
           else                      DK_ := 0;  S_ := - TEKU_PEREOC ; nls_3811_:=l_1919;
                                     oo.nam_a:=NMS_1919; oo.nlsa :=l_1919;
           end if;
           SQ_ := gl.p_icurval(k.kv, S_, VDAT_ );
           if oo.ref is not null then
              update oper set nlsa=oo.nlsa, nam_a=oo.nam_a where ref=oo.ref;
           end if;
           cp_kb.opl1( oo );
           PAYTT( 0, oo.ref, VDAT_,TT_,DK_  , k.kv, NLS_3811_, S_, gl.baseval, OPL_6203_, SQ_ );
           update opldok set txt=decode(DK_,0, sPEREOV, sPEREOP) where ref= oo.REF and stmt=gl.ASTMT;
          logger.info('NB_CUR: �����='||mode_||' ���� '||k.rate_o||' �� '||k.vdate||' '||oo.ref);
        end if;

     else     -- not 400
     If CP_CUR_   = '1' then
        -- ��� ��, ���������� �� ��� �����
        -- �� ������ ����� - ��������
        If k.PRIV_PEREOC   <> 0 then
           If k.PRIV_PEREOC > 0 then DK_ := 0;  S_ :=   k.PRIV_PEREOC ;
           else                      DK_ := 1;  S_ := - k.PRIV_PEREOC ;
           end if;
           SQ_   := gl.p_icurval(k.kv, S_, VDAT_ );
           cp_kb.opl1( oo );
           PAYTT  (0, oo.ref, VDAT_,TT_, DK_, k.kv, NLS_3811_, S_, gl.baseval, OPL_6203_, SQ_ );
           update opldok set txt='��������� ������������ '||decode(DK_,1, sPEREOV, sPEREOP) where ref=oo.ref and stmt=gl.ASTMT;
        end if;

        --�� ����� ����� (�� �����) - ����������
        If TEKU_PEREOC   <> 0 then
           cp_kb.opl1( oo );
           If TEKU_PEREOC > 0 then   DK_ := 1;  S_ :=   TEKU_PEREOC ;
           else                      DK_ := 0;  S_ := - TEKU_PEREOC ;
           end if;
           SQ_ := gl.p_icurval(k.kv, S_, VDAT_ );
           cp_kb.opl1( oo );
           PAYTT( 0, oo.ref, VDAT_,TT_,DK_  , k.kv, NLS_3115_d, S_, gl.baseval, OPL_6203_, SQ_ );
           update opldok set txt=decode(DK_,0, sPEREOV, sPEREOP) where ref= oo.REF and stmt=gl.ASTMT;
        end if;

     else
        -- ��� ���, �� ������
        cp_kb.opl1( oo );
        PAYTT  (0, oo.ref, VDAT_,tt_, DK_, k.kv, NLS_3811_, S_, gl.baseval, OPL_6203_, SQ_ );
     end if;

     logger.info('NB_CUR: �����='||mode_||' ���� '||k.rate_o||' �� '||k.vdate||' '||oo.ref);

    end if;   --- 400

     update cp_arch set SN_1=SN, SN = TEKU_PEREOC, dat_sn_1=dat_sn, dat_sn=k.vdate,
            str_ref = str_ref||','||oo.REF
     where ref=k.REF;

     if FL_=2 then      gl.pay(2,oo.REF,gl.bDATE);    end if;

      l_sql := 'insert into CP_PAYMENTS (cp_ref, op_ref) values (:c_ref,:p_ref)';
      begin
         EXECUTE IMMEDIATE l_sql  USING k.ref, oo.ref;
      exception when others then NULL;
      --raise_application_error(-(20203),'\9350 - no table Exist or others '||SQLERRM,TRUE);
      END;

     ----------
     <<kin1_>> NULL;

  END LOOP; -- k

  return;

end NB_cur ;
---------------

PROCEDURE NB_curF
(mode_  IN int,
 DAT_   IN date,
 ID_    IN int,
 B_4621 IN VARCHAR2,
 P_1819 IN VARCHAR2,
 P_1919 IN VARCHAR2,
 sErr OUT varchar2 ) IS
  -- ��������� ����������
  --2) ���������, ��������� ����������
  accs6_       number;
  daos6_ date        ;
  SN6_  number       ; -- ������������ �������    ���������� (=������ �������������� ����� 6 ��?)
  SQ6_  number       ; -- ������������ ���������� ���������� (=������ �������������� ����� 6 ��?)
  oo6  opldok%rowtype;
BEGIN

  if NBUBNK_ = 1 then fl_400 := 0; end if;

  if gl.AMFO = '300465' then tt_ := 'FXP'; end if;

  begin
    select decode(substr(flags,38,1),'1',2,0) into FL_ from tts where tt=tt_;
  EXCEPTION WHEN NO_DATA_FOUND THEN    raise_application_error(-(20203), '  �� �������� ��.'|| tt_,TRUE);
  end ;

  sERR:=NULL;

  FOR k in (select b.KV, decode(b.KV,gl.baseval,6,16) VOB, b.CP_ID, b.EMI, a.REF, a.DAT_UG, a.DAT_ROZ,
                   nvl(a.SN,0) PRIV_PEREOC   -- ��������������� ����� ���������� ����������
            from  cp_arch a, cp_kod b, oper o
            where a.op  = 1    and  a.DAT_UG  <= DAT_    and o.ref = a.ref
              and a.ID  = b.ID and  a.DAT_ROZ >= DAT_    and (o.sos=3  or a.DAT_ROZ<=gl.BDATE)
              and o.sos > 0    and  a.DAT_ROZ > a.DAT_UG and MODE_ in (0, a.REF)
              and NOT (gl.BDATE < a.DAT_ROZ)
            )
  LOOP

  logger.info('NB_CURF: �����='||mode_||' '||k.dat_roz||' '||gl.bdate||' s='||k.priv_pereoc);

     -- ������ ��������, FXQ ����� �������������� ��� �����, ����� ��� ��� �� �� �������,
     -- �� � ��������, ������������ ��������� ����� ���� ����������.
     -- � ���������� ����� �����: ����� ���� FXQ + FXO  + FXO  = 0
     ----------------------------------------------------
     begin
        -- ����� ����� ��� �������� 3811, 6203, 3115
        -- �� CP_ACCC  ����� CP_DEAL (����� ��� ���� ��������)
        select  u.nlsSN,  u.nls_FXP,      ad.nls,      ar.nls, Substr(ar.nms,1,38),
                nvl(u.nls_1819,p_1819), nvl(u.nls_1919,p_1919)
        into  NLS_3811_,  nls_6203_,  NLS_3115_d,  NLS_3115_r, nMs_3115_r,
              l_1819, l_1919
        from accounts ar, accounts ad, cp_deal d, cp_accc u
        where d.ref = k.REF and d.accS = ad.acc and ad.accc = ar.acc
              -- and u.nlsSN   is not null
              and d.ryn = u.ryn and u.emi  = k.emi  and ar.nls  = u.nlsS
              and u.nls_FXP is not null  and rownum = 1 ;

        OPL_6203_ := NLS_6203_; SQ6_ := 0 ; SN6_ := 0;
        SN6_ := k.PRIV_PEREOC;

        begin
          select a.nls, a.acc, a.daos   INTO OPL_6203_, accs6_, daos6_
          from accounts a, cp_deal d
          where a.dazs is null and d.ref=k.REF and d.accs6=a.acc ;

          SN6_    := k.PRIV_PEREOC;
          for p in (select * from opldok where acc=accs6_ and fdat >= daos6_)
          loop
             sq6_ := sq6_ +   p.s * (2*  p.dk-1);
-------------select * into  oo6 from opldok where ref=p.ref and stmt=p.stmt and dk = 1-p.dk;
-------------SN6_ := sn6_ + oo6.s * (2*oo6.dk-1);
          end loop; --p
        exception WHEN NO_DATA_FOUND THEN null; SQ6_ := null ;
        end;

        --����� ������������ ������������ ������ 3811, 6203, 3115
        select Substr(a3.nms,1,38), Substr(a6.nms,1,38) into NMS_3811_, nMs_6203_
        from accounts a3, accounts a6
        where a3.nls(+) = NlS_3811_  and  a3.kv = k.KV
              and  a6.nls = nLs_6203_  and  a6.kv = gl.baseval;

       if l_1819 is not null and l_1919 is not null then
          --����� ������������ ������������ ������ 3541, 3641
       select Substr(a3.nms,1,38), Substr(a6.nms,1,38) into NMS_1819, NMS_1919
       from accounts a3, accounts a6
       where a3.nls = l_1819  and  a3.kv = k.KV
         and a6.nls = l_1919  and  a6.kv = k.kv;
       end if;

     exception
        WHEN NO_DATA_FOUND THEN  sERR :='cp_kb.NB_curF: �� ������� ��.��� ������. � CP_ACCC(Accounts)'; RETURN;
        WHEN TOO_MANY_ROWS THEN  sERR :='cp_kb.NB_curF: ������� ����� ��.��� ������. � CP_ACCC';        RETURN;
     end;

   --  logger.info('NB_CURF: 3811 �����='||mode_);
   --  NLS_3115_d := NLS_3811_; NLS_3115_r := NLS_3811_; NmS_3115_r := NmS_3811_;
     -- � ������ �� �� ������� (�� ����� �����.���)
     If gl.baseval=980 and to_char(gl.bdate,'yyMM') > to_char(k.DAT_ROZ,'yyMM')
        then VOB_:=96   ; VDAT_:= cp.F_VDAT_ZO(k.DAT_ROZ);
        else VOB_:=k.VOB; VDAT_:= gl.bdate;
     end if;

/*   18/04-13
   ����� �� ��� 15.04.2013 STA
     VDAT_:= gl.bdate;
*/

     If SN6_ > 0 then DK_ := 0;  S_ :=   SN6_ ;
     else             DK_ := 1;  S_ := - SN6_ ;
     end if;
     logger.trace('NB_CURF: SN6='||SN6_);
     if S_=0 then goto KIN2_; end if;

     SQ_   := Nvl( abs(SQ6_), gl.p_icurval(k.kv, S_, VDAT_ ) );
     NAZN_ := '��������� ���������� �� ' || k.CP_ID || '. ���.����� ' || k.REF ;

     logger.trace('NB_CURF: 400 �����='||mode_);
     if fl_400 = 1 then null;
        OPL_6203_:=NLS_3115_d; NLS_6203_:=NLS_3115_r; NMS_6203_:=NMS_3115_r;
        if sn6_ > 0 then
           nls_3811_:=l_1819; oo.nam_a:=NMS_1819; oo.nlsa :=l_1819;
        else
           nls_3811_:=l_1919; oo.nam_a:=NMS_1919; oo.nlsa :=l_1919;
        end if;
     else
         NLS_3115_d := NLS_3811_; NLS_3115_r := NLS_3811_; NmS_3115_r := NmS_3811_;
         oo.nam_a:=NMS_3115_r; oo.nlsa :=NLS_3115_r;
     end if;

     --����� ���
     oo.ref  := null  ;
     oo.vob  := vob_  ;
     oo.vdat := vdat_ ;
     oo.kv   :=  k.kv ;
     oo.kv2  :=gl.baseval;
  --   oo.nam_a:=NMS_3115_r;
  --   oo.nlsa :=NLS_3115_r;
     oo.nam_b:=NMS_6203_ ;
     oo.nlsb :=NLS_6203_ ;
     oo.nazn :=NAZN_     ;
     oo.s    := s_  ;
     oo.dk   := dk_ ;
     oo.s2   := SQ_ ;

     cp_kb.opl1( oo );

     PAYTT  (0, oo.ref, VDAT_,tt_, DK_, k.kv, NLS_3811_, S_, gl.baseval, OPL_6203_, SQ_ );
     update opldok set txt='��������� ������������ '||decode(DK_,1, sPEREOV, sPEREOP) where ref= oo.REF and stmt=gl.ASTMT;
     update cp_arch set SN_1=SN, dat_sn_1=dat_sn,
            SN = 0, str_ref = str_ref||','|| oo.REF where ref=k.REF;
     if FL_= 2 then    gl.pay(2, oo.REF,gl.bDATE);  end if;

     l_sql := 'insert into CP_PAYMENTS (cp_ref, op_ref) values (:c_ref,:p_ref)';
     begin
        EXECUTE IMMEDIATE l_sql  USING k.ref, oo.ref;
     exception when others then NULL;
     END;

     logger.info('NB_CURF: �����='||mode_||' ��������� '||NLS_3811_||'->'||OPL_6203_||' ref='||oo.ref);

  <<kin2_>> NULL;
  END LOOP; -- k

  return;
end NB_curF ;

BEGIN
  BEGIN     -- ������ ��� �� ��
       select '1' into NBUBNK_
       from params
       where par = 'NBUBANK' and SUBSTR(val, 1, 1) = '1';
  EXCEPTION WHEN NO_DATA_FOUND THEN NBUBNK_ := '0';
  END;

  begin
  select '1' into CP_CUR_ from params where par='CP_CUR' and  val='1';
  EXCEPTION WHEN NO_DATA_FOUND THEN CP_CUR_:='0';
  end;


---------------
END CP_KB;
/
 show err;
 
PROMPT *** Create  grants  CP_KB ***
grant EXECUTE                                                                on CP_KB           to CP_ROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/cp_kb.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 