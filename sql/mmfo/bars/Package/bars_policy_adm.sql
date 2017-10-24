
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_policy_adm.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_POLICY_ADM 
IS
   --
   --  BARS_POLICY_ADM - ����� ����������������� ������� �� �������� ����� BARS
   --

   g_header_version    CONSTANT VARCHAR2 (64) := 'version 2.0 10/01/2016';

   g_awk_header_defs   CONSTANT VARCHAR2 (512) := '';

   --
   -- header_version - ���������� ������ ��������� ������
   --
   FUNCTION header_version
      RETURN VARCHAR2;

   --
   -- body_version - ���������� ������ ���� ������
   --
   FUNCTION body_version
      RETURN VARCHAR2;


   --
   -- ������������ ������ � policy_table
   -- ��� ������� ����� BARS
   --
   PROCEDURE alter_policy_info (
      p_table_name      IN policy_table.table_name%TYPE,
      p_policy_group    IN policy_table.policy_group%TYPE,
      p_select_policy   IN policy_table.select_policy%TYPE,
      p_insert_policy   IN policy_table.insert_policy%TYPE,
      p_update_policy   IN policy_table.update_policy%TYPE,
      p_delete_policy   IN policy_table.delete_policy%TYPE);

   --
   -- ������������ ������ � policy_table
   --
   PROCEDURE alter_policy_info (
      p_owner           IN policy_table.owner%TYPE,
      p_table_name      IN policy_table.table_name%TYPE,
      p_policy_group    IN policy_table.policy_group%TYPE,
      p_select_policy   IN policy_table.select_policy%TYPE,
      p_insert_policy   IN policy_table.insert_policy%TYPE,
      p_update_policy   IN policy_table.update_policy%TYPE,
      p_delete_policy   IN policy_table.delete_policy%TYPE);

   --
   -- ������������� ��������� �������� ��� �������(����� BARS) �� ������ �� policy_table
   --
   PROCEDURE add_policies (p_table_name IN VARCHAR2);

   --
   -- ������������� ��������� �������� ��� ������� �� ������ �� policy_table
   --
   PROCEDURE add_policies (p_owner IN VARCHAR2, p_table_name IN VARCHAR2);

   --
   -- ������������� �������� ������� ������� ��� ����������� �������(����� BARS)
   --
   PROCEDURE refresh_policies (p_table_name IN VARCHAR2);

   --
   -- ������������� �������� ������� ������� ��� ����������� �������
   --
   PROCEDURE refresh_policies (p_owner IN VARCHAR2, p_table_name IN VARCHAR2);

   --
   -- ������� ��������� �������� �� �������(����� BARS)
   --
   PROCEDURE remove_policies (p_table_name IN VARCHAR2);

   --
   -- ������� ��������� �������� �� �������
   --
   PROCEDURE remove_policies (p_owner IN VARCHAR2, p_table_name IN VARCHAR2);

   --
   -- �������� ��������� �������� �������(����� BARS)
   --
   PROCEDURE alter_policies (p_table_name   IN VARCHAR2,
                             p_enable       IN BOOLEAN DEFAULT TRUE);

   --
   -- �������� ��������� �������� �������
   --
   PROCEDURE alter_policies (p_owner        IN VARCHAR2,
                             p_table_name   IN VARCHAR2,
                             p_enable       IN BOOLEAN DEFAULT TRUE);

   --
   -- ��������� �������� �� ��� �������, ��������� � POLICY_TABLE
   --
   PROCEDURE add_all_policies;

   --
   -- ��������� �������� ������� ������� �� ���� ��������
   --
   PROCEDURE refresh_all_policies;

   --
   -- ������� �������� �� ��� �������, ��������� � POLICY_TABLE
   --
   PROCEDURE remove_all_policies;

   --
   -- �������� �������� �� ��� �������, ��������� � POLICY_TABLE
   --
   PROCEDURE alter_all_policies;

   --
   -- �������� �������� �� �������(����� BARS)
   --
   PROCEDURE enable_policies (p_table_name IN VARCHAR2);

   --
   -- �������� �������� �� �������
   --
   PROCEDURE enable_policies (p_owner IN VARCHAR2, p_table_name IN VARCHAR2);

   --
   -- ��������� �������� �� �������(����� BARS)
   --
   PROCEDURE disable_policies (p_table_name IN VARCHAR2);

   --
   -- ��������� �������� �� �������
   --
   PROCEDURE disable_policies (p_owner IN VARCHAR2, p_table_name IN VARCHAR2);

   --
   -- �������� ��� ��������, ��������� � POLICY_TABLE
   --
   PROCEDURE enable_all_policies;

   --
   -- ��������� ��� ��������, ��������� � POLICY_TABLE
   --
   PROCEDURE disable_all_policies;

   --
   -- ��������� � ������� ������� BRANCH(����� BARS)
   --
   PROCEDURE add_column_branch (p_table_name IN VARCHAR2);

   --
   -- ��������� � ������� ������� BRANCH
   --
   PROCEDURE add_column_branch (p_owner        IN VARCHAR2,
                                p_table_name   IN VARCHAR2);

   --
   -- ��������� � ������� ������� BRANCH_A � BRANCH_B(����� BARS)
   --
   PROCEDURE add_column_branch_ab (p_table_name IN VARCHAR2);

   --
   -- ��������� � ������� ������� BRANCH_A � BRANCH_B
   --
   PROCEDURE add_column_branch_ab (p_owner        IN VARCHAR2,
                                   p_table_name   IN VARCHAR2);

   --
   -- ��������� � ������� ������� KF(����� BARS)
   --
   PROCEDURE add_column_kf (p_table_name IN VARCHAR2);

   --
   -- ��������� � ������� ������� KF
   --
   PROCEDURE add_column_kf (p_owner IN VARCHAR2, p_table_name IN VARCHAR2);

   --
   -- ��������� ������� ���� �� accounts(acc,branch) �� ����������� ����� �� ������� ����� BARS
   --
   PROCEDURE add_fk_acc_branch (p_table_name IN VARCHAR2);

   --
   -- ��������� ������� ���� �� accounts(acc,branch) �� ����������� �����
   --
   PROCEDURE add_fk_acc_branch (p_owner        IN VARCHAR2,
                                p_table_name   IN VARCHAR2);

   --
   -- ��������� ������� ���� �� oper(ref,branch) �� ����������� ����� �� ������� ����� BARS
   --
   PROCEDURE add_fk_ref_branch (p_table_name IN VARCHAR2);

   --
   -- ��������� ������� ���� �� oper(ref,branch) �� ����������� �����
   --
   PROCEDURE add_fk_ref_branch (p_owner        IN VARCHAR2,
                                p_table_name   IN VARCHAR2);

   --
   -- ������������ ��� ��� �������� �������(���� branch), ���������� �� accounts
   --
   PROCEDURE update_accounts_child_tables (p_acc          IN NUMBER,
                                           p_new_branch   IN VARCHAR2);


   --
   -- ��������� ���� KF � ���������� �����
   -- � ����� BARS
   PROCEDURE add_kf2pk (p_table_name IN VARCHAR2);

   --
   -- ��������� ���� KF � ���������� �����
   --
   PROCEDURE add_kf2pk (p_owner IN VARCHAR2, p_table_name IN VARCHAR2);

   --
   -- ��������� ���� KF � ����������� �����
   -- � ����� BARS
   PROCEDURE add_kf2uk (p_table_name IN VARCHAR2);

   --
   -- ��������� ���� KF � ���������� �����
   --
   PROCEDURE add_kf2uk (p_owner IN VARCHAR2, p_table_name IN VARCHAR2);

   --
   -- ��������� ���� KF �� ������� ������, ���� ��� ��������� �� PK ��� UK ������� � ����� KF
   -- � ����� BARS
   PROCEDURE alter_kf_cons (p_table_name IN VARCHAR2);

   --
   -- ��������� ���� KF �� ������� ������, ���� ��� ��������� �� PK ��� UK ������� � ����� KF
   --
   PROCEDURE alter_kf_cons (p_owner IN VARCHAR2, p_table_name IN VARCHAR2);


