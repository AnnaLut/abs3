
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/branch_usr.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BRANCH_USR is

  -- global consts
  G_HEADER_VERSION constant varchar2(64)  := 'version 2.02 19/02/2009';


  -- ����� �������� ���������
  VALUE_FORCE    constant number(1) := 1;   -- ���������� NULL ���� ��������� ���
  VALUE_NOFORCE  constant number(1) := 0;   -- ���������� ������ ���� ��������� ���

  ----
  -- header_version - ���������� ������ ��������� ������
  --
  function header_version return varchar2;

  ----
  -- body_version - ���������� ������ ���� ������
  --
  function body_version return varchar2;

-- ������������� ���������� ������
procedure param;

-- ���������� �������� staff.branch
procedure set_branch(p_branch varchar2);

-- ������� �������� staff.branch
function get_branch return varchar2;

-- ������� ������������ branch.name
function get_branch_name return varchar2;

-- ������� �������� ��������� ��� ���������
-- @param tag - ���(���) ���������
function get_branch_param(p_tag in varchar2) return varchar2;

--
-- ������� �������� ��������� ��� ���������
-- @param tag   - ���(���) ���������
--        force - ���������� NULL ��� ����������
--
function get_branch_param2(
             p_tag   in  varchar2,
             p_force in  number default VALUE_FORCE ) return varchar2;


-- ������� �������� ��������� ��� ��������� ����� nls(kv)
-- @param p_nls - ����� �������� �����
-- @param p_kv - ��� ������
-- @param p_tag - ���(���) ���������
function get_branch_param_acc(
    p_nls in accounts.nls%type,
    p_kv  in accounts.kv%type,
    p_tag in branch_parameters.tag%type) return branch_parameters.val%type;

/**************************************************************
* ������� ��� ������������ ������������� � ������� TOBOPACK
***************************************************************/

-- ���������� �������� TOBO
procedure SetTOBO(tobo_value varchar2);
-- ������� �������� TOBO
function GetTOBO return varchar2;
-- ������� ������������ TOBO
function GetTOBOName return varchar2;
-- ������� �������� ��������� ��� TOBO
function GetTOBOParam(p_tag in varchar2) return varchar2;
-- ������� �������� CASH
function GetToboCASH return varchar2;
-- ������� �������� CASH7
function GetToboCASH7 return varchar2;
-- ������� �������� CHEQ
function GetToboCHEQ return varchar2;
-- ������� �������� CHEQ7
function GetToboCHEQ7 return varchar2;
-- ������� �������� VP
function GetToboVP return varchar2;

-- ������� �������� ��������� ��� ��������� ����� nls(kv)
-- @param p_nls - ����� �������� �����
-- @param p_kv - ��� ������
-- @param p_tag - ���(���) ���������
function GetTOBOParamAcc(
    p_nls in accounts.nls%type,
    p_kv  in accounts.kv%type,
    p_tag in branch_parameters.tag%type) return branch_parameters.val%type;

end branch_usr;
/
CREATE OR REPLACE PACKAGE BODY BARS.BRANCH_USR as

  -- global consts
  G_BODY_VERSION constant varchar2(64)  := 'version 2.02 19/02/2009';


  MODCODE        constant varchar2(3) := 'SVC';

  ----
  -- header_version - ���������� ������ ��������� ������
  --
  function header_version return varchar2 is
  begin
    return 'Package header BRANCH_USR '||G_HEADER_VERSION;
  end header_version;

  ----
  -- body_version - ���������� ������ ���� ������
  --
  function body_version return varchar2 is
  begin
    return 'Package body BRANCH_USR '||G_BODY_VERSION;
  end body_version;

-- ������������� ���������� ������
procedure param is
begin
  null;
end;

-- ���������� �������� staff.branch
procedure set_branch(p_branch varchar2) is
begin
  null;
end;

-- ������� �������� staff.branch
function get_branch return varchar2 is
begin
  return sys_context('bars_context', 'user_branch');
end;

-- ������� ������������ branch.name
function get_branch_name return varchar2 is
  v_name branch.name%type;
begin
  select name into v_name from branch
  where branch=sys_context('bars_context', 'user_branch');
  return v_name;
end;



function get_branch_param2(
             p_tag   in  varchar2,
             p_force in  number default VALUE_FORCE ) return varchar2
is
l_value   branch_parameters.val%type;
l_branch  branch.branch%type := sys_context('bars_context', 'user_branch');
begin
    begin
        select val into l_value
          from branch_parameters
         where tag    = p_tag
           and branch = l_branch;
    exception
        when NO_DATA_FOUND then
            if (p_force = VALUE_FORCE) then l_value := null;
            else bars_error.raise_nerror(MODCODE, 'BRANCHPARAM_NOTEXISTS', p_tag, l_branch);
            end if;
    end;
    return l_value;

