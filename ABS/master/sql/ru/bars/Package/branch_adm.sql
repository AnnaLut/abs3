
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/branch_adm.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BRANCH_ADM is
/*
  ������� ���������:

   17/03/2006 ����   1. ������ ����� ����������� ����������� � ����.
                        ������� ������ - TOBO_ADM
   21.10.2005 SERG   ��������
*/

-- ������� ��� ��������� ��� ������������
function get_user_branch(p_name in varchar2) return varchar2;
-- ���������� ��� ��������� ��� ������������
procedure set_user_branch(p_name in varchar2, p_branch varchar2);

/**************************************************************
* ������� ��� ������������ ������������� � ������� TOBO_ADM
***************************************************************/

-- ������� ��� ���� ��� ������������
function GetUserTOBO(uname in varchar2) return varchar2;
-- ���������� ��� ���� ��� ������������
procedure SetUserTOBO(uname in varchar2, tobo_value varchar2);

end branch_adm;
/
CREATE OR REPLACE PACKAGE BODY BARS.BRANCH_ADM is
/*
   29.03.2006 ����   2. ����� �� ������ ������ � STAFF_BRANCH - ���
                        ������������� � �������������� ��� �� �����.
   17/03/2006 ����   1. ������ ����� ����������� ����������� � ����.
                        ������� ������ - TOBO_ADM
   21.10.2005 SERG   ��������
*/

-- ������� ��� ��������� ��� ������������
function get_user_branch(p_name in varchar2) return varchar2 is
  v_branch staff.branch%type;
begin
  select branch into v_branch from staff where logname=p_name;
  return v_branch;
end;
-- ���������� ��� ��������� ��� ������������
procedure set_user_branch(p_name in varchar2, p_branch varchar2) is
begin
  /*begin -- ��������� � ������ ����������� ��������� ��� ������������
    insert into staff_branch(id,branch)
    select id, branch from staff where logname=p_name;
  exception when dup_val_on_index then
    null;
  end;*/
  -- ����������� ��� ���� ������������
  update staff set branch=p_branch where logname=p_name;
end;

-- ������� ��� ���� ��� ������������
function GetUserTOBO(uname in varchar2) return varchar2 is
begin
  return get_user_branch(uname);
end;

-- ���������� ��� ���� ��� ������������
procedure SetUserTOBO(uname in varchar2, tobo_value varchar2) is
begin
  set_user_branch(uname, tobo_value);
end;

end branch_adm;
/
 show err;
 
PROMPT *** Create  grants  BRANCH_ADM ***
grant EXECUTE                                                                on BRANCH_ADM      to ABS_ADMIN;
grant EXECUTE                                                                on BRANCH_ADM      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BRANCH_ADM      to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/branch_adm.sql =========*** End *** 
 PROMPT ===================================================================================== 
 