END bars_policy_adm;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_POLICY_ADM is
--
--  BARS_POLICY_ADM - ����� ����������������� ������� �� �������� ����� BARS
--

g_body_version  constant varchar2(64)  := 'version 2.0 10/01/2016';

g_awk_body_defs constant varchar2(512) := ''
;

-- ��� ����� �-��� ��������
g_func_schema_name   constant varchar2(30)  := 'BARS';

-- ��� �������� ��������� ��� ������ ������ �������
g_driving_namespace constant varchar2(30)  := 'BARS_CONTEXT';
-- ������� �������� ��������� ��� ������ ������ �������
g_driving_attribute constant varchar2(30)  := 'POLICY_GROUP';

--
-- header_version - ���������� ������ ��������� ������
--
function header_version return varchar2 is
begin
  return 'Package header BARS_POLICY_ADM '||g_header_version||'.'||chr(10)
       ||'AWK definition: '||chr(10)
       ||g_awk_header_defs;
end header_version;

--
-- body_version - ���������� ������ ���� ������
--
function body_version return varchar2 is
begin
  return 'Package body BARS_POLICY_ADM '||g_body_version||'.'||chr(10)
       ||'AWK definition: '||chr(10)
       ||g_awk_body_defs;
end body_version;

--
-- ������������ ������ � policy_table
-- ��� ������� ����� BARS
--
procedure alter_policy_info(
    p_table_name         in policy_table.table_name%type,
    p_policy_group        in policy_table.policy_group%type,
    p_select_policy     in policy_table.select_policy%type,
    p_insert_policy     in policy_table.insert_policy%type,
    p_update_policy     in policy_table.update_policy%type,
        p_delete_policy     in policy_table.delete_policy%type) is
begin
  alter_policy_info(
        'BARS',
    p_table_name,
    p_policy_group,
    p_select_policy,
    p_insert_policy,
    p_update_policy,
        p_delete_policy);
end alter_policy_info;

--
-- ������������ ������ � policy_table
--
procedure alter_policy_info(
    p_owner         in policy_table.owner%type,
    p_table_name         in policy_table.table_name%type,
    p_policy_group        in policy_table.policy_group%type,
    p_select_policy     in policy_table.select_policy%type,
    p_insert_policy     in policy_table.insert_policy%type,
    p_update_policy     in policy_table.update_policy%type,
        p_delete_policy     in policy_table.delete_policy%type) is
begin
  update policy_table set select_policy=p_select_policy, insert_policy=p_insert_policy, update_policy=p_update_policy, delete_policy=p_delete_policy
  where owner=upper(p_owner) and table_name=upper(p_table_name) and policy_group=upper(p_policy_group);
  if sql%rowcount=0 then
    insert into policy_table(owner, table_name, policy_group, select_policy, insert_policy, update_policy, delete_policy)
    values(upper(p_owner), upper(p_table_name), upper(p_policy_group), p_select_policy, p_insert_policy, p_update_policy, p_delete_policy);
  end if;
end alter_policy_info;

--
-- check_policy - ��������� ����������� ���������� ���������� �������� �� ���������� �������
-- @p_object_owner  - �������� �������
-- @p_object_name   - ��� �������
-- @p_policy_owner      - �������� ������� ��������
-- @p_policy_function      - ������� ��������
-- @exception - ����������� ���������� � ��������� ������
--
procedure check_policy(p_object_owner in varchar2, p_object_name in varchar2,
                       p_policy_owner in varchar2, p_policy_function in varchar2) is
  l_policy_result    varchar2(4000);
  l_cursor            integer;
begin
  -- ��������� ��������� ������� ��������
  -- ����� ��� �� ������ ���������, �������� ��� ������������ �������, ������������ ������ ���������
  -- ���� ����� "������" �������, ����� ��������
  execute immediate 'select '||p_policy_owner||'.'||p_policy_function||'(:p_object_owner,:p_object_name) from dual'
  into l_policy_result using p_object_owner, p_object_name;
  -- �������� ������ ������� � ���������
  if l_policy_result is not null then
    l_cursor := dbms_sql.open_cursor();
    dbms_sql.parse(l_cursor, 'select 1 from '||p_object_owner||'.'||p_object_name||' where ('||l_policy_result||')', dbms_sql.native);
    dbms_sql.close_cursor(l_cursor);
  end if;
exception when others then
  if dbms_sql.is_open(l_cursor) then
      dbms_sql.close_cursor(l_cursor);
  end if;
  raise_application_error(-20000, '������ ��� �������� �������� '||p_policy_owner||'.'||p_policy_function||' �� ������� '
                                 ||p_object_owner||'.'||p_object_name||chr(10)||SQLERRM, true);
end check_policy;

--
-- ������������� ��������� �������� ������� �� ������ �� policy_table(����� BARS)
--
procedure add_policies(p_table_name in varchar2) is
begin
    add_policies('BARS', p_table_name);
end add_policies;

--
-- ������������� ��������� �������� ������� �� ������ �� policy_table
--
procedure add_policies(p_owner in varchar2, p_table_name in varchar2) is
    l_owner             policy_table.owner%type;
    l_table_name        policy_table.table_name%type;
    l_policy_name       varchar2(30);
    l_statement_types   varchar2(30);
