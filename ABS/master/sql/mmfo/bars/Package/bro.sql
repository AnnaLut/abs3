CREATE OR REPLACE PACKAGE BARS.BRO IS

 G_HEADER_VERSION  CONSTANT VARCHAR2(64)  :=  'ver.3/ 19.07.2017';
 ern CONSTANT POSITIVE := 203;  erm VARCHAR2(250);  err EXCEPTION;
/*

                   ������ ��� ���� ��� ����� ���� ������
                   --------------------------------------

 19.07.2017 ����� ����� 2600 �� ���
 15.10.2015 ������ ������ ��.�������� = BRO_OB = ����� ���������������� ������ ��� � ��.�����
 20.08.2015 ������ ��������� ���� ���������� ������ INT_BRO
 ����� �� ��������� ������-������ ����������� ������ ������������ ������� �� ������ ���.�������
 ���������� Bars027.apd
*/
   BRO_OB varchar2(1);
---================================================================


PROCEDURE INT_BRO_LAST_DAY ( p_dat date) ;

PROCEDURE INT_BRO ( p_dat date) ;



-- O������ ����� ������� � ��������:
PROCEDURE Ins0 ( p_Rnk   in     number,
                 p_ACC   in     number,
                 p_cc_id in     varchar2,
                 p_sdate in     date,
                 p_wdate in     date,
                 p_lim   in     number,
                 p_ir    in     number,
                 p_isp   in     number,
                 p_kv    in     number,
                 p_NLS   in     varchar2
               );

PROCEDURE Ins1 ( p_ND    IN OUT number,
                 p_ACC   IN     number,
                 p_cc_id in     varchar2,
                 p_sdate in     date,
                 p_wdate in     date,
                 p_lim   in     number,
                 p_ir    in     number,
                 p_isp   in     number,
                 p_kv    in     number,
                 p_NLS   in     varchar2
               ) ;

------------------------------------------------------

-- �������� ��������� ��������:

PROCEDURE Upd0 ( p_ND    in     number,
                 p_ACC   in     number,
                 p_cc_id in     varchar2,
                 p_sdate in     date,
                 p_wdate in     date,
                 p_lim   in     number,
                 p_ir    in     number,
                 p_KV    in     number,     ---
                 p_NLS   in     varchar2,   ---
                 p_isp   in     number,
                 p_FL1   in     int )
                ;


PROCEDURE Upd1 ( p_ND    in     number,
                 p_ACC   in     number,
                 p_cc_id in     varchar2,
                 p_sdate in     date,
                 p_wdate in     date,
                 p_lim   in     number,
                 p_ir    in     number,
                 p_KV    in     number,     ---
                 p_NLS   in     varchar2,   ---
                 p_isp   in     number)
                ;

------------------------------------------------------
-- ������� �������:

PROCEDURE Del1 ( p_ND    IN     number) ;

------------------------------------------------------
-- H������� ���� ������ p_mode:

PROCEDURE Visa( p_nd     in     number,
                p_lim    in     number,
                p_ir     in     number,
                p_mode   IN     number) ;
------------------------------------------------------
-- K������������ ����������� �������� ���������:

procedure BONUS (p_nd   IN  number  ,
                 p_mfob IN  varchar2,
                 p_nlsb IN  varchar2,
                 p_nmsb IN  varchar2,
                 p_REF  OUT number  ) ;
------------------------------------------------------

procedure CLOS_1 (p_nd IN number);
-- �������� 1 �������a

------------------------------------------------------

procedure CLOS_ALL (p_dat IN  date);
-- O������ �������� ���������, ���� ������� ��������.
-- ������������ �� ������ ���.

-------------------------------------------------------

/**
 * header_version - ���������� ������ ��������� ������ BRO
 */
function header_version return varchar2;

/**
 * body_version - ���������� ������ ���� ������ BRO
 */
function body_version return varchar2;
-------------------

END BRO;
/




CREATE OR REPLACE PACKAGE BODY BARS.BRO IS
 G_BODY_VERSION  CONSTANT VARCHAR2(64)  :=   'ver.4 15.11.2017';

