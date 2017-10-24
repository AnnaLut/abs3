
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/cc_o_nls.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CC_O_NLS 
  (bal_ varchar2,
   RNK_  int,
   sour_ int,
   ND_   int,
   kv_   int,
   tip3_ varchar2
  )
RETURN number IS

 ACC_    accounts.acc%type :=null;
 tip_bal_ VARCHAR2(3):=null;
 prod_   cc_deal.prod%type :=null;
 tt_     varchar2(3);

BEGIN

 ACC_:=CC_O_NLS_EXT(bal_,rnk_,sour_,ND_,KV_,tip_bal_,TIP3_,prod_,tt_);

 RETURN ACC_;


END cc_O_NLS ;
/
 show err;
 
PROMPT *** Create  grants  CC_O_NLS ***
grant EXECUTE                                                                on CC_O_NLS        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CC_O_NLS        to RCC_DEAL;
grant EXECUTE                                                                on CC_O_NLS        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/cc_o_nls.sql =========*** End *** =
 PROMPT ===================================================================================== 
 