begin
    bars_audit.info('���������� ������� �� ������ '||p_owner||'.'||p_table_name);
    l_owner      := upper(p_owner);
    l_table_name := upper(p_table_name);
    -- ��������� ����������� ��������
    dbms_rls.add_policy_context(
        object_schema => l_owner,
        object_name   => l_table_name,
        namespace     => g_driving_namespace,
        attribute     => g_driving_attribute
    );
    bars_audit.info('�������� ����������� �������� ('||g_driving_namespace||','||g_driving_attribute||
                    ') �� ������� '||l_owner||'.'||l_table_name);
    for p in (select * from policy_table where owner=l_owner and table_name=l_table_name) loop
        -- ���������� ������� ������ ������� �� �������
        if p.policy_group<>'SYS_DEFAULT' then
            dbms_rls.create_policy_group(
                object_schema => l_owner,
                object_name   => l_table_name,
                policy_group  => p.policy_group
            );
            bars_audit.info('������� ������ ������� '||p.policy_group||' �� ������� '||l_owner||'.'||l_table_name);
        end if;
        -- �������� ��� ��������
        for m in (select * from policy_mnemonics) loop
            l_policy_name       := null;
            l_statement_types   := null;
            if instr(p.select_policy,m.policy_char)>0 then
                l_policy_name     := l_policy_name || 'S';
                l_statement_types := l_statement_types || ',SELECT';
            end if;
            if instr(p.insert_policy,m.policy_char)>0 then
                l_policy_name := l_policy_name || 'I';
                l_statement_types := l_statement_types || ',INSERT';
            end if;
            if instr(p.update_policy,m.policy_char)>0 then
                l_policy_name := l_policy_name || 'U';
                l_statement_types := l_statement_types || ',UPDATE';
            end if;
            if instr(p.delete_policy,m.policy_char)>0 then
                l_policy_name := l_policy_name || 'D';
                l_statement_types := l_statement_types || ',DELETE';
            end if;
            if l_policy_name is not null then
                -- ������� �������� ��������
                check_policy(l_owner, l_table_name, g_func_schema_name, m.policy_function);
                --
                l_policy_name := m.policy_name_prefix || '_' || l_policy_name;
                dbms_rls.add_grouped_policy(
                    object_schema   => l_owner,
                    object_name     => l_table_name,
                    policy_group    => p.policy_group,
                    policy_name     => l_policy_name,
                    function_schema => g_func_schema_name,
                    policy_function => m.policy_function,
                    statement_types => substr(l_statement_types, 2),
                    update_check    => TRUE,
                    enable          => FALSE,
            static_policy   => TRUE,
                    policy_type     => case
                                 when m.policy_type='SHARED_STATIC'         then dbms_rls.SHARED_STATIC
                                         when m.policy_type='STATIC'             then dbms_rls.STATIC
                                         when m.policy_type='CONTEXT_SENSITIVE'        then dbms_rls.CONTEXT_SENSITIVE
                                         when m.policy_type='SHARED_CONTEXT_SENSITIVE'    then dbms_rls.SHARED_CONTEXT_SENSITIVE
                                         when m.policy_type='DYNAMIC'            then dbms_rls.DYNAMIC
                                         else dbms_rls.DYNAMIC
                                       end
                );
                bars_audit.info('��������� �������� '||l_policy_name||' � ������ '||p.policy_group
                               ||' �� ������� '||l_owner||'.'||l_table_name);
            end if;
        end loop;
      -- ��������� ����� ���������� ��������
      update policy_table set apply_time=sysdate,
      who_alter=substr('TERMINAL: '||sys_context('USERENV','TERMINAL')||', '||
                     'HOST: '||sys_context('USERENV','HOST')||', '||
                     'OS_USER: '||sys_context('USERENV','OS_USER')||', '||
                     'IP_ADDRESS: '||sys_context('USERENV','IP_ADDRESS'),1,256)
      where owner=p.owner and table_name=p.table_name and policy_group=p.policy_group;
      commit;
    end loop;
    bars_audit.info('�������� �� ������ '||l_owner||'.'||l_table_name||' ������� ���������');
end add_policies;

--
-- ������������� �������� ������� ������� ��� ����������� �������(����� BARS)
--
procedure refresh_policies(p_table_name in varchar2) is
begin
    refresh_policies('BARS', p_table_name);
end refresh_policies;

--
-- ������������� �������� ������� ������� ��� ����������� �������
--
procedure refresh_policies(p_owner in varchar2, p_table_name in varchar2) is
    l_owner             policy_table.owner%type;
    l_table_name        policy_table.table_name%type;
begin
    l_owner      := upper(p_owner);
    l_table_name := upper(p_table_name);
    for p in (select * from all_policies where object_owner=l_owner and object_name=l_table_name)
    loop
        dbms_rls.enable_grouped_policy(
            object_schema   => l_owner,
            object_name     => l_table_name,
            group_name      => p.policy_group,
            policy_name     => p.policy_name
        );
    end loop;
    bars_audit.info('��������� �������� ������� ������� �� ������� '||l_owner||'.'||l_table_name);

end refresh_policies;

--
-- ������� ��������� �������� �������(����� BARS)
--
procedure remove_policies(p_table_name in varchar2) is
begin
    remove_policies('BARS', p_table_name);
end remove_policies;

--
-- ������� ��������� �������� �������
--
procedure remove_policies(p_owner in varchar2, p_table_name in varchar2) is
    l_owner             policy_table.owner%type;
    l_table_name        policy_table.table_name%type;
begin
    l_owner      := upper(p_owner);
    l_table_name := upper(p_table_name);
    -- ������� �������� �� �����
    for p in (select * from all_policies where object_owner=l_owner and object_name=l_table_name)
    loop
        dbms_rls.drop_grouped_policy(
            object_schema   => l_owner,
            object_name     => l_table_name,
            policy_group    => p.policy_group,
            policy_name     => p.policy_name
        );
        bars_audit.info('������� �������� '||p.policy_name||' �� ������ '||p.policy_group
                      ||' �� ������� '||l_owner||'.'||l_table_name);
    end loop;
    -- ������� ���� ������
    for g in (select * from all_policy_groups where object_owner=l_owner and object_name=l_table_name)
    loop
        dbms_rls.delete_policy_group(
            object_schema   => l_owner,
            object_name     => l_table_name,
            policy_group    => g.policy_group
        );
        bars_audit.info('������� ������ ������� '||g.policy_group||' �� ������� '||l_owner||'.'||l_table_name);
    end loop;
    -- ������� ����������� ��������
    for c in (select * from all_policy_contexts where object_owner=l_owner and object_name=l_table_name)
    loop
        dbms_rls.drop_policy_context(
            object_schema => l_owner,
            object_name   => l_table_name,
            namespace     => c.namespace,
            attribute     => c.attribute
        );
        bars_audit.info('������ ����������� �������� ('||c.namespace||','||c.attribute||') � ������� '||l_owner||'.'||l_table_name);
    end loop;
end remove_policies;

--
-- �������� ��������� �������� �������(����� BARS)
--
procedure alter_policies(p_table_name in varchar2, p_enable in boolean default true) is
begin
    alter_policies('BARS', p_table_name, p_enable);
end alter_policies;

--
-- �������� ��������� �������� �������
--
procedure alter_policies(p_owner in varchar2, p_table_name in varchar2, p_enable in boolean default true) is
begin
    remove_policies(p_owner, p_table_name);
    add_policies(p_owner, p_table_name);
    if p_enable then
        enable_policies(p_owner, p_table_name);
    end if;
