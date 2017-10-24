
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/fin_deb.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.FIN_DEB IS  G_HEADER_VERSION  CONSTANT VARCHAR2(64)  :=  'ver.1.1  26.05.2015' ;
------------------------------------------------------------------
/*
01-10.09.2015 ������ � cc_deal �������� ������ �������� ��� ������� 0, 1, 6 - �� �������������� � �.��������
                  37 ��������� �� : 137=�����, 237=��, 337=��
           �������� ��.
���������� ���������
*/
---================================================================
PROCEDURE Del_acc ( p_nd number, p_nls varchar2  , p_kv int    , p_acc number ) ;  --��������� "������ ����"
PROCEDURE Ins_acc ( p_nd number, p_nls varchar2  , p_kv int    , p_acc number ) ;  --��������� "�������� ����"  
PROCEDURE Upd_nd  ( p_ND number, p_CC_ID varchar2, p_SDATE date, p_WDATE date ) ;  --�������� ��.��������� ���
--------------------------------------------------------------------------
------------------------------------------------------------
function  Frot1 ( p_mod_abs int, p_prod varchar2, p_acc int, p_rnk number) return varchar2 ; --������������ ���������  �� 1 �����
PROCEDURE prot1 ( p_mod_abs int, p_prod varchar2, p_acc int, p_rnk number, p_nd OUT number, p_err OUT  varchar2 ); --������������ ���������  �� 1 �����
PROCEDURE prot   ( p_mod int, p_prod varchar2 ) ;  --������������ ���������  �� 
------------------------------------------------------------
function sum_mod(p_mod int, p_prod varchar2, p_kv int ) return number ;
-------------------------------------------------------------
function header_version return varchar2;
function body_version   return varchar2;
-------------------

END FIN_DEB;
/
CREATE OR REPLACE PACKAGE BODY BARS.FIN_DEB IS  G_BODY_VERSION  CONSTANT VARCHAR2(64)  :=   'ver.1.3  21.10.2015';

/*
21.10.2015 �������� � ������������� ������ ( �� �� 3578.05 �����)
05.10.2015 ������ ��������� � ��� ���
02.10.2015 ������ � cc_deal �������� ������ �������� ��� ������� 0, 1, 6 - �� �������������� � �.��������
                  37 ��������� �� : 137=�����, 237=��, 337=��
           �������� ��.
��������CO��� ���������
*/
PROCEDURE Del_acc ( p_nd number, p_nls varchar2  , p_kv int    , p_acc number ) is  --��������� "������ ����"
begin
  if p_acc >0 then delete from nd_acc where nd=p_nd and acc = p_acc ;
  else             delete from nd_acc where nd=p_nd and acc = (select acc from accounts where kv = p_kv and nls = p_nls) ;
  end if;
end Del_acc;
------------------------------------------------------------------------------
PROCEDURE Ins_acc ( p_nd number, p_nls varchar2  , p_kv int    , p_acc number ) is  --��������� "�������� ����"
  aa accounts%rowtype ;
  dd cc_deal%rowtype  ;
  cc customer%rowtype ;
  ff fin_debt%rowtype ;
  sTmp_ varchar2(200) ;
