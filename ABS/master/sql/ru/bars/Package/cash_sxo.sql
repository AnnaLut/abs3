
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/cash_sxo.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.CASH_SXO IS  G_HEADER_VERSION  CONSTANT VARCHAR2(64)  :=  'ver.1 03.06.2015' ;
------------------------------------------------------------------
BranchC branch.branch%type;  -- ����� ����
BranchS branch.branch%type;  -- ����� ������ �������
----------------------------
-- �������������� ����� ������� �� ��������,
procedure SET_SXO  ( p_branch branch.branch%type, p_branch_sxo branch.branch%type )  ;
-- ���������  ����� ������� � 1002  -> �� 1001
procedure SET_��S  ( p_nbs accounts.nbs%type, p_branch accounts.branch%type )  ;
--------------------------------------------------------------------------------

function  GET_SXO  ( p_branch branch.branch%type) Return branch.branch%type          ; -- �������� ����� �������
function  BC  Return branch.branch%type; -- �������� ���� ������� �����
function  BS  Return branch.branch%type; -- �������� ����� ������ �������

function header_version return varchar2;
function body_version   return varchar2;
-------------------

END CASH_SXO;
/
CREATE OR REPLACE PACKAGE BODY BARS.CASH_SXO is
   g_body_version  constant varchar2(64)  :=   'ver.1.3.1  01.09.2015';

-------------------------------------------------
/*
 01.09.2015 ��뺺�� ��� Mfo in ('305482', '351823','352457','311647') 305482	-��������������� ������������ -351823	��������� ������������
 - 352457	���������� ������������ -311647	����������� ������������
 ��������  ������ 1002 �� 1001
 19.06.2015 Sta ��� Mfo in ('322669', '336503') then      -- 26	322669	�� �� �� �.���� � ���.  --  9	336503	�-���������� ������������
                ��������  ������ 1002 �� 1001

 18.06.2015 Sta ��������� ��������� �������� ������
 10.06.2015 Sta ��������  �������� ������ 1002 �� 1001

  �������������� ����� ������� �� ��������,
*/
-------------------------------------------------
procedure SET_SXO  (  p_branch  branch.branch%type, p_branch_sxo branch.branch%type )  is
   p4_ int;           l_nls_kas  accounts.nls%type; l_branch     branch.branch%type ;
begin
   begin  select branch  into l_branch from branch2 where branch = p_branch     and DATE_CLOSED is null;
   exception when no_data_found then raise_application_error(-(20000),'\      �� �������� �����-2, �� ���������������, ��� ����� ������� '||p_branch );
   end;
   begin  select branch  into l_branch from branch2 where branch = p_branch_sxo and DATE_CLOSED is null;
   exception when no_data_found then raise_application_error(-(20000),'\      �� ���� ������� �����-2 ���������� ����� ��� ����� ������� '||p_branch_sxo );
   end;

   -- ��/�������� ����� ---------------------------------------------------------
   if nbs_ob22_null('1007', '01', p_branch_sxo ) is null then
      OP_BSOBV(1,980,'100701', p_branch_sxo,'','','');
      OP_BSOBV(1,840,'100701', p_branch_sxo,'','','');
      OP_BSOBV(1,978,'100701', p_branch_sxo,'','','');
      OP_BSOBV(1,643,'100701', p_branch_sxo,'','','');
   end if;

   if nbs_ob22_null(1107, '01', p_branch_sxo) is null then
      OP_BSOBV(1,961,'110701', p_branch_sxo,'','','');
      OP_BSOBV(1,959,'110701', p_branch_sxo,'','','');
   end if;

   If gl.aMfo in ('305482', '351823','352457','311647') then
      -- 	305482	��������������� ������������  	09305480
      -- 	351823	��������� ������������   		09351600
      -- 	352457	���������� ������������        	02766367
      -- 	311647	����������� ������������   		09311380
      ---- ������ 1002 �� 1001
      CASH_SXO.SET_��S(p_nbs =>'1002',  p_branch => p_branch_sxo);
      CASH_SXO.SET_��S(p_nbs =>'1102',  p_branch => p_branch_sxo);
   end if;

   -- ������������� �������� ���������� ������-2 � ��� �����������  --
   for b in ( select * from branch where branch like p_branch ||'%' )
   loop
      for t in ( select * from branch_parameters where branch = p_branch_sxo
                    and   tag in ( 'CASH7', --	������� - ����� � �����	1007	01
                                   'CASH17', --	������� - ����.������ � �����	1107	01
                                   'CASHS'  --	������� - ����� � ������� �����	100
                                 )
                )

      loop update branch_parameters  set  val = t.val  where branch = b.branch  and tag = t.tag ;
           if SQL%rowcount = 0 then  insert INTO branch_parameters (branch, tag, val) values (b.branch, t.tag, t.val);   END IF;
      END LOOP ; -- T
   END LOOP; ------ b

