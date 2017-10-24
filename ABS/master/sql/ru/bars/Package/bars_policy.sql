
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_policy.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_POLICY as
/*
  BARS_POLICY - ����� ���������� �������� ������� ��� ������������� ���� � DML ���������
                � �������� �������� � ����� ����� ��������� �������� � ������� 3 �������
                ����������� ������������� �����
*/

g_header_version  constant varchar2(64)  := 'version 2.8 10/12/2008';

g_awk_header_defs constant varchar2(512) := ''

  ||'����� �����'||chr(10)
;

--
-- header_version - ���������� ������ ��������� ������
--
function header_version return varchar2;

--
-- body_version - ���������� ������ ���� ������
--
function body_version return varchar2;

--
--  ���������� �������� ������� �� ���� ������ �������
--
function set_group_policy(p_schema in varchar2, p_name in varchar2)
return varchar2;

--
--  ���������� �������� ������� � ������������� (������������� + �����������
--  �������������)
--
function set_branch_policy(p_schema in varchar2, p_name in varchar2)
return varchar2;

--
--  ���������� �������� ������� � ������������� (������ ���� �������������)
--
function set_equal_branch_policy(p_schema in varchar2, p_name in varchar2)
return varchar2;

--
--  ���������� �������� ���������� �������� (�� ���, �� ���� KF)
--
function set_mfo_policy(p_schema in varchar2, p_name in varchar2)
return varchar2;

--
--  ���������� �������� ���������� �������� �� ���� �������(���)
--
function set_filial_policy(p_schema in varchar2, p_name in varchar2)
return varchar2;

--
--  ���������� �������� �� ������� 2-� ������������� � ����� ��������
--  (������������� + ����������� �������������)
--
function set_dual_branch_policy(p_schema in varchar2, p_name in varchar2)
return varchar2;

--
--  ���������� �������� ���������� �������
--
function set_no_access_policy(p_schema in varchar2, p_name in varchar2)
return varchar2;

--
--  ������������� ��������, ������������� ������ �������
--
function set_error_policy(p_schema in varchar2, p_name in varchar2)
return varchar2;

--
--  �-��� ����������� ������: ����������� ������� "BARS.TABLE_NAME" ��������� � ������ ������� "FILIAL/WHOLE"
--
function raise_error(p_schema in varchar2, p_name in varchar2)
return number;

--
--  ���������� �������� ������� ������ ��������� �������������
--
function set_center_policy(p_schema in varchar2, p_name in varchar2)
return varchar2;

--
--  ���������� �������� ������� ������ � ����� ����������� �������������
--
function set_subling_policy(p_schema in varchar2, p_name in varchar2)
return varchar2;

--
--  ���������� �������� ������� ������ � ����� ��������� ������������� � ��� ��������
--  �������������
--
function set_parent_policy(p_schema in varchar2, p_name in varchar2)
return varchar2;

--
--  ���������� �������� �� ��������� ������� (���������� ��������)
--
function set_deleted_policy(p_schema in varchar2, p_name in varchar2)
return varchar2;

--
--  ���������� �������� ������� � ������ ������� �� ���� branch
--
function set_region_branch_policy(p_schema in varchar2, p_name in varchar2)
return varchar2;

--
--  ���������� �������� ������� � ������ ������� �� ���� kf
--
function set_region_mfo_policy(p_schema in varchar2, p_name in varchar2)
return varchar2;

end bars_policy;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_POLICY 
is
/*
  BARS_POLICY - ����� ���������� �������� ������� ��� ������������� ���� � DML ���������
                � �������� �������� � ����� ����� ��������� �������� � ������� 3 �������
                ����������� ������������� �����
*/

g_body_version  constant varchar2(64)  := 'version 2.9 03/02/2009';

g_awk_body_defs constant varchar2(512) := ''

  ||'����� �����'||chr(10)
;


--
-- header_version - ���������� ������ ��������� ������
--
function header_version return varchar2 is
begin
  return 'Package header BARS_POLICY '||g_header_version||'.'||chr(10)
	   ||'AWK definition: '||chr(10)
	   ||g_awk_header_defs;
end header_version;

--
-- body_version - ���������� ������ ���� ������
--
function body_version return varchar2 is
begin
  return 'Package body BARS_POLICY '||g_body_version||'.'||chr(10)
	   ||'AWK definition: '||chr(10)
	   ||g_awk_body_defs;
end body_version;

--
--  ���������� �������� ������� �� ���� ������ �������
--
function set_group_policy(p_schema in varchar2, p_name in varchar2)
return varchar2 is
begin
  return 'policy_group = sys_context(''bars_context'',''policy_group'')';
end;


