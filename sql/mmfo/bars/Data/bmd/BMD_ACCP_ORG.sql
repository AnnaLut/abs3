set serveroutput on

declare
  type t_rec_metaextrnval is record (
     tabid      meta_extrnval.tabid%type,
     colid      meta_extrnval.colid%type,
     srccolname meta_columns.colname%type,
     tab_alias  meta_extrnval.tab_alias%type,
     tab_cond   meta_extrnval.tab_cond%type,
     src_cond   meta_extrnval.src_cond%type);
  type t_tab_metaextrnval is table of t_rec_metaextrnval;
  l_arr_metaextrnval t_tab_metaextrnval := t_tab_metaextrnval();

  type t_rec_metabrowsetbl is record (
     hosttabid   meta_browsetbl.hosttabid%type,
     hostcolid   meta_browsetbl.hostcolkeyid%type,
     addcolname  meta_columns.colname%type,
     varcolname  meta_columns.colname%type,
     addtabalias meta_browsetbl.addtabalias%type,
     cond_tag    meta_browsetbl.cond_tag%type);
  type t_tab_metabrowsetbl is table of t_rec_metabrowsetbl;
  l_arr_metabrowsetbl t_tab_metabrowsetbl := t_tab_metabrowsetbl();

  type t_rec_metafiltertbl is record (
     tabid    meta_filtertbl.tabid%type,
     colid    meta_filtertbl.colid%type,
     fltcode  meta_filtertbl.filter_code%type,
     flag_ins meta_filtertbl.flag_ins%type,
     flag_del meta_filtertbl.flag_del%type,
     flag_upd meta_filtertbl.flag_upd%type);
  type t_tab_metafiltertbl is table of t_rec_metafiltertbl;
  l_arr_metafiltertbl t_tab_metafiltertbl := t_tab_metafiltertbl();

  l_tabid       meta_tables.tabid%type;
  l_tabname     meta_tables.tabname%type;
  l_tabsemantic meta_tables.semantic%type;
  l_newtabid    meta_tables.tabid%type;
  l_newcolid    meta_columns.colid%type;
  l_varcolid    meta_columns.colid%type;
  l_colname     meta_columns.colname%type;
  i             number;