/*
                       ������ ��� ���� ��� ����� ���� ������
                       --------------------------------------

 15.11.2017 Sta TransFer-2017  : 6399.L1 => 6350.L1,  6399.L2 => 6350.L2 

 19.07.2017 Suf COBUSUPMMFO-686 + COBUMMFOTEST-1274
 19.07.2017 ����� ����� 2600 �� ���
 23.10.2017 Sta �� ������ ���� ��� ��������� ���. ��������
 12.04.2015 Sta ������-����� � ����.�� �� ���������� � �������
 07.04.2016 Sta ������� ������ �� �� �� ����.��������
                ���.�������� ND = ��� ��� �� ��������� �� ����������/����������� �������� ���������
                ���.�������� ND = ��� ��� �� ��������� �� ������� �������� ���������

 19.02.2016 Sta  ��.�������� = BRO_OB = 1 =����� ���������������� ������ ��� � ��.�����
 17.02.2016 Sta ��� �������  ������� ���� BRO �������� � ���� �������� acra
                � ���������� ������� ���   ���������� %  �  ������� %
 09-12-2015 ������+������ �������� ��� � ����� ���
 07-12-2015 ������+������ ���� �� (������������. ���������� �������� - ������ "������"
 15.10.2015 ������ ������ ��.�������� = BRO.BRO_OB = ����� ���������������� ������ ��� � ��.�����
            1.���������� ��������� ������� ������� ������������. �������� �� ������������ ������� ������ ���������� �������� ����� ��� ����� ���� ����������� �� ����� � ������.
              ��������� �� ��������� BRO.BRO_OB =1
            2.�������� ������������ ������ ���������� ���������� � ��������� ��������� ������.
              ����������  �� ��������� BRO.BRO_OB =1
            4.���������� �������� ���������� ������� ��� ������� ��������� �� ���������� ������� �������� �� ��������� ���� �� ��������� ������� ����� ���. ����� �___ �� _____ �� ���. ����. ������� �_____ �� ����� ___ ��� (����� ������ �������� �� ������ ���� ������� ������ � ������ � ���� �������� ����������� �����).
              ��������  �� ��������� BRO.BRO_OB =1
            � ���������,  ������� ������, ��.���. � ��.����� 7239

 20-08-2015 C�����. ������������� ����������� ����
 09.08.2013 ������ �.
 ����� �� ��������� ������-������ ����������� ������ ������������ ������� �� ������ ���.�������
 �����: ������-�������� + ����-��������
 ���������� Bars027.apd
*/

nlchr char(2) := chr(13)||chr(10) ;

---------------------------------------------------------------------

PROCEDURE INT_BRO1 ( p_mode int,  -- = +1 - �����������, =  0 - �������
                     p_dat date,
                     dd cc_deal%rowtype
                   ) is
 l_KNL number := 0   ;  l_KDO number := 0  ; l_dni_per int       ;  l_dni_all int  ;
 aa   accounts%rowtype; oo    oper%rowtype  ; aa2 accounts%rowtype;  aa7 accounts%rowtype;  ii int_accn%rowtype;
                                              cc2 customer%rowtype;  cc7 customer%rowtype;
 SB6 sb_ob22%rowtype ;  --- ���� 6* ��� �������� %% ��� ����������� ������

 txt_6  varchar2(254 Byte);
 nls67  varchar2(15);
 nms67  accounts.nms%type;

begin
 If p_mode not in (0,1) then RETURN ; end if;

 begin select * into SB6 from sb_ob22 where r020||ob22 in ('6399L1','6350L1') and d_close is null and rownum = 1;  -- Transfer-2017
 EXCEPTION WHEN NO_DATA_FOUND THEN    raise_application_error(-20100,'BRO-30.�� ������� ���. 63**');
 end ;
