
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/getnewbranch.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GETNEWBRANCH (p_mfo varchar2, p_branch varchar2) RETURN varchar2
IS
BEGIN
  if p_branch is null then
    return null;
  else

    return p_branch;
  end if;
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/getnewbranch.sql =========*** End *
 PROMPT ===================================================================================== 
 