end alter_policies;


procedure clean_errors is
begin
    execute immediate 'truncate table tmp_policy_errors';
end clean_errors;

procedure save_error(
    p_sqlcall   in tmp_policy_errors.sql_call%type,
    p_errormsg  in tmp_policy_errors.error_msg%type) is
pragma autonomous_transaction;
begin
    insert into tmp_policy_errors(sql_call, error_msg)
    values(p_sqlcall, p_errormsg);
    commit;
end save_error;

--
-- ��������� �������� �� ��� ������� ����� BARS, ��������� � POLICY_TABLE
--
procedure add_all_policies is
    l_sqlerrm varchar2(4000);
    l_has_errors boolean := false;
begin
    --raise_application_error(-20000, '������������� ��������� ADD_ALL_POLICIES �������� ���������', true);
    clean_errors;
    for t in (select unique owner, table_name from policy_table) loop
        begin
            add_policies(t.owner, t.table_name);
        exception when others then
            l_has_errors := true;
            l_sqlerrm := substr(SQLERRM,1,4000);
            bars_audit.error(l_sqlerrm);
            save_error('add_policies('''||t.owner||''', '''||t.table_name||''')', l_sqlerrm);
        end;
    end loop;
    if l_has_errors then
        raise_application_error(-20000, '��������� ��������� � ��������. �������� ��. ������� TMP_POLICY_ERRORS.', true);
    end if;
end add_all_policies;

--
-- ��������� �������� ������� ������� �� ���� ��������
--
procedure refresh_all_policies is
    l_sqlerrm varchar2(4000);
    l_has_errors boolean := false;
begin
    clean_errors;
    for t in (select unique owner, table_name from policy_table) loop
        begin
            refresh_policies(t.owner, t.table_name);
        exception when others then
            l_has_errors := true;
            l_sqlerrm := substr(SQLERRM,1,4000);
            bars_audit.error(l_sqlerrm);
            save_error('refresh_policies('''||t.owner||''', '''||t.table_name||''')', l_sqlerrm);
        end;
    end loop;
    if l_has_errors then
        raise_application_error(-20000, '��������� ��������� � ��������. �������� ��. ������� TMP_POLICY_ERRORS.', true);
    end if;
end refresh_all_policies;

--
-- ������� �������� �� ��� ������� ����� BARS, ��������� � POLICY_TABLE
--
procedure remove_all_policies is
    l_sqlerrm varchar2(4000);
    l_has_errors boolean := false;
begin
    --raise_application_error(-20000, '������������� ��������� REMOVE_ALL_POLICIES �������� ���������', true);
    clean_errors;
    for t in (select unique owner, table_name from policy_table) loop
        begin
            remove_policies(t.owner, t.table_name);
        exception when others then
            l_has_errors := true;
            l_sqlerrm := substr(SQLERRM,1,4000);
            bars_audit.error(l_sqlerrm);
            save_error('remove_policies('''||t.owner||''', '''||t.table_name||''')', l_sqlerrm);
        end;
    end loop;
    if l_has_errors then
        raise_application_error(-20000, '��������� ��������� � ��������. �������� ��. ������� TMP_POLICY_ERRORS.', true);
    end if;
end remove_all_policies;

--
-- �������� �������� �� ��� ������� ����� BARS, ��������� � POLICY_TABLE
--
procedure alter_all_policies is
    l_sqlerrm varchar2(4000);
    l_has_errors boolean := false;
begin
    --raise_application_error(-20000, '������������� ��������� ALTER_ALL_POLICIES �������� ���������', true);
    clean_errors;
    for t in (select unique owner, table_name from policy_table) loop
        begin
            alter_policies(t.owner, t.table_name);
        exception when others then
            l_has_errors := true;
            l_sqlerrm := substr(SQLERRM,1,4000);
            bars_audit.error(l_sqlerrm);
            save_error('alter_policies('''||t.owner||''', '''||t.table_name||''')', l_sqlerrm);
        end;
    end loop;
    if l_has_errors then
        raise_application_error(-20000, '��������� ��������� � ��������. �������� ��. ������� TMP_POLICY_ERRORS.', true);
    end if;
end alter_all_policies;

--
-- �������� �������� �� �������(����� BARS)
--
procedure enable_policies(p_table_name in varchar2) is
begin
    enable_policies('BARS', p_table_name);
end enable_policies;

--
-- �������� �������� �� �������
--
procedure enable_policies(p_owner in varchar2, p_table_name in varchar2) is
    l_owner             policy_table.owner%type;
    l_table_name        policy_table.table_name%type;
begin
    l_owner := upper(p_owner);
    l_table_name := upper(p_table_name);
    for p in (select * from all_policies where object_owner=l_owner and object_name=l_table_name)
    loop
        dbms_rls.enable_grouped_policy(
            object_schema   => l_owner,
            object_name     => l_table_name,
            group_name      => p.policy_group,
            policy_name     => p.policy_name,
            enable          => true
        );
    end loop;
    bars_audit.info('�������� �������� �� ������� '||l_owner||'.'||l_table_name);
end enable_policies;

--
-- ��������� �������� �� �������(����� BARS)
--
procedure disable_policies(p_table_name in varchar2) is
begin
    disable_policies('BARS', p_table_name);
end disable_policies;

--
-- ��������� �������� �� �������
--
procedure disable_policies(p_owner in varchar2, p_table_name in varchar2) is
    l_owner             policy_table.owner%type;
    l_table_name        policy_table.table_name%type;
begin
    l_owner := upper(p_owner);
    l_table_name := upper(p_table_name);
    for p in (select * from all_policies where object_owner=l_owner and object_name=l_table_name)
    loop
        dbms_rls.enable_grouped_policy(
            object_schema   => l_owner,
            object_name     => l_table_name,
            group_name      => p.policy_group,
            policy_name     => p.policy_name,
            enable          => false
        );
    end loop;
    bars_audit.info('��������� �������� �� ������� '||l_owner||'.'||l_table_name);
end disable_policies;

--
-- �������� ��� ��������, ��������� � POLICY_TABLE
--
procedure enable_all_policies is
    l_sqlerrm varchar2(4000);
    l_has_errors boolean := false;
begin
    clean_errors;
    for t in (select unique owner, table_name from policy_table) loop
        begin
            enable_policies(t.owner, t.table_name);
        exception when others then
            l_has_errors := true;
            l_sqlerrm := substr(SQLERRM,1,4000);
            bars_audit.error(l_sqlerrm);
            save_error('enable_policies('''||t.owner||''', '''||t.table_name||''')', l_sqlerrm);
        end;
    end loop;
    if l_has_errors then
        raise_application_error(-20000, '��������� ��������� � ��������. �������� ��. ������� TMP_POLICY_ERRORS.', true);
    end if;
end enable_all_policies;

--
-- ��������� ��� ��������, ��������� � POLICY_TABLE
--
procedure disable_all_policies is
    l_sqlerrm varchar2(4000);
    l_has_errors boolean := false;
begin
    clean_errors;
    for t in (select unique owner, table_name from policy_table) loop
        begin
            disable_policies(t.owner, t.table_name);
        exception when others then
            l_has_errors := true;
            l_sqlerrm := substr(SQLERRM,1,4000);
            bars_audit.error(l_sqlerrm);
            save_error('disable_policies('''||t.owner||''', '''||t.table_name||''')', l_sqlerrm);
        end;
    end loop;
    if l_has_errors then
        raise_application_error(-20000, '��������� ��������� � ��������. �������� ��. ������� TMP_POLICY_ERRORS.', true);
    end if;
end disable_all_policies;

--
-- ��������� � ������� ������� BRANCH(����� BARS)
--
procedure add_column_branch(p_table_name in varchar2) is
begin
    add_column_branch('BARS', p_table_name);
end add_column_branch;

--
-- ��������� � ������� ������� BRANCH
--
procedure add_column_branch(p_owner in varchar2, p_table_name in varchar2) is
    l_table_alias  varchar2(30);
    e_column_already_exists exception;
    pragma exception_init(e_column_already_exists,-1430);
begin
    begin
        select table_alias into l_table_alias from table_alias where table_name=p_table_name;
    exception when no_data_found then
        l_table_alias := replace(p_table_name,'_','');
    end;
    execute immediate 'alter table '||p_owner||'.'||p_table_name||' add(
                       branch varchar2(30)
                       default sys_context(''bars_context'',''user_branch''))';
    execute immediate 'alter table '||p_owner||'.'||p_table_name||' modify(
                       branch varchar2(30)
                       default sys_context(''bars_context'',''user_branch'')
                       constraint cc_'||l_table_alias||'_branch_nn not null)';
    execute immediate 'alter table '||p_owner||'.'||p_table_name||' add( constraint fk_'||l_table_alias||'_branch
                       foreign key(branch) references bars.branch(branch))';
    -- ��������� �����������
    execute immediate 'comment on column '||p_owner||'.'||p_table_name||'.branch is ''Hierarchical Branch Code''';
exception
    when e_column_already_exists then null;
    when others then raise;
end add_column_branch;

--
-- ��������� � ������� ������� BRANCH_A � BRANCH_B
--
procedure add_column_branch_ab(p_table_name in varchar2) is
begin
    add_column_branch_ab('BARS', p_table_name);
end add_column_branch_ab;

--
-- ��������� � ������� ������� BRANCH_A � BRANCH_B
--
procedure add_column_branch_ab(p_owner in varchar2, p_table_name in varchar2) is
    l_table_alias  varchar2(30);
begin
    begin
        select table_alias into l_table_alias from table_alias where table_name=p_table_name;
    exception when no_data_found then
        l_table_alias := replace(p_table_name,'_','');
    end;
    -- branch_a
    execute immediate 'alter table '||p_owner||'.'||p_table_name||' add(
                       branch_a varchar2(30)
                       default sys_context(''bars_context'',''user_branch''))';
    execute immediate 'alter table '||p_owner||'.'||p_table_name||' modify(
                       branch_a varchar2(30)
                       default sys_context(''bars_context'',''user_branch'')
                       constraint cc_'||l_table_alias||'_brancha_nn not null)';
    execute immediate 'alter table '||p_owner||'.'||p_table_name||' add( constraint fk_'||l_table_alias||'_brancha
                       foreign key(branch_a) references bars.branch(branch))';
    -- branch_b
    execute immediate 'alter table '||p_owner||'.'||p_table_name||' add(
                       branch_b varchar2(30)
                       default sys_context(''bars_context'',''user_branch''))';
    execute immediate 'alter table '||p_owner||'.'||p_table_name||' modify(
                       branch_b varchar2(30)
                       default sys_context(''bars_context'',''user_branch'')
                       constraint cc_'||l_table_alias||'_branchb_nn not null)';
    execute immediate 'alter table '||p_owner||'.'||p_table_name||' add( constraint fk_'||l_table_alias||'_branchb
                       foreign key(branch_b) references bars.branch(branch))';
