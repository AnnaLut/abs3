

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PAY_CCK_UPB.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PAY_CCK_UPB ***

  CREATE OR REPLACE PROCEDURE BARS.PAY_CCK_UPB 
              (flg_  SMALLINT DEFAULT NULL,  -- Plan/Fact flg
               ref_  INTEGER,    -- Reference
               dat_  DATE,       -- Value Date
                tt_  CHAR,       -- Transaction code
                dk_  SMALLINT,   -- Debet/Credit
               kv1_  SMALLINT,   -- Currency code 1
              nls1_  VARCHAR2,   -- Account number 1
              sum11_ DECIMAL,    -- Amount 1
               kv2_  SMALLINT,   -- Currency code 2
              nls2_  VARCHAR2,   -- Account number 2
              sum2_  DECIMAL   -- Amount 2
) IS
/*
  Ver 3.34
  01-02-2017  http://jira.unity-bars.com.ua:11000/browse/COBUSUPABS-5268
              ��������� � ���-������!
              ������ ���� ����� �� ������������� �� ������ ������� , � �� ����������� �����!
              ����� ���� �� 2620 ������������ ������ , ��� � ����������� ��� �� ��������� �������� �������������, �� ������������� ������ 14, � ����� �������� ������ 16!
              �������� ��� ���������� ����� ��� ��������� �������� ������������� ����, ������ �� ������������� ������ 14!
  06-12-2012  � ������� ���� �������� cck_ob22  ���������� ���� sd8 - ��22 ��� ��� (patch090.sql)
              ������� ��� �������� �� ������ ������� �� ����  - ���� sd8 null � ���������� ������
              ������ �������� nbs_ob22_null(6397, OB22_6397, TOBO_) ���� �� ������ �� ����� �������.
  25-07-2012  � ���. ��������� ��������� ��������� ��� �����������, ���� ������ ��� ������ ������,
              ���� ����������� �� ����� ��� ���������� ������ �����������.
  04-01-2012  ��� ��������� �������� �������� (��� ������) � (��������� + ���������� ��� ����)
              ��������� �������� ���������� (� 2909 ������� ������ �� ���� �������). + ��� �������
              ������ ������� ������� ��. ���� �� ����
              ������� ������� ������  ����� ����� �� ���� 6397. ��� ����� (����� �� ��������)
              �� �������� �� ����� ������ ���������� 6397. �� ��� � �������������.
              ������ ��� ����������� � ���� ��������������� ������.
  29-11-2011  ����� ������ �������� VPF. ������ ������ ������ ���������� �������
              ����� ��� ������������ (��������� �������). ������� ������ ����
              ���������� �������� � ���.
  04-02-2011  �������� �� ������ �� ��� � get_info_upb_ext
              ��� ���������� ��� ����� �������� ������-�� ��� �� ��� ����
  02-02-2011  ��������� �������� ��� ���������� �������� �� ������������ ��� ������
  03-09-2010  ����� ����� ������� ����� ��������� ��������� ����������
              ������������ ����� �������� CCK_PAY_S  0-���������� 1-�������������
               SD4 - ������������ ��� � �� ���� � ������� ���� cc_o_nls
  26-06-2010  ������������ ������ ��������� ������ � ��� ����� ��������� SG
              ���� ����� ������ ������� ��� ��������� ������� ������������ ��
              ��� ���������� (���). ����� ��������� ����� �� ��� ������(��������)
  19-05-2010  �������� ����������� � �� ������
  14-04-2010  �� �� ����������� ���������� ������ ���-���� ����� �� ��������
              �����. � ������ ��������
  26-01-2010  ��������� ����������� ������ �������� � ������ �������� �� ���.
              ��. GET_INFO_UPB_EXT - ���������
  24-02-2009  ���.���� �� ��� = DAT1.
              ����� �������� ����� ����� ���� � �� CCK/
              ����� ���� ���� ����� �� ����� ����������. �� - ��������.
  27-01-2009  ���.���� ��� ������� ����
  16-01-2009  ��� ���� ��8 !!
  ������ ��������� ���������� (���������� ��  #ifdef UPB �� PAYTT)
  ��������� ��������� CCK-��������.
  ���.�������� ����
*/


  sTmp_   varchar2(100);
  Sum1B_   number;
  SumQB_   number;

  VOB_     oper.VOB%type :=130;
  l_rang    CC_RANG_ADV_REP_NAME.blk%type;
  sum1_    oper.S%type:=0;  --����� ����� ������� ��� ����
  sum1T_   oper.S%type:=0;  --����� ����� ������� �� ���� ��
  sum1D_   oper.S%type:=0;  -- ����� ������� �� ���.�����(��� ����) ��������
  sum1M_   oper.S%type:=0;  -- ����� ������� �� ���.�����(��� ����) ��������
  sum1A_   oper.S%type:=0;  -- ����� �� ��������� ���������

  sum1T_P_   oper.S%type:=0;  --����� �����     (�����) ������� �� ���� ��
  sum1D_P_   oper.S%type:=0;  -- ����� �������  (�����) �� ���.�����(��� ����) ��������
  sum1M_P_   oper.S%type:=0;  -- ����� �������  (�����) �� ���.�����(��� ����) ��������

  nSSP_   number;  -- ��������� ����
  nSSPN_  number;  -- ��������� %
  nSSPK_  number;  -- ��������� ���

  sn8_     oper.S%type;
  qn8_     oper.S%type;
  SK0      oper.S%type;   -- ����� � ������ �������� ����� ������������ ��������
  SK0_980  oper.S%type;   -- ����� � ������ �������� ����� ������������ ��������

  ratn_advanced number;   -- ��������� ���������

  N980_    accounts.KV%type;
  TOBO_    accounts.TOBO%type; -- ���� ����.��
  nls_1002 accounts.NLS%type ; -- ���� �����
  nls_6397 accounts.NLS%type ; -- ���� ��� �� ���� ����-�������� ��
  nls_6110 accounts.NLS%type ; -- ���� ��� ��� �� ���� ����������
  nls_sk0  accounts.NLS%type ; -- ���� ������������ �������
  RANG_SK9SK0 Varchar2(6);     -- ������ ��� ���� ��� ��������� ��������� � ����� ��� ���������
  acc_     accounts.ACC%type ; -- ���� �������
  acc8_    accounts.ACC%type ; -- ���� ������
  ND_      cc_deal.ND%type   ;
  PASP_    operw.value%type  ;
  PASPN_   operw.value%type  ;
  ATRT_    operw.value%type  ;
  DT_R_    operw.value%type  ;