begin

  begin sTmp_ := ' ���. �� �������� !';
     if p_acc > 0 then sTmp_ := '���= '||      p_acc || sTmp_; select * into aa from accounts where acc = p_acc;
     else              sTmp_ :=  p_nls ||'/'|| p_kv  || sTmp_; select * into aa from accounts where kv  = p_kv and nls = p_nls ;
     end if;
  EXCEPTION WHEN NO_DATA_FOUND    THEN  raise_application_error(  -(20203), sTmp_ );
  end;

  begin sTmp_ := '���.'|| aa.nls || ', RNK='|| aa.rnk || ' ��.���='|| gl.aOkpo || ' - ������������ !';
     select * into cc from customer where rnk = aa.rnk and okpo <> gl.aOkpo ;
  EXCEPTION WHEN NO_DATA_FOUND    THEN  raise_application_error(  -(20203), sTmp_ );
  end ;

  dd.vidd := cc.custtype *100 + 37 ;

  If p_nd > 0 then
     begin  sTmp_  := '��� ���=' || p_nd || ' � ������� �� (vidd='|| dd.vidd || ') �� �������� !' ;
        select * into dd from cc_deal where vidd = dd.vidd  and sos < 15  and nd = p_nd ;
     EXCEPTION WHEN NO_DATA_FOUND    THEN  raise_application_error(  -(20203), sTmp_ );
     end ;
  else
     dd.prod:= aa.nbs||aa.ob22 ;
     begin sTmp_  := '���� �����, ��� �������� (�� ���) ='|| dd.prod || ' �� � ��� ! ';
           select * into ff from fin_debt where nbs_n = substr(dd.prod,1,6) and mod_abs in (0, 1, 6 )  ;
     EXCEPTION WHEN NO_DATA_FOUND    THEN  raise_application_error(  -(20203), sTmp_ );
     end ;
  end if ;
  -------------------------------
  sTmp_ := '���.' || aa.nls || '/' || aa.kv || ' ��� ����`����� �� ���� ����� � ���. = '     ;
  begin  select d.* into dd from nd_acc n, cc_deal d where n.acc = aa.acc and n.nd = d.nd and rownum = 1;
         sTmp_:= sTmp_|| dd.nd || ', Vidd = ' || dd.vidd ;  raise_application_error(  -(20203), sTmp_ );
  EXCEPTION WHEN NO_DATA_FOUND    THEN  Null ;
  end;
  -------------------------------
  dd.vidd := cc.custtype *100 + 37 ;
  If nvl ( p_nd,0 ) = 0 then
     select bars_sqnc.get_nextval('S_CC_DEAL') into dd.ND from dual;
--   dd.cc_id :=  'FD/'||dd.prod||'/'||aa.rnk;
     dd.cc_id :=  'FD/'||aa.nls ||'/'||aa.kv;
     dd.wdate := nvl(aa.mdate,TO_DATE('31/12/2050', 'DD/MM/YYYY'));
     Insert into CC_DEAL   (ND, SOS,    CC_ID,   SDATE,    WDATE,    RNK, VIDD, LIMIT, USER_ID,    BRANCH,    PROD)
                 Values (dd.nd, 10 , dd.cc_id, aa.daos, dd.wdate, aa.rnk, dd.vidd, 0    ,  aa.isp, aa.branch, dd.prod);
  else
     sTmp_ := '���/���.'|| aa.nls   || '(' || aa.nbs   || '.' || aa.ob22  || ') ���������� ��� ������ �������� ��� : ' ||
                           ff.nbs_n || ' ' || ff.nbs_p || ' ' || ff.nbs_k ;
     If (aa.nbs|| aa.ob22)  NOT in  ( ff.nbs_n, nvl(ff.nbs_p, ff.nbs_n) , nvl(ff.nbs_k, ff.nbs_n) )  then
        raise_application_error(  -(20203), sTmp_ );
     end if;
  end if ;
  ---------------------------------------------------
  insert into nd_acc (nd,acc) values (dd.nd, aa.acc);
  ---------------------------------------------------
  if aa.ostc < 0 and  (aa.nbs||aa.ob22) = ff.nbs_p  then
     update cc_deal set sos = 13 where nd = dd.nd ;
  end if;

end Ins_acc;

----------------------------------------------------------------------------
PROCEDURE Upd_nd  ( p_ND number, p_CC_ID varchar2, p_SDATE date, p_WDATE date ) is  --�������� ��.��������� ���
begin
   update cc_deal set cc_id = p_cc_id, SDATE = p_SDATE , WDATE = p_WDATE  where nd = p_nd;
   if SQL%rowcount = 0 then  raise_application_error(  -(20203), '��� ���=' || p_nd || ' �� ��������  !' );  end if ;
end Upd_nd   ;
-----------------

function  Frot1 ( p_mod_abs int, p_prod varchar2, p_acc int, p_rnk number) return varchar2 is --������ ��������.������������ ���������  �� 1 �����
   l_kol  number  ; l_nd number ; l_err varchar2 (100) := null; l_vidd number;
