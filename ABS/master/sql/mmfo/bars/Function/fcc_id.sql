
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fcc_id.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FCC_ID (nd_ INTEGER) RETURN varchar2 IS
nn_     varchar2(10);
BEGIN
   SELECT cc_id
   INTO nn_
   FROM  cc_deal
   WHERE nd  = nd_;
   if nn_ is null THEN
      nn_:='';
   end if;
   RETURN nn_;
END FCC_ID;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fcc_id.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 