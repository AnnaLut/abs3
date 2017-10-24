CREATE OR REPLACE package login
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



CREATE OR REPLACE package body login 
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


grant execute on LOGIN to BARS_ACCESS_DEFROLE;

grant execute on LOGIN to WR_ALL_RIGHTS;

grant execute on LOGIN to SYSTEM;