--
--  ���������� �������� ������� �� ������������� (������������� + �����������
--  �������������)
--
function set_branch_policy(p_schema in varchar2, p_name in varchar2)
return varchar2 is
begin
  return 'branch like sys_context(''bars_context'',''user_branch_mask'')';
end;

--
--  ���������� �������� ������� � ������������� (������ ���� �������������)
--
function set_equal_branch_policy(p_schema in varchar2, p_name in varchar2)
return varchar2 is
begin
  return 'branch = sys_context(''bars_context'',''user_branch'')';
end;


--
--  ���������� �������� ���������� �������� �� ���� �������(���)
--
function set_filial_policy(p_schema in varchar2, p_name in varchar2)
return varchar2 is
begin
  return 'branch like sys_context(''bars_context'',''user_mfo_mask'')';
end;

--
--  ���������� �������� ���������� �������� (�� ���, �� ���� KF)
--
function set_mfo_policy(p_schema in varchar2, p_name in varchar2)
return varchar2 is
begin
  return 'kf = sys_context(''bars_context'',''user_mfo'')';
end;

--
--  ���������� �������� �� ������� 2-� ������������� � ����� ��������
--  (������������� + ����������� �������������)
--
function set_dual_branch_policy(p_schema in varchar2, p_name in varchar2)
return varchar2 is
begin
  return 'branch_a like sys_context(''bars_context'',''user_branch_mask'')'
   ||' or branch_b like sys_context(''bars_context'',''user_branch_mask'')';
end;

--
--  ���������� �������� ���������� �������
--
function set_no_access_policy(p_schema in varchar2, p_name in varchar2)
return varchar2 is
begin
  return '1=0';
end;

--
--  ������������� ��������, ������������� ������ �������
--
function set_error_policy(p_schema in varchar2, p_name in varchar2)
return varchar2 is
begin
  return 'bars_policy.raise_error('''||p_schema||''', '''||p_name||''')=1';
end;

--
--  �-��� ����������� ������: ����������� ������� "BARS.TABLE_NAME" ��������� � ������ ������� "FILIAL/WHOLE"
--
function raise_error(p_schema in varchar2, p_name in varchar2)
return number is
begin
  bars_error.raise_nerror('BRS', 'MODIFICATION_DISABLED', p_schema||'.'||p_name);
  return 0;
end raise_error;

--
--  ���������� �������� ������� ������ ��������� �������������
--
function set_center_policy(p_schema in varchar2, p_name in varchar2)
return varchar2 is
begin
  return 'sys_context(''bars_context'',''params_mfo'')=sys_context(''bars_context'',''glb_mfo'')';
end;

--
--  ���������� �������� ������� ������ � ����� ����������� �������������
--
function set_subling_policy(p_schema in varchar2, p_name in varchar2)
return varchar2 is
begin
  return 'branch <> sys_context(''bars_context'',''user_branch'') AND branch like sys_context(''bars_context'',''user_branch_mask'')';
end;

--
--  ���������� �������� ������� ������ � ����� ��������� ������������� � ��� ��������
--  �������������
--
function set_parent_policy(p_schema in varchar2, p_name in varchar2)
return varchar2 is
begin
  return 'sys_context(''bars_context'',''user_branch'') like branch || ''%''';
end;
--
--  ���������� �������� �� ��������� ������� (���������� ��������)
--
function set_deleted_policy(p_schema in varchar2, p_name in varchar2) return varchar2
is
begin
    return 'deleted is null';
end set_deleted_policy;

--
--  ���������� �������� ������� � ������ ������� �� ���� branch
--
function set_region_branch_policy(p_schema in varchar2, p_name in varchar2)
return varchar2 is
begin
    return 'substr(branch,2,6) in ('
                ||' select sys_context(''bars_context'',''user_mfo'') from dual'
                ||' union all'
                ||' select mfo from banks where mfop=sys_context(''bars_context'',''user_mfo'')'
                ||' )';
end;

--
--  ���������� �������� ������� � ������ ������� �� ���� kf
--
function set_region_mfo_policy(p_schema in varchar2, p_name in varchar2)
return varchar2 is
begin
    return 'kf in ('
                ||' select sys_context(''bars_context'',''user_mfo'') from dual'
                ||' union all'
                ||' select mfo from banks where mfop=sys_context(''bars_context'',''user_mfo'')'
                ||' )';
end;

end bars_policy;
/
 show err;
 
PROMPT *** Create  grants  BARS_POLICY ***
grant EXECUTE                                                                on BARS_POLICY     to ABS_ADMIN;
grant EXECUTE                                                                on BARS_POLICY     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_POLICY     to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_policy.sql =========*** End ***
 PROMPT ===================================================================================== 
 