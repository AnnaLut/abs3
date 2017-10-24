
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/FINMON/function/f_pol_finmon_person.sql =========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION FINMON.F_POL_FINMON_PERSON (p_schema   IN varchar2,
                                     p_name     IN varchar2)
   RETURN varchar2
IS
BEGIN
   RETURN '';                                   --'branch_id = get_branch_id';
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/FINMON/function/f_pol_finmon_person.sql =========
 PROMPT ===================================================================================== 
 