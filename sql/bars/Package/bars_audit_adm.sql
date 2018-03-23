prompt PACKAGE BARS_AUDIT_ADM

create or replace package bars_audit_adm
is

   ------------------------------------------------------------------
   -- Константы
   --
   --
   g_headerVersion   constant varchar2(64)  := 'version 2.00 04.10.2017';
   g_headerDefs      constant varchar2(512) := '';


    -----------------------------------------------------------------
    -- CREATE_AUDIT_PARTITION()
    --
    --     Создание секции в таблице журнала аудита до указанной
    --     даты. В результате будут созданы секции для всех дат
    --     от последней созданной в таблице аудита до указанной
    --
    --
     procedure create_audit_partition(
         p_partEndDate   in  date  );
         
         
    -----------------------------------------------------------------
    -- COMPRESS_PARTITION
    --
    --     Сжатие секции в таблице журнала аудита по названию или
    --     по дате. Нельзя сжимать секцию, в которую еще может быть запись (>=sysdate).
    --     По-умолчанию пишет ошибки только в аудит
    --     
     procedure compress_partition(partname          in   varchar2, 
                                  silent_mode       in   boolean default true);
                                  
     procedure compress_partition(partition_date    in   date,
                                  silent_mode       in   boolean default true);


    -----------------------------------------------------------------
    -- SET_LOG_LEVEL()
    --
    --     Устанавливает уровень детализации протокола
    --     для указанного пользователя
    --
     procedure set_log_level(
         p_staffid       in  number,
         p_loglevel      in  varchar2 );


    --------------------------------------------------------
    -- HEADER_VERSION()
    --
    --     Функция возвращает строку с версией заголовка пакета
    --
    --
    --
    function header_version return varchar2;



    --------------------------------------------------------
    -- BODY_VERSION()
    --
    --     Функция возвращает строку с версией тела пакета
    --
    --
    --
    function body_version return varchar2;