begin
   select count(*), max(nd) into l_kol, L_nd from nd_acc where acc = p_acc;
   If l_kol > 1 then L_err := '1.1) ������� ����� 1 ���� �� ND_acc';   goto RET_ ;   end if;
   If l_kol = 1 then
      --0 ���� ��������/cc_deal
      --1 MONEX. ������� ��������/cc_deal
      --2 �� ��
      --3 �� ��
      --6 CIN. �����.��������� (����� � ���)/cc_deal
      begin select vidd into l_vidd from cc_deal where nd = L_nd ;
            if l_vidd in  (  1,  2,  3) and  p_mod_abs = 2 OR
               l_vidd in  ( 11, 12, 13) and  p_mod_abs = 3 OR
               l_vidd in  (137,237,337) and  p_mod_abs in (0,1,6) then  null;
            else  L_err := '1.2) CC_DEAL.vidd='||l_vidd ||' �� ���.0,1,2,3,6' ;
            end if;
            goto RET_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN null ;
      end;
   end if;

   --4 ���������/ And
   select count(*),     max(nd) into l_kol, L_nd from e_deal where acc36 = p_acc ;
   If l_kol > 1         then  L_err := '4.1) ������� ����� 1 ���� �� E_deal';         goto  RET_ ;  end if;
   If l_kol = 1 then
      If p_mod_abs != 4 then  L_err := '4.2) ������� � E_DEAL, ��� �� � ��� 4' ; else  goto  RET_ ;  end if;
   end if;

   --5 ���/And
   select count(*),     max(nd) into l_kol, L_nd from rko_lst where acc1 = p_acc ;
   If l_kol > 1         then  L_err := '5.1) ������� ����� 1 ���� �� RKO_LST';        goto  RET_ ;  end if;
   If l_kol = 1 then
      If p_mod_abs != 5 then  L_err := '5.2) ������� � RKO_LST, ��� �� � ��� 5' ; else goto  RET_ ;  end if;
   end if;

   --7 ��� WAY4 (���� ������)
   begin select    nd into       L_nd from W4_acc where acc_3570 = p_acc ;
         If p_mod_abs != 7 then  L_err := '7.2) ������� � W4_acc, ��� �� � ��� 7'; else   goto RET_ ;  end if;
   EXCEPTION WHEN NO_DATA_FOUND THEN  null;
             when others  then
                  if sqlcode= -01422 then L_err := '7.1) ������� ����� 1 ���� �� W4_acc' ; goto RET_ ;
                  else raise;
                  end if;
   end;

   begin select '0.0) ������� ��.���='|| gl.aOkpo into L_err from customer where rnk = p_rnk and okpo = gl.aOkpo;
   EXCEPTION WHEN NO_DATA_FOUND THEN                   L_err := '0.1) �� � CC_DEAL,EC_DEAL,RKO_LST,W4_ACC';
   end;

   <<RET_>> null;
   RETURN substr('000000000000000000000000000'||l_nd, -20)|| l_err ;

end Frot1;
---------
PROCEDURE prot1 ( p_mod_abs int, p_prod varchar2, p_acc int, p_rnk number, p_nd OUT number, p_err OUT  varchar2 ) is --����������� � �������� 2������������ ���������  �� 1 �����
   l_kol0  int :=0 ; l_kol4 int:=0 ;  l_kol5 int :=0 ;
   l_nd    number  ; l_err varchar2 (100) := null; l_vidd number;
   l_prodP varchar2(10);
