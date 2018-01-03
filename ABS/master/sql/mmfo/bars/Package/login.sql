CREATE OR REPLACE PACKAGE "LOGIN" is

  --------------------------------------------------------------------------------
  --  LOGIN - пакет обслуживает логин пользователя
  --------------------------------------------------------------------------------

  g_header_version  constant varchar2(64)  := 'version 1.11 10/09/2014';
  g_awk_header_defs constant varchar2(512) := '';

  --------------------------------------------------------------------------------
  --
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2;

  --------------------------------------------------------------------------------

  --
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2;

  -- Получения отдела пользователя для присвоения в контекст
  function get_user_otdel(p_user_id core_users.user_id%type, p_branch varchar2) return number;

  --ф-ція, яка поверене USER_ID - ди користувачів, які передавали даному користувачу права
  function get_parent_dlg_userid(p_user_id core_users.user_id%type) return varchar2;

  -----------------------------------------------------------------
  -- смена текущего бранча
  --
  --
  procedure subst_branch(
    p_branch in core_branches.branch%type
  );

  -----------------------------------------------------------------
  -- возврат контекста в нормальное состояние
  --
  --
  procedure reset_branch;




  -----------------------------------------------------------------
  -- процедура входа пользователя в комплекс
  --
  --
  procedure login_user(
    p_username   in  varchar2,
    p_sessionid  in  varchar2,
    p_hostname   in  varchar2,
    p_userid    out  number  );


  -----------------------------------------------------------------
  -- процедура входа пользователя в комплекс (перезагрузка)
  --
  --
  procedure login_user(
    p_username   in  ora_aspnet_users.username%type,
    p_userid    out  core_users.user_id%type  ) ;

  -----------------------------------------------------------------
  -- процедура входа пользователя в комплекс по идентификатору ключа
  --
  --
  procedure login_user(
    p_key_id   in  core_users.key_id%type,
    p_userid    out  core_users.user_id%type  );


  -----------------------------------------------------------------
  -- процедура выхода пользователя из комплекса
  --
  procedure logout_user(p_sessionid  in  varchar2 );

  -----------------------------------------------------------------
  -- процедура инициализации пользовательской сессии
  --
  --
  procedure set_user_session(
                p_userid     in  number,
                p_sessionid  in  varchar2 );

  -----------------------------------------------------------------
  -- очистка данных для истекших сессий
  --
  procedure clear_expired_session(p_force_userid in varchar2 default null);

  -----------------------------------------------------------------
  -- процедура установки в контекст произвольной переменной
  --
  --
  procedure set_user_var (p_var_name in varchar2, p_var_value in varchar2);

  -----------------------------------------------------------------
  -- процедура получения из контекста произвольной переменной
  --
  --
  function get_user_var (p_var_name in varchar2) return varchar2;

  -----------------------------------------------------------------
  -- установка доступа текущему пользователю
  --
  --
  procedure change_user_access(
    p_accces_type_id in core_user_access.access_type_id%type
  );

  -----------------------------------------------------------------
  -- очистка контекста всех пользователей
  --
  --
  procedure clear_all_context;

  procedure clear_context (p_client_id in varchar2);

  end login;

 
 

 