-- ���������� ��� ��������� ��� � ��
  CC_ID_   cc_deal.CC_ID%type;
  PROD_   cc_deal.PROD%type;
  DAT1_    cc_deal.SDATE%type;
  DAT4_    cc_deal.WDATE%type;
  nRet_    int               ;
  sRet_    varchar2(256)     ;
  rnk_     accounts.RNK%type ;
  nS_      number            ; -- ����� �������� �������
  nS1_     number            ; -- ����� �������������� �������
  NMK_     operw.value%type  ;
  OKPO_    customer.OKPO%type; -- OKPO         �������
  ADRES_   operw.value%type  ;
  KV_      accounts.KV%type  ;
  LCV_     tabval.LCV%type   ;  -- ISO ������   ��
  NAMEV_   tabval.NAME%type  ; -- �����a       ��
  UNIT_    tabval.UNIT%type  ; -- ���.������   ��
  GENDER_  tabval.GENDER%type; -- ��� ������   ��
  nSS_     number            ; -- ���.����� ���.�����
  nSS1_    number            ; -- �����.����� ���.�����
  DAT_SN_  date              ; --\ �� ����� ���� ��� %
  nSN_     number            ; --/ ����� ��� %
  nSN1_    number            ;-- | �����.����� ����.�����
  DAT_SK_  date              ; --\ �� ����� ���� ��� ���
  nSK_     number            ; --/ ����� ��� ����������� ��������
  nSK1_    number            ; --| �����.����� �����.�����
  ACC_SK0  accounts.acc%type ;
  KV_KOM_  int               ; -- ��� ��������
  DAT_SP_  date              ; -- �� ����� ���� ��� ����
  nSP_     number            ; -- ����� ��� ����������� ����
  KV_SN8   accounts.KV%type  ;
  NLS_8008 accounts.NLS%type ; --\
  NLS_8006 accounts.NLS%type ; --/ ����� ���������� ����
  MFOK_    oper.MFOB%type    ; --\
  nls_SG   accounts.NLS%type ; --/ ���� �������
  nls_SG_980 accounts.NLS%type ; --/ ���� �������
  OB22_6397 accounts.ob22%type ; -- ��22 ��� ���� ��� ��������
  Mess_    varchar2(1024)    ;
--
  flg_spn int:=0;
  flg_sk9 int:=0;
  flg_sp  int:=0;
  flg_sn int:=0;
  flg_sk0 int:=0;
  flg_ss  int:=0;

  Del_SK4 number:=0;
  SK4_stp_dat date;
  l_limit number:=0;
  l_VID  number:=0;
  l_OSTX number:=0;
  CC_PAY_S int:= NVL( GetGlobalOption('CC_PAY_S'),'0');
  L_ALLSUM_FOR_VP number:=0; --
  L_DEL_VP  number:=0;
  l_nSK_980 number:=0;   -- ��� �� �������� �������� (temp)
  rate_   cur_rates$base.rate_b%type; -- ���� ������ ������


PROCEDURE pay_no(nlsm_ varchar2,nlsk_ varchar2, TT_ char)
is
  l_SERR  varchar2(35);
  l_NERR  int;
begin
        select max(n.id), max(n.name)
          into l_NERR, l_SERR
          from PAYTT_NO n
         where rownum=1
           and TT_ = Nvl(n.TT,TT_)
           and (dk_=1 and nlsm_ like trim(NBSD)||'%' AND nlsk_ like trim(NBSK)||'%'
                OR
                dk_=0 and nlsk_ like trim(NBSD)||'%' AND nlsm_ like trim(NBSK)||'%'
               );
  if l_NERR is not null then
  raise_application_error(-(20203),
  '\PAY_CCK_UPB:'||l_NERR||'.'||l_SERR||' '|| nlsm_||' - '||nlsk_||'('||TT_||')', TRUE);
  end if;
end;


BEGIN
  N980_:= GL.BASEVAL;

 logger.trace ('PAY_CCK: ref_='||ref_);

  -- ����� ���.�������� CC_ID
  begin
    select trim(value) into CC_ID_ from operw where ref=REF_ and tag ='CC_ID';
    If substr(CC_ID_,-4,1) ='/' then
       KV_   := to_number(substr(CC_ID_,-3,3));
       CC_ID_:= substr(CC_ID_,1, length(CC_ID_)-4);
    else
       If dk_=0 then   kv_ := kv2_; else  kv_ := kv1_; end if;
    end if;

  EXCEPTION  WHEN OTHERS THEN
    raise_application_error(-(20203),' ���������� ���. ���� CC_ID �� ���='||REF_, TRUE);
  end;

  If dk_=0 then  nls_1002 := NLS2_;  else  nls_1002 := NLS1_;  end if;