--------------------------------------------------
 OP_BS_OB  (P_BBBOO => SB6.R020||       SB6.OB22) ; -- ��������� �������� 6399/L1
 OP_BS_OB  (P_BBBOO => SB6.R020||Substr(SB6.OB22,1,1) ||'2')  ; -- ��������� �������� 6399/L2

 begin select to_number(txt) into l_KNL from nd_txt where nd = dd.nd and tag ='KNL';  EXCEPTION WHEN NO_DATA_FOUND THEN null;  end;
 begin select to_number(txt) into l_KDO from nd_txt where nd = dd.nd and tag ='KDO';  EXCEPTION WHEN NO_DATA_FOUND THEN null;  end;

 If l_KDO >  l_KNL then
    raise_application_error(-20100,'BRO-77.���� �����.������ = '|| (l_KDO/100 ) || ' > �������� ���� ������='|| (l_KNL/100) );
 end if;

 oo.dk := p_mode;

 begin
    select a.* into aa  from accounts a, nd_acc n where n.nd  = dd.nd  and n.acc = a.acc  and a.nbs like '26%'   and a.rnk = dd.rnk  ;
    select i.* into ii  from int_accn i           where i.acc = aa.acc and  i.id = 1      and i.acra is not null and i.acrb is not null ;
    select a.* into aa7 from accounts a           where   acc = ii.acrb ;                   --- 7020
    select a.* into aa2 from accounts a           where  rnk  = dd.rnk and tip   = 'BRO' ;  --- 2608/BRO
    select c.* into cc7 from customer c  where c.rnk = aa7.rnk ;
    select c.* into cc2 from customer c  where c.rnk = aa2.rnk ;
 EXCEPTION WHEN NO_DATA_FOUND THEN    raise_application_error(-20100,'BRO-30.�� ������� ���. ��� ����������� ������');
 end;


 If p_mode = 1 then            if l_KDO = l_KNL then return; end if;

    If p_dat >  dd.wdate then
       oo.nazn  := to_char(dd.wdate,'dd.mm.yyyy');
       oo.s     := greatest (l_KNL - l_KDO , 0);
    else
       oo.nazn:= to_char(p_dat   ,'dd.mm.yyyy');
    --   l_dni_per:= (p_dat   - dd.sdate) ;
    --   l_dni_all:= (dd.wdate-dd.sdate ) ;
    --   oo.s     := round ( l_KNL * l_dni_per/l_dni_all, 0) - l_KDO ;
    --   C�����:  "�������" ������ ������������� %%

       oo.s :=  calp ( s_     => dd.limit*100,                                 -- ����� ��������
                       int_   => (dd.ir - acrn.fprocn (aa.acc, 1, dd.Sdate )), -- ���.����.������
                       dat1_  => dd.sdate+1    , -- ���� "�"  �������������
                       dat2_  => p_dat         , -- ���� "��" ������������
                       basey_ => ii.basey        -- ��� ���� ����������
                     )  - l_KDO ;


    end if;


    ---                                   � � � � � � � �   !
    ---  � NAZN �������� ������ ������������ ��� ���, ��� ������� ������� ������ �� ���� dd.wdate         !!!
    ---  �� ������ �� ������ �������� ������ ������������ ��� ���, ��� ������� ������� ������ �� gl.BDATE !!!

    oo.nazn     := Substr(
       '%% �� ���.' ||aa.nls   ||' �� ' || oo.nazn ||' ���. '||'������ ' || ( dd.ir - acrn.fprocn (aa.acc, 1, dd.Sdate ) ) ||
       '%. ����� � '||dd.cc_id ||' �� '||to_char(dd.sdate,'dd.MM.yyyy') || ' �.', 1,160) ;


    nls67 := aa7.nls;          ---  7020  (ACRB �� ����.����.2600)
    nms67 := aa7.nms;

 Else   if l_KDO <= 0 then RETURN; end if;

    oo.s     := l_KDO ;
    oo.nazn  := substr( '���������� ����������� ������� ����� ����� � '||dd.CC_ID||' �� '||to_char(dd.sdate,'dd.MM.yyyy')||' � ��`��� � ����������� ������������� ��������� ����',1,160);

    if aa.KV = gl.baseval then SB6.ob22 := Substr( SB6.ob22 ,1,1) ||'1';
    else                       SB6.ob22 := Substr( SB6.ob22 ,1,1) ||'2';
    end if;

    Begin --  6399 ��� �������� ���.%%  ��� ����������� ������
      Select NLS,NMS into nls67,nms67 from Accounts where BRANCH = substr(aa.BRANCH,1,15) and  NBS = SB6.R020 and OB22 = SB6.Ob22 and KV = gl.baseval and  DAZS is NULL and rownum=1;
    EXCEPTION WHEN NO_DATA_FOUND THEN    nls67 := aa7.nls;    nms67 := aa7.nms;            --  7020  (ACRB �� ����.����.2600)
    end;


 End If;

 If oo.s < 1       then return; end if;
 ----------------------------

  if aa2.kv <> gl.baseval then  oo.s2 := gl.p_icurval( aa2.kv, oo.s, gl.bdate);
  else                          oo.s2 := oo.s ;
  end if ;

  gl.ref (oo.REF);
  gl.in_doc3(ref_  => oo.REF,  tt_ => '%%1', vob_  => 6,          nd_    => substr(dd.cc_id,1,10),  pdat_=> SYSDATE , vdat_=> gl.BDATE,  dk_ => 1-oo.dk,
             kv_   => aa2.kv,  s_  => oo.S , kv2_  => gl.baseval, s2_    => oo.s2,    sk_ => null,  data_=> gl.BDATE, datp_=> gl.bdate,
             nam_a_=> substr(aa2.nms,1,38) , nlsa_ => aa2.nls,    mfoa_  => gl.aMfo,
             nam_b_=> substr(nms67,1,38)   , nlsb_ => nls67  ,    mfob_  => gl.aMfo,
             nazn_ => oo.nazn, d_rec_=>null, id_a_ => cc2.okpo, id_b_=> cc7.okpo, id_o_=> null, sign_=> null, sos_=> 1,   prty_ => null,  uid_   => null);
  gl.payv (0, oo.REF, gl.bDATE, '%%1', 1-oo.dk, aa2.kv, aa2.nls, oo.s, gl.baseval, nls67, oo.s2);
  gl.pay  (2, oo.REF, gl.bDATE );

  insert into operw (ref,tag, value) values (oo.ref, 'ND   ', to_char( dd.nd) );

  l_KDO  := l_KDO + (2*oo.dk-1) * oo.s ;  update nd_txt set txt = to_char(l_KDO) where nd = dd.nd and tag = 'KDO'   ;
  if SQL%rowcount = 0 then  insert into nd_txt (nd,tag, txt ) values (dd.nd, 'KDO', to_char (l_KDO) ) ; end if; -- ������� ��� ��������� �� �� BRO

end INT_BRO1 ;

