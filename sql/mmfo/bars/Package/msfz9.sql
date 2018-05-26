
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/msfz9.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.MSFZ9 IS
  -- Sta 06.02.2018
  NLS_3739 varchar2(15) ; ------ '373959212006';
  NMS_3739 varchar2(38) ; ------'������� ��� ������������ �� (����-9)';

------------------------------------
  procedure PUL9  ( p_NDG cc_deal.ndG%type ) ;


function Get_Prvn ( d_nd  cc_deal.nd%type,   d_ndg cc_deal.ndG%type,  p_nd number,    p_ndo number  ---- ,  p_id  PRVN_FLOW_DEALS_CONST.id%type
                   ) return int ;
  procedure step_x ( p_ndG number          ) ;   --  �������� ���������

  procedure REGU   ( p_nd number, p_KV int ) ;   --  ����������� (��`������/�������� )
  procedure step_2 ( p_tip accounts.tip%type, DD v_MSFZ91%rowtype, oo IN OUT oper%rowtype , p_CR9 varchar2, qum_3600 number ) ;  -- ������ �����-����� ���`�������  ��� 1 �� = dd.ND

  procedure BEFOR_3600  ( p_NDG cc_deal.ndG%type , oo IN OUT oper%rowtype) ; -- S36 (������ �������� ������ ) �� 3600  (�� 22 09, 10).
  procedure AFTER_3600  ( p_NDG cc_deal.ndG%type , oo IN OUT oper%rowtype) ; -- S36 (������ �������� ������ ) �� 3600  (�� 22 09, 10).
  ------------------------------------
  procedure OPN1  ( p_NDG cc_deal.ndG%type, p_kv int, p_ir number, p_basey int, p_s number , p_mdate date ) ; -- �������� ������ �/�
  procedure P9129 ( p_NDG cc_deal.ndG%type)  ; -- 9129 �� ���.����
  procedure FINIS_3600  ( p_NDG cc_deal.ndG%type ) ; -- �� ������ ��� ������ ������� � ��=3600 �� ���� �������� � ��������� �� ����� ������ ��  SS � �������.������ �� 9129

END msfz9;

/
CREATE OR REPLACE PACKAGE BODY BARS.MSFZ9 is
--------------------------------------------------------
/*
25/05/2018 LitvinSO ��������� ���������� �������
11.04.2018 LitvinSO  ���������� ������ ��� ����������� ��, � ������������ ���.���������� ���������� �� ���������
27.03.2018 VPogoda  ������ get_nls �� get_nls4rnk ��� ����, �����, �� �����������, �������� ����� �� ����� ������� �����
26.03.2018 LitvinSO ���� ����� �������� �� ������� ������� �� ������
20.03.2018 LitvinSO ��� �������� SG �������� ������ ��� ��������� ����������� ����� � ���������� ��� ����������� SG
22.02.2018 Sta ����������� �� ������ SG

15.02.2018 �� - ������ �� ����������
13.02.2018 Sta 	��� ����, ����� ��������� ����������� ���� ������������� �������� ��������� �� ������������ ���������� ������ � ���� ��������� , ������� ���
   1) ����� ������������� ������������ ������ ��������� (SP, SPN, SK9) �� ����� ���������� 3739_9
      ���������� ��� ������ SQL-������� DAT_SPZ  � ��������� ( �.�. �������� ����)  ���.�������� DATVZ = ���� ���������� �������������
      � ������ ����� �������� ������������(��������� �������)
   2) ����� ���������� ������� �� ������ ����������� 3739_9 �� ����� ��������� (SP, SPN, SK9)
      �	��� ������������ - ���.�������� DATVZ �������
      �	��� ����� ����������� � � ��� ��������.
   ��� ������ �������� � �� ������� ���������  SQL-������� DAT_SPZ  - ���� ������ �� �������� �� ������.


05.02.2018 Sta �� VIDD=3 ���������� ������� ������ �� �������� ���.������� � �������, ������� ���������� �� ����� ���.��������
29.01.2018 Sta � % �������� ����� �������� ������ ���� SN, � ������ ���� ����� � ��� ��� ��������� �� ������� ��� ������ ����� ���� SN
17.01.2018 Sta Sdog +Limit 12322.00 � ��� ��������. ������� � �����
16.01.2018 Sta - :11, "³����� ��������" <viktoriia.semenova@unity-bars.com> wrote:
    �� ����������� ����������� ������� � ������ ����������:
    1) �� ������  ���������� - � CONST
       - � ���� ND ��������� ND ���.���������,
       - � ���� NDO - ND ���.�������� = NDG
       - ID �������� �������
11.12.2017 Sta �������������� 3600 �� ������ ���
06.12.2017 Sta 3600 ��� ����.�� �� ������ ������ ! I_CR9=0 (�������������). ����� �� 3600 ������ ���� �������� �� ���.��������.
27.11.2017 Sta
1) ��������� ������ ���.�������� ��� VIDD=2 - ������ � ������ ��������
3) �� ������ ��� ������ ������� � ��=3600 �� ���� �������� � ��������� �� ����� ������ ��  SS � �������.������ �� 9129

24.11.2017 Sta +���.�������� - ������ ����8 � PRVN ...
14.11.2017 Sta ��� �������� � ����  ����-�� � ��� ���� ��������� 11 .���.���� ���� 'ZAY_R' = ��� ������������ � ������ �� �� = �� ��������������. ������ � ��������.
   � ���� �� ������������, ��� ����� �� ��� ����� ��������.

01.11.2017 Specparam
10.11.2017 NLS = 3739*9
10.10.2017 -� ��������� ���.�������� ���������� ������ ���� "������������ �����", "���� ����������" - �.�. ��� ��������� �� ����� ���� ��������� �� ���, ������� ����������� ��� ���.��������.
   � ������ ����� ��� ���� � ������ �����.
   � � ��������� ��� ������ ���������� (����� ����-���� � ������ ���.���) , ��� ���������������� ����� ���.���. ��� ����� �� ��������, �� ��� ������� ����� �� ������.
06.10 2017 - ����� + ����� ��������� ��� ������.����.�� - ���� � ������� �� �������� SDI, ��������� �� ��������� �� ������� S36.
04.10.1027 ����.���
02.10.2017 HAVING ( sum (Z.SS ) > 1       or sum (Z.SP ) > 1         or sum (Z.SN ) > 1            or sum (Z.SDI) > 1      or sum (Z.SPN) > 1            or sum (Z.SNA) > 1
28.09.2017 ����� SS = 0, ����� SP �� = 0
20.09.2017 SNO ������������� � ������ ��� � ���� �� SNO
18.08.2017 ����� � nd_acc ��� 3739
22.08.2017 ���� 3739 - ������ ���� ��� �������� �� ���� ���.��������� (������ �������� ������ � ���.�������).
17.08.2017 ����� ������ prvn
  -- Sta+Vlka S/. 25.05.2017- 1
25.05.2017 ���������� ���������� �������� + ��������
24.04.2017 Sta procedure OPN1 �������� ������ �/�
21.04.2017     ���������� SNA
3.2 ��������  ������������ �������� ������� ��������� ���
��� SP       - � ������ ��� �� SS.
��� SN ,SPN  � � ������ ��� ������ �� ��������� ������ �� SS+SP
��� SNO      - �� ������� � ������� ������� �������������, � ��������� ���������� �����������.
��� SNA      - � ������ ��� ������ �� ��������� ������ �� ��������� ������� ������� � ������� �����������.
��� SDI, SPI - ����������� ����������� �� ������� �� �������� SS+SP (���� ������� ���� ��� ������� ������������� ��, ����������� � ���������).

�������� �������  3578/3579/8999/9129 ��������� �������� ��� ��������, ����������� �� ���������� �����.
-	��� �������� ������������ ������� ��, ������� �� �������� ���� S36 ������ ���������� � ��������� ���� ����'���� �� ���������� ����� ��� �������� �� ������������;
-	��� �������� �������������� ������� �� ���� ������� �� ������� � ����� S36, ������������� ����������� ��� ������� �� �������� ������� ������������� (��� ������� SS) ��  ������� �� ������� ��������������� ����� (��� ������� CR9). �������, �� ����������� �� ������� SS,  ������������� �� �������� ���������������� �������� (��� ������� SDI) ������� ����������� ����������� �� ������� ������� ������������� ������� � �����������, � �������, �� ����������� �� ��������������� �����, ���������� �� ������� ���� S36 , ���� ������� ���� ����'������ �� ������������ ��������.

S36 (������ �������� ������ ) �� 3600  (�� 22 09, 10).
- ��� ������������   �� ������� �� S36 ������ ���������� ����'����  �� ���������� ����� ��� �������� �� ������������ (������ �����);
- ��� �������������� �� ������� ��  S36
  ������������� ����������� ��� ������� SS+CR9.
    �������, �� ����������� �� ������� SS, ����������� �� �������� SDI
             ������� ����������� ����������� �� ������� ������� ������������� ������� � �����������,
    � �������, �� ����������� CR9, ���������� �� ������� ���� S36,  ���� ������� ���� ����'������ �� ������������ ��������.
*/

----------------------------
procedure PUL9  ( p_NDG cc_deal.ndG%type ) is
begin
   PUL.put('NDG',p_NDG);
   PUL.put('WACC','A.ACC in (select n.acc from nd_acc n,cc_deal d where d.ND =n.ND and d.ndg='||p_ndg||' union select n.acc FROM ACCOUNTS n,cc_accp cp,CC_add d, cc_deal dd WHERE cp.accs = d.accs AND n.ACC = cp.ACC and d.nd =dd.nd and dd.ndg ='||p_ndg||')');
end PUL9;


function Get_NLS  ( p_KV int, p_B4 varchar2) return varchar2 is     nTmp_ number;     l_NLS accounts.nls%type;
begin
   While 1<2
   loop  nTmp_ := trunc(dbms_random.value(1, 999999999));       l_NLS :=p_B4||'_'||nTmp_ ;
         begin select 1 into nTmp_ from accounts where nls like l_NLS and kv = p_KV ;
         EXCEPTION WHEN NO_DATA_FOUND THEN  return vkrzn ( substr(gl.aMfo,1,5) , l_NLS ) ;
         end ;
   end loop  ;
end Get_Nls  ;
--------------
function get_nls4rnk (p_tip in accounts.tip%type  -- ��� �������
                     ,p_nbs in accounts.nbs%type  -- ���������� �������
                     ,p_rnk in accounts.rnk%type  -- ��� �볺���
                     ,p_kv  in accounts.kv%type   -- ��� ������
                     ,p_nd  in cc_deal.nd%type)   -- ����� ��������
  return accounts.nls%type
  is
  v_num  number := 1;
  v_flag number;
  v_ret  accounts.nls%type;
  v_acc  nd_acc.acc%type;
begin
  
  if p_tip = 'LIM' then  -- ��� ������� ���� ������������� ����� � ������� ��������
    v_ret := vkrzn(substr(gl.amfo, 1, 5), '89990' || substr(p_nd,1,9)); 
    v_ret := f_newnls2(acc2_      => null,
                       descrname_ => 'LIM',
                       nbs2_      => '8999',
                       rnk2_      => p_rnk,
                       idd2_      => v_num,
                       kv_        => p_kv,
                       inmask_    => v_ret);
    select count(1) into v_flag
      from accounts 
      where nls = v_ret;
    if v_flag != 0 then
      return v_ret;
    end if;
    v_ret := MSFZ9.Get_NLS(p_kv,p_nbs) ;
    return v_ret;
  end if;
        
  select n.acc
    into v_acc
    from nd_acc n, accounts a
    where nd = p_nd
      and n.acc = a.acc
      and a.tip = 'LIM'
      and a.dazs is null
      and rownum = 1;
  
  v_ret := f_newnls(acc2_      => v_acc,
                    descrname_ => p_tip,
                    nbs_       => p_nbs);
  select count(1) into v_flag
    from accounts 
      where nls = v_ret;
  if v_flag != 0 then 
    v_ret := MSFZ9.Get_NLS(p_kv,p_nbs) ;
  end if;

  return v_ret;

exception
 when others then
   v_ret := MSFZ9.Get_NLS(p_kv,p_nbs) ;
   return v_ret;
end get_nls4rnk;
----------------

procedure step_x ( p_ndG number  ) is  --  �������� ���������
                   x_NDG number ;
 dd cc_deal%rowtype  ;
 a8 accounts%rowtype ;
 sTmp_ varchar2(38)  ;
 l_ref number :=  0  ;
begin

 If nvl(p_ndG,0) = 0 then x_NDG := to_number(PUL.GET('NDG')); else x_NdG := p_ndG ; end if;
 If nvl(x_ndG,0) = 0 then raise_application_error ( -20333,'MSFZ9 �� ������ NDG') ; end if;

 begin sTmp_ := 'CC_DEAL' ; select * into dd from cc_deal  where nd  = x_ndg      ;
       sTmp_ := 'ACCOUNTS'; select * into A8 from accounts where tip ='LIM' and acc in (select acc from nd_acc where nd = x_ndg );
 exception when no_data_found then raise_application_error( -20333,'MSFZ9('||sTmp_||') �� �������� ���.��=' || x_ndg );
 end;

 for k in (select * from cc_deal where ndg = x_ndg  and nd <> ndg)
 loop
    for ka in (select * from accounts where acc in (select acc from nd_acc where nd = k.ND ) )
    loop delete from nd_acc where acc= ka.acc and nd = k.ND;
         begin select CHGACTION into sTmp_ from nd_acc_update where nd = x_ndg and acc = ka.acc and CHGACTION ='D' and rownum = 1 ;
               If ka.tip in ('SS ','SP ') then update accounts set accc = a8.acc where acc = ka.acc  ; end if ;
               insert into nd_acc (nd, acc) values ( x_NDG, ka.acc);
               update PRVN_FLOW_DEALS_CONST set ND = x_NDG, ndo = null where nd = k.ND and acc =ka.acc; -- �������������� �������
         exception when no_data_found then null;
         end;

         If l_ref = 0 and ka.tip in ( 'SP ', 'SN ', 'SPN', 'SNA', 'SDI', 'SPI' ,'S36')  and  ka.dapp is not null  then
            begin select o1.ref  into l_ref   from opldok o1, opldok o2 where o1.fdat = ka.dapp and o1.acc = ka.acc and o2.ref = o1.ref and o2.stmt = o1.stmt and o2.dk = 1- o1.dk
                                               and o2.acc = (select acc from accounts where kv = ka.kv and nls = NLS_3739) and rownum = 1 ;
                  ful_bak( l_ref) ;
            exception when no_data_found then l_ref := -1 ;
            end ;
         end if ;
    end loop;  -- ka

    delete from nd_txt  where nd = k.nd;
    delete from cc_add  where nd = k.nd;
    delete from cc_lim  where nd = k.nd;
    delete from cc_deal where nd = k.nd;
 -- update cc_deal set sos =14 where nd = k.nd;

 end loop; -- k

 update cc_deal set ndg = null where nd = x_NDG ;

end step_x;
-----------------------------------------
function Get_Prvn ( d_nd  cc_deal.nd%type,   d_ndg cc_deal.ndG%type,  p_nd number,    p_ndo number )  return int IS
  l_ret int := 0;
begin If d_ndg is null and d_nd = p_nd  OR  d_ndg = p_nd  and d_nd = p_ndo then l_ret := 1; end if;   RETURN l_ret;
end  Get_Prvn;
-----------------------------
procedure insN (p_nd number, p_acc number) is
begin begin insert into nd_acc_old (nd,acc) values (p_nd,p_acc); exception when others then   if SQLCODE = -00001 then null ; else raise; end if;  end;  end insN;
--------------------------------------------
procedure opl (oo IN OUT oper%rowtype ) is
 l_stmt number;
begin If oo.s  = 0 then RETURN ; end if ;
      oo.tt   := nvl( oo.tt ,'024')     ;
      oo.vob  := nvl( oo.vob, 6   )     ;
      oo.mfoa := nvl( oo.mfoa,gl.aMfo)  ;
      oo.mfob := nvl( oo.mfob,gl.aMfo)  ;
      oo.vdat := nvl( oo.vdat,gl.bdate) ;
      If oo.ref is null then gl.ref (oo.REF);
         gl.in_doc3 (ref_ => oo.REF  , tt_  => oo.tt  , vob_ => oo.vob ,   nd_ =>oo.nd   , pdat_=>SYSDATE, vdat_ =>oo.vdat , dk_ =>oo.dk,
                      kv_ => oo.kv   , s_   => oo.S   , kv2_ => oo.kv2 ,   s2_ =>oo.S2   , sk_  => null  , data_ =>gl.BDATE,datp_=>gl.bdate,
                   nam_a_ => oo.nam_a,nlsa_ => oo.nlsa,mfoa_ => oo.Mfoa, nam_b_=>oo.nam_b,nlsb_ =>oo.nlsb, mfob_ =>oo.Mfob ,
                    nazn_ => oo.nazn ,d_rec_=> null   ,id_a_ => oo.id_a, id_b_ =>oo.id_b ,id_o_ =>null   , sign_ =>null,sos_=>1,prty_=>null,uid_=>null);
      end if;

      select NVL(max(stmt),0)  into l_stmt from opldok where ref = oo.ref;

      gl.payv(0, oo.ref, oo.vdat, oo.tt, oo.dk, oo.kv, oo.nlsa , oo.s, oo.kv2    ,oo.nlsb, oo.s2);
      update opldok set txt = oo.d_rec where ref = oo.ref and stmt > l_Stmt;
      gl.pay (2, oo.ref, oo.vdat);  -- �� �����
end opl ;
----------------
procedure REGU ( p_nd number, p_KV INT ) is   -- ����������� (��`������/�������� )
  l_txt varchar2 (250);
  kol_SS  int ;
  Ost_k1  number := 0;
  l_val params$global.val%type := '1' ;  l_par params$global.par%type := 'MSFZ9' ;
  a8 accounts%rowtype    ;
  oo oper%rowtype        ;
  Z9 V_MSFZ9 %rowtype    ;
  I_CR9 varchar2(1) := '0'; -- ������� ����� ��. ³���������� �� = 0, 1= �������������
  qum_3600 number ;

begin

  NLS_3739 := Vkrzn( substr( gl.aMfo, 1,5), '373909' );  NMS_3739 := '������� ��� ������������ �� (����-9)';
  l_txt := 'MSFZ9:�� �������� ��-������� ��='|| p_nd ;
  begin  select   * into Z9 from v_MSFZ9              where   nd=p_nd ;
  exception when no_data_found then raise_application_error(-20000, l_txt );
  end ;

  begin  select a.*  into a8 from accounts a, nd_acc n where n.nd=p_nd and a.tip='LIM' and a.acc=n.acc;
         select okpo into oo.id_a from customer where rnk = a8.rnk;      oo.id_b := oo.id_a ;
  exception when no_data_found then raise_application_error(-20000,'��� ���.��� '||p_nd||' �����.���.8999*LIM' );
  end ;

  oo.nd    := substr(z9.cc_id, 1, 10 ) ;
  oo.nazn  :='����������� �� '|| oo.ND || ' �� �������  ���.���.' ;

  delete from nd_acc_old;
  INSERT INTO nd_acc_old (ND, ACC) Select nd, acc from nd_acc where nd =p_nd;

  begin select substr(trim(txt),1,1) into I_CR9 from nd_txt where tag='I_CR9' and nd= p_ND ; 
exception     when no_data_found   then I_CR9 := '0'  ;
  end ;
  If I_CR9<>'0' then MSFZ9.BEFOR_3600(p_ND,oo) ; end if ; --12.04.2018 Sta + Vika  ��� I_CR9=0 ��������� �� ���������.
  select NVL( sum(a.ostc), 0)  into qum_3600  from accounts a, nd_acc_old n   where n.nd=p_nd and n.acc=a.acc and a.tip in ('S36') and a.kv=gl.baseval ;

  -------------------------------------------------
  For dd in (select * from v_MSFZ91 where nd = p_nd order by ss, sp )
  loop

     -- ����������
     If ( DD.sn > DD.ss or DD.sp > DD.ss  or DD.spn > DD.ss or DD.sdi > DD.ss or DD.sna > DD.ss ) and DD.ss > 0  then
         raise_application_error(-20000, '��� ���.���='|| p_nd || ' ���='|| dd.kv ||' ��.���. SS='|| dd.SS||' ����� �������: SN,SP,SPN,SDI,SNA = ' ||
                                                                      dd.sn || ','|| dd.sp || ','|| dd.spn|| ','|| dd.sdi|| ','|| dd.sna );
     End if;
/*
     If DD.ss1 = 0 and dd.sn1 = 0 and dd.sp1 = 0  and dd.spn1 = 0 and dd.sdi1 = 0 and DD.sna1 = 0 and dd.sno1 = 0 then
        raise_application_error(-20000, '��� ���.���='|| p_nd || ' ���='|| dd.kv ||' �� ��� = 0 ' );
     End if;
*/

     If dd.ss1 = 0 and NVL(dd.sp1,0)  <> 0 then
        If dd.ss < dd.sp                   then  raise_application_error(-20000, '��� ���.���='|| p_nd || ' ���='|| dd.kv ||' ��.���. SS='|| dd.SS||' ����� SP=' || dd.sp );
        else                                     MSFZ9.step_2 ( 'SP ', DD , oo, I_CR9, qum_3600 ) ;
        end if;
     elsIf dd.ss >= 1                      then  MSFZ9.step_2 ( 'SS ', DD , oo, I_CR9, qum_3600 ) ;
     end if ;
  end loop ;

  ---3.5) ----- ����������� ������ �������� LIM � ������������� �������  LIM
  FOR DED in      (select a.acc, a.kv, n.ND, a.OSTC from accounts a, nd_acc_old n where a.tip ='LIM' and a.acc=n.acc and n.nd = p_ND ) -- ������ 1 ��� ��� ���.���, ������ ��� �������
  loop
      DED.OSTC := 0 ;
      for RODI in (select a.acc, a.kv, n.ND, a.OSTC from accounts a, nd_acc_old n where a.tip ='LIM' and a.acc=n.acc and n.nd <> DED.ND ) -- ��������� ���, ��� ���.���
      loop
          RODI.ostc := 0 ;
          For DOCH in (select  a.* from  accounts a, nd_acc_old n  where  a.tip in ( 'SS ', 'SP ' ) and a.acc = n.acc and n.nd = RODI.ND )
          loop
              UPDATE accounts set ACCC = RODI.ACC where acc = DOCH.acc;
              RODI.ostc := RODI.ostc + DOCH.ostc;
          end loop ; -- DOCH

          update  accounts set ostc = 0 where acc = RODI.ACC ;
          delete  from saldoa           where acc = RODI.acc ;
          update  accounts set ostc = RODI.ostc, ostb = RODI.ostc, ostf = 0, accc= DED.acc  where acc = RODI.ACC ;

          If    DED.KV  = RODI.KV     then a8.ostc :=                                               RODI.OSTC                       ;
          ElsIf DED.KV  = gl.baseval  then a8.ostc :=                        gl.p_Icurval (RODI.KV, RODI.OSTC, gl.bdate)            ;
          ElsIf RODI.KV = gl.baseval  then a8.ostc := gl.p_Ncurval (DED.KV ,                        RODI.OSTC,             gl.bdate);
          Else                             a8.ostc := gl.p_Ncurval (DED.KV , gl.p_Icurval (RODI.KV, RODI.OSTC, gl.bdate),  gl.bdate);
          end if ;

          DED.OSTC := DED.OSTC +  a8.ostc;

      end loop ;-- RODI;

      update  accounts set ostc = 0   where acc  = DED.ACC ;
      delete  from saldoa             where acc  = DED.acc ;
      update  accounts set ostc = DED.ostc, ostb = DED.ostc, ostf = 0, accc= null  where acc = DED.ACC ;
      exit;

  end loop ; -- DED

  update PRVN_FLOW_DEALS_CONST set DATE_CLOSE = gl.bdate where nd = p_ND and NDO is null ;


  If z9.vidd in (2,3 ) and I_CR9 <> '1'  then    MSFZ9.AFTER_3600( p_ND, oo ) ; end if;  --�� ³���������� �� = 1-- S36 (������ �������� ������ ) �� 3600  (�� 22 09, 10).

  If oo.ref is not null then
     select NVL ( sum ( decode( dk, 0, -1, 1) * sq ), 0)  into oo.s from opl where ref = oo.ref and nls = NLS_3739  ;

     l_txt := 'MSFZ9 ������� ��. ���='|| oo.ref ||' ����������������� ��������� ���.='||oo.s ;

     logger.info ('MSFZ9:select ref,tt, dk,s,sq,kv,nls,txt from opldok o,accounts a where a.acc=o.acc and ref='||oo.ref||' order by stmt,dk;' );
--   If oo.s <> 0 then  raise_application_error( -20333, l_txt );      end if ;
     logger.info(l_txt);
  end if;

  pul.put('ND', p_ND );
  pul.put('REF', oo.ref );

end REGU ;

---------------

procedure step_2 ( p_tip accounts.tip%type, DD v_MSFZ91%rowtype, oo IN OUT oper%rowtype , p_CR9 varchar2, qum_3600 number ) is  -- ������ �����-����� ���`�������  ��� 1 �� = dd.ND
  a8_new accounts%rowtype ;
  cc customer%rowtype ;
  a8_old accounts%rowtype ;
  i8_old int_accn%rowtype ;
  DD_old cc_deal%rowtype  ;
  DD_new cc_deal%rowtype  ;
  rr  int_ratn%rowtype;
  aa_old accounts%rowtype ;
  aa_new accounts%rowtype ;
  CA1 cc_add%rowtype ;

  SPC specparam%rowtype ;
  SPI specparam_int%rowtype ;

  p4_ int ;
  SUM_SP   NUMBER ;
  Sum_SN   number ;
  Sum_SPN  number ;
  Sum_SNA  number ;
--qum_3600 number ;
  qum_LIM  number ;
  ZNAM_SN  number ;
  ZNAM_SP  number ;
  ZNAM_SP1 number ;
  ZNAM_BV  number ;
  CHISLI   number ;
  L_KOEFF  NUMBER ;
  x_acc    number ;
  sTmp_    varchar2 (25);
  ost_k2   number  ;
--------------------------------------
begin   -- ����� ���
  begin sTmp_ := 'CC_DEAL' ; select * into dd_old from cc_deal  where nd  = dd.nd      ;
        sTmp_ := 'CUSTOMER'; select * into cc     from customer where rnk = dd_old.rnk ;
        sTmp_ := 'CC_ADD'  ; select * into CA1    from cc_add   where nd  = dd_old.nd and adds = 0 ;
        sTmp_ := 'ACCOUNTS'; select * into A8_old from accounts where tip ='LIM' and acc in (select acc from nd_acc_old where nd = dd_old.ND );
        sTmp_ := 'INT_ACCN'; select * into i8_old from int_accn where acc = A8_old.acc and id  = 0 ;
        Update accounts set  pap = 3 where acc = A8_old.acc ;
  exception when no_data_found then raise_application_error( -20333,'MSFZ9('||sTmp_||') �� �������� ��� ��=' || dd.ND );
  end;
  ---------------------
  oo.nlsb  := NLS_3739 ;
  oo.nam_b := NMS_3739 ;

 -- �������� � ������������ ���� ������

-- 1) ����� �a������� �� -----------------------------------------------------------------
--select NVL( sum(a.ostc), 0)            into qum_3600  from accounts a, nd_acc_old n               where n.nd=dd_old.nd and n.acc=a.acc and a.tip in ('S36') and a.kv=gl.baseval ;
  select NVL(sum(a.ostc),0)              into ZNAM_BV   from accounts a, nd_acc_old n               where n.nd=dd_old.nd and n.acc=a.acc and a.tip <> 'SNA'   and a.kv=dd.KV and nbs like '20%' ;
  select NVL(sum(a.ostc), 0)             into ZNAM_SP   from accounts a, nd_acc_old n               where n.nd=dd_old.nd and n.acc=a.acc and a.tip in ('SS ') and a.kv=dd.kv ;
  select NVL(sum(a.ostc), 0)             into ZNAM_SP1  from accounts a, nd_acc_old n               where n.nd=dd_old.nd and n.acc=a.acc and a.tip in ('SP ') and a.kv=dd.kv ;
  select NVL(sum(a.ostc*acrn.fprocn (a.acc,0,gl.bd)),0) into ZNAM_SN  from accounts a, nd_acc_old n where n.nd=dd_old.nd and n.acc=a.acc and a.tip in ('SS ','SP ') and a.kv=dd.kv ;
  select NVL(sum(gl.p_icurval( a.kv, a.ostc, gl.bd)),0) into qum_LIM  from accounts a, nd_acc_old n where n.nd=dd_old.nd and n.acc=a.acc and a.tip in ('SS ','SP ') ;
--  select gl.p_icurval(kv,ostc,gl.bdate)  into qum_LIM  from accounts                                where acc =A8_old.acc  ;

  sum_SN  := dd.sn1  * 100 ;
  sum_spn := dd.spn1 * 100 ;
  SUM_SP  := DD.SP1  * 100 ;
  Sum_SNA := dd.SNA1 * 100 ;

  update   cc_deal  set  ndG = nd where nd = dd_old.nd;

    -- 2)  �������� �� ��� ������� ��� -----------------------------------------------------
   for ss in (select a.* from accounts a, nd_acc_old n  where (  a.tip in ('SN ','SPN','SP ','SNA','SDI','SPI') and a.kv=dd.kv or a.tip='S36') and a.acc = n.acc  and ostc <> 0  )
   loop
      -- ��� ������������ ������ ��������� ������������ ���.�������� DATVZ	���� ���������� �������������
      If ss.tip in ('SP ','SPN', 'SK9' ) then
         sTmp_  := to_char( DAT_SPZ(SS.ACC,gl.Bdate,0), 'DD/MM/YYYY');
         update ACCOUNTSW  set value = sTmp_ where acc = ss.ACC AND TAG = 'DATVZ';
         IF SQL%ROWCOUNT = 0 THEN   Insert into ACCOUNTSW (ACC,TAG,VALUE) Values ( ss.acc, 'DATVZ', sTmp_); END IF;
      end if;

      If p_CR9 = '0' and ss.tip = 'S36' then null ;  --06.12.2017 Sta 3600 ��� ����.�� �� ������ ������ ! I_CR9=0 (�������������). ����� �� 3600 ������ ���� �������� �� ���.��������.
      else
        oo.kv  := ss.kv ;         oo.kv2 := oo.kv ;
        oo.s   := abs( ss.ostc);  oo.s2  := oo.s  ;
        If ss.ostc < 0  then oo.dk := 0 ;
        else                 oo.dk := 1 ;
        end if;
        oo.nlsa  := ss.nls;     oo.nam_a := substr(ss.nms,1,38)  ;
        oo.d_rec := '��������� ������� �� ������ '||NLS_3739 ;
        MSFZ9.opl (oo) ; -- ��������
      end if;

   end loop;

   --3)   ---���� �� ������� �� � ���---------------------------------------------------------------------------------------
   for kk in ( select w.* , a.nls, a.ostc from PRVN_FLOW_DEALS_CONST W , accounts a where w.nd = dd_old.ND  and w.kv = dd.kv and w.acc = a.acc and a.dazs is null order by  a.acc )
   loop
      -- �������� ������ ��
      DD_new     := dd_old    ;      DD_new.ndG := dd_old.ND ;    DD_new.nd  := bars_sqnc.get_nextval('s_cc_deal')  ;
      INSERT INTO cc_deal values DD_new ;
      CA1.nd  := DD_new.nd ;  CA1.accs := kk.acc ; CA1.kv := dd.kv ;

      If    ca1.aim < 62 then  ca1.aim :=  0 ;
      elsIf ca1.aim < 70 then  ca1.aim := 62 ;
      elsIf ca1.aim < 90 then  ca1.aim := 70 ;
      end if;
      INSERT INTO cc_add  values CA1 ;

      for xt in ( select * from nd_txt where nd = dd_old.ND  )  --  and tag not in  ('PR_TR' )  ------ ������� �����������
      loop begin  INSERT INTO nd_txt (nd,tag,txt) values (DD_new.nd, xt.tag, xt.txt);    exception when others then null;     end;  end loop ; ----xt

      -- ���  �������������� ������� ��� ����. ��� �� ���� nd_txt ���� �������, ������� ������ �����  � ������ 'PR_TR'  ��� vidd=1
      update cc_deal set branch = dd_old.branch, vidd = 1  where nd = dd_new.ND;

      A8_new := A8_old;
      
      Op_Reg(99,0,0,0, p4_, dd_old.RNK, get_nls4rnk('LIM','8999', a8_new.rnk,dd.kv,dd_new.nd), dd.kv, A8_new.NMS, 'LIM', A8_new.isp, A8_new.acc);