--------------
  -- ����� ���.�������� DAT1
  begin
    select substr(trim(value),1,10) into sTmp_
    from operw where ref=REF_ and tag ='DAT1' ;
    DAT1_:=to_date (sTmp_,'dd-mm-yyyy' );
  EXCEPTION  WHEN OTHERS THEN DAT1_:=null;
  end;

 logger.trace ('PAY_CCK: CC_ID='||CC_ID_);
  --- ���� ���� �������
  begin

     IF DAT1_ is not null then

        select acc, rnk, nd, tobo, nls,limit, prod
        INTO ACC_,RNK_,ND_,TOBO_, nls_SG, l_limit, PROD_
        from (
           select a.acc, a.rnk, n.nd, a.tobo, a.nls,d.limit, d.prod
        from accounts a, nd_acc n, cc_deal d,cc_add ca
        where trim(d.CC_ID)=trim(CC_ID_) and d.sdate=DAT1_ and d.nd  = n.ND
          and d.nd=ca.nd  and ca.adds=0  and d.vidd in (11,12,13)
             and ca.kv =kv_  and (a.tip = 'SG ' or nbs ='2620' ) AND A.KV=CA.KV
             and a.acc=n.acc and a.dazs is null and d.sos<14
          order by a.nbs, a.acc)
        where rownum=1;

     else
        If dk_=0 then nls_SG := nls1_; else nls_SG := nls2_; end if;

       -- � ��� ���� �� � ��������� ������� � ����� (�������������)
        select a.acc, a.rnk, n.nd, a.tobo, d.sdate
        INTO ACC_,RNK_,ND_,TOBO_,DAT1_
        from accounts a, nd_acc n, cc_deal d
        where d.CC_ID=CC_ID_ and d.nd  = n.ND
          and a.kv =kv_      and a.nls = nls_SG and d.vidd in (11,12,13)
          and a.acc=n.acc    and a.dazs is null and d.sos<15;
        INSERT INTO operw (ref,tag,value) VALUES (REF_,'DAT1',to_char(DAT1_,'dd/mm/yyyy'));
     end if;

  EXCEPTION  WHEN OTHERS THEN
     raise_application_error(-(20203),
     '     �� �������� ��., ��, ���.SG '||kv_||'/'||nls_SG, TRUE);
  end;

   logger.trace ('PAY_CCK: nls_SG = '||nls_SG);

--  ��� ��������� ��� �� ��
GET_INFO_UPB_EXT
 ( CC_ID_, DAT1_, nRet_, sRet_, rnk_,
  nS_    , -- ����� �������� �������
  nS1_   , -- ����� �������������� �������
  NMK_   , OKPO_, ADRES_, KV_, LCV_, NAMEV_, UNIT_, GENDER_,
  nSS_   , -- ���.����� ���.����� � �����
  DAT4_  ,
  nSS1_  , -- �����.����� ���.������ �����
  DAT_SN_,
  nSN_   , -- ����� ��� % � �����
  nSN1_  , -- �����.����� ����.����� � �����
  DAT_SK_,
  nSK_   , -- ����� ��� ����������� �������� � �����
  nSK1_  , -- �����.����� �����.����� � �����
  KV_KOM_,
  DAT_SP_,
  nSP_   , -- ����� ��� ����������� ����
  KV_SN8 ,
  NLS_8008,
  NLS_8006,
  MFOK_   ,
  sTmp_   ,
  nSSP_   , -- ����� ������������� ����
  nSSPN_  , -- ����� ������������ ���������
  nSSPK_  , -- �����  ������������ ��������
  Mess_

);

-- ��� ��������� � ��������� �� ����� ����������� ���������
   if substr (nls2_,1,2)='26' then
 begin
       select vob into vob_ from tts_vob where tt='CCK' and ord=3;
      exception when no_data_found then
         VOB_:=350;
      end;
   else
    begin
  select r.blk
     into l_rang
    from nd_txt t, cc_rang_name r where t.nd=nd_ and T.TAG='CCRNG' and T.TXT =R.RANG;
    exception when no_data_found then l_rang:=0;

 end;
 -- �� ����i���� ���� (�� ���. SG) ��������� �����
    if l_rang=2 then
      begin
       select vob into vob_ from tts_vob where tt='CCK' and ord=2;
      exception when no_data_found then
         VOB_:=134;
      end;
    else
      begin
       select vob into vob_ from tts_vob where tt='CCK' and ord=1;
      exception when no_data_found then
         VOB_:=130;
      end;
    end if; -- l_rang=2
   end if;  -- substr (nls2_,1,2)='26'