------------------------------------------------------------------------
PROCEDURE INT_BRO_LAST_DAY ( p_dat IN date) is
  l_Bdat_Real date ;
  l_Bdat_Next date ;
  l_dat31     date ;

--- ���������� %% � ����.���.���� ������

Begin
  l_Bdat_Real := nvl( p_dat,gl.BDate) ;
  l_Bdat_Next := DAT_NEXT_U (l_Bdat_Real,1) ;

  If to_number( to_char ( l_Bdat_Next, 'YYMM' ) ) > to_number ( to_char ( l_Bdat_Real, 'YYMM' ) ) then
     l_dat31 := trunc (l_Bdat_Next, 'MM') - 1;
     bro.INT_BRO ( l_dat31 );
  end if;

END INT_BRO_LAST_DAY;

------------------------------------------------------------------------

PROCEDURE INT_BRO ( p_dat IN date) is
 --������� ���������� ������ �� ����������� ���.
begin for dd in (select * from cc_deal where vidd=26 and sos = 10 and wdate >= gl.bdate)
      loop  bro.INT_BRO1 ( +1, p_dat,  dd ) ;  end loop;
end  INT_BRO;

------------------------------------------------------------------------

PROCEDURE CHK_2600 ( p_ACC IN  number) is   aa accounts%rowtype ;
begin
  If p_acc is null  then  raise_application_error(-20100,'BRO-10.�� ������� ���.���. ');   end if;

  begin  select * into aa from accounts where acc = p_acc;
  EXCEPTION WHEN NO_DATA_FOUND THEN  raise_application_error(-20100,'BRO-11.�� �������� ���.���, p_acc='||p_acc);
  end;

  If aa.pap <> 2 Or aa.lim > 0 or aa.blkd > 0 or aa.dazs is not null then
     raise_application_error(-20100,'BRO-12.��������� ���.'|| aa.nls || ' �� ���������� ������ ����������:' ||
                             nlchr||'��������, ��� ���, �� ����������, �� ��������');
  end if;

  begin  select acc  into aa.acc from int_accn where acc = p_acc and id = 1;
  EXCEPTION WHEN NO_DATA_FOUND THEN  raise_application_error(-20100,'BRO-13.��� ���.��� '||aa.nls|| ' �� ������� ��� �����.%');
  end;

end CHK_2600;

---================================================================
PROCEDURE Ins0 ( p_Rnk   in     number,
                 p_ACC   in     number,
                 p_cc_id in     varchar2,
                 p_sdate in     date,
                 p_wdate in     date,
                 p_lim   in     number,
                 p_ir    in     number,
                 p_isp   in     number,
                 p_kv    in     number,
                 p_NLS   in     varchar2
               )
               is
  l_nd number;
  aa   accounts%rowtype;
begin
  aa.nls := p_nls ;
  aa.KV  := Nvl( p_Kv, gl.baseval);
  aa.acc := p_acc ;
  aa.Rnk := p_Rnk ;

  If aa.NLS is null  and aa.acc is null   AND aa.RNK is    null then
     raise_application_error(-20100,'BRO-x1.�� ������� �������� ��� ������ ������� ���������� ' );
  end if;

  If aa.NLS is null  and aa.acc is null   AND aa.RNK is NOT null then
     begin select * into aa from accounts where rnk = aa.Rnk and kv = aa.Kv and nbs ='2600' and dazs is null ;
     EXCEPTION WHEN NO_DATA_FOUND THEN  raise_application_error(-20100,'BRO-x2.�� �������� ������� ������� �볺��� '|| aa.Rnk || '  � ���.'|| aa.Kv);
               when TOO_MANY_ROWS then  raise_application_error(-20100,'BRO-x3.�������� ����� ������ ���. �볺��� '|| aa.Rnk || '  � ���.'|| aa.Kv);
     end;
  end if;

  bro.ins1 ( l_ND, aa.ACC, p_CC_ID, p_SDATE, p_WDATE , p_LIM, p_IR, p_ISP, aa.KV, aa.NLS);

end Ins0;

PROCEDURE Ins1 ( p_ND    in OUT number,
                 p_ACC   in     number,
                 p_CC_ID in     varchar2,
                 p_SDATE in     date,
                 p_WDATE in     date,
                 p_LIM   in     number,
                 p_IR    in     number,
                 p_ISP   in     number,
                 p_KV    in     number,
                 p_NLS   in     varchar2 ) is

  l_acc number;