--      Op_Reg(99,0,0,0, p4_, dd_old.RNK, MSFZ9.Get_NLS(dd.KV,'8999'), dd.kv, A8_new.NMS, 'LIM', A8_new.isp, A8_new.acc);
      i8_old.acc := A8_new.acc;  insert into int_accn values i8_old ;

----  update PRVN_FLOW_DEALS_CONST set ndo = DD_new.nd, acc8 = A8_new.acc where id = kk.id ;
/*  On Jan 15, 2018 19:11, "³����� ��������" <viktoriia.semenova@unity-bars.com> wrote:
    �� ����������� ����������� ������� � ������ ����������:
    1) �� ������  ���������� - � CONST
       - � ���� ND ��������� ND ���.���������,
       - � ���� NDO - ND ���.�������� = NDG
       - ID �������� �������
*/
      update PRVN_FLOW_DEALS_CONST set nd  = DD_new.nd,  ndo = dd_old.ND, acc8 = A8_new.acc where id = kk.id ;

      -------- ���� ��  ������������� ������� ��� ������ LIM
      update accounts set nbs = null, tobo = dd_old.branch, mdate = dd_old.wdate where acc = A8_new.acc;
      INSERT INTO nd_acc (nd, acc) VALUES ( DD_new.ND , A8_new.acc);
      INSERT INTO cc_sob (ND,FDAT,ISP,TXT ,otm) VALUES (DD_new.ND, gl.bDATE, gl.auid,'��������� � �� '|| dd_old.ND,6);
      kk.ostc :=  - kk.ostc ;
      INSERT INTO cc_lim (nd,fdat,acc,lim2,sumg, sumo ) VALUES (DD_new.ND, gl.bdate, a8_new.acc, kk.ostc, 0      , 0       ) ;
      INSERT INTO cc_lim (nd,fdat,acc,lim2,sumg, sumo ) VALUES (DD_new.nd, dd_old.WDATE, a8_new.acc, 0  , kk.ostc, kk.ostc ) ;

      insN ( DD_new.nd, A8_new.acc);

      -- 3.1) ������������ �������� ���� SS ���� � ������ � ��
      insert into nd_acc(nd, acc) values ( DD_new.nd,  kk.acc ) ;   insN ( DD_new.nd, kk.acc);
      delete from nd_acc where nd = dd_old.nd and acc = kk.acc  ;

      -- 3.2) SNO ������ ����������� � ������� ��
      for ss in (select a.* from accounts a, nd_acc n where a.tip ='SNO' and a.acc= n.acc and n.nd = dd_old.ND  and dazs is null and  a.kv = dd.kv )
      loop  insert into nd_acc(nd, acc) values ( DD_new.nd,   ss.acc ) ;   insN ( DD_new.nd, ss.acc);
            delete from nd_acc where nd = dd_old.nd and acc = ss.acc   ;
            update SNO_GPP set nd = DD_new.nd where acc = ss.acc and nd = dd_old.nd ;
            update SNO_REF set nd = DD_new.nd where acc = ss.acc and nd = dd_old.nd ;
      end loop; -- SS

      -- ���������� �� ��������� ������������ �����
      for ss in (select a.tip, min(a.acc) ACC from accounts a, nd_acc n where a.tip in ('SN ','SPN','SP ','SNA','SDI','SPI') and a.kv=dd.kv and a.acc=n.acc and n.nd=dd_old.ND and dazs is null group by a.tip)
      loop  insert into nd_acc(nd, acc) values ( DD_new.nd,   ss.acc ) ;   insN ( DD_new.nd, ss.acc);
            delete from nd_acc where nd = dd_old.nd and acc = ss.acc   ;
      end loop;

      -- 3.3) �� ������ ������ - �������������� ����������� ��� ����� ��� 3600
      for s36 in (select a.* from accounts a, nd_acc_old n where a.tip<>'S36' and a.nbs='3600' and ob22 in ('22','09','10') and a.acc=n.acc and n.nd=dd_old.ND and dazs is null)
      loop update accounts set tip = 'S36' where acc = s36.acc; end loop;

      -- 3.3) ������������/��������� ������������� �����
      for tt in (select distinct decode ( a.tip, 'S36', 'SDI', a.tip) tip   from accounts a, nd_acc_old n
                 where (  a.tip in ('SN ','SPN','SP ','SNA') and a.kv = dd.kv    or    a.tip in ( 'SDI', 'SPI', 'S36' )  )
                   and a.acc = n.acc and n.nd = dd_old.ND        and dazs is null
                )
      loop

         BEGIN select 1 into x_acc from accounts a, nd_acc n where n.nd = DD_new.nd and n.acc= a.acc and a.tip = tt.tip and a.dazs is null and rownum = 1;
         EXCEPTION WHEN NO_DATA_FOUND THEN  ----� ����� �� DD_new.nd ������ ���� ����� ��� ���  ���� ��������� ����� aa.acc �� ������� ������������� acc
             Begin  -- ��� ������� ��� �������� ������ ����� - ��� ������ ���� ������ ����
                select   * into aa_old
                from (select a.* from nd_acc_old n, accounts a where (a.kv=dd.kv or a.tip in ('SDI','SPI')) and n.nd=DD_old.nd and n.acc=a.acc and a.tip=tt.tip and a.dazs is null order by decode(dd.kv,a.kv,1,2) )
                where rownum = 1;
             EXCEPTION WHEN NO_DATA_FOUND THEN  goto NOT_LIKE;
             end ;

             -- � ��� ����� ����
--             aa_new.nls := MSFZ9.Get_NLS(dd.KV,aa_old.nbs) ;
             aa_new.nls := get_nls4rnk(aa_old.tip,aa_old.nbs,aa_old.rnk,aa_old.kv,dd_new.nd);
             Op_Reg(99,0,0,0, p4_, aa_old.RNK, aa_new.nls, dd.kv, aa_old.NMS, aa_old.tip, aa_old.isp, aa_new.acc );
             update accounts set tobo = dd_old.branch, mdate = aa_old.mdate, pap = aa_old.pap  where acc = aa_new.acc ;
             Accreg.setAccountSParam(aa_new.acc, 'OB22', aa_old.ob22 ) ;

             If aa_old.tip = 'SN ' then
                update int_accn set acra = aa_new.acc where acc = kk.acc and id = 0;
             end if;

             -- ��������� ����.�������� ��� ������ �� �������������.  -- �������� ! �� ���� ���������. �������� % ������
             for ii in (select * from int_accn where acc = aa_old.acc)
             loop begin ii.acc := aa_new.acc ;    insert into int_accn values ii;
                  exception when others then   if SQLCODE = -00001 then null ; else raise; end if;
                  end;
                  select max(bdat) into rr.bdat from int_ratn where acc = aa_old.acc and id = ii.id and bdat <= gl.bdate ;
                  If rr.bdat is not null then
                     select * into rr from int_ratn where acc = aa_old.acc and id = ii.id and bdat = rr.bdat ;
                     begin rr.acc := aa_new.acc ;   insert into int_ratn values rr ;
                     exception when others then   if SQLCODE = -00001 then null ; else raise; end if;
                     end;
                  end if;
             end loop ; -- ii �� ����.��������� �����

             begin select * into SPC from specparam where acc = aa_old.acc and NOT exists (select 1 from specparam where acc = aa_new.acc );
                   SPC.acc := aa_new.acc; INSERT INTO specparam values SPC ;
             exception when no_data_found then null;
             end;

             begin select * into SPI from specparam_int where acc = aa_old.acc and NOT exists (select 1 from specparam_int where acc = aa_new.acc );
                   SPI.acc := aa_new.acc; INSERT INTO specparam_int values SPI ;
             exception when no_data_found then null;
             end;

             -- ��� ������������ - ���.�������� DATVZ ������� �.�. � ��� �������� �������
             -- ��� ����� ����������� � � ��� �������� ������ �� ����� ����������
             insert into ACCOUNTSW (ACC,TAG,VALUE) select aa_new.acc, TAG,VALUE from ACCOUNTSW where acc = aa_old.acc  and NOT exists (select 1 from ACCOUNTSW where acc = aa_new.acc );

             -- ��������� ���� � ����� �� DD_new.nd
             insert into nd_acc(nd, acc) values ( DD_new.nd,  aa_new.acc ) ; insN ( DD_new.nd , aa_new.acc);

         end ;
         <<NOT_LIKE>> null;

      end loop  ; ---- TT
   end loop ; -- kk
   -------------------------------

   -- ������������ � ���������  ������� - ��������� ����� ���.��� � �� �����
   for ff in ( select d.nd ND_NEW, a.nls, a.kv, a.nms, a.acc , a.tip
               from  cc_deal d,    nd_acc_old n,  accounts a
               where d.ndg = dd_old.ND and d.ndg <> d.nd     and d.nd = n.nd and n.acc = a.acc  and  a.tip in  ('SN ','SPN','SP ','SNA','SDI') and a.kv = dd.kv
               order by decode( a.tip , 'SP ',1 , 'SN ',2, 'SPN', 3, 'SNA',99,  9)
              )
   loop

      oo.nlsa  := ff.nls;  oo.nam_a := substr(ff.nms,1,38) ;  oo.kv := dd.kv; oo.kv2 := oo.kv ;
      ---1------------------------------------------------------------------------------------------

      If ff.tip = 'SP '  then oo.dk    := 1 ;  -- ����������  � ������ ��� �� SS.

         If ZNAM_SP=0 and ZNAM_SP1<>0 then CHISLI := fost(ff.acc, gl.bd-1);
            L_KOEFF  := div0 (CHISLI,ZNAM_SP1) ;
         ELSE select sum(a.ostc)  into    CHISLI from accounts a, nd_acc_old n  where n.nd = FF.ND_NEW and n.acc= a.acc and a.tip in ( 'SS ' ) AND A.KV = DD.KV ;
            L_KOEFF  := div0( NVL(CHISLI,0),ZNAM_SP) ;
         END IF ;
         oo.S     := Round (  sum_sP * L_KOEFF, 0 ) ;
         oo.d_rec := '������� SP � ���.��� �� SS' ;
         MSFZ9.opl (oo) ;

      ---2-----------------------------------------------------------------------------------------
      ElsIf ff.tip = 'SN '  then oo.dk := 1 ;  -- ����������  � � ������ ��� ������ �� ��������� ������ �� SS+SP
                                               -- ���� ��� ���� * (���� * % �� ���.���) / ( ���� ���*% �� ������� ���)
         If   ZNAM_SN = 0   then    oo.s   := sum_sn;    Sum_sn := 0 ;
         else select sum( a.ostc*acrn.fprocn(a.acc,0,gl.bdate) ) into CHISLI  from accounts a, nd_acc n  where n.nd = FF.ND_NEW and n.acc= a.acc and a.tip in ('SS ','SP ') AND A.KV = DD.KV ;
              L_KOEFF  := div0( NVL(CHISLI,0) ,ZNAM_SN)  ;
              oo.S := Round (  sum_sn * L_KOEFF, 0 ) ;
         end if ;
         oo.d_rec := '������� SN � ���.��� �� LIM*���.��' ;
         MSFZ9.opl (oo) ;

      ---3------------------------------------------------------------------------------------------
      ElsIf ff.tip= 'SPN'  then oo.dk := 1 ; -- ������ SN
         If   ZNAM_SN = 0  then    oo.s   := sum_spn;         sum_spn:= 0 ;
         else select sum( a.ostc*acrn.fprocn(a.acc,0,gl.bdate))  into CHISLI  from accounts a, nd_acc n  where n.nd = FF.ND_NEW and n.acc= a.acc and a.tip in ('SS ','SP ') and A.KV = DD.KV ;
              L_KOEFF  := div0( NVL(CHISLI,0), ZNAM_SN)  ;
              oo.S := Round (  sum_sPn * L_KOEFF, 0 ) ;
         end if ;
         oo.d_rec := '������� SN � ���.��� �� LIM*���.��' ;
         MSFZ9.opl (oo) ;

      ---9------------------------------------------------------------------------------------------
      ElsIf ff.tip =  'SDI' and p_CR9 ='1'     then   -- �� ����������� ��
         -- SDI -  ����������� ��  SS+SP (���).
         select sum( gl.p_icurval( a.kv, a.ostc, gl.bdate))    into CHISLI  from accounts a, nd_acc n   where n.nd = FF.ND_NEW and n.acc= a.acc and a.tip in ('SS ','SP ') and A.KV = DD.KV ;
         L_KOEFF  := div0( NVL(CHISLI,0) ,Qum_LIM ) ; -- �������� ��� �� ����
         oo.s2 :=   qum_3600 * L_KOEFF ;
         oo.s2  := round( oo.s2, 0) ;

         If dd.kv = 980 then    oo.s  := oo.s2 ;
         else                   oo.s  := gl.p_ncurval( dd.kv, oo.s2, gl.bdate); oo.kv2 := 980;
         end if ;
         oo.dk := 0 ;
         oo.d_rec := '������� SDI � ���.��� �� LIM-���' ;
         MSFZ9.opl (oo) ; -- ���������� -  ����������� �� LIM (���).

      ---99------------------------------------------------------------------------------------------
      ElsIf ff.tip = 'SNA' and znam_BV <> 0  then  oo.dk := 0 ;
         select sum(a.ostc) into CHISLI from accounts a where acc in (select acc from nd_acc_old where nd = FF.ND_NEW) and kv = dd.KV and nbs like '20%' and tip <> 'SNA';
         L_KOEFF  :=  div0(NVL(CHISLI,0), ZNAM_BV)  ;
         oo.s     :=  Abs(round (Sum_SNA * L_KOEFF , 0)  );
         MSFZ9.opl (oo) ; -- ����������  � ��� SNA  - � ������ ��� ������ �� ��� ������ �� BV ������� � ������� �����������.
         oo.d_rec := '������� SNA  � ���.��� �� BV' ;
      end if ; --- ff.tip = ...

   end loop ; -- ff
   ---------------------------------------------------

   -- 3.4) ������ ���������������� ������������� �����
   for ss in (select a.* from accounts a, nd_acc n where  a.tip in ('SS ', 'SN ','SPN','SP ','SNA','SDI','SPI') and a.acc=n.acc and n.nd=dd_old.ND and dazs is null and a.kv=dd.kv )
   loop   delete from nd_acc where nd = dd_old.ND and acc = ss.acc ;  end loop;

   -----------------------