bars_audit.trace('PAY_CCK_UPB: CC_ID_='||CC_ID_||', DAT1_='||DAT1_||
', nS_='    ||nS_    ||', nS1_='   ||nS1_   ||', KV_='    ||KV_    ||
', nSS_='   ||nSS_   ||', DAT4_='  ||DAT4_  ||', nSS1_='  ||nSS1_  ||
', DAT_SN_='||DAT_SN_||', nSN_='   ||nSN_   ||', nSN1_='  ||nSN1_  ||
', DAT_SK_='||DAT_SK_||', nSK_=   '||nSK_   ||', nSK1_='  ||nSK1_  ||
', KV_KOM_='||KV_KOM_||', DAT_SP_='||DAT_SP_||', nSP_=   '||nSP_   ||
', nSSP_='  ||nSSP_  ||', nSSPN_=' ||nSSPN_ ||', nSSPK_= '||nSSPK_ ||
', sum11_=' ||sum11_ ||', sum1_=' ||sum1_||' VOB='||to_char(VOB_)
);


  --------------------------- ���� ------------------------------------
   -- ��� ��� ����� ����� ������ ������� get_info_upb_ext
   -- ��������� �� ��� ���������  � ���� ���������� ���������
   -- ��������� ������ �� ��������� ������

 logger.trace ('PAY_CCK: KV_KOM_'||KV_KOM_);

  begin
    select to_number(value) into KV_SN8 from operw where ref=ref_ and tag='SN8KV';
    select to_number(value) into SN8_ from operw where ref=ref_ and tag='SN8';
    qn8_ := gl.p_icurval(kv_sn8, sn8_, gl.BDATE);
  EXCEPTION  WHEN OTHERS THEN    sn8_:=0; qn8_:=0;
  end;

 logger.trace ('PAY_CCK: KV_SN8 = '||KV_SN8||' SN8 = '||SN8_);

  If nvl(sn8_,0) >0 then
      begin
          select sd8
            into OB22_6397
            from cck_ob22
           where nbs||ob22 = PROD_;
        EXCEPTION  WHEN OTHERS
           THEN OB22_6397 := null;
      end;

  if OB22_6397 is null then
       begin
       -- ���� ��� ��� �� ���� ����
       select a.nls into NLS_6397
       from accounts a, TOBO_PARAMS t
       where t.tobo=TOBO_
         and t.tag='CC_6397' and a.kv=n980_
         and t.val=a.nls and a.dazs is null;

     EXCEPTION  WHEN OTHERS THEN
       raise_application_error(-(20203),
       ' �� �������� ���.�����i� �� ���i ��� ���� '||TOBO_||'�������� �������  "��������� �������� �����"(TOBO_PARAMS) ��� ="CC_6397" ', TRUE);
     end;

  else

    NLS_6397 := nbs_ob22_null(6397, OB22_6397, TOBO_);
                if NLS_6397 is null then
                raise_application_error(-20203,
                    '\9356 - �� ������ ���� ���='|| '6397'||' OB22='||OB22_6397||' ��� ������ = ' || TOBO_,TRUE);
                end if;
  end if;

     --������������ ���.���� � ��������
        pay_no(nls_8006,nls_8008,tt_); -- �������� �� ������������ ��� ������
     gl.payv(flg_,ref_,dat_,tt_,1,KV_SN8,nls_8006,sn8_,KV_SN8,nls_8008, sn8_);
     --���������� ���� �� ������ � �����
       pay_no(nls_1002,nls_6397,'CC8');
     gl.payv(flg_,ref_,dat_,'CC8',1,N980_,nls_1002,Qn8_,N980_,nls_6397, Qn8_);
     INSERT INTO operw (ref,tag,value) VALUES (REF_,'QN8', QN8_ );
  else
     -- ������ ������ ������ �� ����, �� ��� ����� �� ����, �� ���.���
     If sum11_ = 0 then RETURN;
     end if;
  end if;

 logger.trace ('PAY_CCK: 4');
  --���.��������� �������� ������ ����:
  --1. ��� �������
  INSERT INTO operw (ref,tag,value) VALUES (REF_,'FIO', NMK_ );
  --2. ����. ��� �������
  INSERT INTO operw (ref,tag,value) VALUES (REF_,'POKPO', OKPO_ );

      update oper set vob=vob_, sk = 14 where ref=REF_; --sk = decode(substr(nls2_,1,4),'2620',16,14)

  -- ������ ��� ������ ��������
    begin
      select to_number(value) into KV_KOM_  from operw where ref=ref_ and tag='SK0KV';
      select abs(to_number(value)) into SK0 from operw where ref=ref_ and tag='SK0';
    exception when no_data_found then
      sk0:=0; kv_kom_:=kv_;
    end;
    logger.trace ('PAY_CCK: KV_KOM_ = '||KV_KOM_||' SK0 = '||SK0);

