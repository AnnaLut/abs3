set serveroutput on

declare

  type t_rec_extrnval is record (
    tabid            meta_extrnval.tabid%type,
    colid            meta_extrnval.colid%type,
    srccolname       meta_columns.colname%type,
    tab_alias        meta_extrnval.tab_alias%type,
    tab_cond         meta_extrnval.tab_cond%type,
    src_cond         meta_extrnval.src_cond%type);
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

  l_tabid        meta_tables.tabid%type;
  l_tabname      meta_tables.tabname%type;
  l_tabsemantic  meta_tables.semantic%type;
  l_tablinesdef  varchar2(16);
  l_newtabid     meta_tables.tabid%type;
  l_newcolid     meta_columns.colid%type;
  l_varcolid     meta_columns.colid%type;
  l_colname      meta_columns.colname%type;

begin

  l_tabsemantic := '������� ����������� ��� ���� �� ������������ ����';
  l_tablinesdef := '10';
  l_tabname     := 'ACCP_ORGS';

  -- �������� ��� �������
  l_tabid := bars_metabase.get_tabid(l_tabname);

  -- ���� ������� �� ������� � ���
  if l_tabid is null then

    -- �������� ��� ��� ����� �������
    l_tabid := bars_metabase.get_newtabid();

    -- ��������� �������� ������� � ���
    bars_metabase.add_table(l_tabid, l_tabname, l_tabsemantic);

  -- ���� ������� ������� � ���
  else

    -- ��������� ��������� �������
    bars_metabase.set_tabsemantic(l_tabid, l_tabsemantic);

    -- ��������� linesdef �������
    --bars_metabase.set_tablinesdef(l_tabid, l_tablinesdef);

    -- ��������� ������ ������� ����� ������ ������ �� ���� ����� �������
    select e.tabid, e.colid, c.colname, e.tab_alias, e.tab_cond, e.src_cond
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

    -- ������� �������� �����
    bars_metabase.delete_metatables(l_tabid);

  end if;

  -- ��������� �������� �����
  bars_metabase.add_column(l_tabid, 1, 'AMOUNT_FEE', 'N', '����� ����.~����������', null, 22, 9, 0, 0, 0, 0, '', '', 0, 0, '', 0, 0, 0, '');
  bars_metabase.add_column(l_tabid, 2, 'DDOG', 'D', '����~�������� ', null, 10, 3, 0, 0, 0, 0, '', '', 0, 0, '', 0, 0, 0, '');
  bars_metabase.add_column(l_tabid, 3, 'FEE_MFO', 'C', '��� �����~��� �������.~����.�������', null, 6, 10, 0, 0, 0, 0, '', '', 0, 0, '', 0, 0, 0, '');
  bars_metabase.add_column(l_tabid, 4, 'FEE_NLS', 'C', '������� �����~��� �������.~����.�������', null, 15, 11, 0, 0, 0, 0, '', '', 0, 0, '', 0, 0, 0, '');
  bars_metabase.add_column(l_tabid, 5, 'FEE_OKPO', 'C', '������ �����~��� �������.~����.�������', null, 10, 12, 0, 0, 0, 0, '', '', 0, 0, '', 0, 0, 0, '');
  bars_metabase.add_column(l_tabid, 7, 'NAME', 'C', '����� �����������', null, 70, 1, 1, 0, 1, 0, '', '', 1, 0, '', 0, 0, 0, '');
  bars_metabase.add_column(l_tabid, 8, 'NDOG', 'C', '� ��������', null, 20, 2, 0, 0, 0, 0, '', '', 0, 0, '', 0, 0, 0, '');
  bars_metabase.add_column(l_tabid, 10, 'OKPO', 'C', '��� ������~�����������', null, 10, 0, 0, 1, 0, 0, '', '', 1, 0, '', 0, 0, 1, '');
  bars_metabase.add_column(l_tabid, 11, 'ORDER_FEE', 'N', '��� �������~������ ����~����������', null, 22, 8, 0, 0, 0, 1, '', '', 0, 0, '', 0, 0, 0, '');
  bars_metabase.add_column(l_tabid, 12, 'SCOPE_DOG', 'N', '��� ������~䳿 ��������', null, 22, 7, 0, 0, 0, 1, '', '', 0, 0, '', 0, 0, 0, '');
  bars_metabase.add_column(l_tabid, 13, 'FEE_TYPE_ID', 'N', '���~����.�������', null, 1, 13, 0, 0, 0, 1, '', '', 0, 0, '', 0, 0, 0, '');
  bars_metabase.add_column(l_tabid, 14, 'FEE_BY_TARIF', 'N', '��� ������', null, 22, null, 0, 0, 0, 1, '', '', 0, 0, '', 0, 0, 0, '');

  -- ��������� �������� �������� ����
  l_newtabid := bars_metabase.get_tabid('ACCP_ORDER_FEE');
  l_newcolid := bars_metabase.get_colid(l_newtabid, 'ID');
  if (l_newtabid is not null and l_newcolid is not null) then
    bars_metabase.add_extrnval(l_tabid, 11, l_newtabid, l_newcolid, 'a', '', '', '');
  else
    dbms_output.put_line('� ��� �� ������� ������� ACCP_ORDER_FEE ��� �������� �������� ���� ������� ACCP_ORGS.');
  end if;

  -- ��������� �������� �������� ����
  l_newtabid := bars_metabase.get_tabid('ACCP_SCOPE');
  l_newcolid := bars_metabase.get_colid(l_newtabid, 'ID');
  if (l_newtabid is not null and l_newcolid is not null) then
    bars_metabase.add_extrnval(l_tabid, 12, l_newtabid, l_newcolid, 'b', '', '', '');
  else
    dbms_output.put_line('� ��� �� ������� ������� ACCP_SCOPE ��� �������� �������� ���� ������� ACCP_ORGS.');
  end if;

  -- ��������� �������� �������� ����
  l_newtabid := bars_metabase.get_tabid('ACCP_FEE_TYPES');
  l_newcolid := bars_metabase.get_colid(l_newtabid, 'FEE_TYPE_ID');
  if (l_newtabid is not null and l_newcolid is not null) then
    bars_metabase.add_extrnval(l_tabid, 13, l_newtabid, l_newcolid, 'c', '', '', '');
  else
    dbms_output.put_line('� ��� �� ������� ������� ACCP_FEE_TYPES ��� �������� �������� ���� ������� ACCP_ORGS.');
  end if;

  -- ��������� �������� �������� ����
  l_newtabid := bars_metabase.get_tabid('TARIF');
  l_newcolid := bars_metabase.get_colid(l_newtabid, 'KOD');
  if (l_newtabid is not null and l_newcolid is not null) then
    bars_metabase.add_extrnval(l_tabid, 14, l_newtabid, l_newcolid, 'd', '', '', '');
  else
    dbms_output.put_line('� ��� �� ������� ������� TARIF ��� �������� �������� ���� ������� ACCP_ORGS.');
  end if;

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
        null,
        null);
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

end;
/

commit;
