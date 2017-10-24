
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/af2.sql =========*** Run *** ======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.AF2 (ref_ int,fdat_ date) return NUMBER IS
k_ int;
s_ number;
begin
 select count(*),sum(gl.p_icurval(kv,s,fdat_))
 into k_,s_
 from opl where ref=ref_ and fdat=fdat_ and dk=0 and substr(nls,1,1)<>8;
 if k_=0 then
    s_:=0;
 end if;
 return s_;
 end af2;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/af2.sql =========*** End *** ======
 PROMPT ===================================================================================== 
 