-- ��������� �������� � ������ �������� �� ��������
-- ������ ������ ��� �������� � ������ (�������� �� ������ �� 3578/3579)

     -- ���� �������� � �������� � ������ ���� ���� ���� ������� � ������
     -- ��������� ������ ������ ������ � ���
     if KV_KOM_!=gl.baseval and nSK1_>0 then
       begin
         SELECT a.nls
           into NLS_SG_980
           from nd_acc n, accounts a  where n.nd=ND_
                and a.tip='SG ' and a.kv=gl.baseval and n.acc=a.acc
                and a.dazs is null and rownum=1;
       EXCEPTION
       WHEN NO_DATA_FOUND THEN null;
            raise_application_error(-(20204),
            ' �� �������� ������� ��������� (SG) � ����������� �����! ��� ��� = '||to_char(ND_), TRUE);
       end;
     end if;

      -- ��� ���������� �������� � ���. ���������
      if SK0>0 and kv_kom_<>kv_ and kv_kom_=N980_ then
        -- ����� ������������ ���������
        begin
        select a.nls,abs(a.ostb+a.ostf)
          into nls_sk0,nSSPK_
          FROM accounts a, nd_acc n
         WHERE n.nd=ND_ and n.acc=a.acc and
               a.tip='SK9' and a.kv=KV_KOM_ and rownum=1
               and (a.ostb+a.ostf)=
                    (SELECT min(aa.ostb+aa.ostf)
                       FROM accounts aa, nd_acc nn
                      WHERE nn.nd=ND_ and nn.acc=aa.acc and
                            aa.tip='SK9' and aa.kv=KV_KOM_
                    );
        exception when no_data_found then
           nSSPK_:=0;
        end;


        if nSSPK_>0 then
              pay_no(nls_1002,nls_sk0,'CCM');
           gl.payv(flg_,ref_,dat_,'CCM',1,kv_kom_,nls_1002,least(nSSPK_,SK0),kv_kom_,nls_sk0, least(nSSPK_,SK0) );
        end if;
        logger.trace ('PAY_CCK: 6');
        -- ����� ��������
        if  SK0-least(nSSPK_,SK0)>0 then
         begin
         select a.nls,abs(a.ostb+a.ostf)
           into nls_sk0,nSK_
           FROM accounts a, nd_acc n
          WHERE n.nd=ND_ and n.acc=a.acc and
                a.tip='SK0' and a.kv=KV_KOM_ and rownum=1
                and (a.ostb+a.ostf)=
                     (SELECT min(aa.ostb+aa.ostf)
                        FROM accounts aa, nd_acc nn
                       WHERE nn.nd=ND_ and nn.acc=aa.acc and
                             aa.tip='SK0' and aa.kv=KV_KOM_
                     );
         exception when no_data_found then
            nSK_:=0;
         end;
         if nSK_<SK0-least(nSSPK_,SK0) then
            raise_application_error(-(20204),
              ' ������� ���� ��� ��������� ����� �� ���������� �� ������ ������� ='||to_char(nSSPK_+nSK_), TRUE);

         else
               pay_no(nls_1002,nls_sk0,'CCM');
            gl.payv(flg_,ref_,dat_,'CCM',1,kv_kom_,nls_1002,
                    least(nSK_,SK0-least(nSSPK_,SK0)),kv_kom_,nls_sk0, least(nSK_,SK0-least(nSSPK_,SK0)) );
         end if;
        end if;
      end if;

     logger.trace ('PAY_CCK: 7');


        -- �������� ��� ��������� �� �������� � ���
        -- ������ 1001 (980)  - 2909 (980)
        --        2909 (980)  - 3578 (840)

   if SK0>0 and kv_kom_!=N980_ then

     -- ������ ������ �� ��������� ���������� 2909
     SK0_980:=gl.p_icurval(KV_KOM_,SK0,gl.BDATE) ;
        pay_no(nls_1002,NLS_SG_980,'CCM');
     gl.payv(flg_,ref_,dat_,'CCM',1,gl.baseval,nls_1002,SK0_980,gl.baseval,NLS_SG_980, SK0_980 );

        -- ������� �� ���������� ���������
         select max(decode (rownum,1,tip,null))||max(decode (rownum,2,tip,null))
           into RANG_SK9SK0
           from
               (
                select tip from cc_rang
                 where tip in ('SS ','SP ','SN ','SPN','SK0','SK9') and
                       rang=to_number(nvl((select txt from nd_txt where tag='CCRNG' and nd=ND_),GetGlobalOption('CC_RANG')))
                 order by ord
               );
   -- ���� ����� ������ ����� ��������� ��������� ����������
   -- �� �� �������� ���������� (������������ �������)
   -- ����� ������������ �� ������ 3578/3579
    if RANG_SK9SK0='SK9SK0' then
          pay_no(NLS_SG,NLS_SG_980,'CCM');
       gl.payv(flg_,ref_,dat_,'CCM',1,gl.baseval,NLS_SG_980,SK0_980,KV_,NLS_SG, SK0);
    else

  -- ����� ������������ ���������
        begin
        select a.nls,abs(a.ostb+a.ostf)
          into nls_sk0,nSSPK_
          FROM accounts a, nd_acc n
         WHERE n.nd=ND_ and n.acc=a.acc and
               a.tip='SK9' and a.kv=KV_KOM_ and rownum=1
               and (a.ostb+a.ostf)=
                    (SELECT min(aa.ostb+aa.ostf)
                       FROM accounts aa, nd_acc nn
                      WHERE nn.nd=ND_ and nn.acc=aa.acc and
                            aa.tip='SK9' and aa.kv=KV_KOM_
                    );
        exception when no_data_found then
           nSSPK_:=0;
        end;
        if nSSPK_>0 then
              pay_no(nls_sk0,NLS_SG_980,'CCM');
           gl.payv(flg_,ref_,dat_,'CCM',1,gl.baseval,NLS_SG_980
                   ,gl.p_icurval(KV_KOM_,least(nSSPK_,SK0),gl.BDATE)
                   ,kv_kom_,nls_sk0
                   ,least(nSSPK_,SK0)
                  );
        end if;
        logger.trace ('PAY_CCK: 6-1');
        -- ����� ������� ��������

--        if  SK0-least(nSSPK_,SK0)>0 then
       -- ���������� ����� ��� ���������
       if  SK0_980-gl.p_icurval(KV_KOM_,least(nSSPK_,SK0),gl.BDATE)>0 then
         begin
         select a.nls,abs(a.ostb+a.ostf)
           into nls_sk0,nSK_
           FROM accounts a, nd_acc n
          WHERE n.nd=ND_ and n.acc=a.acc and
                a.tip='SK0' and a.kv=KV_KOM_ and rownum=1
                and (a.ostb+a.ostf)=
                     (SELECT min(aa.ostb+aa.ostf)
                        FROM accounts aa, nd_acc nn
                       WHERE nn.nd=ND_ and nn.acc=aa.acc and
                             aa.tip='SK0' and aa.kv=KV_KOM_
                     );
         exception when no_data_found then
            nSK_:=0;
         end;

         -- ������� � ����������� � 1 ������� ���� ������ ������� ������ ��������� �����
         -- ������� �� ������������ ������ ����
         -- ����� � ��������� �������� � �� ������ � ����� ��������� ��������  � ������ ���������
         -- ����� ������ ����� �������� ���������� �� ������ � ��������� �����������
         -- ����� ��� ������������ ������� ���� ������� ������ ����������

         if SK0-nSSPK_-nSK_=0  then
            l_nSK_980:= SK0_980-gl.p_icurval(KV_KOM_,least(nSSPK_,SK0),gl.BDATE);

          else
            l_nSK_980:=least (gl.p_icurval(KV_KOM_,nSK_,gl.bdate),
                             SK0_980-gl.p_icurval(KV_KOM_,least(nSSPK_,SK0),gl.BDATE));
          end if;

            pay_no(NLS_SG_980,nls_sk0,'CCM');
            gl.payv(flg_,ref_,dat_,'CCM',1,gl.baseval,NLS_SG_980,
                    l_nSK_980                     ,kv_kom_,nls_sk0,
                    least(nSK_,SK0-least(nSSPK_,SK0)) );


         -- �� ����� ������������ ������������� ��������

