
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/kp_kom.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.KP_KOM (nd_ INT, s_ NUMBER, mode_ INT)
   RETURN NUMBER
IS
   pr_       NUMBER;
   sum_       NUMBER;
   res_      NUMBER;
   komU_flag_ NUMBER;
   komU_val_  NUMBER;
   nak_    NUMBER;
BEGIN

   if mode_ = 1 then
      begin
      select nak into nak_ from kp_deal where nd=nd_;
   end;
   if nak_ = 1 then  return 0;
   end if;
 end if;

   if mode_ = 1 then
      begin
       select komU_Flag,komU_Val into komU_flag_,komU_val_ from kp_deal where nd=nd_;
   end;
   if komU_flag_ = 0 then
     return ROUND (s_ * komU_val_ / 100, 2);
   elsif komU_flag_ = 1 then
     return komU_val_;
   end if;
   end if;


   BEGIN
      SELECT DECODE (mode_, 0, pr_fl, pr_ul),
             DECODE (mode_, 0, sum_fl, sum_ul)
        INTO pr_,
             sum_
        FROM kp_komis
       WHERE nd = nd_ AND s_ >= s1 AND s_ < s2 and type=mode_  ;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN 0;
   END;

   IF pr_ IS NOT NULL AND pr_ <> 0
   THEN
      res_ := ROUND (s_ * pr_ / 100, 2);
   ELSIF sum_ IS NOT NULL AND sum_ <> 0
   THEN
      res_ := sum_;
   ELSE
      res_ := 0;
   END IF;

   RETURN (res_);
END;
 
/
 show err;
 
PROMPT *** Create  grants  KP_KOM ***
grant EXECUTE                                                                on KP_KOM          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on KP_KOM          to R_KP;
grant EXECUTE                                                                on KP_KOM          to WR_ALL_RIGHTS;
grant EXECUTE                                                                on KP_KOM          to WR_KP;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/kp_kom.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 