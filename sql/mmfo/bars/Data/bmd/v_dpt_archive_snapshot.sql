set serveroutput on

declare

  type t_rec_extrnval is record (
    tabid            meta_extrnval.tabid%type,
    colid            meta_extrnval.colid%type,
    srccolname       meta_columns.colname%type,
    tab_alias        meta_extrnval.tab_alias%type,
    tab_cond         meta_extrnval.tab_cond%type,
    src_cond         meta_extrnval.src_cond%type,
    col_dyn_tabname  varchar2(30));
  type t_tab_extrnval is table of t_rec_extrnval;
  l_extrnval     t_tab_extrnval := t_tab_extrnval();

  type t_rec_browsetbl is record (
    hosttabid   meta_browsetbl.hosttabid%type,
    hostcolid   meta_browsetbl.hostcolkeyid%type,
    addcolname  meta_columns.colname%type,
    varcolname  meta_columns.colname%type,
    addtabalias meta_browsetbl.addtabalias%type,
    cond_tag    meta_browsetbl.cond_tag%type);
  type t_tab_browsetbl is table of t_rec_browsetbl;
  l_browsetbl    t_tab_browsetbl := t_tab_browsetbl();

  type t_rec_filtertbl is record (
    tabid       meta_filtertbl.tabid%type,
    colid       meta_filtertbl.colid%type,
    fltcode     meta_filtertbl.filter_code%type,
    flag_ins    meta_filtertbl.flag_ins%type,
    flag_del    meta_filtertbl.flag_del%type,
    flag_upd    meta_filtertbl.flag_upd%type);
  type t_tab_filtertbl is table of t_rec_filtertbl;
  l_filtertbl    t_tab_filtertbl := t_tab_filtertbl();

  type t_rec_dependency is record (
    id               meta_dependency_cols.id%type,
    tabid            meta_dependency_cols.tabid%type,
    colid            meta_dependency_cols.colid%type,
    event            meta_dependency_cols.event%type,
    depcolid         meta_dependency_cols.depcolid%type,
    action_type      meta_dependency_cols.action_type%type,
    action_name      meta_dependency_cols.action_name%type,
    default_value    meta_dependency_cols.default_value%type,
    condition        meta_dependency_cols.condition%type);
  type t_tab_dependency is table of t_rec_dependency;
  l_dependency     t_tab_dependency := t_tab_dependency();

  l_tabid        meta_tables.tabid%type;
  l_tabname      meta_tables.tabname%type;
  l_tabsemantic  meta_tables.semantic%type;
  l_tablinesdef  varchar2(16);
  l_tabselect_statement meta_tables.select_statement%type;
  l_newtabid     meta_tables.tabid%type;
  l_newcolid     meta_columns.colid%type;
  l_varcolid     meta_columns.colid%type;
  l_colname      meta_columns.colname%type;

