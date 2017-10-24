CREATE OR REPLACE PACKAGE bars_metabase is

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--| ����� bars_metabase ��� ������ � ������������� ������ ��������� |
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

g_header_version   constant varchar2(64)  := 'version 2.43 23/08/2017';
g_header_defs      constant varchar2(512) := '';

/**
 * header_version - ���������� ������ ��������� ������
 */
function header_version return varchar2;

/**
 * body_version - ���������� ������ ���� ������
 */
function body_version return varchar2;

function get_tabid (p_tabname meta_tables.tabname%type ) return number;

function get_colid (
  p_tabid   meta_columns.tabid%type,
  p_colname meta_columns.colname%type
) return number;

function get_newtabid return number;

function get_newcolid (p_tabid meta_tables.tabid%type ) return number;

procedure set_tablinesdef (
  p_tabid     meta_tables.tabid%type,
  p_linesdef  varchar2);

procedure set_tabsemantic (
  p_tabid       meta_tables.tabid%type,
  p_tabsemantic meta_tables.semantic%type);

procedure set_tabselect_statement (
  p_tabid            meta_tables.tabid%type,
  p_select_statement meta_tables.select_statement%type) ;

procedure delete_metatables (p_tabid meta_tables.tabid%type);

procedure delete_metacolumns (
  p_tabid meta_columns.tabid%type,
  p_colid meta_columns.colid%type);

procedure add_table (
  p_tabid        meta_tables.tabid%type,
  p_tabname      meta_tables.tabname%type,
  p_tabsemantic  meta_tables.semantic%type,
  p_tabselect_statement  meta_tables.select_statement%type default null,
  p_linesdef     int default 10);

procedure add_column (
  p_tabid             meta_tables.tabid%type,
  p_colid             meta_columns.colid%type,
  p_colname           meta_columns.colname%type,
  p_coltype           meta_columns.coltype%type,
  p_semantic          meta_columns.semantic%type,
  p_showwidth         meta_columns.showwidth%type,
  p_showmaxchar       meta_columns.showmaxchar%type,
  p_showpos           meta_columns.showpos%type,
  p_showin_ro         meta_columns.showin_ro%type,
  p_showretval        meta_columns.showretval%type,
  p_instnssemantic    meta_columns.instnssemantic%type,
  p_extrnval          meta_columns.extrnval%type,
  p_showrel_ctype     meta_columns.showrel_ctype%type,
  p_showformat        meta_columns.showformat%type,
  p_showin_fltr       meta_columns.showin_fltr%type,
  p_showref           meta_columns.showref%type             default 0,
  p_showresult        meta_columns.showresult%type          default null,
  p_nottoedit         meta_columns.not_to_edit%type         default 0,
  p_nottoshow         meta_columns.not_to_show%type         default 0,
  p_simplefilter      meta_columns.simple_filter%type       default 0,
  p_webformname       meta_columns.web_form_name%type       default null,
  p_formname          meta_columns.form_name%type           default null,
  p_inputinnewrecord  meta_columns.INPUT_IN_NEW_RECORD%type default 0);

procedure add_extrnval (
  p_tabid          meta_extrnval.tabid%type,
  p_colid          meta_extrnval.colid%type,
  p_srctabid       meta_extrnval.srctabid%type,
  p_srccolid       meta_extrnval.srccolid%type,
  p_tab_alias      meta_extrnval.tab_alias%type,
  p_tab_cond       meta_extrnval.tab_cond%type default null,
  p_src_cond       meta_extrnval.src_cond%type default null,
  p_coldyntabname  varchar2                    default null);

procedure add_browsetbl (
  p_hosttabid    meta_browsetbl.hosttabid%type,
  p_addtabid     meta_browsetbl.addtabid%type,
  p_addtabalias  meta_browsetbl.addtabalias%type,
  p_hostcolkeyid meta_browsetbl.hostcolkeyid%type,
  p_addcolkeyid  meta_browsetbl.addcolkeyid%type,
  p_var_colid    meta_browsetbl.var_colid%type,
  p_cond_tag     meta_browsetbl.cond_tag%type);

procedure add_sortorder (
  p_tabid     meta_sortorder.tabid%type,
  p_colid     meta_sortorder.colid%type,
  p_sortorder meta_sortorder.sortorder%type,
  p_sortway   meta_sortorder.sortway%type);

procedure add_filtertbl (
  p_tabid     meta_filtertbl.tabid%type,
  p_colid     meta_filtertbl.colid%type,
  p_flt_tabid meta_filtertbl.filter_tabid%type,
  p_flt_code  meta_filtertbl.filter_code%type,
  p_flg_ins   meta_filtertbl.flag_ins%type default 0,
  p_flg_del   meta_filtertbl.flag_del%type default 0,
  p_flg_upd   meta_filtertbl.flag_upd%type default 0);

procedure add_actiontbl (
  p_tabid     meta_actiontbl.tabid%type,
  p_code      meta_actiontbl.action_code%type,
  p_proc      meta_actiontbl.action_proc%type);

procedure add_nsifunction (
  p_tabid        meta_nsifunction.tabid%type,
  p_funcid       meta_nsifunction.funcid%type,
  p_descr        meta_nsifunction.descr%type,
  p_procname     meta_nsifunction.proc_name%type,
  p_procpar      meta_nsifunction.proc_par%type,
  p_procexec     meta_nsifunction.proc_exec%type,
  p_qst          meta_nsifunction.qst%type,
  p_msg          meta_nsifunction.msg%type,
  p_formname     meta_nsifunction.form_name%type,
  p_checkfunc    meta_nsifunction.check_func%type,
  p_webformname  varchar2 default null,
  p_iconid       int default 0);

procedure add_dependency (
  p_tabid         number,
  p_colid         number,
  p_event         varchar2,
  p_depcolid      number,
  p_action_type   varchar2,
  p_action_name   varchar2,
  p_default_value varchar2,
  p_condition     varchar2
  );

procedure update_table (
  p_tabid       meta_tables.tabid%type   ,
  p_tabname     meta_tables.tabname%type ,
  p_tabsemantic meta_tables.semantic%type,
  p_linesdef    meta_tables.linesdef%type);

procedure update_column (
  p_tabid             meta_tables.tabid%type,
  p_colid             meta_columns.colid%type,
  p_colname           meta_columns.colname%type,
  p_coltype           meta_columns.coltype%type,
  p_semantic          meta_columns.semantic%type,
  p_showwidth         meta_columns.showwidth%type,
  p_showmaxchar       meta_columns.showmaxchar%type,
  p_showpos           meta_columns.showpos%type,
  p_showin_ro         meta_columns.showin_ro%type,
  p_showretval        meta_columns.showretval%type,
  p_instnssemantic    meta_columns.instnssemantic%type,
  p_extrnval          meta_columns.extrnval%type,
  p_showrel_ctype     meta_columns.showrel_ctype%type,
  p_showformat        meta_columns.showformat%type,
  p_showin_fltr       meta_columns.showin_fltr%type,
  p_showref           meta_columns.showref%type             default 0,
  p_showresult        meta_columns.showresult%type          default null,
  p_nottoedit         meta_columns.not_to_edit%type         default 0,
  p_nottoshow         meta_columns.not_to_show%type         default 0,
  p_simplefilter      meta_columns.simple_filter%type       default 0,
  p_formname          meta_columns.form_name%type           default null,
  p_webformname       meta_columns.web_form_name%type       default null,
  p_inputinnewrecord  meta_columns.input_in_new_record%type default 0);

procedure update_extrnval (
  p_tabid          meta_extrnval.tabid%type,
  p_colid          meta_extrnval.colid%type,
  p_srctabid       meta_extrnval.srctabid%type,
  p_srccolid       meta_extrnval.srccolid%type,
  p_tab_alias      meta_extrnval.tab_alias%type,
  p_tab_cond       meta_extrnval.tab_cond%type default null,
  p_coldyntabname  varchar2                    default null);

procedure update_browsetbl (
  p_hosttabid    meta_browsetbl.hosttabid%type,
  p_addtabid     meta_browsetbl.addtabid%type,
  p_addtabalias  meta_browsetbl.addtabalias%type,
  p_hostcolkeyid meta_browsetbl.hostcolkeyid%type,
  p_addcolkeyid  meta_browsetbl.addcolkeyid%type,
  p_var_colid    meta_browsetbl.var_colid%type,
  p_cond_tag     meta_browsetbl.cond_tag%type);

procedure update_sortorder (
  p_tabid     meta_sortorder.tabid%type,
  p_colid     meta_sortorder.colid%type,
  p_sortorder meta_sortorder.sortorder%type,
  p_sortway   meta_sortorder.sortway%type);

procedure update_filtertbl (
  p_tabid     meta_filtertbl.tabid%type,
  p_colid     meta_filtertbl.colid%type,
  p_flt_tabid meta_filtertbl.filter_tabid%type,
  p_flt_code  meta_filtertbl.filter_code%type,
  p_flg_ins   meta_filtertbl.flag_ins%type default 0,
  p_flg_del   meta_filtertbl.flag_del%type default 0,
  p_flg_upd   meta_filtertbl.flag_upd%type default 0);

procedure update_actiontbl (
  p_tabid     meta_actiontbl.tabid%type,
  p_code      meta_actiontbl.action_code%type,
  p_proc      meta_actiontbl.action_proc%type);

procedure update_dependency (
  p_id            number,
  p_event         varchar2,
  p_action_type   varchar2,
  p_action_name   varchar2,
  p_default_value varchar2,
  p_condition     varchar2);

procedure sync_column (
  p_tabid          meta_tables.tabid%type,
  p_colname        meta_columns.colname%type,
  p_coltype        meta_columns.coltype%type,
  p_semantic       meta_columns.semantic%type,
  p_showmaxchar    meta_columns.showmaxchar%type);

procedure delete_table (p_tabid meta_tables.tabid%type);

procedure delete_column (
  p_tabid meta_columns.tabid%type,
  p_colid meta_columns.colid%type);

procedure delete_extrnval (
  p_tabid meta_extrnval.tabid%type,
  p_colid meta_extrnval.colid%type);

procedure delete_browsetbl (
  p_hosttabid    meta_browsetbl.hosttabid%type,
  p_addtabid     meta_browsetbl.addtabid%type,
  p_hostcolkeyid meta_browsetbl.hostcolkeyid%type,
  p_addcolkeyid  meta_browsetbl.addcolkeyid%type,
  p_var_colid    meta_browsetbl.var_colid%type);

procedure delete_sortorder (
  p_tabid meta_sortorder.tabid%type,
  p_colid meta_sortorder.colid%type);

procedure delete_filtertbl (
  p_tabid meta_filtertbl.tabid%type,
  p_colid meta_filtertbl.colid%type);

procedure delete_actiontbl (
  p_tabid meta_actiontbl.tabid%type,
  p_code  meta_actiontbl.action_code%type);

procedure delete_nsifunction (
  p_tabid meta_nsifunction.tabid%type);

procedure delete_dependency (p_id number);

procedure change_filter (
  p_code      meta_filtercodes.code%type,
  p_name      meta_filtercodes.name%type,
  p_condition meta_filtercodes.condition%type);

procedure delete_filter (p_code meta_filtercodes.code%type);

procedure addTableToRef (
  p_tabid  references.tabid%type,
  p_refid  references.type%type);

