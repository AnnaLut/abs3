
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/package/bars_sync.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARSAQ.BARS_SYNC as
--
--  BARS_SYNC - ����� ��� �������������� ������ ��� � ��. �����
--

g_package_name    constant varchar2(30)  := 'BARS_SYNC';

g_header_version  constant varchar2(64)  := 'version 1.03 25/11/2009';

g_awk_header_defs constant varchar2(512) := ''
	||'KF - ����� � ����� ''kf''' || chr(10)
  ;

  --
  -- global variables
  --
  g_mosdate         date;   -- "mark_opldok"_start_date (���� ������ ������� ������� � OPLDOK)


--
-- header_version - ���������� ������ ��������� ������
--
function header_version return varchar2;

--
-- body_version - ���������� ������ ���� ������
--
function body_version return varchar2;

--
-- get_bankdate_g - ���������� ���� ����������� ����������� ���
--
-- ���������� ��� ������� ���������� ����������� ���,
-- ���� ���������� ��� � ����������� ����� ����������,
-- ������������ ������� Internet Banking �������� ������ � ���������� ���������� ���.
function get_bankdate_g return date;

--
-- is_bankdate_open - ���������� 1/0 - ������/������ ������� ���������� ���������� ����
--
function is_bankdate_open return integer;

--
-- get_bank_mfo - ���������� ��� �����(MFO)
--
function get_bank_mfo return varchar2;

--
-- check_ident_code - ��������� ������������� �������� ������������������ ����
--
-- ���� ��������(�� ������ ������):
-- "99999", "000000000" - ��� ����������
-- 8-������� ��������   - ��� ������(��� �������� ������������ �������)
-- 10-������� ��������  - ��� �������(��� �������� ������������ �������)
--
-- @return 0/1
function check_ident_code(p_ident_code in varchar2) return integer;

--
-- calc_ident_code - ������������� ����������������� ���
--
-- �-��� ������������ ��� �������� ������������ ������� 8-������� �����. �����(��� �����)
-- @return ��� 8-������� ����� ���������� ��� � ����������� ����������� ��������(������� ����),
--         � ��������� ������� ���������� �������� ��������
function calc_ident_code(p_ident_code in varchar2) return varchar2;

--
-- calc_account_ctrl_dig - ��������� ����������� ������ � ������� ������ �������� �����
--
-- @p_mfo   - ��� �����(MFO �� ����������� BANKS)
-- @p_nls   - ����� �������� �����
--            ��������� �����: bbbbKnnnnnnnnn,
--            ��� bbbb - ����� ����������� �����, K - ����������� ������, nnnnnnnnn - ������������� ����� �����
-- @return ����� �������� ����� � ����������� ����������� ��������
function calc_account_ctrl_dig(p_mfo in varchar2, p_nls in varchar2) return varchar2;

--
-- user_id - ���������� ID �������� ������������ ���
--
function user_id return integer;

  ----
  -- kf - ���������� ������� ��� ������������ � ��������� �� �������
  --
  function kf return varchar2;

  ----
  -- subst_mfo - �������������� ��������� ���
  --
  procedure subst_mfo(p_kf in varchar2);

  ----
  -- set_context - ������������ � ������������� ��������
  --
  procedure set_context;

  procedure init;

  ----
  -- set_tag - �������� ��� dbms_streams.set_tag()
  --
  procedure set_tag(tag in raw default null);

  ----
  -- get_tag - �������� ��� dbms_streams.get_tag()
  --
  function get_tag return raw;

end bars_sync;
/
CREATE OR REPLACE PACKAGE BODY BARSAQ.BARS_SYNC is
--
--  BARS_SYNC - ����� ��� �������������� ������ ��� � ��. �����
--

g_body_version  constant varchar2(64)  := 'version 1.06 23/06/2014';

g_awk_body_defs constant varchar2(512) := ''
	||'KF - ����� � ����� ''kf''' || chr(10)
  ;


--
-- header_version - ���������� ������ ��������� ������
--
function header_version return varchar2 is
begin
  return 'Package header '||g_package_name||' '||g_header_version||'.'||chr(10)
	   ||'AWK definition: '||chr(10)
	   ||g_awk_header_defs;
end header_version;

--
-- body_version - ���������� ������ ���� ������
--
function body_version return varchar2 is
begin
  return 'Package body '||g_package_name||' '||g_body_version||'.'||chr(10)
	   ||'AWK definition: '||chr(10)
	   ||g_awk_body_defs;
end body_version;

--
-- get_bankdate_g - ���������� ���� ����������� ����������� ���
--
-- ���������� ��� ������� ���������� ����������� ���,
-- ���� ���������� ��� � ����������� ����� ����������,
-- ������������ ������� Internet Banking �������� ������ � ���������� ���������� ���.
function get_bankdate_g return date is
begin
  return bars.bankdate_g;