-- ���� 3739 - ������ ���� ��� �������� �� ���� ���.��������� (������ �������� ������ � ���.�������).
   for gg in (select acc, kv from accounts where tip = 'SG ' and acc in (select acc from nd_acc where nd = dd_old.ND) and dazs is null )
   loop Insert into nd_acc ( nd, acc)
        select d.nd, gg.acc
        from cc_deal d, nd_acc n, accounts a
        where d.ndg = dd_old.ND  and d.nd <> d.ndg and d.nd = n.nd and n.acc = a.acc and a.kv = gg.kv and a.tip ='SS '
	and not exists (select 1 from bars.nd_acc where nd = d.nd and acc = gg.acc) ;
   end loop ; -- gg

end step_2;
--------------
procedure BEFOR_3600 ( p_NDG cc_deal.ndG%type, oo IN OUT oper%rowtype) is -- S36 (������ �������� ������ ) �� 3600  (�� 22 09, 10).
  a36 accounts%rowtype;  p4_ int;
begin
  -- �������� ��� �� ������ ���-3600 ����

  begin select b.* into a36 from accounts b, nd_acc_old n where n.nd= p_NDG and n.acc= b.acc and b.tip ='S36'  and b.dazs is null  and b.kv = gl.baseval and rownum= 1 ;
  exception when no_data_found then a36.acc := 0;
  end ;

  oo.dk    := 1      ;
  oo.d_rec := '��������� �� S36-���' ;

  for A in (select * from accounts where tip in ('SDI','S36' ) and ostc>0 and acc in (select acc from nd_acc_old where nd = p_NDG)   )
  loop  if a.acc <> a36.acc then -- ���� ����������� �� 3600-���
           If a36.acc = 0   then  -- �� ��� ���, ���� ������� � ��������� � ��� ���
