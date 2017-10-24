
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/cc_o_nls_extf.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CC_O_NLS_EXTF 
  (bal_     in varchar2,
   RNK_     in int,
   sour_    in int,
   ND_      in int,
   kv_      in int,
   tip_bal_ in varchar2,
   tip3_    in varchar2,
   PROD_    in varchar2,
   TT_      in varchar2
  )
RETURN number IS

 ACC_    accounts.acc%type :=null;
 tts_     varchar2(3);

BEGIN
 tts_:=substr(ltrim(rtrim(tt_)),1,3);
 ACC_:=CC_O_NLS_EXT(bal_,rnk_,sour_,ND_,KV_,tip_bal_,TIP3_,prod_,tts_);
 dbms_output.put_line ('TT='||tts_);

 RETURN ACC_;


END CC_O_NLS_EXTf ;
/
 show err;
 
PROMPT *** Create  grants  CC_O_NLS_EXTF ***
grant EXECUTE                                                                on CC_O_NLS_EXTF   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CC_O_NLS_EXTF   to RCC_DEAL;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/cc_o_nls_extf.sql =========*** End 
 PROMPT ===================================================================================== 
 