begin

   select count(*), max(nd) into l_kol0, L_nd from nd_acc where acc = p_acc;

   If l_kol0 > 1 then
      If p_mod_abs in (0,1,6) then
         l_kol0 := 1 ;
         for z in (select * from nd_acc where acc = p_acc and nd <> l_nd )
         loop delete from nd_acc where nd = z.nd ; end loop   ;
      else    L_err := '1.1) ������� ����� 1 ���� �� ND_acc' ; goto  RET_ ;
      end if;
   end if;

   If l_kol0 = 1 then
      --0 ���� ��������/cc_deal
      --1 MONEX. ������� ��������/cc_deal
      --2 �� ��
      --3 �� ��
      --6 CIN. �����.��������� (����� � ���)/cc_deal
      begin select vidd into l_vidd from cc_deal where nd = L_nd ;
            if l_vidd in  (  1,  2,  3) and  p_mod_abs = 2 OR
               l_vidd in  ( 11, 12, 13) and  p_mod_abs = 3 OR
               l_vidd in  (137,237,337) and  p_mod_abs in (0,1,6) then  null;
            else  L_err := '1.2) CC_DEAL.vidd='||l_vidd ||' �� ���.0,1,2,3,6' ;
            end if;
            goto RET_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN null ;
      end;
   end if;

   -------------------------------------    4 ���������/ And
   select count(*),     max(nd) into l_kol4, L_nd from e_deal where acc36 = p_acc ;
   If l_kol4 > 1         then    ----------- L_err := '4.1) ������� ����� 1 ���� �� E_deal';  goto  RET_ ;
      l_kol4 := 1 ;
   end if;
   If l_kol4 = 1 then
      If p_mod_abs != 4 then  L_err := '4.2) ������� � E_DEAL, ��� �� � ��� 4' ; else  goto  RET_ ;  end if;
   end if;

   ------------------------------------     5 ���/And
   select count(*),     max(nd) into l_kol5, L_nd from rko_lst where acc1 = p_acc ;
   If l_kol5 > 1         then       ---------L_err := '5.1) ������� ����� 1 ���� �� RKO_LST';    goto  RET_ ;
      l_kol5 :=  1 ;
   end if;
   If l_kol5 = 1 then
      If p_mod_abs != 5 then  L_err := '5.2) ������� � RKO_LST, ��� �� � ��� 5' ; else goto  RET_ ;  end if;
   end if;

   --7 ��� WAY4 (���� ������)
   begin select    nd into       L_nd from W4_acc where acc_3570 = p_acc ;
         If p_mod_abs != 7 then  L_err := '7.2) ������� � W4_acc, ��� �� � ��� 7'; else   goto RET_ ;  end if;
   EXCEPTION WHEN NO_DATA_FOUND THEN  null;
             when others  then
                  if sqlcode= -01422 then L_err := '7.1) ������� ����� 1 ���� �� W4_acc' ; goto RET_ ;
                  else raise;
                  end if;
   end;

   begin select '0.0) ������� ��.���='|| gl.aOkpo into L_err from customer where rnk = p_rnk and okpo = gl.aOkpo;
         goto RET_ ;
   EXCEPTION WHEN NO_DATA_FOUND THEN null;
   end;

   If p_mod_abs NOT in (0, 1, 6)   then
      If l_kol4 = 0 and l_kol5 = 0 then   L_err := '0.1) �� � CC_DEAL,EC_DEAL,RKO_LST,W4_ACC';  end if ;
      goto RET_ ;
   End if;

   If l_kol0 = 0 then
      begin
        fin_deb.Ins_acc ( p_nd => null, p_nls=>null, p_kv =>null, p_acc => p_acc);
        select nbs_p into l_prodP from fin_debT where  nbs_n = p_prod ;

        If l_prodP is not null then  select nd into l_nd from nd_acc where acc = p_acc and rownum = 1 ;
           for p in (select acc,ostc from accounts where rnk=p_rnk and nbs||ob22 = l_prodP and acc not in (select acc from nd_acc) and dazs is null)
           loop  fin_deb.Ins_acc ( p_nd => l_nd, p_nls=>null, p_kv => null, p_acc => p.acc);
                 if p.ostc < 0 then update cc_deal set sos= 13 where nd = l_nd ; end if;
           end loop;
        end if;
      EXCEPTION WHEN NO_DATA_FOUND THEN  L_err := '0.2) ��.�� ���������';   goto RET_ ;
      end ;
   End iF ;
   <<RET_>> null;
   p_nd   := l_nd ; p_err := l_err ;
   RETURN ;

end prot1;
--------

PROCEDURE prot   ( p_mod int, p_prod varchar2 ) is
  l_FROT1 varchar2 (100); l_nd number; l_err varchar2(40);
begin

  If    p_mod in (1,9)    then  execute immediate 'truncate table fin_debVY ';  -- ������ �������
  Elsif p_mod in (2)      then  delete  from fin_debVY where fin <>7 ;
  Elsif p_mod in (3)      then  delete  from fin_debVY where fin = 7 ;
  else  RETURN ; -- -- ������ ��������
  end if;

