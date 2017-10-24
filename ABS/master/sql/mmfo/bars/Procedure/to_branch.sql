

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/TO_BRANCH.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure TO_BRANCH ***

  CREATE OR REPLACE PROCEDURE BARS.TO_BRANCH 
  (p_branch IN varchar2,
   p_name   IN varchar2,
   p_descr  IN varchar2)
is
begin
  begin
    update branch
    set    name       =p_name ,
           description=p_descr
    where  branch     =p_branch;
    if SQL%ROWCOUNT=0 then
      insert into branch (branch,  name,  description)
                  values (p_branch,p_name,p_descr);
    end if;
  end;
  commit;
end to_branch;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/TO_BRANCH.sql =========*** End ***
PROMPT ===================================================================================== 
