
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_user_branch_mask.sql =========***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_USER_BRANCH_MASK 
return varchar2
deterministic
/*
   user_mfo like to MMFO
   ��������� CRNV branch ���������� �� ��������� MMFO branch
   �������� MMFO ��������� �� ������ ������
   /300465/322669/% = > /322669/%
*/
as
begin
 return substr(sys_context('BARS_CONTEXT', 'USER_BRANCH_MASK'),8);
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_user_branch_mask.sql =========***
 PROMPT ===================================================================================== 
 