

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/BANK_PF1.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure BANK_PF1 ***

  CREATE OR REPLACE PROCEDURE BARS.BANK_PF1 ( P_MODE INT, p_dat date) is
/*

 10.04.2014 oper.sos = 5 - ��������� ���-���������

�������� ���� ��������� <DemkovichMS@oschadbank.ua>
�� 03/04/2014 12:04

�� ���������� ����� ����������� �� �������� �������� ������ ���������� ����� �� ������
  ��3, ��5, ��7, ��9, ���, ���, ���, ���,  AAN, DPF, EDP, MUQ, MVQ, VPF, 046
  --------------------------------------------------------------------------
  � ��� ����� MILLENNIUM� - ����������� ����� �� ���������� �������� ������� ����������� ��������������
  �� ����������� ����������� ������ �� ��������������� �������
  �� ������� 7419/07 �� �������� 3622/12.

�� ���������� ����� �������� ������ ��� ������ �������� ����� �� ������������� �������
  3540, 3640 (��� CV7),
              -------
����������� ����� �� ���������� �������� ������� ����������� ��������� ��������� ��������� �� �����
  �420�.

������� 7419/07 - �� �������  ��� ����.
������� 3622 ������������ �� ��� ��볿 ����� �� ���������� �� �� ����������� �������.

������� ����� ��������� ��������, �� ����� ���������� �� ������ �� ���������� ����������� ��� �����������  ���.

--07.04.2014-------------------
� 3622 "������������ ������������� �� ��������� �� ����`�������� ���������, ��i� ������� �� ��������":
  12 - ��� �� ����"������ �������� ������� ����������� � �������� ����� �������� �������� ������ ���������� �����.
       (��3, ��5, ��7, ��9, ���, ���, ���, ���,  AAN, DPF, MUQ, MVQ, VPF, 046)
  35 - ��� �� ����"������ �������� ������� ����������� � �������� ����� ����������� �������� ������ ��� ������� ������.
       EDP,

(420, (F01- ��) ����� ��������� �/���)

����������� �������: ��� �� �������. ����. ����. �����. �� ����. ��
�� ������� ������������� �� ��������� ���������� ���� ���� �/����� �� ������� ��:
36227035017
36228012017

*/
-------------------------------------------------------------
 Q_ number := 0 ;   Q5_ number := 0 ;  oo oper%rowtype; A12 ACCOUNTS%ROWTYPE; A35 ACCOUNTS%ROWTYPE; nls7_ accounts.nls%type;
 rat_ number;
------------------
BEGIN
 IF nvl( P_MODE,0) not in (0,1)  THEN RETURN; END IF;

 execute immediate 'truncate table CCK_AN_TMP ';

 IF nvl( P_MODE,0)     in (0  )  THEN
    -- ������  �����
    insert into CCK_AN_TMP ( branch, kv,  n1,         pr,  nd, Name, name1 , n2, n3, n4 )
    select                   branch, kv,  q*5/1000 , nal, ref, tt  , tt1   ,  s, q , q/s
    from ( select NVL(T.NAL,0) NAL ,
                  a.kv , p.branch  ,
                  p.ref, p.tt tt   , o.tt tt1, p.s,
                  NVL( (select round(o.s*RATE_B/BSUM,0) from cur_rates$base WHERE kv=a.kv and branch=a.branch and vdate=p_dat),
                        gl.p_icurval(  a.kv, p.s, p_dat)
                     ) q
           from opldok o,  accounts a , PF_TT3800 T, oper p
           where o.dk = 1     and o.fdat = p_dat  and  o.acc = a.acc and a.nbs in ('3800') and ob22 in ('10','20')
             and T.tt = o.tt  and p.ref  = o.ref  and  p.sos = 5
          ) ;

    RETURN;
 end if;
 -------------------------------------
 -- ������ �������� �������� - � ������ ������ �� ����������
 oo.vob  :=  6 ;
 begin  select * into A12 from accounts where length(branch)=8 and kv=980 and dazs is null and  nbs='3622' and ob22='12' ;
 EXCEPTION when NO_DATA_FOUND THEN raise_application_error(-20000,'�� �������� ��� 3622/12 �� ���');
 end;

 begin  select * into A35 from accounts where length(branch)=8 and kv=980 and dazs is null and  nbs='3622' and ob22='35' ;
 EXCEPTION when NO_DATA_FOUND THEN raise_application_error(-20000,'�� �������� ��� 3622/35 �� ���');
 end;

 -- �������
 for k in (select   NVL(T.NAL,0) NAL, a.kv, substr(a.branch,1,15) branch,  sum(o.s) S
           from opldok o, accounts a, PF_TT3800  T, oper p
           where o.dk  = 1    and o.fdat = p_dat and o.acc = a.acc     and a.nbs in ('3800') and ob22 in ('10','20')
             and T.tt = o.tt  and p.ref  = o.ref and p.sos = 5
           GROUP BY NVL(T.NAL,0)    , a.kv, substr(a.branch,1,15)
          )
 loop
    begin select round( k.s * RATE_B/BSUM,0) into Q_ from cur_rates$base WHERE kv = k.kv and branch = k.branch and vdate = p_dat;
    EXCEPTION when NO_DATA_FOUND THEN Q_ := gl.p_icurval( k.kv, k.s, p_dat);
    end;
    If nvl(q_,0) <= 0 then Q_ := gl.p_icurval( k.kv, k.s, p_dat); end if;
    rat_ := q_ /k.s ;

    q5_ := round( q_ * 5/1000, 0 );
    If q_ > 0 then
