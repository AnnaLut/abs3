

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CCK_DU.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CCK_DU ***

  CREATE OR REPLACE PROCEDURE BARS.P_CCK_DU 
(p_dat1 date,  -- ������ ��������� % :���� �  ������������
 p_dat2 date,  -- ������ ��������� % :���� �� ������������
 p_mode int    -- =0 ������ ��������, =1 - �������� � ����������
 )
Is

/*

15.11.2013 Sta  p_mode int    -- =0 - ������ ��������      , ��� ����� ���� ��������������
                                 =1 - �������� � ����������, � ������  ���� ��������������

25.10.2013 Sta
  �� ���������� ����� ��������� ����  ARJK.DatF    - '���� �������� ������������ �� ����
  ���� ���� � 18 ��� ���� ������ = 23.04.2013
  ��.�. ��������, ������� ���� ��������� �� ������ ���� �� ������ � 23.04.2013 � ���� ���������� ����������
   (��������, ��� ���� 30.09.2013) ���� ������� �����.
   ����� ���������� ��� ������� ����� �������� ���� �������:

exec tuda;
exec P_ARJK_DATF ( p_id =>18,  p_dat => to_date('30-09-2013','dd-mm-yyyy') , p_mode =>0);
select  TOBO,   CC_ID,   SDATE,   WDATE,   RNK,  IN_DAT,  OUT_DAT, S/100  from s_ARJK_DATF ;

�������� �� �������� ���� �� �����, ��������������� � �������� ����-������ �������� ������ .
��� ��� �������� ����� ��������
select  substr(TOBO,1,15), sum(S)/100  from s_ARJK_DATF group by   substr(TOBO,1,15) having sum(S)>0;
 ���� �� ������ ����� ���������� ����� ��������  - ������ ������.
 ��� ������� ������, �� ��������� ����� �������� �� ���� � ����������� ����� �������������� ��� �� ����� ����������� !
 ���������� ���������� �� ���������� ���������� � ���������� %  31.10.2013  !!.

-----------------------
16.05.2013 Sta   ������� ����� 6 kl ����� ���-�������
14.05.2013 Kempf ������� ����� 6 kl ����� tmp tabl (������ 1 �������� - 4 �������. ������ 10 �� ������� )
13.05.2013 Sta �� ����� �������. ����� ����� ���� ����
  08.05.2013 Sta+����� �.�. ���.249-31-55 (��.7752) �� �� ���������    ����������� ��������
  ��� 28,02,2013 ��������� ���������� ��� � ���������� ������� �� �������� �� ����� ���������� �������
  Sta 10.01.2013 ��� ��� + ��� +������� +��� ��

******  ������������ �������i�  procedure P_CCK_DU  *************  ��� ����                *******

----------------------------
 ������� ������ � ���-���������

 EXISTS   --    ��������� �� ���� �������
 COUNT    --    �������� ������ ������
 LIMIT    --    �������� ������ �� ����� ������ �������� (��� �� ����������� ���������� ����� �������)
 FIRST and LAST  -- �������� 1-� �� �������
 PRIOR and NEXT  -- ������� ��������� �� ���������
 EXTEND          --��������� ������� (��� �� ����������� ���������� ����� �������)
 TRIM            --��������� ������� �� ����� �������� (��� �� ����������� ���������� ����� �������)
 DELETE          -- �������� �����  �� ��

*/
---------------------------
  TYPE rec6 IS RECORD (nls accounts.nls%type, nms accounts.nms%type);
  TYPE mas6 IS TABLE OF rec6 INDEX BY VARCHAR2(21);
  tmp  mas6;
  ind_ VARCHAR2(21);
---------------------------
 sTmp_  varchar2(60);
 DU_    int ;
 dat1_  date; -- ���� �������� ��
 DAT11_ date;
 dat2_  date; -- ���� ������ �� ��
 OB_    int ;
 dt1_   date; -- ������ ���������� �
 dt2_   date; -- ������ ���������� ��
 ND_  number;
 NOM_ number;
 PUL_ int   ;
 -------------------
 oo oper%rowtype   ;
 dd cc_deal%rowtype;
 jj arjk%rowtype   ;
 BBBBoo_  char(6)  ;
 l_newnbs number;
