
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fsrok.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FSROK (ND_ INTEGER) RETURN SMALLINT IS
nn_     SMALLINT;
BEGIN
   SELECT round( (d.wdate-a.wdate)/30)
   INTO nn_
   FROM  cc_add a, cc_deal d
   WHERE a.nd = d.nd AND
         a.adds=0    AND
         a.nd = nd_ ;
   if nn_ is null THEN
      nn_:=0;
   end if;
   RETURN nn_;
END FSROK;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fsrok.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 