end add_column_branch_ab;

--
-- ��������� � ������� ������� KF(����� BARS)
--
procedure add_column_kf(p_table_name in varchar2) is
begin
    add_column_kf('BARS', p_table_name);
end add_column_kf;

--
-- ��������� � ������� ������� KF
--
procedure add_column_kf(p_owner in varchar2, p_table_name in varchar2) is
    l_owner           varchar2(30);
    l_table_name        varchar2(30);
    l_table_alias       varchar2(30);
    l_num        number;
    e_column_already_exists exception;
    pragma exception_init(e_column_already_exists,-1430);
begin
    l_owner := upper(p_owner);
    l_table_name := upper(p_table_name);
    begin
        select table_alias into l_table_alias from table_alias where table_name=l_table_name;
    exception when no_data_found then
        l_table_alias := replace(l_table_name,'_','');
    end;
    -- ��������� ���� �������
    execute immediate 'alter table '||p_owner||'.'||p_table_name||' add(
                       kf varchar2(6) default sys_context(''bars_context'',''user_mfo''))';
    -- ���� ���� ���� branch, �������� ��������� �������� ��� � ���� kf
    begin
        select 1 into l_num from all_tab_columns where owner=l_owner and table_name=l_table_name and column_name='BRANCH';
        -- �����, ��������� kf
        execute immediate 'update '||p_owner||'.'||p_table_name||' set kf=bc.extract_mfo(branch)';
        commit;
    exception when no_data_found then
        null;
    end;
    -- ����������� not null
    execute immediate 'alter table '||p_owner||'.'||p_table_name||' modify(
                       kf varchar2(6) default sys_context(''bars_context'',''user_mfo'')
                       constraint cc_'||l_table_alias||'_kf_nn not null)';
    -- ������ �� banks$base.mfo
    execute immediate 'alter table '||p_owner||'.'||p_table_name||' add( constraint fk_'||l_table_alias||'_kf
                       foreign key(kf) references bars.banks$base(mfo))';
exception
    when e_column_already_exists then null;
    when others then raise;
end add_column_kf;

--
-- ��������� ������� ���� �� accounts(acc,branch) �� ����������� ����� �� ������� ����� BARS
--
procedure add_fk_acc_branch(p_table_name in varchar2) is
begin
    add_fk_acc_branch('BARS', p_table_name);
end add_fk_acc_branch;

--
-- ��������� ������� ���� �� accounts(acc,branch) �� ����������� �����
--
procedure add_fk_acc_branch(p_owner in varchar2, p_table_name in varchar2) is
    l_table_alias  varchar2(30);