BEGIN

   l_newnbs := NEWNBS.GET_STATE;

 if p_dat1 is null or p_dat2 is null or p_dat2 < p_dat1 then
     raise_application_error(-20203,'\      ����������i ����', TRUE);
 end if;
 ----------
 oo.tt    := 'PS1'  ;
 oo.kv    := gl.baseval;
 oo.kv2   := gl.baseval;
 oo.dk    := 1 ;
 oo.vdat  := gl.BDATE  ;
 oo.vob   := 6;
 oo.sk    := null;

 -------------------------

 if p_mode = 1 then -- ������ ��� ������ "� ����������"

    -- 0) ���-������� ��� ������� ������ 6 ��.
    tmp.DELETE;
    for k in (select * from accounts where dazs is null and length(branch)=15 and kv=gl.baseval and nbs||ob22 in (decode(l_newnbs,0,'604665','605534'),
                                                                                                                  decode(l_newnbs,0,'6042F5','605256'),
                                                                                                                  decode(l_newnbs,0,'611137','')))
    loop
      ind_ := k.nbs||k.ob22||k.branch;
      tmp(ind_).nls := k.nls ;
      tmp(ind_).nms := k.nms ;
    end loop;

 end if;

 -- 1) ��������� ���� ��� ���������.
 EXECUTE IMMEDIATE 'truncate table CCK_AN_TMP_UPB';

 -- 2) ��������� ���� ��� ������� ����������.
 ------------------------------------
 Logger.info('TMP_ARJK_OPER-1-Begin');
   EXECUTE IMMEDIATE 'truncate table TMP_ARJK_OPER ';
   insert into  TMP_ARJK_OPER (vdat, KV, nlsa, nlsb, nazn, s, s2, nam_b, nd)
                    select vdat, KV, nlsa, nlsb, nazn, s, s2, nam_b, nd from oper where sos=5 and tt='%%1'
                       and (nlsa like '22_8%' and nlsb like '60%' or  nlsa like '3578%' and nlsb like decode(l_newnbs,0,'61%','65%'))
                       and  pdat>(p_dat1-5) and pdat<(p_dat2+5);
   commit;
 Logger.info('TMP_ARJK_OPER-2-End');
 -------------------------------

 for k in (SELECT * from TMP_ARJK_OPER )
 loop
    If NOT (k.vdat >= p_dat1  and k.vdat <= p_dat2) then  goto RecNext;  end if;

    If    k.nlsb like case when l_newnbs = 0 then '6046%' else '6055%' end then     BBBBoo_  := case when l_newnbs = 0 then '604665' else '605534' end;
    ElsIf k.nlsb like case when l_newnbs = 0 then '6042%' else '6052%'end then     BBBBoo_  :=  case when l_newnbs = 0 then '6042F5' else '605256' end;
    elsIf k.nlsb like case when l_newnbs = 0 then '6111%' else '' end then  BBBBoo_  :=  case when l_newnbs = 0 then '611137' else '' end;
    else  goto RecNext;
    end if;

    begin

       select n.nd into ND_ from nd_acc n, accounts a where n.acc=a.acc  and a.kv=k.kv and a.nls= k.nlsA and rownum=1;
       Pul_:= TO_NUMBER (cck_app.get_nd_txt (nd_, 'ARJK'));

       If p_mode = 1 then  --- �������� � ����������, � ������  ���� �������������� - ������� ������������������ ���.
          select * into jj from arjk where id = Pul_ and datf is null;
       end if;

       sTmp_ := cck_app.get_nd_txt ( ND_, 'DINDU');
       If sTmp_ is null then  goto RecNext;
       end if;
       dat1_ := to_date ( sTmp_,'dd/mm/yyyy') ;
       DAT11_:= dat1_;

       sTmp_ := cck_app.get_nd_txt ( ND_, 'DO_DU');
       If sTmp_ is null then dat2_ := null;
       else                  dat2_ := to_date ( sTmp_ ,'dd/mm/yyyy') -1 ;
       end if;

       sTmp_ := substr (k.nazn, instr(k.nazn, ' �� ',10)-8,8);
       dt1_  := to_date(sTmp_,'dd-mm-yy') ;
       sTmp_ := substr (k.nazn, instr(k.nazn, ' �� ',10)+4,8);
       dt2_  := to_date(sTmp_,'dd-mm-yy') ;

       select * into dd from cc_deal where nd = ND_ ;

    exception when others then goto RecNext;
    end;

    OB_  := dt2_ - dt1_  + 1 ; -- �� ������� ���� ��������� � ��
    dat1_:= greatest(    dat1_      , dt1_);
    dat2_:= least   (nvl(dat2_,dt2_), dt2_);
    DU_  := dat2_- dat1_ + 1 ; -- �� ������� ���� ��������� � ��
    --------------------------------------
    oo.s := round(k.s2 *du_/ob_,1); --���������� !!
    NOM_ := round(k.s  *du_/ob_,1);  --nominal
    If oo.s <= 0 then goto RecNext; end if;

