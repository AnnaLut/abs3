
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_policy.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_POLICY as
/*
  BARS_POLICY - ����� ���������� �������� ������� ��� ������������� ���� � DML ���������
                � �������� �������� � ����� ����� ��������� �������� � ������� 3 �������
                ����������� ������������� �����
*/

g_header_version  constant varchar2(64)  := 'version 2.14 12/09/2012';

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

----
-- set_operation function
--
function set_operation(p_operation varchar2) return number;

----
-- noop function
--
function noop(p_label varchar2) return number;

--
--  ���������� �������� ������� � ����� � �������� ������ �� ���� branch
--
function set_root_branch_policy(p_schema in varchar2, p_name in varchar2)
return varchar2;

--
--  ���������� �������� ���������� ������� �� ����� valid_after � valid_before
--
function set_valid_policy(p_schema in varchar2, p_name in varchar2)
return varchar2;

--
--  ������������� ��������, ������������� ������ ����������� �������� ������
--  �������������� ���
--
function set_root_error_policy(p_schema in varchar2, p_name in varchar2)
return varchar2;

--
--  �-��� ����������� ������: ������������ ��� ��������� ����������� �������� ������ ������� "BARS.TABLE_NAME"
--
function raise_root_error(p_schema in varchar2, p_name in varchar2)
return number;

----
-- current_operation - ���������� ������� ��������: S,I,U,D
--
function current_operation return varchar2;

--
--  ���������� �������� ������� �� ���� RFC (Root/Filial Code)
--
function set_rfc_policy(p_schema in varchar2, p_name in varchar2)
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

g_body_version  constant varchar2(64)  := 'version 2.12 12/09/2012';

g_awk_body_defs constant varchar2(512) := ''

  ||'����� �����'||chr(10)
;

--
-- ���������� ����������
--
G_CURRENT_SELECT    varchar2(4000);
G_CURRENT_UPDATE    varchar2(4000);
G_CURRENT_INSERT    varchar2(4000);
G_CURRENT_DELETE    varchar2(4000);

G_CURRENT_OPERATION     varchar2(1); -- S,I,U,D

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

--
--  ���������� �������� ���������� ������� �� ����� valid_after � valid_before
--
function set_valid_policy(p_schema in varchar2, p_name in varchar2)
return varchar2
is
begin
    return 'sysdate between valid_after and valid_before';
end set_valid_policy;

----
-- set_operation function
--
function set_operation(p_operation varchar2) return number
is
begin
  if logger.trace_enabled
  then
      logger.trace('set_operation: %s', p_operation);
  end if;
  --
  G_CURRENT_OPERATION := p_operation;
  --
  return 1;
end set_operation;

----
-- noop function
--
function noop(p_label varchar2) return number
is
begin
  logger.trace('noop: %s, %s ',p_label, sys_context('USERENV','CURRENT_SQL'));
  return 1;
end noop;

--
--  ���������� �������� ������� � ����� � �������� ������ �� ���� branch
--
function set_root_branch_policy(p_schema in varchar2, p_name in varchar2)
return varchar2
is
begin
    return 'plc.set_operation(''S'')=1 and sys_context(''bars_context'',''user_branch'') like branch||''%''';
end set_root_branch_policy;

----
--  ������������� ��������, ������������� ������ ����������� �������� ������
--  �������������� ���
--
function set_root_error_policy(p_schema in varchar2, p_name in varchar2)
return varchar2 is
begin
  return 'plc.set_operation(''U'')=1 and '||chr(10)
       ||'case '||chr(10)
       ||'when plc.current_operation=''S'' then 1 '||chr(10)
       ||'when branch like sys_context(''bars_context'',''user_branch_mask'') then 1 '||chr(10)
       ||'when branch = ''/'' and sys_context(''bars_context'',''user_branch'') <> ''/'' then '||chr(10)
       ||'     bars_policy.raise_root_error('''||p_schema||''', '''||p_name||''') '||chr(10)
       ||'else 0'||chr(10)
       ||'end = 1'
       ;
end;

--
--  �-��� ����������� ������: ������������ ��� ��������� ����������� �������� ������ ������� "BARS.TABLE_NAME"
--
function raise_root_error(p_schema in varchar2, p_name in varchar2)
return number is
begin
  bars_error.raise_nerror('BRS', 'ROOT_MODIFICATION_DISABLED', p_schema||'.'||p_name);
  return 0;
end raise_root_error;

----
-- current_operation - ���������� ������� ��������: S,I,U,D
--
function current_operation return varchar2
is
begin
    if logger.trace_enabled
    then
        logger.trace('current_operation=%s', G_CURRENT_OPERATION);
    end if;
    --
    return G_CURRENT_OPERATION;
    --
end current_operation;

--
--  ���������� �������� ������� �� ���� RFC (Root/Filial Code)
--
function set_rfc_policy(p_schema in varchar2, p_name in varchar2)
return varchar2
is
begin
  --
  return 'rfc = sys_context(''bars_context'',''rfc'')';
  --
end set_rfc_policy;


end bars_policy;
/
 show err;
 
PROMPT *** Create  grants  BARS_POLICY ***
grant EXECUTE                                                                on BARS_POLICY     to ABS_ADMIN;
grant EXECUTE                                                                on BARS_POLICY     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_POLICY     to UPLD;
grant EXECUTE                                                                on BARS_POLICY     to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_policy.sql =========*** End ***
 PROMPT ===================================================================================== 
 