
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/br3_finrez.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.BR3_FINREZ ( p_ref  number, p_stmt number, p_dk int) return varchar2 is
  -- OPПРЕДЕЛЕНИЕ БРАНЧА ДЛЯ ДОХ/РАСХ
  branch_ varchar2(22) := null  ;  k_NBS     accounts.nbs%type ;  k_NlS     accounts.nls%type ;
  k_branch  accounts.branch%type;  k_B2      char(2)           ;  k_txt     opldok.txt%type   ;
  tt_     oper.tt%type   ;  nazn_   oper.nazn%type ;  mfoa_   oper.mfoa%type ;  mfob_   oper.mfoa%type ;
  nlsk_   oper.nlsb%type ;  kvk_    oper.kv%type   ;  kvi_    oper.kv%type   ;
begin
 begin
   select a.NBS, a.branch, substr(a.nbs,2,1) B2, o.txt , a.nls   into   k_nbs, k_branch, k_b2,  k_txt   , k_nls
   from opldok o, accounts a
   where a.acc = o.acc  and o.ref = p_ref and o.stmt = p_stmt     and o.dk  = p_dk  and (a.nls like '6%' or a.nls like '7%');
 exception when NO_DATA_FOUND THEN return branch_;
 end;
 If k_txt like '/%'  then    BRANCH_ := k_txt;    return branch_; end if;
 select branch , tt, mfoa , mfob ,   decode(nlsb,k_nls, nlsa, nlsb),      decode(nlsb,k_nls, kv  , kv2 ),
        NVL( decode ( kv, gl.baseval, nvl(kv2, kv), KV ) , gl.baseval) ,     nazn
 into   BRANCH_, tt_, mfoa_, mfob_, nlsk_, kvk_, kvi_, nazn_  from   oper  where  ref = p_ref;

 If k_nbs = '6204' and kvi_=gl.baseval and mfoa_=mfob_ and nlsk_ like '3801%' and tt_<>'REV' then
    kvi_ :=to_number(substr(nlsk_,12,3) ) ;
 end if;
 -- надо определить бранч, кому принадлежат эти дох/расх  !!!!! -- Доп реквизит в OPLDOK  - самый главный
-------------------------------------------------------------------
   If nazn_ like 'Переведення залишку з%' and tt_ ='024' then BRANCH_ := k_branch; -- Стартов_е остатки - по месту прописки счета
   elsIf k_txt like '/' || gl.amfo || '/%'               then BRANCH_ := k_txt;    -- 3  |<Додаткове уточнення>   | рознесення затрат (госп,зарпл,...) за допомогою <мак-3>
   elsIf k_b2 = '0' OR k_b2 = '1' and nlsk_ like '35%'   then                      --  Процентные+Комиссионные (по методу начисления)
      begin  select branch into BRANCH_ from accounts where kv=KVK_ and nls=NLSK_; -- 1  |<Мiсце заключення угоди>| бранч рах.2638, 2208, 3578,...контрсчета
      EXCEPTION WHEN NO_DATA_FOUND THEN null;
      end;
   ElsIf k_b2 >'2' OR mfoa_<>mfob_ OR length(branch_)=8  then                      -- 4   |<Мiсце прописки рах6/7> | Власне бранч-2 рахунку 6/7 класу
      If length(BRANCH_) < 15 then BRANCH_ := k_branch; end if;
   end if;
    -- 2   |<Мiсце вводу операцiї>  | бранч, де ввели операцiю :вал/обм, разову ком,...
    --      Остальное - по умолчанию - от места возникновения операции  BRANCH_  := oper.branch
    return branch_;

end br3_finrez ;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/br3_finrez.sql =========*** End ***
 PROMPT ===================================================================================== 
 