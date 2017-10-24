
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/cpar.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CPAR (p_pkg varchar2, p_prc varchar2) RETURN int
IS
  n  int;
BEGIN
  if nvl(length(p_prc),0)=0 then
    return 0;
  end if;
  if nvl(length(p_pkg),0)=0 then
    select count(1)
    into   n
    from   user_arguments
    where  package_name is null and
           object_name=upper(p_prc);
  else
    select count(1)
    into   n
    from   user_arguments
    where  package_name=upper(p_pkg) and
           object_name=upper(p_prc);
  end if;
  RETURN n;
END cpar;
/
 show err;
 
PROMPT *** Create  grants  CPAR ***
grant EXECUTE                                                                on CPAR            to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/cpar.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 