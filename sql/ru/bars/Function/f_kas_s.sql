
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_kas_s.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_KAS_S          (ref_ in NUMBER,stmt_ in NUMBER,dk_ in number)
 return number is
S_ number;
sk_ number;
sd_ number;
begin
    select s into sk_ from opldok where ref=ref_ and stmt=stmt_
	and dk=dk_ and acc in (select acc from accounts where nbs like '10%');
    begin
	  select s into sd_ from opldok where ref=ref_ and stmt=stmt_
	  and dk=dk_-1 and acc in (select acc from accounts where nbs='3801')	;
      exception when NO_DATA_FOUND THEN sd_:=0;
    end;
	select iif_n(sd_,sk_,sk_,sk_,sd_) into s_ from dual;
 RETURN s_;
end f_kas_s;
/
 show err;
 
PROMPT *** Create  grants  F_KAS_S ***
grant EXECUTE                                                                on F_KAS_S         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_KAS_S         to RPBN001;
grant EXECUTE                                                                on F_KAS_S         to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_kas_s.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 