end SET_SXO ;
------------------
-- ���������  ����� ������� � 1002  -> �� 1001
procedure SET_��S  ( p_nbs accounts.nbs%type, p_branch accounts.branch%type )  is
  oo oper%rowtype; l_p4 int ; l_acc number;
begin
  oo.nam_a := '���� �������� �������' ;
  oo.NAZN  := '��������� �������� �������' ;

  For k in (select * from accounts where dazs is null and nbs =p_nbs and branch = p_branch)
  loop
     oo.nlsa  := vkrzn ( substr(gl.aMfo,1,5), (k.nbs-1)||'0'|| substr (k.nls,6,9) );
     update accounts set dazs = null, tobo = k.branch  where kv=k.kv and nls = oo.nlsa and dazs is not null;

     op_reg_lock( mod_  => 99     , p1_=> 0   , p2_ => 0       , p3_ => k.grp, p4_ =>l_p4 , rnk_ => k.rnk,
                  p_nls_=> oo.nlsa, kv_=> k.kv, nms_=> oo.nam_a, tip_=> k.tip, isp_=>k.isp, accR_=> l_acc,  tobo_ => k.branch  ) ;

     If k.kv in (980, 959) then   update BRANCH_PARAMETERS set val = oo.nlsa where val = k.nls;   end if;

     If k.ostc < 0  then  OO.S := - K.OSTC ;
        If oo.ref is null then
           gl.ref (oo.ref);
           gl.in_doc3(ref_  => oo.REF,  tt_   => '013', vob_ => 222,      nd_  => P_NBS||'/'|| (P_NBS-1),   pdat_  => SYSDATE ,
                      vdat_ => GL.BD ,  dk_   => 1    , kv_  => K.kv ,    s_   => OO.S    , kv2_  => K.KV,    s2_  => OO.S,
                      sk_   => 66,      data_ => GL.BD, datp_=> gl.bd,   nam_a_=>OO.NAM_A , nlsa_ => OO.NLSA, mfoa_=> gl.aMfo,
                      nam_b_=> SUBSTR(K.NMS,1,38)     , nlsb_=> K.NLS,   mfob_ => gl.aMfo ,
                      nazn_ => oo.NAZN, d_rec_=> null , id_a_=>gl.aOkpo, id_b_ => gl.aOkpo,
                      id_o_ => null   , sign_ => null , sos_ => 1,       prty_  => null   ,  uid_ => null);
        end if;
        begin
            select nls into oo.nlsb from accounts where branch= k.branch and kv= k.kv and dazs is null and nbs= Substr(p_nbs,1,3)||'7' and rownum=1;
            gl.payv ( 0, oo.REF, gl.bd, 'TOG', 1, k.kv, oo.nlsa, oo.s, k.kv, oo.nlsb, oo.s ); -- TOG �������������� � ������� ������ �� ����
            gl.payv ( 0, oo.REF, gl.bd, 'TOA', 1, k.kv, oo.nlsb, oo.s, k.kv, k.nls  , oo.s ); -- TOA ³�������� �������� ������ �� �������
        exception when no_data_found then oo.nlsb := null;
        end;

     end if;
  end loop;

end SET_��S;
---------------------------------------------------

