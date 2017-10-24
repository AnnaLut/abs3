
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/check_acccapture.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CHECK_ACCCAPTURE 
        (
        p_branch varchar2,
        p_acc number)
return smallint
is
   l_chk  smallint;
begin

   select min(column_value) into l_chk
   from v_klbx_branch v, table(sec.getAgrp(p_acc)) t
   where
      -- LOCAL группа синхронгизатора ТВБВ
      ( p_branch = v.branch                                and   t.column_value = 39) or
      -- PARENT группа синхронгизатора ТВБВ
      ( p_branch = substr(v.branch,1, length(v.branch)-7)  and   t.column_value = 38) or
      -- GLOBAL
      (t.column_value = 37 );
   return nvl(l_chk,0);

end;
/
 show err;
 
PROMPT *** Create  grants  CHECK_ACCCAPTURE ***
grant EXECUTE                                                                on CHECK_ACCCAPTURE to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/check_acccapture.sql =========*** E
 PROMPT ===================================================================================== 
 