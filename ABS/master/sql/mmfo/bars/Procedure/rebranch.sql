create or replace procedure rebranch
( p_oldbranch in branch.branch%type
, p_newbranch in branch.branch%type
) is
  ----------------------------------------------------------------------------
  --
  -- REBRANCH - выполняет миграцию данных из старого бранча в новый
  --
  -- version 1.12    26.10.2017
  --
  --
  -- ВАЖНО! Предполагается, что оба бранча уже заведены в таблице BRANCH 
  --
  -- ВАЖНО! Выполнять миграцию можно только в нерабочее время, т.к. блокируется большое кол-во таблиц 
  --
  -- ВАЖНО! SEC_AUDIT не трогаем! 
  --
  ----------------------------------------------------------------------------
  -- маска формата для преобразования char <--> number
  g_number_format     constant varchar2(128) := 'FM999999999999999999999999999990.0999999999999999999999999999999';
  -- маска формата для преобразования char <--> number
  g_integer_format    constant varchar2(128) := 'FM999999999999999999999999999990';
  -- параметры преобразования char <--> number
  g_number_nlsparam   constant varchar2(30)  := 'NLS_NUMERIC_CHARACTERS = ''. ''';
  -- маска формата для преобразования char <--> date
  g_date_format       constant varchar2(30)  := 'DD.MM.YYYY HH24:MI:SS';
  -- максимальный размер строки, которую может прочесть SQL*Plus 
  g_max_line_size 	  constant number := 2450;
  --
  l_script          clob;
  l_table           varchar2(30);
  l_refsync         varchar2(30);
  l_temp            varchar2(32767);
  l_temp2           varchar2(32767);
  l_stmt            varchar2(32767);
  l_table_fields    varchar2(32767);
  l_pk_fields       varchar2(32767);
  l_cursor          integer;
  l_d               integer;
  l_rectab          dbms_sql.desc_tab3;
  l_colcnt          number;
  l_prefix          varchar2(32767);
  l_suffix          varchar2(32767);
  --                
  l_number          number;
  l_date            date;
  l_varchar2        varchar2(32767);
  l_len			        number;
  l_total_len	      number;
  --
  l_oldbranch_info  branch%rowtype;
  l_newbranch_info  branch%rowtype;
  l_newbranch_inuse boolean;
  --
  l_tablist         dbms_utility.uncl_array;
  
  -- таблиці з форенкей на поле бранч
  type t_tablist_fk is table of user_constraints%rowtype index by binary_integer;
  l_tablist_fk      t_tablist_fk;
  
  l_columnlist      dbms_utility.uncl_array;
  l_msglist         dbms_utility.lname_array;
  --
  is_cons_deferred  boolean := false;
  l_tablen          binary_integer;
  l_rows_updated    number;
  l_start_time      date;
  l_finish_time     date;
  l_delta_time      number;
  l_num             number;

  ----
  -- pre_job - выполняет предварительную работу
  -- (отключение триггеров, констрейнтов и перевод проверки констрейнтов в отложенный режим)
  --
  procedure PRE_JOB
  is
  begin
    -- фиксируем время начала ребранчинга
    l_start_time := sysdate;
    l_temp := 'Время начала: '||to_char(l_start_time, 'DD.MM.YYYY HH24:MI:SS');
    l_msglist(l_msglist.last+1) := l_temp;
    dbms_output.put_line(l_temp); dbms_output.new_line;
    
    -- -- выключаем контроль за групповым обновлением accounts
    -- l_temp := 'alter trigger tiu_acc disable';
    -- execute immediate l_temp;
    -- l_msglist(l_msglist.last+1) := l_temp;
    -- dbms_output.put_line(l_temp);
    
    -- -- выключаем контроль за групповым обновлением customer
    -- l_temp := 'alter trigger tiu_cus disable';
    -- execute immediate l_temp;
    -- l_msglist(l_msglist.last+1) := l_temp;
    -- dbms_output.put_line(l_temp);

    -- выключаем тригер TU_DPTFILEROW
    l_temp := 'alter trigger TU_DPTFILEROW disable';
    execute immediate l_temp;
    l_msglist(l_msglist.last+1) := l_temp;
    dbms_output.put_line(l_temp);

    -- отключаем контроль branch=tobo на oper, т.к. валится ORA-600
