
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_op_val.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_OP_VAL (ref_ in NUMBER)
 return number is
kv1 number ;
kol number ; -- определяет операцию как валютную если хотя бы одна проводка -вал
             -- 27-09-2002   QWA
begin
  begin
    select count(*) into kol from opl where ref=ref_ and exists (
    select kv from opl where ref=ref_ and kv<>980);
    exception when NO_DATA_FOUND THEN KV1:=1 ;
  end ;
  if kol<>0 then kv1:=2; -- VAL
    else kv1:=1;         -- UAH
  end if;
 RETURN KV1;
end f_op_val;
/
 show err;
 
PROMPT *** Create  grants  F_OP_VAL ***
grant EXECUTE                                                                on F_OP_VAL        to ABS_ADMIN;
grant EXECUTE                                                                on F_OP_VAL        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_OP_VAL        to RPBN001;
grant EXECUTE                                                                on F_OP_VAL        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_op_val.sql =========*** End *** =
 PROMPT ===================================================================================== 
 