begin

  l_tabsemantic := '����� �������� �� - ������';
  l_tablinesdef := '10';
  l_tabselect_statement := '';
  l_tabname     := 'V_DPT_ARCHIVE_SNAPSHOT';

  -- �������� ��� �������
  l_tabid := bars_metabase.get_tabid(l_tabname);

  -- ���� ������� �� ������� � ���
  if l_tabid is null then

    -- �������� ��� ��� ����� �������
    l_tabid := bars_metabase.get_newtabid();

    -- ��������� �������� ������� � ���
    bars_metabase.add_table(l_tabid, l_tabname, l_tabsemantic, l_tabselect_statement);

  -- ���� ������� ������� � ���
  else

    -- ��������� ��������� �������
    bars_metabase.set_tabsemantic(l_tabid, l_tabsemantic);

    -- ��������� linesdef �������
    bars_metabase.set_tablinesdef(l_tabid, l_tablinesdef);

    -- ��������� select_statement �������
    bars_metabase.set_tabselect_statement(l_tabid, l_tabselect_statement);

    -- ��������� ������ ������� ����� ������ ������ �� ���� ����� �������
    select e.tabid, e.colid, c.colname, e.tab_alias, e.tab_cond, e.src_cond, e.col_dyn_tabname
      bulk collect
      into l_extrnval
      from meta_extrnval e, meta_columns c
     where e.srctabid = l_tabid
       and e.srctabid = c.tabid and e.srccolid = c.colid;

    -- ��������� ������ ��� ������� ������� ����� ������ ������ �� ���� ����� �������
    select b.hosttabid, b.hostcolkeyid, c.colname, v.colname, b.addtabalias, v.semantic
      bulk collect
      into l_browsetbl
      from meta_browsetbl b, meta_columns c, meta_columns v
     where b.addtabid = l_tabid
       and b.addtabid = c.tabid and b.addcolkeyid = c.colid
       and b.addtabid = v.tabid and b.var_colid = v.colid;

    -- ��������� ������ ����� ������ ������ �� ���� ��������� �������
    select tabid, colid, filter_code, flag_ins, flag_del, flag_upd
      bulk collect
      into l_filtertbl
      from meta_filtertbl
     where filter_tabid = l_tabid and tabid <> l_tabid;

    -- ��������� ����������� ����� ��������� �������
    select id, tabid, colid, event, depcolid, action_type, action_name, default_value, condition
      bulk collect
      into l_dependency
      from meta_dependency_cols
     where tabid = l_tabid;

    -- ������� �������� �����
    bars_metabase.delete_metatables(l_tabid);

  end if;

  -- ��������� �������� �����
  bars_metabase.add_column(l_tabid, 1, 'ACC_NUM', 'C', '�����~�����������~�������', '2.5', 15, 8, 0, 0, 0, 0, '', '', 0, 0, '', 0, 0, 0, '', '', 0);
  bars_metabase.add_column(l_tabid, 2, 'BEG_DT', 'D', '���� �������~䳿 ��������', '1.5', 10, 13, 0, 0, 0, 0, '', '', 0, 0, '', 0, 0, 0, '', '', 0);
  bars_metabase.add_column(l_tabid, 3, 'BRANCH', 'C', '���~��������� (����)', '2', 30, 3, 0, 0, 0, 0, '', '', 0, 0, '', 0, 0, 0, '', '', 0);
  bars_metabase.add_column(l_tabid, 5, 'CCY_ID', 'N', '������', '.5', 22, 1, 0, 0, 0, 0, '', '', 0, 0, '', 0, 0, 0, '', '', 0);
  bars_metabase.add_column(l_tabid, 6, 'CNT_DUBL', 'N', '�-�� �����������~��������', '.5', 22, 15, 0, 0, 0, 0, '', '', 0, 0, '', 0, 0, 0, '', '', 0);
  bars_metabase.add_column(l_tabid, 7, 'CTR_AMT', 'N', '����~��������', '2', 22, 9, 0, 0, 0, 0, '', '', 0, 0, '', 0, 0, 0, '', '', 0);
  bars_metabase.add_column(l_tabid, 8, 'CTR_DT', 'D', '���� ���������~��������~(��������~�������)', '1.5', 10, 12, 0, 0, 0, 0, '', '', 0, 0, '', 0, 0, 0, '', '', 0);
  bars_metabase.add_column(l_tabid, 9, 'CUST_ID', 'N', '��. �볺���', '1.5', 22, 4, 0, 0, 0, 0, '', '', 0, 0, '', 0, 0, 0, '', '', 0);
  bars_metabase.add_column(l_tabid, 10, 'CUST_NM', 'C', '�����~�볺���', '3.5', 70, 5, 0, 0, 0, 0, '', '', 0, 0, '', 0, 0, 0, '', '', 0);
  bars_metabase.add_column(l_tabid, 11, 'DEP_BAL', 'N', '������� ��~����������� �������', '2', 22, 9, 0, 0, 0, 0, '', '# ##0.00', 0, 0, '', 0, 0, 0, '', '', 0);
  bars_metabase.add_column(l_tabid, 12, 'DPT_ID', 'N', '��. �����������~��������', '2', 22, 6, 0, 0, 0, 0, '', '', 0, 0, '', 0, 0, 0, '', '', 0);
  bars_metabase.add_column(l_tabid, 13, 'END_DT', 'D', '���� ���������~䳿 ��������', '1.5', 10, 14, 0, 0, 0, 0, '', '', 0, 0, '', 0, 0, 0, '', '', 0);
  bars_metabase.add_column(l_tabid, 14, 'INT_BAL', 'N', '�������~�� �����������~�������', '2', 22, 11, 0, 0, 0, 0, '', '# ##0.00', 0, 0, '', 0, 0, 0, '', '', 0);
  bars_metabase.add_column(l_tabid, 15, 'KF', 'C', '���~������ (���)', '.5', 6, 2, 0, 0, 0, 0, '', '', 0, 0, '', 0, 0, 0, '', '', 0);
  bars_metabase.add_column(l_tabid, 16, 'ND', 'C', '�����~�����o��', '2', 35, 7, 0, 0, 0, 0, '', '', 0, 0, '', 0, 0, 0, '', '', 0);
  bars_metabase.add_column(l_tabid, 17, 'RATE', 'N', '³�������~������', '.5', 22, 10, 0, 0, 0, 0, '', '', 0, 0, '', 0, 0, 0, '', '', 0);
  bars_metabase.add_column(l_tabid, 18, 'RPT_DT', 'D', '����~������~��~���������������', '1.5', 10, 99, 0, 0, 0, 0, '', '', 0, 0, '', 0, 0, 0, '', '', 0);
  bars_metabase.add_column(l_tabid, 19, 'USER_ID', 'N', '����������', '.5', 22, 98, 0, 0, 0, 0, '', '', 0, 0, '', 0, 0, 0, '', '', 0);
  bars_metabase.add_column(l_tabid, 20, 'VIDD_ID', 'N', '��. ����~��������', '.5', 22, -1, 0, 0, 0, 0, '', '', 0, 0, '', 0, 0, 0, '', '', 0);
  bars_metabase.add_column(l_tabid, 21, 'VIDD_NM', 'C', '����� ����~��������', '3', 50, 0, 0, 0, 0, 0, '', '', 0, 0, '', 0, 0, 0, '', '', 0);
  bars_metabase.add_column(l_tabid, 30, 'EBPY', 'C', '³������� � ��� (��� / Ͳ)', '.5', 22, 77, 0, 0, 0, 0, '', '', 0, 0, '', 0, 0, 0, '', '', 0);
  bars_metabase.add_column(l_tabid, 31, 'WB', 'C', '³������� � ���-������� (Y/N)', '.5', 22, 76, 0, 0, 0, 0, '', '', 0, 0, '', 0, 0, 0, '', '', 0);
  bars_metabase.add_column(l_tabid, 32, 'DATE_SNAPSHOT', 'D', '����~����������~������', '1.5', 10, 99, 0, 0, 0, 0, '', 'dd.MM.yyyy hhhh:mm:ss', 0, 0, '', 0, 0, 0, '', '', 0);

  -- ������� �������� ������� �� ����������
  bars_metabase.delete_nsifunction(l_tabid);

  -- ��������������� ������ ������� ����� ������ ������
  for i in 1..l_extrnval.count loop
    l_newcolid := bars_metabase.get_colid(l_tabid, l_extrnval(i).srccolname);
    if (l_newcolid is not null) then
      bars_metabase.add_extrnval(
        l_extrnval(i).tabid,
        l_extrnval(i).colid,
        l_tabid,
        l_newcolid,
        l_extrnval(i).tab_alias,
        l_extrnval(i).tab_cond,
        l_extrnval(i).src_cond,
        l_extrnval(i).col_dyn_tabname);
    end if;
  end loop;

  -- ��������������� ������ ����� ��� ������� ������� ������ ������
  for i in 1..l_browsetbl.count loop
    l_newcolid := bars_metabase.get_colid(l_tabid, l_browsetbl(i).addcolname);
    l_varcolid := bars_metabase.get_colid(l_tabid, l_browsetbl(i).varcolname);
    if (l_newcolid is not null and l_varcolid is not null) then
      bars_metabase.add_browsetbl( 
        l_browsetbl(i).hosttabid,
        l_tabid,
        l_browsetbl(i).addtabalias,
        l_browsetbl(i).hostcolid,
        l_newcolid,
        l_varcolid,
        l_browsetbl(i).cond_tag);
    end if;
  end loop;

  -- ��������������� ������ ����� ������ ������ �� ���� ��������� �������
  for i in 1..l_filtertbl.count loop
    bars_metabase.add_filtertbl(
      l_filtertbl(i).tabid,
      l_filtertbl(i).colid,
      l_tabid,
      l_filtertbl(i).fltcode,
      l_filtertbl(i).flag_ins,
      l_filtertbl(i).flag_del,
      l_filtertbl(i).flag_upd);
  end loop;

  -- ��������������� ����������� ����� ��������� �������
  for i in 1..l_dependency.count loop
    bars_metabase.add_dependency(
      l_dependency(i).tabid,
      l_dependency(i).colid,
      l_dependency(i).event ,
      l_dependency(i).depcolid  ,
      l_dependency(i).action_type ,
      l_dependency(i).action_name ,
      l_dependency(i).default_value ,
      l_dependency(i).condition );
  end loop;

end;
/

commit;
