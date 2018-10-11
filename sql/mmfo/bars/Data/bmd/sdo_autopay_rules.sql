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

  l_tabsemantic := '—ƒќ: ƒов≥дник правил дл€ автооплати документ≥в';
  l_tablinesdef := '';
  l_tabselect_statement := '';
  l_tabname     := 'SDO_AUTOPAY_RULES';

  -- получаем код таблицы
  l_tabid := bars_metabase.get_tabid(l_tabname);

  -- если таблица не описана в Ѕћƒ
  if l_tabid is null then

    -- получаем код дл€ новой таблицы
    l_tabid := bars_metabase.get_newtabid();

    -- добавл€ем описание таблицы в Ѕћƒ
    bars_metabase.add_table(l_tabid, l_tabname, l_tabsemantic, l_tabselect_statement);

  -- если таблица описана в Ѕћƒ
  else

    -- обновл€ем семантику таблицы
    bars_metabase.set_tabsemantic(l_tabid, l_tabsemantic);

    -- обновл€ем linesdef таблицы
    bars_metabase.set_tablinesdef(l_tabid, l_tablinesdef);

    -- обновл€ем select_statement таблицы
    bars_metabase.set_tabselect_statement(l_tabid, l_tabselect_statement);

    -- сохран€ем ссылки сложных полей других таблиц на пол€ нашей таблицы
    select e.tabid, e.colid, c.colname, e.tab_alias, e.tab_cond, e.src_cond, e.col_dyn_tabname
      bulk collect
      into l_extrnval
      from meta_extrnval e, meta_columns c
     where e.srctabid = l_tabid
       and e.srctabid = c.tabid and e.srccolid = c.colid;

    -- сохран€ем ссылки дл€ условий фильтра полей других таблиц на пол€ нашей таблицы
    select b.hosttabid, b.hostcolkeyid, c.colname, v.colname, b.addtabalias, v.semantic
      bulk collect
      into l_browsetbl
      from meta_browsetbl b, meta_columns c, meta_columns v
     where b.addtabid = l_tabid
       and b.addtabid = c.tabid and b.addcolkeyid = c.colid
       and b.addtabid = v.tabid and b.var_colid = v.colid;

    -- сохран€ем ссылки полей других таблиц на нашу вложенную таблицу
    select tabid, colid, filter_code, flag_ins, flag_del, flag_upd
      bulk collect
      into l_filtertbl
      from meta_filtertbl
     where filter_tabid = l_tabid and tabid <> l_tabid;

    -- сохран€ем зависимости между колонками таблицы
    select id, tabid, colid, event, depcolid, action_type, action_name, default_value, condition
      bulk collect
      into l_dependency
      from meta_dependency_cols
     where tabid = l_tabid;

    -- удал€ем описание полей
    bars_metabase.delete_metatables(l_tabid);

  end if;

  -- добавл€ем описание полей
  bars_metabase.add_column(l_tabid, 2, 'IS_ACTIVE', 'N', 'јктивн≥сть', '2', 22, 2, 0, 0, 0, 0, '', '', 1, 1, '', 0, 0, 1, '', '', 0);
  bars_metabase.add_column(l_tabid, 3, 'RULE_DESC', 'C', 'Ќазва правила', '5', 500, 3, 0, 0, 1, 0, '', '', 1, 1, '', 0, 0, 1, '', '', 0);
  bars_metabase.add_column(l_tabid, 4, 'RULE_ID', 'N', ' од правила', '1', 22, 1, 0, 0, 0, 1, '', '', 1, 1, '', 0, 0, 1, '', '', 0);

  -- очищаем описание функций на справочник
  bars_metabase.delete_nsifunction(l_tabid);

  -- восстанавливаем ссылки сложных полей других таблиц
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

  -- восстанавливаем ссылки полей дл€ условий фильтра других таблиц
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

  -- восстанавливаем ссылки полей других таблиц на нашу вложенную таблицу
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

  -- восстанавливаем зависимости между колонками таблицы
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
