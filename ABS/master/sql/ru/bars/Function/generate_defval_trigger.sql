
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/generate_defval_trigger.sql =======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GENERATE_DEFVAL_TRIGGER (
                               p_tabname  in  varchar2 ) return varchar2
is

l_dummy      number;
l_tabalias   table_alias.table_alias%type;
l_stmt       varchar2(4000);

begin

    select count(*) into l_dummy
      from user_tab_columns c, policy_table p
     where p.repl_type like 'UPD%'
       and p.table_name = c.table_name
       and p.table_name = p_tabname
       and c.data_default is not null;

    if (l_dummy = 0) then return null;
    end if;

    -- get table alias
    begin
        select table_alias into l_tabalias
          from table_alias
         where table_name = p_tabname;
    exception
        when NO_DATA_FOUND then l_tabalias := p_tabname;
    end;

    l_stmt := 'create or replace trigger bars.ti$def_' || lower(l_tabalias) || chr(10);
    l_stmt := l_stmt || 'before insert on ' || lower(p_tabname)  || chr(10);
    l_stmt := l_stmt || 'for each row' || chr(10);
    l_stmt := l_stmt || 'begin' || chr(10);
    l_stmt := l_stmt || '    --';
    l_stmt := l_stmt || '    -- Умолчательные значения для материализованного представления';
    l_stmt := l_stmt || '    --';

    for c in (select column_name, data_default
                from user_tab_columns c, policy_table p
               where p.repl_type like 'UPD%'
                 and p.table_name = c.table_name
                 and p.table_name = p_tabname
                 and c.data_default is not null )
    loop

        l_stmt := l_stmt || '    if (:new.' || lower(c.column_name) || ' is null) then' || chr(10);
        l_stmt := l_stmt || '        :new.' || lower(c.column_name) || ' := ' || ltrim(rtrim(c.data_default)) || ';' || chr(10);
        l_stmt := l_stmt || '    end if;' || chr(10);
        l_stmt := l_stmt || chr(10);


    end loop;

    l_stmt := l_stmt || 'end;'  || chr(10);
    l_stmt := l_stmt || '/';

    return l_stmt;

end generate_defval_trigger;
/
 show err;
 
PROMPT *** Create  grants  GENERATE_DEFVAL_TRIGGER ***
grant EXECUTE                                                                on GENERATE_DEFVAL_TRIGGER to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/generate_defval_trigger.sql =======
 PROMPT ===================================================================================== 
 