
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/abs_utils.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.ABS_UTILS is

   --------------------------------------------------------------
   --
   --  ����������: ����� ��������� ������� ������������ � ���
   --
   --------------------------------------------------------------



   G_HEADER_VERSION       constant varchar2(64)  := 'version 4.0 10.04.2015';




   -----------------------------------------------------------------
   -- HEADER_VERSION()
   --
   --     ������� ��������� ������ ��������� ������
   --
   --
   --
   function header_version return varchar2;


   -----------------------------------------------------------------
   -- BODY_VERSION()
   --
   --     ������� ��������� ������ ���� ������
   --
   --
   --
   function body_version return varchar2;


  --------------------------------------------------------------
  --
  --  CREATE_BARS_ROLE
  --
  --    �������� ���� + ���������� � roles$base
  --    (������������� ��, ��� ������� roles$base  ����)
  --
  --    p_rolename - ��� ����
  --
  --
  procedure create_bars_role(p_rolename  varchar2);



  --------------------------------------------------------------
  --
  --  SET_TAB_POLICY
  --
  --    ���������� ������� � policy_table
  --
  --    p_tabname - ��� �������
  --
  --    p_group   - ������ ������� ('WHOLE', 'FILIAL')
  --
  --    p_owner   - �������� �������
  --
  procedure set_tab_policy(
                  p_tabname   varchar2,
                  p_group     varchar2,
                  p_owner     varchar2  default 'BARS');

   --------------------------------------------------------------
   --
   --  GET_NEXT_ZAPROS_PKEY()
   --
   --    ������� ����������� ����� ����������� ����� ��� �����
   --
   --
   function get_next_zapros_pkey return varchar2;



   --------------------------------------------------------------
   --
   --  ADD_FUNC
   --
   --    ���������� ������� � operlist
   --
   --    p_name       -  �������� �������
   --    p_funcname   -  ��� ���������� �������
   --    p_rolename   -  ��� ���� ��� �������
   --    p_usearc     -  ������������ � ������
   --    p_frontend   -  ��������� � ������� �������� �-���
   --    p_forceupd   -  ���� ����� ������� ��� ����
   --                    (������ ����� �� ����� �-���), �������� ��� ���������
   --    p_forcerole  -  ���� ����� ���� ���� ��� ���� ���� ������, �����, �������
   --                    ����� ���� � ���������� ����
   --                    ������������� ���� ����� ����� ��� ������������.
   --
   --    return       -  ����� �����
   --
   function add_func(
                   p_name        operlist.name%type,
                   p_funcname    operlist.funcname%type,
                   p_rolename    operlist.rolename%type,
                   p_usearc      smallint  default 0,
                   p_frontend    smallint  default 0,
                   p_forceupd    smallint  default 1,
                   p_forcerole   smallint  default 1,
                   p_runnable    smallint  default 1)
    return number;


   --------------------------------------------------------------
   --
   --  ADD_FUNC
   --
   --    ���������� ������� � operlist
   --
   --    p_name       -  �������� �������
   --    p_funcname   -  ��� ���������� �������
   --    p_rolename   -  ��� ���� ��� �������
   --    p_usearc     -  ������������ � ������
   --    p_frontend   -  ��������� � ������� �������� �-���
   --    p_forceupd   -  ���� ����� ������� ��� ����
   --                    (������ ����� �� ����� �-���), �������� ��� ���������
   --    p_forcerole  -  ���� ����� ���� ���� ��� ���� ���� ������, �����, �������
   --                    ����� ���� � ���������� ����
   --                    ������������� ���� ����� ����� ��� ������������.
   --
   --
   procedure add_func(
                   p_name        operlist.name%type,
                   p_funcname    operlist.funcname%type,
                   p_rolename    operlist.rolename%type,
                   p_usearc      smallint  default 0,
                   p_frontend    smallint  default 0,
                   p_forceupd    smallint  default 1,
                   p_forcerole   smallint  default 1,
                   p_runnable    smallint  default 1);


  --------------------------------------------------------------
  --
  --  ADD_OPLIST_DEPS
  --
  --    ���������� ������� � ������� �������� ������� operlist_deps
  --
  --    p_id_parent  -  ��. ������������ �������
  --    p_id_child   -  ��. �������� �������
  --
  procedure add_oplist_deps(p_id_parent operlist_deps.id_parent%type,
                            p_id_child  operlist_deps.id_child%type);


   --------------------------------------------------------------
   --
   --  CORRECT_REFERENCES
   --
   --    ������� ���� ��� ���� ������������, � ������� �� ���, ������ ������
   --
   --    p_tabname    - ��� ������� �� meta_tables (��� % - ��� ����)
   --    p_createrole - ���� ��������� ���� ��� ����������� �� ����������
   --                   = 1 - ������� ���� � ������ �� ������
   --                   = 0 - �� ��������� ����, ������ �� ��������
   --
   procedure  correct_references(
                  p_tabname     varchar2  default '%',
                  p_createrole  smallint  default 1 );



   --------------------------------------------------------------
   --
   --  CORRECT_SYNONYMS()
   --
   --    ������� �������� ��� ���� �������� �����
   --    ������� ����� �������� ����������� � ������
   --
   --
   procedure correct_synonyms;






   --------------------------------------------------------------
   --
   --  GRANT_FUNC_PRIVS()
   --
   --   ������ ������� ������������� �� �������
   --
   --   p_codeapp    - ��� ���-�, ���� �� ��������� - ������ ��� ���� ���-��
   --   p_funcid     - ��� �������
   --   p_createrole - ���� ��������� ���� ��� ����������� �� ����������
   --                  = 1 - ������� ���� � ������ �� ������
   --                  = 0 - �� ��������� ����, ������ �� ��������
   --
   procedure grant_func_privs(
                  p_codeapp     applist.codeapp%type   default '%',
                  p_funcid      varchar2               default '%',
                  p_createrole  smallint               default 1 );



   --------------------------------------------------------------
   --
   --  GRANT_REF_PRIVS()
   --
   --   ������ ������� ������������� �� �����������
   --
   --   p_codeapp    - ��� ���-�, ���� �� ��������� - ������ ��� ���� ���-��
   --   p_refname    - ���  �����������(��� �� meta_tables), ���� �� ������� - ��� ����
   --   p_createrole - ���� ��������� ���� ��� ����������� �� ����������
   --                  = 1 - ������� ���� � ������ �� ������
   --                  = 0 - �� ��������� ����, ������ �� ��������
   --
   procedure  grant_ref_privs(
                  p_codeapp     applist.codeapp%type       default '%',
                  p_refname     meta_tables.tabname%type   default '%',
                  p_createrole  smallint                   default 1 );




   --------------------------------------------------------------
   --
   --  GRANT_ALL_PRIVS()
   --
   --   ������ ���� ������� ��� ���-�
   --
   procedure grant_all_privs(p_codeapp  varchar2 default '%');




   --------------------------------------------------------------
   --
   --  ADD_FUNCLIST_START()
   --
   --
   --   ���������� �-���  ������� ����� �� ������ ���
   --
   --   p_codeoper   - ��� �-��� �� operlist
   --   p_checked    - 1 - ������� ��-���������, 0 -�� �������
   --   p_position   - ������� (�� �����. �����, ������ ���������)
   --
   --
   procedure add_funclist_start(
                  p_codeoper    number,
                  p_checked     smallint,
                  p_position    smallint default null);




   --------------------------------------------------------------
   --
   --  ADD_FUNCLIST_FINISH()
   --
   --
   --   ���������� �-���  ������� ����� �� ������ ���
   --
   --   p_codeoper   - ��� �-��� �� operlist
   --   p_checked    - 1 - ������� ��-���������, 0 -�� �������
   --   p_position   - ������� (�� �����. �����, ������ ���������)
   --
   --
   procedure add_funclist_finish(
                  p_codeoper    number,
                  p_checked     smallint,
                  p_position    smallint default null);


  --------------------------------------------------------------
  --
  --   ������ �����
  --
  --------------------------------------------------------------


  function add_reference(table_name VARCHAR2, role_name VARCHAR2,
                         sem VARCHAR2,
                         dlg_name VARCHAR2 DEFAULT NULL) RETURN NUMBER;


  function add_function(
                  func_name VARCHAR2,
                  role_name VARCHAR2,
                  sem VARCHAR2,
                  full_name VARCHAR2 DEFAULT NULL) RETURN NUMBER;




  --------------------------------------------------------------
  --
  --    NEW_FUNC_ID
  --
  --    ����� ����� ����� ��� ������� (�������� ������ ������)
  --
  --    p_bankcode     - 3-� �������  ��� ������
  --    p_bankname     - ������������ ������
  --    p_force        - ���� ����������  - �������� �� �����
  --
  function new_func_id return  number;



  --------------------------------------------------------------
  --
  --  ADD_FUNC_CNT
  --
  --    ���������� ������� � operlist (��� ������� - ��� deafult)
  --
  --    p_name       -  �������� �������
  --    p_funcname   -  ��� ���������� �������
  --    p_rolename   -  ��� ���� ��� �������
  --
  procedure add_func_cnt(p_name          operlist.name%type,
                         p_funcname      operlist.funcname%type,
                         p_rolename      operlist.rolename%type,
                         p_funcid    out number );


   --------------------------------------------------------------
   --
   --  ADD_FUNCLIST_CNT()
   --
   --   ���������� �-���  ������� ����� ��� �������
   --   p_codeoper   - ��� �-��� �� operlist
   --   p_type       - 1 - ����� ���, 0- �����
   --   p_checked    - 1 - ������� ��-���������, 0 -�� �������
   --
   procedure add_funclist_cnt(
                  p_codeoper    number,
                  p_type        number,
                  p_checked     number);


   --------------------------------------------------------------
   --
   --  ADD_DOC_OPFIELD
   --
   --    �������� ����� ���� �������� ���������
   --
   --    p_tag         - ��� ��� ���������
   --    p_descript    - ��������
   --    p_format      - ������
   --    p_browser     - ������� ����������� ����� �������� ������� ��������� � ���� TagBrowse("SELECT kod,txt FROM sp_70_2")
   --    p_editable    - ������������� ��� ���
   --    p_vspo_char   - ������� ���. ���������, ��� ���. ��������� � ���
   --    p_check_func  - ������� �������� ����������� �����  � ���� C_TAG(#(TAG),#(VAL))
   --    p_def_value   - ������������� �������� � ���� select :RNK from dual
   --    p_datatype    - ��� ������ �� ����������� meta_coltypes
   --    p_usearch     - ������� �������� ��� ��������� � �������� ����� (1-��/0-���)
   --    p_force       - ���� ����������  - �������� �� �����
   --
   --
   procedure add_doc_opfield( p_tag        varchar2              ,
                              p_descript   varchar2              ,
                              p_format     varchar2  default null,
                              p_browser    varchar2  default null,
                              p_editable   smallint  default    0,
                              p_vspo_char  varchar2  default null,
                              p_check_func varchar2  default null,
                              p_def_value  varchar2  default null,
                              p_datatype   varchar2              ,
                              p_usearch    smallint              ,
                              p_force      smallint  default 1);


  --------------------------------------------------------------
  --
  --  ADD_ACC_OPFIELD
  --
  --    �������� ����� ���. �������� �����
  --
  --    p_tag         - ��� ��� ���������
  --    p_descript    - ��������
  --    p_usearch     - ������� �������� ��� ��������� � �������� ����� (1-��/0-���)
  --    p_force       - ���� ����������  - �������� �� �����
  --
  --
  procedure add_acc_opfield( p_tag        varchar2              ,
                             p_descript   varchar2              ,
                             p_usearch    smallint              ,
                             p_force      smallint  default 1);


  --------------------------------------------------------------
  --
  --  add_func2arm
  --
  --  �������� ������� � ���
  --
  procedure add_func2arm(p_codeoper operlist.codeoper%type, p_codeapp applist.codeapp%type) ;
  --------------------------------------------------------------
  --
  --  add_func2deps
  --
  --
 procedure add_func2deps(p_idpar in number, p_idchild in number);
  --------------------------------------------------------------
  --
  --  add_arm
  --
  --  ������ ����� ���
  --
 procedure add_arm(p_arm_code varchar2, p_arm_desc varchar2, p_frontend number default 1);


END ABS_UTILS;
/
CREATE OR REPLACE PACKAGE BODY BARS.ABS_UTILS as

  --------------------------------------------------------------
  --
  --  ����������: ����� ��������� ������� ������������ � ���
  -- ����� ������������� �� ������ �������. ��������� �������� ������� ������� ���� ������

  --
  --
  --------------------------------------------------------------


  G_BODY_VERSION    constant varchar2(64)  := 'version 5.1 29.09.2016';
  G_TRACE           constant varchar2(100) := 'abs_utils.';
  G_MODULE          constant varchar2(5)   := 'ADM';
  G_AWK_BODY        constant varchar2(512) := '';


  -----------------------------------------------------------------
  -- HEADER_VERSION()
  --
  --     ������� ��������� ������ ��������� ������
  --
  --
  --
  function header_version return varchar2
  is
  begin
     return G_HEADER_VERSION;
  end;


  -----------------------------------------------------------------
  -- BODY_VERSION()
  --
  --     ������� ��������� ������ ���� ������
  --
  --
  --
  function body_version return varchar2
  is
  begin
     return G_BODY_VERSION;
  end;


  --------------------------------------------------------------
  --
  --  CREATE_BARS_ROLE (depricated)
  --
  --    �������� ���� + ���������� � roles$base
  --    (������������� ��, ��� ������� roles$base  ����)
  --
  --    p_rolename - ��� ����
  --
  procedure create_bars_role(p_rolename  varchar2)
  is
  begin


     null;


  end;


  --------------------------------------------------------------
  --
  --  SET_TAB_POLICY (depricated - use bars_policy_adm)
  --
  --    ���������� ������� � policy_table
  --
  --    p_tabname - ��� �������
  --
  --    p_group   - ������ ������� ('WHOLE', 'FILIAL')
  --
  --    p_owner   - �������� �������
  --
  procedure set_tab_policy(
                  p_tabname   varchar2,
                  p_group     varchar2,
                  p_owner     varchar2  default 'BARS')
  is
  begin
       null;
   end;


  --------------------------------------------------------------
  --
  --  GET_NEXT_ZAPROS_PKEY()  (depricated- moved to bars_report)
  --
  --    ������� ����������� ����� ����������� ����� ��� �����
  --
  --
  function get_next_zapros_pkey return varchar2
  is
  begin

     return bars_report.get_next_zapros_pkey;

  end;


  --------------------------------------------------------------
  --
  --  ADD_DOC_OPFIELD
  --
  --    �������� ����� ���. �������� ���������
  --
  --    p_tag         - ��� ��� ���������
  --    p_descript    - ��������
  --    p_format      - ������
  --    p_browser     - ������� ����������� ����� �������� ������� ��������� � ���� TagBrowse("SELECT kod,txt FROM sp_70_2")
  --    p_editable    - ������������� ��� ���
  --    p_vspo_char   - ������� ���. ���������, ��� ���. ��������� � ���
  --    p_check_func  - ������� �������� ����������� �����  � ���� C_TAG(#(TAG),#(VAL))
  --    p_def_value   - ������������� �������� � ���� select :RNK from dual
  --    p_datatype    - ��� ������ �� ����������� meta_coltypes
  --    p_usearch     - ������� �������� ��� ��������� � �������� ����� (1-��/0-���)
  --    p_force       - ���� ����������  - �������� �� �����
  --
  --
  procedure add_doc_opfield( p_tag        varchar2              ,
                             p_descript   varchar2              ,
                             p_format     varchar2  default null,
                             p_browser    varchar2  default null,
                             p_editable   smallint  default    0,
                             p_vspo_char  varchar2  default null,
                             p_check_func varchar2  default null,
                             p_def_value  varchar2  default null,
                             p_datatype   varchar2              ,
                             p_usearch    smallint              ,
                             p_force      smallint  default 1)
  is
     l_coltype meta_coltypes.coltype%type;
  begin
     begin
        select coltype into l_coltype
          from meta_coltypes where coltype = upper(p_datatype);
     exception when no_data_found then
        bars_error.raise_nerror(G_MODULE, 'NOT_CORRECT_PARAM_TYPE',p_datatype, p_tag);
     end;

     if p_editable not in (0,1) then
        bars_error.raise_nerror(G_MODULE, 'NOT_CORRECT_EDITABLE_VALUE', p_tag);
     end if;

     if p_usearch not in (0,1) then
        bars_error.raise_nerror(G_MODULE, 'NOT_CORRECT_ARCH_VALUE', p_tag);
     end if;

     if length(p_vspo_char) > 1 then
        bars_error.raise_nerror(G_MODULE, 'NOT_CORRECT_SEP_LEN', p_vspo_char);
     end if;

     if length(p_tag) > 5 then
        bars_error.raise_nerror(G_MODULE, 'NOT_CORRECT_FIELD_LEN', p_tag);
     end if;

     if length(p_browser) > 250 then
        bars_error.raise_nerror(G_MODULE, 'NOT_CORRECT_BROWSER_LEN', p_tag);
     end if;

     if length(p_check_func) > 250 then
        bars_error.raise_nerror(G_MODULE, 'NOT_CORRECT_CHKFUNC_LEN', p_tag);
     end if;

     begin
        insert into op_field(tag, name, fmt, browser, nomodify,
                             vspo_char, chkr, default_value, type, use_in_arch)
        values(p_tag, p_descript, p_format, p_browser, p_editable,
               p_vspo_char, p_check_func, p_def_value, upper(p_datatype), p_usearch);
     exception when dup_val_on_index then
        if p_force  = 1 then
           update op_field set
                  name          = p_descript  ,
                  fmt           = p_format    ,
                  browser       = p_browser   ,
                  nomodify      = p_editable  ,
                  vspo_char     = p_vspo_char ,
                  chkr          = p_check_func,
                  default_value = p_def_value ,
                  type          = p_datatype  ,
                  use_in_arch   = p_usearch
            where tag = p_tag;
        end if;
     end;

  end;



  --------------------------------------------------------------
  --
  --  ADD_ACC_OPFIELD
  --
  --    �������� ����� ���. �������� �����
  --
  --    p_tag         - ��� ��� ���������
  --    p_descript    - ��������
  --    p_usearch     - ������� �������� ��� ��������� � �������� ����� (1-��/0-���)
  --    p_force       - ���� ����������  - �������� �� �����
  --
  --
  procedure add_acc_opfield( p_tag        varchar2              ,
                             p_descript   varchar2              ,
                             p_usearch    smallint              ,
                             p_force      smallint  default 1)
  is
  begin

     begin
        insert into accounts_field(tag, name, use_in_arch)
        values(p_tag, p_descript,p_usearch);
     exception when dup_val_on_index then
        if p_force  = 1 then
           update accounts_field set
                  name          = p_descript  ,
                  use_in_arch   = p_usearch
            where tag = p_tag;
        end if;
     end;

  end;


  --------------------------------------------------------------
  --
  --  ADD_MODULE
  --
  --    ��������� ������
  --
  --    p_modcode     - 3-� �������  ��� ������
  --    p_modname     - ������������ ������
  --    p_modwidecode - ������������ ��� ������
  --    p_force        - ���� ����������  - �������� �� �����
  --
  --
  procedure add_module(
                  p_modcode     bars_supp_modules.mod_code%type,
                  p_modwidecode bars_supp_modules.mod_widecode%type  default null,
                  p_modname     bars_supp_modules.mod_name%type,
                  p_force       smallint                             default 1)
  is
  begin
     insert into bars_supp_modules(mod_code, mod_widecode, mod_name)
     values(p_modcode, p_modwidecode, p_modname);
  exception when dup_val_on_index then
     if  p_force =1 then
         update bars_supp_modules set mod_widecode = p_modwidecode, mod_name = p_modname
         where  mod_code = p_modcode;
     end if;
  end;


  --------------------------------------------------------------
  --
  --  ADD_BANK
  --
  --    ��������� ����
  --
  --    p_bankcode     - 3-� �������  ��� ������
  --    p_bankname     - ������������ ������
  --    p_force        - ���� ����������  - �������� �� �����
  --
  procedure add_bank(
                  p_bankcode    bars_supp_banks.bank_code%type,
                  p_bankname    bars_supp_banks.bank_name%type,
                  p_force       smallint                        default 1)
  is
  begin
     insert into bars_supp_banks(bank_code, bank_name)
     values(p_bankcode, p_bankname);
  exception when dup_val_on_index then
     if  p_force =1 then
         update bars_supp_banks set bank_name = p_bankname
         where  bank_code = p_bankcode;
     end if;
  end;


  --------------------------------------------------------------
  --
  --    NEW_FUNC_ID
  --
  --    ����� ����� ����� ��� ������� (�������� ������ ������)
  --
  --    p_bankcode     - 3-� �������  ��� ������
  --    p_bankname     - ������������ ������
  --    p_force        - ���� ����������  - �������� �� �����
  --
  function new_func_id return  number
  is
     l_newid number;
  begin
     select min(codeoper) + 1 into l_newid
     from operlist o1
     where not exists ( select codeoper from operlist
                        where codeoper=o1.codeoper + 1);
     return l_newid;
  exception when no_data_found then
     l_newid:=1;
  end;


  --------------------------------------------------------------
  --
  --  GRANT_FUNC_ROLE
  --
  --    ���� ������������� � ���� ���� ��������� �-���, ���������� �� ����
  --
  --    p_funcid     -  ����� �������
  --
  --
  procedure grant_func_role(p_funcid   operlist.codeoper%type)
  is
     l_rolename  operlist.rolename%type;
     l_grantsql  varchar2(1000);
  begin

     begin
        select rolename into l_rolename from operlist
        where codeoper = p_funcid;
     exception when no_data_found then
        bars_error.raise_error('SVC', 134, to_char(p_funcid));
     end;


     for c in (select unique codeapp from operapp where codeoper=p_funcid) loop

         for j in ( select unique logname
                    from applist_staff af, staff f
                    where codeapp=c.codeapp and af.id=f.id) loop

             l_grantsql:='grant '||l_rolename||' to '||j.logname;
             begin
                execute immediate l_grantsql;
             exception when others then
                bars_error.raise_error('SVC', 135, l_rolename, j.logname);
             end;
         end loop;

     end loop;

  end;


  --------------------------------------------------------------
  --
  --  ADD_FUNC
  --
  --    ���������� ������� � operlist
  --
  --    p_name       -  �������� �������
  --    p_funcname   -  ��� ���������� �������
  --    p_rolename   -  ��� ���� ��� �������
  --    p_usearc     -  ������������ � ������
  --    p_frontend   -  ��������� � ������� �������� �-���
  --    p_forceupd   -  ���� ����� ������� ��� ����
  --                    (������ ����� �� ����� �-���), �������� ��� ���������
  --    p_forcerole  -  ���� ����� ���� ���� ��� ���� ���� ������, �����, �������
  --                    ����� ���� � ���������� ����
  --                    ������������� ���� ����� ����� ��� ������������.
  --
  function add_func(p_name      operlist.name%type,
                    p_funcname  operlist.funcname%type,
                    p_rolename  operlist.rolename%type,
                    p_usearc    smallint default 0,
                    p_frontend  smallint default 0,
                    p_forceupd  smallint default 1,
                    p_forcerole smallint default 1,
                    p_runnable  smallint default 1) return number is
    l_funcid  number;
    l_oldrole operlist.rolename%type;
    l_exists  smallint;
  begin

    if (p_rolename is not null) then
      begin
        select 1
          into l_exists
          from dba_roles
         where role = upper(p_rolename);
      exception
        when no_data_found then
          bars_error.raise_error('SVC', 133, p_rolename);
      end;
    end if;

    begin
      select codeoper, rolename, 1
        into l_funcid, l_oldrole, l_exists
        from operlist
       where funcname like p_funcname;
    exception
      when no_data_found then
        l_exists := 0;
    end;

    -- ������� ����������
    if (l_exists = 1) then

      if (p_forceupd = 1) then
        update operlist
           set name     = p_name,
               rolename = upper(p_rolename),
               frontend = p_frontend,
               usearc   = p_usearc
         where codeoper = l_funcid;

        if (upper(l_oldrole) <> upper(p_rolename) and p_forcerole = 1) then
          grant_func_role(l_funcid);
        end if;
        dbms_output.put_line('�����i� �' || l_funcid || ' <' || p_name ||
                             '> - ���������');
      end if;

      -- ������� �� ����������
    else
      l_funcid := new_func_id;

      insert into operlist
        (codeoper,
         name,
         dlgname,
         funcname,
         semantic,
         runable,
         parentid,
         rolename,
         frontend,
         usearc)
      values
        (l_funcid,
         p_name,
         'N/A',
         p_funcname,
         p_rolename,
         p_runnable,
         null,
         p_rolename,
         p_frontend,
         p_usearc);
      dbms_output.put_line('�����i� �' || l_funcid || ' <' || p_name ||
                           '> - ���������');
    end if;

    return l_funcid;

  end;


  --------------------------------------------------------------
  --
  --  ADD_FUNC
  --
  --    ���������� ������� � operlist
  --
  --    p_name       -  �������� �������
  --    p_funcname   -  ��� ���������� �������
  --    p_rolename   -  ��� ���� ��� �������
  --    p_usearc     -  ������������ � ������
  --    p_frontend   -  ��������� � ������� �������� �-���
  --    p_forceupd   -  ���� ����� ������� ��� ����
  --                    (������ ����� �� ����� �-���), �������� ��� ���������
  --    p_forcerole  -  ���� ����� ���� ���� ��� ���� ���� ������, �����, �������
  --                    ����� ���� � ���������� ����
  --                    ������������� ���� ����� ����� ��� ������������.
  --
  procedure  add_func(
                  p_name        operlist.name%type,
                  p_funcname    operlist.funcname%type,
                  p_rolename    operlist.rolename%type,
                  p_usearc      smallint  default 0,
                  p_frontend    smallint  default 0,
                  p_forceupd    smallint  default 1,
                  p_forcerole   smallint  default 1,
                  p_runnable    smallint  default 1)
  is
     l_funcid   number;
  begin
     l_funcid := add_func(
                  p_name,
                  p_funcname,
                  p_rolename,
                  p_usearc  ,
                  p_frontend,
                  p_forceupd,
                  p_forcerole,
                  p_runnable);
  end;


  --------------------------------------------------------------
  --
  --  ADD_FUNC_CNT
  --
  --    ���������� ������� � operlist (��� ������� - ��� deafult)
  --
  --    p_name       -  �������� �������
  --    p_funcname   -  ��� ���������� �������
  --    p_rolename   -  ��� ���� ��� �������
  --
  procedure add_func_cnt(p_name          operlist.name%type,
                         p_funcname      operlist.funcname%type,
                         p_rolename      operlist.rolename%type,
                         p_funcid    out number )
  is
     l_funcid number;
  begin
     l_funcid:=  add_func(p_name      => p_name,
                     p_funcname  => p_funcname,
                     p_rolename  => p_rolename,
                     p_usearc    => 0,
                     p_frontend  => 0,
                     p_forceupd  => 1,
                     p_forcerole => 1,
                     p_runnable  => 1) ;

     p_funcid := l_funcid;
  end;


  --------------------------------------------------------------
  --
  --  ADD_OPLIST_DEPS
  --
  --    ���������� ������� � ������� �������� ������� operlist_deps
  --
  --    p_id_parent  -  ��. ������������ �������
  --    p_id_child   -  ��. �������� �������
  --
  procedure add_oplist_deps(p_id_parent operlist_deps.id_parent%type,
                            p_id_child  operlist_deps.id_child%type) is
  begin
     insert into operlist_deps  (id_parent, id_child)
     values (p_id_parent, p_id_child);
  exception  when dup_val_on_index then
     null;
  end add_oplist_deps;


  --------------------------------------------------------------
  --
  --  CREATE_ROLE()
  --
  --  �������� ����
  --
  function create_role(
                 p_rolename varchar2) return smallint
  is
     l_trace varchar2(1000):=G_TRACE||'create_role: ';
  begin
     /*
     execute immediate 'create role '||p_rolename;
     bars_audit.info(l_trace||' ���� '||p_rolename||' �������');
     return 0;
  exception when others then
     if sqlcode = -1921 then
        return 1;
     else
        bars_audit.error(l_trace||'���� '||p_rolename||'�� �������: '||sqlerrm);
        raise;
     end if;
     */
     null;
  end;


  --------------------------------------------------------------
  --
  --  GRANT_REF_TO_ROLE()
  --
  --  ������ ������ �� ���������� � ����
  --
  procedure grant_ref_to_role(
              p_rolename varchar2,
              p_tabname  meta_tables.tabname%type)
  is
     l_trace varchar2(1000) := G_TRACE||'grant_ref_to_role: ';
  begin
     execute immediate 'grant insert, update, delete on '||p_tabname||' to '||p_rolename;
  exception when others then
     bars_audit.error(l_trace||'������ ������ ������� �� ���� '||p_rolename||' ��� '||p_tabname);
     raise;
  end;


  --------------------------------------------------------------
  --
  --  CORRECT_REFERENCES
  --
  --    ������� ���� ��� ���� ������������, � ������� �� ���, ������ ������
  --
  --    p_tabname    - ��� ������� �� meta_tables (��� % - ��� ����)
  --    p_createrole - ���� ��������� ���� ��� ����������� �� ����������
  --                   = 1 - ������� ���� � ������ �� ������
  --                   = 0 - �� ��������� ����, ������ �� ��������
  --
  procedure  correct_references(
                 p_tabname     varchar2  default '%',
                 p_createrole  smallint  default 1 )
  is
     l_trace varchar2(1000):=G_TRACE||'correct_references: ';
     l_ret   number;
  begin

     -- ����� ����������� ��� ������� �� ���������� ������� ����, ������� ��� ����
     if p_createrole = 1 then
        for c in (
                   select role2edit, tabname
                   from meta_tables m, references r,
                        -- ������ �������. �������
                        ( select table_name from user_tables
                          union all
                          select view_name from user_views
                          union all
                          select  synonym_name from dba_synonyms
                          where table_owner='BARS' and owner='PUBLIC' and
                                table_name in (select table_name from user_tables
                                               union all
                                               select view_name  from user_views)
                        ) avobj
                    where r.tabid = m.tabid
                          and avobj.table_name = m.tabname
                          and role2edit is null
                          and m.tabname like p_tabname)
        loop
           l_ret := create_role(c.tabname);
        end loop;
     end if;

     bars_audit.info(l_trace||'������ ������ � ���� ��� ������������');
     -- ������ ��� ������ �� �����������
     for c in (
                select role2edit, tabname
                from meta_tables m, references r, dba_roles dr,
                     -- ������ �������. �������
                     ( select table_name from user_tables
                       union all
                       select view_name from user_views
                       union all
                       select  synonym_name from dba_synonyms
                       where table_owner='BARS' and owner='PUBLIC' and
                             table_name in (select table_name from user_tables
                                            union all
                                            select view_name  from user_views)
                     ) avobj
                 where r.tabid = m.tabid
                       and avobj.table_name = m.tabname
                       and dr.role = role2edit
                       and m.tabname like p_tabname)
     loop
--         execute immediate ' grant select, insert, update, delete on '||c.tabname||' to '||c.role2edit;
         execute immediate ' grant select on '||c.tabname||' to '||c.role2edit;
     end loop;

  end;


  --------------------------------------------------------------
  --
  --  GRANT_REF_PRIVS()
  --
  --   ������ ������� ������������� �� �����������
  --
  --   p_codeapp    - ��� ���-�, ���� �� ��������� - ������ ��� ���� ���-��
  --   p_refname    - ���  �����������(��� �� meta_tables), ���� �� ������� - ��� ����
  --   p_createrole - ���� ��������� ���� ��� ����������� �� ����������
  --                  = 1 - ������� ���� � ������ �� ������
  --                  = 0 - �� ��������� ����, ������ �� ��������
  --
  procedure  grant_ref_privs(
                 p_codeapp     applist.codeapp%type       default '%',
                 p_refname     meta_tables.tabname%type   default '%',
                 p_createrole  smallint                   default 1 )
  is
     l_ret    number := 0;
     l_trace  varchar2(1000) := G_TRACE||'grant_ref_privs: ';
  begin

     correct_references(
             p_tabname    => p_refname,
             p_createrole => p_createrole);

     -- ������ �� ���� ��� ������������ ������� �������������
     for c in (
               select ref_user, ref_role
               from (
                     select unique ref_user, ref_role, dp.granted_role
                     from (
                            select role2edit ref_role, logname ref_user
                            from meta_tables m, refapp ra, staff s,  applist_staff af,
                                 references r,
                                 dba_users du,  dba_roles dr,
                                 -- ������ �������. �������
                                 ( select table_name from user_tables
                                   union all
                                   select view_name from user_views
                                   union all
                                   select  synonym_name from dba_synonyms
                                   where table_owner='BARS' and owner='PUBLIC' and
                                          table_name in (select table_name from user_tables
                                                         union all
                                                         select view_name  from user_views)
                                 ) avobj
                            where r.tabid = m.tabid and r.tabid = ra.tabid
                                 and ra.codeapp = af.codeapp and af.id=s.id
                                 and logname is not null
                                 and af.codeapp like p_codeapp
                                 and m.tabname like p_refname
                                 and role2edit is not null
                                 and avobj.table_name = m.tabname
                                 and du.username = s.logname
                                 and dr.role = role2edit
                          ) d,
                          dba_role_privs dp
                     where     dp.grantee(+) = ref_user
                           and dp.granted_role(+) = ref_role
                    )
               where granted_role is null
              )
     loop
         bars_audit.info(l_trace||' ������ �������: '||'grant '||c.ref_role||' to '||c.ref_user);
         execute immediate 'grant '||c.ref_role||' to '||c.ref_user;
     end loop;

  end;


  --------------------------------------------------------------
  --
  --  GRANT_FUNC_PRIVS()
  --
  --   ������ ������� ������������� �� �����������
  --
  --
  --   p_codeapp    - ��� ���-�, ���� �� ��������� - ������ ��� ���� ���-��
  --   p_funcid     - ��� �������
  --   p_createrole - ���� ��������� ���� ��� ����������� �� ����������
  --                  = 1 - ������� ���� � ������ �� ������
  --                  = 0 - �� ��������� ����, ������ �� ��������

  procedure grant_func_privs(
                 p_codeapp     applist.codeapp%type   default '%',
                 p_funcid      varchar2               default '%',
                 p_createrole  smallint               default 1 )
  is
     l_trace  varchar2(1000):= G_TRACE||'grant_func_privs: ';
     l_rcnt   number:=0;
  begin

     if (p_createrole = 1) then
        bars_audit.info(l_trace||'������ ����� ��������������� �������� ����');
     else
        bars_audit.info(l_trace||'������ �����, ��� ������� �������������� ���� � �� - �� ���������');
     end if;

     -- ����� ���� ����� �� �� ������ �� ���������� � ��
     for c in (
                select func_role
                from ( select dr.role db_role, func_role
                       from (
                              select unique upper(rolename) func_role
                              from   operlist o, operapp oa,  applist_staff af,  staff f
                              where  o.codeoper = oa.codeoper
                                     and to_char(o.codeoper) like p_funcid
                                     and oa.codeapp like p_codeapp
                                     and oa.codeapp = af.codeapp
                                     and f.id = af.id
                                     and rolename is not null
                                     and logname  is not null
                            ) app,
                            dba_roles dr
                       where  dr.role(+) = func_role
                     )
                where db_role is null
              ) loop

        if (p_createrole = 1) then
            bars_audit.info(l_trace||'���� '||c.func_role||' ���� � �� - ������ ��');
            l_rcnt := create_role(c.func_role);
        else
            bars_audit.info(l_trace||'���� '||c.func_role||' ���� � �� - �� ������ ��');
        end if;
     end loop;

     -- � ���� ���� �������, �� �� ������ ������ �� ��� �������
     for c in (
                select db_role, du.username db_user, func_role, func_user
                from (
                       select func_role, func_user, dr.role db_role,
                              dp.grantee db_user, dp.granted_role
                       from (
                              select unique upper(rolename) func_role, upper(logname) func_user
                              from   operlist o, operapp oa,  applist_staff af,  staff f
                              where  o.codeoper = oa.codeoper
                                     and to_char(o.codeoper) like p_funcid
                                     and oa.codeapp like p_codeapp
                                     and oa.codeapp = af.codeapp
                                     and f.id = af.id
                                     and rolename is not null
                                     and logname  is not null
                            ) app,
                            dba_roles dr, dba_role_privs dp
                       where     dr.role(+)         = func_role
                             and dp.grantee(+)      = func_user
                             and dp.granted_role(+) = func_role
                      ), dba_users du
                where granted_role is null
                      and du.username(+) = func_user
              )
     loop

         if c.db_role is null then
            bars_audit.info(l_trace||'���� '||c.func_role||' �� ���� ������� �� ���������� ����, ���������� �� ����� ���� �� ������ ��� '||c.func_user);
         else
            if c.db_user is null then
               bars_audit.info(l_trace||'������������ '||c.func_user||' �� c��������� � ��, ���������� �� ���� '||c.db_role||' �� ������');
            else
               bars_audit.info(l_trace||'������ ����������: '||'grant '||c.db_role||' to '||c.db_user);
               execute immediate 'grant '||c.db_role||' to '||c.db_user;
            end if;
         end if;

     end loop;

  end;


  --------------------------------------------------------------
  --
  --  GRANT_ALL_PRIVS()
  --
  --   ������ ���� ������� ��� ���-�
  --
  procedure grant_all_privs(p_codeapp  varchar2 default '%') is
  begin
     grant_func_privs(p_codeapp);
     grant_ref_privs(p_codeapp);
  end;


  --------------------------------------------------------------
  --
  --  ADD_FUNCLIST()
  --
  --   ���������� �-���  ������� �����
  --   p_codeoper   - ��� �-��� �� operlist
  --   p_type       - 1 - ����� ���, 0- �����
  --   p_checked    - 1 - ������� ��-���������, 0 -�� �������
  --   p_position   - �������
  --
  procedure add_funclist(
                 p_codeoper    number,
                 p_type        smallint,
                 p_checked     smallint,
                 p_position    smallint default null)
  is
     l_newid number;
     l_pos   number;
  begin

     select nvl(max(rec_id), 0) + 1 into l_newid from list_funcset;

     if p_position is null then
        select nvl(max(func_position),0) + 1 into l_pos
        from list_funcset where set_id = p_type;
     else
        l_pos := p_position;
     end if;

     for c in ( select rec_id
                  from list_funcset
                 where func_id =  p_codeoper and set_id = p_type ) loop
         delete from list_funcset where rec_id = c.rec_id;
     end loop;

     bc.subst_mfo(f_ourmfo_g);

     begin
        insert into list_funcset (rec_id, set_id, func_id, func_activity, func_position, kf)
        values(l_newid, p_type, p_codeoper, p_checked, l_pos, f_ourmfo_g);
     exception when dup_val_on_index then null;
     end;

     bc.set_context;

  end;


  --------------------------------------------------------------
  --
  --  ADD_FUNCLIST_CNT()
  --
  --   ���������� �-���  ������� ����� ��� �������
  --   p_codeoper   - ��� �-��� �� operlist
  --   p_type       - 1 - ����� ���, 0- �����
  --   p_checked    - 1 - ������� ��-���������, 0 -�� �������
  --
  procedure add_funclist_cnt(
                 p_codeoper    number,
                 p_type        number,
                 p_checked     number)
  is
  begin
     add_funclist(
                 p_codeoper => p_codeoper,
                 p_type     => p_type,
                 p_checked  => p_checked,
                 p_position => null);

  end;


  --------------------------------------------------------------
  --
  --  ADD_FUNCLIST_START()
  --
  --
  --   ���������� �-���  ������� ����� �� ������ ���
  --
  --   p_codeoper   - ��� �-��� �� operlist
  --   p_checked    - 1 - ������� ��-���������, 0 -�� �������
  --   p_position   - ������� (�� �����. �����, ������ ���������)
  --
  --
  procedure add_funclist_start(
                 p_codeoper    number,
                 p_checked     smallint,
                 p_position    smallint default null)
  is
  begin
     add_funclist(p_codeoper, 0,  p_checked,  p_position);
  end;


  --------------------------------------------------------------
  --
  --  ADD_FUNCLIST_FINISH()
  --
  --
  --   ���������� �-���  ������� ����� �� ������ ���
  --
  --   p_codeoper   - ��� �-��� �� operlist
  --   p_checked    - 1 - ������� ��-���������, 0 -�� �������
  --   p_position   - ������� (�� �����. �����, ������ ���������)
  --
  --
  procedure add_funclist_finish(
                 p_codeoper    number,
                 p_checked     smallint,
                 p_position    smallint default null)
  is
  begin
     add_funclist(p_codeoper, 1,  p_checked,  p_position);
  end;


  --------------------------------------------------------------
  --
  --  ADD_FUNCTION()
  --
  --   ����������
  --
  --
  --
  function add_function(
                  func_name varchar2,
                  role_name varchar2,
                  sem       varchar2,
                  full_name varchar2 DEFAULT NULL) RETURN NUMBER IS
     l_funcid number;
  begin
     l_funcid := add_func(
                 p_name     => sem,
                 p_funcname => func_name,
                 p_rolename => role_name);
     return l_funcid;
  end;


/* ����������� ����� ������������ � Meta_tables � References
   (������ ����������� ��� ������������ � ����������� ���� � ������� ��������������)
  table_name - ��� �������������� �������
  role_name - ��� ��������������� ����
  sem         - ������������ �����������
  dlg_name - ������ ������ ��� �������������� �������
  ���������� ��� ��������� ������� (TABID)
*/

  FUNCTION Add_Reference(
                 table_name VARCHAR2,
                 role_name  VARCHAR2,
                        sem VARCHAR2,
                                       dlg_name VARCHAR2 DEFAULT NULL) RETURN NUMBER IS

tab_id  NUMBER;

FUNCTION FIND_FREE RETURN NUMBER IS
  cur_n NUMBER;
  found BOOLEAN;
  temp  NUMBER;
BEGIN
  cur_n := 0;
  found := FALSE;
  WHILE NOT found LOOP
    cur_n := cur_n + 1;
    BEGIN
      SELECT tabid INTO temp FROM meta_tables WHERE tabid=cur_n;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      found := TRUE;
    END;
  END LOOP;
  RETURN cur_n;
END;
BEGIN
  BEGIN
    SELECT tabid INTO tab_id FROM meta_tables
    WHERE UPPER(tabname)=UPPER(table_name);
    BEGIN
      SELECT tabid INTO tab_id FROM references WHERE tabid=tab_id;
      -- Updating role
      UPDATE references SET role2edit=role_name WHERE tabid=tab_id;
      IF dlg_name IS NOT NULL THEN
        UPDATE references SET dlgname=dlg_name WHERE tabid=tab_id;
      END IF;
      DBMS_OUTPUT.PUT_LINE('���������� <' || sem || '> ��������!');
    EXCEPTION WHEN NO_DATA_FOUND THEN
      BEGIN
        -- Inserting into REFERENCES
        INSERT INTO references (tabid,dlgname,role2edit)
        VALUES (tab_id,role_name,dlg_name);
        DBMS_OUTPUT.PUT_LINE('���������� <' || sem || '> ��������!');
      END;
    END;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    BEGIN
      -- Inserting into REFERENCES and META_TABLES
      tab_id := FIND_FREE;
      INSERT INTO meta_tables (tabid,tabname,semantic)
      VALUES (tab_id,UPPER(table_name),sem);
      DBMS_OUTPUT.PUT_LINE('������� <' || table_name || '> ���������!');

      INSERT INTO references (tabid,dlgname,role2edit)
      VALUES (tab_id,role_name,dlg_name);
      DBMS_OUTPUT.PUT_LINE('���������� <' || sem || '> ��������!');
    END;
  END;
  RETURN tab_id;
END;


-- ������� �������� ��� ���� �������� �����
-- ������� ����� �������� ����������� � ������
PROCEDURE Correct_Synonyms
IS
  CURSOR BAD_SYNONYMS IS
    SELECT
      SYNONYM_NAME
    FROM DBA_SYNONYMS
    WHERE
      (TABLE_OWNER,TABLE_NAME) NOT IN
      (SELECT OWNER,OBJECT_NAME FROM DBA_OBJECTS)
      AND TABLE_OWNER NOT IN ('SYS','SYSTEM')
      AND OWNER='PUBLIC';

  CURSOR ALL_USER_OBJECTS IS
    SELECT OBJECT_NAME
    FROM USER_OBJECTS
    WHERE OBJECT_TYPE IN
      ('TABLE','VIEW','PROCEDURE','FUNCTION','PACKAGE','SEQUENCE') AND
      OBJECT_NAME NOT IN (SELECT SYNONYM_NAME FROM DBA_SYNONYMS WHERE OWNER='PUBLIC');


CID          INTEGER;
RES             INTEGER;
SSS          VARCHAR2(200);

BEGIN
  CID := DBMS_SQL.OPEN_CURSOR;
  --��� ���� ���������, ����������� � ������
  FOR I IN BAD_SYNONYMS LOOP
    -- �������
    SSS:='DROP PUBLIC SYNONYM ' || I.SYNONYM_NAME;
    DBMS_OUTPUT.PUT_LINE(SSS);
    BEGIN
      DBMS_SQL.PARSE(CID, SSS, DBMS_SQL.V7);
    EXCEPTION
      WHEN OTHERS THEN NULL;
    END;
  END LOOP;
  --��� ���� �������� ��� ���������
  FOR I IN ALL_USER_OBJECTS LOOP
    -- ������� ��
    SSS:='CREATE PUBLIC SYNONYM ' || I.OBJECT_NAME || ' FOR ' || I.OBJECT_NAME || ';';
    DBMS_OUTPUT.PUT_LINE(SSS);
    BEGIN
      DBMS_SQL.PARSE(CID, SSS, DBMS_SQL.V7);
    EXCEPTION
      WHEN OTHERS THEN NULL;
    END;
  END LOOP;
  DBMS_SQL.CLOSE_CURSOR( CID );
END Correct_Synonyms;

  --------------------------------------------------------------
  --
  --  add_func2arm
  --
  --  �������� ������� � ���
  --
  procedure add_func2arm(p_codeoper operlist.codeoper%type, p_codeapp applist.codeapp%type) is
      l_trace varchar2(1000) := g_trace||'add_func2arm: ';
	  l_tmp varchar2(1000);
	  l_arm_row applist%rowtype;
  begin
      begin
	     select codeapp into l_tmp from applist where codeapp = p_codeapp;
	  exception when no_data_found then
	      bars_error.raise_nerror(G_MODULE, 'NO_SUCH_ARM', p_codeapp);
	  end;

	  begin
	     select codeoper into l_tmp from operlist where codeoper = p_codeoper;
	  exception when no_data_found then
	      bars_error.raise_nerror(G_MODULE, 'NO_SUCH_FUNCID', p_codeoper);
	  end;
	  l_arm_row := user_menu_utl.read_arm(p_codeapp);
      resource_utl.set_resource_access_mode(resource_utl.get_resource_type_id(user_menu_utl.get_arm_resource_type_code(l_arm_row.frontend)),
                                            l_arm_row.id,
                                            resource_utl.get_resource_type_id(user_menu_utl.get_func_resource_type_code(l_arm_row.frontend)),
                                            p_codeoper,
                                            user_menu_utl.FUNC_ACCESS_MODE_GRANTED);

      bars_audit.info(l_trace || '������� ' || p_codeoper || ' ��������� � ��� ' || p_codeapp);


  end;
  --------------------------------------------------------------
  --
  --  add_func2deps
  --
  --
 procedure add_func2deps(p_idpar in number, p_idchild in number) is
    l_trace varchar2(1000) := g_trace||'add_func2deps: ';
 begin
    insert into operlist_deps (id_parent, id_child) values (p_idpar, p_idchild);
	bars_audit.info(l_trace||' ������ ��''���� �� ��������� '||p_idpar ||' �� '||p_idchild);
 exception when dup_val_on_index then null;
 end;
  --------------------------------------------------------------
  --
  --  add_arm
  --
  --  ������ ����� ���
  --
 procedure add_arm(p_arm_code varchar2, p_arm_desc varchar2, p_frontend number default 1) is
     l_trace varchar2(1000) := g_trace||'add_arm: ';
 begin
    insert into applist(codeapp, name, frontend)  values(p_arm_code, p_arm_desc, p_frontend);
	bars_audit.info(l_trace||'������ ����� ��� � �����:'||p_arm_code );
 exception when dup_val_on_index then null;
 end;


end abs_utils;
/
 show err;
 
PROMPT *** Create  grants  ABS_UTILS ***
grant EXECUTE                                                                on ABS_UTILS       to ABS_ADMIN;
grant EXECUTE                                                                on ABS_UTILS       to BARSAQ;
grant EXECUTE                                                                on ABS_UTILS       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on ABS_UTILS       to QUERY_EDITOR;
grant EXECUTE                                                                on ABS_UTILS       to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/abs_utils.sql =========*** End *** =
 PROMPT ===================================================================================== 
 