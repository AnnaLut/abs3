
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_dev.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_DEV 
is

    -------------------------------------------------------
    -- CHECK_PRIVELEGE()
    --
    --
    --
    --
    --
    --
    procedure check_privilege(
                  p_objtype    in  varchar2,
                  p_objowner   in  varchar2,
                  p_objname    in  varchar2,
                  p_privopt    in  boolean,
                  p_privlist   in  ora_name_list_t,
                  p_userlist   in  ora_name_list_t );


    --------------------------------------------------------
    -- CHECK_INDEX()
    --
    --
    --
    --
    function check_index(
                  p_indexname  in  varchar2 ) return number;


    --------------------------------------------------------
    -- CHECK_CONSTRAINT()
    --
    --
    --
    --
    function check_constraint(
                  p_consname  in  varchar2  ) return number;


    --------------------------------------------------------
    -- CHECK_TABLE()
    --
    --
    --
    --
    procedure check_table(
                  p_tabname  in  varchar2  );


    --------------------------------------------------------
    -- CHECK_INDEX()
    --
    --
    --
    --
    procedure check_index(
                  p_indexname  in  varchar2 );

    --------------------------------------------------------
    -- GET_TABLE_ALIAS()
    --
    --
    --
    --
    function get_table_alias(
                  p_tabname  in  varchar2  ) return varchar2;

