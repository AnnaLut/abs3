

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FORMSTRU.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FORMSTRU ***

  CREATE OR REPLACE PROCEDURE BARS.P_FORMSTRU (
  p_kodf          in varchar2,
  p_view_tabname  in varchar2,
  p_stru_tabname  in varchar2,
  p_user_tabname out varchar2 )
is
  refcur SYS_REFCURSOR;
  l_view_tabid number;
  l_tabid   number;
  l_tabname varchar2(30);
  l_tabsem  varchar2(254);
  l_colid   number;
  l_colname varchar2(30);
  l_columns varchar2(2000);
  l_natr    number;
  l_name    varchar2(254);
  l_val     varchar2(254);
begin

  if getglobaloption('HAVETOBO') = 2 then
     -- полный доступ
     execute immediate 'begin bc.set_policy_group(''WHOLE''); end;';
  end if;

  l_tabname := upper(p_view_tabname || '_' || to_char(user_id));
  -- описание таблицы tmp_nbu_user/rnbu_trace_user в Ѕћƒ
  l_tabid := bars_metabase.get_tabid(l_tabname);
  if l_tabid is null then

     -- берем все из описани€ rnbu_trace
     l_view_tabid := bars_metabase.get_tabid(p_view_tabname);
     if l_view_tabid is not null then
        select semantic into l_tabsem from meta_tables where tabid = l_view_tabid;
     else
        l_tabsem := p_view_tabname;
     end if;

     -- таблица
     l_tabid := bars_metabase.get_newtabid;
     bars_metabase.add_table (
        p_tabid       => l_tabid,
        p_tabname     => l_tabname,
        p_tabsemantic => l_tabsem );

     -- колонки
     for z in ( select * from meta_columns where tabid = l_view_tabid )
     loop
        bars_metabase.add_column (
           p_tabid          => l_tabid,
           p_colid          => z.colid,
           p_colname        => z.colname,
           p_coltype        => z.coltype,
           p_semantic       => z.semantic,
           p_showwidth      => z.showwidth,
           p_showmaxchar    => z.showmaxchar,
           p_showpos        => z.showpos,
           p_showin_ro      => z.showin_ro,
           p_showretval     => z.showretval,
           p_instnssemantic => z.instnssemantic,
           p_extrnval       => z.extrnval,
           p_showrel_ctype  => z.showrel_ctype,
           p_showformat     => z.showformat,
           p_showin_fltr    => z.showin_fltr );
     end loop;

  end if;

  for z in ( select colid from meta_columns where tabid = l_tabid and colname like 'COL_P%' )
  loop
     bars_metabase.delete_column (l_tabid, z.colid);
  end loop;

  select max(colid) into l_colid from meta_columns where tabid = l_tabid;

  l_columns := null;
  open refcur for
     'select natr, name, val
        from ' || p_stru_tabname || '
       where kodf = ''' || p_kodf ||'''
       order by code_sort';
  loop
     fetch refcur into l_natr, l_name, l_val;
     exit when refcur%notfound;

     l_colid   := l_colid + 1;
     l_colname := 'COL_P'||to_char(l_natr);
     l_name    := replace(l_name, '''', '`');
     l_name    := replace(l_name, '"', '`');
     l_columns := l_columns || l_val || ' ' || l_colname || ', ';

     bars_metabase.add_column (
        p_tabid          => l_tabid,
        p_colid          => l_colid,
        p_colname        => l_colname,
        p_coltype        => 'C',
        p_semantic       => p_kodf || '-' || l_name,
        p_showwidth      => 1.2,
        p_showmaxchar    => 254,
        p_showpos        => l_colid,
        p_showin_ro      => 0,
        p_showretval     => 0,
        p_instnssemantic => 0,
        p_extrnval       => 0,
        p_showrel_ctype  => null,
        p_showformat     => null,
        p_showin_fltr    => 1 );

  end loop;

  -- view
  execute immediate 'create or replace view ' || l_tabname || ' as
     select ' || l_columns || ' ' || p_view_tabname || '.* from ' || p_view_tabname;
  -- public synonym
  begin
     execute immediate 'create or replace public synonym ' || l_tabname || ' for ' || l_tabname;
  exception when others then null;
  end;
  -- grant
  execute immediate 'grant select on ' || l_tabname || ' to rpbn002';

  p_user_tabname := l_tabname;

  if getglobaloption('HAVETOBO') = 2 then
     -- вернутьс€ в свою область видимости
     execute immediate 'begin bc.set_context(); end;';
  end if;

  commit;

exception when others then
  rollback;
  if getglobaloption('HAVETOBO') = 2 then
     -- вернутьс€ в свою область видимости
     execute immediate 'begin bc.set_context(); end;';
  end if;
  raise_application_error(-20000, dbms_utility.format_error_stack());
end p_formstru;
/
show err;

PROMPT *** Create  grants  P_FORMSTRU ***
grant EXECUTE                                                                on P_FORMSTRU      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FORMSTRU      to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FORMSTRU.sql =========*** End **
PROMPT ===================================================================================== 
