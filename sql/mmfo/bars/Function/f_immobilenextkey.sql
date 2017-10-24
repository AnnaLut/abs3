
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_immobilenextkey.sql =========*** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_IMMOBILENEXTKEY RETURN NUMBER
IS
  nn_  number;
BEGIN
--select min(num)
--into   nn_
--from   conductor
--where  num not in (select key FROM asvo_immobile);
  select nvl(max(key),0)+1
  into   nn_
  FROM   asvo_immobile;
  RETURN nn_;
END;
/
 show err;
 
PROMPT *** Create  grants  F_IMMOBILENEXTKEY ***
grant EXECUTE                                                                on F_IMMOBILENEXTKEY to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_IMMOBILENEXTKEY to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_immobilenextkey.sql =========*** 
 PROMPT ===================================================================================== 
 