begin                           ----   ������ � SOS = 0 :

  if  p_ACC is not null then

      bro.CHK_2600 (p_acc);
      SELECT bars_sqnc.get_nextval('S_CC_DEAL') INTO p_ND FROM dual;
      INSERT into CC_DEAL (nd, user_id, SOS, RNK, cc_id, sdate, wdate, LIMIT, IR, VIDD)
      select p_nd, nvl(p_isp,gl.aUid), 0 , a.RNK, p_CC_ID, nvl(p_sdate, gl.bdate), p_wdate, p_lim,p_IR, 26  from   accounts a  where  a.acc = p_ACC ;

      INSERT into ND_ACC(nd,acc) values (p_ND,p_ACC);

  else
      begin Select ACC into l_acc From Accounts where KV=p_kv and NLS=p_NLS;
      EXCEPTION WHEN NO_DATA_FOUND THEN  raise_application_error(-20100,'BRO-x4.�� �������� ���.='||p_nls || '� ���='||p_KV );
      end;

      bro.CHK_2600 (l_acc); SELECT bars_sqnc.get_nextval('S_CC_DEAL') INTO p_ND FROM dual;
      INSERT into CC_DEAL (nd, user_id, sos, RNK, cc_id, sdate, wdate, LIMIT, IR, VIDD)
        select p_nd, nvl(p_isp,gl.aUid),  0, a.RNK, p_CC_ID, nvl(p_sdate, gl.bdate), p_wdate, p_lim,p_IR, 26
        from   accounts a
        where  a.kv = p_KV and a.nls = p_NLS;
      INSERT into ND_ACC(nd,acc) Select p_ND, a.ACC from Accounts a where a.KV=p_kv and a.NLS=p_NLS;

  end if;


end Ins1;

------------------------------------------------------

---- ����������:   ����������� SOS=6

PROCEDURE Upd0 ( p_ND    in     number,
                 p_ACC   in     number,
                 p_cc_id in     varchar2,
                 p_sdate in     date,
                 p_wdate in     date,
                 p_lim   in     number,
                 p_ir    in     number,
                 p_KV    in     number,      ---
                 p_NLS   in     varchar2,    ---
                 p_isp   in     number,
                 p_FL1          int ) is

begin

  If p_fl1 = 0 then
     bro.Upd1 ( p_ND,p_ACC,p_cc_id,p_sdate,p_wdate,p_lim,p_ir,p_KV,p_NLS,p_isp  );
  else
     BRO.Visa(p_ND, p_lim, p_ir, 6);
  end if;

end UPD0;


PROCEDURE Upd1 ( p_ND    in     number,
                 p_ACC   in     number,
                 p_cc_id in     varchar2,
                 p_sdate in     date,
                 p_wdate in     date,
                 p_lim   in     number,
                 p_ir    in     number,
                 p_KV    in     number,     ---
                 p_NLS   in     varchar2,   ---
                 p_isp   in     number) is

  l_acc number;

  -- �������� ��������� ��������
begin
  Select ACC into l_acc From Accounts where KV=p_kv and NLS=p_NLS;
  bro.CHK_2600 (l_acc);
  update nd_acc set acc = l_acc where nd = p_nd;
  UPDATE cc_deal d set  user_id = nvl(p_ISP,d.user_id),
                        rnk     = (select rnk from accounts where acc = l_acc),
                        cc_id   = p_CC_ID,
                        sdate   = nvl(p_sdate, gl.bdate),
                        wdate   = p_wdate,
                        limit   = p_lim,
                        IR      = p_IR
      where SOS in (0,6) and nd = p_nd and vidd = 26 ;
end Upd1;

---------------------------------------------------------

PROCEDURE Del1 ( p_ND  IN number)   is
  -- ������� �������
  dd cc_deal%rowtype;
  l_acc number;
  nTmp_ number;
begin
  begin select * into dd from cc_deal where nd = p_nd and sos in (0,2,6) and vidd = 26;
     If dd.sos = 6 then        --������� �����
        select acc into l_acc from nd_acc where nd = p_nd;
        nTmp_ :=dd.LIMIT * 100;
     -- update accounts set lim=lim + nTmp_ where acc = l_ACC ; -- 19.07.2017 ��������������  ������� COBUSUPMMFO-686
     end if;
     delete from nd_acc  where nd = p_nd ;
     delete from cc_deal where nd = p_ND ;
  EXCEPTION WHEN NO_DATA_FOUND THEN null;
  end;

end Del1;
------------------------------------------------------

PROCEDURE Visa( p_nd     in     number,
                p_lim    in     number,
                p_ir     in     number,
                p_mode   IN     number) is
-- �������� ���� ������ p_mode
   dd  cc_deal%rowtype  ;
   aa  accounts%rowtype ;
   ii  int_accn%rowtype ;

   aa1 accounts%rowtype ;    -- 2608/1 - �������
   aa2 accounts%rowtype ;    -- 2608/2 - ��� ������
   p4_ int ;
   --------------------

   -- p_mode = 2  : old.sos = 0 ->  new.sos = 2    -- �� ������������. ������ �� ����������, ������ cc_deal.sos= 2

   -- p_mode = 6  : old.sos = 2 ->  new.sos = 6    -- ��������� ������  �� ����� � ��������� �� ����.������� �� �������������
   -- p_mode =10  : old.sos = 6 ->  new.sos =10    -- ��������� ������ + ������������� ���� � ��������
                                                   -- �������� ����.����� ��� ���.% �� �������� % ������
   -- p_mode =15  : old.sos =10 ->  new.sos =15/14
   -----------------------------------------------

   l_lim   number := p_lim * 100;
   l_99    number := 999999999999999 ;
   l_br    number ;
   l_name  varchar2(35);
   l_ir    number ;
   l_int   number ;
   l_acr_dat date ;
   l_bdat    date ;
   l_ost   number ;