/
CREATE OR REPLACE PACKAGE BODY "LOGIN" is

  --------------------------------------------------------------------------------
  --
  --  LOGIN - пакет обслуживает логин пользователя
  --
  --------------------------------------------------------------------------------


  --------------
  -- constants
  --

  g_body_version  constant varchar2(64)  := 'version 1.11 10/09/2014';
  g_awk_body_defs constant varchar2(512) := '';
  g_trace_pfx constant varchar2(12) := 'login.';
  g_modcode constant varchar2(7) := 'EAR';

  CLIID_PREFIX        constant varchar2(12)  := 'BARSAPP-';
  CLIID_PREFIX_LEN    constant number       := 12;
  GLOBAL_CTX          constant varchar2(30) := 'core_global_ctx';
  CTXPAR_USERID       constant varchar2(30) := 'user_id';
  CTXPAR_CUSTID       constant varchar2(30) := 'cust_id';
  CTXPAR_USERNAME     constant varchar2(30) := 'user_name';
  CTXPAR_USER_BRANCH  constant varchar2(30) := 'user_branch';
  CTXPAR_HOSTNAME     constant varchar2(30) := 'host_name';
  CTXPAR_USERACCESS   constant varchar2(30) := 'user_access';
  CTXPAR_APPNAME      constant varchar2(30) := 'app_name';
  CTXPAR_LASTCALL     constant varchar2(30) := 'last_call';
  CTXPAR_NLSMASK      constant varchar2(30) := 'nlsmask';
  CTXPAR_OTDEL        constant varchar2(30) := 'otdel';
  CTXPAR_USERID_DLG   constant varchar2(30) := 'userid_dlg';
  CTXPFX_TEMP         constant varchar2(5) := 'temp_';
  MAX_SESSION_TIMEOUT constant number       := 60;  -- в минутах

  --------------------------------------------------------------------------------
  -- header_version - возвращает версию заголовка пакета
  --
  function header_version return varchar2 is
  begin
    return 'Package header LOGIN '||g_header_version||'.'||chr(10)
       ||'AWK definition: '||chr(10)
       ||g_awk_header_defs;
  end header_version;

  --------------------------------------------------------------------------------
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2 is
  begin
    return 'Package body LOGIN '||g_body_version||'.'||chr(10)
       ||'AWK definition: '||chr(10)
       ||g_awk_body_defs;
  end body_version;


  function get_host_name return varchar2 is
  begin
    return sys_context('USERENV','HOST');
  end;

  -----------------------------------------------------------------
  -- функция получения клиентского идентификатора
  --
  --
  function get_current_clientid return varchar2 is
  begin
    return sys_context('userenv', 'client_identifier');
  end;


  -----------------------------------------------------------------
  -- функция получения клиентского идент. по пользователю и сессии
  --
  --
  function get_user_clientid(
                p_sessionid in  varchar2 ) return varchar2
  is
  begin
      return CLIID_PREFIX || p_sessionid;
  end get_user_clientid;

  -----------------------------------------------------------------
  -- процедура установки клиентского идентификатора
  --
  procedure set_user_clientid(
                p_clientid  in  varchar2 )
  is
  begin
      if (p_clientid is not null) then
          sys.dbms_session.set_identifier(p_clientid);
      end if;
  end set_user_clientid;

  -----------------------------------------------------------------
  -- процедура регистрации сессии в таблице активных сессий
  --
  procedure add_user_session(
                p_clientid   in  varchar2,
                p_userid     in  number,
                p_proxyuser  in  varchar2 )
  is pragma autonomous_transaction;
  begin
      insert into user_login_sessions(client_id, user_id, proxy_user)
      values (p_clientid, p_userid, p_proxyuser);
      commit;
  exception
      when DUP_VAL_ON_INDEX then
          raise_application_error(-20999, 'Duplicate session registration');
  end add_user_session;

  -----------------------------------------------------------------
  -- процедура удаление сессии из списка активных сессий
  --
  procedure drop_user_session(
                p_clientid   in  varchar2 )
  is pragma autonomous_transaction;
  begin
    delete from user_login_sessions
      where client_id = p_clientid;
    commit;
  end drop_user_session;

  -----------------------------------------------------------------
  -- процедура выхода пользователя из комплекса
  --
  procedure logout_user(
                p_sessionid  in  varchar2 )
  is
    l_clientid     varchar2(64);    -- клиентский идентификатор
    l_th varchar2(128) := g_trace_pfx||'logout_user';
  begin
   -- PROC_CONTEXT_AUDIT('LOGOUT', p_sessionid);
    logger.trace('%s: entry point', l_th );

    -- Получаем клиент. идентификатор
    if (p_sessionid is null) then
        logger.trace('%s: p_sessionid is null', l_th );
        l_clientid := sys_context('userenv', 'client_identifier');
    else
        logger.trace('%s: p_sessionid is not null', l_th );
        l_clientid := get_user_clientid(p_sessionid);
    end if;
    logger.trace('%s: l_clientid = %s', l_th, to_char(l_clientid) );

    -- Очищаем контекст сессии пользователя
    sys.dbms_session.clear_context(GLOBAL_CTX, client_id=> l_clientid);
    PKG_CONTEXT.clear_context(l_clientid);
    logger.trace('%s: context cleared', l_th);

    -- Удаляем сессию из таблицы активных сессий
    drop_user_session(l_clientid);
    logger.trace('%s: user session dropped', l_th);

    logger.trace('%s: done', l_th );
  end logout_user;

  -----------------------------------------------------------------
  -- процедура инициализации пользовательской сессии
  --
  --
  procedure set_user_session(
                p_userid     in  number,
                p_sessionid  in  varchar2 )
  is
    l_userid       number;          -- ид. пользователя
    l_host         varchar2(256);
    l_clientid     varchar2(64);    -- клиентский идентификатор
    l_errm         varchar2(128);
    l_th varchar2(128) := g_trace_pfx||'set_user_session';
  begin
    logger.trace('%s: entry point', l_th );

    -- Получаем клиент. идентификатор
    l_clientid := get_user_clientid(p_sessionid);
    logger.trace('%s: l_clientid=%s', l_th, to_char(l_clientid) );

    -- Устанавливаем кл. идентификатор
    set_user_clientid(l_clientid);
    logger.trace('%s: clientid is set', l_th);

    -- Если польз. сессия проходила через login_user
    l_userid := sys_context(GLOBAL_CTX, CTXPAR_USERID);
    logger.trace('%s: l_userid=%s', l_th, to_char(l_userid));

    l_host := sys_context(GLOBAL_CTX, CTXPAR_HOSTNAME);
    logger.trace('%s: l_host=%s', l_th, l_host);

