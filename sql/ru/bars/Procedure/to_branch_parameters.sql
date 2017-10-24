

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/TO_BRANCH_PARAMETERS.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure TO_BRANCH_PARAMETERS ***

  CREATE OR REPLACE PROCEDURE BARS.TO_BRANCH_PARAMETERS 
  (p_branch IN varchar2,
   p_tag    IN varchar2,
   p_val    IN varchar2)
is
begin
  begin
    insert into branch_parameters   (branch,  tag,  val)
                           values (p_branch,p_tag,p_val);
  exception when others then
    update branch_parameters
    set    val=p_val
    where  tag=p_tag and branch=p_branch;
  end;
  commit;
end to_branch_parameters;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/TO_BRANCH_PARAMETERS.sql =========
PROMPT ===================================================================================== 
