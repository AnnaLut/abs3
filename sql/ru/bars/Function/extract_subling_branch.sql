
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/extract_subling_branch.sql ========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.EXTRACT_SUBLING_BRANCH (p_branch_parent in branch.branch%type, p_branch_child in branch.branch%type)
        return branch.branch%type is
        begin
            return substr(p_branch_child, 1, instr(p_branch_child, '/', length(p_branch_parent)+1));
        end extract_subling_branch;
/
 show err;
 
PROMPT *** Create  grants  EXTRACT_SUBLING_BRANCH ***
grant EXECUTE                                                                on EXTRACT_SUBLING_BRANCH to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/extract_subling_branch.sql ========
 PROMPT ===================================================================================== 
 