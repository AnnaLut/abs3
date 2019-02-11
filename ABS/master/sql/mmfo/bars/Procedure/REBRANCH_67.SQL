PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/REBRANCH_67.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure REBRANCH_67 ***

CREATE OR REPLACE PROCEDURE BARS.REBRANCH_67
 ( p_mode int, p_branch_OLD accounts.branch%type, p_branch_NEW accounts.branch%type, p_nazn oper.nazn%type ) is
 OO OPER%ROWTYPE;
 l_datz date ;
 l_branch_OLD accounts.branch%type;
 l_branch_NEW accounts.branch%type;
 os number;
 l_sos number;

/*
  08.10.2018 Гриценя Ю.В. http://jira.unity-bars.com:11000/browse/COBUMMFO-9389  
  Плоску проводку замінили на складну, операції довізовуються БО. 
  Автозакриття рахунків прибрав. По заявці буде оновлена операція МГ1 (була не правильна на ММФО)
  Проводкі будуть іти через 3739(03) і будуть доплачуватися джобом BARS.PAYSOS0****  
   
  23.05.2017 Сухова Т.А
             процедура перенесення зал.рах 6-7 кл одного Бранч-2(old) на інший Бранч-2 (new)
             та їх наступне закриття
             використовуэться при закритті Бранч-2
*/

begin
 oo.nazn      := Substr( NVL( p_nazn,       PUL.get('NZN') ) , 1, 160)  ;
 If oo.nazn is null then oo.nazn := 'Перенесення залишку зг. постанови АТ "Ощадбанк" в звязку перепідпорядкуванням  ТВБВ' ; end if;

 l_branch_OLD := Substr( NVL( P_branch_OLD, PUL.get('BRO') ) , 1,  15)  ;
 l_branch_NEW := Substr( NVL( p_branch_NEW, PUL.get('BRN') ) , 1,  15)  ;

 oo.tt  := 'МГ1' ;
 l_datz := DAT_NEXT_U ( gl.bdate , 1);

 for k in (select acc, NLS NLSa, Substr(nms,1,38) nam_a, ostc, nbs_ob22_bra (nbs, ob22, l_branch_NEW) nlsb, KV
           from accounts A
           where dazs is null and branch = l_branch_OLD and substr(nbs,1,1) in ('6','7')
           )
 loop
 --    begin
    if k.ostc <> 0 and k.nlsb is not null  then

       select substr(nms,1,38) into oo.nam_b from accounts where kv = k.kv and nls = k.nlsb;

       If k.ostc > 0 then oo.dk := 1 ; oo.s := + k.ostc ;
       else               oo.dk := 0 ; oo.s := - k.ostc ;
       end if ;

       gl.ref (oo.REF);
       oo.nd := trim (Substr( '          '||to_char(oo.ref) , -10 ) ) ;
       gl.in_doc3 (ref_=>oo.REF ,   tt_  =>oo.tt  , vob_ =>6       ,  nd_  =>oo.nd   , pdat_=>SYSDATE, vdat_=>gl.bdate , dk_ =>oo.dk,
                   kv_ =>k.kv   ,   s_   =>oo.S   , kv2_ =>k.kv    , s2_   =>oo.S    , sk_  => null  , data_=>gl.BDATE,datp_=>gl.bdate,
                 nam_a_=>k.nam_a,  nlsa_ =>k.nlsa ,mfoa_ =>gl.amfo , nam_b_=>oo.nam_b, nlsb_=>k.nlsb , mfob_=>gl.aMfo,
                 nazn_ =>oo.nazn, d_rec_ =>null   ,id_a_ =>gl.aOkpo, id_b_ =>gl.aOkpo, id_o_=> null  , sign_=>null, sos_=>1, prty_=>null, uid_=>null );
       --gl.payv(0, oo.ref, gl.bdate, oo.tt, oo.dk, k.kv, k.nlsa, oo.s, k.kv,  k.nlsb, oo.s);
       --gl.pay (2, oo.ref, gl.bdate);
       gl.dyntt2(sos_   => l_sos,
                 mod1_  => 0,
                 mod2_  => 1,
                 ref_   => oo.REF,
                 vdat1_ => gl.bDATE,
                 vdat2_ => null,
                 tt0_   => oo.tt,
                 dk_    => oo.dk,
                 kva_   => k.kv,
                 mfoa_  => gl.amfo,
                 nlsa_  => k.nlsa,
                 sa_    => oo.S,
                 kvb_   => k.kv,
                 mfob_  => gl.aMfo,
                 nlsb_  => k.nlsb,
                 sb_    => oo.S,
                 sq_    => null,
                 nom_   => null);
                 
	  --http://jira.unity-bars.com:11000/browse/COBUMMFO-9389 
	  --автозакриття ремим, спрацьовував тригер BARS.CC_ACCOUNTS_DAZS (проставлення дати закриття коли є залишок), всі рахунки по яким будуть проволки закривати вручну. 
	  --в центурі виконання цього згортання не закінчувалося закриттям рахунків, тому закриваємо тільки ті рахунки по яким залишок 0.
      -- update accounts set dazs = l_datz where acc = k.acc;
      ----http://jira.unity-bars.com:11000/browse/COBUMMFO-9389
      --проводки все рівно довізовуються, тому коментуємо частину закриття рахунків.
--    ElsIf k.ostc = 0 then
--       update accounts set dazs = l_datz where acc = k.acc;

    end if;

 end loop;

end REBRANCH_67 ;
/
show err;

grant execute on REBRANCH_67 to  BARS_ACCESS_DEFROLE ;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/REBRANCH_67.sql =========*** End *
PROMPT ===================================================================================== 
