
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/applistnextid.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.APPLISTNEXTID RETURN NUMBER IS
  nn_  number;
BEGIN
  select min(num)
  into   nn_
  from   conductor
  where  num not in (select id FROM applist where id is not null);
  RETURN nn_;
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/applistnextid.sql =========*** End 
 PROMPT ===================================================================================== 
 