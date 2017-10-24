CREATE OR REPLACE FUNCTION BARS.GetNewBranch(p_mfo varchar2, p_branch varchar2) RETURN varchar2
IS
BEGIN
  if p_branch is null then
    return null;
  else
   
    return p_branch;
  end if;
END;
/