--              a36.nls := MSFZ9.Get_NLS(gl.baseval, '3600' ) ;
              a36.nls := get_nls4rnk('S36','3600',a.rnk,a.kv,p_ndg);
              Op_Reg(99,0,0,0, p4_, a.RNK, a36.nls, gl.baseval, a.NMS, 'S36', a.isp, a36.acc );
              update accounts set tobo = a.branch, mdate = a.mdate, pap = 2 where acc = a36.acc ;
              Accreg.setAccountSParam(a36.acc, 'OB22', '09' )     ;
              insert into nd_acc     (nd,acc) values ( p_ndG, a36.acc) ;
              insert into nd_acc_old (nd,acc) values ( p_ndG, a36.acc) ;
              select * into a36 from accounts where acc = a36.acc ;
           end if  ;
           oo.nlsa  := A.nls  ;  oo.nam_a := substr(A.nms  ,1,38) ;  oo.kv    := A.KV   ;  oo.s  := A.ostc ;
           oo.nlsb  := a36.nls;  oo.nam_b := substr(a36.nms,1,38) ;  oo.kv2   := a36.kv ;  oo.s2 := gl.p_icurval( a.kv,  A.ostc, gl.bdate) ;
           MSFZ9.opl (oo) ; -- ��������
        end if;
  end loop ;

