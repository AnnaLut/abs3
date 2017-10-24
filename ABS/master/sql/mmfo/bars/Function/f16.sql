
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f16.sql =========*** Run *** ======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F16 (i_ int) return char is
n_  int; c3_ char(1); c2_ char(1); c1_ char(1); c0_ char(1);
begin
 c3_:=f16x(round(i_/4096 -0.5,0)); n_ :=mod(i_,4096);
 c2_:=f16x(round(n_/256  -0.5,0)); n_ :=mod(n_,256) ;
 c1_:=f16x(round(n_/16   -0.5,0)); n_ :=mod(n_,16)  ; c0_:=f16x(n_);
 return c3_||c2_||c1_||c0_;
end;
 
/
 show err;
 
PROMPT *** Create  grants  F16 ***
grant EXECUTE                                                                on F16             to CHCK002;
grant EXECUTE                                                                on F16             to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f16.sql =========*** End *** ======
 PROMPT ===================================================================================== 
 