--         if nSK_<SK0-least(nSSPK_,SK0) then
--            raise_application_error(-(20204),
--              ' ������� ���� ��� ��������� ����� �� ���������� �� ������ ������� ='||to_char(nSSPK_+nSK_), TRUE);
--         else
--            gl.payv(flg_,ref_,dat_,'CCM',1,gl.baseval,NLS_SG_980
--                    ,gl.p_icurval(KV_KOM_,   least(nSK_,SK0-least(nSSPK_,SK0))     ,gl.bdate)
--                    ,kv_kom_,nls_sk0,
--                    least(nSK_,SK0-least(nSSPK_,SK0)) );

--         end if;
        end if;



    end if;     --   RANG_SK9SK0='SK9SK0'
   end if;      --   SK0>0 and kv_kom_!=N980_

 -- �� ����� �������������� ����� �������� ��� ��������� ���� � �������� ��������
  sum1_:= sum11_ - (sn8_+sk0);


  -----------------------
  -- ���� �������� ������ sum1_ >0
  --������� �������� ������ �� ���.���� � ���.�����
  -- ������������� ��� ������������� ������ ?
  -- ��������� ������ ��������� CCK.CC_ASG


  if CC_PAY_S=1 then

        select a.vid,nvl(a.ostx,0)
        INTO   l_vid,l_ostx
        from accounts a, nd_acc n, cc_deal d,cc_add ca
        where d.nd  = ND_ and a.acc=n.acc and d.nd=n.nd and a.tip='LIM' and rownum=1;
    -- ������� ������ � ������ ����� ������������ ����� ���������� ��������
    -- ��� ������ ������ ����� � ��������� != ����� � ������� �� ����� �������� �� ���� ���������
    -- ��� �������� �������� ����� ���������� get_info_upb_ext
    if l_vid=2 then
       nSS_:=CCK_PLAN_SUM_POG(ND_, KV_,l_vid,l_ostx,CC_PAY_S)/100;
      --       nSS_:=CCK_PLAN_SUM_POG(ND_, KV_,l_vid,l_ostx,CC_PAY_S)/100+nSSP_;
      --         logger.trace ('PAY_CCK: CCK_PLAN_SUM_POG = '||to_char(nSS_-nSSP_));
         logger.trace ('PAY_CCK: CCK_PLAN_SUM_POG = '||to_char(nSS_));
    end if;
   end if;

  -- ��������� ��� �������� � �������
  nSS1_:=nvl(nSS1_,0)*100;
  nSS_:=nvl(nSS_,0)*100;

  If sum1_< nSS1_+nSN_+(case when KV_=KV_KOM_ and KV_KOM_=gl.baseval then nSK_ else 0 end)
  then
     -- ��� ������������� ������
     sum1D_:= (nSN_) * 100; -- ����� ������� �� ���.����� ��������
     sum1M_:= (nSK_) * 100; -- ����� ������� �� ���.����� ��������
  else
     -- ��� ������������� ������
     sum1D_:= (nSN1_) * 100; -- ����� ������� �� ���.����� ��������
     sum1M_:= (nSK1_) * 100; -- ����� ������� �� ���.����� ��������
  end if;
 logger.trace ('PAY_CCK: 8');
-- ��������� ��������� � ����� �����
  sum1T_P_:=nvl(nSSP_ ,0)* 100;
  sum1D_P_:=nvl(nSSPN_,0)* 100;
  sum1M_P_:=nvl(nSSPK_,0)* 100;
-- �������� ��������� �� ����� ����� ������� � ��������
  sum1D_:=sum1D_-sum1D_P_;
  sum1M_:=sum1M_-sum1M_P_;