end get_bankdate_g;

--
-- is_bankdate_open - ���������� 1/0 - ������/������ ������� ���������� ���������� ����
--
function is_bankdate_open return integer is
  l_value  integer;
begin
  select to_number(val) into l_value from bars.params where par='RRPDAY';
  return l_value;
end is_bankdate_open;

--
-- get_bank_mfo - ���������� ��� �����(MFO)
--
function get_bank_mfo return varchar2 is
begin
  return bars.gl.kf;
end get_bank_mfo;

--
-- check_ident_code - ��������� ������������� �������� ������������������ ����
--
-- ���� ��������(�� ������ ������):
-- "99999", "000000000" - ��� ����������
-- 8-������� ��������   - ��� ������(��� �������� ������������ �������)
-- 9-������� ��������   - ��� ���������� �������
-- 10-������� ��������  - ��� �������(��� �������� ������������ �������)
--
-- @return 0/1
function check_ident_code(p_ident_code in varchar2) return integer is
begin
  if 1=bars.bars_regexp.match('(^99999$)|(^\d{8,10}$)',p_ident_code)     -- 8,9,10-������� �������� ��� ��� '99999'
  then
    return 1;
  else
    return 0;
  end if;
end check_ident_code;

--
-- calc_ident_code - ������������� ����������������� ���
--
-- �-��� ������������ ��� �������� ������������ ������� 8-������� �����. �����(��� �����)
-- @return ��� 8-������� ����� ���������� ��� � ����������� ����������� ��������(������� ����),
--         � ��������� ������� ���������� �������� ��������
function calc_ident_code(p_ident_code in varchar2) return varchar2 is
begin
  return bars.v_okpo(p_ident_code);
end calc_ident_code;

--
-- calc_account_ctrl_dig - ��������� ����������� ������ � ������� ������ �������� �����
--
-- @p_mfo   - ��� �����(MFO �� ����������� BANKS)
-- @p_nls   - ����� �������� �����
--            ��������� �����: bbbbKnnnnnnnnn,
--            ��� bbbb - ����� ����������� �����, K - ����������� ������, nnnnnnnnn - ������������� ����� �����
-- @return ����� �������� ����� � ����������� ����������� ��������
function calc_account_ctrl_dig(p_mfo in varchar2, p_nls in varchar2) return varchar2 is
begin
  return bars.vkrzn(substr(p_mfo,1,5), p_nls);
end calc_account_ctrl_dig;

--
-- user_id - ���������� ID �������� ������������ ���
--
function user_id return integer is
begin
  return bars.gl.aUID;
end user_id;

  ----
  -- kf - ���������� ������� ��� ������������ � ��������� �� �������
  --
  function kf return varchar2 is
    l_kf	varchar2(6);
  begin
    l_kf := bars.gl.kf();
    if l_kf is null then
       raise_application_error(-20000, 'Package GL not initialized', true);
    end if;
    return l_kf;
  end kf;

  ----
  -- subst_mfo - �������������� ��������� ���
  --
  procedure subst_mfo(p_kf in varchar2) is
  begin
	bars.bc.subst_mfo(p_kf);
  end subst_mfo;

  ----
  -- set_context - ������������ � ������������� ��������
  --
  procedure set_context is
  begin
	bars.bc.set_context;
  end set_context;

  ----
  -- init - ������������� ������
  --
  procedure init is
  begin
      g_mosdate := trunc(sysdate - 10); -- ����� �� ��������� 10 ���� ������
  end init;

  ----
  -- set_tag - �������� ��� dbms_streams.set_tag()
  --
  procedure set_tag(tag in raw default null) is
  begin
    dbms_streams.set_tag(tag);
  end set_tag;

  ----
  -- get_tag - �������� ��� dbms_streams.get_tag()
  --
  function get_tag return raw is
    l_tag raw(2000);
  begin
    -- workaround for Bug 7007268: SERVEROUTPUT ON + DBMS_STREAMS.GET_TAG + DBMS_OUTPUT.PUT_LINE THROWS ORA-06502
    -- ������ � ������� SQL, � �� ����� ������������ �������� pl/sql-������� � ����������
    select dbms_streams.get_tag() into l_tag from dual;
    return l_tag;
  end get_tag;


begin
  init;
end bars_sync;
/
 show err;
 
PROMPT *** Create  grants  BARS_SYNC ***
grant EXECUTE                                                                on BARS_SYNC       to REFSYNC_USR;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARSAQ/package/bars_sync.sql =========*** End ***
 PROMPT ===================================================================================== 
 