end bars_audit_adm;
/ 
create or replace package body bars_audit_adm
is

    -----------------------------------------------------------------
    -- Константы
    --
    --
    g_bodyVersion   constant varchar2(64)   := 'version 2.00 04.10.2017';
    g_bodyDefs      constant varchar2(512)  := '';

    MODULE_PREFIX   constant varchar2(3)    := 'SEC';

    g_trace         constant varchar2(32)   := 'bars_audit_adm.';
    -----------------------------------------------------------------
    -- CREATE_AUDIT_PARTITION()
    --
    --     Создание секции в таблице журнала аудита до указанной
    --     даты. В результате будут созданы секции для всех дат
    --     от последней созданной в таблице аудита до указанной
    --
    --
     procedure create_audit_partition(
         p_partEndDate   in  date  )
     is

     l_partBeginDate  date;          /* дата последней секции таблицы */
     l_lastPartName   varchar2(30);  /*  имя последней секции таблицы */
     l_currPartDate   date;          /*   текущая дата секции таблицы */
     l_currPartName   varchar2(30);  /*    имя текущей секции таблицы */

     begin

         select partition_name
           into l_lastPartName
           from user_tab_partitions
          where table_name = 'SEC_AUDIT'
            and partition_position = (select max(partition_position)
                                        from user_tab_partitions
                                       where table_name = 'SEC_AUDIT');

         begin

             l_partBeginDate := to_date(substr(l_lastPartName, 2), 'yyyymmdd');

         exception
             when OTHERS then
                 bars_error.raise_error(MODULE_PREFIX, 702);
         end;

         -- Проверяем разницу между датами
         if (p_partEndDate - l_partBeginDate > 300) then
             bars_error.raise_error(MODULE_PREFIX, 703);
         end if;

         l_currPartDate := l_partBeginDate + 2;

         while (l_currPartDate <= trunc(p_partEndDate))
         loop

             -- Получаем имя секции
             l_currPartName := 'P' || to_char(l_currPartDate-1, 'yyyymmdd');

             -- Создаем секцию
             execute immediate 'alter table sec_audit add partition ' || l_currPartName ||
                               ' values less than (to_date(''' || to_char(l_currPartDate, 'ddmmyyyy') || ''', ''ddmmyyyy''))';

             -- увеличиваем счетчик
             l_currPartDate := l_currPartDate + 1;

         end loop;

     end create_audit_partition;

    -----------------------------------------------------------------
    -- COMPRESS_PARTITION_FORCE
    --     Внутренняя процедура, без проверок
    --     Сжатие секции в таблице журнала аудита по названию.
    --  
    procedure compress_partition_force(partname           in   varchar2,
                                       silent_mode        in   boolean)
    is
    type t_policy is table of policy_table%rowtype;
    
    l_trace varchar2(128) := g_trace||'compress_partition_force: ';
    
    l_policy t_policy;
    begin
        bars_audit.info(g_trace || 'START для секции '||partname);
        
        begin
            execute immediate 'drop table TMP_SEC_AUDIT_COMPRESSED';
        exception
            when others then
                if sqlcode = -942 then null; else raise; end if;
        end;
        
        execute immediate 'create table tmp_sec_audit_compressed compress tablespace BRSAUDITD as select * from sec_audit partition ('||partname||')';
        
        dbms_stats.gather_table_stats (ownname => 'BARS', 
                                       tabname => 'TMP_SEC_AUDIT_COMPRESSED', 
                                       degree => 32, 
                                       estimate_percent => 100);
        
        select * bulk collect into l_policy 
        from policy_table 
        where table_name = 'SEC_AUDIT';

        bpa.remove_policies(p_table_name => 'SEC_AUDIT');

        begin
            execute immediate 'alter table sec_audit exchange partition '||partname||' with table tmp_sec_audit_compressed';
        exception
            when others then
                -- восстанавливаем политики
                for idx in l_policy.first..l_policy.last
                    loop
                        bpa.alter_policy_info('SEC_AUDIT', 
                                              l_policy(idx).POLICY_GROUP, 
                                              l_policy(idx).SELECT_POLICY, 
                                              l_policy(idx).INSERT_POLICY, 
                                              l_policy(idx).UPDATE_POLICY, 
                                              l_policy(idx).DELETE_POLICY);
                    end loop;
                bpa.alter_policies('SEC_AUDIT');
                bars_audit.error(l_trace || 'Ошибка обмена секциями: ' || sqlerrm);
                if (not silent_mode) then
                    raise_application_error(-20000, 'Ошибка обмена секциями: '||sqlerrm);
                end if;
                return;
        end;
        for idx in l_policy.first..l_policy.last
            loop
                bpa.alter_policy_info('SEC_AUDIT', 
                                      l_policy(idx).POLICY_GROUP, 
                                      l_policy(idx).SELECT_POLICY, 
                                      l_policy(idx).INSERT_POLICY, 
                                      l_policy(idx).UPDATE_POLICY, 
                                      l_policy(idx).DELETE_POLICY);
            end loop;
        bpa.alter_policies('SEC_AUDIT');
        bars_audit.info(l_trace || 'секция ' || partname ||' сжата. END.');

    end compress_partition_force;

    -----------------------------------------------------------------
    -- COMPRESS_PARTITION
    --     
    --     Сжатие секции в таблице журнала аудита по названию.
    --     Нельзя сжимать секции, в которые еще может быть запись (>=sysdate)
    --
    procedure compress_partition(partname in   varchar2, silent_mode boolean default true)
    is
    l_trace varchar2(128) := g_trace||'compress_partition by name: ';
    l_partdate date;
    l_partname varchar2(32);
    begin
        bars_audit.info(l_trace || 'START для секции '||partname);
        begin
            WITH DATA AS (
            select table_name,
                   partition_name,
                   to_date (
                      trim (
                      '''' from regexp_substr (
                                 extractvalue (
                                   dbms_xmlgen.getxmltype (
                                   'select high_value from all_tab_partitions where table_name='''
                                            || table_name
                                            || ''' and table_owner = '''
                                            || table_owner
                                            || ''' and partition_name = '''
                                            || partition_name
                                            || ''''),
                                         '//text()'),
                                      '''.*?''')),
                      'syyyy-mm-dd hh24:mi:ss')
                      high_value_in_date_format
              FROM all_tab_partitions
             WHERE table_name = 'SEC_AUDIT' AND table_owner = 'BARS'
             )
            SELECT partition_name, high_value_in_date_format INTO l_partname, l_partdate FROM DATA
            WHERE partition_name = upper(partname);
        exception
            when no_data_found then
                bars_audit.error(l_trace || 'Секции не существует');
                if (not silent_mode) then
                    raise_application_error(-20000, 'Секции не существует');
                end if;
                return;
        end;
        if l_partdate >= trunc(sysdate) then
            bars_audit.error(l_trace || 'Секция недоступна для сжатия');
            if (not silent_mode) then
                raise_application_error(-20000, 'Секция недоступна для сжатия');
            end if;
            return;
        end if;
        compress_partition_force(partname, silent_mode);
    end;

    -----------------------------------------------------------------
    -- COMPRESS_PARTITION
    --     
    --     Сжатие секции в таблице журнала аудита по дате.
    --     Нельзя сжимать секции, в которые еще может быть запись (>=sysdate)
    --    
    procedure compress_partition(partition_date     in   date,
                                 silent_mode        in   boolean default true)
    is
    l_trace varchar2(128) := g_trace||'compress_partition by date: ';
    l_partname varchar2(32);
    begin
        bars_audit.info(l_trace || 'START для секции за дату '||to_char(partition_date, 'dd.mm.yyyy'));
        
        if partition_date >= trunc(sysdate) then
            -- Если в эту секцию еще будет запись
            bars_audit.error(g_trace || l_trace || 'Секция недоступна для сжатия');
            if (not silent_mode) then
                raise_application_error(-20000, 'Секция недоступна для сжатия');
            end if;
            return;
        end if;
        
        begin
            WITH DATA AS (
            select table_name,
                   partition_name,
                   to_date (
                      trim (
                      '''' from regexp_substr (
                                 extractvalue (
                                   dbms_xmlgen.getxmltype (
                                   'select high_value from all_tab_partitions where table_name='''
                                            || table_name
                                            || ''' and table_owner = '''
                                            || table_owner
                                            || ''' and partition_name = '''
                                            || partition_name
                                            || ''''),
                                         '//text()'),
                                      '''.*?''')),
                      'syyyy-mm-dd hh24:mi:ss')
                      high_value_in_date_format
              FROM all_tab_partitions
             WHERE table_name = 'SEC_AUDIT' AND table_owner = 'BARS'
             )
            SELECT partition_name INTO l_partname FROM DATA
            WHERE trunc(partition_date) >= high_value_in_date_format -1
            AND trunc(partition_date) < high_value_in_date_format;
        
        exception
            when no_data_found then
                bars_audit.error(l_trace || 'Секции не существует');
                if (not silent_mode) then
                    raise_application_error(-20000, 'Секции не существует');
                end if;
                return;
        end;
        
        compress_partition_force(partname    => l_partname,
                                 silent_mode => silent_mode);
    end;    


    -----------------------------------------------------------------
    -- SET_LOG_LEVEL()
    --
    --     Устанавливает уровень детализации протокола
    --     для указанного пользователя
    --
     procedure set_log_level(
         p_staffid       in  number,
         p_loglevel      in  varchar2 )
     is
     begin

         update sec_useraudit
            set log_level  = p_logLevel
          where staff_id = p_staffid;

         if (sql%rowcount = 0) then

             insert into sec_useraudit (staff_id, log_level)
             values (p_staffid, p_loglevel);

         end if;

     end set_log_level;


    -----------------------------------------------------------------
    -- HEADER_VERSION()
    --
    --     Функция возвращает строку с версией заголовка пакета
    --
    --
    --
    function header_version return varchar2
    is
    begin
        return 'package header BARS_AUDIT_ADM ' || g_headerVersion || chr(10) ||
               'package header definition(s):' || chr(10) || g_headerDefs;
    end header_version;



    -----------------------------------------------------------------
    -- BODY_VERSION()
    --
    --     Функция возвращает строку с версией тела пакета
    --
    --
    --
    function body_version return varchar2
    is
    begin
        return 'package body BARS_AUDIT_ADM ' || g_bodyVersion || chr(10) ||
               'package body definition(s):' || chr(10) || g_bodyDefs;
    end body_version;


end bars_audit_adm;
/
Show errors;

PROMPT *** Create  grants  BARS_AUDIT_ADM ***
grant EXECUTE                                                                on BARS_AUDIT_ADM  to ABS_ADMIN;
grant EXECUTE                                                                on BARS_AUDIT_ADM  to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_AUDIT_ADM  to WR_ALL_RIGHTS;

