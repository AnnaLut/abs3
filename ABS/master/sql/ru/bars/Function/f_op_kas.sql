
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_op_kas.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_OP_KAS (ref_ in NUMBER,stmt_ in NUMBER)
 return number is
kas number ;
kol number ;
begin
  begin
    kol:=0;
 select count(*) into kol from opldok o,accounts a
    where o.ref=ref_ and o.stmt=stmt_ and a.acc=o.acc(+)
    and exists (select o.acc from opldok o,accounts a
        where o.ref=ref_ and o.stmt=stmt_ and a.acc=o.acc(+)
  and SUBSTR(a.nls,1,2)='10'
     and SUBSTR(a.nls,1,4) not in ('1005','1007')
	 );
    exception when NO_DATA_FOUND THEN kas:=1 ;
  end ;
  if kol<>0 then kas:=2; -- KAS
    else kas:=1;         -- NOT KAS
  end if;
 RETURN kas;
end f_op_kas;
/
 show err;
 
PROMPT *** Create  grants  F_OP_KAS ***
grant EXECUTE                                                                on F_OP_KAS        to ABS_ADMIN;
grant EXECUTE                                                                on F_OP_KAS        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_OP_KAS        to RPBN001;
grant EXECUTE                                                                on F_OP_KAS        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_op_kas.sql =========*** End *** =
 PROMPT ===================================================================================== 
 