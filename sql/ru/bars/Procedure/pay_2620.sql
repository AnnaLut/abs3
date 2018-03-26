CREATE OR REPLACE PROCEDURE BARS.PAY_2620
               (flg_ SMALLINT,  -- флаг оплаты
                ref_ INTEGER,   -- референция
               VDAT_ DATE,      -- дата валютировния
                 tt_ CHAR,      -- тип транзакции
                dk_ NUMBER,    -- признак дебет-кредит
                kv_ SMALLINT,  -- код валюты А
               nlsm_ VARCHAR2,  -- номер счета А
                 sa_ DECIMAL,   -- сумма в валюте А
                kvk_ SMALLINT,  -- код валюты Б
               nlsk_ VARCHAR2,  -- номер счета Б
                 ss_ DECIMAL    -- сумма в валюте Б
) IS
/* 23.08.2017 Sta COBUSUPABS-6338

Для проведення безготівкових ЛЮБИХ перерахувань з рахунків клієнтів (2620/20) військових
Умови:
-Платник (наш 2620/20, customer.OKPO, customer.NMK – тільки ПРИЗВІЩЕ  ) 
-Отримува – неважниво хто
-Признач.платежу  like %customer.OKPO%    +  like % сustomer.NMK%
6110/10(1%-но минимум 15грн, максимум 750 грн)
*/
  aa accounts%rowtype;  cc customer%rowtype; i_ int ;  oo oper%rowtype;
  ---------------------------------------------------------------------
  l_Kod   tarif.kod%type      :=  3     ;
  l_nbs   accounts.nbs%type   := '6110' ;
  l_ob    accounts.ob22%type  := '10'   ;
  l_tag   operw.tag%type      := 'KTAR ';
  l_ttD   tts.tt%type         := 'D06'  ;
  -----------------------------
begin  
  -- основная проводка 
  gl.payv(flg_,ref_, VDAT_, tt_,dk_,kv_,nlsm_,sa_,kvk_,nlsk_,ss_);
  return;
/*
  -- Комиссию НЕ берем
  iF KV_ <> GL.BASEVAL      or 
     gl.doc.NLSA  NOT LIKE '2620%' OR  -- счет не 2620
     gl.doc.MFOA  <>  gL.aMfo      OR  -- отправитель не в нашем МФО  
     gl.doc.MFOB  = gl.aMfo THEN       -- получатель     в нашем МФО 
     RETURN ;
  END IF;

  begin select ob22, rnk, branch INTO AA.ob22, aa.rnk, aa.branch  from accounts where kv = gl.baseval and nls =  gl.doc.NLSA ;  -- номер счета А
  EXCEPTION WHEN NO_DATA_FOUND THEN   raise_application_error(-20203,'PAY_2620: Не знайдено рахунок'||gl.baseval||'/'|| gl.doc.NLSA );
  end;

  If aa.ob22 = '20'  then
     begin select okpo, upper(nmk)  INTO cc.okpo, cc.nmk  from customer where rnk = aa.rnk ;  -- RNK счета А
     EXCEPTION WHEN NO_DATA_FOUND THEN   raise_application_error(-20203,'PAY_2620: Не знайдено кл.'||aa.rnk );
     end;
     If gl.doc.nazn        not like '%'||cc.okpo||'%'  then goto KOMIS_ ; end if ; -- комиссию берем , тк не совпадает ОКПО
     cc.nmk := trim  (cc.nmk); 
     i_     := instr (cc.nmk, ' ',1 ) -1 ;
     cc.nmk := substr(cc.nmk, 1 , i_)    ;
     If upper(gl.doc.nazn) not like '%'||cc.nmk ||'%'  then goto KOMIS_ ; end if ; -- комиссию берем , тк не совпадает ФИО ( толко фамилия )
     RETURN;  -- ура  ! 
  end if;

  <<komis_>> null;
  -----------------------------
  oo.nlsb := nbs_ob22_bra ( l_nbs, l_ob, substr( aa.branch, 1, 15 ) ) ; 
  oo.s    := f_tarif (l_Kod, kv_, gl.doc.NLSA, sa_, 0, null) ;
  if oo.s >=1  then  
     gl.payv ( flg_, ref_, VDAT_, l_ttD, 1, gl.baseval, gl.doc.NLSA, oo.s, gl.baseval,  oo.nlsb , oo.s ); 
     update operw set value = l_kod  where ref = ref_ and tag =l_tag;
     if SQL%rowcount = 0 then insert into operw (ref,tag, value) values (Ref_, l_tag, l_kod) ;  end if  ;
  end if;*/

END PAY_2620 ;
/