end BEFOR_3600 ;
----------------------------
procedure AFTER_3600 ( p_NDG cc_deal.ndG%type, oo IN OUT oper%rowtype) is -- S36 (������ �������� ������ ) �� 3600  (�� 22 09, 10).
   tx  nd_txt%rowtype   ;
   a8  accounts%rowtype ;
   ss  accounts%rowtype ;
   sdi accounts%rowtype ; p4_ int ;
   a36 accounts%rowtype ;
begin

  --�� ³���������� �� = 1
   begin select   * into tx from nd_txt               where tag  ='I_CR9' and nd = p_NDG   and trim(txt) = '1'   ;
         select a.* into a8 from accounts a, nd_acc n where n.nd = p_NDG  and a.acc= n.acc and a.tip     = 'LIM' ; ---and ostx < 0 ;
         If a8.kv <> gl.baseval then a8.ostx := gl.p_icurval ( a8.kv, a8.ostx, gl.bdate) ; end if;
   exception when no_data_found then RETURN  ; --³���������� �� = 0, - S36 ������ ���������� ����'���� �� ���������� ����� ��� �������� �� ������������ (������ �����);
   end;
-- ����� ��������� ��� ������.����.�� - ���� � ������� �� �������� SDI, ��������� �� ��������� �� ������� S36.

   -- 3600 ������ ��� ������ ���� � ��� = ��� . ���-������� = a36.OSTC
   select count (*), min(a.acc)
   into p4_, a36.acc
   from accounts a, nd_acc n
   where n.nd = p_NDG and a.acc = n.acc and a.tip = 'S36' and dazs is null ;

   If p4_ = 0  then RETURN; end if;
   If p4_ > 1  then raise_application_error(-20000, '���.S36 ����� 1 '); end if;
   select * into a36 from accounts where acc = a36.acc;
   If a36.kv <> gl.baseval then raise_application_error(-20000, '������ ���.S36 �� 980'); end if;
   If a36.ostc <= 0 then return; end if;

   -- ��������� ���-���-��� 2066*SDI = sdi.ostQ
   select  NVL( sum ( gl.p_icurval(a.kv, a.ostc, gl.bdate)) , 0)
   into sdi.ostQ
   from nd_acc n, cc_deal d, accounts a
   where d.ndg = p_ndG and d.nd <> d.ndg and d.nd = n.nd and n.acc= a.acc and a.tip = 'SDI';

   -- ��������� ���-��� 2066+3600 = a36.ostQ
   a36.ostQ   := a36.ostc +  sdi.ostQ ; -- c�������� �����.��� �������+ �������

   -- ��������� ��� (������� + ���������) ���-��� =  2063*SS + 9129*CR9  = a8.ostQ
   select NVL( sum ( gl.p_icurval( a.kv, a.ostc, gl.bdate ) ) , 0)
   into a8.ostQ
   from accounts a, nd_acc n, cc_deal d
   where  p_ndg = d.ndg  and d.nd = n.nd and n.acc= a.acc and a.tip in ('CR9', 'SS ') ;
   If a8.ostQ >= 0  then RETURN ; end if ;

   ---------------------------------------
   /*
   ��� �������������� �� ������� ��  S36  ������������� ����������� ��� ������� SS+CR9. = 899.ostx
   �������, �� ����������� �� ������� SS, ����������� �� �������� SDI   ������� ����������� ����������� �� ������� ������� ������������� ������� � �����������,
   � �������, �� ����������� CR9, ���������� �� ������� ���� S36,  ���� ������� ���� ����'������ �� ������������ ��������.
   */


   for n2 in (select n.nd from nd_acc n, accounts a where a.tip ='LIM' and a.accc = a8.acc and a.acc= n.acc )
   loop
      begin
         select a.* into ss  from accounts a, nd_acc n where a.tip ='SS ' and a.ostc < 0     and n.nd = n2.nd and a.acc = n.acc ;
         ss.ostQ := gl.p_icurval( ss.kv, ss.ostc, gl.bdate) ;

         -- ����� ������ ���� ������� � ��� ?
         oo.s2  := round ( a36.ostQ * least ( div0 (ss.ostQ,a8.ostQ) , 1 ) , 0) ;

         If oo.s2 > 0 then
            -- ����� ���� �� ����� ���� ?
            begin select a.* into sdi from accounts a, nd_acc n where a.tip ='SDI' and a.dazs is null and n.nd = n2.nd and a.acc = n.acc and a.kv = ss.kv ;
            exception when no_data_found then   ----� ����� �� DD_new.nd ������ ���� ����� ��� ���
               -- ���� ��������� ����� aa.acc �� ������� ������������� acc
               sdi.nls := get_nls4rnk('SDI',substr(ss.nbs,1,3)||'6',ss.rnk,ss.kv,n2.nd);