/*    if l_host != get_host_name() then
      logger.security('Attempt to set session id created by another user '||get_host_name||' => '||l_host);
      raise_application_error(-20000, 'Attempt to set session id created by another user '||get_host_name||' => '||l_host);
    end if;*/
    -- если нашелся параметр user_id, значит сессия наша
    if (l_userid is not null and l_userid = p_userid ) then
      logger.trace('%s: all right', l_th);
    -- иначе посылаем запрос на перелогин
    else
        l_errm := 'Empty context for client id: '||
          l_clientid||'user id:'|| to_char(l_userid) || '(' || to_char(p_userid) ||')';
        logout_user(p_sessionid);
        logger.trace('%s: logout complete', l_th);
        logger.trace('%s: error, %s', l_th, l_errm);
        -- -20111 - именно этот код ошибки ловит приложение
        raise_application_error(-20111, l_errm);
    end if;
    -- обновляем дату последнего обращения
    sys.dbms_session.set_context(GLOBAL_CTX, CTXPAR_LASTCALL, to_char(sysdate, 'dd.mm.yyyy hh24:mi:ss'), client_id=>l_clientid);

    logger.trace('%s: lastcall updated, done', l_th );
  end set_user_session;

  -----------------------------------------------------------------
  -- get_def_access = получает умолчательный доступ для пользователя
  --
  --
  function get_def_access return core_access_types.access_type_id%type
  is
    l_res core_access_types.access_type_id%type;
  begin

    -- если не выдано - выдат дефолтный тип доступа

    select access_type_id
      into l_res
      from core_access_types
     where def_flag ='Y';

    dbms_output.put_line('get_def_access - '||l_res);

   return l_res;

  exception when no_data_found then
    raise_application_error(-20000, 'Default access is not defined');
  end;

  function get_user_access(
    p_user_id in core_users.user_id%type
  ) return varchar2
  is
    l_res varchar2(256);
  begin

    begin

      -- поиск дефолтного доступа  среди выданных доступов
      select access_type_id
        into l_res
       from core_user_access
      where user_id = p_user_id
       and def_flag = 'Y';

    exception when no_data_found then
        l_res := get_def_access;
    end;

    dbms_output.put_line('get_user_access - '||l_res);

    return l_res;
  end;


