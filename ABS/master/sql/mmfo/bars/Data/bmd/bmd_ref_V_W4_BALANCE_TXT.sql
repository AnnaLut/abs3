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

  l_tabid        meta_tables.tabid%type;
  l_tabname      meta_tables.tabname%type;
  l_tabsemantic  meta_tables.semantic%type;
  l_tablinesdef  varchar2(16);
  l_newtabid     meta_tables.tabid%type;
  l_newcolid     meta_columns.colid%type;
  l_varcolid     meta_columns.colid%type;
  l_colname      meta_columns.colname%type;

begin

  l_tabsemantic := 'W4. ����� �������(new)';
  l_tabname     := 'V_W4_BALANCE_TXT';

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
    bars_metabase.set_tablinesdef(l_tabid, l_tablinesdef);

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

    -- ������� �������� �����
    bars_metabase.delete_metatables(l_tabid);

  end if;

  -- ��������� �������� �����

               bars_metabase.add_column(l_tabid, 1, 'DAT',          'C', '����~�������',            null, 10, 1, 0, 0, 0, 0, '', '', 0, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 2, 'BRANCH',       'C', '³�������',              null, 30, 2, 1, 0, 0, 0, '', '', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 3, 'NMK',          'C', '�볺��',                  null, 70, 3, 1, 0, 1, 0, '', '', 1, 0, '', 0, 0, 1);
               bars_metabase.add_column(l_tabid, 4, 'KV',           'C', '���.',                    null,  3, 4, 1, 1, 0, 0, '', '', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 5, 'NLS',          'C', '���������~�������',        1.8, 15, 5, 1, 1, 0, 0, '',         '', 1, 0, '', 0, 0, 1);
               bars_metabase.add_column(l_tabid, 6, 'A_PK_OST',     'N', '������� ��~����.�������',  1.8, 22, 6, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 7, 'W_PK_OST',     'N', 'W4.������� ��~����.�������',  1.8, 22, 7, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 8, 'DELTA_PK_OST', 'N', 'г�����',  1.6, 22, 8, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 9, 'A_OVR_OST',     'N', '������� ��~2202/2203',  1.8, 22, 9, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 10, 'W_OVR_OST',     'N', 'W4.������� ��~2202/2203',  1.8, 22, 10, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 11, 'DELTA_OVR_OST', 'N', 'г�����',  1.6, 22, 11, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 12, 'A2207_OST',     'N', '������� ��~2207',  1.8, 22, 12, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 13, 'W2207_OST',     'N', 'W4.������� ��~2207',  1.8, 22, 13, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 14, 'DELTA_2207_OST', 'N', 'г�����',  1.6, 22, 14, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 15, 'A2208_OST',     'N', '������� ��~2208',  1.8, 22, 15, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 16, 'W2208_OST',     'N', 'W4.������� ��~2208',  1.8, 22, 16, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 17, 'DELTA_2208_OST', 'N', 'г�����',  1.6, 22, 17, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 18, 'A2209_OST',     'N', '������� ��~2209',  1.8, 22, 18, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 19, 'W2209_OST',     'N', 'W4.������� ��~2209',  1.8, 22, 19, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 20, 'DELTA_2209_OST', 'N', 'г�����',  1.6, 22, 20, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 21, 'A2625D_OST',     'N', '������� ��~2625D',  1.8, 22, 21, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 22, 'W2625D_OST',     'N', 'W4.������� ��~2625D',  1.8, 22, 22, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 23, 'DELTA_2625D_OST', 'N', 'г�����',  1.6, 22, 23, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 24, 'A2627_OST',     'N', '������� ��~2627',  1.8, 22, 24, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 25, 'W2627_OST',     'N', 'W4.������� ��~2627',  1.8, 22, 25, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 26, 'DELTA_2627_OST', 'N', 'г�����',  1.6, 22, 26, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 27, 'A2627X_OST',     'N', '������� ��~2627X',  1.8, 22, 27, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 28, 'W2627X_OST',     'N', 'W4.������� ��~2627X',  1.8, 22, 28, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 29, 'DELTA_2627X_OST', 'N', 'г�����',  1.6, 22, 29, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 30, 'A2628_OST',     'N', '������� ��~2628',  1.8, 22, 30, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 31, 'W2628_OST',     'N', 'W4.������� ��~2628',  1.8, 22, 31, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 32, 'DELTA_2628_OST', 'N', 'г�����',  1.6, 22, 32, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 33, 'A3570_OST',     'N', '������� ��~3570',  1.8, 22, 33, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 34, 'W3570_OST',     'N', 'W4.������� ��~3570',  1.8, 22, 34, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 35, 'DELTA_3570_OST', 'N', 'г�����',  1.6, 22, 35, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 36, 'A3579_OST',     'N', '������� ��~3579',  1.8, 22, 36, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 37, 'W3579_OST',     'N', 'W4.������� ��~3579',  1.8, 22, 37, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 38, 'DELTA_3579_OST', 'N', 'г�����',  1.6, 22, 38, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 39, 'A9129_OST',     'N', '������� ��~9129',  1.8, 22, 39, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 40, 'W9129_OST',     'N', 'W4.������� ��~9129',  1.8, 22, 40, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 41, 'DELTA_9129_OST', 'N', 'г�����',  1.6, 22, 41, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 42, 'AAR_OST',     'N', '����������~����',  1.8, 22, 42, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
               bars_metabase.add_column(l_tabid, 43, 'WAR_OST',     'N', 'W4.����������~����',  1.8, 22, 43, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);   
               bars_metabase.add_column(l_tabid, 44, 'DELTA_AR_OST', 'N', 'г�����',  1.6, 22, 44, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);
	       bars_metabase.add_column(l_tabid, 45, 'WPEN', 'N', 'W4.����',  1.6, 22, 45, 1, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0);	


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

end;
/
commit;
/