begin

  begin select * into dd from cc_deal where vidd = 26 and nd = p_nd and sos =
                 CASE WHEN p_mode =  2                      THEN   0
                      WHEN p_mode =  6 and BRO.BRO_OB = '0' THEN   2
                      WHEN p_mode =  6 and BRO.BRO_OB = '1' THEN   0
                      WHEN p_mode = 10                      THEN   6
                      WHEN p_mode = 15                      THEN  10
                      ELSE                                       100
                      END  ;
--sos in decode(p_mode, 2,0, 6,2, 10,6, 15,10, 100 )
  EXCEPTION WHEN NO_DATA_FOUND THEN   raise_application_error(-20100,'BRO-20.����� '||p_nd|| ' �� ��������');
  end;

  begin select a.* into aa from nd_acc n, accounts a where a.tip <> 'BRO' and n.nd = p_nd and n.acc= a.acc FOR UPDATE OF lim NOWAIT ;
  EXCEPTION WHEN NO_DATA_FOUND THEN raise_application_error(-20100,'BRO-21.�� ������ ���������� ���.���');
  end;

  begin select * into ii  from int_accn  where acc = aa.acc  and id = 1 ;
        select * into aa1 from accounts  where acc = ii.acra ;
        If aa1.NLS not like '___8%' then
            raise_application_error(-20100,'BRO-13.��� ���.% '||aa.nls|| ' �� ������ �� ���8* ');
        end if;
  EXCEPTION WHEN NO_DATA_FOUND THEN   raise_application_error(-20100,'BRO-13.��� ���.��� '||aa.nls|| ' �� ������� ��� �����.%');
  end;

  ----------------------------------------------------------------------------------------------
  If    p_mode = 2  then                                     -- �� ������������. ������ �� ����������, ������ cc_deal.sos= 2
     update cc_deal set sos= 2 where nd = p_ND ;

  ElsIf p_mode =  6  then

     If p_lim > 0    then
        l_ost := (aa.ostc + aa.lim) ;
        If l_ost >= l_lim  then
            update cc_deal  set sos = 6, limit = p_lim where nd  = p_ND;
        ----update accounts set lim = lim - l_lim  where acc = aa.acc;
        else raise_application_error(-20100,'���.��� ���������� ='||p_ND||': ³����� ������� �� ������� = '||(l_ost/100)||' - ����� ���� ����='|| (l_lim/100)||' ');
        end  if;
     else    raise_application_error(-20100,'���.��� ���������� ='||p_ND||': �� ������� ���� ���� ');
     end if;

  ElsIf p_mode=10 then

     --  C���� ����� � Accounts.LIM ����������� ��� ��������� !

     l_ost := (aa.ostc + aa.lim) ;   -- ������� ����� � ����.�������� �� �����
     If l_ost >= l_lim  then
        update accounts set lim = lim - l_lim  where acc = aa.acc;
     else raise_application_error(-20100,'���.��� ���������� ='||p_ND||': ³����� ������� �� ������� = '||(l_ost/100)||' ����� ���� ����='|| (l_lim/100)  );
     end  if;


     l_ir := nvl(acrn.fprocn(aa.acc, 1, dd.Sdate),0);
     If p_ir > l_IR  then                      -- ��������� ������ + ������������� ���� � ��������

        --��������� �������-�������� � ��������� ��
        l_int := calp ( s_     => l_lim,         -- ����� ��������
                        int_   => (p_ir - l_ir), -- ���.����.������
                        dat1_  =>dd.sdate+1    , -- ���� "�"  �������������
                        dat2_  =>dd.wdate      , -- ���� "��" ������������
                        basey_ =>ii.basey        -- ��� ���� ����������
                       );
        delete from nd_txt where nd = p_ND and tag in ('KNL');
        insert into nd_txt ( nd, tag, txt ) values ( p_nd, 'KNL', to_char(l_int) );  -- ������� ����������� ������
        insert into nd_txt ( nd, tag, txt ) values ( p_nd, 'KDO', '0'            );  -- ������� ��� ��������� �� �� BRO
        update cc_deal  set sos = 10, ir = p_ir where nd = p_ND;
        -----------------
        begin select * into aa2 from accounts  where rnk = aa1.rnk and tip = 'BRO' and dazs is null;
        EXCEPTION WHEN NO_DATA_FOUND THEN
              aa2.nls   := F_NEWNLS ( aa1.acc, aa1.tip, aa1.nbs );
              aa2.nms   := '��������� �� ��������� �������' ;
              aa2.kv    := aa1.kv ;
              op_reg ( 99, 0, 0, aa1.grp, p4_, aa1.rnk, aa2.nls, aa1.kv, aa2.nms, 'BRO', aa1.isp, aa2.acc );
              Accreg.setAccountSParam(aa2.Acc, 'OB22', aa1.OB22);
              Update Accounts set TOBO=aa.tobo where ACC=aa2.Acc;
        END;

     else     raise_application_error(-20100,'BRO-03.���.���='||p_ND||'.% ��.������������ :p_ir='||p_ir|| ' <= �������='||l_ir );
     end if;

  ElsIf p_mode = 15 then                  -- ����������

     --  ������ �����-������ �� �����
     update accounts set lim = lim + l_Lim  where acc= aa.ACC ;

     -- �������� ���
     If dd.wdate >= gl.bdate  then  -- ��������� / ������������� % � ������������ ������� �� ��.
        update cc_deal  set sos = 14 where nd = p_ND ;
        bro.INT_BRO1 (  0, dd.wdate, dd ) ;  -- ������� ����
     Else --  ����������
        bro.INT_BRO1 ( +1, dd.wdate, dd ) ;  -- ����������� ����
     end if;

     -- Sos := 15;  -- HE ���������  = ����������.  ���������� � ������������� ����������� �������� ���������
     -- BRO.BONUS (p_nd => p_nd, p_mfob => null, p_nlsb => null, p_nmsb => null, p_REF => l_ref ) ;

     RETURN;

  end if;

