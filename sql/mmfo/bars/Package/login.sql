
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/login.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.LOGIN 
is
    g_header_version constant varchar2(64)  := '1.0.0.0'; -- 2014.10.22

    -------------------------------------------------------------------
    -- header_version - возвращает версию заголовка пакета
    --
    function header_version return varchar2;

     ------------------------------------------------------------------
     -- body_version - возвращает версию тела пакета
     --
    function body_version return varchar2;

    --------------------------------------------------------------------
    --set_user_session - процедура инициализации пользовательской сессии
    --
    procedure set_user_session(
                p_userid     in  number,
                p_sessionid  in  varchar2 );
    --------------------------------------------------------------------
	--login_user - процедура инициализации пользовательской сессии
    procedure login_user(
                  p_sessionid 			in  varchar2,
                  p_login_name    		in  varchar2,
                  p_authentication_mode in  varchar2,
                  p_hostname   			in  varchar2,
                  p_appname    			in  varchar2 );
end login;
/
CREATE OR REPLACE PACKAGE BODY BARS.LOGIN 
is
     g_body_version constant varchar2(64)  := '1.0.0.0'; -- 2014.10.22
     ------------------------------------------------------------------
     -- header_version - возвращает версию заголовка пакета
     --
     function header_version return varchar2 is
     begin
       return g_header_version;
     end header_version;

     --------------------------------------------------------------------------------
     -- body_version - возвращает версию тела пакета
     --
     function body_version return varchar2 is
     begin
       return g_body_version;
     end body_version;

    --------------------------------------------------------------------
    --set_user_session - процедура инициализации пользовательской сессии
    --
    procedure set_user_session(
                p_userid     in  number,
                p_sessionid  in  varchar2 ) is
    begin
        bars_login.set_user_session(p_sessionid);
    end set_user_session;

	--login_user - процедура инициализации пользовательской сессии
    procedure login_user(
                p_sessionid 			in  varchar2,
                p_login_name    		in  varchar2,
                p_authentication_mode 	in  varchar2,
                p_hostname   			in  varchar2,
                p_appname    			in  varchar2 ) is
		l_user_id number;
	begin
		begin
			select id into l_user_id from staff$base where logname = p_login_name;
			exception when no_data_found then
				raise_application_error(-20000, 'User ' || p_login_name || ' not found.');
		end;
		bars_login.login_user(p_sessionid, l_user_id, p_hostname, p_appname);
	end login_user;

end login;
/
 show err;
 
PROMPT *** Create  grants  LOGIN ***
grant EXECUTE                                                                on LOGIN           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on LOGIN           to SYSTEM;
grant EXECUTE                                                                on LOGIN           to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/login.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 