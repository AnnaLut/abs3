
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/meta_export.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.META_EXPORT (p_tabname meta_tables.tabname%type)
return clob
is
---
-- Повертає текст скрипта мета-опису 
-- Музика О.С.
-- 13/11/2013
--
l_tabid meta_tables.tabid%type;
l_semantic meta_tables.semantic%type;
l_tabrelation meta_tables.tabrelation%type;
l_acc_par          number:=0;
l_adm_staff_access number:=0;
l_res              clob;
begin
  begin
       select tabid, semantic, nvl(to_char(tabrelation), 'null')
              into l_tabid, l_semantic, l_tabrelation
         from meta_tables
        where upper(tabname)=upper(p_tabname);
        exception when no_data_found
          then raise_application_error(-20000, 'Table '||p_tabname||' is not defined');
    end;

    select count(*)
        into l_acc_par
     from acc_par
      where tabid=l_tabid;

    select count(*)
           into l_adm_staff_access
     from adm_staff_access
      where tabid=l_tabid;

l_res:=
  'set serveroutput on'||chr(13)||chr(10)||
  '    declare'||chr(13)||chr(10)||
  '--объявление типа t_rec_metaextrnval'||chr(13)||chr(10)||
  '  type t_rec_metaextrnval is record ('||chr(13)||chr(10)||
  '     tabid      meta_extrnval.tabid%type,'||chr(13)||chr(10)||
  '     colid      meta_extrnval.colid%type,'||chr(13)||chr(10)||
  '     srccolname meta_columns.colname%type,'||chr(13)||chr(10)||
  '     tab_alias  meta_extrnval.tab_alias%type,'||chr(13)||chr(10)||
  '     tab_cond   meta_extrnval.tab_cond%type);'||chr(13)||chr(10)||
  '  type t_tab_metaextrnval is table of t_rec_metaextrnval;'||chr(13)||chr(10)||
  '  l_arr_metaextrnval t_tab_metaextrnval := t_tab_metaextrnval();'||chr(13)||chr(10)||
  ' '||chr(13)||chr(10)||
  '--объявление типа t_rec_metabrowsetbl'||chr(13)||chr(10)||
  '  type t_rec_metabrowsetbl is record ('||chr(13)||chr(10)||
  '     hosttabid   meta_browsetbl.hosttabid%type,'||chr(13)||chr(10)||
  '     hostcolid   meta_browsetbl.hostcolkeyid%type,'||chr(13)||chr(10)||
  '     addcolname  meta_columns.colname%type,'||chr(13)||chr(10)||
  '     varcolname  meta_columns.colname%type,'||chr(13)||chr(10)||
  '     addtabalias meta_browsetbl.addtabalias%type,'||chr(13)||chr(10)||
  '     cond_tag    meta_browsetbl.cond_tag%type);'||chr(13)||chr(10)||
  '  type t_tab_metabrowsetbl is table of t_rec_metabrowsetbl;'||chr(13)||chr(10)||
  '  l_arr_metabrowsetbl t_tab_metabrowsetbl := t_tab_metabrowsetbl();'||chr(13)||chr(10)||
  '  '||chr(13)||chr(10);

  if l_acc_par>0 then
    l_res:=l_res||'  --объявление типа t_rec_accpar'||chr(13)||chr(10)||
                  '  type t_rec_accpar is record ('||chr(13)||chr(10)||
                  '     colname     meta_columns.colname%type,'||chr(13)||chr(10)||
                  '     pr          acc_par.pr%type);'||chr(13)||chr(10)||
                  '  type t_tab_accpar is table of t_rec_accpar;'||chr(13)||chr(10)||
                  '  l_arr_accpar t_tab_accpar := t_tab_accpar();'||chr(13)||chr(10);
    end if;

  if l_adm_staff_access>0 then
    l_res:=l_res||'  '||chr(13)||chr(10)||
    '  --бъявление типа t_rec_admstaffaccess'||chr(13)||chr(10)||
    '  type t_rec_admstaffaccess is record ('||chr(13)||chr(10)||
    '     colname     meta_columns.colname%type,'||chr(13)||chr(10)||
    '     sec         adm_staff_access.sec%type);'||chr(13)||chr(10)||
    '  type t_tab_admstaffaccess is table of t_rec_admstaffaccess;'||chr(13)||chr(10)||
    '  l_arr_admstaffaccess t_tab_admstaffaccess := t_tab_admstaffaccess();'||chr(13)||chr(10);
    end if;


  l_res:=l_res||
  '--объявление типа t_rec_metafiltertbl'||chr(13)||chr(10)||
  '  type t_rec_metafiltertbl is record ('||chr(13)||chr(10)||
  '     tabid   meta_filtertbl.tabid%type,'||chr(13)||chr(10)||
  '     colid   meta_filtertbl.colid%type,'||chr(13)||chr(10)||
  '     fltcode meta_filtertbl.filter_code%type);'||chr(13)||chr(10)||
  '  type t_tab_metafiltertbl is table of t_rec_metafiltertbl;'||chr(13)||chr(10)||
  '  l_arr_metafiltertbl t_tab_metafiltertbl := t_tab_metafiltertbl();'||chr(13)||chr(10)||
  '  '||chr(13)||chr(10)||
  '--объявление переменных'||chr(13)||chr(10)||
  '  l_tabid       meta_tables.tabid%type;'||chr(13)||chr(10)||
  '  l_tabname     meta_tables.tabname%type;'||chr(13)||chr(10)||
  '  l_tabsemantic meta_tables.semantic%type;'||chr(13)||chr(10)||
  '  l_newtabid    meta_tables.tabid%type;'||chr(13)||chr(10)||
  '  l_newcolid    meta_columns.colid%type;'||chr(13)||chr(10)||
  '  l_varcolid    meta_columns.colid%type;'||chr(13)||chr(10)||
  '  l_colname     meta_columns.colname%type;'||chr(13)||chr(10)||
  '  i             number;'||chr(13)||chr(10)||
  '  '||chr(13)||chr(10)||
  'begin'||chr(13)||chr(10)||
  '  '||chr(13)||chr(10)||
  '  l_tabsemantic := '''||l_semantic||''''||';'||chr(13)||chr(10)||
  '  l_tabname := '''||upper(p_tabname)||''''||';'||chr(13)||chr(10)||
  '  '||chr(13)||chr(10)||
  '-- получаем код таблицы'||chr(13)||chr(10)||
  '  l_tabid := bars_metabase.get_tabid(l_tabname);'||chr(13)||chr(10)||
  '  '||chr(13)||chr(10)||
  '-- если таблица не описана в БМД'||chr(13)||chr(10)||
  '  if l_tabid is null then'||chr(13)||chr(10)||
  '     -- получаем код для новой таблицы'||chr(13)||chr(10)||
  '     l_tabid := bars_metabase.get_newtabid();'||chr(13)||chr(10)||
  '     -- добавляем описание таблицы в БМД'||chr(13)||chr(10)||
  '     bars_metabase.add_table(l_tabid, l_tabname, l_tabsemantic);'||chr(13)||chr(10)||
  '  -- если таблица описана в БМД'||chr(13)||chr(10)||
  '  else'||chr(13)||chr(10)||
  '     -- обновляем семантику таблицы'||chr(13)||chr(10)||
  '     bars_metabase.set_tabsemantic(l_tabid, l_tabsemantic);'||chr(13)||chr(10)||
  '     -- сохраняем ссылки сложных полей других таблиц на поля нашей таблицы'||chr(13)||chr(10)||
  '     i := 0;'||chr(13)||chr(10)||
  '     for k in (select e.tabid, e.colid, e.tab_cond, c.colname, e.tab_alias'||chr(13)||chr(10)||
  '                 from meta_extrnval e, meta_columns c'||chr(13)||chr(10)||
  '                where e.srctabid=l_tabid'||chr(13)||chr(10)||
  '                  and e.srctabid=c.tabid and e.srccolid=c.colid)'||chr(13)||chr(10)||
  '     loop'||chr(13)||chr(10)||
  '        i := i + 1;'||chr(13)||chr(10)||
  '        l_arr_metaextrnval.extend;'||chr(13)||chr(10)||
  '        l_arr_metaextrnval(i).tabid      := k.tabid;'||chr(13)||chr(10)||
  '        l_arr_metaextrnval(i).colid      := k.colid;'||chr(13)||chr(10)||
  '        l_arr_metaextrnval(i).srccolname := k.colname;'||chr(13)||chr(10)||
  '        l_arr_metaextrnval(i).tab_alias  := k.tab_alias;'||chr(13)||chr(10)||
  '        l_arr_metaextrnval(i).tab_cond   := k.tab_cond;'||chr(13)||chr(10)||
  '     end loop;'||chr(13)||chr(10)||
  '  '||chr(13)||chr(10)||
  ' -- сохраняем ссылки для условий фильтра полей других таблиц на поля нашей таблицы'||chr(13)||chr(10)||
  '     i := 0;'||chr(13)||chr(10)||
  '     for k in (select b.hosttabid, b.hostcolkeyid, b.addtabalias,'||chr(13)||chr(10)||
  '                      c.colname k_colname, v.colname v_colname, v.semantic v_colsemantic'||chr(13)||chr(10)||
  '                 from meta_browsetbl b, meta_columns c, meta_columns v'||chr(13)||chr(10)||
  '                where b.addtabid=l_tabid'||chr(13)||chr(10)||
  '                  and b.addtabid=c.tabid and b.addcolkeyid=c.colid'||chr(13)||chr(10)||
  '                  and b.addtabid=v.tabid and b.var_colid=v.colid)'||chr(13)||chr(10)||
  '     loop'||chr(13)||chr(10)||
  '        i := i + 1;'||chr(13)||chr(10)||
  '        l_arr_metabrowsetbl.extend;'||chr(13)||chr(10)||
  '        l_arr_metabrowsetbl(i).hosttabid   := k.hosttabid;'||chr(13)||chr(10)||
  '        l_arr_metabrowsetbl(i).hostcolid   := k.hostcolkeyid;'||chr(13)||chr(10)||
  '        l_arr_metabrowsetbl(i).addcolname  := k.k_colname;'||chr(13)||chr(10)||
  '        l_arr_metabrowsetbl(i).varcolname  := k.v_colname;'||chr(13)||chr(10)||
  '        l_arr_metabrowsetbl(i).addtabalias := k.addtabalias;'||chr(13)||chr(10)||
  '        l_arr_metabrowsetbl(i).cond_tag    := k.v_colsemantic;'||chr(13)||chr(10)||
  '     end loop;'||chr(13)||chr(10)||
  '  '||chr(13)||chr(10)||
  '     -- сохраняем ссылки полей других таблиц на нашу вложенную таблицу'||chr(13)||chr(10)||
  '     i := 0;'||chr(13)||chr(10)||
  '     for k in (select tabid, colid, filter_code'||chr(13)||chr(10)||
  '                 from meta_filtertbl'||chr(13)||chr(10)||
  '                where filter_tabid = l_tabid and tabid <> l_tabid)'||chr(13)||chr(10)||
  '     loop'||chr(13)||chr(10)||
  '        i := i + 1;'||chr(13)||chr(10)||
  '        l_arr_metafiltertbl.extend;'||chr(13)||chr(10)||
  '        l_arr_metafiltertbl(i).tabid   := k.tabid;'||chr(13)||chr(10)||
  '        l_arr_metafiltertbl(i).colid   := k.colid;'||chr(13)||chr(10)||
  '        l_arr_metafiltertbl(i).fltcode := k.filter_code;'||chr(13)||chr(10)||
  '     end loop;'||chr(13)||chr(10)||
  '  '||chr(13)||chr(10);
 -- сохраняем ссылки полей справочника 'Параметры клиентов и счетов' на поля нашей таблицы
  if l_acc_par>0 then
    l_res:=l_res||'  -- сохраняем ссылки полей справочника "Параметры клиентов и счетов" на поля нашей таблицы'||chr(13)||chr(10)||
      '     i := 0;'||chr(13)||chr(10)||
      '     for k in (select c.colname, a.pr'||chr(13)||chr(10)||
      '                 from acc_par a, meta_columns c'||chr(13)||chr(10)||
      '                where a.tabid=l_tabid'||chr(13)||chr(10)||
      '                  and a.tabid=c.tabid'||chr(13)||chr(10)||
      '                  and a.colid=c.colid)'||chr(13)||chr(10)||
      '     loop'||chr(13)||chr(10)||
      '        i := i + 1;'||chr(13)||chr(10)||
      '        l_arr_accpar.extend;'||chr(13)||chr(10)||
      '        l_arr_accpar(i).colname := k.colname;'||chr(13)||chr(10)||
      '        l_arr_accpar(i).pr := k.pr;'||chr(13)||chr(10)||
      '     end loop;'||chr(13)||chr(10);
    end if;
  --сохраняем ссылки полей справочника 'Доп. доступ пользователей' на поля нашей таблицы
  if l_adm_staff_access>0 then
      l_res:=l_res||'  '||chr(13)||chr(10)||
      '  --сохраняем ссылки полей справочника "Доп. доступ пользователей" на поля нашей таблицы'||chr(13)||chr(10)||
      '     i := 0;'||chr(13)||chr(10)||
      '     for k in (select c.colname, a.sec'||chr(13)||chr(10)||
      '                 from adm_staff_access a, meta_columns c'||chr(13)||chr(10)||
      '                where a.tabid=l_tabid'||chr(13)||chr(10)||
      '                  and a.tabid=c.tabid'||chr(13)||chr(10)||
      '                  and a.colid=c.colid)'||chr(13)||chr(10)||
      '     loop'||chr(13)||chr(10)||
      '        i := i + 1;'||chr(13)||chr(10)||
      '        l_arr_admstaffaccess.extend;'||chr(13)||chr(10)||
      '        l_arr_admstaffaccess(i).colname := k.colname;'||chr(13)||chr(10)||
      '        l_arr_admstaffaccess(i).sec := k.sec;'||chr(13)||chr(10)||
      '     end loop;'||chr(13)||chr(10)||
      ''||chr(13)||chr(10)||
      ''||chr(13)||chr(10)||
      ''||chr(13)||chr(10)||
      ''||chr(13)||chr(10);
    end if;

 l_res:=l_res||'     -- удаляем описание полей'||chr(13)||chr(10);

   if l_acc_par>0 then
       l_res:=l_res||'  '||chr(13)||chr(10)||
                     '     delete from acc_par where tabid=l_tabid;'||chr(13)||chr(10);
    end if;

    if l_adm_staff_access>0 then
      l_res:=l_res||'  '||chr(13)||chr(10)||
                    '     delete from adm_staff_access where tabid=l_tabid;'||chr(13)||chr(10);
      end if;

  l_res:=l_res||'     bars_metabase.delete_metatables(l_tabid);'||chr(13)||chr(10)||
  '  end if;'||chr(13)||chr(10)||
  '  '||chr(13)||chr(10)||
  '  -- добавляем описание полей'||chr(13)||chr(10);

 -- добавляем описание полей
 begin
  for k in(select nvl(to_char(colid), 'null') colid, colname, coltype, semantic,
                  nvl(to_char(showwidth), 'null') showwidth, nvl(to_char(showmaxchar), 'null') showmaxchar,
                  nvl(to_char(showpos), 'null') showpos, nvl(to_char(showin_ro), 'null') showin_ro,
                  nvl(to_char(showretval), 'null') showretval, nvl(to_char(instnssemantic), 'null') instnssemantic,
                  nvl(to_char(extrnval), 'null') extrnval, nvl(to_char(showrel_ctype), 'null') showrel_ctype, nvl(to_char(showformat), 'null') showformat,
                  nvl(to_char(showin_fltr), 'null') showin_fltr, nvl(to_char(showref), 'null') showref, nvl(to_char(showresult), 'null') showresult,
                  nvl(to_char(not_to_edit), 'null') not_to_edit, nvl(to_char(not_to_show), 'null') not_to_show,
                  nvl(to_char(simple_filter), 'null') simple_filter,  nvl(to_char(form_name), 'null') form_name
             from meta_columns
            where tabid=l_tabid
            order by colid)
    loop
      l_res:=l_res||
      '  bars_metabase.add_column(l_tabid, '''||k.colid||''''||', '''
      ||k.colname||''''||', '''
      ||k.coltype||''''||', '''
      ||k.semantic||''''||', '
      ||k.showwidth||', '
      ||k.showmaxchar||', '
      ||k.showpos||', '
      ||k.showin_ro||', '
      ||k.showretval||', '
      ||k.instnssemantic||', '
      ||k.extrnval||', '
      ||k.showrel_ctype||', '
      ||k.showformat||', '
      ||k.showin_fltr||', '
      ||k.showref||', '
      ||k.showresult||', '
      ||k.not_to_edit||', '
      ||k.not_to_show||', '
      ||k.simple_filter||', '
      ||k.form_name||');'
      ||chr(13)||chr(10);

      end loop;
    end;
  -- добавляем описание сложного поля
  begin
    for c in(select nvl(to_char(e.colid), 'null') colid, t.tabname tabname, c.colname colname, e.tab_alias tab_alias, e.tab_cond tab_cond
               from meta_extrnval e, meta_tables t, meta_columns c
              where e.tabid=l_tabid
                and e.srctabid=t.tabid
                and e.srctabid=c.tabid
                and e.srccolid=c.colid)
           loop
             l_res:=l_res||'  -- добавляем описание сложного поля'||chr(13)||chr(10);
             l_res:=l_res||'  l_newtabid := bars_metabase.get_tabid('''||c.tabname||''''||');'||chr(13)||chr(10);
             l_res:=l_res||'  l_newcolid := bars_metabase.get_colid(l_newtabid, '''||c.colname||''''||');'||chr(13)||chr(10);
             l_res:=l_res||'  if (l_newtabid is not null and l_newcolid is not null) then'||chr(13)||chr(10);
             l_res:=l_res||'     bars_metabase.add_extrnval(l_tabid, '''||c.colid||''''||', l_newtabid, l_newcolid, '''||c.tab_alias||''''||', '''||c.tab_cond||''''||');'||chr(13)||chr(10);
             l_res:=l_res||'  else'||chr(13)||chr(10);
             l_res:=l_res||'     dbms_output.put_line(''В БМД не описана таблица '||c.tabname||' для описания сложного поля таблицы '||upper(p_tabname)||''');'||chr(13)||chr(10);
             l_res:=l_res||'  end if;'||chr(13)||chr(10);
             end loop;
    end;
   -- добавляем описание для условий фильтра
  begin
    for x in(select nvl(to_char(b.hostcolkeyid), 'null') hostcolkeyid, nvl(to_char(t.tabname), 'null') tabname,nvl(to_char(c.colname), 'null') c_colname,
                    nvl(to_char(v.colname), 'null') v_colname,nvl(to_char(b.addtabalias), 'null') addtabalias,nvl(to_char(b.cond_tag), 'null') cond_tag
                       from meta_browsetbl b, meta_tables t, meta_columns c, meta_columns v
              where b.hosttabid=l_tabid
                and b.addtabid=t.tabid
                and b.addtabid=c.tabid
                and b.addcolkeyid=c.colid
                and b.addtabid=v.tabid
                and b.var_colid=v.colid)
         loop
            l_res:=l_res||'  -- добавляем описание для условий фильтра'||chr(13)||chr(10);
            l_res:=l_res||'  l_newtabid := bars_metabase.get_tabid(''' || x.tabname || ''''||');'||chr(13)||chr(10);
            l_res:=l_res||'  l_newcolid := bars_metabase.get_colid(l_newtabid, ''' || x.c_colname || ''''||');'||chr(13)||chr(10);
            l_res:=l_res||'  l_varcolid := bars_metabase.get_colid(l_newtabid, ''' || x.v_colname || ''''||');'||chr(13)||chr(10);
            l_res:=l_res||'  if (l_newtabid is not null and l_newcolid is not null) then'||chr(13)||chr(10);
            l_res:=l_res||'     bars_metabase.add_browsetbl(l_tabid, l_newtabid, '''||x.addtabalias||''''||', '''||x.hostcolkeyid||''''||', l_newcolid, l_varcolid, '''||x.cond_tag||''''||');'||chr(13)||chr(10);
            l_res:=l_res||'  else'||chr(13)||chr(10);
            l_res:=l_res||'     dbms_output.put_line(''В БМД не описана таблица '||x.tabname||' для описания условий фильтра таблицы '||upper(p_tabname)||''');'||chr(13)||chr(10);
            l_res:=l_res||'  end if;'||chr(13)||chr(10);
           end loop;
    end;

    --добавляем описание вложенных таблиц
    begin
      for z in(select f.colid, t.tabname, d.code, d.name, d.condition, f.flag_ins, f.flag_del, f.flag_upd
             from meta_filtertbl f, meta_tables t, meta_filtercodes d
            where f.tabid        = l_tabid
              and f.filter_tabid = t.tabid
              and f.filter_code  = d.code)
        loop
          l_res:=l_res||'  -- добавляем описание вложенных таблиц'||chr(13)||chr(10);
          l_res:=l_res||'  l_newtabid := bars_metabase.get_tabid(''' || z.tabname || ''''||');'||chr(13)||chr(10);
          l_res:=l_res||'  if (l_newtabid is not null) then'||chr(13)||chr(10);
          l_res:=l_res||'     bars_metabase.change_filter('''||z.code||''''||', '''||z.name||''''||', '''||replace(z.condition, chr(39), chr(39)||chr(39))||''''||');'||chr(13)||chr(10);
          l_res:=l_res||'     bars_metabase.add_filtertbl(l_tabid, '''||to_char(z.colid)||''''||', l_newtabid, '''||z.code||''''||', '''||to_char(z.flag_ins)||''''||', '''||to_char(z.flag_del)||''''||', '''||to_char(z.flag_upd)||''''||');'||chr(13)||chr(10);
          l_res:=l_res||'  else'||chr(13)||chr(10);
          l_res:=l_res||'     dbms_output.put_line(''В БМД не описана таблица '||z.tabname||' для описания вложенности таблицы '||upper(p_tabname)||''');'||chr(13)||chr(10);
          l_res:=l_res||'  end if;'||chr(13)||chr(10);
          end loop;
      end;

      --добавляем описание сортировки
      begin
        for t in(select nvl(to_char(colid), 'null') colid, nvl(to_char(sortorder), 'null') sortorder, sortway
          from meta_sortorder
          where tabid=l_tabid)
          loop
            l_res:=l_res||'  -- добавляем описание сортировки'||chr(13)||chr(10);
            l_res:=l_res||'  bars_metabase.add_sortorder(l_tabid, ''' || t.colid || ''''||', ''' || t.sortorder || ''''||', ''' || t.sortway || ''''||');'||chr(13)||chr(10);
            end loop;
        end;

     --добавляем описание процедур
     begin
     for s in(select action_code, action_proc
                from meta_actiontbl
                  where tabid=l_tabid)
          loop
            l_res:=l_res||'  -- добавляем описание процедур'||chr(13)||chr(10);
            l_res:=l_res||'  bars_metabase.add_actiontbl(l_tabid, ''' || s.action_code || ''''||', ''' || s.action_proc || ''''||');'||chr(13)||chr(10);
            end loop;
       end;

     --добавляем описание функций на справочник
     begin

       l_res:=l_res||'  -- очищаем описание функций на справочник'||chr(13)||chr(10);
       l_res:=l_res||'  bars_metabase.delete_nsifunction(l_tabid);'||chr(13)||chr(10);

       for e in(select funcid, descr, proc_name, proc_par, proc_exec, qst, msg, form_name
                   from meta_nsifunction
                     where tabid=l_tabid
                       order by funcid)
         loop
           l_res:=l_res||'  --добавляем описание функций на справочник'||chr(13)||chr(10);
           l_res:=l_res||'  bars_metabase.add_nsifunction(l_tabid, '''||e.funcid||''''||', '''||
           e.descr||''''||', '''||replace(e.proc_name, chr(39), chr(39)||chr(39))||''''||', '''||
           replace(e.proc_par, chr(39), chr(39)||chr(39))||''''||', '''||
           e.proc_exec||''''||', '''||
           e.qst||''''||', '''||
           e.msg||''''||', '''||
           replace(e.form_name, chr(39), chr(39)||chr(39))||'''' ||');'||chr(13)||chr(10);
           end loop;
       end;

       --восстанавливаем ссылки сложных полей других таблиц

       l_res:=l_res||' '||chr(13)||chr(10);
       l_res:=l_res||'  for i in 1..l_arr_metaextrnval.count'||chr(13)||chr(10)||
                     '  loop'||chr(13)||chr(10)||
                     '    l_newcolid := bars_metabase.get_colid(l_tabid, l_arr_metaextrnval(i).srccolname);'||chr(13)||chr(10)||
                     '     if (l_newcolid is not null) then'||chr(13)||chr(10)||
                     '        bars_metabase.add_extrnval('||chr(13)||chr(10)||
                     '           l_arr_metaextrnval(i).tabid,'||chr(13)||chr(10)||
                     '           l_arr_metaextrnval(i).colid,'||chr(13)||chr(10)||
                     '           l_tabid,'||chr(13)||chr(10)||
                     '           l_newcolid,'||chr(13)||chr(10)||
                     '           l_arr_metaextrnval(i).tab_alias,'||chr(13)||chr(10)||
                     '           l_arr_metaextrnval(i).tab_cond);'||chr(13)||chr(10)||
                     '     end if;'||chr(13)||chr(10)||
                     '  end loop;'||chr(13)||chr(10)||
                     '  '||chr(13)||chr(10);
      -- восстанавливаем ссылки полей для условий фильтра других таблиц
       l_res:=l_res||'  -- восстанавливаем ссылки полей для условий фильтра других таблиц'||chr(13)||chr(10)||
                     '  for i in 1..l_arr_metabrowsetbl.count'||chr(13)||chr(10)||
                     '  loop'||chr(13)||chr(10)||
                     '     l_newcolid := bars_metabase.get_colid(l_tabid, l_arr_metabrowsetbl(i).addcolname);'||chr(13)||chr(10)||
                     '     l_varcolid := bars_metabase.get_colid(l_tabid, l_arr_metabrowsetbl(i).varcolname);'||chr(13)||chr(10)||
                     '     if (l_newcolid is not null and l_varcolid is not null) then'||chr(13)||chr(10)||
                     '        bars_metabase.add_browsetbl( '||chr(13)||chr(10)||
                     '           l_arr_metabrowsetbl(i).hosttabid,'||chr(13)||chr(10)||
                     '           l_tabid,'||chr(13)||chr(10)||
                     '           l_arr_metabrowsetbl(i).addtabalias,'||chr(13)||chr(10)||
                     '           l_arr_metabrowsetbl(i).hostcolid,'||chr(13)||chr(10)||
                     '           l_newcolid,'||chr(13)||chr(10)||
                     '           l_varcolid,'||chr(13)||chr(10)||
                     '           l_arr_metabrowsetbl(i).cond_tag);'||chr(13)||chr(10)||
                     '     end if;'||chr(13)||chr(10)||
                     '  end loop;'||chr(13)||chr(10);
       --восстанавливаем ссылки полей других таблиц на нашу вложенную таблицу
       l_res:=l_res||'  '||chr(13)||chr(10)||
                     '  -- восстанавливаем ссылки полей других таблиц на нашу вложенную таблицу'||chr(13)||chr(10)||
                     '  for i in 1..l_arr_metafiltertbl.count'||chr(13)||chr(10)||
                     '  loop'||chr(13)||chr(10)||
                     '     bars_metabase.add_filtertbl('||chr(13)||chr(10)||
                     '        l_arr_metafiltertbl(i).tabid,'||chr(13)||chr(10)||
                     '        l_arr_metafiltertbl(i).colid,'||chr(13)||chr(10)||
                     '        l_tabid,'||chr(13)||chr(10)||
                     '        l_arr_metafiltertbl(i).fltcode);'||chr(13)||chr(10)||
                     '  end loop;'||chr(13)||chr(10);

       if l_acc_par>0 then
         l_res:=l_res||'  '||chr(13)||chr(10)||
         '  -- восстанавливаем ссылки справочника "Параметры клиентов и счетов"'||chr(13)||chr(10)||
         '  for i in 1..l_arr_accpar.count'||chr(13)||chr(10)||
         '  loop'||chr(13)||chr(10)||
         '     l_newcolid := bars_metabase.get_colid(l_tabid, l_arr_accpar(i).colname);'||chr(13)||chr(10)||
         '     if (l_newcolid is not null) then'||chr(13)||chr(10)||
         '        insert into acc_par (tabid, colid, pr)'||chr(13)||chr(10)||
         '        values (l_tabid, l_newcolid, l_arr_accpar(i).pr);'||chr(13)||chr(10)||
         '     end if;'||chr(13)||chr(10)||
         '  end loop;'||chr(13)||chr(10);
         end if;

          if l_adm_staff_access>0 then
                l_res:=l_res||'  '||chr(13)||chr(10)||
                '  -- восстанавливаем ссылки справочника "Доп. доступ пользователей"'||chr(13)||chr(10)||
                '  for i in 1..l_arr_admstaffaccess.count'||chr(13)||chr(10)||
                '  loop'||chr(13)||chr(10)||
                '     l_newcolid := bars_metabase.get_colid(l_tabid, l_arr_admstaffaccess(i).colname);'||chr(13)||chr(10)||
                '     if (l_newcolid is not null) then'||chr(13)||chr(10)||
                '        insert into adm_staff_access (tabid, colid, sec)'||chr(13)||chr(10)||
                '        values (l_tabid, l_newcolid, l_arr_admstaffaccess(i).sec);'||chr(13)||chr(10)||
                '     end if;'||chr(13)||chr(10)||
                '  end loop;'||chr(13)||chr(10);
             end if;


       l_res:=l_res||'end;'||chr(13)||chr(10)||
                     '/'||chr(13)||chr(10)||
                     'commit;'||chr(13)||chr(10);


  return l_res;

 end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/meta_export.sql =========*** End **
 PROMPT ===================================================================================== 
 