end bars_dev;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_DEV 
is

    -----------------------------------------------------------------
    -- Constants
    --
    --
    --

    VALIDATE_ERROR  constant number := -20997;








    function get_error_message(
                 p_errornum  in   number,
                 p_par01     in   varchar2 default null,
                 p_par02     in   varchar2 default null,
                 p_par03     in   varchar2 default null ) return varchar2
    is

    l_message  varchar2(1024);  /* текст сообщения об ошибке */

    begin

        case (p_errornum)
            when (901) then
                l_message := l_message || 'Запрещено выдавать привилегии с опцией ADMIN/GRANT (привилегия: %s1 пользователь/роль: %s2)';
            when (902) then
                l_message := l_message || 'Запрещено выдавать ANY-привилегии (привилегия: %s1 пользователь/роль: %s2)';
            when (903) then
                l_message := l_message || 'Запрещено выдавать пользователю системные привилегии (привилегия: %s1 пользователь/роль: %s2)';
            when (904) then
                l_message := l_message || 'Запрещено выдавать пользователю объектные привилегии (привилегия: %s1 пользователь/роль: %s2)';

            when (910) then
                l_message := 'Столбец %s2 таблицы %s1 типа NUMBER объявлен без указания размерности. Необходимо уточнить размерность (пример NUMBER(9,4) или NUMBER(38))';
            when (911) then
                l_message := 'Таблицы %s1 должна располагаться в табличных пространствам BRS% (указано: %s2)';
            when (912) then
                l_message := 'Параметры хранения таблицы %s1 не совпадают с параметрами табличного пространства (табличное пространство: %s2)';
            when (913) then
                l_message := null;
            when (914) then
                l_message := 'Неверное именование огр. целостности для таблицы %s1 (получено: %s2 ожидалось: %s3)';
            when (915) then
                l_message := 'Неверное именование индекса для таблицы %s1 (получено: %s2 ожидалось: %s3)';
        else null;
        end case;


        l_message := '\' || lpad(to_char(p_errornum), 4, '0') || ' ' || l_message;

        l_message := replace(l_message, '%s1', p_par01);
        l_message := replace(l_message, '%s2', p_par02);
        l_message := replace(l_message, '%s3', p_par03);

        return l_message;

    end get_error_message;







    procedure check_privilege(
                  p_objtype    in  varchar2,
                  p_objowner   in  varchar2,
                  p_objname    in  varchar2,
                  p_privopt    in  boolean,
                  p_privlist   in  ora_name_list_t,
                  p_userlist   in  ora_name_list_t )
    is

    l_userName  staff$base.logname%type;    /* Имя пользователя */
    l_roleName  roles$base.role_name%type;  /*         Имя роли */

    l_userFlag  number := 0;                /* Признак наличия пользователя комплекса */
    l_roleFlag  number := 0;                /*         Признак наличия роли комплекса */

    begin

        -- Проверяем есть ли среди получателей привилегии
        -- пользователь или роль комплекса
        for i in 1..p_userlist.count
        loop

            -- Проверяем входит ли в список ролей
            select count(*) into l_roleFlag
              from roles$base
             where role_name = p_userlist(i);

            if (l_roleFlag = 1) then
                l_roleName:= p_userlist(i);
                exit;
            end if;

            -- Проверяем вхождение в список пользователей
            select count(*) into l_userFlag
              from staff$base
             where logname = p_userlist(i);

            if (l_userFlag = 1) then
                l_userName := p_userlist(i);
                exit;
            end if;

        end loop;

        if (l_userFlag = 0 and l_roleFlag = 0) then
            return;
        end if;

        -- Если дается системная привилегия, то опция ADMIN | GRANT
        -- должна отсутствовать (исключение CREATE SESSION)
        if (p_objtype = 'SYSTEM PRIVILEGE') then

            if (p_privopt) then

                for i in 1..p_privlist.count
                loop
                    if (p_privlist(i) != 'CREATE SESSION') then
                        raise_application_error(-20997, get_error_message(901, p_privlist(i), nvl(l_userName, l_roleName)));
                    end if;
                end loop;

            end if;

            -- Проверка выдачи всех привилегий типа ANY
            for i in 1..p_privlist.count
            loop

                if (p_privlist(i) like '% ANY %') then
                        raise_application_error(-20997, get_error_message(902, p_privlist(i), nvl(l_userName, l_roleName)));
                end if;

            end loop;

            -- Пользователю можно выдавать только CREATE SESSION
            if (l_userFlag = 1 and l_userName != 'BARS') then

                for i in 1..p_privlist.count
                loop
                    if (p_privlist(i) != 'CREATE SESSION') then
                        raise_application_error(-20997, get_error_message(903, p_privlist(i), l_userName));
                    end if;
                end loop;

            end if;

        elsif (p_objtype = 'OBJECT PRIVILEGE' and l_userName != 'BARS' and l_userName is not null) then

            raise_application_error(-20997, get_error_message(904, p_privlist(1) || ' ' || p_objowner || '.' || p_objname, l_userName));

        end if;

    end check_privilege;



    --------------------------------------------------------
    -- GET_TABLE_ALIAS()
    --
    --
    --
    --
    function get_table_alias(
                  p_tabname  in  varchar2  ) return varchar2
    is

    l_tabalias   varchar2(30);    /*  Псевдоним таблицы */

    begin

        select table_alias into l_tabalias
          from table_alias
         where table_name = p_tabname;

        return replace(l_tabalias, '_', '');

    exception
        when NO_DATA_FOUND then return replace(p_tabname, '_', '');
    end get_table_alias;



    --------------------------------------------------------
    -- GET_COLUMN_ALIAS()
    --
    --
    --
    --
    function get_column_alias(
                  p_tabname  in  varchar2,
                  p_colname  in  varchar2 ) return varchar2
    is

    l_colalias   varchar2(30);    /*  Псевдоним столбца */

    begin

        select column_alias into l_colalias
          from table_col_alias
         where table_name  = p_tabname
           and column_name = p_colname;

        return replace(l_colalias, '_', '');

    exception
        when NO_DATA_FOUND then return replace(p_colname, '_', '');
    end get_column_alias;


    function check_number(
                 p_num   in  varchar2 ) return number
    is

    l_dummy  number;

    begin

        l_dummy := to_number(p_num);
        return 1;

    exception
        when OTHERS then return 0;
    end check_number;


    --------------------------------------------------------
    -- CHECK_INDEX()
    --
    --
    --
    --
    function check_index(
                  p_indexname  in  varchar2  ) return number
    is

    l_result    number := 0;    /*           Результат */
    l_tabname   varchar2(30);   /* Имя таблицы индекса */
    l_pos       number;         /* Позиция символа _ */
    l_tabalias  varchar2(30);

    begin

        --
        -- Получаем имя таблицы данного индекса
        --
        begin
            select table_name into l_tabname
              from user_indexes
             where index_name = p_indexname;
        exception
            when NO_DATA_FOUND then
                --raise_application_error(-20999, 'error - index '|| p_indexname || ' not found');
                return null;
        end;

        --
        -- 1. Имя индекс может совпадать с именем огр. целостности
        --    для первичного ключа (P), уникального ключа (U) и
        --    ссылочного ограничения целостности
        --
        begin

            select 1 into l_result
              from user_constraints
             where constraint_name = p_indexname
               and constraint_type in ('P', 'U', 'R');

            return l_result;

        exception
            when NO_DATA_FOUND then null;
        end;

        --
        -- 2. Имя индекса In[n]_TABALIAS
        --
        --

        l_tabalias := get_table_alias(l_tabname);

        l_pos := instr(p_indexname, '_');

        -- Нет символа подчеркивания
        if (l_pos is null or l_pos not in (2, 3, 4)) then
           l_result := -1;
        end if;

        -- Неверно указано число
        if (check_number(substr(p_indexname, 2, l_pos - 2)) != 1) then
            l_result := -1;
        end if;

        -- Первый символ не I
        if (substr(p_indexname, 1, 1) != 'I') then
            l_result := -1;
        end if;

        if (substr(p_indexname, l_pos+ 1) != l_tabalias) then
            l_result := -1;
        end if;

        if (l_result = -1) then
            l_result := 0;
        else
            l_result := 1;
        end if;

        return l_result;

    end check_index;

    -----------------------------------------------------------------
    -- GET_CONS_SEARCHCOND()
    --
    --
    --
    --
    --


    function get_cons_searchcond(
                 p_consname in varchar2 ) return varchar2
    is

    l_result varchar2(2000);

    begin

        for i in (select c.constraint_name, c.table_name, cc.column_name, c.search_condition
                    from user_constraints c, user_cons_columns cc
                   where c.constraint_name = p_consname
                     and c.constraint_name = cc.constraint_name
                     and c.constraint_type = 'C' )
        loop
            l_result := substr(i.search_condition, 1, 2000);
        end loop;

        return l_result;

    end get_cons_searchcond;



    --------------------------------------------------------
    -- CHECK_CONSTRAINT()
    --
    --
    --
    --
    function check_constraint(
                  p_consname  in  varchar2  ) return number
    is

    l_result    number := 0;    /*           Результат */
    l_tabname   varchar2(30);   /* Имя таблицы индекса */
    l_rtabname  varchar2(30);   /* Имя таблицы индекса */
    l_pos       number;         /* Позиция символа _ */
    l_tabalias  varchar2(30);
    l_rtabalias varchar2(30);
    l_constype  varchar2(1);    /* Тип огр. целостности */

    l_colname   varchar2(30);
    l_colalias  varchar2(30);
    l_chkCond   varchar2(2000);

    begin

        dbms_output.put_line('Check constraint ' || p_consname);

        --
        -- 1. Существование огр. целостности
        --
        begin

            select constraint_type, table_name into l_constype, l_tabname
              from user_constraints
             where constraint_name = p_consname;

        exception
            when NO_DATA_FOUND then
                --raise_application_error(-20999, 'error - constraint not found');
                return null;
        end;

        --
        -- Получаем алиас таблицы
        --
        l_tabalias := get_table_alias(l_tabname);


        dbms_output.put_line('Table alias is ' || l_tabalias);

        --
        -- Проверяем в зависимости от типа
        --
        case (l_constype)
            when ('P') then null;

                if (p_consname != 'PK_' || l_tabalias) then return 0;
                end if;

            when ('U') then null;

                if (p_consname != 'UK_' || l_tabalias) then return 0;
                end if;

            when ('R') then null;

                 select r.table_name into l_rtabname
                   from user_constraints c, user_constraints r
                  where c.constraint_name = p_consname
                    and c.r_owner = 'BARS'
                    and c.r_constraint_name = r.constraint_name;

                 l_rtabalias := get_table_alias(l_rtabname);

                 if (substr(p_consname, 1, 4+length(l_tabalias) + length(l_rtabalias)) != 'FK_' || l_tabalias || '_' || l_rtabalias) then return 0;
                 end if;

            when ('C') then null;

                dbms_output.put_line('Check constraint detected.');

                begin
                    select column_name into l_colname
                      from user_cons_columns
                     where constraint_name = p_consname;
                exception
                    when TOO_MANY_ROWS then return 1;
                end;

                l_colalias := get_column_alias(l_tabname, l_colname);

                l_chkCond := get_cons_searchcond(p_consname);

                dbms_output.put_line(':=' || l_chkCond || '=:');
                dbms_output.put_line(':=' || '"' || l_colname || '" IS NOT NULL' || '=:');

                if (rtrim(ltrim(l_chkCond)) = '"' || l_colname || '" IS NOT NULL' or
                    rtrim(ltrim(l_chkCond)) = l_colname || ' IS NOT NULL') then

                    if (p_consname != 'CC_' || l_tabalias || '_' || l_colalias || '_NN') then return 0;
                    end if;

                else

                    if (p_consname != 'CC_' || l_tabalias || '_' || l_colalias) then return 0;
                    end if;

                end if;

            when 'V' then return 1;

            else null;

        end case;

        return 1;


    end check_constraint;







    --------------------------------------------------------
    -- CHECK_CONSTRAINT()
    --
    --
    --
    --
    procedure check_constraint(
                  p_tabname   in  varchar2,
                  p_constype  in  varchar2,
                  p_consname  in  varchar2 )
    is


    l_result    number := 0;    /*           Результат */
    l_tabname   varchar2(30);   /* Имя таблицы индекса */
    l_rtabname  varchar2(30);   /* Имя таблицы индекса */
    l_pos       number;         /* Позиция символа _ */
    l_tabalias  varchar2(30);
    l_rtabalias varchar2(30);
    l_constype  varchar2(1);    /* Тип огр. целостности */

    l_colname   varchar2(30);
    l_colalias  varchar2(30);
    l_chkCond   varchar2(2000);

    l_consname  varchar2(30);

    begin

        --
        -- Получаем алиас таблицы
        --
        l_tabalias := get_table_alias(l_tabname);

        --
        -- Проверяем в зависимости от типа
        --
        case (p_constype)

            when ('P') then l_consname := 'PK_' || l_tabalias;

            when ('U') then l_consname := 'UK_' || l_tabalias;

            when ('R') then null;

                 --
                 -- Получаем имя и алиас таблицы, на которую ссылается
                 --
                 select r.table_name into l_rtabname
                   from user_constraints c, user_constraints r
                  where c.constraint_name = p_consname
                    and c.r_owner = c.owner
                    and c.r_constraint_name = r.constraint_name;

                 l_rtabalias := get_table_alias(l_rtabname);

                 l_consname := 'FK_' || l_tabalias || '_' || l_rtabalias;

            when ('C') then null;

                begin

                    --
                    -- Получаем имя столбца и его алиас
                    --

                    select column_name into l_colname
                      from user_cons_columns
                     where constraint_name = p_consname;

                    l_colalias := get_column_alias(l_tabname, l_colname);

                    --
                    -- Получаем текст огр. целостности
                    --

                    l_chkCond := get_cons_searchcond(p_consname);

                    l_consname := 'CC_' || l_tabalias || '_' || l_colalias;

                    --
                    -- Если это "not null", то добавляем в конце "_NN"
                    --

                    if (l_chkCond = '"' || l_colname || '" IS NOT NULL' or
                        l_chkCond = l_colname || ' IS NOT NULL'            ) then

                        l_consname := l_consname || '_NN';

                    end if;

                exception
                    when TOO_MANY_ROWS then null;
                end;

            when 'V' then null;

        end case;

        --
        -- Для некоторых ситуация пока нет обработчика (многостолбцовые огр. целостности)
        --
        if (l_consname is not null) then return;
        end if;


        if (p_constype = 'P') then

            if (p_consname != l_consname) then
                raise_application_error(VALIDATE_ERROR, get_error_message(914, p_tabname, p_consname, l_consname));
            end if;

        else

            --
            -- Ввиду возможного повторения сравниваем только начальну подстроку
            -- предполагая в конце возможность наличия номера
            --
            if (substr(p_consname, 1, length(l_consname)) != l_consname) then
                raise_application_error(VALIDATE_ERROR, get_error_message(914, p_tabname, p_consname, l_consname || '<n>'));
            end if;

        end if;

    end check_constraint;

    --------------------------------------------------------
    -- CHECK_INDEX()
    --
    --
    --
    --
    procedure check_index(
                  p_tabname    in  varchar2,
                  p_indexname  in  varchar2 )
    is

    l_tabname   varchar2(30);   /* Имя таблицы индекса */
    l_pos       number;         /* Позиция символа _   */
    l_tabalias  varchar2(30);   /* Алиас таблицы       */
    l_dummy     number;

    begin

        dbms_output.put_line(p_indexname);

       --
       -- Получается что триггер вызывается в Oracle ранее, чем
       -- добавляется огр. целостности

       -- select count(*) into l_dummy
       --   from user_constraints
       --  where constraint_name = p_indexname
       --    and constraint_type in ('P', 'U', 'R');

        --
        -- Если имя индекса не совпадает с именем огр. целостности
        -- то проверяем его именование
        --

        l_tabalias := get_table_alias(p_tabname);

        if (p_indexname = 'PK_' || l_tabalias) then
            dbms_output.put_line('PK!');
            return;
        end if;

        if (p_indexname like 'FK_'|| l_tabalias || '_%') then return;
            dbms_output.put_line('FK!');
        end if;


        dbms_output.put_line('I!');

