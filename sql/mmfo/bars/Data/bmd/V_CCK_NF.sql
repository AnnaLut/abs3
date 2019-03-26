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
  l_newtabid     meta_tables.tabid%type;
  l_newcolid     meta_columns.colid%type;
  l_varcolid     meta_columns.colid%type;
  l_colname      meta_columns.colname%type;

begin

  l_tabsemantic := '�������� ����� ������� �� / V_CCK_NF';
  l_tablinesdef := '2000';
  l_tabname     := 'V_CCK_NF';

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
  bars_metabase.add_column(l_tabid, 7, 'CC_ID', 'C', '����.~� ��', 1.5, null, 5, 0, 0, 1, 0, '', '', 1, 0, '', 0, 0, 1, '', '', 0);
  bars_metabase.add_column(l_tabid, 8, 'DSDATE', 'D', '���� ���~䳿 ��~', 1.3, null, 10, 0, 0, 0, 0, '', '', 1, 0, '', 0, 0, 0, '', '', 0);
  bars_metabase.add_column(l_tabid, 9, 'DWDATE', 'D', '���� ������~䳿 ��~', 1.3, null, 11, 0, 0, 0, 0, '', '', 1, 0, '', 0, 0, 0, '', '', 0);
  bars_metabase.add_column(l_tabid, 11, 'ISP', 'N', '³��~����~�� ��', .5, null, 14, 0, 0, 0, 0, '', '', 1, 0, '', 0, 0, 1, '', '', 0);
  bars_metabase.add_column(l_tabid, 12, 'KV', 'N', '������ ��', .3, null, 8, 0, 0, 0, 0, '', '', 1, 0, '', 0, 0, 1, '', '', 0);
  bars_metabase.add_column(l_tabid, 14, 'ND', 'N', '��� �� � ���', 1.5, null, 1, 0, 1, 0, 0, '', '', 1, 0, '', 0, 0, 1, '', 'ShowAccList(0,AVIEW_ALL,AVIEW_ReadOnly|AVIEW_AllOptions,"exists(select 1 from V_ND_ACCOUNTS where nd=:ND and acc=a.acc)")', 0);
  bars_metabase.add_column(l_tabid, 17, 'PR', 'N', '%~��', .7, null, 9, 0, 0, 0, 0, '', '', 1, 0, '', 0, 0, 0, '', '', 0);
  bars_metabase.add_column(l_tabid, 20, 'RNK', 'N', '���~������������', 1.3, null, 3, 0, 0, 0, 0, '', '', 1, 0, '', 0, 0, 1, '', 'EditCustomer( IifN(:VIDD <10,2,3), NUMBER_Null, :CC_NMK, CVIEW_ReadOnly, hWndForm, 0, "", FALSE)', 0);
  bars_metabase.add_column(l_tabid, 22, 'SDOG', 'N', '���� �� ��������', 1.5, null, 7, 0, 0, 0, 0, '', '# ##0.00', 1, 0, '', 0, 0, 0, '', '', 0);
  bars_metabase.add_column(l_tabid, 29, 'NAMK', 'C', '�����~������������~', 1.5, null, 4, 0, 0, 0, 0, '', '', 1, 0, '', 0, 0, 1, '', '', 0);
  bars_metabase.add_column(l_tabid, 30, 'BRANCH', 'C', '�����~��', 2, null, 0, 0, 0, 0, 0, '', '', 1, 0, '', 0, 0, 1, '', '', 0);
  bars_metabase.add_column(l_tabid, 31, 'PROD', 'C', '���~�������~----------~���.����~', 1, null, 2, 0, 0, 0, 0, '', '', 1, 0, '', 0, 0, 1, 'sPar=CC_DOPW[NSIFUNCTION][ACCESSCODE=>1][PROC=>PUL.Set_Mas_Ini(''ND'',:ND, ''X'')][EXEC=>BEFORE][showDialogWindow=>false]', '', 0);
  bars_metabase.add_column(l_tabid, 33, 'NDI', 'N', '���~�����~���', 1.3, null, 13, 0, 0, 0, 0, '', '', 1, 0, '', 0, 0, 1, '', '', 0);
  bars_metabase.add_column(l_tabid, 35, 'ACC8', 'N', 'ACC ��� 8999*LIM', 1.3, null, 99, 0, 0, 0, 0, '', '', 1, 0, '', 0, 0, 0, '', '', 0);
  bars_metabase.add_column(l_tabid, 36, 'VIDD_NAME', 'C', '���~�� (�����)', 1.5, null, 6, 0, 0, 0, 0, '', '', 0, 0, '', 0, 0, 0, '', '', 0);
  bars_metabase.add_column(l_tabid, 37, 'SOS', 'C', '���� ��', 1.7, null, null, 0, 0, 0, 0, '', '', 0, 0, '', 0, 1, 0, '', '', 0);
  bars_metabase.add_column(l_tabid, 38, 'CHGDATE', 'C', '���� ������� ~������', 1.3, null, 15, 0, 0, 0, 0, '', '', 0, 0, '', 0, 0, 0, '', '', 0);

  -- ��������� �������� ��� ������� �������
  l_newtabid := bars_metabase.get_tabid('KU_108');
  l_newcolid := bars_metabase.get_colid(l_newtabid, 'NKD');
  l_varcolid := bars_metabase.get_colid(l_newtabid, 'KVZ');
  if (l_newtabid is not null and l_newcolid is not null) then
    bars_metabase.add_browsetbl(l_tabid, l_newtabid, '', '14', l_newcolid, l_varcolid, '��� ���');
  else
    dbms_output.put_line('� ��� �� ������� ������� KU_108 ��� �������� ������� ������� ������� V_CCK_NF.');
  end if;

  -- ��������� �������� ��� ������� �������
  l_newtabid := bars_metabase.get_tabid('KU_108');
  l_newcolid := bars_metabase.get_colid(l_newtabid, 'NKD');
  l_varcolid := bars_metabase.get_colid(l_newtabid, 'MPAWN');
  if (l_newtabid is not null and l_newcolid is not null) then
    bars_metabase.add_browsetbl(l_tabid, l_newtabid, '', '14', l_newcolid, l_varcolid, '�������� ���');
  else
    dbms_output.put_line('� ��� �� ������� ������� KU_108 ��� �������� ������� ������� ������� V_CCK_NF.');
  end if;

  -- ��������� �������� ��� ������� �������
  l_newtabid := bars_metabase.get_tabid('KU_108');
  l_newcolid := bars_metabase.get_colid(l_newtabid, 'NKD');
  l_varcolid := bars_metabase.get_colid(l_newtabid, 'NLSZ');
  if (l_newtabid is not null and l_newcolid is not null) then
    bars_metabase.add_browsetbl(l_tabid, l_newtabid, '', '14', l_newcolid, l_varcolid, '���.���� ');
  else
    dbms_output.put_line('� ��� �� ������� ������� KU_108 ��� �������� ������� ������� ������� V_CCK_NF.');
  end if;

  -- ��������� �������� ��� ������� �������
  l_newtabid := bars_metabase.get_tabid('KU_108');
  l_newcolid := bars_metabase.get_colid(l_newtabid, 'NKD');
  l_varcolid := bars_metabase.get_colid(l_newtabid, 'NZD');
  if (l_newtabid is not null and l_newcolid is not null) then
    bars_metabase.add_browsetbl(l_tabid, l_newtabid, '', '14', l_newcolid, l_varcolid, '��� ������');
  else
    dbms_output.put_line('� ��� �� ������� ������� KU_108 ��� �������� ������� ������� ������� V_CCK_NF.');
  end if;

  -- ��������� �������� ��� ������� �������
  l_newtabid := bars_metabase.get_tabid('KU_108');
  l_newcolid := bars_metabase.get_colid(l_newtabid, 'NKD');
  l_varcolid := bars_metabase.get_colid(l_newtabid, 'OKPOZ');
  if (l_newtabid is not null and l_newcolid is not null) then
    bars_metabase.add_browsetbl(l_tabid, l_newtabid, '', '14', l_newcolid, l_varcolid, '���� ������������');
  else
    dbms_output.put_line('� ��� �� ������� ������� KU_108 ��� �������� ������� ������� ������� V_CCK_NF.');
  end if;

  -- ��������� �������� ��� ������� �������
  l_newtabid := bars_metabase.get_tabid('KU_108');
  l_newcolid := bars_metabase.get_colid(l_newtabid, 'NKD');
  l_varcolid := bars_metabase.get_colid(l_newtabid, 'PAWN');
  if (l_newtabid is not null and l_newcolid is not null) then
    bars_metabase.add_browsetbl(l_tabid, l_newtabid, '', '14', l_newcolid, l_varcolid, '��� ������');
  else
    dbms_output.put_line('� ��� �� ������� ������� KU_108 ��� �������� ������� ������� ������� V_CCK_NF.');
  end if;

  -- ��������� �������� ��� ������� �������
  l_newtabid := bars_metabase.get_tabid('CUSTOMER');
  l_newcolid := bars_metabase.get_colid(l_newtabid, 'RNK');
  l_varcolid := bars_metabase.get_colid(l_newtabid, 'NMK');
  if (l_newtabid is not null and l_newcolid is not null) then
    bars_metabase.add_browsetbl(l_tabid, l_newtabid, '', '20', l_newcolid, l_varcolid, '������������ �����������');
  else
    dbms_output.put_line('� ��� �� ������� ������� CUSTOMER ��� �������� ������� ������� ������� V_CCK_NF.');
  end if;

  -- ��������� �������� ����������
  bars_metabase.add_sortorder(l_tabid, 14, 2, 'DESC');

  -- ��������� �������� ����������
  bars_metabase.add_sortorder(l_tabid, 38, 1, 'DESC');

  -- ������� �������� ������� �� ����������
  bars_metabase.delete_nsifunction(l_tabid);

  -- ��������� �������� ������� �� ����������
  bars_metabase.add_nsifunction(l_tabid, 1, '��: �������� ������ ��', '', '', 'ONCE', '', '', '4', '', '/barsroot/CreditUi/NewCredit/?custtype=3', 4);

  -- ��������� �������� ������� �� ����������
  bars_metabase.add_nsifunction(l_tabid, 2, '��:�������� ', 'CCK.CC_DELETE(  :ND  )', '', 'EACH', '�������� ���������� ��   :ND ����������� :NAMK ?', '�������� ���������� ��   :ND ����������� :NAMK  ! ', '54', '', '', 54);

  -- ��������� �������� ������� �� ����������
  bars_metabase.add_nsifunction(l_tabid, 3, '��: ����������� ��', 'cck_ui.AUTOR(:ND,:M,:X,:Y)', ':M(SEM=0=������_1=�����,TYPE=N),:X(SEM=ϳ������,TYPE=S),:Y(SEM=����������,TYPE=S)', 'EACH', '�� :CC_ID �� :DSDATE?', '', '58', '', '', 58);

  -- ��������� �������� ������� �� ����������
  bars_metabase.add_nsifunction(l_tabid, 4, '��: �������� ��������� �� ', '', '', '', '', '', '80', '', '/barsroot/CreditUi/NewCredit/?custtype=3'||chr(38)||'nd=:ND', 80);

  -- ��������� �������� ������� �� ����������
  bars_metabase.add_nsifunction(l_tabid, 5, '��: ������� �� ��������,���''����� � ��', '', '', 'ONCE', '', '', '106', '', '/barsroot/CreditUi/accounts/Index/?id=:ND', 106);

  -- ��������� �������� ������� �� ����������
  bars_metabase.add_nsifunction(l_tabid, 6, '��: �������� ��� ��� �������� ��', '', '', 'EACH', '', '', '83', '', 'sPar=CC_W_LIM1_EXT[NSIFUNCTION][ACCESSCODE=>0][PROC=>PUL.PUT(''ND'',:ND);PUL.PUT(''ACC8'',:ACC8)][EXEC=>BEFORE][showDialogWindow=>false][EDIT_MODE=>MULTI_EDIT]', 83);

  -- ��������� �������� ������� �� ����������
  bars_metabase.add_nsifunction(l_tabid, 7, '��: ��������� ����. ������� �� �� ', '', '', 'ONCE', '', '', '80', '', 'sPar=CCK_PL_INS[NSIFUNCTION][CONDITIONS=> ND=:ND][ACCESSCODE=>0][PROC=>PUL.Set_Mas_Ini(''ND'',:ND,''X'')][EXEC=>BEFORE][showDialogWindow=>false]', 80);

  -- ��������� �������� ������� �� ����������
  bars_metabase.add_nsifunction(l_tabid, 8, '��: ������ ���� ������������', '', '', 'ONCE', '', '', '79', '', '/barsroot/CreditUi/glk/Index/?id=:ND', 79);

  -- ��������� �������� ������� �� ����������
  bars_metabase.add_nsifunction(l_tabid, 9, '��: �������� ������������', '', '', 'ONCE', '', '', '65', '', 'sPar=V_ZAL_ND[NSIFUNCTION][ACCESSCODE=>5][PROC=>PUL.Set_Mas_Ini(''ND'',:ND,''X''); PUL.Set_Mas_Ini(''ACCC'',:ACC8, ''ACCC'')][EXEC=>BEFORE][showDialogWindow=>false]', 65);

  -- ��������� �������� ������� �� ����������
  bars_metabase.add_nsifunction(l_tabid, 12, '��: ������ �볺���', '', '', 'ONCE', '', '', '155', '', '/barsroot/clientregister/registration.aspx?readonly=1'||chr(38)||'rnk=:RNK', null);

  -- ��������� �������� ������� �� ����������
  bars_metabase.add_nsifunction(l_tabid, 15, '��: ������������� �������� �������� ������������', '', '', '', '', '', '105', '', '/barsroot/barsweb/dynform.aspx?form=frm_fin2_kart_kl_fl'||chr(38)||'rnk=:RNK', 105);

  -- ��������� �������� ������� �� ����������
  bars_metabase.add_nsifunction(l_tabid, 18, '��: ����� ���� �� �������� ��', '', '', 'ONCE', '', '', '93', '', 'sPar=CC_SOB[ACCESSCODE=>5][PROC=>PUL.Set_Mas_Ini(''ND'',:ND,''X'')][EXEC=>BEFORE][showDialogWindow=>false][CONDITIONS=> nd=:ND]', 93);

  -- ��������� �������� ������� �� ����������
  bars_metabase.add_nsifunction(l_tabid, 25, '��: ��䳿 ', '', '', 'ONCE', '', '', '86', '', 'sPar=CC_SOB_WF[ACCESSCODE=>1][PROC=>PUL_DAT(:B,:E)][PAR=>:B(SEM=�,TYPE=S),:E(SEM=��,TYPE=S)][DESCR=>��: ��䳿 ][EXEC=>BEFORE]', 86);

  -- ��������� �������� ������� �� ����������
  bars_metabase.add_nsifunction(l_tabid, 99, '��: ����� �������� �� ', '', '', 'ONCE', '', '', '75', '', 'sPar=V_CCK_ZF[ACCESSCODE=>1][DESCR=>��: ����� �������� ��]', 75);

  -- ��������� �������� ������� �� ����������
  bars_metabase.add_nsifunction(l_tabid, 105, '���', '', '', 'EACH', '', '', '102', '', '/barsroot/CreditUi/Glk/Index/?id=:ND', null);

  -- ��������� �������� ���������
  bars_metabase.add_tblcolor(l_tabid, 1, null, ':DWDATE < GL.BD +30', 2, 'COLOR_LightGray');

  -- ��������� �������� ���������
  bars_metabase.add_tblcolor(l_tabid, 2, null, ':DWDATE < GL.BD +7', 2, 'COLOR_LightAqua');

  -- ��������� �������� ���������
  bars_metabase.add_tblcolor(l_tabid, 3, null, ':DWDATE = GL.BD', 2, 'COLOR_LightGreen');

  -- ��������� �������� ���������
  bars_metabase.add_tblcolor(l_tabid, 4, null, ':DWDATE < GL.BD ', 2, 'COLOR_Salmon');

  -- ��������� �������� ���������
  bars_metabase.add_tblcolor(l_tabid, 5, null, ':DWDATE > GL.BD and :SOS > 10 ', 2, 'COLOR_Orchid');

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