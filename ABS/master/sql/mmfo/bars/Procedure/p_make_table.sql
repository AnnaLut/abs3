

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_MAKE_TABLE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_MAKE_TABLE ***

  CREATE OR REPLACE PROCEDURE BARS.P_MAKE_TABLE (
  p_mode    number,
  p_tabname varchar2,
  p_sql     varchar2,
  p_synonym varchar2,
  p_role    varchar2,
  p_grant   varchar2,
  p_policy  varchar2)
is
  l_txt varchar2(2000);
  l_tmp varchar2(30);
  l_par varchar2(30);
  ern   number;
  err   EXCEPTION;
begin
  -- проверка по справочнику допустимых таблиц для импорта
  begin
    select tabname into l_tmp
    from dbf_imp_tabs
    where upper(tabname)=upper(p_tabname);
  exception when no_data_found then
    -- в справочнике допустимых таблиц для импорта таблица не обнаружена
    ern := 1;
    l_par := p_tabname;
    raise err;
  end;

  if    p_mode = 1 then
    l_txt := 'create table';
  elsif p_mode = 2 then
    l_txt := 'insert into';
  elsif p_mode = 3 then
    l_txt := 'update';
  elsif p_mode = 4 then
    l_txt := 'delete from';
  elsif p_mode = 5 then
    if (p_tabname is not null) then
      begin
        select table_name into l_tmp
        from user_tables
        where table_name = upper(p_tabname);

        execute immediate 'drop table ' || p_tabname;
        delete from policy_table where table_name = upper(p_tabname);
      exception
        when NO_DATA_FOUND then null;
      end;
    end if;

    if (p_synonym is not null) then
      begin
        select synonym_name into l_tmp
        from all_synonyms
        where synonym_name = upper(p_synonym) and table_owner = 'BARS';

        execute immediate 'drop public synonym ' || p_synonym;
      exception
        when NO_DATA_FOUND then null;
      end;
    end if;

    if (p_role is not null) then
      begin
        select role into l_tmp
        from dba_roles
        where role = upper(p_role);

        execute immediate 'drop role ' || p_role;
      exception
        when NO_DATA_FOUND then null;
      end;
    end if;

    if (p_policy is not null) then
      delete from policy_table where table_name = upper(p_policy);
    end if;
  else
    -- недопустимый параметр MODE
    ern := 2;
    l_par := to_char(p_mode);
    raise err;
  end if;

  if (l_txt is not null)  then
    -- добавляем в POLICY_TABLE
    if (p_mode = 1 and p_policy is not null) then
      execute immediate 'insert into policy_table ' || p_policy;
    end if;

    bars_audit.info('p_make_table stmt: '||l_txt || ' ' || p_tabname || ' ' || p_sql);
    -- Выполняем действие
    execute immediate l_txt || ' ' || p_tabname || ' ' || p_sql;

    if (p_mode = 1) then
      if (p_synonym is not null) then
        execute immediate 'create public synonym ' || p_synonym;
      end if;
      if (p_role is not null) then
        execute immediate 'create role ' || p_role;
        execute immediate 'grant select, insert, update, delete on ' ||
          p_tabname || ' to '  || p_role;
      end if;
      if (p_grant is not null) then
        execute immediate 'grant ' || p_grant;
      end if;
    end if;
  end if;
exception when err then
  bars_error.raise_error('IMP', ern, l_par);
end p_make_table; 
 
/
show err;

PROMPT *** Create  grants  P_MAKE_TABLE ***
grant EXECUTE                                                                on P_MAKE_TABLE    to ABS_ADMIN;
grant EXECUTE                                                                on P_MAKE_TABLE    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_MAKE_TABLE    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_MAKE_TABLE.sql =========*** End 
PROMPT ===================================================================================== 
