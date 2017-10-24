
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/zvt_b.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.ZVT_B 
 (NBSD_ varchar2,  -- БС Дебет
  NBSK_ varchar2,  -- БС Кредит
  BRD_  varchar2,  -- Бранч счета-Дебет
  BRK_  varchar2,  -- Бранч счета-Кредит
  BRO_  varchar2   -- Бранч операции
  )

  return varchar2 result_cache is

  BR_ branch.branch%type := BRO_;
/*
22-07-2010 Sta Переопределение бранча операции
*/

begin
 If    NBSD_ in ('1001','1002','1101','1102',
                 '9702','9726','9751','9754',
                 '9810','9812','9819','9820','9821')     then bR_ :=  BRD_;
 elsIf NBSK_ in ('1001','1002','1101','1102',
                 '9702','9726','9751','9754',
                 '9810','9812','9819','9820','9821')     then bR_ :=  BRK_;
 else
      RETURN BR_;
 end if;

 If length(br_) > length(bro_) then     return BR_;  else return BRO_; end if;

end ZVT_B;
/
 show err;
 
PROMPT *** Create  grants  ZVT_B ***
grant EXECUTE                                                                on ZVT_B           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on ZVT_B           to RPBN001;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/zvt_b.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 