/*    l_temp := 'alter table oper disable constraint cc_oper_branch_tobo_cc';
    execute immediate l_temp;
    l_msglist(l_msglist.last+1) := l_temp;
    dbms_output.put_line(l_temp);
*/
    -- Отключаем политики на таблицы
    l_temp := 'Отключаем политики на таблицы:';
    l_msglist(l_msglist.last+1) := l_temp;
    dbms_output.put_line(l_temp);
    for i in l_tablist.first..l_tablist.last
    loop
      BPA.DISABLE_POLICIES( l_tablist(i) );
    end loop;

    -- Отключаем констреінт на таблицы  CIG  
    select c.* 
      bulk collect 
      into l_tablist_fk 
      from user_constraints c, USER_CONS_COLUMNS p 
     where c.constraint_type='R' 
       and c.constraint_name = p.constraint_name
       and P.COLUMN_NAME = 'BRANCH' 
       and r_constraint_name!='PK_BRANCH' 
       and c.table_name like 'CIG%'
     order by c.table_name;

    l_temp := 'Отключаем констреінт на таблицы: CIG';
    l_msglist(l_msglist.last+1) := l_temp;    
    dbms_output.put_line(l_temp);
    
	  IF (l_tablist_fk.COUNT > 0)
    THEN
      FOR i IN l_tablist_fk.FIRST..l_tablist_fk.LAST 
      LOOP
			  dbms_output.put(rpad(l_tablist_fk(i).constraint_name,32,'.'));
        execute immediate 'alter table '||l_tablist_fk(i).table_name||' disable constraint '||l_tablist_fk(i).constraint_name||' ';
			  dbms_output.put('disable'); dbms_output.new_line;   	
      END LOOP;
    END IF;
    
    -- переводим проверку констрейнтов в отложенный режим
    execute immediate 'alter session set constraints=deferred';
    is_cons_deferred := true;
    l_temp := 'Ограничения целостности переведены в режим отложенной проверки';
    l_msglist(l_msglist.last+1) := l_temp;
    dbms_output.put_line(l_temp); dbms_output.new_line;
    
    -- входим внутрь МФО
    bc.subst_mfo(bc.extract_mfo(p_oldbranch));
    --
  end pre_job;

  function get_elapsed_time
  ( p_delta_time  in   number
  ) return varchar
  is
    l_elapsed  varchar2(100);
  begin
    l_elapsed := trunc(mod(p_delta_time * 24, 24)) ||' год, ' ||
                 trunc(mod(p_delta_time * 24 * 60, 60)) ||' хв, ' ||
                 round(mod(p_delta_time * 24 * 60 * 60, 60)) || ' с';
    return l_elapsed;
  end get_elapsed_time;

---
-- 
--
---
procedure p_upd_table
is
  t_list number_list;