end get_branch_param2;


-- ������� �������� ��������� ��� ���������
-- @param tag - ���(���) ���������
function get_branch_param(p_tag in varchar2) return varchar2 is
  v_val  branch_parameters.val%type;
begin
  return get_branch_param2(p_tag, VALUE_FORCE);
end get_branch_param;


-- ������� �������� ��������� ��� ��������� ����� nls(kv)
-- @param p_nls - ����� �������� �����
-- @param p_kv - ��� ������
-- @param p_tag - ���(���) ���������
function get_branch_param_acc(
    p_nls in accounts.nls%type,
    p_kv  in accounts.kv%type,
    p_tag in branch_parameters.tag%type) return branch_parameters.val%type is
    l_branch    accounts.branch%type;
    l_val       branch_parameters.val%type;
begin
    --
    -- ���������� �������� ��������� �� ���� ��� ������ ����� nls(kv)
    --
    begin
        select branch into l_branch from accounts where nls=p_nls and kv=p_kv;
    exception when no_data_found then
        raise_application_error(-20000, '���� �� ������: '||p_nls||'('||p_kv||')', true);
    end;
    begin
        l_val := branch_edit.getBranchParams(l_branch, p_tag);
    exception when no_data_found then
        raise_application_error(-20000, '�������� ��������� '''||p_tag||''' �� ������� ��� BRANCH='''||l_branch||'''', true);
    end;
    return l_val;
end get_branch_param_acc;

/**************************************************************
* ������� ��� ������������ ������������� � ������� TOBOPACK
***************************************************************/
-- ���������� �������� TOBO
procedure SetTOBO(tobo_value varchar2) is
begin
  set_branch(tobo_value);
end;
-- ������� �������� TOBO
function GetTOBO return varchar2 is
begin
  return get_branch;
end;
-- ������� ������������ TOBO
function GetTOBOName return varchar2 is
begin
  return get_branch_name;
end;
-- ������� �������� ��������� ��� TOBO
function GetTOBOParam(p_tag in varchar2) return varchar2 is
begin
  return get_branch_param(p_tag);
end GetTOBOParam;
-- ������� �������� CASH
function GetToboCASH return varchar2 is
begin
  return get_branch_param('CASH');
end GetToboCASH;
-- ������� �������� CASH7
function GetToboCASH7 return varchar2 is
begin
	return get_branch_param('CASH7');
end GetToboCASH7;
-- ������� �������� CHEQ
function GetToboCHEQ return varchar2 is
begin
	return get_branch_param('CHEQ');
end GetToboCHEQ;
-- ������� �������� CHEQ7
function GetToboCHEQ7 return varchar2 is
begin
  return get_branch_param('CHEQ7');
end GetToboCHEQ7;
-- ������� �������� VP
function GetToboVP return varchar2 is
begin
  return get_branch_param('VP');
end GetToboVP;

-- ������� �������� ��������� ��� ��������� ����� nls(kv)
-- @param p_nls - ����� �������� �����
-- @param p_kv - ��� ������
-- @param p_tag - ���(���) ���������
function GetTOBOParamAcc(
    p_nls in accounts.nls%type,
    p_kv  in accounts.kv%type,
    p_tag in branch_parameters.tag%type) return branch_parameters.val%type is
begin
    return get_branch_param_acc(p_nls, p_kv, p_tag);
end GetTOBOParamAcc;

end branch_usr;
/
 show err;
 
PROMPT *** Create  grants  BRANCH_USR ***
grant EXECUTE                                                                on BRANCH_USR      to ABS_ADMIN;
grant EXECUTE                                                                on BRANCH_USR      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BRANCH_USR      to BASIC_INFO;
grant EXECUTE                                                                on BRANCH_USR      to PYOD001;
grant EXECUTE                                                                on BRANCH_USR      to START1;
grant EXECUTE                                                                on BRANCH_USR      to WEB_BALANS;
grant EXECUTE                                                                on BRANCH_USR      to WR_ALL_RIGHTS;
grant EXECUTE                                                                on BRANCH_USR      to WR_CREDIT;
grant EXECUTE                                                                on BRANCH_USR      to WR_CUSTLIST;
grant EXECUTE                                                                on BRANCH_USR      to WR_CUSTREG;
grant EXECUTE                                                                on BRANCH_USR      to WR_DEPOSIT_U;
grant EXECUTE                                                                on BRANCH_USR      to WR_DOC_INPUT;
grant EXECUTE                                                                on BRANCH_USR      to WR_KP;
grant EXECUTE                                                                on BRANCH_USR      to WR_RATES;
grant EXECUTE                                                                on BRANCH_USR      to WR_VIEWACC;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/branch_usr.sql =========*** End *** 
 PROMPT ===================================================================================== 
 