begin
    begin
        select table_alias into l_table_alias from table_alias where table_name=p_table_name;
    exception when no_data_found then
        l_table_alias := replace(p_table_name,'_','');
    end;
    execute immediate 'alter table '||p_owner||'.'||p_table_name||' add( constraint fk_'||l_table_alias||'_accbranch
                       foreign key(acc,branch) references bars.accounts(acc,branch))';
end add_fk_acc_branch;

--
-- ��������� ������� ���� �� oper(ref,branch) �� ����������� ����� �� ������� ����� BARS
--
procedure add_fk_ref_branch(p_table_name in varchar2) is
begin
    add_fk_ref_branch('BARS', p_table_name);
end add_fk_ref_branch;

--
-- ��������� ������� ���� �� oper(ref,branch) �� ����������� �����
--
procedure add_fk_ref_branch(p_owner in varchar2, p_table_name in varchar2) is
    l_table_alias  varchar2(30);
begin
    begin
        select table_alias into l_table_alias from table_alias where table_name=p_table_name;
    exception when no_data_found then
        l_table_alias := replace(p_table_name,'_','');
    end;
    execute immediate 'alter table '||p_owner||'.'||p_table_name||' add( constraint fk_'||l_table_alias||'_refbranch
                       foreign key(ref,branch) references bars.oper(ref,branch))';
end add_fk_ref_branch;

--
-- ������������ ��� ��� �������� �������(���� branch), ���������� �� accounts
--
procedure update_accounts_child_tables(p_acc in number, p_new_branch in varchar2) is
begin
    null;
end update_accounts_child_tables;

--
-- ��������� ���� KF � ���������� �����
-- � ����� BARS
procedure add_kf2pk(p_table_name in varchar2) is
begin
    add_kf2pk('BARS', p_table_name);
end add_kf2pk;

--
-- ��������� ���� KF � ���������� �����
--
procedure add_kf2pk(p_owner in varchar2, p_table_name in varchar2) is
    l_owner                varchar2(30);
    l_table_name        varchar2(30);
    l_table_alias          varchar2(30);
    l_columns            varchar2(1000);
    l_constraint        varchar2(30);
    l_indexname         varchar2(100);
    l_tablespacename         varchar2(100);
    -------------------------------------------------------------------------------------------------------------------------------------------
    cursor cur_foreignkey_tables is
    select a.constraint_name constraint_name_fk, a.table_name table_name_fk, listagg(a.column_name,',') within group (order by a.position) list_col
    from all_cons_columns a
    join all_constraints c    on a.owner = c.owner      and a.constraint_name = c.constraint_name
                                                        and c.constraint_type = 'R'
                                                        and a.owner = l_owner
    join all_constraints c_pk on c.r_owner = c_pk.owner and c.r_constraint_name = c_pk.constraint_name
                                                        and c_pk.table_name = l_table_name
    join all_cons_columns b   on c_pk.owner = b.owner   and c_pk.constraint_name = b.constraint_name
                                                        and b.position = a.position
    group by a.constraint_name, a.table_name;
    -------------------------------------------------------------------------------------------------------------------------------------------
    type tab_cur_foreignkey_tables is table of cur_foreignkey_tables%rowtype;
    l_tab_cur_fkey_tables tab_cur_foreignkey_tables;
    -------------------------------------------------------------------------------------------------------------------------------------------
begin
    l_owner := upper(p_owner);
    l_table_name := upper(p_table_name);
    begin
        select table_alias into l_table_alias from table_alias where table_name=l_table_name;
    exception when no_data_found then
        l_table_alias := replace(l_table_name,'_','');
    end;
    l_columns := '';
    for c in (select c.*, t.index_name
              from all_constraints t, all_cons_columns c
              where t.owner=l_owner and
                    t.table_name=l_table_name and
                    t.owner=c.owner and
                    t.table_name=c.table_name and t.constraint_type='P' and
                    t.constraint_name=c.constraint_name
              order by c.position)
    loop
        l_constraint := c.constraint_name;
        l_columns := l_columns||','||c.column_name;
        l_indexname := c.index_name;
    end loop;
    if l_columns is null then
        raise_application_error(-20000, '��������� ���� �����������?', true);
    end if;
    -------------------------------------------------------------------------
    select i.tablespace_name into l_tablespacename
    from user_indexes i
    where i.index_name = l_indexname;
    -------------------------------------------------------------------------
    open cur_foreignkey_tables;
    fetch cur_foreignkey_tables bulk collect into l_tab_cur_fkey_tables;
    close cur_foreignkey_tables;
    -------------------------------------------------------------------------
    if instr(lower(l_columns),'kf') = 0 then
        l_columns := 'kf'||l_columns;
    else
        l_columns := substr(l_columns,2);
    end if;
    -- ������� ������ PK
    execute immediate 'alter table '||l_owner||'.'||l_table_name||' drop primary key cascade';
    declare
      err       exception;
      pragma    exception_init(err, -1418);
    begin
        execute immediate 'drop index '||l_owner||'.'||l_constraint;
    exception when err then
        null;
    end;
    -- ������� ����� PK
    execute immediate 'alter table '||l_owner||'.'||l_table_name||' add constraint pk_'||l_table_alias||' primary key('||l_columns||') using index tablespace '||l_tablespacename;

    if nvl(l_tab_cur_fkey_tables.count,0) <> 0 then
        for i in l_tab_cur_fkey_tables.first .. l_tab_cur_fkey_tables.last loop
            execute immediate'alter table '
                            ||l_owner
                            ||'.'
                            ||l_tab_cur_fkey_tables(i).table_name_fk
                            ||' add constraint '
                            ||l_tab_cur_fkey_tables(i).constraint_name_fk
                            ||' foreign key ('
                            ||case when instr(lower(l_tab_cur_fkey_tables(i).list_col),'kf') = 0 then 'kf,'||l_tab_cur_fkey_tables(i).list_col else l_tab_cur_fkey_tables(i).list_col end||') references '
                            ||l_owner
                            ||'.'
                            ||l_table_name
                            ||'('
                            ||l_columns
                            ||')';
        end loop;
    end if;
    -------------------------------------------------------------------------
--    ORA-00936: missing expression
--    ORA-06512: at "BARS.BARS_POLICY_ADM", line 788
--    ORA-06512: at "BARS.BARS_POLICY_ADM", line 710
--    ORA-06512: at line 2

end add_kf2pk;

--
-- ��������� ���� KF � ����������� �����
-- � ����� BARS
procedure add_kf2uk(p_table_name in varchar2) is
begin
    add_kf2uk('BARS', p_table_name);
end add_kf2uk;

--
-- ��������� ���� KF � ����������� �����
--
procedure add_kf2uk(p_owner in varchar2, p_table_name in varchar2) is
    l_owner                varchar2(30);
    l_table_name        varchar2(30);
    l_table_alias          varchar2(30);
    l_columns            varchar2(1000);
    l_constraint        varchar2(30);
    l_cons_name            varchar2(30);
    l_cons_name_nn        varchar2(30);
    i                number;
    l_exists            boolean;
    l_num            number;
    l_stmt            varchar2(4000);
