
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/package/bars_refsync_usr.sql =========*** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARSAQ.BARS_REFSYNC_USR is

  -- Copyryight : UNITY-BARS
  -- Author     : Oleg
  -- Created    : �������, 13.07.2007 14:56:15
  -- Purpose    : ����� �������� ��� ���������� ������������� ������������

  -- global consts
  G_HEADER_VERSION constant varchar2(64)  := 'version 1.07 27/09/2009';

  -- ��������� ����������� ���������
  GROUP_ALL_TRANSACTIONS       constant pls_integer := bars_refsync.GROUP_ALL_TRANSACTIONS;
  GROUP_SINGLE_TRANSACTION     constant pls_integer := bars_refsync.GROUP_SINGLE_TRANSACTION;

  ----
  -- header_version - ���������� ������ ��������� ������
  --
  function header_version return varchar2;

  ----
  -- body_version - ���������� ������ ���� ������
  --
  function body_version return varchar2;

  ----
  -- get_all_changed_data - �������������� ������ ��� ������������� �� ���� ��������
  -- @p_message_grouping - ������ ����������� ���������
  --    0 - GROUP_ALL_TRANSACTIONS   - ��������� �� ���� �����������
  --    1 - GROUP_SINGLE_TRANSACTION - ��������� �� ����� ����������
  procedure get_all_changed_data(p_message_grouping in number default GROUP_ALL_TRANSACTIONS);


  ------------------------------------------
  -- PROC_OPLDOK_CHANGES
  --
  -- ��ࠡ�⪠ ��������� �� �஢�����
  --
  procedure proc_opldok_changes;


end bars_refsync_usr;
 
/
CREATE OR REPLACE PACKAGE BODY BARSAQ.BARS_REFSYNC_USR is

  -- global consts
  G_BODY_VERSION constant varchar2(64)  := 'version 1.08 27/02/2009';
  G_MODULE_NAME constant varchar2(3) := 'SYN';

  ----
  -- header_version - ���������� ������ ��������� ������
  --
  function header_version return varchar2 is
  begin
    return 'Package header '||G_HEADER_VERSION;
  end header_version;



  ----
  -- body_version - ���������� ������ ���� ������
  --
  function body_version return varchar2 is
  begin
    return 'Package body '||G_BODY_VERSION;
  end body_version;

  ----------------------------------------
  --
  -- get_all_changed_data - �������������� ������ ��� ������������� �� ���� ��������
  -- @p_message_grouping - ������ ����������� ���������
  --    0 - GROUP_ALL_TRANSACTIONS   - ��������� �� ���� �����������
  --    1 - GROUP_SINGLE_TRANSACTION - ��������� �� ����� ����������
  --
  procedure get_all_changed_data(p_message_grouping in number default GROUP_ALL_TRANSACTIONS) is
  begin
    bars_refsync.get_all_changed_data(user, p_message_grouping);
  end get_all_changed_data;


  ------------------------------------------
  -- PROC_OPLDOK_CHANGES
  --
  -- ��ࠡ�⪠ ��������� �� �஢�����
  --
  procedure proc_opldok_changes is
  begin
      bars_refsync.proc_opldok_changes;
  end;


begin
  -- Initialization
  null;
end bars_refsync_usr;
/
 show err;
 
PROMPT *** Create  grants  BARS_REFSYNC_USR ***
grant EXECUTE                                                                on BARS_REFSYNC_USR to BARS;
grant EXECUTE                                                                on BARS_REFSYNC_USR to JBOSS_USR;
grant EXECUTE                                                                on BARS_REFSYNC_USR to REFSYNC_USR;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARSAQ/package/bars_refsync_usr.sql =========*** 
 PROMPT ===================================================================================== 
 