function  GET_SXO  ( p_branch branch.branch%type) Return branch.branch%type  is  -- �������� ����� �������
                     l_branch_sxo branch.branch%type ;
begin
    begin select a.branch  into l_branch_sxo    from accounts a, BRANCH_PARAMETERS p
          where p.branch = p_branch and p.tag = 'CASH7' and p.val = a.nls and a.kv = 980;
    exception when no_data_found then null;
    end;
    return l_branch_sxo;
end GET_SXO;
---------------------------------------------------

procedure KWT7 ( p_dat1 date , p_dat2 date)  is
-----------------------------------------------
  type many1  is record ( ACC number, s number, refd number, stmtD number,  refk number, STMTK number, fdatD date, fdatK date );
  type many   is table of many1 index by varchar2(20);
  tmp  many   ;  INDK  varchar2 (20) ;
  l_dat2 date := nvl( p_dat2, p_dat1 );
begin
  If p_dat1 is null then return; end if;

  execute immediate  'truncate table  CCK_AN_TMP ';

  tmp.delete;
  for d in (select a.acc, s.fdat
            from accounts a, saldoa s
            where a.nbs in ('1007','1107','9891','9893','9899' ) and a.acc=s.acc and s.fdat >= p_dat1 and s.fdat <= l_dat2
--and a.kv=980 and a.nls='10070926000001'
              order by a.acc, s.fdat
            )
  loop
     -- Yd - ���� �����
     for Yd in (select * from opldok where acc = d.acc and dk = 0 and fdat = d.fdat and sos = 5
--and ref = 21847838
)
     loop
        -- � ����� Yd - ���� ������ Yk
        INDK := null;
        for Yk in (select * from opldok where acc = d.acc and dk = 1 and fdat >= Yd.fdat and fdat <=l_dat2 and sos = 5 and s = Yd.s
                   order by ref )
        loop
           INDK := to_char (Yk.stmt);
           -- ���������� !!
           if NOT tmp.exists(INDK) then
              tmp(INDK).acc   :=  d.acc  ;
              tmp(INDK).fdatd := Yd.fdat ;
              tmp(INDK).s     := Yd.s    ;
              tmp(INDK).refd  := Yd.ref  ;
              tmp(INDK).stmtD := Yd.stmt ;
              tmp(INDK).refk  := Yk.ref  ;
              tmp(INDK).stmtK := Yk.stmt ;
              tmp(INDK).fdatK := Yk.fdat ;
              exit;
           end if ;
           INDK   := null ;
        end loop  ; ----- ����������

        If INDK is null then
           -- Nd = �� ������������ �����
           INDK := to_char (-Yd.stmt) ;
           tmp(INDK).acc   :=  d.acc  ;
           tmp(INDK).fdatd := Yd.fdat ;
           tmp(INDK).s     := Yd.s    ;
           tmp(INDK).refd  := Yd.ref  ;
           tmp(INDK).stmtD := Yd.stmt ;
           tmp(INDK).stmtK := null    ; --\
           tmp(INDK).stmtK := null    ; --/
           tmp(INDK).fdatK := null    ;
        end if;
     end loop ; --- od
     ------------------------

     for Nk in (select * from opldok where acc = d.acc and dk = 1 and fdat = d.fdat and sos = 5)
     loop
        INDK := to_char (Nk.stmt);
        -- �� ���������� ������ (��������� ????)
        if NOT tmp.exists(INDK) then
           tmp(INDK).acc   :=  d.acc  ;
           tmp(INDK).fdatd :=  null   ;
           tmp(INDK).s     := Nk.s    ;
           tmp(INDK).refd  := null    ;
           tmp(INDK).stmtD := null    ;
           tmp(INDK).refk  := Nk.ref  ;
           tmp(INDK).stmtK := Nk.stmt ;
           tmp(INDK).fdatK := Nk.fdat ;
        end if ;
     end loop  ;

  end loop ; --- D

  INDK := tmp.first      ; -- ���������� ������ ��  ������ ������
  while INDK is not null
  loop

     If tmp(INDK).refd is not NULL and tmp(INDK).refk is not NULL then
        insert into CCK_AN_TMP (BRANCH, ACC, KV, NLS, CC_ID, zalq, ZAL, REZ,        NLSALT, N1, N2, USERID, NAME, PR,     srok,  N3, N4, UV, NAME1, PRS )
        select a.branch,  a.acc , a.kv, a.nls, substr(a.nms,1,20), fost(a.acc, tmp(INDK).fdatD-1 ), fost(a.acc, tmp(INDK).fdatD ), tmp(INDK).s ,
                  to_char( tmp(INDK).fdatD,'yyMMdd' ),             x.ref, tmp(INDK).stmtD, x.USERID, x.branch,
                                                                 (select to_number(to_char(dat,'HH24MI')) from oper_visa where ref=x.ref and status=2),
                  to_number(to_char( tmp(INDK).fdatK,'yyMMdd' )) , y.ref, tmp(INDK).stmtk, y.USERID, y.branch,
                                                                 (select to_number(to_char(dat,'HH24MI')) from oper_visa where ref=y.ref and status=2)
        from oper x, oper y , accounts a
        where x.ref = tmp(INDK).refd and y.ref = tmp(INDK).refk and a.acc = tmp(INDK).acc ;

     ElsIf tmp(INDK).refd is not NULL  then

        insert into CCK_AN_TMP (BRANCH, ACC, KV, NLS, CC_ID, zalq, ZAL, REZ,        NLSALT, N1, N2, USERID, NAME, PR )
        select a.branch,  a.acc , a.kv, a.nls, substr(a.nms,1,20), fost(a.acc, tmp(INDK).fdatD-1 ), fost(a.acc, tmp(INDK).fdatD ), tmp(INDK).s ,
                  to_char( tmp(INDK).fdatD,'yyMMdd' ),             x.ref, tmp(INDK).stmtD, x.USERID, x.branch,
                                                                 (select to_number(to_char(dat,'HH24MI')) from oper_visa where ref=x.ref and status=2)
        from oper x, accounts a
        where x.ref = tmp(INDK).refd and a.acc = tmp(INDK).acc ;

     ElsIf tmp(INDK).refk is not NULL  then

        insert into CCK_AN_TMP (BRANCH, ACC, KV, NLS, CC_ID, zalq, ZAL, REZ,         srok,  N3, N4, UV, NAME1, PRS )
        select a.branch,  a.acc , a.kv, a.nls, substr(a.nms,1,20), fost(a.acc, tmp(INDK).fdatD-1 ), fost(a.acc, tmp(INDK).fdatD ), tmp(INDK).s ,
                  to_number(to_char( tmp(INDK).fdatK,'yyMMdd' )) , y.ref, tmp(INDK).stmtk, y.USERID, y.branch,
                                                                 (select to_number(to_char(dat,'HH24MI')) from oper_visa where ref=y.ref and status=2)
        from oper y , accounts a
        where y.ref = tmp(INDK).refk and a.acc = tmp(INDK).acc ;

     end if;


     INDK   := tmp.next(INDK); -- ���������� ������ �� ����.���� ������
  end loop    ; --- D

end KWT7;

------------------------------
function  BC  Return branch.branch%type is  begin RETURN  CASH_SXO.BranchC ; end BC ;   -- �������� ���� ������� �����
function  BS  Return branch.branch%type is  begin RETURN  CASH_SXO.BranchS ; end BS ;   -- �������� ����� ������ �������

function header_version return varchar2 is begin  return 'Package header CASH_SXO '||g_header_version; end header_version;
function body_version   return varchar2 is begin  return 'Package body CASH_SXO '||g_body_version; end body_version;
--------------

---��������� ���� --------------
begin
  CASH_SXO.BranchC := SUBSTR (SYS_CONTEXT ('bars_context', 'user_branch'), 1, 30) ;
  CASH_SXO.BranchS := CASH_SXO.GET_SXO    ( CASH_SXO.BranchC);
end CASH_SXO;
/
 show err;
 
PROMPT *** Create  grants  CASH_SXO ***
grant EXECUTE                                                                on CASH_SXO        to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/cash_sxo.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 