--logger.info( 'PF ' ||k.kv ||' ' ||k.branch || ' ' ||k.nal );
       update CCK_AN_TMP set n1 = n1 + q5_ , -- ������� ����� ������ � ���
                             n2 = n2 + k.s , -- ������� ��������
                             n3 = n3 + q_    -- ���������� ��������
       where branch =  k.branch and pr = k.nal and kv = k.kv ;

       if SQL%rowcount = 0 then

          iF k.nal = 1 THEN OO.NLSA := A12.NLS;
          ELSE    OO.NLSA := A35.NLS;
          END IF;

--        OP_BS_OB1 (PP_BRANCH => k.branch, P_BBBOO => '741907' );
          nls7_:= substr(nbs_ob22_null('7419','07', k.branch), 1, 14 );
--logger.info( 'PF*' ||k.kv ||' ' ||k.branch || ' ' ||k.nal );

          insert  into CCK_AN_TMP ( kv, branch, n1, NLS, NLSALT, PR, n2, n3, n4   )
                values (k.kv    , --
                        k.branch, -- �����-2
                        q5_     , -- n1 = ������� ����� ������ � ���
                        nls7_   , -- �� 7419/07
                        OO.NLSA , -- �� 3622
                        K.NAL   , -- PR =1 - ������� ������
                        k.s     , -- n2 = ������� ��������
                        q_      , -- n3 = ���������� ��������
                        rat_      -- n4 = ��������� ����
                        );
       end if;
    end if;
 end loop ; -- k
 -------------------------------------------------------------------------------

 FOR  Z IN (SELECT PR, NLSALT, SUM(N1) S FROM CCK_AN_TMP where n1 >0 group by pr, nlsalt)
 LOOP
    gl.ref (oo.REF);
    oo.nd:= trim(substr('      ' ||to_char(oo.ref), -10));
    OO.NAZN := '����-��� �� �������. ����. ����. �����. �� ����. �� �� '|| to_char(p_dat,'dd.mm.yyyy') ;

    iF Z.PR = 1 THEN OO.NLSA := A12.NLS; OO.NAM_A := SUBSTR(A12.NMS,1,38);  OO.NLSB := '36228012017';  OO.NAM_B:='������i� � ���i����';
    ELSE             OO.NLSA := A35.NLS; OO.NAM_A := SUBSTR(A35.NMS,1,38);  OO.NLSB := '36227035017';  OO.NAM_B:='������i� � ���/���i����';
    END IF;

    if gl.aMfo = '300465' then oo.tt := 'PS1' ; else oo.tt := 'PS2'; end if;

    gl.in_doc3(ref_   => oo.ref   , tt_   => oo.tt    , vob_  => oo.vob   ,  nd_   => oo.nd   , pdat_ => SYSDATE  , vdat_ => gl.bdate ,
               dk_    => 1        , kv_   => 980      , s_    => Z.S      ,  kv2_  => 980     , s2_   => Z.S      , sk_   => null     ,
                data_ => gl.bdate , datp_ => gl.bdate , nam_a_=> oo.nam_a ,  nlsa_ => oo.nlsa , mfoa_ => gl.aMfo  , nam_b_=> oo.nam_b ,
                nlsb_ => oo.nlsb  , mfob_ => '300465' , nazn_ => oo.nazn  ,  d_rec_=> null    , id_a_ => gl.aOkpo , id_b_ =>'00032129' ,
                id_o_ => null     , sign_ => null     , sos_  => 1        ,  prty_ => null    , uid_  => null     );

    paytt ( 0, oo.ref, gl.bdate, oo.tt, 1, 980, oo.nlsa, z.s, 980, oo.NLSb, z.s);

    oo.tt   :='420';
    for k in ( select kv, branch, n1,n2, n3, n4, nls from CCK_AN_TMP where n1 >0 and pr = z.pr )
    loop
        gl.payv( 0, oo.ref, gl.bdate, oo.tt, 0, 980, oo.nlsa, k.n1, 980, K.NLS, k.n1);
        update opldok set txt = substr('���=' || k.kv || ', ���='|| k.n2 || ', ���='|| k.n3 || ', ���� = '|| k.n4,1,50)
          where ref = oo.ref and stmt = gl.aStmt;

    end loop; -- ������ 1 ��������

 end loop; -- Z

 -- ������ ��� ���� - ������� ��������
 if gl.aMfo = '300465' then oo.tt := 'PS1' ; else oo.tt := 'PS2'; end if;
 gl.ref (oo.REF);
 oo.nd:= trim(substr('      ' ||to_char(oo.ref), -10));
 OO.NAZN := '����-������������� �� �������. ����. ����. �����. �� ������� �� �� '|| to_char(p_dat,'dd.mm.yyyy') ;

 begin  select * into A12 from accounts where length(branch)=8 and kv=980 and dazs is null and  nbs='2902' and ob22='09' ;

   OO.NLSA  := A12.NLS;
   OO.NAM_A := SUBSTR(A12.NMS,1,38);
   OO.NLSB  := '29022009017';
   OO.NAM_B :='������i� � ���i����';
   oo.s     := least (  fkos(a12.acc, p_dat, p_dat) , a12.ostc);

   if oo.s >0 then
      gl.ref (oo.REF);
      gl.in_doc3(ref_   => oo.ref   , tt_   => oo.tt    , vob_  => oo.vob   ,  nd_   => oo.nd   , pdat_ => SYSDATE  , vdat_ => gl.bdate ,
                 dk_    => 1        , kv_   => 980      , s_    => oo.S     ,  kv2_  => 980     , s2_   => oo.S     , sk_   => null     ,
                  data_ => gl.bdate , datp_ => gl.bdate , nam_a_=> oo.nam_a ,  nlsa_ => oo.nlsa , mfoa_ => gl.aMfo  , nam_b_=> oo.nam_b ,
                  nlsb_ => oo.nlsb  , mfob_ => '300465' , nazn_ => oo.nazn  ,  d_rec_=> null    , id_a_ => gl.aOkpo , id_b_ =>'00032129' ,
                  id_o_ => null     , sign_ => null     , sos_  => 1        ,  prty_ => null    , uid_  => null     );
      paytt ( 0, oo.ref, gl.bdate, oo.tt, 1, 980, oo.nlsa, oo.s, 980, oo.NLSb, oo.s);
   end if;
 EXCEPTION when NO_DATA_FOUND THEN raise_application_error(-20000,'�� �������� ��� 2902/09 �� ���');
 end;

 begin  select * into A12 from accounts where length(branch)=8 and kv=980 and dazs is null and  nbs='2902' and ob22='15' ;

   OO.NLSA  := A12.NLS;
   OO.NAM_A := SUBSTR(A12.NMS,1,38);
   OO.NLSB  := '29027015017';
   OO.NAM_B :='������i� � ���/���i����';
   oo.s     := least (  fkos(a12.acc, p_dat, p_dat) , a12.ostc);

   if oo.s >0 then
      gl.ref (oo.REF);
      gl.in_doc3(ref_   => oo.ref   , tt_   => oo.tt    , vob_  => oo.vob   ,  nd_   => oo.nd   , pdat_ => SYSDATE  , vdat_ => gl.bdate ,
                 dk_    => 1        , kv_   => 980      , s_    => oo.S     ,  kv2_  => 980     , s2_   => oo.S     , sk_   => null     ,
                  data_ => gl.bdate , datp_ => gl.bdate , nam_a_=> oo.nam_a ,  nlsa_ => oo.nlsa , mfoa_ => gl.aMfo  , nam_b_=> oo.nam_b ,
                  nlsb_ => oo.nlsb  , mfob_ => '300465' , nazn_ => oo.nazn  ,  d_rec_=> null    , id_a_ => gl.aOkpo , id_b_ =>'00032129' ,
                  id_o_ => null     , sign_ => null     , sos_  => 1        ,  prty_ => null    , uid_  => null     );
      paytt ( 0, oo.ref, gl.bdate, oo.tt, 1, 980, oo.nlsa, oo.s, 980, oo.NLSb, oo.s);
   end if;
 EXCEPTION when NO_DATA_FOUND THEN raise_application_error(-20000,'�� �������� ��� 2902/15 �� ���');
 end;


end Bank_PF1;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/BANK_PF1.sql =========*** End *** 
PROMPT ===================================================================================== 