begin
    l_owner := upper(p_owner);
    l_table_name := upper(p_table_name);
    begin
        select table_alias into l_table_alias from table_alias where table_name=l_table_name;
    exception when no_data_found then
        l_table_alias := replace(l_table_name,'_','');
    end;
    l_columns := '';
    for c in (select c.* from all_constraints t, all_cons_columns c
          where t.owner=l_owner and t.table_name=l_table_name
              and t.owner=c.owner and t.table_name=c.table_name and t.constraint_type='U'
              and t.constraint_name=c.constraint_name
              order by c.position)
    loop
        l_constraint := c.constraint_name;
        l_columns := l_columns||','||c.column_name;
    end loop;
    if l_columns is null then
        raise_application_error(-20000, '���������� ���� �����������?', true);
    end if;
    l_columns := 'kf'||l_columns;
    -- ��������� ��� �����������
    l_cons_name := 'UK_'||l_table_alias;
    -- �������� ����� ��� ��� ����, ��������� � ���� ����� ��-�������
    i := 1; l_cons_name_nn := 'UK'||case when i=1 then '' else to_char(i) end||'_'||l_table_alias; l_exists := true;
    while(length(l_cons_name_nn)<=30 and l_exists)
      loop
        begin
          select 1 into l_num from all_objects
          where owner=l_owner and object_name=l_cons_name_nn;
          i := i + 1;
          l_cons_name_nn := 'UK'||to_char(i)||'_'||l_table_alias;
        exception when no_data_found then
          l_exists := false;
        end;
      end loop;
    if l_exists then
          raise_application_error(-20000, '���������� ��������� ��� �����������', true);
    end if;
    -- ������� UK
    l_stmt := 'alter table '||l_owner||'.'||l_table_name||' add constraint '||l_cons_name_nn
    ||' unique('||l_columns||') using index';
    begin
        execute immediate l_stmt;
    exception when others then
        raise_application_error(-20000, SQLERRM||chr(10)||l_stmt, true);
    end;
end add_kf2uk;

--
-- ��������� ���� KF �� ������� ������, ���� ��� ��������� �� PK ��� UK ������� � ����� KF
-- � ����� BARS
procedure alter_kf_cons(p_table_name in varchar2) is
begin
    alter_kf_cons('BARS', p_table_name);
end alter_kf_cons;

--
-- ��������� ���� KF �� ������� ������, ���� ��� ��������� �� PK ��� UK ������� � ����� KF
--
procedure alter_kf_cons(p_owner in varchar2, p_table_name in varchar2) is
    l_owner                varchar2(30);
    l_table_name        varchar2(30);
    l_table_alias          varchar2(30);
    l_ref_table_alias      varchar2(30);
    l_ref_owner            varchar2(30);
    l_ref_table            varchar2(30);
    l_column_list          varchar2(1000);
    l_ref_column_list      varchar2(1000);
    l_cons_name            varchar2(30);
    l_cons_name_nn        varchar2(30);
    l_ref_constraint    varchar2(30);
    i                    integer;
    l_exists            boolean;
    l_num                number;
    l_stmt                varchar2(4000);
    l_cons_exists       exception;
      pragma    exception_init(l_cons_exists, -2275);

begin
    l_owner := upper(p_owner);
    l_table_name := upper(p_table_name);
    begin
        select table_alias into l_table_alias from table_alias where table_name=l_table_name;
    exception when no_data_found then
        l_table_alias := replace(l_table_name,'_','');
    end;
    -- ���� �� ���� ��������� ������������ �����������
    for c in (select * from all_constraints where owner=l_owner and table_name=l_table_name and constraint_type='R'
              and (owner, constraint_name) not in (select owner, constraint_name from all_cons_columns where column_name='KF'))
    loop
        -- ��������� ������ ����� �����������, ��� �������, ��� ����� ����� ���� KF
        l_column_list := '';
        for z in (select a.column_name, a.position, u.owner r_owner, u.table_name r_table_name, u.constraint_name
                  from all_cons_columns a, all_constraints u, all_tab_cols t
                  where a.owner=c.owner and a.table_name=c.table_name and a.constraint_name=c.constraint_name
                  and c.r_owner=u.owner and c.r_constraint_name=u.constraint_name
                  and u.constraint_type in ('P','U') and u.owner=t.owner and u.table_name=t.table_name and t.column_name='KF'
                  order by a.position)
        loop
            l_ref_owner := z.r_owner;
            l_ref_table := z.r_table_name;
            l_ref_constraint := z.constraint_name;
            l_column_list := l_column_list||','||z.column_name;
        end loop;
        if l_column_list is not null then
            l_column_list := 'kf'||l_column_list;
            -- ��������� ����� ������������ �������
            begin
                select table_alias into l_ref_table_alias from table_alias where table_name=l_ref_table;
            exception when no_data_found then
                l_ref_table_alias := replace(l_ref_table,'_','');
            end;
            -- ��������� ������ ����� ������������ �������
            l_ref_column_list := '';
            for w in (select column_name from all_cons_columns where owner=l_ref_owner and table_name=l_ref_table
                      and constraint_name=l_ref_constraint
                      order by position)
            loop
                l_ref_column_list := l_ref_column_list||','||w.column_name;
            end loop;
            l_ref_column_list := 'kf'||l_ref_column_list;
            -- ��������� ��� �����������
            l_cons_name := substr('FK_'||l_table_alias||'_'||l_ref_table_alias,1,30);
            -- �������� ����� ��� ��� ����, ��������� � ���� ����� ��-�������
            i := 1; l_cons_name_nn := l_cons_name; l_exists := true;
            --bars_audit.info('alter_kf_constraints '||l_owner||'.'||l_table_name||':'||l_cons_name_nn);
            while(length(l_cons_name_nn)<=30 and l_exists)
            loop
                begin
                    select 1 into l_num from all_constraints
                    where owner=l_owner and table_name=l_table_name and constraint_name=l_cons_name_nn;
                    i := i + 1;
                    l_cons_name_nn := l_cons_name||to_char(i);
                exception when no_data_found then
                    l_exists := false;
                end;
            end loop;
            if l_exists then
                raise_application_error(-20000, '���������� ��������� ��� �����������', true);
            end if;
            l_stmt := 'alter table '||p_owner||'.'||p_table_name||' add constraint '||l_cons_name_nn
            ||' foreign key('||l_column_list||') references '||l_ref_owner||'.'||l_ref_table||'('||l_ref_column_list||')';
            --bars_audit.info(l_stmt);
            -- ������� ����� ����������
            begin
                execute immediate l_stmt;
            exception
              when l_cons_exists then
                null;
              when others then
                raise_application_error(-20000, SQLERRM||chr(10)||l_stmt, true);
            end;
            -- ������� ������ ����������
            execute immediate 'alter table '||p_owner||'.'||p_table_name||' drop constraint '||c.constraint_name;
        end if;
    end loop;