--        if (l_dummy = 0) then

            --
            -- Имя индекса In[n]_TABALIAS
            --
            --

            l_pos := instr(p_indexname, '_');

            -- Нет символа подчеркивания
            if (l_pos is null or l_pos not in (2, 3, 4)) then
               raise_application_error(VALIDATE_ERROR, get_error_message(915, p_tabname, p_indexname, 'I<nn>_' || l_tabalias || ' или PK_'|| l_tabalias || ' или FK_' || l_tabalias || '_*'));
            end if;

            -- Неверно указано число
            if (check_number(substr(p_indexname, 2, l_pos - 2)) != 1) then
               raise_application_error(VALIDATE_ERROR, get_error_message(915, p_tabname, p_indexname, 'I<nn>_' || l_tabalias || ' или PK_'|| l_tabalias || ' или FK_' || l_tabalias || '_*'));
            end if;

            -- Первый символ не I
            if (substr(p_indexname, 1, 1) != 'I') then
               raise_application_error(VALIDATE_ERROR, get_error_message(915, p_tabname, p_indexname, 'I<nn>_' || l_tabalias || ' или PK_'|| l_tabalias || ' или FK_' || l_tabalias || '_*'));
            end if;

            if (substr(p_indexname, l_pos+ 1) != l_tabalias) then
               raise_application_error(VALIDATE_ERROR, get_error_message(915, p_tabname, p_indexname, 'I<nn>_' || l_tabalias || ' или PK_'|| l_tabalias || ' или FK_' || l_tabalias || '_*'));
            end if;