procedure add_tblcolor (
  p_tabid      meta_tblcolor.tabid%type,
  p_ord        meta_tblcolor.ord%type,
  p_colid      meta_tblcolor.colid%type,
  p_condition  meta_tblcolor.condition%type,
  p_colorindex meta_tblcolor.color_index%type,
  p_colorname  meta_tblcolor.color_name%type);

procedure delete_tblcolor (
  p_tabid meta_tblcolor.tabid%type);

procedure import_bmd (p_tabname varchar2, p_filename varchar2);

procedure create_dyn_filter(p_tabid                in number,
                            p_filter_name          in varchar2,
                            p_dyn_filter_cond_list in t_dyn_filter_cond_list,
                            p_save_filter          in number default 1,
                            p_where_clause         in out varchar2,
                            p_condition_list       in clob
                            );

procedure update_dyn_filter(p_tabid                in number,
                            p_filterid             in number,
                            p_filter_name          in varchar2,
                            p_dyn_filter_cond_list in t_dyn_filter_cond_list,
                            p_where_clause         in out varchar2,
                            p_condition_list       in clob
                            );

end bars_metabase;
/
CREATE OR REPLACE PACKAGE BODY bars_metabase is

--***************************************************************************--
--
-- bars_metabase - ����� ��� ������ � ������������� ������ ���������
--
--***************************************************************************--
g_body_version   constant varchar2(64)  := 'version 2.43 23/08/2017';
g_body_defs      constant varchar2(512) := '';

g_modcode        constant varchar2(3)   := 'BMD';

module_gl        constant boolean := true;

-- Logical operator constant

G_LOGIC_AND           varchar2(100) := 'AND';
G_LOGIC_OR            varchar2(100) := 'OR';
-- REletional operator constant
G_RELATIONAL_LIKE     varchar2(100) := 'LIKE';
G_RELATIONAL_NOTLIKE  varchar2(100) := 'NOT LIKE';
G_RELATIONAL_IN       varchar2(100) := 'IN';
G_RELATIONAL_NOTIN    varchar2(100) := 'NOT IN';
G_RELATIONAL_NULL     varchar2(100) := 'IS NULL';
G_RELATIONAL_NOTNULL  varchar2(100) := 'IS NOT NULL';
/**
 * header_version - ���������� ������ ��������� ������
 */
function header_version return varchar2 is
begin
  return 'Package header ACCREG ' || g_header_version || '.' || chr(10)
	   || 'AWK definition: '  || chr(10)
	   || g_header_defs;
end header_version;

/**
 * body_version - ���������� ������ ���� ������
 */
function body_version return varchar2 is
begin
  return 'Package body ACCREG '  || g_body_version || '.' || chr(10)
	   || 'AWK definition: ' || chr(10)
	   || g_body_defs;
end body_version;

--***************************************************************************--
-- �������:  get_tabid
-- ��������: ��������� ���� �������
-- ���������:
--   p_tabname - ������������ �������
--***************************************************************************--
function get_tabid (p_tabname meta_tables.tabname%type) return number
is
  l_tabid meta_tables.tabid%type;
begin
  begin
     select tabid into l_tabid from meta_tables where tabname=p_tabname;
  exception
     when no_data_found then
        l_tabid := null;
  end;
  return l_tabid;
end;

--***************************************************************************--
-- �������:  get_colid
-- ��������: ��������� ���� �������
-- ���������:
--   p_tabid - ��� �������
--   p_colid - ������������ �������
--***************************************************************************--
function get_colid (
  p_tabid   meta_columns.tabid%type,
  p_colname meta_columns.colname%type
) return number
is
  l_colid meta_columns.colid%type := null;
begin

  if (p_tabid is not null and p_colname is not null) then

     begin

        select colid into l_colid from meta_columns
        where tabid=p_tabid and colname=p_colname;

     exception
        when no_data_found then
           l_colid := null;

     end;

  end if;

  return l_colid;

end;

--***************************************************************************--
-- �������:  get_newtabid
-- ��������: ��������� ���� ��� ����� �������
--***************************************************************************--
function get_newtabid return number
is
begin

  return s_metatables.nextval;

end;

--***************************************************************************--
-- �������:  get_newcolid
-- ��������: ��������� ���� ��� ����� ������� �������
-- ���������:
--   p_tabid - ��� �������
--***************************************************************************--
function get_newcolid (p_tabid meta_tables.tabid%type) return number
is
  l_colid meta_columns.colid%type;
begin

  select nvl(max(colid),0)+1 into l_colid from meta_columns where tabid=p_tabid;

  return l_colid;

end;

--***************************************************************************--
-- ���������: set_tablinesdef
-- ��������:  ���������� linesdef ��� �������
-- ���������:
--   p_tabid    - ��� �������
--   p_linesdef - linesdef
--***************************************************************************--
procedure set_tablinesdef (
  p_tabid     meta_tables.tabid%type,
  p_linesdef  varchar2)
is
begin
  update meta_tables set linesdef = to_number(p_linesdef) where tabid = p_tabid;
end;

--***************************************************************************--
-- ���������: set_tabsemantic
-- ��������:  ���������� ��������� ��� �������
-- ���������:
--   p_tabid       - ��� �������
--   p_tabsemantic - ���������
--***************************************************************************--
procedure set_tabsemantic (
  p_tabid       meta_tables.tabid%type,
  p_tabsemantic meta_tables.semantic%type)
is
begin
  update meta_tables set semantic = p_tabsemantic where tabid = p_tabid;
end;

--***************************************************************************--
-- ���������: set_select_statement
-- ��������:  ���������� set_select_statement ��� �������
-- ���������:
--   p_tabid       - ��� �������
--   p_set_select_statement - select_statement
--***************************************************************************--
procedure set_tabselect_statement (
  p_tabid            meta_tables.tabid%type,
  p_select_statement meta_tables.select_statement%type)
is
begin
  update meta_tables set select_statement = p_select_statement where tabid = p_tabid;
end;

--***************************************************************************--
-- ���������: delete_metatables
-- ��������:  �������� �� ��������� ������ ������ �� �������
-- ���������:
--   p_tabid - ��� �������
--***************************************************************************--
procedure delete_metatables (p_tabid meta_tables.tabid%type)
is
begin

  delete from meta_extrnval        where tabid        = p_tabid;
  delete from meta_extrnval        where srctabid     = p_tabid;
  delete from meta_browsetbl       where hosttabid    = p_tabid;
  delete from meta_browsetbl       where addtabid     = p_tabid;
  delete from meta_filtertbl       where tabid        = p_tabid;
  delete from meta_filtertbl       where filter_tabid = p_tabid;
  delete from meta_actiontbl       where tabid        = p_tabid;
  delete from meta_sortorder       where tabid        = p_tabid;
  delete from meta_tblcolor        where tabid        = p_tabid;
  delete from meta_dependency_cols where tabid        = p_tabid;
  delete from meta_columns         where tabid        = p_tabid;

end;

--***************************************************************************--
-- ���������: delete_metacolumns
-- ��������:  �������� �� ��������� ������ ������ �� �������
-- ���������:
--   p_tabid - ��� �������
--   p_colid - ��� �������
--***************************************************************************--
procedure delete_metacolumns (
  p_tabid meta_columns.tabid%type,
  p_colid meta_columns.colid%type)
is
begin

  delete from meta_extrnval        where tabid     = p_tabid and colid = p_colid;
  delete from meta_extrnval        where srctabid  = p_tabid and srccolid = p_colid;
  delete from meta_browsetbl       where hosttabid = p_tabid and hostcolkeyid = p_colid;
  delete from meta_browsetbl       where addtabid  = p_tabid and addcolkeyid = p_colid;
  delete from meta_browsetbl       where addtabid  = p_tabid and var_colid = p_colid;
  delete from meta_filtertbl       where tabid     = p_tabid and colid = p_colid;
  delete from meta_sortorder       where tabid     = p_tabid and colid = p_colid;
  delete from meta_dependency_cols where tabid     = p_tabid and colid = p_colid;
  delete from meta_columns         where tabid     = p_tabid and colid = p_colid;

end;

--***************************************************************************--
-- ���������: add_table
-- ��������:  ���������� ������������ ����� �������
-- ���������:
--   p_tabid       - ��� �������
--   p_tabname     - ��� �������
--   p_tabsemantic - ��������� �������
--   p_linesdef    - ���������� ����� �� ���������
--***************************************************************************--
procedure add_table (
  p_tabid        meta_tables.tabid%type,
  p_tabname      meta_tables.tabname%type,
  p_tabsemantic  meta_tables.semantic%type,
  p_tabselect_statement  meta_tables.select_statement%type default null,
  p_linesdef     int default 10)
is
  l_tabname      meta_tables.tabname%type;
  l_tabsemantic  meta_tables.semantic%type;
  l_tabselect_statement  meta_tables.select_statement%type;
  l_tabid        meta_tables.tabid%type;
  l_1            int;