end alter_kf_cons;



--------------------------------------------------------------------------------

----
-- add_fk_table - ��������� ��������� ����������� ����������� �� table
--
procedure add_fk_table(p_table varchar2, p_columns varchar2, p_index integer default null, p_ref_table varchar2, p_ref_columns varchar2)
is
    l_cons_exists   exception;
    pragma exception_init(l_cons_exists, -02264);
begin
    if p_index=10
    then
        raise_application_error(-20000, '��������� ��� ����� ��� FK :((');
    end if;
    --
    execute immediate 'alter table '||p_table||' add constraint fk_'||substr(replace(p_table,'_')||'_'||replace(p_ref_table,'_'),1,26)||to_char(p_index)
        ||' foreign key('||p_columns||') references '||p_ref_table||'('||p_ref_columns||') enable novalidate';
exception
    when l_cons_exists then
    --
    add_fk_table(p_table, p_columns, nvl(p_index,0)+1, p_ref_table, p_ref_columns);
    --
end add_fk_table;

----
-- add_fk_accounts - ��������� ��������� ����������� ����������� �� accounts
--
procedure add_fk_accounts(p_table varchar2, p_columns varchar2, p_index integer default null)
is
begin
    add_fk_table(p_table, p_columns, p_index, 'accounts', 'kf, acc');
end add_fk_accounts;

----
-- add_fk_oper - ��������� ��������� ����������� ����������� �� oper
--
procedure add_fk_oper(p_table varchar2, p_columns varchar2, p_index integer default null)
is
begin
    add_fk_table(p_table, p_columns, p_index, 'oper', 'kf, ref');
end add_fk_oper;

----
-- add_fk_customer - ��������� ��������� ����������� ����������� �� customer
--
procedure add_fk_customer(p_table varchar2, p_columns varchar2, p_index integer default null)
is
begin
    add_fk_table(p_table, p_columns, p_index, 'customer', 'rnk');
end add_fk_customer;

----
-- add_fk_staff - ��������� ��������� ����������� ����������� �� staff$base
--
procedure add_fk_staff(p_table varchar2, p_columns varchar2, p_index integer default null)
is
begin
    add_fk_table(p_table, p_columns, p_index, 'staff$base', 'id');
end add_fk_staff;


/*
--
-- ��������� � ������� ������� RFC(����� BARS) RFC=Root/Filial Code
--
procedure add_column_rfc(p_table_name in varchar2) is
begin
    add_column_rfc('BARS', p_table_name);
end add_column_rfc;

--
-- ��������� � ������� ������� RFC
--
procedure add_column_rfc(p_owner in varchar2, p_table_name in varchar2) is
    l_owner           varchar2(30);
    l_table_name        varchar2(30);
    l_table_alias       varchar2(30);
    l_num        number;
begin
    l_owner := upper(p_owner);
    l_table_name := upper(p_table_name);
    begin
        select table_alias into l_table_alias from table_alias where table_name=l_table_name;
    exception when no_data_found then
        l_table_alias := replace(l_table_name,'_','');
    end;
    -- ��������� ���� �������
    execute immediate 'alter table '||p_owner||'.'||p_table_name||' add(
                       rfc varchar2(6) default sys_context(''bars_context'',''rfc''))';
    -- ���� ���� ���� branch, �������� ��������� �������� ��� � ���� rf
    begin
        select 1 into l_num from all_tab_columns where owner=l_owner and table_name=l_table_name and column_name='BRANCH';
        -- �����, ��������� kf
        execute immediate 'update '||p_owner||'.'||p_table_name||' set rfc=bc.extract_rfc(branch)';
        commit;
    exception when no_data_found then
        null;
    end;
    -- ����������� not null
    execute immediate 'alter table '||p_owner||'.'||p_table_name||' modify(
                       rfc varchar2(6) default sys_context(''bars_context'',''rfc'')
                       constraint cc_'||l_table_alias||'_rfc_nn not null)';
    -- ������ �� banks$base.mfo
    execute immediate 'alter table '||p_owner||'.'||p_table_name||' add( constraint fk_'||l_table_alias||'_rfc
                       foreign key(rfc) references bars.banks$base(mfo))';
    -- ��������� �����������
    execute immediate 'comment on column '||p_owner||'.'||p_table_name||'.rfc is ''Root/Filial Code (Root="000000", Filial="MFO")''';
    --
end add_column_rfc;


--
-- ��������� ���� RFC � ���������� �����
-- � ����� BARS
procedure add_rfc2pk(p_table_name in varchar2) is
begin
    add_rfc2pk('BARS', p_table_name);
end add_rfc2pk;

--
-- ��������� ���� RFC � ���������� �����
--
procedure add_rfC2pk(p_owner in varchar2, p_table_name in varchar2) is
    l_owner                varchar2(30);
    l_table_name        varchar2(30);
    l_table_alias          varchar2(30);
    l_columns            varchar2(1000);
    l_constraint        varchar2(30);
begin
    l_owner := upper(p_owner);
    l_table_name := upper(p_table_name);
    begin
        select table_alias into l_table_alias from table_alias where table_name=l_table_name;
    exception when no_data_found then
        l_table_alias := replace(l_table_name,'_','');
    end;
    l_columns := '';
    for c in (select c.* from all_constraints t, all_cons_columns c
          where t.owner=l_owner and t.table_name=l_table_name
              and t.owner=c.owner and t.table_name=c.table_name and t.constraint_type='P'
              and t.constraint_name=c.constraint_name
              order by c.position)
    loop
        l_constraint := c.constraint_name;
        l_columns := l_columns||','||c.column_name;
    end loop;
    if l_columns is null then
        raise_application_error(-20000, '��������� ���� �����������?', true);
    end if;
    l_columns := 'rfc'||l_columns;
    -- ������� ������ PK
    execute immediate 'alter table '||l_owner||'.'||l_table_name||' drop primary key';
    declare
      err       exception;
      pragma    exception_init(err, -1418);
    begin
        execute immediate 'drop index '||l_owner||'.'||l_constraint;
    exception when err then
        null;
    end;
    -- ������� ����� PK
    execute immediate 'alter table '||l_owner||'.'||l_table_name||' add constraint pk_'||l_table_alias
    ||' primary key('||l_columns||') using index';
end add_rfc2pk;
*/


end bars_policy_adm;
/
 show err;
 
PROMPT *** Create  grants  BARS_POLICY_ADM ***
grant EXECUTE                                                                on BARS_POLICY_ADM to BARSAQ with grant option;
grant EXECUTE                                                                on BARS_POLICY_ADM to BARSAQ_ADM with grant option;
grant EXECUTE                                                                on BARS_POLICY_ADM to BARSDWH_ACCESS_USER;
grant EXECUTE                                                                on BARS_POLICY_ADM to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_POLICY_ADM to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_policy_adm.sql =========*** End
 PROMPT ===================================================================================== 
 