logger.info('FIN_1 insert ');

  insert /*+ APPEND */  into fin_debVY ( FIN,    PROD,   KV,   NLS,   ACC,   OST ,   NMS, RNK, nd )
  select             f.mod_abs, f.nbs_n, a.kv, a.nls, a.acc, a.ostc, substr(a.nms,1,40), a.rnk, 0
  from  accounts A,
      (select * from fin_debt where p_mod=1  OR  p_mod=2 and mod_abs<>7  OR  p_mod=3 and mod_abs=7 )  F
  where A.dazs is null and a.nbs||A.ob22 = F.nbs_n ;
  commit;

logger.info('FIN_2 for k ');

  for k in ( select rowid RI, FIN,PROD,acc, rnk from  fin_debVY )
--loop  l_FROT1 := FIN_DEB.FROT1( k.FIN, k.PROD, k.acc, k.rnk) ;
  loop FIN_DEB.prot1 ( k.FIN, k.PROD, k.acc, k.rnk, l_nd,  l_err ) ;  --����������� � �������� 2������������ ���������  �� 1 �����
       update fin_debVY  set nd =  l_nd, SERR = l_err where rowid = k.RI;
  end loop;

logger.info('FIN_3 finis ');

end prot      ;
------------------------------------------------------------
function sum_mod(p_mod int, p_prod varchar2, p_kv int ) return number is
 l_s number ;
begin

 If p_mod in (0, 1 ) then
-----��� ������   CC_DEAL --������ ----------------------------------
    select nvl(sum(a.ostc),0) into l_s
    from (select acc,ostc from accounts where kv = p_kv and nbs||ob22 = p_prod  ) a,
         nd_acc n,
         (select nd       from cc_deal  where vidd=37 and sos <15 )  d
    where  a.acc = n.acc and n.nd = d.nd;

 elsif p_mod in (2, 3 ) then
----- �� : CC_DEAL --������ ----------------------------------
    select nvl(sum(a.ostc),0) into l_s
    from (select acc,ostc from accounts where kv = p_kv and nbs||ob22 = p_prod  ) a,
         nd_acc n,
         (select nd       from cc_deal  where ( p_mod = 2 and vidd in (1,2,3)  OR  p_mod = 3 and vidd in (11,12,13) )  and sos <15 )  d
    where  a.acc = n.acc and n.nd = d.nd;


-------��������� E_DEAL---������------------------------------
 elsif p_mod in (4 ) then
    select nvl(sum(a.ostc),0) into l_s  from accounts a, e_deal d  where a.kv = p_kv and a.nbs||a.ob22 = p_prod  and a.acc = d.ACC36 ;

-------��� RKO_LST--������-------------------------------
 elsif p_mod in (5 ) then
    select nvl(sum(a.ostc),0) into l_s  from accounts a, rko_lst d  where a.kv = p_kv and a.nbs||a.ob22 = p_prod  and a.acc = d.ACC1 ;

-------CIN_CUST --������+������-------------------------------
 elsif p_mod in (6 ) and gl.amfo = '300465' then
     execute immediate
    'select nvl(sum(a.ostc),0) from accounts a, cin_cust d where a.kv = '|| p_kv ||' and a.nbs||a.ob22 = ''' || p_prod ||''' and a.nls = d.NLS_3578 ' into l_s;

-------��� WAY4 --�������� -------------------------------
 elsif p_mod in (7 ) then
    select nvl(sum(a.ostc),0) into l_s  from accounts a, W4_ACC d  where a.kv = p_kv and a.nbs||a.ob22 = p_prod  and a.acc = d.ACC_3570 ;

 end if;

 return l_s ;

end sum_mod ;

------------------------------------------------------------
function header_version return varchar2 is begin  return 'Package header FIN_DEB '||G_HEADER_VERSION; end header_version;
function body_version   return varchar2 is begin  return 'Package body   FIN_DEB '||G_BODY_VERSION; end body_version;
--------------

---��������� ���� --------------
begin
  null;
END FIN_DEB;
/
 show err;
 
PROMPT *** Create  grants  FIN_DEB ***
grant EXECUTE                                                                on FIN_DEB         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FIN_DEB         to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/fin_deb.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 