--        end if;

    end check_index;


    --------------------------------------------------------
    -- CHECK_TABLE()
    --
    --
    --
    --
    procedure check_table(
                  p_tabname  in  varchar2  )
    is

    l_tsname  varchar2(30);  /* Наименование табличного пространства */

    l_tabExtInit number(38);
    l_tabExtNext number(38);
    l_tsExtInit  number(38);
    l_tsExtNext  number(38);

    begin


        --
        -- 1. Проверяем наличие столбцов без размерности
        --

        for i in (select column_name, data_type, data_scale
                    from user_tab_columns
                   where table_name = p_tabname )
           loop

               if (i.data_type = 'NUMBER' and i.data_scale is null) then
                   raise_application_error(VALIDATE_ERROR, get_error_message(910, p_tabname, i.column_name));
               end if;

           end loop;

        --
        -- 2. Проверяем табличное пространство
        --

        select tablespace_name, initial_extent, next_extent
          into l_tsname, l_tabExtInit, l_tabExtNext
          from user_tables
         where table_name = p_tabname;

        if (l_tsname not like 'BRS%') then
            raise_application_error(VALIDATE_ERROR, get_error_message(911, p_tabname, l_tsname));
        end if;

        select initial_extent, next_extent
          into l_tsExtInit, l_tsExtNext
          from user_tablespaces
         where tablespace_name = l_tsname;

        if (l_tabExtInit != l_tsExtInit or l_tabExtNext != l_tsExtNext) then
            raise_application_error(VALIDATE_ERROR, get_error_message(912, p_tabname, l_tsname));
        end if;

        --
        -- 3. Проверяем корректность именования ограничений целостности
        --
        for i in (select constraint_type, constraint_name
                    from user_constraints
                   where table_name = p_tabname)
        loop
            check_constraint(p_tabname, i.constraint_type, i.constraint_name);
        end loop;

        --
        -- 4. Проверяем корректность именования индексов
        --
        for i in (select index_name
                    from user_indexes
                   where table_name = p_tabname)
        loop
            check_index(p_tabname, i.index_name);
        end loop;

    end check_table;

    --------------------------------------------------------
    -- CHECK_INDEX()
    --
    --
    --
    --
    procedure check_index(
                  p_indexname  in  varchar2 )
    is
    begin
        null;
    end check_index;


end bars_dev;
/
 show err;
 
PROMPT *** Create  grants  BARS_DEV ***
grant EXECUTE                                                                on BARS_DEV        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_dev.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 