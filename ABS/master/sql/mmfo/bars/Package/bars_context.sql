prompt package/bars_context.sql
create or replace package bars.bars_context
as

    -----------------------------------------------------------------
    --
    -- BARS_CONTEXT - ����� ��� ��������� ��������
    --                ��������� "BARS_CONTEXT"
    --

    -----------------------------------------------------------------

    -- ���������
    --
    --
    VERSION_HEADER       constant varchar2(64) := 'version 1.21 12.09.2012';
    VERSION_HEADER_DEFS  constant varchar2(512) := ''
               || 'KF                           ���������������� ����� � ����� ''kf'''  || chr(10)
               || 'POLICY_GROUP                 ������������� ����� �������'  || chr(10)
               || 'BR_ACCESS                ����������� ������������� �� ������ V_BRANCH_ACCESS '  || chr(10)
            ;

    GLOBAL_CTX             constant varchar2(30) := 'bars_global';
    CONTEXT_CTX            constant varchar2(30) := 'bars_context';

    GROUP_WHOLE            constant varchar2(30) := 'WHOLE';
    GROUP_FILIAL           constant varchar2(30) := 'FILIAL';

    -- ��������� ����������� ���������
    CTXPAR_USERID          constant varchar2(30) := 'user_id';
    CTXPAR_USERNAME        constant varchar2(30) := 'user_name';
    CTXPAR_APPSCHEMA       constant varchar2(30) := 'user_appschema';

    -- ��������� ���������
    CTXPAR_POLGRPDEF       constant varchar2(30) := 'policy_group_default';
    CTXPAR_POLGRP          constant varchar2(30) := 'policy_group';
    CTXPAR_SECALARM        constant varchar2(30) := 'sec_alarm';
    CTXPAR_MFO             constant varchar2(30) := 'mfo';
    CTXPAR_RFC             constant varchar2(30) := 'rfc';
    CTXPAR_USERMFOP        constant varchar2(30) := 'user_mfop';
    CTXPAR_GLOBAL_BANKDATE constant varchar2(30) := 'global_bankdate';
    CTXPAR_GLBMFO          constant varchar2(30) := 'glb_mfo';
    CTXPAR_USERBRANCH      constant varchar2(30) := 'user_branch';
    CTXPAR_USERBRANCH_MASK constant varchar2(30) := 'user_branch_mask';
    CTXPAR_USERMFO         constant varchar2(30) := 'user_mfo';
    CTXPAR_USERMFO_MASK    constant varchar2(30) := 'user_mfo_mask';
    CTXPAR_CSCHEMA         constant varchar2(30) := 'cschema';
    CTXPAR_LASTCALL        constant varchar2(30) := 'last_call';
    CTXPAR_DBID            constant varchar2(30) := 'db_id';
    CTXPAR_PARAMSMFO       constant varchar2(30) := 'params_mfo';
    CTXPAR_SELECTED_BRANCH constant varchar2(30) := 'selected_branch';


    ROOT_MFO               constant varchar2(6) := '000000';


    function current_branch_code
    return varchar2;

    function current_mfo
    return varchar2;

    function current_branch_name
    return varchar2;

    function current_policy_group
    return varchar2;

    -----------------------------------------------------------------
    -- SET_CONTEXT()
    --
    --    ��������� �������������� ��������� ������������
    --
    --
    procedure set_context;

    -----------------------------------------------------------------
    -- CLEAR_SESSION_CONTEXT()
    --
    --    ������� ����������������� ���������
    --
    --
    procedure clear_session_context;

    -----------------------------------------------------------------
    -- RELOAD_CONTEXT()
    --
    --    ����������������� ����������������� ���������
    --
    --
    procedure reload_context;



    -----------------------------------------------------------------
    -- CHECK_USER_PRIVS()
    --
    --     ������� �������� ���� ������������
    --
    --
    function check_user_privs return boolean;



    -----------------------------------------------------------------
    -- EXTRACT_MFO()
    --
    --     ������� ��� ��������� ���� ��� �� ���� ���������
    --
    --
    --
    function extract_mfo(
                 p_branch in varchar2 default null) return varchar2;

    -----------------------------------------------------------------
    -- EXTRACT_RFC()
    --
    --     ������� ��� ��������� ���� RFC(Root/Filial Code) �� ���� ���������
    --
    --
    --
    function extract_rfc(
                 p_branch in varchar2 default null) return varchar2;

    -----------------------------------------------------------------
    -- GET_PARENT_BRANCH()
    --
    --     ������� ��� ��������� ���� ������������� ���������
    --
    --
    --
    function get_parent_branch(
                 p_branch in varchar2 default null) return varchar2;

    -----------------------------------------------------------------
    -- IS_PARENT_BRANCH()
    --
    --     ������� ��������� �������� �� ���������� ��� ���������
    --     (������ ��������) ����� �� ������������ ��������� ��
    --     ��������� � �������� ��������� ������������.
    --
    --     ���������:
    --
    --         p_branch   ��� ���������
    --
    --         p_level    �������
    --                        0 - �������� ���������� �����������
    --                            ���� ��������� � ��������������
    --                            ���� ��������� � ������������
    --                        <n> ���������� ������� �����
    --
    --     ������� ���������� �������� "1", ���� ���������� ���
    --     ��������� �������� ������������, ����� �������� "0"
    --
    function is_parent_branch(
                 p_branch in varchar2,
                 p_level  in number  default 0) return number;


    -----------------------------------------------------------------
    -- IS_PBRANCH()
    --
    --     ������� ������� is_parent_branch()
    --
    function is_pbranch(
                 p_branch in varchar2,
                 p_level  in number  default 0) return number;


    -----------------------------------------------------------------
    -- IS_MFO()
    --
    --     ������� ���������� �������� �� BRANCH ���������� �����������
    --     ���������� 0/1
    --
    --
    function is_mfo(
                 p_branch in varchar2 default null) return number;


    -----------------------------------------------------------------
    -- MAKE_BRANCH()
    --
    --     ������� ���������� ����� �� ���
    --
    --
    --
    function make_branch(
                 p_mfo in varchar2) return varchar2;


    -----------------------------------------------------------------
    -- MAKE_BRANCH_MASK()
    --
    --     ������� ���������� ����� ������ �� ���
    --
    --
    --
    function make_branch_mask(
                 p_mfo in varchar2) return varchar2;

    -----------------------------------------------------------------
    -- SUBST_BRANCH()
    --
    --     ��������� ������������� ������������ ������ ��������������
    --     @p_branch - ��� �������������
    --     @p_policy_group - ������ �������
    --     (���� ������, �� ����� ��������� � ���������� ����� ��������)
    --
    procedure subst_branch(
                  p_branch       in varchar2
                  ,p_policy_group in varchar2 default null
                  );

    -----------------------------------------------------------------
    -- SUBST_MFO()
    --
    --     ��������� ������������� ������������ ������ MFO
    --
    --
    procedure subst_mfo(
                  p_mfo in varchar2);


    -----------------------------------------------------------------
    -- SET_POLICY_GROUP()
    --
    --     ��������� ������������� �������� ������ �������
    --
    --
    procedure set_policy_group(
                  p_policy_group in varchar2);

    -----------------------------------------------------------------
    -- SELECT_BRANCH()
    --
    --    ����� ������ �� ��������� ���������
    --
    --
    procedure select_branch(p_branch in varchar2);



    -----------------------------------------------------------------
    -- HEADER_VERSION()
    --
    --     ������� ���������� ������ � ������� ��������� ������
    --
    --
    --
    function header_version return varchar2;

    -----------------------------------------------------------------
    -- BODY_VERSION()
    --
    --     ������� ���������� ������ � ������� ���� ������
    --
    --
    --
    function body_version return varchar2;

    -----------------------------------------------------------------
    -- SET_CSCHEMA()
    --
    --    ��������� ������� �����
    --
    --
    procedure set_cschema(p_cschema varchar2);


    -----------------------------------------------------------------
    -- GO()
    --
    --     ��������� ������������� ������������ ������ ��������������
    --     @p_branch - ��� ������������� ��� ��� ���
    --     �-�,
    --     bc.go('/'); -- ����� � �������� �����
    --     bc.go('303398'); -- ����� � ���, �� ��, ��� � �����
    --     bc.go('/303398/');
    --     bc.go('/303398/000120/060120/'); - ����� � ����� /303398/000120/060120/
    --
    procedure go(p_branch in varchar2);

    -----------------------------------------------------------------
    -- HOME()
    --
    --    ������������ ����� � ���� �����
    --
    --
    procedure home;