-- Получения отдела пользователя для присвоения в контекст
function get_user_otdel(p_user_id core_users.user_id%type, p_branch varchar2) return number
  is
    l_otdel ea_otdel.id%type;
  begin
    begin
	 select o.otdel into l_otdel
	  from ea_otdel_users o, core_users c
		where o.pr=1
		  and o.user_id=c.ext_id
		  and c.user_id=p_user_id
		  and o.branch=p_branch;
		exception when no_data_found then l_otdel:=null;
      end;
    return l_otdel;
  end get_user_otdel;

   --ф-ція, яка поверене USER_ID - ди користувачів, які передавали даному користувачу права
  function get_parent_dlg_userid(p_user_id core_users.user_id%type) return varchar2
  is
    l_list_users varchar2(32767);
	i number :=0;
  begin
    for c in(select user_id_from from core_users_delegating
				where user_id_to = p_user_id
				and date_begin<=sysdate
				and date_end >sysdate)
	loop
       l_list_users:=l_list_users||case when i=0 then ' ' else ',' end || to_char(c.user_id_from);
	   i:=i+1;
      end loop;
    return l_list_users;
  end get_parent_dlg_userid;


  -----------------------------------------------------------------
  -- процедура входа пользователя в комплекс
  --
  --
  procedure login_user(
    p_username   in  varchar2,
    p_sessionid  in  varchar2,
    p_hostname   in  varchar2,
    p_userid    out  number  )
  is
    l_hostname     varchar2(64);    -- имя клиентского хоста
    l_sessionid    varchar2(32);    -- идент. сессии
    l_clientid     varchar2(64);    -- клиентский идентификатор
    l_proxyuser    varchar2(30);    -- имя прокси-пользователя
    l_errm         varchar2(128);
    l_branch       core_branches.branch%type;
    l_user_access  core_user_access.access_type_id%type;
	l_otdel number(38);
	l_userid_dlg varchar2(32767);
	l_th varchar2(128) := g_trace_pfx||'login_user';
  begin
    --PROC_CONTEXT_AUDIT('LOGIN_B4',p_sessionid);
    logger.trace('%s: entry point', l_th );
    if (p_sessionid is null) then
      l_errm := 'Session ID cannot be null';
      logger.trace('%s: %s', l_th, l_errm );
      raise_application_error(-20999, l_errm);
    end if;

    -- очистить сессию если она уже существует
    logout_user(p_sessionid);
    logger.trace('%s: session cleared', l_th );

    --получение параметров пользователя
    get_user_params(p_username, p_userid, l_branch);

    l_hostname  := nvl(p_hostname, get_host_name());
    l_sessionid := substr(p_sessionid, 1, 32);
    l_proxyuser := sys_context('userenv', 'proxy_user');
    logger.trace('%s: p_userid=%s,  l_hostname=%s, l_sessionid=%s, l_proxyuser=%s ', l_th,
      to_char(p_userid),  l_hostname, l_sessionid, l_proxyuser);

    -- Формируем кл. идентификатор
    l_clientid := get_user_clientid(l_sessionid);
    logger.trace('%s: l_clientid=%s', l_th, to_char(l_clientid) );

    --получение параметров доступа
    l_user_access := get_user_access(p_userid);

	l_otdel:=get_user_otdel(p_userid, l_branch);

	l_userid_dlg:=get_parent_dlg_userid(p_userid);


    -- Регистрируем сессию
    add_user_session(l_clientid, p_userid, l_proxyuser);
    logger.trace('%s: user session added', l_th );
    -- Устанавливаем значения в контекст
    sys.dbms_session.set_context(GLOBAL_CTX, CTXPAR_USERID,    to_char(p_userid), client_id=> l_clientid);
    sys.dbms_session.set_context(GLOBAL_CTX, CTXPAR_USERNAME,  p_username,        client_id=> l_clientid);
    sys.dbms_session.set_context(GLOBAL_CTX, CTXPAR_USER_BRANCH,  l_branch,        client_id=> l_clientid);
    sys.dbms_session.set_context(GLOBAL_CTX, CTXPAR_USERACCESS,  l_user_access,   client_id=> l_clientid);
    sys.dbms_session.set_context(GLOBAL_CTX, CTXPAR_HOSTNAME,  l_hostname,        client_id=> l_clientid);
	sys.dbms_session.set_context(GLOBAL_CTX, CTXPAR_OTDEL,  to_char(l_otdel),     client_id=> l_clientid);
	sys.dbms_session.set_context(GLOBAL_CTX, CTXPAR_USERID_DLG,  l_userid_dlg,     client_id=> l_clientid);

	--
    logger.trace('%s: context is set', l_th );

    -- Выполняем установку параметров в сессии
    set_user_session(p_userid, l_sessionid);

    logger.info(
      msg_mgr.get_msg(
        p_modcode => g_modcode,
        p_msgcode => 'LOGIN_USER',
        p_param1 => p_username
      )
    );
    -- информация о логине в журнал
    logger.debug('Login. '||
      ' Userid='||to_char(p_userid)||
      ', HostName='||l_hostname||
      ', SessionId='||l_sessionid);

    logger.trace('%s: done', l_th );
    --PROC_CONTEXT_AUDIT('LOGIN_E');
  end login_user;

  -----------------------------------------------------------------
  -- процедура входа пользователя в комплекс (перезагрузка)
  --
  --
  procedure login_user(
    p_username   in  ora_aspnet_users.username%type,
    p_userid    out  core_users.user_id%type  ) is
  begin
    --PROC_CONTEXT_AUDIT('LOGIN_B2name');
    login_user(
      p_username  => p_username,
      p_sessionid => 'session_'||p_username,
      p_hostname  => get_host_name(),
      p_userid    => p_userid
    );
  end;

  -----------------------------------------------------------------
  -- процедура входа пользователя в комплекс по идентификатору ключа
  --
  --
  procedure login_user(
    p_key_id   in  core_users.key_id%type,
    p_userid    out  core_users.user_id%type  )
  is
    l_user_name ora_aspnet_users.username%type;
  begin
    --PROC_CONTEXT_AUDIT('LOGIN_B2key');
    begin
      select loweredusername into l_user_name from v_users where key_id = p_key_id;
    exception when no_data_found then
      raise_application_error(-20000,'KEY_ID ' || p_key_id || ' not found');
    end;

    login_user(
      p_username  => l_user_name,
      p_sessionid => 'key_id_session_'||p_key_id,
      p_hostname  => get_host_name(),
      p_userid    => p_userid
    );

  end;


  -----------------------------------------------------------------
  -- очистка данных для истекших сессий
  --
  procedure clear_expired_session(p_force_userid in varchar2 default null)
  is
    l_clientid   varchar2(64);
    l_expired    boolean;
  begin

    -- Сохраняем свой кл. идентификатор
    l_clientid := substr(sys_context('userenv', 'client_identifier'), 1, 64);

    -- Проходим по всем зарегистрир. сессиям
    for c in (select client_id , proxy_user, user_id
                from user_login_sessions)
    loop

      -- Устанавливаем кл. идентификатор сессии
      set_user_clientid(c.client_id);

      -- Для сессий с прокси-аутен. смотрим дату последнего обращения
      if sys_context(GLOBAL_CTX, CTXPAR_LASTCALL) is null or
        (to_date(sys_context(GLOBAL_CTX, CTXPAR_LASTCALL), 'dd.mm.yyyy hh24:mi:ss') < sysdate - MAX_SESSION_TIMEOUT/60/24)
      then
        l_expired := true;
      else
        l_expired := false;
      end if;

      -- в случае если указан ID - насильная чистка пользователя
      if p_force_userid is not null and c.user_id = p_force_userid then
        l_expired := true;
      end if;

      -- Если сессию нужно удалять
      if (l_expired) then
          sys.dbms_session.clear_context(GLOBAL_CTX, client_id=> c.client_id);
          PKG_CONTEXT.clear_context(l_clientid);
          drop_user_session(c.client_id);
      end if;

    end loop;

    -- Восстанавливаем кл. идентификатор
    set_user_clientid(l_clientid);

  exception
    when OTHERS then
        -- Восстанавливаем кл. идентификатор
        set_user_clientid(l_clientid);
        -- Выпускаем ошибку
        raise;
  end clear_expired_session;


  -----------------------------------------------------------------
  -- процедура установки в контекст произвольной переменной
  --
  --
  procedure set_user_var (p_var_name in varchar2, p_var_value in varchar2)
  is
  begin
     -- установка контекста
    sys.dbms_session.set_context(GLOBAL_CTX, CTXPFX_TEMP || p_var_name,
      p_var_value, client_id => get_current_clientid());
  end set_user_var;

  -----------------------------------------------------------------
  -- процедура получения из контекста произвольной переменной
  --
  --
  function get_user_var (p_var_name in varchar2) return varchar2
  is
  begin
     -- получение контекста
     return sys_context(GLOBAL_CTX, CTXPFX_TEMP || p_var_name);
  end get_user_var;


  -----------------------------------------------------------------
  -- смена текущего бранча
  --
  --
  procedure subst_branch(
    p_branch in core_branches.branch%type
  ) is
  begin
    sys.dbms_session.set_context(
      namespace => GLOBAL_CTX,
      attribute => CTXPAR_USER_BRANCH,
      value     =>  p_branch
    );
  end;

  -----------------------------------------------------------------
  -- установка доступа текущему пользователю
  --
  --
  procedure change_user_access(
    p_accces_type_id in core_user_access.access_type_id%type
  ) is
    l_cnt integer;
  begin

    if p_accces_type_id != get_def_access() then

      select count(1)
        into l_cnt
        from core_user_access
       where user_id = userid
         and access_type_id = p_accces_type_id;

      if l_cnt = 0 then
        raise_application_error(-20000, 'Access denied');
      end if;

    end if;

    sys.dbms_session.set_context(
      namespace => GLOBAL_CTX,
      attribute => CTXPAR_USERACCESS,
      value     =>  p_accces_type_id,
      client_id => get_current_clientid()
    );

  end;

  -----------------------------------------------------------------
  -- возврат контекста в нормальное состояние
  --
  --
  procedure reset_branch is
    l_branch core_branches.branch%type;
    l_user_id core_users.user_id%type;
  begin

    --получение параметров пользователя
    get_user_params(
      p_username => sys_context(GLOBAL_CTX, CTXPAR_USERNAME),
      p_user_id =>  l_user_id,
      p_branch =>  l_branch);

    sys.dbms_session.set_context(
      namespace => GLOBAL_CTX,
      attribute => CTXPAR_USER_BRANCH,
      value     =>  l_branch
    );
    
  end;

  -----------------------------------------------------------------
  -- очистка контекста всех пользователей
  --
  --
  procedure clear_all_context is
  begin
    --sys_context('userenv','sessionid')
    dbms_session.clear_all_context('CORE_GLOBAL_CTX');
  end;
  
procedure clear_context (p_client_id in varchar2) is
begin
sys.dbms_session.clear_context('core_global_ctx', p_client_id);
end;  

end login;
/