end VISA;
------------------------------------------------------
procedure BONUS (p_nd   IN  number  ,
                 p_mfob IN  varchar2,
                 p_nlsb IN  varchar2,
                 p_nmsb IN  varchar2,
                 p_REF  OUT number  ) is

  -- ���������� � ������������� ����������� �������� ���������

  dd cc_deal%rowtype     ;
  cc customer%rowtype    ;
  T_ varchar2(250)       ;
  oo oper%rowtype        ;
  aa accounts%rowtype    ;    -- ���.���� 2600
  ab accounts%rowtype    ;    -- ���� BRO
  ------------------------
  sRKO_D varchar2(100)   ;
  sRKO_N varchar2(100)   ;
  sErr_  varchar2 (100)  := 'BRO-05.BONUS, ���.���='|| p_nd || ' ' ;
  sErr1_ varchar2 (100)  ;

begin

  begin
     sErr1_:='�� �������� ��� (vidd=26 and wdate< gl.bd and sos=10)';  sELECT d.* into dd from cc_deal  d  where d.nd = p_nd and vidd=26 and wdate < gl.bdate and sos= 10;
     sErr1_:='�� �������� �볺��� ��� ����������:rnk='     ||dd.rnk ;  select c.* into cc from customer c  where c.rnk= dd.rnk ;
     sErr1_:='�� �������� ���.���� ���� �����-������� (tag = KNL)';  select txt into T_ from nd_txt      where   nd = p_nd  and tag = 'KNL';
     sErr1_:='������� ���.���� KNL ���� ������ =' || T_             ;  oo.s   :=  to_number(T_) ;          If oo.s <= 0 then return ; end if ;
     sErr1_:='�� �������� ���.��� ���������� (nbs like 26% )'       ;  select a.* into aa from accounts a, nd_acc n where n.nd = p_nd and n.acc = a.acc  and a.nbs like '26%' and a.rnk=dd.rnk  ;
     sErr1_:='�� �������� ���.�����.������(BRO) � ���.>='|| oo.s/100;  select a.* into ab from accounts a  where a.rnk= dd.rnk and tip= 'BRO' and kv=aa.kv and ostc>=oo.s ;
  exception when others then raise_application_error(-20100,sErr_ || sErr1_ );