--               sdi.nls := MSFZ9.Get_NLS(ss.KV, substr(ss.nbs,1,3)||'6') ;
               Op_Reg(99,0,0,0, p4_, ss.RNK, sdi.nls, ss.kv, ss.NMS, 'SDI', ss.isp, sdi.acc );
               update accounts set tobo = ss.branch, mdate = ss.mdate, pap = 2 where acc = sdi.acc ;
---------------Accreg.setAccountSParam(aa_new.acc, 'OB22', aa_old.ob22 ) ;
               -- ��������� ���� � ����� �� DD_new.nd
               insert into nd_acc(nd, acc) values ( n2.nd,  sdi.acc ) ; insN (n2.nd,  sdi.acc);
               select * into sdi from accounts where acc = sdi.acc ;
            end;
            sdi.ostQ := gl.p_icurval( sdi.kv, sdi.ostc, gl.bdate)  ;

            If oo.S2 > sdi.ostQ then
               oo.S2 :=  LEAST ( (oo.S2-sdi.ostQ) , fost(a36.acc, gl.bdate) ) ;
               If oo.S2 > 0 then
                  oo.dk    := 0 ;
                  oo.nam_a := substr(sdi.nms,1,38) ; oo.nlsa := sdi.nls ;
                  oo.nam_b := substr(a36.nms,1,38) ; oo.nlsb := a36.nls ;
                  oo.kv    := sdi.kv ;
                  oo.s     := gl.p_Ncurval ( sdi.kv, oo.s2 , gl.bdate)  ;
                  oo.kv2   := a36.kv ;
                  --if s36.kv <> gl.baseval then oo.s2 := gl.p_Ncurval ( s36.kv, oo.s2 , gl.bdate); end if;
                  MSFZ9.opl (oo);
               end if ;
            end if;
         end if;
      exception when no_data_found then null ;
      end;
   end loop   ; --  n2

end AFTER_3600 ;
--------------------
procedure OPN1 ( p_NDG cc_deal.ndG%type, p_kv int, p_ir number, p_basey int, p_s number , p_mdate date ) is  -- �������� ������ �/�
/*
� ��������� ���.�������� ���������� ������ ���� "������������ �����", "���� ����������" - �.�. ��� ��������� �� ����� ���� ��������� �� ���, ������� ����������� ��� ���.��������.
� ������ ����� ��� ���� � ������ �����.
� � ��������� ��� ������ ���������� (����� ����-���� � ������ ���.���) , ��� ���������������� ����� ���.���. ��� ����� �� ��������, �� ��� ������� ����� �� ������.
1) ��������� ������ ���.�������� ��� VIDD=2 - ������ � ������ ��������


���������� ��������� :
1) �� VIDD=3 ���������� ������� ������ �� �������� ���.������� � �������, ������� ���������� �� ����� ���.��������
*/


  p4_ int ;  sTmp_ varchar2(25) ;
  l_NDG  cc_deal.ndG%type := NVL( p_ndg, TO_NUMBER (pul.Get ('NDG'))  );
  l_kv   int := NVL(p_kv, gl.baseval);
  DD_old cc_deal%rowtype  ;
  CA1    cc_add%rowtype   ;
  a8_old accounts%rowtype ;
  DD_new cc_deal%rowtype  ;
  a8_new accounts%rowtype ;
  i8     int_accn%rowtype ;
  l_s number := NVL(p_s,0) * 100 ;
  l_mdate date ;