begin

  l_tabsemantic := '������� ����������� ��� ���� �� ������������ ����';
  l_tabname := 'ACCP_ORGS';

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

     -- ��������� ������ ������� ����� ������ ������ �� ���� ����� �������
     i := 0;
     for k in (select e.tabid, e.colid, e.tab_cond, c.colname, e.tab_alias, e.src_cond
                 from meta_extrnval e, meta_columns c
                where e.srctabid=l_tabid
                  and e.srctabid=c.tabid and e.srccolid=c.colid)
     loop
        i := i + 1;
        l_arr_metaextrnval.extend;
        l_arr_metaextrnval(i).tabid      := k.tabid;
        l_arr_metaextrnval(i).colid      := k.colid;
        l_arr_metaextrnval(i).srccolname := k.colname;
        l_arr_metaextrnval(i).tab_alias  := k.tab_alias;
        l_arr_metaextrnval(i).tab_cond   := k.tab_cond;
        l_arr_metaextrnval(i).src_cond   := k.src_cond;
     end loop;

     -- ��������� ������ ��� ������� ������� ����� ������ ������ �� ���� ����� �������
     i := 0;
     for k in (select b.hosttabid, b.hostcolkeyid, b.addtabalias,
                      c.colname k_colname, v.colname v_colname, v.semantic v_colsemantic
                 from meta_browsetbl b, meta_columns c, meta_columns v
                where b.addtabid=l_tabid
                  and b.addtabid=c.tabid and b.addcolkeyid=c.colid
                  and b.addtabid=v.tabid and b.var_colid=v.colid)
     loop
        i := i + 1;
        l_arr_metabrowsetbl.extend;
        l_arr_metabrowsetbl(i).hosttabid   := k.hosttabid;
        l_arr_metabrowsetbl(i).hostcolid   := k.hostcolkeyid;
        l_arr_metabrowsetbl(i).addcolname  := k.k_colname;
        l_arr_metabrowsetbl(i).varcolname  := k.v_colname;
        l_arr_metabrowsetbl(i).addtabalias := k.addtabalias;
        l_arr_metabrowsetbl(i).cond_tag    := k.v_colsemantic;
     end loop;

     -- ��������� ������ ����� ������ ������ �� ���� ��������� �������
     i := 0;
     for k in (select tabid, colid, filter_code, flag_ins, flag_del, flag_upd
                 from meta_filtertbl
                where filter_tabid = l_tabid and tabid <> l_tabid)
     loop
        i := i + 1;
        l_arr_metafiltertbl.extend;
        l_arr_metafiltertbl(i).tabid    := k.tabid;
        l_arr_metafiltertbl(i).colid    := k.colid;
        l_arr_metafiltertbl(i).fltcode  := k.filter_code;
        l_arr_metafiltertbl(i).flag_ins := k.flag_ins;
        l_arr_metafiltertbl(i).flag_del := k.flag_del;
        l_arr_metafiltertbl(i).flag_upd := k.flag_upd;
     end loop;

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

  -- ��������� �������� �������� ����
  l_newtabid := bars_metabase.get_tabid('ACCP_ORDER_FEE');
  l_newcolid := bars_metabase.get_colid(l_newtabid, 'ID');
  if (l_newtabid is not null and l_newcolid is not null) then
     bars_metabase.add_extrnval(l_tabid, 11, l_newtabid, l_newcolid, 'a', '', '');
  else
     dbms_output.put_line('� ��� �� ������� ������� ACCP_ORDER_FEE ��� �������� �������� ���� ������� ACCP_ORGS.');
  end if;

  -- ��������� �������� �������� ����
  l_newtabid := bars_metabase.get_tabid('ACCP_SCOPE');
  l_newcolid := bars_metabase.get_colid(l_newtabid, 'ID');
  if (l_newtabid is not null and l_newcolid is not null) then
     bars_metabase.add_extrnval(l_tabid, 12, l_newtabid, l_newcolid, 'b', '', '');
  else
     dbms_output.put_line('� ��� �� ������� ������� ACCP_SCOPE ��� �������� �������� ���� ������� ACCP_ORGS.');
  end if;

  -- ������� �������� ������� �� ����������
  bars_metabase.delete_nsifunction(l_tabid);

  -- ��������� �������� ���������

  -- ��������������� ������ ������� ����� ������ ������
  for i in 1..l_arr_metaextrnval.count
  loop
     l_newcolid := bars_metabase.get_colid(l_tabid, l_arr_metaextrnval(i).srccolname);
     if (l_newcolid is not null) then
        bars_metabase.add_extrnval(
           l_arr_metaextrnval(i).tabid,
           l_arr_metaextrnval(i).colid,
           l_tabid,
           l_newcolid,
           l_arr_metaextrnval(i).tab_alias,
           l_arr_metaextrnval(i).tab_cond);
     end if;
  end loop;

  -- ��������������� ������ ����� ��� ������� ������� ������ ������
  for i in 1..l_arr_metabrowsetbl.count
  loop
     l_newcolid := bars_metabase.get_colid(l_tabid, l_arr_metabrowsetbl(i).addcolname);
     l_varcolid := bars_metabase.get_colid(l_tabid, l_arr_metabrowsetbl(i).varcolname);
     if (l_newcolid is not null and l_varcolid is not null) then
        bars_metabase.add_browsetbl( 
           l_arr_metabrowsetbl(i).hosttabid,
           l_tabid,
           l_arr_metabrowsetbl(i).addtabalias,
           l_arr_metabrowsetbl(i).hostcolid,
           l_newcolid,
           l_varcolid,
           l_arr_metabrowsetbl(i).cond_tag);
     end if;
  end loop;

  -- ��������������� ������ ����� ������ ������ �� ���� ��������� �������
  for i in 1..l_arr_metafiltertbl.count
  loop
     bars_metabase.add_filtertbl(
        l_arr_metafiltertbl(i).tabid,
        l_arr_metafiltertbl(i).colid,
        l_tabid,
        l_arr_metafiltertbl(i).fltcode,
        l_arr_metafiltertbl(i).flag_ins,
        l_arr_metafiltertbl(i).flag_del,
        l_arr_metafiltertbl(i).flag_upd);
  end loop;

end;
/

commit;