/*
  sum1M_ := least(Sum1_,sum1M_);
  Sum1_  := Sum1_ - sum1M_;
  sum1D_ := least(Sum1_,sum1D_);
  Sum1_  := Sum1_ - sum1D_;
  sum1T_ := sum1_ ; --����� ����� ������� �� ���� ��
*/
/*
nSSP_
nSSPN_
nSSPK_
*/
     -- � get_info_upb ��� ���������� ���������� � ������������ ����
  for p in (select tip from cc_rang r
             where  r.rang=nvl((select txt from nd_txt where tag ='CCRNG' and nd=nd_),1)
                    and r.tip <> (case when KV_KOM_=gl.baseval and KV_KOM_=KV_  then 'ODB' else 'SK0' end)
                    and r.tip <> (case when KV_KOM_=gl.baseval and KV_KOM_=KV_  then 'ODB' else 'SK9' end)
                    and substr(nls_SG,1,2)!='26'
             order by ord
           )
  loop
  logger.trace ('PAY_CCK: '||p.tip);
     if p.tip='SPN' then
           sum1D_P_ := least(Sum1_,sum1D_P_);
           Sum1_  := Sum1_ - least(Sum1_,sum1D_P_);
           flg_spn:=1;
              logger.trace ('PAY_CCK: SPN='||to_char(sum1D_P_)||' SUM1_='||to_char(Sum1_));
     elsif p.tip='SK9' then
           sum1M_P_ := least(Sum1_,sum1M_P_);
           Sum1_  := Sum1_ - least(Sum1_,sum1M_P_);
           flg_sk9:=1;
              logger.trace ('PAY_CCK: SK9='||to_char(sum1M_P_)||' SUM1_='||to_char(Sum1_));
     elsif p.tip='SP ' then
           sum1T_P_ := least(Sum1_,sum1T_P_);
           Sum1_  := Sum1_ - least(Sum1_,sum1T_P_);
           flg_sp:=1;
              logger.trace ('PAY_CCK: SP ='||to_char(sum1T_P_)||' SUM1_='||to_char(Sum1_));
     elsif p.tip='SN'  then
           sum1D_ := least(Sum1_,sum1D_);
           Sum1_  := Sum1_ - least(Sum1_,sum1D_);
           flg_sn:=1;
              logger.trace ('PAY_CCK: SN ='||to_char(sum1D_)||' SUM1_='||to_char(Sum1_));
     elsif p.tip='SK0' then
           sum1M_ := least(Sum1_,sum1M_);
           Sum1_  := Sum1_ - least(Sum1_,sum1M_);
           flg_sk0:=1;
              logger.trace ('PAY_CCK: SK0='||to_char(sum1M_)||' SUM1_='||to_char(Sum1_));
     elsif p.tip='SS ' and Sum1_>0 then
               logger.trace ('PAY_CCK: Sum advanced Sum1='||to_char(Sum1_)||'nSS1='||to_char(nSS1_)||'sum1T_P='||to_char(sum1T_P_)||'nSS='||to_char(nSS_));
               -- ����� ������ < ���� �������( ���� + ���������, ���� ������)
           if nvl(nSS_,0)<least(Sum1_+sum1T_P_,nSS1_) and kv_=gl.baseval then
             begin
                 logger.trace ('PAY_CCK: SK4 - OK!' );
               -- ����������� ������ ���-��� �� ��������� ��������� ��������� �� ����������� ������ CCK.CC_ASG
               select a.acc,
                     nls_SG,
                     n.stp_dat
                    --  (select nls from accounts where acc=decode(n.acrb,null,cc_o_nls('8999',RNK_,4,ND_,KV_,'SD4') ,n.acrb))
                 into acc8_ ,nls_6110,SK4_stp_dat
                 from accounts a, int_accn n,nd_acc na
                where n.acc=a.acc and a.tip='LIM' and na.nd=ND_ and na.acc=a.acc and n.id=4 and rownum=1;

               ratn_advanced:=acrn.fprocn(ACC8_,4,gl.bd)/100;
                -- ��������� ������� ����� ������ �������������� ���� ������
               if ratn_advanced is null or ratn_advanced=0 then
                  select max(ir)/100 into ratn_advanced
                    from  int_ratn where acc=acc8_ and br is null and id=4 and
                          bdat=(select max(bdat) from int_ratn
                                 where acc=acc8_ and bdat<=gl.bd and id=4
                               );
               end if;
               logger.trace ('PAY_CCK: Ratn_Advanced = '||to_char(ratn_advanced));
               if nvl(ratn_advanced,0)>0 and (SK4_stp_dat is null or SK4_stp_dat>gl.bd) then
                      -- ���� ����� ��������
                      sum1A_:=(nSS1_-nSS_)*ratn_advanced;
                         logger.trace ('PAY_CCK: SK4 - MAX= '||to_char(sum1A_));
--                         logger.trace ('PAY_CCK: SK4 - sum1A_='||to_char(sum1A_) );
                     -- ��������+ ����������� ���� ��� ���������
                  if  (sum1A_+nSS1_)>Sum1_+sum1T_P_ then -- ������� ������ � ��������� ����������
                      sum1A_:=trunc((Sum1_+sum1T_P_-nSS_)*ratn_advanced/(1+ratn_advanced));
                        logger.trace ('PAY_CCK: SK4 - SUM= '||to_char(sum1A_));

                  end if;

                  Sum1_:=Sum1_-sum1A_;
               end if;
             exception when no_data_found then null;
             end;
           end if;
          -- flg_ss :=1;

     end if;


  end loop;
 -- ������� ����� �� �������� ������� ����������� � ������� �������
 -- (������� �� ��������� ������)
  if   flg_spn=0 then sum1D_P_ :=0; end if;
  if   flg_sk9=0 then sum1M_P_  :=0; end if;
  if   flg_sp =0 then sum1T_P_ :=0; end if;
  if   flg_sn =0 then sum1D_   :=0; end if;
  if   flg_sk0=0 then sum1M_   :=0; end if;