end;
/
CREATE OR REPLACE PACKAGE BODY BARS.bars_context
is


    -----------------------------------------------------------------
    -- ���������
    --
    --
    VERSION_BODY          constant varchar2(64)  := 'version 1.5 06.03.2019';
    VERSION_BODY_DEFS     constant varchar2(512) := ''
                          || 'KF            ���������������� ����� � ����� ''KF'''                   || chr(10)
                          || 'POLICY_GROUP  ������������� ����� �������'                             || chr(10)
                          || 'BR_ACCESS     ����������� ������������� �� ������ V_BRANCH_ACCESS '    || chr(10)
            ;

    RESOURCE_BUSY          exception;
    pragma exception_init(RESOURCE_BUSY,   -54  );


    -----------------------------------------------------------------
    -- ���������� ����������
    --
    --
    g_polgrpdef       varchar2(30);    -- ������������� �������� ����� �������

    is_select_branch_call    boolean;

    function current_branch_code
    return varchar2
    is
    begin
        return sys_context(bars_context.CONTEXT_CTX, bars_context.CTXPAR_USERBRANCH);
    end;

    function current_mfo
    return varchar2
    is
    begin
        return sys_context(bars_context.CONTEXT_CTX, bars_context.CTXPAR_USERMFO);
    end;

    function current_branch_name
    return varchar2
    is
    begin
        return branch_utl.get_branch_name(current_branch_code());
    end;

    function current_policy_group
    return varchar2
    is
    begin
        return sys_context(bars_context.CONTEXT_CTX, bars_context.CTXPAR_POLGRP);
    end;

    -----------------------------------------------------------------
    -- SET_CONTEXT_EX()
    --
    --    ��������� ��������� ������������ � ������������ �
    --    ��������� ��������������
    --
    --
    procedure set_context_ex(
                  p_branch in varchar2 default null)
    is
    --
    l_secalarm     params.val%type;     -- ������� ����������� ������� ������
    l_kf           banks.mfo%type;      -- ��� �������
    l_mfop         params.val%type;     -- ��� ��� ����. ������
    l_mfog         params.val%type;     -- ��� ��� ��. �����
    l_bankdate     params.val%type;     -- ���������� ����
    l_clientid     varchar2(64);       -- ���������� ������������� ������
    --
    begin

        -- ��������� ����� �������������� �� ������ ������������
        if (    sys_context(CONTEXT_CTX, CTXPAR_USERBRANCH) is not null
            and sys_context(CONTEXT_CTX, CTXPAR_USERBRANCH) = p_branch  ) then return; -- ���� �������, �������
        end if;

        -- ������ ���������� ���������
        l_secalarm := branch_attribute_utl.get_value( p_branch_code => '/',   p_attribute_code => 'SECALARM') ;
        l_mfog     := branch_attribute_utl.get_value( p_branch_code => '/',   p_attribute_code => 'GLB-MFO') ;

         -- �������� ��� ������� �� ���� ���������
        l_kf := extract_mfo(p_branch);


        if (l_kf is not null) then
            -- ������ ��������� �������
            l_mfop     := branch_attribute_utl.get_value( p_branch_code => '/'||l_kf||'/',   p_attribute_code => 'MFOP') ; 
            l_bankdate := branch_attribute_utl.get_value( p_branch_code => '/'||l_kf||'/',   p_attribute_code => 'BANKDATE'); 
        end if;

        l_clientid := sys_context('userenv', 'client_identifier');

        -- ������������� �������� ��������� ���������
        sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_SECALARM,        l_secalarm,      client_id=> l_clientid);
        sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_MFO,             l_kf,            client_id=> l_clientid);
        sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_USERMFOP,        l_mfop,          client_id=> l_clientid);
        sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_GLOBAL_BANKDATE, l_bankdate,      client_id=> l_clientid);
        sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_USERBRANCH,      p_branch,        client_id=> l_clientid);
        sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_USERBRANCH_MASK, p_branch ||'%',  client_id=> l_clientid);
        sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_GLBMFO,          l_mfog,          client_id=> l_clientid);

        if (l_kf is not null) then
            sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_MFO,             l_kf,        client_id=> l_clientid);
            sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_USERMFO,         l_kf,        client_id=> l_clientid);
            sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_RFC,             l_kf,        client_id=> l_clientid);
            sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_USERMFO_MASK,    '/' || l_kf || '/%', client_id=> l_clientid);
            sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_USERMFOP,        l_mfop,      client_id=> l_clientid);
            sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_GLOBAL_BANKDATE, l_bankdate,  client_id=> l_clientid);
        else
            sys.dbms_session.clear_context(CONTEXT_CTX, attribute=>CTXPAR_MFO,             client_id=> l_clientid);
            sys.dbms_session.clear_context(CONTEXT_CTX, attribute=>CTXPAR_USERMFO,         client_id=> l_clientid);
            sys.dbms_session.set_context  (CONTEXT_CTX, CTXPAR_RFC,           ROOT_MFO,    client_id=> l_clientid);
            sys.dbms_session.clear_context(CONTEXT_CTX, attribute=>CTXPAR_USERMFO_MASK,    client_id=> l_clientid);
            sys.dbms_session.clear_context(CONTEXT_CTX, attribute=>CTXPAR_USERMFOP,        client_id=> l_clientid);
            sys.dbms_session.clear_context(CONTEXT_CTX, attribute=>CTXPAR_GLOBAL_BANKDATE, client_id=> l_clientid);
        end if;



    end set_context_ex;


    -----------------------------------------------------------------
    -- CLEAR_SESSION_CONTEXT()
    --
    --    ������� ����������������� ���������
    --
    --
    procedure clear_session_context
    is
    begin
        sys.dbms_session.clear_context(CONTEXT_CTX, client_id=>sys_context('userenv', 'client_identifier'));
    end clear_session_context;


    -----------------------------------------------------------------
    -- RELOAD_CONTEXT()
    --
    --    ����������������� ����������������� ���������
    --
    --
    procedure reload_context
    is
    begin
        for c in (select client_id from user_login_sessions)
        loop
            sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_LASTCALL, null, client_id=>c.client_id);
        end loop;
    end reload_context;


    -----------------------------------------------------------------
    -- SET_POLICY_GROUP_EX()
    --
    --     ��������� ������������� �������� ������ �������
    --     �� ������������ ������������ ��������� � ���������
    --     ������ �� �������� !!!
    --
    procedure set_policy_group_ex(
                  p_policy_group in varchar2)
    is
    l_policy_group   varchar2(30);
    begin
        -- ��������� ������������� ����� ������ �������
        begin
            select policy_group into l_policy_group
              from policy_groups
             where policy_group = p_policy_group;
        exception
            when NO_DATA_FOUND then
                raise_application_error(-20000, '������������ ������ �������: ' || p_policy_group);
        end;

        -- ������������� �������� ������ �������
        sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_POLGRP, p_policy_group, client_id=> sys_context('userenv', 'client_identifier'));

    end set_policy_group_ex;


    -----------------------------------------------------------------
    -- SET_POLICY_GROUP()
    --
    --     ��������� ������������� �������� ������ �������
    --     (� �������� ������ �� ���������� �����)
    --
    procedure set_policy_group(
                  p_policy_group in varchar2)
    is
    l_policy_group   varchar2(30);
    begin
        -- ����� ������ ������� �� ���������� ����� ��������
        if (lower(get_caller_name) = 'anonymous block') then
            raise_application_error(-20000, '��������� �������� ������ ������� �� ���������� ����� ���������');
        end if;

        -- ������������� �������� ������
        set_policy_group_ex(p_policy_group);

    end set_policy_group;




    -----------------------------------------------------------------
    -- SET_CONTEXT()
    --
    --    ��������� �������������� ��������� ������������
    --
    --
    procedure set_context
    is
    --
    l_branch            staff$base.branch%type;         -- ��� ��������� ������������
    l_staff_branch      staff$base.branch%type;         -- ��� ��������� ������������
    l_selected_branch   staff$base.branch%type;         -- ��������� ��� ���������
    l_current_branch    staff$base.current_branch%type; -- ������� �����
    l_reinit            boolean;                        -- ������� ������������� �����������������
    l_polgrp            staff$base.policy_group%type;   -- ������ ������� ������������
    --
    -- ������������� ������ ���
    l_old_mfo        varchar2(6) := nvl(sys_context(CONTEXT_CTX, CTXPAR_USERMFO), ROOT_MFO);
    -- ���, ������� ���� ����������
    l_new_mfo           varchar2(6);
    --
    l_sec_clear        boolean := false; -- ������� �������� ����� ������� � ������ ?
    --
    begin

        -- �������� ��������� ������������

        select branch
               ,current_branch
               ,policy_group
          into l_staff_branch
               ,l_current_branch
               ,l_polgrp
          from staff$base
         where id = sys_context(GLOBAL_CTX, CTXPAR_USERID);

        l_branch := l_staff_branch;

        -- set_context() ������ �� �� select_branch() ?
        if not nvl(is_select_branch_call,false)
        then
            -- ����� ������������ ������ ���� �� ��������� ��������� ��� ������ ?
            l_selected_branch := sys_context(CONTEXT_CTX, CTXPAR_SELECTED_BRANCH);
            --
            if l_selected_branch is not null then
                l_branch := l_selected_branch;
            else
                -- ����������� ������� ����� �� staff
                -- ҳ���� ��� / ������������
                if l_current_branch is not null and l_staff_branch = '/'
                then
                       l_branch := l_current_branch;
                end if;
            end if;
        end if;


      if l_branch = l_staff_branch
      then
          -- ������������� ������ ������� ������������
          set_policy_group_ex(l_polgrp);
      else
          if l_branch='/'
          then
              set_policy_group_ex(GROUP_WHOLE); -- ��� ����� ������ ������� WHOLE
          else
              set_policy_group_ex(g_polgrpdef); -- ������������� �������������
          end if;
      end if;

      --
      -- ��������� ������������� ��� ���������, ���� ��
      -- ������� �� ����, ������� ����� ����������, ��
      -- ���������� ����������������� ������ gl
      --
      if (    sys_context(CONTEXT_CTX, CTXPAR_USERBRANCH) is null
          or  sys_context(CONTEXT_CTX, CTXPAR_USERBRANCH) != l_branch )
      then
          l_reinit := true;
      end if;

      -- ���, ������� �� ������ ����������
      l_new_mfo := nvl(extract_mfo(l_branch), ROOT_MFO);
      --
      if l_old_mfo<>l_new_mfo
      then
          l_sec_clear := true;
      end if;


      set_context_ex(l_branch);

      -- ��������� ����������������� �������
      if (l_reinit)
      then
          gl.param;
          sec.reinit;
      end if;
      -- ��� ������������ ��� ������� �������� BARS_SEC � ������� ������� � ������
      if l_sec_clear
      then
          sec.clear_session_context();
      end if;

      -- ������ ��� �������������
      sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_CSCHEMA, sys_context(GLOBAL_CTX, CTXPAR_APPSCHEMA), client_id=> sys_context('userenv', 'client_identifier'));

      -- ������ ����
      sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_LASTCALL, to_char(sysdate, 'dd.mm.yyyy hh24:mi:ss'), client_id=> sys_context('userenv', 'client_identifier'));

    end set_context;


    -----------------------------------------------------------------
    -- CHECK_USER_PRIVS()
    --
    --     ������� �������� ���� ������������
    --
    --
    function check_user_privs return boolean
    is
    begin
        return true;
    end check_user_privs;




    -----------------------------------------------------------------
    -- EXTRACT_MFO()
    --
    --     ������� ��� ��������� ���� ��� �� ���� ���������
    --
    --
    --
    function extract_mfo(
        p_branch in varchar2 default null)
    return varchar2
    is
        l_branch varchar2(30 char) default p_branch;
    begin
        if (l_branch is null) then
            l_branch := current_branch_code();
        end if;

        return regexp_substr(l_branch, '\d{6}');
    end;

    -----------------------------------------------------------------
    --     ������� ��� ��������� ���� RFC(Root/Filial Code) �� ���� ���������
    function extract_rfc(
        p_branch in varchar2 default null) return varchar2
    is
    begin
        return nvl(extract_mfo(p_branch), ROOT_MFO);
    end extract_rfc;

    -----------------------------------------------------------------
    --     ������� ��� ��������� ���� ������������� ���������
    function get_parent_branch(
        p_branch in varchar2 default null) return varchar2
    is
        l_branch branch.branch%type;
    begin
        l_branch := p_branch;

        if (l_branch is null) then
            l_branch := current_branch_code();
        end if;

        return substr(l_branch, 1, instr(l_branch, '/', -2));
    end get_parent_branch;


    -----------------------------------------------------------------
    -- IS_PARENT_BRANCH()
    --
    --     ������� ��������� �������� �� ���������� ��� ���������
    --     (������ ��������) ����� �� ������������ ��������� ��
    --     ��������� � �������� ��������� ������������.
    --
    --     ���������:
    --
    --         p_branch   ��� ���������
    --
    --         p_level    �������
    --                        0 - �������� ���������� �����������
    --                            ���� ��������� � ��������������
    --                            ���� ��������� � ������������
    --                        <n> ���������� ������� �����
    --
    --     ������� ���������� �������� "1", ���� ���������� ���
    --     ��������� �������� ������������, ����� �������� "0"
    --
    function is_parent_branch(
                 p_branch in varchar2,
                 p_level  in number  default 0) return number
    is
    l_pbr       branch.branch%type;   -- ��� �������� ���������
    l_isparent  boolean := false;     -- ������� ���������
    --
    begin

        l_pbr := sys_context('bars_context', 'user_branch');

        -- ������������ ��� �������� ������
        if (p_level = 0) then
            if (p_branch = l_pbr) then return 1;
            else return 0;
            end if;
        end if;

        -- �������� ��� ��������� ������������� ������ �� p_level
        for i in 0..p_level
        loop
            if (p_branch = l_pbr) then l_isparent := true;
            end if;
            l_pbr := substr(l_pbr, 1, greatest(instr(l_pbr, '/', -2), 1));
        end loop;

        if (l_isparent) then return 1;
        else                 return 0;
        end if;

    end is_parent_branch;


    -----------------------------------------------------------------
    -- IS_PBRANCH()
    --
    --     ������� ������� is_parent_branch()
    --
    function is_pbranch(
                 p_branch in varchar2,
                 p_level  in number  default 0) return number
    is
    begin
        return is_parent_branch(p_branch, p_level);
    end is_pbranch;


    -----------------------------------------------------------------
    -- IS_MFO()
    --
    --     ������� ���������� �������� �� BRANCH ����������
    --     ����������� (���������� �������� 0/1)
    --
    --
    function is_mfo(
        p_branch in varchar2 default null)
    return number
    is
        l_branch branch.branch%type;
    begin
        l_branch := p_branch;

        if (l_branch is null) then
            l_branch := current_branch_code();
        end if;

        if (l_branch like '/______/') then return 1;
        else return 0;
        end if;

    end is_mfo;


    -----------------------------------------------------------------
    -- MAKE_BRANCH()
    --
    --     ������� ���������� ��� ��������� �� ���
    --
    --
    --
    function make_branch(
        p_mfo in varchar2) return varchar2
    is
    begin
        return '/' || p_mfo || '/';
    end make_branch;


    -----------------------------------------------------------------
    -- MAKE_BRANCH_MASK()
    --
    --     ������� ���������� ����� ��������� �� ���
    --
    --
    --
    function make_branch_mask(
        p_mfo in varchar2) return varchar2
    is
    begin
        return '/' || p_mfo || '/%';
    end make_branch_mask;

    -----------------------------------------------------------------
    -- SUBST_BRANCH()
    --
    --     ��������� ������������� ������������ ������ ��������������
    --     @p_branch - ��� �������������
    --     @p_policy_group - ������ �������
    --     (���� ������, �� ����� ��������� � ���������� ����� ��������)
    --
    procedure subst_branch(
                  p_branch       in varchar2
                 ,p_policy_group in varchar2 default null
                           )
    is
    --
    l_dummy        number;              -- �����
    l_branch       staff.branch%type;   -- ��� ������������� ������������
    --
    -- ������������� ������ ���
    l_old_mfo        varchar2(6) := nvl(sys_context(CONTEXT_CTX, CTXPAR_USERMFO), ROOT_MFO);
    -- ���, ������� ���� ����������
    l_new_mfo           varchar2(6);
    --
    l_sec_clear        boolean := false; -- ������� �������� ����� ������� � ������ ?
    --

    begin

        -- ��������� ������������� ������������� � ����������� �������������
        begin
            select 1 into l_dummy
              from branch
             where branch = p_branch;
        exception
            when NO_DATA_FOUND then
                raise_application_error(-20000, '��������������� ������������� ' || p_branch || ' �� ���������� � ����������� �������������');
        end;

        -- �������������� � �������������� �������
        set_context;

        -- ������������� ������ �������
        if (p_policy_group is not null)
        then
            set_policy_group(p_policy_group);  -- ������������� � ��������� ������
        else
            if p_branch='/'
            then
                set_policy_group_ex(GROUP_WHOLE); -- ��� ����� ������ ������� WHOLE
            else
                set_policy_group_ex(g_polgrpdef); -- ������������� �������������
            end if;
        end if;

        -- �������� ������������� ��������� ������������
        l_branch := sys_context(CONTEXT_CTX, CTXPAR_USERBRANCH);

            --
            -- ���� ������������ �� ����� ����� ������������� ������� ��������������
            -- �.�. �������� ������������� �� �������� ��� �������� ��� ��������, ��
            -- ����������� �����. ���������
            -- �������� ������������ �� ����������� ������ �� ������������� V_BR_ACCESS
            begin
                select 1 into l_dummy
                  from v_branch_access
                 where branch = p_branch;
            exception
                when NO_DATA_FOUND then
                    raise_application_error(-20000, '������������ ' || sys_context(GLOBAL_CTX, CTXPAR_USERNAME) || ' �� ����� ����� �������������� �������������� ' || p_branch);
            end;


        -- ���, ������� �� ������ ����������
        l_new_mfo := nvl(extract_mfo(p_branch), ROOT_MFO);
        --
        if l_old_mfo<>l_new_mfo
        then
            l_sec_clear := true;
        end if;

    -- ������������� �������� ���������
        set_context_ex(p_branch);

        -- ��������� �������������� ����������������� ������� GL, SEC
        gl.param;
        sec.reinit;
        -- ��� ������������ ��� ������� �������� BARS_SEC � ������� ������� � ������
        if l_sec_clear
        then
            sec.clear_session_context();
        end if;
    end subst_branch;


    -----------------------------------------------------------------
    -- SUBST_MFO()
    --
    --     ��������� ������������� ������������ ������ MFO
    --
    --
    procedure subst_mfo(
                  p_mfo  in  varchar2 )
    is
    begin
        subst_branch('/' || p_mfo || '/');
    end subst_mfo;

    -----------------------------------------------------------------
    -- save_current_branch()
    --
    --    ��������� ��������� ����� � staff
    --
    --
    procedure save_current_branch(p_branch in varchar2)
    is
        pragma autonomous_transaction;
        l_uid  staff$base.id%type := sys_context(GLOBAL_CTX, CTXPAR_USERID);
    begin
        select id
          into l_uid
          from staff$base
         where id = l_uid
           for update nowait;
        --
        update staff$base
           set current_branch = p_branch
         where id = l_uid;
        --
        commit;
        --
    exception
        when RESOURCE_BUSY then
            raise_application_error(-20000, '���������� ������������� ������ ������������ ID='||l_uid);
    end save_current_branch;

    -----------------------------------------------------------------
    -- SELECT_BRANCH()
    --
    --    ����� ������ �� ��������� ���������
    --
    --
    procedure select_branch(p_branch in varchar2)
    is
        l_errmsg varchar2(4000);
        l_branch long := trim(p_branch);
    begin
        is_select_branch_call := true;
    -- ������ ������� selected_branch, ��� ����� ������ ������� ���������� ����� �������
        sys.dbms_session.clear_context(CONTEXT_CTX, sys_context('userenv', 'client_identifier'), CTXPAR_SELECTED_BRANCH);
        -- �������������� ��������� ����������, ����� ������, �������� �� ��� ���
        subst_branch(l_branch);
        -- ������������� ������������ ��������� ���������
        sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_SELECTED_BRANCH, l_branch, client_id => sys_context('userenv', 'client_identifier'));
        -- ��������� ��������� ����� � staff
        save_current_branch(l_branch);
        -- ������ ������ � ������, �.�. ��� ������ ��������
        bars_audit.info('������� �������� '||l_branch);
        --
        is_select_branch_call := false;
    exception
        when others then
            --
            is_select_branch_call := false;
            --
            raise_application_error(-20000, dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace());
            --
    end select_branch;

    -----------------------------------------------------------------
    -- SET_CSCHEMA()
    --
    --    ��������� ������� ����� ���������������� ������
    --
    --
    procedure set_cschema(
                  p_cschema varchar2 )
    is
    begin
        bars_login.change_user_appschema(p_cschema);

        -- ������ ��� �������������
        sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_CSCHEMA, sys_context(GLOBAL_CTX, CTXPAR_APPSCHEMA));

    end set_cschema;


    -----------------------------------------------------------------
    -- INIT()
    --
    --    ������������� ��������� ������
    --
    --
    procedure init
    is
    l_tabname    varchar2(30);  -- ��� ������� �������
    l_defvalue   long;          -- ������������� ��������
    l_deflen     number;        -- ����� �������������� ��������
    l_polgrp     varchar2(30);  -- ������������� ��������
    begin

        if (sys_context(CONTEXT_CTX, CTXPAR_POLGRPDEF) is null) then

            -- ���������� ������� ������� �������� �������
            begin
                select table_name into l_tabname
                  from user_tables
                 where table_name = 'POLICY_TABLE';
            exception
                when NO_DATA_FOUND then l_tabname := 'POLICY_TABLE_LT';  -- ������� ����������
            end;

            -- �������� ������������� �������� ���� POLICY_GROUP
            begin
                select data_default, default_length into l_defvalue, l_deflen
                  from user_tab_columns
                 where table_name  = l_tabname
                   and column_name = 'POLICY_GROUP';
                l_polgrp := trim(replace(substr(l_defvalue, 1, l_deflen),''''));
            exception
                when NO_DATA_FOUND then l_polgrp := 'WHOLE';
            end;

            -- ��������� �������� � ��������� � ������������� ����������
            sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_POLGRPDEF, l_polgrp, client_id=> sys_context('userenv', 'client_identifier'));
            g_polgrpdef := l_polgrp;
        else
            g_polgrpdef := sys_context(CONTEXT_CTX, CTXPAR_POLGRPDEF);
        end if;

    end init;


    -----------------------------------------------------------------
    -- HEADER_VERSION()
    --
    --     ������� ���������� ������ � ������� ��������� ������
    --
    --
    --
    function header_version return varchar2
    is
    begin
        return 'package header BARS_CONTEXT ' || VERSION_HEADER || chr(10) ||
               'package header definition(s):' || chr(10) || VERSION_HEADER_DEFS;
    end header_version;

    -----------------------------------------------------------------
    -- BODY_VERSION()
    --
    --     ������� ���������� ������ � ������� ���� ������
    --
    --
    --
    function body_version return varchar2
    is
    begin
        return 'package body BARS_CONTEXT ' || VERSION_BODY || chr(10) ||
               'package body definition(s):' || chr(10) || VERSION_BODY_DEFS;
    end body_version;

    -----------------------------------------------------------------
    -- GO()
    --
    --     ��������� ������������� ������������ ������ ��������������
    --     @p_branch - ��� ������������� ��� ��� ���
    --     �-�,
    --     bc.go('/'); -- ����� � �������� �����
    --     bc.go('303398'); -- ����� � ���, �� ��, ��� � �����
    --     bc.go('/303398/');
    --     bc.go('/303398/000120/060120/'); - ����� � ����� /303398/000120/060120/
    --
    procedure go(p_branch in varchar2)
    is
    begin
    if regexp_like(p_branch, '^\d{6}$')
        then
        subst_branch('/'||p_branch||'/');
        else
        subst_branch(p_branch);
        end if;
    end go;

    -----------------------------------------------------------------
    -- HOME()
    --
    --    ������������ ����� � ���� �����
    --
    --
    procedure home
    is
    begin
        bc.set_context;
    end home;

begin
    init;
end bars_context;
/

 show err;
 
PROMPT *** Create  grants  BARS_CONTEXT ***
grant EXECUTE                                                                on BARS_CONTEXT    to ABS_ADMIN;
grant EXECUTE                                                                on BARS_CONTEXT    to BARSAQ with grant option;
grant EXECUTE                                                                on BARS_CONTEXT    to BARSAQ_ADM with grant option;
grant EXECUTE                                                                on BARS_CONTEXT    to BARSUPL;
grant EXECUTE                                                                on BARS_CONTEXT    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_CONTEXT    to BARS_CONNECT;
grant DEBUG,EXECUTE                                                          on BARS_CONTEXT    to BARS_DM;
grant EXECUTE                                                                on BARS_CONTEXT    to FINMON;
grant EXECUTE                                                                on BARS_CONTEXT    to JBOSS_USR;
grant EXECUTE                                                                on BARS_CONTEXT    to KLBX;
grant EXECUTE                                                                on BARS_CONTEXT    to PFU;
grant EXECUTE                                                                on BARS_CONTEXT    to RPBN001;
grant EXECUTE                                                                on BARS_CONTEXT    to RPBN002;
grant EXECUTE                                                                on BARS_CONTEXT    to TEST;
grant EXECUTE                                                                on BARS_CONTEXT    to WR_ALL_RIGHTS;
grant EXECUTE                                                                on BARS_CONTEXT    to BARS_INTGR;