-----������ �������� -----------------------------------------------------------

If p_mode = 1 then

    gl.ref (oo.REF)     ;
    oo.s2    := oo.s    ;
    oo.nlsa  := k.nlsb  ;
    oo.nam_a := k.nam_b ;
    ind_     := BBBBOO_ || substr(dd.branch,1,15);

    if tmp.EXISTS (ind_) then
       oo.nlsb  := tmp(ind_).nls;
       oo.nam_b := substr( tmp(ind_).nms, 1,38);
    Else
       --������� � �������� ���� 6 ��
       OP_BS_OB1 ( substr(dd.branch,1,15), BBBBoo_);
       begin
          select nls, substr(nms,1,38)  into oo.nlsb, oo.nam_b   from accounts
          where dazs is null   and  branch    = substr(dd.branch,1,15) and kv=gl.baseval  and  nbs||ob22 = BBBBoo_ ;
       exception when no_data_found then goto RecNext;
       end;
    end if;

    gl.bdate := oo.vdat;
    oo.nd    := k.nd ;
    oo.nazn  := substr('���������i ������ �� �� � '|| dd.cc_id     || ' �i� '|| to_char(dd.sdate,'dd.mm.yyyy') ||
                       ', �� ���� '|| to_char(DAT11_,'dd.mm.yyyy') || ' �i������� �i���������� ���� ������ '   , 1,160);
    gl.in_doc3(ref_  =>oo.REF  , tt_   =>oo.tt  , vob_ =>oo.vob  ,
               nd_   =>oo.nd   , pdat_ =>SYSDATE, vdat_=>oo.vdat , dk_=>oo.dk,
               kv_   =>oo.kv   , s_    =>oo.s   , kv2_ =>oo.kv2  , s2_=>oo.s2,
               sk_   =>oo.sk   , data_ =>oo.vdat, datp_=>oo.vdat ,
               nam_a_=>oo.nam_a, nlsa_ =>oo.nlsa, mfoa_=>gl.aMfo ,
               nam_b_=>oo.nam_b, nlsb_ =>oo.nlsb, mfob_=>gl.aMfo ,
               nazn_ =>oo.nazn , d_rec_=>null   , id_a_=>gl.aOkpo,
               id_b_ =>gl.aOkpo, id_o_ =>null   , sign_=>null    ,
               sos_  =>1       , prty_ =>null   , uid_ =>null   );
    gl.payv(0,oo.REF,oo.vdat,oo.tt,oo.dk,oo.kv,oo.nlsa,oo.s,oo.kv2,oo.nlsb,oo.s2);
end if;
-------------------------------------------------------------------------

    --��������
    insert into  CCK_AN_TMP_UPB
     ( TOBO, CC_ID,SDATE,WDATE,NAME,vidd,NLS,RNK,IN_DAT,OUT_DAT, S, dat_pog, SG_OSTC, SG_RATN, ROW_NUM, COUNT_DAY, KV, S_OSTC)
    select dd.branch, dd.cc_id, dd.sdate, dd.wdate,substr(k.nazn,1,100),substr(k.nazn,101,50),
           c.okpo, dd.rnk,  dat1_, dat2_, oo.s/100, to_number( to_char(DAT11_,'yyyymmdd')), k.ref, oo.ref, nd_, pul_, k.KV, nom_/100
    from customer c where c.rnk = dd.rnk;

   <<RecNext>> null;

 end loop;

 Logger.info('TMP_ARJK_OPER-3-Dela');

end  P_CCK_DU ;
/
show err;

PROMPT *** Create  grants  P_CCK_DU ***
grant EXECUTE                                                                on P_CCK_DU        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_CCK_DU        to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CCK_DU.sql =========*** End *** 
PROMPT ===================================================================================== 
