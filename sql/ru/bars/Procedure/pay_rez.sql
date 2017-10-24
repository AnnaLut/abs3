

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PAY_REZ.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PAY_REZ ***

  CREATE OR REPLACE PROCEDURE BARS.PAY_REZ 
(flg_  SMALLINT      ,  -- флаг оплаты
 ref_  oper.ref%type ,  -- референция
 VDAT_ oper.vdat%type,  -- дата валютировния
 tt_   oper.tt%type  ,  -- тип транзакции
 dk_   oper.dk%type  ,  -- признак дебет-кредит
 kv_   oper.kv%type  ,  -- код валюты А
 nlsm_ oper.nlsa%type,  -- номер счета А
 sa_   oper.s%type   ,   -- сумма в валюте А
 kvk_  oper.kv2%type ,  -- код валюты Б
 nlsk_ oper.nlsb%type,  -- номер счета Б
 ss_   oper.s2%type     -- сумма в валюте Б
) is

 nTmp_ int ;
 nls24_ accounts.nls%type    ;
 kv24_  accounts.kv%type     ;

begin

  If tt_ in ('ARE','AR*') OR (nlsm_ not like '77%' and nlsk_ not like '77%' )
     then
     return;
  end if;
  ------------------------------------------------------

  begin

    If nlsm_ like '77%' then  nls24_ := nlsk_; kv24_ := kvk_;
    else                      nls24_ := nlsm_; kv24_ := kv_ ;
    end if;

    select 1 into nTmp_ from accounts A
    where a.nls = nls24_ and a.kv = kv24_
      and exists
  (select 1 from srezerv_ob22 where nbs_rez = A.nbs and ob22_rez = A.ob22     )
      and exists
  (select 1 from rez_protocol where substr(branch,1,15)=substr(A.branch,1,15) );

    raise_application_error
     (  -20203,
     '\ - PAY_REZ Недопустимая ручная проводка по форм/расформ Рез.фонда! ', TRUE);

   exception when NO_DATA_FOUND then RETURN;
   end;

END PAY_REZ;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PAY_REZ.sql =========*** End *** =
PROMPT ===================================================================================== 