--------------------------------------
begin
  If p_ir is null then raise_application_error( -20333,' �� ������ ���. %% ������ ��� ��'  );  end if;

  -- ����� ���
  begin sTmp_ := 'CC_DEAL' ; select * into dd_old from cc_deal  where nd  = l_NDG      ;
        sTmp_ := 'CC_ADD'  ; select * into CA1    from cc_add   where nd  = dd_old.nd and adds = 0 ;
        sTmp_ := 'ACCOUNTS'; select * into A8_old from accounts where tip ='LIM' and acc in (select acc from nd_acc where nd = dd_old.ND );

        If l_s <= 0 then
           l_s := GREATESt( dd_old.sdog*100 + a8_old.ostb ,0 ) ;
           If a8_old.kv <> p_kv then
              If    p_kv      = gl.baseval then l_s := gl.p_Icurval ( a8_old.kv, l_s, gl.bdate);
              ElsIf a8_old.kv = gl.baseval then                                                   l_s := gl.p_Ncurval ( p_kv, l_s, gl.bdate);
              else                              l_s := gl.p_Icurval ( a8_old.kv, l_s, gl.bdate);  l_s := gl.p_Ncurval ( p_kv, l_s, gl.bdate);
              end if;
           end if;
        end if;

        sTmp_ := 'INT_ACCN'; select * into i8     from int_accn where acc = A8_old.acc and id  = 0 ;

  exception when no_data_found then raise_application_error( -20333,sTmp_||') �� �������� ��� ��=' || l_nDG );
  end;
  -------------
  If    dd_old.vidd = 2 AND a8_old.kv <> p_KV then raise_application_error( -20333, '����-��� ��: ��� ��� ���.����� ('||a8_old.kv||') �� = ���� ��� ���/����� (' || p_KV || ')'  );
  ElsIf dd_old.vidd = 3 then

     begin sTmp_ := 'P'|| Substr( '000'||p_KV, -3) ;
           select tag into sTmp_ from nd_txt where nd = dd_old.nd and tag = sTmp_ ;
     exception when no_data_found then
           If p_kv <> A8_old.kv then
              raise_application_error( -20333, sTmp_||') ������������ ��� ��� ��� ��=' || l_nDG );
           end if;
     end;

  END IF;


  update   cc_deal  set  ndG = nd where nd = dd_old.nd and ndg is null;
  ---============================
  -- �������� ������ ��
  --------------------------- cc_deal ---------------
  l_s         := l_s /100   ;
  ---------------------------
  DD_new      := dd_old     ;
  DD_new.ndG  := dd_old.ND  ;
  DD_new.SDOG := l_s        ;
  DD_new.limit:= l_s        ;
  DD_new.vidd := 1          ;
  DD_new.sdate:= gl.bdate   ;
  DD_new.wdate:= nvl(p_mdate, dd_old.wdate);
  DD_new.nd   := bars_sqnc.get_nextval('s_cc_deal')  ;
  INSERT INTO cc_deal values DD_new ;

  ----------------------------- cc_add --------------
  CA1.nd      := DD_new.nd    ;
  CA1.kv      := l_kv         ;
  CA1.s       := l_s          ;
  CA1.bdate   := DD_new.sdate ;
  CA1.wdate   := DD_new.sdate ;
  If    ca1.aim < 62 then  ca1.aim :=  0 ;
  elsIf ca1.aim < 70 then  ca1.aim := 62 ;
  elsIf ca1.aim < 90 then  ca1.aim := 70 ;
  end if;
  INSERT INTO cc_add values CA1 ;

  ----------------------------- accounts -8999 -------
  A8_new := A8_old;
  a8_new.nls := get_nls4rnk('LIM','8999',dd_old.rnk,l_kv,dd_new.nd);
  Op_Reg(99,0,0,0, p4_, dd_old.RNK, a8_new.nls, l_kv, A8_new.NMS, 'LIM', A8_new.isp, A8_new.acc);
  update accounts set nbs = null, tobo = dd_old.branch, mdate = DD_new.wdate , accc = a8_old.acc     where acc = A8_new.acc;
  INSERT INTO nd_acc (nd, acc) VALUES ( DD_new.ND , A8_new.acc);

  Insert into nd_acc ( nd, acc)
  select DD_new.ND, a.acc
  from  nd_acc n, accounts a
  where n.nd = p_ndg and n.acc = a.acc and a.tip ='SG ' and a.kv = l_kv;

  ------------------------------- int_accn -----------
  i8.acc     := A8_new.acc;
  i8.BASEY   := NVL(p_basey, i8.BASEY);
  i8.ACR_DAT := DD_new.sdate -1 ;
  i8.ACRA    := null ;
  i8.ACRB    := null ;
  insert into int_accn    values i8 ;
  insert into int_ratn (acc, id, BDAT, IR ) values (i8.acc, i8.id, DD_new.sdate, p_ir);


  ---------------------------------���.����
  for dop in (select * from nd_txt where nd = dd_old.ND and tag not in  ('PR_TR' )  )
  loop begin dop.ND :=DD_new.ND;  CCK_APP.SET_ND_TXT(dop.nd, dop.tag, dop.txt);--INSERT INTO nd_txt values dop;
       exception when others then   if SQLCODE = -00001 then null;   else raise; end if;
       end;
  end loop;

  -------------------------------- CC_lim--------------
  INSERT INTO cc_lim (nd,fdat,acc,lim2,sumg, sumo ) VALUES (DD_new.ND, gl.bdate, a8_new.acc, l_s, 0  , 0       ) ;
  INSERT INTO cc_lim (nd,fdat,acc,lim2,sumg, sumo ) VALUES (DD_new.nd, dd_old.WDATE, a8_new.acc, 0  , l_s, l_s ) ;

 ---------------------------------cc_sob + ????
  INSERT INTO cc_sob (ND,FDAT,ISP,TXT ,otm) VALUES (DD_new.ND, gl.bDATE, gl.auid,'³������ ����� ��='|| dd_new.ND || ' ��� ��='|| dd_old.ND,6);



end OPN1 ;


procedure P9129 ( p_NDG cc_deal.ndG%type) is -- 9129 �� ���.����
begin
 NULL;
end;


procedure FINIS_3600  ( p_NDG cc_deal.ndG%type ) is
-- �� ������ ��� ������ ������� � ��=3600 �� ���� �������� � ��������� �� ����� ������ ��  SS � �������.������ �� 9129
-- ������ ����� 9129 !!!

  OST_3600  number ;
  QST_9129 number ;
  oo oper%rowtype;
  SDI accounts%rowtype ;
begin
  for s36 in (select a.nls, a.kv, d.ndG, a.ostc , a.nms, d.cc_id, d.sdate , c.okpo
              from (select *from accounts where ostc > 0 and nbs ='3600'       ) a,
                   (select * from cc_deal where ndg = nd and p_ndg in (0, ndg) ) d,
                   nd_acc n , customer c
              where n.nd = d.nd and n.acc = a.acc and d.rnk = c.rnk
             )
  loop
     OST_3600 := gl.p_icurval( s36.kv, s36.OSTC, gl.bdate) ;  --- ���-������� ����� 3600

     begin select - gl.p_icurval(a.kv,s.ostf - s.dos, gl.bdate)  -- ���-������� ����� 9129 ��� �������., ���� ��� ������ ������, �.�. ���������������� ������
           into QST_9129
           from nd_acc n, accounts a, saldoa s
           where n.nd = s36.NDG and n.acc = a.acc and a.acc= s.acc and s.kos >0 and a.tip='CR9' and s.fdat = gl.bdate ;

           -- ���-������ ������� ������ (�� ������� ��� �����)
           for ss in (select  gl.p_icurval(a.kv,s.dos,gl.bdate) DOSQ , n.nd, a.nbs, a.rnk, a.isp, a.mdate, a.branch, a.grp, d.cc_id, a.kv
                      from nd_acc n, cc_deal d, saldoa s, accounts a
                      where  s.dos >0 and s.fdat = gl.bdate and s.acc = a.acc and a.tip = 'SS ' and a.acc = n.acc and n.nd = d.nd and d.ndg = s36.NDG)


           loop oo.s := ROUND ( least ( ss.DOSQ /QST_9129, 1 ) * s36.OSTC , 0 );
                oo.s := LEAST ( OST_3600, oo.S );

                If oo.s > 0 then
                   begin select a.* into sdi from accounts a, nd_acc n where n.nd = ss.nd and a.tip ='SDI' and n.acc = a.acc ;
                   exception when no_data_found then             -- � ��� ����� ����
--                         sdi.nls := MSFZ9.Get_NLS(ss.KV, substr(ss.nbs,1,3) ||'6' ) ;
                         sdi.nls := get_nls4rnk('SDI',substr(ss.nbs,1,3) ||'6',ss.rnk,ss.kv,ss.nd);
                         CCK.cc_op_nls ( ss.ND,  ss.kv, sdi.nls, 'SDI', ss.isp, ss.GRP, '', ss.MDATE, sdi.acc);
                         select a.* into sdi from accounts a where acc = sdi.acc ;
                   end;
                   If ss.kv <> s36.kv then  oo.s2 := gl.p_Ncurval( ss.kv,  gl.p_icurval( s36.kv, oo.s, gl.bdate)  , gl.bdate );
                   else                     oo.s2 := oo.s ;
                   end if;

                   oo.tt   := '%%1' ;
                   oo.ref  := null ;
                   oo.nd   := substr(ss.cc_id,1,10);
                   oo.dk   := 1;
                   oo.kv   := s36.kv   ; oo.nlsa := s36.nls ;  oo.nam_a := substr(s36.nms,1,38);
                   oo.kv2  := sdi.kv   ; oo.nlsb := sdi.nls ;  oo.nam_b := substr(sdi.nms,1,38);
                   oo.nazn := Substr( '��������� ���� �������� (��������� ����) �������� ��� ������ �������. ���.'||s36.NDG ||' �� '|| to_char( s36.sdate, 'dd.mm.yyyy'), 1,160) ;
                   oo.id_a := s36.okpo ;
                   oo.id_b := s36.okpo ;
                   MSFZ9.opl (oo)      ;
                end if;
           end loop ; -- s
     exception when no_data_found then null ;
     end;

  end loop ; -- s36

end FINIS_3600;

---��������� ���� --------------
begin
  declare p4_ int;  acc_ number;
  begin   NLS_3739 := Vkrzn( substr( gl.aMfo, 1,5), '373909' );  NMS_3739 := '������� ��� ������������ �� (����-9)';
     for k in (select distinct kv from accounts where nbs like '20%' and ostc <>0)
     loop op_reg(99,0,0,0,p4_,gl.aRnk, NLS_3739, k.kv, NMS_3739, 'ODB', gl.auid,acc_ );   Accreg.setAccountSParam(acc_, 'OB22', '03') ; end loop;
  end;
--null;
end  ;

/
 show err;
 
PROMPT *** Create  grants  MSFZ9 ***
grant EXECUTE                                                                on MSFZ9           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on MSFZ9           to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/msfz9.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 