--  EXCEPTION WHEN NO_DATA_FOUND THEN raise_application_error(-20100,sErr_||sErr1_ );
  end;
  begin select Substr(value,1,100) into sRKO_D from customerw where rnk=aa.RNK and tag='RKO_D'; EXCEPTION WHEN NO_DATA_FOUND THEN null; end;
  begin select Substr(value,1,100) into sRKO_N from customerw where rnk=aa.RNK and tag='RKO_N'; EXCEPTION WHEN NO_DATA_FOUND THEN null; end;

  If BRO.BRO_OB = '1' then
     oo.nazn := substr(
                '������� %% �� ���.'|| aa.nls||
                ' � '  || to_char( dd.sdate, 'dd.mm.yyyy') ||
                ' �� ' || to_char( dd.wdate, 'dd.mm.yyyy') ||
                ' ������ '|| ( dd.ir - acrn.fprocn (aa.acc, 1, dd.Sdate ) ) || '%.'||
                ' ����� � '|| dd.cc_id   || ' �� ' || to_char( dd.sdate, 'dd.MM.yyyy' ) ||'�.' , 1,160);
  else
     oo.nazn := substr(
                       '���.������� %% �� ��������� ���� �� �����/��� ����� ���.��. � '||dd.CC_ID||
                       ' �� ' || to_char( dd.sdate, 'dd.MM.yyyy' )    ||
                       ' �� ���.�����. ���. � ' || sRKO_N || ' �� '  || sRKO_D  ||
                       ' �� ����� ' || to_char (dd.wdate - dd.sdate)  || ' ��.'
           ,1, 160);

  end if;

  oo.nlsa  := ab.nls;
  oo.nam_a := substr( ab.nms,1,38) ;

  -- ���� � ����.�������� ��������� ����� "������� �������".
  -- ���� �� ���� - ����������� %% �� ����.
  BEGIN
     SELECT NLSB, MFOB, substr(NAMB,1,38)
       INTO oo.nlsb, oo.mfob, oo.nam_b
       FROM INT_ACCN
      WHERE acc = aa.acc and ID=1 and NLSB is not null ;
  EXCEPTION WHEN NO_DATA_FOUND THEN
     null;
  END;

  oo.nlsb  :=          NVL(oo.nlsb , aa.nls ) ;
  oo.nam_b :=  Substr( NVL(oo.nam_b, aa.nms ) , 1, 38) ;
  oo.mfob  :=          NVL(oo.mfob, gl.aMfo ) ;
  If oo.mfob = gl.aMfo then oo.tt := 'PS1' ;
  else                      oo.tt := 'PS2' ;
  end if;

  gl.ref (oo.REF);
  gl.in_doc3(ref_  => oo.REF  , tt_   => oo.tt  , vob_ => 6      , nd_  => substr(dd.cc_id,1,10), pdat_=> SYSDATE , vdat_=> gl.BDATE,  dk_=> 1,
             kv_   => ab.kv   , s_    => oo.S   , kv2_ => ab.kv  , s2_  => oo.s,     sk_ => null, data_=> gl.BDATE, datp_=> gl.bdate,
             nam_a_=> oo.nam_a, nlsa_ => oo.nlsa, mfoa_=> gl.aMfo,
             nam_b_=> oo.nam_b, nlsb_ => oo.nlsb, mfob_=> oo.mfob,
             nazn_ => oo.nazn , d_rec_=> null   , id_a_=> cc.okpo, id_b_=> cc.okpo, id_o_=> null, sign_=> null    , sos_ => 1,       prty_=> null, uid_ => null);
   BARS.paytt (0, oo.REF,  gl.bDATE, oo.TT,  1, ab.kv, oo.nlsa,   oo.s, ab.kv,  oo.nlsb, oo.s  );
   insert into operw (ref,tag, value) values (oo.ref, 'ND   ', to_char( dd.nd) );

   update cc_deal  set sos = 15 where nd = p_ND ;
   if oo.ref is not null and oo.mfob = gl.aMfo then      gl.pay (2, oo.ref, gl.bdate );   end if;
   p_REF  := oo.ref;

end BONUS;


------------------------------------------------------

procedure CLOS_1 (p_nd IN number) is
----   ���������� 1 ��������:
 oo oper%rowtype;
begin
  for k in (select * from cc_deal where vidd=26 and sos = 10 and nd = p_nd )
  loop                                                           ----------
        BRO.Visa ( p_nd => k.ND, p_lim  => k.LIMIT, p_ir   => k.IR, p_mode => 15 ) ;
        if k.wdate < gl.bdate then
           BRO.BONUS( p_nd => k.ND, p_mfob => null, p_nlsb => oo.nlsb, p_nmsb => oo.nam_b, p_REF => oo.ref ) ;
        end if;
  end loop;
end  CLOS_1;

------------------------------------------------------

procedure CLOS_ALL (p_dat IN  date) is
----   O������ �������� ���������, ���� ������� ��������.  ������������ �� ������ ���.
 oo oper%rowtype;
begin
  for k in (select * from cc_deal where vidd=26 and sos = 10 and wdate < gl.bdate)
  loop  BRO.Visa ( p_nd => k.ND, p_lim  => k.LIMIT, p_ir   => k.IR, p_mode => 15                   ) ;
        BRO.BONUS( p_nd => k.ND, p_mfob => null   , p_nlsb => oo.nlsb, p_nmsb => oo.nam_b, p_REF => oo.ref ) ;
  end loop;
end  CLOS_ALL;

---------------
function header_version return varchar2 is begin  return 'Package header BRO '||G_HEADER_VERSION; end header_version;
function body_version   return varchar2 is begin  return 'Package body BRO '  ||G_BODY_VERSION  ; end body_version;
--------------

---��������� ���� --------------
begin


-- ��.�������� = BRO_OB = 1 =����� ���������������� ������ ��� � ��.�����
--  begin select '1' into BRO.BRO_OB from params where par = 'BRO_OB' and trim(val) ='1' ;
--  EXCEPTION WHEN NO_DATA_FOUND THEN BRO.BRO_OB := '0' ;
--  end;

    BRO.BRO_OB := '1' ;

END BRO;
/

