
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/extract_common_branch.sql =========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.EXTRACT_COMMON_BRANCH (p_branch_a branch.branch%type, p_branch_b branch.branch%type)
return branch.branch%type is
    l_common_branch   branch.branch%type;
    l_length_a        integer;
    l_length_b        integer;
    i                 integer;
begin
    l_common_branch := '';
    l_length_a := length(p_branch_a);
    l_length_b := length(p_branch_b);
    i := 1;
    while i<=l_length_a and i<=l_length_b and substr(p_branch_a,i,1)=substr(p_branch_b,i,1) loop
        l_common_branch := l_common_branch || substr(p_branch_a,i,1);
        i := i + 1;
    end loop;
    return l_common_branch;
end extract_common_branch;
 
/
 show err;
 
PROMPT *** Create  grants  EXTRACT_COMMON_BRANCH ***
grant EXECUTE                                                                on EXTRACT_COMMON_BRANCH to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/extract_common_branch.sql =========
 PROMPT ===================================================================================== 
 