--  if   flg_ss =0 then sum1D_P_ :=0; end if;


  sum1T_ := sum1_ + nvl(sum1T_P_,0);        --����� ����� �������  �� ���� ��
  sum1D_ :=nvl(sum1D_,0) + nvl(sum1D_P_,0); --����� ����� �������  �� ��
  sum1M_ :=nvl(sum1M_,0) + nvl(sum1M_P_,0); --����� ����� �������� �� ��
 logger.trace ('PAY_CCK: 11');
  -- ������������� ���� ����
  if (sum1T_+ sum1D_+sum1M_+sum1A_) = (sum11_ - (sn8_+sk0)) then
      null;
  else
      raise_application_error(-20001,'������ ������ ��������� CCK_PAY_UPB');
  end if;

  -- ������ ��� ���� ������ 5000000
  Sum1B_ := sum1T_ + sum1D_ + sum1M_;

  bars_audit.trace('PAY_CCK_UPB: D='||sum1D_||', M='||sum1M_||', T='||sum1T_ ||', B='||Sum1B_ );

  If sum1T_ >0 then
     if substr(nls_SG,1,2)='26' then
        pay_no(nls_1002,nls_SG,'CCK');
        gl.payv(flg_,ref_, DAT_, tt_, 1,kv_,nls_1002,sum1T_,kv_,nls_SG,sum1T_);
        --update opldok set txt='����������� ����� �� �������� �������' where stmt=gl.aSTMT and ref=ref_; --COBUMMFO-6212
		  update opldok set txt='����������� ����� ��� ��������� �������' where stmt=gl.aSTMT and ref=ref_;
     else
        pay_no(nls_1002,nls_SG,'CCM');
     gl.payv(flg_,ref_, DAT_, tt_, 1,kv_,nls_1002,sum1T_,kv_,nls_SG,sum1T_);
     update opldok set txt='��������� ����� �� �i�� ��' where stmt=gl.aSTMT and ref=ref_;
  end if;
  end if;

  If sum1D_ >0 then
     gl.payv(flg_,ref_, DAT_,'CCD',1,kv_,nls_1002,sum1D_,kv_,nls_SG,sum1D_);
     update opldok set txt='��������� ����������� ����� �� ��' where stmt=gl.aSTMT and ref=ref_;
  end if;

  If sum1M_ >0 then
     gl.payv(flg_,ref_, DAT_,'CCM',1,kv_,nls_1002,sum1M_,kv_,nls_SG,sum1M_);
     update opldok set txt='��������� ���i�i����� ����� �� ��' where stmt=gl.aSTMT and ref=ref_;
  end if;

  If sum1A_ >0 then
     gl.payv(flg_,ref_, DAT_,'CCA',1,kv_,nls_1002,sum1A_,kv_,nls_6110,sum1A_);
     update opldok set txt='������ ���i�i����� ����� �� ���������� ��������� �� ��' where stmt=gl.aSTMT and ref=ref_;
  end if;

    -- ����� ������
  L_ALLSUM_FOR_VP:=sum11_ - (sn8_+sk0); -- ����� ������� ������� ����������� � ������ �������
    -- ������ ������� ������
  l_del_vp:=(case when kv_=978 then MOD(L_ALLSUM_FOR_VP,500) else MOD(L_ALLSUM_FOR_VP,100) end);
  If L_ALLSUM_FOR_VP >0 and kv_<>gl.baseval and l_del_vp!=0 then

     -- ����������� �����
     l_del_vp:=(case when kv_=978 then 500 else 100 end) - l_del_vp;

     if l_del_vp>0 then
       gl.payv(flg_,ref_, DAT_,'VPF',1,kv_,nls_1002,l_del_vp,gl.baseval,nls_1002, eqv_obs(kv_,l_del_vp,gl.bd,1));
       update opldok set txt='����� ������i��� ������� ������ �� ����� ���i��i' where stmt=gl.aSTMT and ref=ref_;
       -- ������ ���� ������� �� ������ � ������� ������ ������
       BEGIN
         SELECT rate_b/bsum into  rate_
           FROM cur_rates
          WHERE (kv,vdate) =
                (SELECT kv, MAX(vdate) FROM cur_rates
                  WHERE vdate <= gl.bd AND kv = kv_
                  GROUP BY kv );
       EXCEPTION
          WHEN NO_DATA_FOUND THEN
          raise_application_error(-20001,' CCK_PAY_UPB �� ���������� ���� ��� ������ '||TO_CHAR(kv_));
       END;
       INSERT INTO operw (ref,tag,value) VALUES (REF_,'KURS', rate_ );
     end if;
  end if;



  If kv_ <>gl.baseval then
     --� ��������
     INSERT INTO operw (ref,tag,value) VALUES (REF_,'KOD_B', '25' );
     INSERT INTO operw (ref,tag,value) VALUES (REF_,'KOD_G','804' );
     INSERT INTO operw (ref,tag,value) VALUES (REF_,'KOD_N','8446');
     INSERT INTO operw (ref,tag,value) VALUES (REF_,'D#73' ,'246' );
     If sum1D_ >0 then
        INSERT INTO operw (ref,tag,value) VALUES (REF_,'73CCD' ,'246');
     end if;
     If sum1M_ >0 then
        INSERT INTO operw (ref,tag,value) VALUES (REF_,'73CCM' ,'270');
     end if;
  end if;

  -- ���� ���������� ����� ������� nSum > 50 000.00 (���)
  -- � 25/07/2012 ��������� � �������� �������� � ���������� ������
  SumQB_ := gl.p_icurval(kv_, Sum1B_, gl.BDATE);
--  If SumQB_ > 5000000 or l_del_vp>0 then
     begin
        SELECT k.name,
               p.SER   ||' '|| p.NUMDOC,
               p.ORGAN ||' '|| To_char(p.PDATE,'dd/mm/yyyy'),
               to_char(p.BDAY,'dd/mm/yyyy')
        INTO PASP_,PASPN_,ATRT_, DT_R_
        from PASSP k, person p
        where p.rnk= RNK_ and NVL(p.PASSP,1)=k.PASSP (+) ;
        INSERT INTO operw (ref,tag,value) VALUES (REF_,'PASP', PASP_ );
        INSERT INTO operw (ref,tag,value) VALUES (REF_,'PASPN',PASPN_);
        INSERT INTO operw (ref,tag,value) VALUES (REF_,'ATRT', ATRT_ );
        INSERT INTO operw (ref,tag,value) VALUES (REF_,'DT_R', DT_R_ );
        INSERT INTO operw (ref,tag,value) VALUES (REF_,'ADRES',ADRES_);
     exception when NO_DATA_FOUND THEN null;
     end;
--  end if;
end PAY_CCK_UPB;
/
show err;

PROMPT *** Create  grants  PAY_CCK_UPB ***
grant EXECUTE                                                                on PAY_CCK_UPB     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PAY_CCK_UPB.sql =========*** End *
PROMPT ===================================================================================== 