begin
  
  -- для таблиць із захистом від групового оновлення (ACCOUNTS та CUSTOMER) зміну бранча виконуємо в циклі
  
  l_stmt := 'update ACCOUNTS set BRANCH='''||p_newbranch||''', TOBO='''||p_newbranch||''' where BRANCH ='''||p_oldbranch||'''';
  dbms_application_info.set_client_info(l_stmt);
  l_msglist(l_msglist.last+1) := l_stmt;
  dbms_output.put_line(l_stmt);
  
  select ACC
    bulk collect
    into t_list
    from ACCOUNTS
   where branch = p_oldbranch;
   
  forall r in 1 .. t_list.count
  update ACCOUNTS
     set BRANCH = p_newbranch,
         TOBO   = p_newbranch
   where ACC    = t_list(r);
  
  l_temp := 'begin bars_ow.add_deal_to_cmque(:nd, :opertype) end;';
  dbms_application_info.set_client_info(l_temp);
  l_msglist(l_msglist.last+1) := l_temp;
  dbms_output.put_line(l_temp);

  -- для карткових рахунків потрібно відправити заявку в СМ на зміну клієнських данних 
  for c_cm in (select w.nd, decode(c.custtype, 3, 3, 8) opertype
                 from w4_acc w
                 join table(t_list) t
                   on w.acc_pk = value(t)
                 join accounts a on w.acc_pk = a.acc
                 join customer c
                   on a.rnk = c.rnk)
  loop
    begin
      bars_ow.add_deal_to_cmque(p_nd       => c_cm.nd,
                                p_opertype => c_cm.opertype);
    exception
      when others then
        l_temp := 'По договору ' || c_cm.nd ||
                  ' ошибка при формировании заявки в CM: ' || sqlerrm;
        l_msglist(l_msglist.last + 1) := l_temp;
    end;
  end loop;
  l_temp := '-- модифицировано '||t_list.count||' строк, Elapsed: ' || get_elapsed_time(sysdate - l_start_time);
  l_msglist(l_msglist.last+1) := l_temp;
  dbms_output.put_line(l_temp);
  
  ------------------------------
  
  l_stmt := 'update CUSTOMER set BRANCH='''||p_newbranch||''', TOBO='''||p_newbranch||''' where BRANCH ='''||p_oldbranch||'''';
  dbms_application_info.set_client_info(l_stmt);
  l_msglist(l_msglist.last+1) := l_stmt;
  dbms_output.put_line(l_stmt);
  
  select RNK
    bulk collect
    into t_list
    from CUSTOMER
   where branch = p_oldbranch;
   
  forall r in 1 .. t_list.count
  update CUSTOMER
     set BRANCH = p_newbranch,
         TOBO   = p_newbranch
   where RNK    = t_list(r);
  
  l_temp := '-- модифицировано '||t_list.count||' строк, Elapsed: ' || get_elapsed_time(sysdate - l_start_time);
  l_msglist(l_msglist.last+1) := l_temp;
  dbms_output.put_line(l_temp);
  
end p_upd_table;

----
-- post_job - выполняет работу после завершения ребранчинга
-- включаем все триггера, ограничения целостности переводим  врежим немедленной проверки 
-- и т.п.
--
procedure POST_JOB
is
begin
    -- восстанавливаем контекст
    bc.set_context;
    --
    if is_cons_deferred
    then -- переводим ограничения целостности в режим немедленной проверки
      execute immediate 'alter session set constraints=immediate';
      is_cons_deferred := false;
      l_temp := 'Ограничения целостности переведены в режим немедленной проверки';
      l_msglist(l_msglist.last+1) := l_temp;
      dbms_output.put_line(l_temp); dbms_output.new_line;
    end if;        
    
    -- -- включаем контроль за групповым обновлением accounts
    -- l_temp := 'alter trigger tiu_acc enable';
    -- execute immediate l_temp;
    -- l_msglist(l_msglist.last+1) := l_temp;
    -- dbms_output.put_line(l_temp);
    
    -- -- включаем контроль за групповым обновлением customer
    -- l_temp := 'alter trigger tiu_cus enable';
    -- execute immediate l_temp;
    -- l_msglist(l_msglist.last+1) := l_temp;
    -- dbms_output.put_line(l_temp);
    
    -- включаем тригер TU_DPTFILEROW
    l_temp := 'alter trigger TU_DPTFILEROW enable';
    execute immediate l_temp;
    l_msglist(l_msglist.last+1) := l_temp;
    dbms_output.put_line(l_temp);
    
    -- включаем контроль branch=tobo на oper
/*    l_temp := 'alter table oper enable constraint cc_oper_branch_tobo_cc';
    execute immediate l_temp;
    l_msglist(l_msglist.last+1) := l_temp;
    dbms_output.put_line(l_temp);
*/    
    -- Включаем политики на таблицы    
    l_temp := 'Включаем политики на таблицы:';
    l_msglist(l_msglist.last+1) := l_temp;    
    dbms_output.put_line(l_temp);
    for i in l_tablist.first..l_tablist.last 
    loop        
        bpa.enable_policies(l_tablist(i));                
    end loop;
	  l_temp := 'Политики включены';
    l_msglist(l_msglist.last+1) := l_temp;    
    dbms_output.put_line(l_temp);
	  
	  -- Включаем констреінт на таблицы  CIG  
    l_temp := 'Вмикаємо констреінти на таблиці: CIG_';
    l_msglist(l_msglist.last+1) := l_temp;    
    dbms_output.put_line(l_temp);
    
    IF (l_tablist_fk.COUNT > 0)
    THEN
      FOR i IN l_tablist_fk.FIRST..l_tablist_fk.LAST 
      LOOP
			  dbms_output.put(rpad(l_tablist_fk(i).constraint_name,32,'.'));
        EXECUTE immediate 'alter table '||l_tablist_fk(i).table_name||' enable constraint '||l_tablist_fk(i).constraint_name||' ';
			  dbms_output.put('enable'); dbms_output.new_line;   	
      END LOOP;
    END IF;
    
    -- фиксируем время завершения ребранчинга
    l_finish_time := sysdate;
    l_temp := 'Время завершения: '||to_char(l_finish_time, 'DD.MM.YYYY HH24:MI:SS');
    l_msglist(l_msglist.last+1) := l_temp;
    dbms_output.put_line(l_temp); dbms_output.new_line;
    -- пишем в протокол затраченное время
    l_delta_time := l_finish_time - l_start_time;
    l_temp := 'Затрачено: ' || get_elapsed_time(l_delta_time);
    l_msglist(l_msglist.last+1) := l_temp;
    dbms_output.put_line(l_temp); dbms_output.new_line;
    
    -- вывод в журнал аудита
    for i in l_msglist.first..l_msglist.last
    loop
        bars_audit.info(l_msglist(i));
    end loop;
    --
    dbms_application_info.set_client_info('');
    
end post_job;

----
-- check_global_name - проверка глобального имени базы в таблице DDBS
--                     с исправлением при необходимости
--
procedure check_global_name
is
	l_globalname	global_name.global_name%type;
	l_ddbname		ddbs.ddb_name%type;
begin
	
  l_temp := 'Проверка значения GLOBAL_NAME и DDB_NAME:';
  l_msglist(l_msglist.last+1) := l_temp;
  dbms_output.put_line(l_temp); dbms_output.new_line;    
	--
	select global_name
	  into l_globalname
	  from global_name;
    --
    l_temp := 'GLOBAL_NAME = '||l_globalname;
    l_msglist(l_msglist.last+1) := l_temp;
    dbms_output.put_line(l_temp); dbms_output.new_line;
	--
	begin
		select ddb_name
      into l_ddbname
		  from ddbs
		 where ddb_id = 1;
		--
	  l_temp := 'DDB_NAME = '||l_ddbname;
    l_msglist(l_msglist.last+1) := l_temp;
	  dbms_output.put_line(l_temp); dbms_output.new_line;
		--
		if l_ddbname<>l_globalname
		then
			update ddbs
			   set ddb_name = l_globalname
			 where ddb_id = 1;
			--
			l_temp := 'Изменено значение DDB_NAME = '||l_globalname;
    		l_msglist(l_msglist.last+1) := l_temp;
		    dbms_output.put_line(l_temp); dbms_output.new_line;
			--
		end if;
		--
	exception 
		when NO_DATA_FOUND then
			insert into ddbs
        ( ddb_id, ddb_name, branch )
			values
        ( 1, l_globalname, null );
			--
	    l_temp := 'Создана запись с DDB_NAME = '||l_globalname;
	    l_msglist(l_msglist.last+1) := l_temp;
		  dbms_output.put_line(l_temp); dbms_output.new_line;
	end;
	--
	commit;
	--
end check_global_name;

begin
    l_temp := 'Начало ребранчинга: '||p_oldbranch||' --> '||p_newbranch;
    l_msglist(1) := l_temp;
    dbms_output.put_line(l_temp); dbms_output.new_line;    
	  
    -- проверка 
	  check_global_name();
    
    -- проверки: существуют ли указанные бранчи    
    begin
      select * into l_oldbranch_info 
        from branch
       where branch=p_oldbranch;
    exception 
      when no_data_found then
        raise_application_error(-20000, 'Бранч '||p_oldbranch||' не найден', true);
    end;
    
    begin
      select * into l_newbranch_info 
        from branch 
       where branch=p_newbranch;  
    exception
      when no_data_found then
        raise_application_error(-20000, 'Бранч '||p_newbranch||' не найден', true);
    end;
    
    l_temp := 'OLD: '||l_oldbranch_info.branch||'  '||l_oldbranch_info.name;
    l_msglist(l_msglist.last+1) := l_temp;
    dbms_output.put_line(l_temp);
    
    l_temp := 'NEW: '||l_newbranch_info.branch||'  '||l_newbranch_info.name;
    l_msglist(l_msglist.last+1) := l_temp;
    dbms_output.put_line(l_temp); dbms_output.new_line;
    
    -- бранчи должны принадлежать одному МФО
    if bc.extract_mfo(p_oldbranch)<>bc.extract_mfo(p_newbranch) 
    then
      raise_application_error(-20000, 'Бранчи не принадлежат одному МФО!', true);
    end if;
    
    -- По наличию записей в BRANCH_PARAMETERS определяем: новый бранч рабочий или нет
    begin
      select 1
        into l_num
        from BRANCH_PARAMETERS
       where BRANCH = p_newbranch
         and rownum = 1;
      l_newbranch_inuse := true;
      l_temp := 'Новый бранч '||p_newbranch||' уже используется.';
      l_msglist(l_msglist.last+1) := l_temp;
      dbms_output.put_line(l_temp); dbms_output.new_line;
      l_temp := 'Данные некоторых таблиц переноситься не будут во избежание задвоения.';
      l_msglist(l_msglist.last+1) := l_temp;
      dbms_output.put_line(l_temp); dbms_output.new_line;
    exception
      when no_data_found then
        l_newbranch_inuse := false;
    end;
    -- найдем список имен таблиц, ссылающихся по внешним ключам на BRANCH.BRANCH
    -- из списка исключаем:
    -- STAFF$BASE      - блокировать ее нельзя, т.к. на нее внешним ключем ссылается SEC_AUDIT
    -- ACCOUNTS        - для СХОВИЩА Ощадбанку необхідно зберігати інформацію про зміну бранчу в ACCOUNTS_UPDATE
    -- ACCOUNTS_UPDATE - для СХОВИЩА Ощадбанку необхідно зберігати ВСЮ ОРИГІНАЛЬНУ історію змін парамерів рахунку
    -- CUSTOMER        - для СХОВИЩА Ощадбанку необхідно зберігати інформацію про зміну бранчу в CUSTOMER_UPDATE
    -- CUSTOMER_UPDATE - для СХОВИЩА Ощадбанку необхідно зберігати ВСЮ ОРИГІНАЛЬНУ історію змін парамерів клієнта
    -- CC_DEAL_UPDATE, DPT_DEPOSIT_CLOS, DPU_DEAL_UPDATE - для СХОВИЩА Ощадбанку необхідно зберігати ВСЮ історію змін парамерів договору
    if l_newbranch_inuse 
    then
      -- если новый бранч уже используется, исключаем ряд таблиц из ребранчинга
      select unique table_name 
        bulk collect 
        into l_tablist 
        from user_constraints 
       where constraint_type='R' 
         and r_constraint_name='PK_BRANCH' 
         and table_name not in ( 'SEC_AUDIT', 'STAFF$BASE', 'OPER', 'ASVO_DPTCONSACC',
                                 'ACCOUNTS', 'ACCOUNTS_UPDATE', 'CUSTOMER', 'CUSTOMER_UPDATE',
                                 'CC_DEAL_UPDATE','DPT_DEPOSIT_CLOS','DPU_DEAL_UPDATE',
                                 'DPT_FILE_SUBST','DPT_FILE_AGENCY','DPT_FILE_ROW','DPT_FILE_HEADER',
                                 'DPT_FILE_ROW_ACCUM', 'DPT_POAS', 'DPT_POA_BRANCHES',
                                 'CUR_RATES$BASE', 'BRANCH_PARAMETERS', 'BRANCH_ATTRIBUTE_VALUE', 'PROC_DR$BASE', 'KAS_S'
                               , 'WCS_SUBPRODUCT_MACS', 'WCS_USER_RESPOSIBILITY'
                               , 'CASH_BRANCH_LIMIT', 'CASH_OPEN', 'CASH_SNAPSHOT' )
       order by table_name;
    else
      select unique table_name 
        bulk collect 
        into l_tablist 
        from user_constraints 
       where constraint_type='R' 
         and r_constraint_name='PK_BRANCH'
         and table_name not in ( 'SEC_AUDIT', 'STAFF$BASE', 'OPER', 'ASVO_DPTCONSACC',
                                 'ACCOUNTS', 'ACCOUNTS_UPDATE', 'CUSTOMER', 'CUSTOMER_UPDATE',
                                 'CC_DEAL_UPDATE','DPT_DEPOSIT_CLOS','DPU_DEAL_UPDATE',
                                 'DPT_FILE_SUBST' )
       order by table_name;
    end if;

    -- выполняем предварительную работу
    -- (отключение триггеров, констрейнтов и перевод проверки констрейнтов в отложенный режим)
    pre_job();
    
    -- блокируем все таблицы    
    l_temp := 'Блокируем таблицы в эксклюзивном режиме:';
    l_msglist(l_msglist.last+1) := l_temp;    
    dbms_output.put_line(l_temp);
    for i in l_tablist.first..l_tablist.last
    loop
        dbms_output.put(rpad(l_tablist(i),32,'.'));
        execute immediate 'lock table '||l_tablist(i)||' in exclusive mode nowait';
        dbms_output.put('locked'); dbms_output.new_line;        
    end loop;    
    dbms_utility.table_to_comma(l_tablist, l_tablen, l_temp);
    dbms_output.new_line;    
    l_msglist(l_msglist.last+1) := l_temp;
    -- теперь добавляем STAFF$BASE в конец списка, чтобы перевести пользователей в новый бранч
    l_tablist(l_tablist.last+1) := 'STAFF$BASE';
    --
    l_temp := 'Модифицируем поля таблиц:';
    l_msglist(l_msglist.last+1) := l_temp;    
    dbms_output.put_line(l_temp);
    
    -- идем по таблицам и модифицируем поля, содержащие старый бранч
    for i in l_tablist.first..l_tablist.last 
    loop
      -- получаем список полей, ссылающихся на бранч
      select c.column_name 
       bulk collect 
       into l_columnlist 
       from user_constraints s, 
            user_cons_columns c  
      where s.constraint_type='R' 
        and s.r_constraint_name='PK_BRANCH'
        and s.constraint_name=c.constraint_name 
        and s.table_name=l_tablist(i);
      
      -- формируем sql-выражение для каждого поля отдельно                
      for j in 1..l_columnlist.count
      loop
        l_stmt := 'update '||l_tablist(i)||' set '||l_columnlist(j)||'='''||p_newbranch||''' '
                ||'where '||l_columnlist(j)||'='''||p_oldbranch||'''';
        dbms_application_info.set_client_info(l_stmt);
        l_msglist(l_msglist.last+1) := l_stmt;
        dbms_output.put_line(l_stmt);
        execute immediate l_stmt;
        l_rows_updated := sql%rowcount;
        l_temp := '-- модифицировано '||l_rows_updated||' строк';
        l_msglist(l_msglist.last+1) := l_temp;
        dbms_output.put_line(l_temp);
      end loop;
      
    end loop;
    
    -- окремо виконуємо ребранчінг табл. по яких необхідно зберігати історію змін (для DWH)
    p_upd_table;
    
    -- восстанавливаем контекст
    bc.set_context;
    
    -- закрываем старый бранч
    update branch 
       set date_closed = glb_bankdate
     where branch = p_oldbranch;
    
    l_temp := 'Старый бранч('||p_oldbranch||') закрыт';
    l_msglist(l_msglist.last+1) := l_temp;
    dbms_output.put_line(l_temp); dbms_output.new_line;        
    -- вроди все    
    commit;
    -- сигналим, что все прошло хорошо
    l_temp := 'Успешное завершение ребранчинга: '||p_oldbranch||' --> '||p_newbranch;
    l_msglist(l_msglist.last+1) := l_temp;
    dbms_output.put_line(l_temp); dbms_output.new_line;
    -- включаем все триггера, ограничения целостности переводим  врежим немедленной проверки 
    -- и т.п.
    post_job();
    --
exception 
  when others then
    rollback;    
    dbms_output.new_line;
    -- Сообщаем об ошибке
    l_temp2 := 'Ошибка при ребранчинге: '||SQLERRM||chr(10)||dbms_utility.format_error_backtrace();
    bars_audit.error(l_temp2);
    -- включаем все триггера, ограничения целостности переводим  врежим немедленной проверки 
    -- и т.п.
    post_job();    
    -- выбрасываем ошибку на суд запускавшего процедуру
    raise_application_error(-20000, l_temp2, true);
    --
end rebranch;
/

show error
