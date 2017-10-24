
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/cash_sxo.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.CASH_SXO IS  G_HEADER_VERSION  CONSTANT VARCHAR2(64)  :=  'ver.1 03.06.2015' ;
------------------------------------------------------------------
BranchC branch.branch%type;  -- бранч свой
BranchS branch.branch%type;  -- бранч своего сховища
----------------------------
-- переустановить бранч сховища на кустовой,
procedure SET_SXO  ( p_branch branch.branch%type, p_branch_sxo branch.branch%type )  ;
-- перевести  кассу сховища с 1002  -> на 1001
procedure SET_КАS  ( p_nbs accounts.nbs%type, p_branch accounts.branch%type )  ;
--------------------------------------------------------------------------------

function  GET_SXO  ( p_branch branch.branch%type) Return branch.branch%type          ; -- Получить бранч сховища
function  BC  Return branch.branch%type; -- Получить Свой текущий бранч
function  BS  Return branch.branch%type; -- Получить бранч своего сховища

function header_version return varchar2;
function body_version   return varchar2;
-------------------

END CASH_SXO;
/
CREATE OR REPLACE PACKAGE BODY BARS.CASH_SXO is
   g_body_version  constant varchar2(64)  :=   'ver.1.2  10.06.2015';
-------------------------------------------------
/*
10.06.2015 Sta  Временно  отложено Замену 1002 на 1001
 переустановить бранч сховища на кустовой,
*/
-------------------------------------------------
procedure SET_SXO  (  p_branch  branch.branch%type, p_branch_sxo branch.branch%type )  is
   p4_ int;           l_nls_kas  accounts.nls%type; l_branch     branch.branch%type ;
begin
   begin  select branch  into l_branch from branch2 where branch = p_branch     and DATE_CLOSED is null;
   exception when no_data_found then raise_application_error(-(20000),'\      Не знайдено Бранч-2, що підпорядковується, або бранч закрито '||p_branch );
   end;
   begin  select branch  into l_branch from branch2 where branch = p_branch_sxo and DATE_CLOSED is null;
   exception when no_data_found then raise_application_error(-(20000),'\      Не вірно вказано бранч-2 сховищного вузла або бранч закрито '||p_branch_sxo );
   end;

   -- До/открытие дорог ---------------------------------------------------------
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

/*
   Временно  отложено.
   ---- Замена 1002 на 1001
   CASH_SXO.SET_КАS(p_nbs =>'1002',  p_branch => p_branch_sxo);
   CASH_SXO.SET_КАS(p_nbs =>'1102',  p_branch => p_branch_sxo);
*/
   -- переустановка кассовых параметров Бранча-2 и его подчиненных  --
   for b in ( select * from branch where branch like p_branch ||'%' )
   loop
      for t in ( select * from branch_parameters where branch = p_branch_sxo
                    and   tag in ( 'CASH7', --	Рахунок - кошти в дорозі	1007	01
                                   'CASH17', --	Рахунок - банк.метали в дорозі	1107	01
                                   'CASHS'  --	Рахунок - кошти в сховищі банку	100
                                 )
                )

      loop update branch_parameters  set  val = t.val  where branch = b.branch  and tag = t.tag ;
           if SQL%rowcount = 0 then  insert INTO branch_parameters (branch, tag, val) values (b.branch, t.tag, t.val);   END IF;
      END LOOP ; -- T
   END LOOP; ------ b

end SET_SXO ;
------------------
-- перевести  кассу сховища с 1002  -> на 1001
procedure SET_КАS  ( p_nbs accounts.nbs%type, p_branch accounts.branch%type )  is
  oo oper%rowtype; l_p4 int ; l_acc number;
begin
  oo.nam_a := 'Каса Кущового Сховища' ;
  oo.NAZN  := 'Створення Кущового Сховища' ;

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
            gl.payv ( 0, oo.REF, gl.bd, 'TOG', 1, k.kv, oo.nlsa, oo.s, k.kv, oo.nlsb, oo.s ); -- TOG Оприбуткування в сховище готівки від ТВБВ
            gl.payv ( 0, oo.REF, gl.bd, 'TOA', 1, k.kv, oo.nlsb, oo.s, k.kv, k.nls  , oo.s ); -- TOA Відсилання надлишків готівки до сховища
        exception when no_data_found then oo.nlsb := null;
        end;

     end if;
  end loop;

end SET_КАS;
---------------------------------------------------


function  GET_SXO  ( p_branch branch.branch%type) Return branch.branch%type  is  -- Получить бранч сховища
                     l_branch_sxo branch.branch%type ;
begin
    begin select a.branch  into l_branch_sxo    from accounts a, BRANCH_PARAMETERS p
          where p.branch = p_branch and p.tag = 'CASH7' and p.val = a.nls and a.kv = 980;
    exception when no_data_found then null;
    end;
    return l_branch_sxo;
end GET_SXO;
------------------------------
function  BC  Return branch.branch%type is  begin RETURN  CASH_SXO.BranchC ; end BC ;   -- Получить Свой текущий бранч
function  BS  Return branch.branch%type is  begin RETURN  CASH_SXO.BranchS ; end BS ;   -- Получить бранч своего сховища

function header_version return varchar2 is begin  return 'Package header CASH_SXO '||g_header_version; end header_version;
function body_version   return varchar2 is begin  return 'Package body CASH_SXO '||g_body_version; end body_version;
--------------

---Аномимный блок --------------
begin
  CASH_SXO.BranchC := SUBSTR (SYS_CONTEXT ('bars_context', 'user_branch'), 1, 30) ;
  CASH_SXO.BranchS := CASH_SXO.GET_SXO    ( CASH_SXO.BranchC);
end CASH_SXO;
/
 show err;
 
PROMPT *** Create  grants  CASH_SXO ***
grant EXECUTE                                                                on CASH_SXO        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CASH_SXO        to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/cash_sxo.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 