begin

  l_tabid := p_tabid;

  if l_tabid is null then
     l_tabid := get_newtabid;
  end if;

  select count(1)
  into   l_1
  from   user_tab_columns
  where  table_name='META_TABLES' and
         COLUMN_NAME='LINESDEF';

  l_tabsemantic := replace(replace(p_tabsemantic, chr(39), chr(39) || chr(39)),chr(38), '''||chr(38)||''');
  l_tabname     := replace(replace(p_tabname,     chr(39), chr(39) || chr(39)),chr(38), '''||chr(38)||''');
  l_tabselect_statement     := replace(replace(p_tabselect_statement,     chr(39), chr(39) || chr(39)),chr(38), '''||chr(38)||''');

  if l_1>0 and p_linesdef is not null then
    execute immediate '
    insert into meta_tables(tabid, tabname, semantic, select_statement, linesdef)
    values ('||to_char(l_tabid)||', '''||l_tabname||''', '''||l_tabsemantic||''', '''||l_tabselect_statement||''', '||
            to_char(p_linesdef)||')';
  else
    insert into meta_tables(tabid, tabname, semantic, select_statement)
    values (l_tabid, p_tabname, p_tabsemantic,p_tabselect_statement);
  end if;

end;

--***************************************************************************--
-- ���������: add_column
-- ��������:  ���������� ������������ ����� �������
--***************************************************************************--
procedure add_column (
  p_tabid             meta_tables.tabid%type,
  p_colid             meta_columns.colid%type,
  p_colname           meta_columns.colname%type,
  p_coltype           meta_columns.coltype%type,
  p_semantic          meta_columns.semantic%type,
  p_showwidth         meta_columns.showwidth%type,
  p_showmaxchar       meta_columns.showmaxchar%type,
  p_showpos           meta_columns.showpos%type,
  p_showin_ro         meta_columns.showin_ro%type,
  p_showretval        meta_columns.showretval%type,
  p_instnssemantic    meta_columns.instnssemantic%type,
  p_extrnval          meta_columns.extrnval%type,
  p_showrel_ctype     meta_columns.showrel_ctype%type,
  p_showformat        meta_columns.showformat%type,
  p_showin_fltr       meta_columns.showin_fltr%type,
  p_showref           meta_columns.showref%type             default 0,
  p_showresult        meta_columns.showresult%type          default null,
  p_nottoedit         meta_columns.not_to_edit%type         default 0,
  p_nottoshow         meta_columns.not_to_show%type         default 0,
  p_simplefilter      meta_columns.simple_filter%type       default 0,
  p_webformname       meta_columns.web_form_name%type       default null,
  p_formname          meta_columns.form_name%type           default null,
  p_inputinnewrecord  meta_columns.INPUT_IN_NEW_RECORD%type default 0)
is
  l_colid  meta_columns.colid%type;
begin
  l_colid := p_colid;
  if l_colid is null then
    l_colid := get_newcolid(p_tabid);
  end if;
  insert
  into   meta_columns (tabid         ,
                       colid         ,
                       colname       ,
                       coltype       ,
                       semantic      ,
                       showwidth     ,
                       showmaxchar   ,
                       showpos       ,
                       showin_ro     ,
                       showretval    ,
                       instnssemantic,
                       extrnval      ,
                       showrel_ctype ,
                       showformat    ,
                       showin_fltr   ,
                       showref       ,
                       showresult    ,
                       not_to_edit   ,
                       not_to_show   ,
                       simple_filter ,
                       form_name     ,
                       web_form_name ,
                       input_in_new_record)
               values (p_tabid                ,
                       l_colid                ,
                       p_colname              ,
                       p_coltype              ,
                       p_semantic             ,
                       p_showwidth            ,
                       p_showmaxchar          ,
                       p_showpos              ,
                       nvl(p_showin_ro,0)     ,
                       nvl(p_showretval,0)    ,
                       nvl(p_instnssemantic,0),
                       nvl(p_extrnval,0)      ,
                       p_showrel_ctype        ,
                       p_showformat           ,
                       nvl(p_showin_fltr,0)   ,
                       nvl(p_showref,0)       ,
                       p_showresult           ,
                       nvl(p_nottoedit,0)     ,
                       nvl(p_nottoshow,0)     ,
                       nvl(p_simplefilter,0)  ,
                       p_formname             ,
                       p_webformname          ,
                       nvl(p_inputinnewrecord,0));
end;

--***************************************************************************--
-- ���������: add_extrnval
-- ��������:  ���������� �������� ������ ������
--***************************************************************************--
procedure add_extrnval (
  p_tabid          meta_extrnval.tabid%type,
  p_colid          meta_extrnval.colid%type,
  p_srctabid       meta_extrnval.srctabid%type,
  p_srccolid       meta_extrnval.srccolid%type,
  p_tab_alias      meta_extrnval.tab_alias%type,
  p_tab_cond       meta_extrnval.tab_cond%type default null,
  p_src_cond       meta_extrnval.src_cond%type default null,
  p_coldyntabname  varchar2                    default null)
is
begin
  if FieldInTable('COL_DYN_TABNAME','META_EXTRNVAL')=1 then
    execute immediate '
    insert
    into   meta_extrnval (tabid    ,
                          colid    ,
                          srctabid ,
                          srccolid ,
                          tab_alias,
                          tab_cond ,
                          src_cond ,
                          COL_DYN_TABNAME)
                  values ('''||p_tabid        ||''',
                          '''||p_colid        ||''',
                          '''||p_srctabid     ||''',
                          '''||p_srccolid     ||''',
                          '''||p_tab_alias    ||''',
                          '''||p_tab_cond     ||''',
                          '''||p_src_cond     ||''',
                          '''||p_coldyntabname||''')';
  else
    insert
    into   meta_extrnval (tabid    ,
                          colid    ,
                          srctabid ,
                          srccolid ,
                          tab_alias,
                          tab_cond ,
                          src_cond)
                  values (p_tabid    ,
                          p_colid    ,
                          p_srctabid ,
                          p_srccolid ,
                          p_tab_alias,
                          p_tab_cond ,
                          p_src_cond);
  end if;
end;

--***************************************************************************--
-- ���������: add_browsetbl
-- ��������:  ���������� �������� ����� ��� ������� ��������
--***************************************************************************--
procedure add_browsetbl (
  p_hosttabid    meta_browsetbl.hosttabid%type,
  p_addtabid     meta_browsetbl.addtabid%type,
  p_addtabalias  meta_browsetbl.addtabalias%type,
  p_hostcolkeyid meta_browsetbl.hostcolkeyid%type,
  p_addcolkeyid  meta_browsetbl.addcolkeyid%type,
  p_var_colid    meta_browsetbl.var_colid%type,
  p_cond_tag     meta_browsetbl.cond_tag%type)
is
begin

  insert into meta_browsetbl(hosttabid, addtabid, addtabalias,
    hostcolkeyid, addcolkeyid, var_colid, cond_tag)
  values (p_hosttabid, p_addtabid, p_addtabalias,
    p_hostcolkeyid, p_addcolkeyid, p_var_colid, p_cond_tag);

end;

--***************************************************************************--
-- ���������: add_sortorder
-- ��������:  ���������� �������� ���������� �������
--***************************************************************************--
procedure add_sortorder (
  p_tabid     meta_sortorder.tabid%type,
  p_colid     meta_sortorder.colid%type,
  p_sortorder meta_sortorder.sortorder%type,
  p_sortway   meta_sortorder.sortway%type)
is
begin

  insert into meta_sortorder(tabid, colid, sortorder, sortway)
  values (p_tabid, p_colid, p_sortorder, p_sortway);

end;

--***************************************************************************--
-- ���������: add_filtertbl
-- ��������:  ���������� �������� ��������� ������
--***************************************************************************--
procedure add_filtertbl (
  p_tabid     meta_filtertbl.tabid%type,
  p_colid     meta_filtertbl.colid%type,
  p_flt_tabid meta_filtertbl.filter_tabid%type,
  p_flt_code  meta_filtertbl.filter_code%type,
  p_flg_ins   meta_filtertbl.flag_ins%type default 0,
  p_flg_del   meta_filtertbl.flag_del%type default 0,
  p_flg_upd   meta_filtertbl.flag_upd%type default 0)
is
begin

  insert into meta_filtertbl(tabid, colid, filter_tabid, filter_code, flag_ins, flag_del, flag_upd)
  values (p_tabid, p_colid, p_flt_tabid, p_flt_code, p_flg_ins, p_flg_del, p_flg_upd);

end;

--***************************************************************************--
-- ���������: add_actiontbl
-- ��������:  ���������� �������� �������� �������
--***************************************************************************--
procedure add_actiontbl (
  p_tabid     meta_actiontbl.tabid%type,
  p_code      meta_actiontbl.action_code%type,
  p_proc      meta_actiontbl.action_proc%type)
is
begin

  insert into meta_actiontbl (tabid, action_code, action_proc)
  values (p_tabid, p_code, p_proc);

end;

--***************************************************************************--
-- ���������: add_nsifunction
-- ��������:  ���������� �������� ������� �����������
--***************************************************************************--
procedure add_nsifunction (
  p_tabid        meta_nsifunction.tabid%type,
  p_funcid       meta_nsifunction.funcid%type,
  p_descr        meta_nsifunction.descr%type,
  p_procname     meta_nsifunction.proc_name%type,
  p_procpar      meta_nsifunction.proc_par%type,
  p_procexec     meta_nsifunction.proc_exec%type,
  p_qst          meta_nsifunction.qst%type,
  p_msg          meta_nsifunction.msg%type,
  p_formname     meta_nsifunction.form_name%type,
  p_checkfunc    meta_nsifunction.check_func%type,
  p_webformname  varchar2 default null,
  p_iconid       int default 0)
is
  l_webformname  varchar2(254);
begin

  insert
  into   meta_nsifunction (tabid,
                           funcid,
                           descr,
                           proc_name,
                           proc_par,
                           proc_exec,
                           qst,
                           msg,
                           form_name,
                           check_func)
                   values (p_tabid,
                           p_funcid,
                           p_descr,
                           p_procname,
                           p_procpar,
                           p_procexec,
                           p_qst,
                           p_msg,
                           p_formname,
                           p_checkfunc);

  begin
    l_webformname := replace(replace(p_webformname, chr(39), chr(39) || chr(39)),
                                                    chr(38), '''||chr(38)||''');
    execute immediate '
    update meta_nsifunction
    set    web_form_name='''||l_webformname||'''
    where  tabid='||to_char(p_tabid)||' and
           funcid='||to_char(p_funcid);
  exception when others then
    null;
  end;

  begin
    execute immediate '
    update meta_nsifunction
    set    icon_id='||nvl(to_char(p_iconid),'null')||'
    where  tabid='||to_char(p_tabid)||' and
           funcid='||to_char(p_funcid);
  exception when others then
    null;
  end;

end;
--***************************************************************************--
-- ���������: add_dependency
-- ��������:  ���������� ����������� ����� ��������� �������
--***************************************************************************--
procedure add_dependency (
  p_tabid         number,
  p_colid         number,
  p_event         varchar2,
  p_depcolid      number,
  p_action_type   varchar2,
  p_action_name   varchar2,
  p_default_value varchar2,
  p_condition     varchar2
  )
is
begin
  insert into meta_dependency_cols
    (id, tabid, colid, event, depcolid,
     action_type, action_name, default_value, condition)
  values
    (s_meta_dependency_cols.nextval, p_tabid, p_colid, p_event, p_depcolid,
     p_action_type, p_action_name, p_default_value, p_condition);
end;
--***************************************************************************--
-- ���������: update_table
-- ��������:  ���������� �������� �������
--***************************************************************************--
procedure update_table (
  p_tabid       meta_tables.tabid%type   ,
  p_tabname     meta_tables.tabname%type ,
  p_tabsemantic meta_tables.semantic%type,
  p_linesdef    meta_tables.linesdef%type)
is
  l_1           int;
begin

  select count(1)
  into   l_1
  from   user_tab_columns
  where  table_name='META_TABLES' and
         COLUMN_NAME='LINESDEF';

  if l_1>0 then
    if p_linesdef is not null then
      execute immediate '
      update meta_tables
      set    tabname ='''||p_tabname    ||''',
             semantic='''||p_tabsemantic||''',
             linesdef='||to_char(p_linesdef)||'
      where  tabid='||to_char(p_tabid);
    else
      execute immediate '
      update meta_tables
      set    tabname ='''||p_tabname    ||''',
             semantic='''||p_tabsemantic||''',
             linesdef=null
      where  tabid='||to_char(p_tabid);
    end if;
  else
    update meta_tables
    set    tabname =p_tabname,
           semantic=p_tabsemantic
    where  tabid=p_tabid;
  end if;

end;

--***************************************************************************--
-- ���������: update_columnn
-- ��������:  ���������� �������� �������
--***************************************************************************--
procedure update_column (
  p_tabid             meta_tables.tabid%type,
  p_colid             meta_columns.colid%type,
  p_colname           meta_columns.colname%type,
  p_coltype           meta_columns.coltype%type,
  p_semantic          meta_columns.semantic%type,
  p_showwidth         meta_columns.showwidth%type,
  p_showmaxchar       meta_columns.showmaxchar%type,
  p_showpos           meta_columns.showpos%type,
  p_showin_ro         meta_columns.showin_ro%type,
  p_showretval        meta_columns.showretval%type,
  p_instnssemantic    meta_columns.instnssemantic%type,
  p_extrnval          meta_columns.extrnval%type,
  p_showrel_ctype     meta_columns.showrel_ctype%type,
  p_showformat        meta_columns.showformat%type,
  p_showin_fltr       meta_columns.showin_fltr%type,
  p_showref           meta_columns.showref%type             default 0,
  p_showresult        meta_columns.showresult%type          default null,
  p_nottoedit         meta_columns.not_to_edit%type         default 0,
  p_nottoshow         meta_columns.not_to_show%type         default 0,
  p_simplefilter      meta_columns.simple_filter%type       default 0,
  p_formname          meta_columns.form_name%type           default null,
  p_webformname       meta_columns.web_form_name%type       default null,
  p_inputinnewrecord  meta_columns.input_in_new_record%type default 0)
is
begin

  update meta_columns
  set    colname             = p_colname,
         coltype             = p_coltype,
         semantic            = p_semantic,
         showwidth           = p_showwidth,
         showmaxchar         = p_showmaxchar,
         showpos             = p_showpos,
         showin_ro           = nvl(p_showin_ro,0),
         showretval          = nvl(p_showretval,0),
         instnssemantic      = nvl(p_instnssemantic,0),
         extrnval            = nvl(p_extrnval,0),
         showrel_ctype       = p_showrel_ctype,
         showformat          = p_showformat,
         showin_fltr         = nvl(p_showin_fltr,0),
         showref             = nvl(p_showref,0),
         showresult          = p_showresult,
         not_to_edit         = nvl(p_nottoedit,0),
         not_to_show         = nvl(p_nottoshow,0),
         simple_filter       = nvl(p_simplefilter,0),
         form_name           = p_formname,
         web_form_name       = p_webformname,
         input_in_new_record = nvl(p_inputinnewrecord,0)
  where  tabid = p_tabid and
         colid = p_colid;

end;

--***************************************************************************--
-- ���������: update_extrnval
-- ��������:  ���������� �������� ������ �������
--***************************************************************************--
procedure update_extrnval (
  p_tabid          meta_extrnval.tabid%type,
  p_colid          meta_extrnval.colid%type,
  p_srctabid       meta_extrnval.srctabid%type,
  p_srccolid       meta_extrnval.srccolid%type,
  p_tab_alias      meta_extrnval.tab_alias%type,
  p_tab_cond       meta_extrnval.tab_cond%type default null,
  p_coldyntabname  varchar2                    default null)
is
begin
  if FieldInTable('COL_DYN_TABNAME','META_EXTRNVAL')=1 then
    execute immediate '
    update meta_extrnval
       set srctabid        = '''||p_srctabid     ||''',
           srccolid        = '''||p_srccolid     ||''',
           tab_alias       = '''||p_tab_alias    ||''',
           tab_cond        = '''||p_tab_cond     ||''',
           COL_DYN_TABNAME = '''||p_coldyntabname||'''
     where tabid = '''||p_tabid||'''
       and colid = '''||p_colid||'''';
  else
    update meta_extrnval
       set srctabid  = p_srctabid,
           srccolid  = p_srccolid,
           tab_alias = p_tab_alias,
           tab_cond  = p_tab_cond
     where tabid = p_tabid
       and colid = p_colid;
  end if;
end;

--***************************************************************************--
-- ���������: update_browsetbl
-- ��������:  ���������� �������� ����� ��� ������� ��������
--***************************************************************************--
procedure update_browsetbl (
  p_hosttabid    meta_browsetbl.hosttabid%type,
  p_addtabid     meta_browsetbl.addtabid%type,
  p_addtabalias  meta_browsetbl.addtabalias%type,
  p_hostcolkeyid meta_browsetbl.hostcolkeyid%type,
  p_addcolkeyid  meta_browsetbl.addcolkeyid%type,
  p_var_colid    meta_browsetbl.var_colid%type,
  p_cond_tag     meta_browsetbl.cond_tag%type)
is
begin

  update meta_browsetbl
     set addtabalias = p_addtabalias,
         cond_tag    = p_cond_tag
   where hosttabid    = p_hosttabid
     and hostcolkeyid = p_hostcolkeyid
     and addtabid     = p_addtabid
     and addcolkeyid  = p_addcolkeyid
     and var_colid    = p_var_colid;

end;

--***************************************************************************--
-- ���������: update_sortorder
-- ��������:  ���������� �������� ���������� �������
--***************************************************************************--
procedure update_sortorder (
  p_tabid     meta_sortorder.tabid%type,
  p_colid     meta_sortorder.colid%type,
  p_sortorder meta_sortorder.sortorder%type,
  p_sortway   meta_sortorder.sortway%type)
is
begin

  update meta_sortorder
     set sortorder = p_sortorder,
         sortway   = p_sortway
   where tabid = p_tabid
     and colid = p_colid;

end;

--***************************************************************************--
-- ���������: update_filtertbl
-- ��������:  ���������� �������� ��������� ������
--***************************************************************************--
procedure update_filtertbl (
  p_tabid     meta_filtertbl.tabid%type,
  p_colid     meta_filtertbl.colid%type,
  p_flt_tabid meta_filtertbl.filter_tabid%type,
  p_flt_code  meta_filtertbl.filter_code%type,
  p_flg_ins   meta_filtertbl.flag_ins%type default 0,
  p_flg_del   meta_filtertbl.flag_del%type default 0,
  p_flg_upd   meta_filtertbl.flag_upd%type default 0)
is
begin

  update meta_filtertbl
     set filter_tabid = p_flt_tabid,
         filter_code  = p_flt_code,
         flag_ins     = p_flg_ins,
         flag_del     = p_flg_del,
         flag_upd     = p_flg_upd
   where tabid = p_tabid
     and colid = p_colid;

end;

--***************************************************************************--
-- ���������: update_actiontbl
-- ��������:  ���������� �������� �������� �������
--***************************************************************************--
procedure update_actiontbl (
  p_tabid     meta_actiontbl.tabid%type,
  p_code      meta_actiontbl.action_code%type,
  p_proc      meta_actiontbl.action_proc%type)
is
begin

  update meta_actiontbl
     set action_proc = p_proc
   where tabid       = p_tabid
     and action_code = p_code;

end;

--***************************************************************************--
-- ���������: update_dependency
-- ��������:  ���������� ����������� ����� ��������� �������
--***************************************************************************--
procedure update_dependency (
  p_id            number,
  p_event         varchar2,
  p_action_type   varchar2,
  p_action_name   varchar2,
  p_default_value varchar2,
  p_condition     varchar2)
is
begin

  update meta_dependency_cols
     set event = p_event,
         action_type = p_action_type,
         action_name = p_action_name,
         default_value = p_default_value,
         condition     = p_condition
   where id = p_id;

end;

--***************************************************************************--
-- ���������: sync_column
-- ��������:  �������������(���������� ��������) �������
--***************************************************************************--
procedure sync_column (
  p_tabid          meta_tables.tabid%type,
  p_colname        meta_columns.colname%type,
  p_coltype        meta_columns.coltype%type,
  p_semantic       meta_columns.semantic%type,
  p_showmaxchar    meta_columns.showmaxchar%type)
is
begin

  update meta_columns
     set coltype        = p_coltype,
         semantic       = p_semantic,
         showmaxchar    = p_showmaxchar
   where tabid   = p_tabid
     and colname = p_colname;

end;

--***************************************************************************--
-- ���������: delete_table
-- ��������:  �������� �������� �������
--***************************************************************************--
procedure delete_table (p_tabid meta_tables.tabid%type)
is
begin

  delete from meta_tables where tabid = p_tabid;

end;

--***************************************************************************--
-- ���������: delete_column
-- ��������:  �������� �������� �������
--***************************************************************************--
procedure delete_column (
  p_tabid meta_columns.tabid%type,
  p_colid meta_columns.colid%type)
is
begin

  delete from meta_columns
   where tabid = p_tabid
     and colid = p_colid;

end;

--***************************************************************************--
-- ���������: delete_extrnval
-- ��������:  �������� �������� ������ �������
--***************************************************************************--
procedure delete_extrnval (
  p_tabid meta_extrnval.tabid%type,
  p_colid meta_extrnval.colid%type)
is
begin

  delete from meta_extrnval
   where tabid = p_tabid
     and colid = p_colid;

end;

--***************************************************************************--
-- ���������: delete_browsetbl
-- ��������:  �������� �������� ����� ��� ������� ��������
--***************************************************************************--
procedure delete_browsetbl (
  p_hosttabid    meta_browsetbl.hosttabid%type,
  p_addtabid     meta_browsetbl.addtabid%type,
  p_hostcolkeyid meta_browsetbl.hostcolkeyid%type,
  p_addcolkeyid  meta_browsetbl.addcolkeyid%type,
  p_var_colid    meta_browsetbl.var_colid%type)
is
begin

  delete from meta_browsetbl
   where hosttabid    = p_hosttabid
     and hostcolkeyid = p_hostcolkeyid
     and addtabid     = p_addtabid
     and addcolkeyid  = p_addcolkeyid
     and var_colid    = p_var_colid;

end;

--***************************************************************************--
-- ���������: delete_sortorder
-- ��������:  �������� �������� ���������� �������
--***************************************************************************--
procedure delete_sortorder (
  p_tabid meta_sortorder.tabid%type,
  p_colid meta_sortorder.colid%type)
is
begin

  delete from meta_sortorder
   where tabid = p_tabid
     and colid = p_colid;

end;

--***************************************************************************--
-- ���������: delete_filtertbl
-- ��������:  �������� �������� ��������� ������
--***************************************************************************--
procedure delete_filtertbl (
  p_tabid meta_filtertbl.tabid%type,
  p_colid meta_filtertbl.colid%type)
is
begin

  delete from meta_filtertbl
   where tabid = p_tabid
     and colid = p_colid;

end;

--***************************************************************************--
-- ���������: delete_actiontbl
-- ��������:  �������� �������� �������� �������
--***************************************************************************--
procedure delete_actiontbl (
  p_tabid meta_actiontbl.tabid%type,
  p_code  meta_actiontbl.action_code%type)
is
begin

  delete from meta_actiontbl
   where tabid       = p_tabid
     and action_code = p_code;

end;

--***************************************************************************--
-- ���������: delete_nsifunction
-- ��������:  �������� �������� ������� �����������
--***************************************************************************--
procedure delete_nsifunction (
  p_tabid     meta_nsifunction.tabid%type)
is
begin

  delete from meta_nsifunction
   where tabid  = p_tabid;

end;

--***************************************************************************--
-- ���������: delete_dependency
-- ��������:  �������� ����������� ����� ��������� �������
--***************************************************************************--
procedure delete_dependency (p_id number)
is
begin

  delete from meta_dependency_cols
   where id  = p_id;

end;

--***************************************************************************--
-- ���������: change_filter
-- ��������:
--***************************************************************************--
procedure change_filter (
  p_code      meta_filtercodes.code%type,
  p_name      meta_filtercodes.name%type,
  p_condition meta_filtercodes.condition%type)
is
begin
  update meta_filtercodes
     set name = p_name,
         condition = p_condition
   where code = p_code;
  if sql%rowcount = 0 then
     insert into meta_filtercodes (code, name, condition)
     values (p_code, p_name, p_condition);
  end if;
end;

--***************************************************************************--
-- ���������: delete_filter
-- ��������:
--***************************************************************************--
procedure delete_filter (p_code meta_filtercodes.code%type)
is
begin
  delete from meta_filtercodes where code = p_code;
end;

--***************************************************************************--
-- ���������: addTableToRef
-- ��������:  ���������� ������� � �����������
--***************************************************************************--
procedure addTableToRef (
  p_tabid  references.tabid%type,
  p_refid  references.type%type)
is
  i number;
begin

  begin
     select count(*) into i from meta_tables where tabid = p_tabid;
  exception when no_data_found then
     -- ��������� ������ (��� %s) �� �������
     bars_error.raise_nerror(g_modcode, 'TABLE_NOT_FOUND', to_char(p_tabid));
  end;

  begin
     select count(*) into i from typeref where type = p_refid;
  exception when no_data_found then
     -- ��������� ��� ������������ (��� %s) �� ������
     bars_error.raise_nerror(g_modcode, 'REF_NOT_FOUND', to_char(p_refid));
  end;

  if p_tabid is not null and p_refid is not null then
     begin
        insert into references (tabid, type)
        values (p_tabid, p_refid);
     exception when dup_val_on_index then null;
     end;
  end if;

end addTableToRef;

--***************************************************************************--
-- ���������: add_tblcolor
-- ��������:  ���������� ������������ ��������� �������
--***************************************************************************--
procedure add_tblcolor (
  p_tabid      meta_tblcolor.tabid%type,
  p_ord        meta_tblcolor.ord%type,
  p_colid      meta_tblcolor.colid%type,
  p_condition  meta_tblcolor.condition%type,
  p_colorindex meta_tblcolor.color_index%type,
  p_colorname  meta_tblcolor.color_name%type)
is
begin
  insert into meta_tblcolor (tabid, ord, colid, condition, color_index, color_name)
  values (p_tabid, p_ord, p_colid, p_condition, p_colorindex, p_colorname);
end add_tblcolor;

--***************************************************************************--
-- ���������: delete_tblcolor
-- ��������:  �������� ������������ ��������� �������
--***************************************************************************--
procedure delete_tblcolor (
  p_tabid meta_tblcolor.tabid%type)
is
begin
  delete from meta_tblcolor where tabid = p_tabid;
end delete_tblcolor;


--***************************************************************************--
-- ���������: get_click_action_form
-- ��������:  ������ ������ ������ ������� ��� ������������ ��� ������� ����� �� ������+�������
--***************************************************************************--
function  get_click_action_form
          (p_tabid  number,     -- ��� �������
           p_colid  varchar2    -- ��� �������
          ) return  varchar2    -- ���� ����� �� ���������� ��� ������� - ���������� ������ ������
is
	l_func_name  operlist.funcname%type;
begin
   select funcname into l_func_name
     from operlist o, meta_columns m
    where tabid      = p_tabid
	  and p_colid    = p_colid
	  and m.oper_id  = o.codeoper;
   return l_func_name;
exception when no_data_found then
   return '';
end;


--***************************************************************************--
-- ���������: import_bmd
-- ��������:  �������� ����� ������������ �������
--***************************************************************************--
procedure import_bmd (p_tabname varchar2, p_filename varchar2)
is
  l_clob      clob;
  l_tabid     meta_tables.tabid%type;
  l_semantic  meta_tables.semantic%type;
  l_linesdef  meta_tables.linesdef%type;
  l_select_statement meta_tables.select_statement%type;
  l_accpar    number;
  type             cur is ref cursor;
  cur_             cur;
  sql_             varchar2(1024);
  l_funcid         meta_nsifunction.funcid%type;
  l_descr          meta_nsifunction.descr%type;
  l_proc_name      meta_nsifunction.proc_name%type;
  l_proc_par       meta_nsifunction.proc_par%type;
  l_proc_exec      meta_nsifunction.proc_exec%type;
  l_qst            meta_nsifunction.qst%type;
  l_msg            meta_nsifunction.msg%type;
  l_form_name      meta_nsifunction.form_name%type;
  l_check_func     meta_nsifunction.check_func%type;
  l_web_form_name  varchar2(254);
  l_icon_id        int;

procedure add_line (p_line varchar2)
is
begin
  l_clob := l_clob || p_line || chr(10);
end add_line;

begin

  begin
     select tabid, semantic, linesdef, replace(select_statement,chr(39),chr(39)||chr(39)) select_statement
       into l_tabid, l_semantic, l_linesdef, l_select_statement
       from meta_tables
      where tabname = p_tabname;
  exception when no_data_found then
     raise_application_error(-20000, '������� ' || p_tabname || ' �� ������� � ���� ����������!');
  end;

  delete from imp_file where file_name = p_filename;

$if $$module_gl $then
  select count(*) into l_accpar from acc_par where tabid = l_tabid;
$end

  add_line('set serveroutput on');
  add_line('');
  add_line('declare');
  add_line('');
  add_line('  type t_rec_extrnval is record (');
  add_line('    tabid            meta_extrnval.tabid%type,');
  add_line('    colid            meta_extrnval.colid%type,');
  add_line('    srccolname       meta_columns.colname%type,');
  add_line('    tab_alias        meta_extrnval.tab_alias%type,');
  add_line('    tab_cond         meta_extrnval.tab_cond%type,');
  add_line('    src_cond         meta_extrnval.src_cond%type,');
  add_line('    col_dyn_tabname  varchar2(30));');
  add_line('  type t_tab_extrnval is table of t_rec_extrnval;');
  add_line('  l_extrnval     t_tab_extrnval := t_tab_extrnval();');
  add_line('');

  add_line('  type t_rec_browsetbl is record (');
  add_line('    hosttabid   meta_browsetbl.hosttabid%type,');
  add_line('    hostcolid   meta_browsetbl.hostcolkeyid%type,');
  add_line('    addcolname  meta_columns.colname%type,');
  add_line('    varcolname  meta_columns.colname%type,');
  add_line('    addtabalias meta_browsetbl.addtabalias%type,');
  add_line('    cond_tag    meta_browsetbl.cond_tag%type);');
  add_line('  type t_tab_browsetbl is table of t_rec_browsetbl;');
  add_line('  l_browsetbl    t_tab_browsetbl := t_tab_browsetbl();');
  add_line('');

  add_line('  type t_rec_filtertbl is record (');
  add_line('    tabid       meta_filtertbl.tabid%type,');
  add_line('    colid       meta_filtertbl.colid%type,');
  add_line('    fltcode     meta_filtertbl.filter_code%type,');
  add_line('    flag_ins    meta_filtertbl.flag_ins%type,');
  add_line('    flag_del    meta_filtertbl.flag_del%type,');
  add_line('    flag_upd    meta_filtertbl.flag_upd%type);');
  add_line('  type t_tab_filtertbl is table of t_rec_filtertbl;');
  add_line('  l_filtertbl    t_tab_filtertbl := t_tab_filtertbl();');
  add_line('');

$if $$module_gl $then
  if l_accpar > 0 then
  add_line('  type t_rec_accpar is record (');
  add_line('     colname     meta_columns.colname%type,');
  add_line('     pr          acc_par.pr%type);');
  add_line('  type t_tab_accpar is table of t_rec_accpar;');
  add_line('  l_accpar       t_tab_accpar := t_tab_accpar();');
  add_line('');
  end if;

$end
  add_line('  type t_rec_dependency is record (');
  add_line('    id               meta_dependency_cols.id%type,');
  add_line('    tabid            meta_dependency_cols.tabid%type,');
  add_line('    colid            meta_dependency_cols.colid%type,');
  add_line('    event            meta_dependency_cols.event%type,');
  add_line('    depcolid         meta_dependency_cols.depcolid%type,');
  add_line('    action_type      meta_dependency_cols.action_type%type,');
  add_line('    action_name      meta_dependency_cols.action_name%type,');
  add_line('    default_value    meta_dependency_cols.default_value%type,');
  add_line('    condition        meta_dependency_cols.condition%type);');
  add_line('  type t_tab_dependency is table of t_rec_dependency;');
  add_line('  l_dependency     t_tab_dependency := t_tab_dependency();');
  add_line('');

  add_line('  l_tabid        meta_tables.tabid%type;');
  add_line('  l_tabname      meta_tables.tabname%type;');
  add_line('  l_tabsemantic  meta_tables.semantic%type;');
  add_line('  l_tablinesdef  varchar2(16);');
  add_line('  l_tabselect_statement meta_tables.select_statement%type;');
  add_line('  l_newtabid     meta_tables.tabid%type;');
  add_line('  l_newcolid     meta_columns.colid%type;');
  add_line('  l_varcolid     meta_columns.colid%type;');
  add_line('  l_colname      meta_columns.colname%type;');
  add_line('');

  add_line('begin');
  add_line('');
  add_line('  l_tabsemantic := ''' || l_semantic || ''';');
  add_line('  l_tablinesdef := ''' || l_linesdef || ''';');
  add_line('  l_tabselect_statement := ''' || l_select_statement || ''';');
  add_line('  l_tabname     := ''' || p_tabname || ''';');
  add_line('');
  add_line('  -- �������� ��� �������');
  add_line('  l_tabid := bars_metabase.get_tabid(l_tabname);');
  add_line('');
  add_line('  -- ���� ������� �� ������� � ���');
  add_line('  if l_tabid is null then');
  add_line('');
  add_line('    -- �������� ��� ��� ����� �������');
  add_line('    l_tabid := bars_metabase.get_newtabid();');
  add_line('');
  add_line('    -- ��������� �������� ������� � ���');
  add_line('    bars_metabase.add_table(l_tabid, l_tabname, l_tabsemantic, l_tabselect_statement);');
  add_line('');
  add_line('  -- ���� ������� ������� � ���');
  add_line('  else');
  add_line('');
  add_line('    -- ��������� ��������� �������');
  add_line('    bars_metabase.set_tabsemantic(l_tabid, l_tabsemantic);');
  add_line('');
  add_line('    -- ��������� linesdef �������');
  add_line('    bars_metabase.set_tablinesdef(l_tabid, l_tablinesdef);');
  add_line('');
  add_line('    -- ��������� select_statement �������');-------------
  add_line('    bars_metabase.set_tabselect_statement(l_tabid, l_tabselect_statement);');
  add_line('');
  add_line('    -- ��������� ������ ������� ����� ������ ������ �� ���� ����� �������');
  add_line('    select e.tabid, e.colid, c.colname, e.tab_alias, e.tab_cond, e.src_cond, e.col_dyn_tabname');
  add_line('      bulk collect');
  add_line('      into l_extrnval');
  add_line('      from meta_extrnval e, meta_columns c');
  add_line('     where e.srctabid = l_tabid');
  add_line('       and e.srctabid = c.tabid and e.srccolid = c.colid;');
  add_line('');
  add_line('    -- ��������� ������ ��� ������� ������� ����� ������ ������ �� ���� ����� �������');
  add_line('    select b.hosttabid, b.hostcolkeyid, c.colname, v.colname, b.addtabalias, v.semantic');
  add_line('      bulk collect');
  add_line('      into l_browsetbl');
  add_line('      from meta_browsetbl b, meta_columns c, meta_columns v');
  add_line('     where b.addtabid = l_tabid');
  add_line('       and b.addtabid = c.tabid and b.addcolkeyid = c.colid');
  add_line('       and b.addtabid = v.tabid and b.var_colid = v.colid;');
  add_line('');
  add_line('    -- ��������� ������ ����� ������ ������ �� ���� ��������� �������');
  add_line('    select tabid, colid, filter_code, flag_ins, flag_del, flag_upd');
  add_line('      bulk collect');
  add_line('      into l_filtertbl');
  add_line('      from meta_filtertbl');
  add_line('     where filter_tabid = l_tabid and tabid <> l_tabid;');
  add_line('');

$if $$module_gl $then
  if l_accpar > 0 then
  add_line('    -- ��������� ������ ����� ����������� "��������� �������� � ������" �� ���� ����� �������');
  add_line('    select c.colname, a.pr');
  add_line('      bulk collect');
  add_line('      into l_accpar');
  add_line('      from acc_par a, meta_columns c');
  add_line('     where a.tabid = l_tabid');
  add_line('       and a.tabid = c.tabid');
  add_line('       and a.colid = c.colid;');
  add_line('');
  end if;

$end

  add_line('    -- ��������� ����������� ����� ��������� �������');
  add_line('    select id, tabid, colid, event, depcolid, action_type, action_name, default_value, condition');
  add_line('      bulk collect');
  add_line('      into l_dependency');
  add_line('      from meta_dependency_cols');
  add_line('     where tabid = l_tabid;');
  add_line('');

  add_line('    -- ������� �������� �����');
$if $$module_gl $then
  if l_accpar > 0 then
  add_line('    delete from acc_par where tabid=l_tabid;');
  end if;
$end
  add_line('    bars_metabase.delete_metatables(l_tabid);');
  add_line('');
  add_line('  end if;');
  add_line('');

  add_line('  -- ��������� �������� �����');
  for c in (select colid                                                        ,
                   colname                                                      ,
                   coltype                                                      ,
                   semantic                                                     ,
                   nvl(''''||to_char(showwidth)||'''',           'null') showwidth          ,
                   nvl(to_char(showmaxchar),         'null') showmaxchar        ,
                   nvl(to_char(showpos),             'null') showpos            ,
                   nvl(to_char(showin_ro),           'null') showin_ro          ,
                   nvl(to_char(showretval),          'null') showretval         ,
                   nvl(to_char(instnssemantic),      'null') instnssemantic     ,
                   nvl(to_char(extrnval),            'null') extrnval           ,
                   showrel_ctype                                                ,
                   showformat                                                   ,
                   nvl(to_char(showin_fltr),         'null') showin_fltr        ,
                   nvl(to_char(showref),             'null') showref            ,
                   showresult                                                   ,
                   nvl(to_char(not_to_edit),         'null') not_to_edit        ,
                   nvl(to_char(not_to_show),         'null') not_to_show        ,
                   nvl(to_char(simple_filter),       'null') simple_filter      ,
                   nvl(to_char(INPUT_IN_NEW_RECORD), 'null') INPUT_IN_NEW_RECORD,
                   form_name                                                    ,
                   web_form_name
            from   meta_columns
            where  tabid = l_tabid
            order by colid)
  loop
    c.semantic      := replace(replace(c.semantic,      chr(39), chr(39) || chr(39)),chr(38), '''||chr(38)||''');
    c.showresult    := replace(replace(c.showresult,    chr(39), chr(39) || chr(39)),chr(38), '''||chr(38)||''');
    c.form_name     := replace(replace(c.form_name,     chr(39), chr(39) || chr(39)),chr(38), '''||chr(38)||''');
    c.web_form_name := replace(replace(c.web_form_name, chr(39), chr(39) || chr(39)),chr(38), '''||chr(38)||''');
    add_line('  bars_metabase.add_column(l_tabid, ' ||
              c.colid         || ', '''   || c.colname             || ''', ''' ||
              c.coltype       || ''', ''' || c.semantic            || ''', '   ||
              c.showwidth     || ', '     || c.showmaxchar         || ', '     ||
              c.showpos       || ', '     || c.showin_ro           || ', '     ||
              c.showretval    || ', '     || c.instnssemantic      || ', '     ||
              c.extrnval      || ', '''   || c.showrel_ctype       || ''', ''' ||
              c.showformat    || ''', '   || c.showin_fltr         || ', '     ||
              c.showref       || ', '''   || c.showresult          || ''', '   ||
              c.not_to_edit   || ', '     || c.not_to_show         || ', '     ||
              c.simple_filter || ', '''   || c.web_form_name       || ''', ''' ||
              c.form_name     || ''', '   || c.INPUT_IN_NEW_RECORD || ');');
  end loop;
  add_line('');

  for e in (select nvl(to_char(e.colid), 'null') colid     ,
                   t.tabname                     srctabname,
                   c.colname                     srccolname,
                   e.tab_alias                             ,
                   e.tab_cond                              ,
                   e.src_cond                              ,
                   e.col_dyn_tabname
            from   meta_extrnval e,
                   meta_tables   t,
                   meta_columns  c
            where  e.tabid    = l_tabid and
                   e.srctabid = t.tabid and
                   e.srctabid = c.tabid and
                   e.srccolid = c.colid)
  loop
    add_line('  -- ��������� �������� �������� ����');
    add_line('  l_newtabid := bars_metabase.get_tabid(''' || e.srctabname || ''');');
    add_line('  l_newcolid := bars_metabase.get_colid(l_newtabid, ''' || e.srccolname || ''');');
    add_line('  if (l_newtabid is not null and l_newcolid is not null) then');
    add_line('    bars_metabase.add_extrnval(l_tabid, ' || e.colid || ', l_newtabid, l_newcolid, ''' || e.tab_alias || ''', ''' ||
                  replace(replace(e.tab_cond,        chr(39), chr(39)||chr(39)),chr(38),'''||chr(38)||''') || ''', ''' ||
                  replace(replace(e.src_cond,        chr(39), chr(39)||chr(39)),chr(38),'''||chr(38)||''') || ''', ''' ||
                  replace(replace(e.col_dyn_tabname, chr(39), chr(39)||chr(39)),chr(38),'''||chr(38)||''') || ''');');
    add_line('  else');
    add_line('    dbms_output.put_line(''� ��� �� ������� ������� ' || e.srctabname || ' ��� �������� �������� ���� ������� ' || p_tabname || '.'');');
    add_line('  end if;');
    add_line('');
  end loop;

  for b in (select nvl(to_char(b.hostcolkeyid), 'null') hostcolkeyid,
                   t.tabname                            addtabname  ,
                   c.colname                            addcolname  ,
                   v.colname                            varcolname  ,
                   b.addtabalias                                    ,
                   b.cond_tag
            from   meta_browsetbl b,
                   meta_tables    t,
                   meta_columns   c,
                   meta_columns   v
            where  b.hosttabid   = l_tabid and
                   b.addtabid    = t.tabid and
                   b.addtabid    = c.tabid and
                   b.addcolkeyid = c.colid and
                   b.addtabid    = v.tabid and
                   b.var_colid   = v.colid)
  loop
    add_line('  -- ��������� �������� ��� ������� �������');
    add_line('  l_newtabid := bars_metabase.get_tabid(''' || b.addtabname || ''');');
    add_line('  l_newcolid := bars_metabase.get_colid(l_newtabid, ''' || b.addcolname || ''');');
    add_line('  l_varcolid := bars_metabase.get_colid(l_newtabid, ''' || b.varcolname || ''');');
    add_line('  if (l_newtabid is not null and l_newcolid is not null) then');
    add_line('    bars_metabase.add_browsetbl(l_tabid, l_newtabid, ''' || b.addtabalias || ''', ''' || b.hostcolkeyid || ''', l_newcolid, l_varcolid, ''' || replace(replace(b.cond_tag, chr(39), chr(39)||chr(39)),chr(38),'''||chr(38)||''') || ''');');
    add_line('  else');
    add_line('    dbms_output.put_line(''� ��� �� ������� ������� ' || b.addtabname || ' ��� �������� ������� ������� ������� ' || p_tabname || '.'');');
    add_line('  end if;');
    add_line('');
  end loop;

  for f in (select f.colid                 ,
                   t.tabname   flttabname  ,
                   d.code      fltcode     ,
                   d.name      fltname     ,
                   d.condition fltcondition,
                   f.flag_ins  fltins      ,
                   f.flag_del  fltdel      ,
                   f.flag_upd  fltupd
            from   meta_filtertbl   f,
                   meta_tables      t,
                   meta_filtercodes d
            where  f.tabid        = l_tabid and
                   f.filter_tabid = t.tabid and
                   f.filter_code  = d.code)
  loop
    add_line('  -- ��������� �������� ��������� ������');
    add_line('  l_newtabid := bars_metabase.get_tabid(''' || f.flttabname || ''');');
    add_line('  if (l_newtabid is not null) then');
    add_line('    bars_metabase.change_filter(''' || f.fltcode || ''', ''' || replace(f.fltname, chr(39), chr(39)||chr(39)) || ''', ''' || replace(f.fltcondition, chr(39), chr(39)||chr(39)) || ''');');
    add_line('    bars_metabase.add_filtertbl(l_tabid, ' || to_char(f.colid) || ', l_newtabid, '''|| f.fltcode || ''', ' ||
                  to_char(f.fltins) || ', ' || to_char(f.fltdel) || ', ' || to_char(f.fltupd) || ');');
    add_line('  else');
    add_line('    dbms_output.put_line(''� ��� �� ������� ������� ' || f.flttabname || ' ��� �������� ����������� ������� ' || p_tabname || '.'');');
    add_line('  end if;');
    add_line('');
  end loop;

  for s in (select colid    ,
                   sortorder,
                   sortway
            from   meta_sortorder
            where  tabid = l_tabid)
  loop
    add_line('  -- ��������� �������� ����������');
    add_line('  bars_metabase.add_sortorder(l_tabid, ' || s.colid || ', ' || s.sortorder || ', ''' || s.sortway || ''');');
    add_line('');
  end loop;

  for a in (select action_code code,
                   action_proc proc
            from   meta_actiontbl
            where  tabid = l_tabid)
  loop
    add_line('  -- ��������� �������� ��������');
    add_line('  bars_metabase.add_actiontbl(l_tabid, ''' || a.code || ''', ''' || replace(replace(a.proc, chr(39), chr(39)||chr(39)),chr(38),'''||chr(38)||''') || ''');');
    add_line('');
  end loop;

  add_line('  -- ������� �������� ������� �� ����������');
  add_line('  bars_metabase.delete_nsifunction(l_tabid);');
  add_line('');

--for n in (select funcid       ,
--                 descr        ,
--                 proc_name    ,
--                 proc_par     ,
--                 proc_exec    ,
--                 qst          ,
--                 msg          ,
--                 form_name    ,
--                 check_func   ,
--                 web_form_name,
--                 icon_id
--          from   meta_nsifunction
--          where  tabid = l_tabid
--          order by funcid)

  sql_ := 'select funcid       ,
                   descr     ,
                   proc_name ,
                   proc_par  ,
                   proc_exec ,
                   qst       ,
                   msg       ,
                   form_name ,
                  check_func
--                web_form_name,
--                icon_id
            from   meta_nsifunction
           where  tabid='||to_char(l_tabid)||'
           order by funcid';

  open cur_ for sql_;
  loop
    fetch cur_ into l_funcid   ,
                    l_descr    ,
                    l_proc_name,
                    l_proc_par ,
                    l_proc_exec,
                    l_qst      ,
                    l_msg      ,
                    l_form_name,
                    l_check_func;

    begin
    execute immediate 'select web_form_name
                       from   meta_nsifunction
                       where  tabid='||to_char(l_tabid)||' and
                              funcid='||to_char(l_funcid)
                       into   l_web_form_name;
    exception when others then
      l_web_form_name := null;
    end;

    begin
    execute immediate 'select icon_id
                       from   meta_nsifunction
                       where  tabid='||to_char(l_tabid)||' and
                              funcid='||to_char(l_funcid)
                       into   l_icon_id;
    exception when others then
      l_icon_id := null;
    end;

    exit when cur_%notfound;
    add_line('  -- ��������� �������� ������� �� ����������');
    add_line('  bars_metabase.add_nsifunction(l_tabid, ' || to_char(l_funcid) || ', ''' ||
                  replace(replace(l_descr,        chr(39), chr(39)||chr(39)),chr(38),'''||chr(38)||''') || ''', ''' ||
                  replace(replace(l_proc_name,    chr(39), chr(39)||chr(39)),chr(38),'''||chr(38)||''') || ''', ''' ||
                  replace(replace(l_proc_par,     chr(39), chr(39)||chr(39)),chr(38),'''||chr(38)||''') || ''', ''' ||
                  replace(replace(l_proc_exec,    chr(39), chr(39)||chr(39)),chr(38),'''||chr(38)||''') || ''', ''' ||
                  replace(replace(l_qst,          chr(39), chr(39)||chr(39)),chr(38),'''||chr(38)||''') || ''', ''' ||
                  replace(replace(l_msg,          chr(39), chr(39)||chr(39)),chr(38),'''||chr(38)||''') || ''', ''' ||
                  replace(replace(l_form_name,    chr(39), chr(39)||chr(39)),chr(38),'''||chr(38)||''') || ''', ''' ||
                  replace(replace(l_check_func,   chr(39), chr(39)||chr(39)),chr(38),'''||chr(38)||''') || ''', ''' ||
                  replace(replace(l_web_form_name,chr(39), chr(39)||chr(39)),chr(38),'''||chr(38)||''') || ''', '   ||
                  nvl(to_char(l_icon_id),'null') || ');');
    add_line('');
  end loop;
  close cur_;

  for r in (select t.ord        ,
                   c.colname    ,
                   t.condition  ,
                   t.color_index,
                   t.color_name
            from   meta_tblcolor t,
                   meta_columns  c
            where  t.tabid = l_tabid    and
                   t.tabid = c.tabid(+) and
                   t.colid = c.colid(+)
            order by t.ord)
  loop
    add_line('  -- ��������� �������� ���������');
    if r.colname is null then
      add_line('  bars_metabase.add_tblcolor(l_tabid, ' || to_char(r.ord) || ', null, ''' || replace(replace(r.condition, chr(39), chr(39)||chr(39)),chr(38),'''||chr(38)||''') || ''', ' || to_char(r.color_index) || ', ''' || r.color_name || ''');');
    else
      add_line('  l_newcolid := bars_metabase.get_colid(l_tabid, ''' || r.colname || ''');');
      add_line('  if (l_newcolid is not null) then');
      add_line('    bars_metabase.add_tblcolor(l_tabid, ' || to_char(r.ord) || ', l_newcolid, ''' || replace(replace(r.condition, chr(39), chr(39)||chr(39)),chr(38),'''||chr(38)||''') || ''', ' || to_char(r.color_index) || ', ''' || r.color_name || ''');');
      add_line('  end if;');
    end if;
    add_line('');
  end loop;

  add_line('  -- ��������������� ������ ������� ����� ������ ������');
  add_line('  for i in 1..l_extrnval.count loop');
  add_line('    l_newcolid := bars_metabase.get_colid(l_tabid, l_extrnval(i).srccolname);');
  add_line('    if (l_newcolid is not null) then');
  add_line('      bars_metabase.add_extrnval(');
  add_line('        l_extrnval(i).tabid,');
  add_line('        l_extrnval(i).colid,');
  add_line('        l_tabid,');
  add_line('        l_newcolid,');
  add_line('        l_extrnval(i).tab_alias,');
  add_line('        l_extrnval(i).tab_cond,');
  add_line('        l_extrnval(i).src_cond,');
  add_line('        l_extrnval(i).col_dyn_tabname);');
  add_line('    end if;');
  add_line('  end loop;');
  add_line('');

  add_line('  -- ��������������� ������ ����� ��� ������� ������� ������ ������');
  add_line('  for i in 1..l_browsetbl.count loop');
  add_line('    l_newcolid := bars_metabase.get_colid(l_tabid, l_browsetbl(i).addcolname);');
  add_line('    l_varcolid := bars_metabase.get_colid(l_tabid, l_browsetbl(i).varcolname);');
  add_line('    if (l_newcolid is not null and l_varcolid is not null) then');
  add_line('      bars_metabase.add_browsetbl( ');
  add_line('        l_browsetbl(i).hosttabid,');
  add_line('        l_tabid,');
  add_line('        l_browsetbl(i).addtabalias,');
  add_line('        l_browsetbl(i).hostcolid,');
  add_line('        l_newcolid,');
  add_line('        l_varcolid,');
  add_line('        l_browsetbl(i).cond_tag);');
  add_line('    end if;');
  add_line('  end loop;');
  add_line('');

  add_line('  -- ��������������� ������ ����� ������ ������ �� ���� ��������� �������');
  add_line('  for i in 1..l_filtertbl.count loop');
  add_line('    bars_metabase.add_filtertbl(');
  add_line('      l_filtertbl(i).tabid,');
  add_line('      l_filtertbl(i).colid,');
  add_line('      l_tabid,');
  add_line('      l_filtertbl(i).fltcode,');
  add_line('      l_filtertbl(i).flag_ins,');
  add_line('      l_filtertbl(i).flag_del,');
  add_line('      l_filtertbl(i).flag_upd);');
  add_line('  end loop;');
  add_line('');

  add_line('  -- ��������������� ����������� ����� ��������� �������');
  add_line('  for i in 1..l_dependency.count loop');
  add_line('    bars_metabase.add_dependency(');
  add_line('      l_dependency(i).tabid,');
  add_line('      l_dependency(i).colid,');
  add_line('      l_dependency(i).event ,');
  add_line('      l_dependency(i).depcolid  ,');
  add_line('      l_dependency(i).action_type ,');
  add_line('      l_dependency(i).action_name ,');
  add_line('      l_dependency(i).default_value ,');
  add_line('      l_dependency(i).condition );');
  add_line('  end loop;');
  add_line('');

$if $$module_gl $then
  if l_accpar > 0 then
    add_line('  -- ��������������� ������ ����������� ''��������� �������� � ������''');
    add_line('  for i in 1..l_accpar.count loop');
    add_line('    l_newcolid := bars_metabase.get_colid(l_tabid, l_accpar(i).colname);');
    add_line('    if (l_newcolid is not null) then');
    add_line('      insert into acc_par (tabid, colid, pr)');
    add_line('      values (l_tabid, l_newcolid, l_accpar(i).pr);');
    add_line('    end if;');
    add_line('  end loop;');
    add_line('');
  end if;

$end
  add_line('end;');
  add_line('/');
  add_line('');
  add_line('commit;');
--add_line('');

  insert into imp_file (file_name, file_clob)
  values (p_filename, l_clob);

end import_bmd;

function get_logical_op(p_operator in varchar2) return varchar2 is
  l_op varchar2(24);
begin
  if p_operator is not null and upper(p_operator) not in ('���', '���', '�', '�', '(', ')') then
    raise_application_error(-20000, '�������� ������� �������� ' || p_operator);
  end if;
  l_op := case
            when upper(p_operator) in ('���', '���') then
             G_LOGIC_OR
            when upper(p_operator) in ('�', '�') then
             G_LOGIC_AND
            else
             p_operator
          end;
  return l_op;
end;

function get_reletional_op(p_operator in varchar2) return varchar2 is
  l_op varchar2(24);
begin
  if p_operator is not null and
     upper(p_operator) not in ('=', '<', '<=', '>', '>=', '<>', '!=', '������', '�� ������', '������', '�� ������', '���� �', '�� ���� �') then
    raise_application_error(-20000, '�������� �������� ��������� ' || p_operator);
  end if;
  l_op := case
            when upper(p_operator) in ('������') then
             G_RELATIONAL_LIKE
            when upper(p_operator) in ('�� ������') then
             G_RELATIONAL_NOTLIKE
            when upper(p_operator) in ('������') then
             G_RELATIONAL_NULL
            when upper(p_operator) in ('�� ������') then
             G_RELATIONAL_NOTNULL
            when upper(p_operator) in ('���� �') then
             G_RELATIONAL_IN
            when upper(p_operator) in ('�� ���� �') then
             G_RELATIONAL_NOTIN
            else
             p_operator
          end;
  return l_op;
end;

function get_value(p_tabid      in number,
                   p_colname    in varchar2,
                   p_relational in varchar2,
                   p_value      in varchar2) return varchar2 is
  l_type    varchar2(1);
  l_value   varchar2(300) := p_value;
  l_coln varchar2(300);
begin
  if p_colname is null then
    l_value := null;
  else

    select mc.coltype, replace(mc.semantic,'~', '')
      into l_type, l_coln
      from meta_columns mc
     where mc.tabid = p_tabid and mc.colname = p_colname;
    -- case sensitive
    if l_type in ('C') then
      l_value := replace(l_value,'''','''''');
      if p_relational in (G_RELATIONAL_NULL, G_RELATIONAL_NOTNULL) then
        l_value := '$~~ALIAS~~$.'|| p_colname||' '|| p_relational;
      elsif  p_relational in (G_RELATIONAL_IN, G_RELATIONAL_NOTIN) then
        l_value := '$~~ALIAS~~$.'|| p_colname||' '|| p_relational || ' ('''||REGEXP_REPLACE(l_value, ' {0,}, {0,}', ''',''')||''')';
      elsif p_relational in (G_RELATIONAL_LIKE, G_RELATIONAL_NOTLIKE) then

        if regexp_like(l_value, '[*%_?]') then
          l_value := regexp_replace(regexp_replace(regexp_replace(l_value,
                                                      '([^\])(\*|%){1,}',
                                                      '\1%'),
                                       '([^\])(\?)',
                                       '\1_'),
                        '([^\])(\?)',
                        '\1_');
          l_value := replace(replace(l_value,'\*','*'), '\?', '?');
          l_value := '$~~ALIAS~~$.'|| p_colname||' '|| p_relational||' '''||l_value||'''';
        else
          l_value := '$~~ALIAS~~$.'|| p_colname||' '|| p_relational||' ''%'||l_value||'%''';
        end if;
        l_value := l_value||' ESCAPE ''\''';
      else
        l_value := '$~~ALIAS~~$.'|| p_colname||' '|| p_relational||' '''||l_value||'''';
      end if;
      -- not case sensitive
    elsif l_type = 'A' then
      l_value := upper(replace(l_value,'''',''''''));
      if p_relational in (G_RELATIONAL_NULL, G_RELATIONAL_NOTNULL) then
        l_value := '$~~ALIAS~~$.'|| p_colname||' '|| p_relational;
      elsif  p_relational in (G_RELATIONAL_IN, G_RELATIONAL_NOTIN) then
        l_value := 'UPPER('||'$~~ALIAS~~$.'|| p_colname||') '|| p_relational || ' ('''||REGEXP_REPLACE(l_value, ' {0,}, {0,}', ''',''')||''')';
      elsif p_relational in (G_RELATIONAL_LIKE, G_RELATIONAL_NOTLIKE) then

        if regexp_like(l_value, '[*%_?]') then
          l_value := regexp_replace(regexp_replace(regexp_replace(l_value,
                                                      '([^\])(\*|%){1,}',
                                                      '\1%'),
                                       '([^\])(\?)',
                                       '\1_'),
                        '([^\])(\?)',
                        '\1_');
          l_value := replace(replace(l_value,'\*','*'), '\?', '?');
          l_value := 'UPPER('||'$~~ALIAS~~$.'|| p_colname||') '|| p_relational||' '''||l_value||'''';
        else
          l_value := 'UPPER('||'$~~ALIAS~~$.'|| p_colname||') '|| p_relational||' ''%'||l_value||'%''';
        end if;
        l_value := l_value||' ESCAPE ''\''';
      else
        l_value := 'UPPER('||'$~~ALIAS~~$.'|| p_colname||') '|| p_relational||' '''||l_value||'''';
      end if;
    elsif l_type = 'D' then

      if regexp_like(l_value, '^+([0-9]{2}[.\/-][0-9]{2}[.\/-][0-9]{4}( {0,1}| [0-9]{2}:[0-9]{2}),{0,1} {0,}){1,}$') or p_relational in (G_RELATIONAL_NULL, G_RELATIONAL_NOTNULL) then
        if p_relational in (G_RELATIONAL_NULL, G_RELATIONAL_NOTNULL) then
          l_value := '$~~ALIAS~~$.'|| p_colname||' '|| p_relational;
        elsif  p_relational in (G_RELATIONAL_IN, G_RELATIONAL_NOTIN) then
          l_value := '$~~ALIAS~~$.'|| p_colname||' '|| p_relational || ' ('||REGEXP_REPLACE(l_value, '([0-9]{2}[.\/-][0-9]{2}[.\/-][0-9]{4}?( [0-9]{2}:[0-9]{2}){0,1})', 'to_date(''\1'',''dd.mm.yyyy hh24:mi'')')||')';
        elsif p_relational in (G_RELATIONAL_LIKE, G_RELATIONAL_NOTLIKE) then
          raise_application_error(-20000, '������� ������/�� ������ ��� ��� �����������');
        else
          l_value := '$~~ALIAS~~$.'|| p_colname||' '|| p_relational||' '||REGEXP_REPLACE(l_value, '([0-9]{2}[.\/-][0-9]{2}[.\/-][0-9]{4}?( [0-9]{2}:[0-9]{2}){0,1})', 'to_date(''\1'',''dd.mm.yyyy hh24:mi'')')||'';
        end if;
      else
         raise_application_error(-20000, '���������� ������ ���� ��� �������: ' ||  l_coln);
      end if;
    elsif l_type in ('E', 'N', 'S', 'B') then
      if regexp_like(l_value, '^(\d{1,}\.?\d{0,} {0,},? {0,}){1,}$') or p_relational in (G_RELATIONAL_NULL, G_RELATIONAL_NOTNULL)  then
      if p_relational in (G_RELATIONAL_NULL, G_RELATIONAL_NOTNULL) then
        l_value := '$~~ALIAS~~$.'|| p_colname||' '|| p_relational;
      elsif  p_relational in (G_RELATIONAL_IN, G_RELATIONAL_NOTIN) then
        l_value := '$~~ALIAS~~$.'|| p_colname||' '|| p_relational || ' ('||l_value||')';
      elsif p_relational in (G_RELATIONAL_LIKE, G_RELATIONAL_NOTLIKE) then
        if regexp_like(l_value, '[*%_?]') then
          l_value := regexp_replace(regexp_replace(regexp_replace(l_value,
                                                      '([^\])(\*|%){1,}',
                                                      '\1%'),
                                       '([^\])(\?)',
                                       '\1_'),
                        '([^\])(\?)',
                        '\1_');
          l_value := replace(replace(l_value,'\*','*'), '\?', '?');
          l_value := '$~~ALIAS~~$.'|| p_colname||' '|| p_relational||' '''||l_value||'''';
        else
          l_value := '$~~ALIAS~~$.'|| p_colname||' '|| p_relational||' ''%'||l_value||'%''';
        end if;
        l_value := l_value||' ESCAPE ''\''';
      else
        l_value := '$~~ALIAS~~$.'|| p_colname||' '|| p_relational||' '||l_value||'';
      end if;
      else
         raise_application_error(-20000, '���������� ������ ����� ��� �������: ' ||  l_coln);
      end if;
    end if;
  end if;
  return l_value;

exception
  when no_data_found then
    raise_application_error(-20000, '�� ������� ������� ' || p_tabid || '.' || p_colname);
end;

function remove_empty_lines(p_dyn_filter_cond_list in t_dyn_filter_cond_list)
  return t_dyn_filter_cond_list is
  l_dyn_filter_cond_list   t_dyn_filter_cond_list := p_dyn_filter_cond_list;
  l_dyn_filter_cond_list_o t_dyn_filter_cond_list := t_dyn_filter_cond_list();
begin
  if l_dyn_filter_cond_list.count > 0 then
    for c_l in l_dyn_filter_cond_list.first .. l_dyn_filter_cond_list.last
    loop
      if trim(l_dyn_filter_cond_list(c_l).logical_op) ||
         trim(l_dyn_filter_cond_list(c_l).colname) ||
         trim(l_dyn_filter_cond_list(c_l).relational_op) ||
         trim(l_dyn_filter_cond_list(c_l).value) is null then
        l_dyn_filter_cond_list.delete(c_l);
      else
        l_dyn_filter_cond_list_o.extend;
        l_dyn_filter_cond_list_o(l_dyn_filter_cond_list_o.last) := l_dyn_filter_cond_list(c_l);
      end if;
    end loop;
  end if;
  return l_dyn_filter_cond_list_o;
end;

procedure check_dyn_filter(p_tabid        in number,
                           p_where_clause varchar2) is
  l_where_clause dyn_filter.where_clause%type;
  l_tabname      meta_tables.tabname%type;
  l_cur          integer;
  l_statement    varchar2(4000);

begin
  select t.tabname
    into l_tabname
    from meta_tables t
   where t.tabid = p_tabid;

  l_cur := dbms_sql.open_cursor();
  l_where_clause := replace(p_where_clause, '$~~ALIAS~~$', l_tabname);
  l_statement := 'select 1 from ' || l_tabname || ' where ' ||
                 l_where_clause;
   bars_audit.info('create_dyn_filter: '||l_statement);
  dbms_sql.parse(l_cur, l_statement, dbms_sql.native);
  dbms_sql.close_cursor(l_cur);
exception
  when others then
    dbms_sql.close_cursor(l_cur);
    raise_application_error(-20000, '������ ������� �����. �������� ����� �������');


end;

procedure create_dyn_filter(p_tabid                in number,
                            p_filter_name          in varchar2,
                            p_dyn_filter_cond_list in t_dyn_filter_cond_list,
                            p_save_filter          in number default 1,
                            p_where_clause         in out varchar2,
                            p_condition_list       in clob
                            ) is
  l_where_clause dyn_filter .where_clause%type;
  l_logic        varchar2(24);
  l_colname      varchar2(30);
  l_relational   varchar2(24);
  l_value        varchar2(300);
  l_dyn_filter_cond_list   t_dyn_filter_cond_list := p_dyn_filter_cond_list;

begin
  bars_audit.info('create_dyn_filter ' || 'Start. p_tabid=>' || p_tabid);
  l_dyn_filter_cond_list := remove_empty_lines(l_dyn_filter_cond_list);
  if p_where_clause is null then
    if l_dyn_filter_cond_list.count > 0 then
      for c_l in l_dyn_filter_cond_list.first .. l_dyn_filter_cond_list.last
      loop

        if c_l = 1 and l_dyn_filter_cond_list(c_l).logical_op is not null and
           l_dyn_filter_cond_list(c_l).logical_op not in('(')then
          raise_application_error(-20000, '����������� ������� ����� ������� �������');
        end if;
        l_logic      := get_logical_op(l_dyn_filter_cond_list(c_l).logical_op);
        l_colname    := l_dyn_filter_cond_list(c_l).colname;
        l_relational := get_reletional_op(l_dyn_filter_cond_list(c_l).relational_op);
        l_value      := get_value(p_tabid, l_colname, l_relational, l_dyn_filter_cond_list(c_l).value);

        l_where_clause := l_where_clause || case when l_where_clause is not null then ' ' else null end ||
                          l_logic ||
                          case when l_value is not null and l_logic is not null then ' ' else null end||l_value;
        bars_audit.info('create_dyn_filter ' || 'Start. l_where_clause=>' ||
                        l_where_clause);
      end loop;
    else
      raise_application_error(-20000, 'Գ���� �� ������');
    end if;
  else
     l_where_clause := p_where_clause;
  end if;
  if l_where_clause is not null then
    check_dyn_filter(p_tabid, l_where_clause);
    if nvl(p_save_filter, 1) = 1 then
      insert into dyn_filter
        (filter_id, tabid, userid, semantic, from_clause, where_clause, condition_list)
      values
        (s_dyn_filter.nextval, p_tabid, user_id, p_filter_name, null,
         l_where_clause, p_condition_list);
    end if;
    p_where_clause := l_where_clause;
  end if;

end;

procedure update_dyn_filter(p_tabid                in number,
                            p_filterid             in number,
                            p_filter_name          in varchar2,
                            p_dyn_filter_cond_list in t_dyn_filter_cond_list,
                            p_where_clause         in out varchar2,
                            p_condition_list       in clob
                            ) is
  l_where_clause dyn_filter .where_clause%type;
  l_logic        varchar2(24);
  l_colname      varchar2(30);
  l_relational   varchar2(24);
  l_value        varchar2(300);
  l_dyn_filter_cond_list   t_dyn_filter_cond_list := p_dyn_filter_cond_list;

begin
  bars_audit.info('update_dyn_filter ' || 'Start. p_filterid=>' || p_filterid);
  l_dyn_filter_cond_list := remove_empty_lines(l_dyn_filter_cond_list);
  if p_where_clause is null then
    if l_dyn_filter_cond_list.count > 0 then
      for c_l in l_dyn_filter_cond_list.first .. l_dyn_filter_cond_list.last
      loop

        if c_l = 1 and l_dyn_filter_cond_list(c_l).logical_op is not null and
           l_dyn_filter_cond_list(c_l).logical_op not in('(')then
          raise_application_error(-20000, '����������� ������� ����� ������� �������');
        end if;
        l_logic      := get_logical_op(l_dyn_filter_cond_list(c_l).logical_op);
        l_colname    := l_dyn_filter_cond_list(c_l).colname;
        l_relational := get_reletional_op(l_dyn_filter_cond_list(c_l).relational_op);
        l_value      := get_value(p_tabid, l_colname, l_relational, l_dyn_filter_cond_list(c_l).value);

        l_where_clause := l_where_clause || case when l_where_clause is not null then ' ' else null end ||
                          l_logic ||
                          case when l_value is not null and l_logic is not null then ' ' else null end||l_value;
        bars_audit.info('create_dyn_filter ' || 'Start. l_where_clause=>' ||
                        l_where_clause);
      end loop;
    else
      raise_application_error(-20000, 'Գ���� �� ������');
    end if;
  else
     l_where_clause := p_where_clause;
  end if;
  if l_where_clause is not null then
    check_dyn_filter(p_tabid, l_where_clause);
    update dyn_filter t
       set t.semantic       = p_filter_name,
           t.where_clause   = l_where_clause,
           t.condition_list = p_condition_list
     where t.filter_id = p_filterid;
     p_where_clause := l_where_clause;
  end if;

end;

end bars_metabase;
/
