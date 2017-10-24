
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_nazn_fx.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_NAZN_FX --(nls_  VARCHAR2, kv_   VARCHAR2)
    (p_type  CHAR,     -- код маски
     p_nlsM  VARCHAR2, -- основной счет
     p_kvM   VARCHAR2, -- валюта основного счета
     p_nlsP  VARCHAR2, -- счет начисленных %%
     p_kvP   VARCHAR2) -- валюта счета начисленных %%
RETURN
  VARCHAR2
IS
  acc_   NUMBER;
  accr_  int;
  accn_  int;
  n_tcp  VARCHAR2(35);
  emi_   VARCHAR2(70);
  nazn_  VARCHAR2(160);
  cp_id_ CP_KOD.cp_id%TYPE;
  nd_    VARCHAR2(10);
  cena_ number; CENA_KUP_ number;
  IR_ number;
  kol_   int := 0; ostc_ number := 0;
  ostcn_ number := 0;
  paket_ varchar2(20);  stavka_ varchar2(20);

BEGIN
  BEGIN
    SELECT acc, ostc
    INTO acc_, ostc_
    FROM accounts
    WHERE nls=P_nlsM  AND kv=to_number(P_kvM);
  EXCEPTION WHEN NO_DATA_FOUND THEN ostc_:=0; acc_:=NULL;
  END;

  ostcn_:=ostc_;

  if substr(P_nlsm,4,1) = '8' then accr_:=acc_; acc_:=-5; end if;

  BEGIN

   select t.name,k.NAME,k.cp_id, v.nd, k.cena, k.CENA_KUP, k.IR,
          d.acc accn
   into n_tcp, emi_, cp_id_, nd_, cena_, CENA_KUP_, IR_, accn_
   from cp_deal d, cp_kod k, cp_type t, cp_v v
   where decode(acc_,-5,d.accr,d.acc)=decode(acc_,-5,accr_,acc_)
         and d.ID=k.id and d.ref=v.ref
         and k.idt=t.idt (+);

  if substr(P_nlsm,4,1) = '8' then
  BEGIN
    SELECT ostc INTO ostcn_
    FROM accounts
    WHERE acc=accn_;
  EXCEPTION WHEN NO_DATA_FOUND THEN ostcn_:=0;
  END;
  end if;

  kol_:= ostcn_/cena_*0.01;  paket_:='';
  if abs(kol_) >0 then paket_:=' пакет '||abs(kol_)||' шт.'; end if;

  if CENA_KUP_ is not NULL then stavka_:='Купон='||CENA_KUP_;
  else stavka_:='Ставка='||IR_||'%';
  end if;

  EXCEPTION WHEN NO_DATA_FOUND THEN n_tcp:='';emi_:='';
           cp_id_:=''; nd_:='';
  END;


  IF emi_ IS NOT NULL THEN
   nazn_ := 'Нарах.% по '||trim(n_tcp)||' '||trim(cp_id_)
          ||' уг. '||nd_
          ||paket_
          ||stavka_
          ||' за період';
  ELSE
   nazn_ := 'нарах.%(купон) по рах. '||P_nlsm;
  END IF;

  RETURN substr(nazn_,1,160);

END;
/
 show err;
 
PROMPT *** Create  grants  F_NAZN_FX ***
grant EXECUTE                                                                on F_NAZN_FX       to BARS010;
grant EXECUTE                                                                on F_NAZN_FX       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_NAZN_FX       to CP_ROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_nazn_fx.sql =========*** End *** 
 PROMPT ===================================================================================== 
 