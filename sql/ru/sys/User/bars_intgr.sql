prompt user/bars_intgr.sql
prompt create a new one
-- create user bars_intgr 
declare
l_res number;
begin
    begin
        select 1 into l_res from bars.staff$base where logname = 'BARS_INTGR';
    exception
        when no_data_found then
            dbms_output.put_line('Нет пользователя staff$base - создаем');
            bars.bars_login.login_user(sys_guid, 1, null, null);
            bars.bars_useradm.create_user(p_usrfio     => 'XRM integration user (direct connection)',
                           p_usrtabn    => '',
                           p_usrtype    => 0, -- Адміністратор
                           p_usraccown  => 0,
                           p_usrbranch  => '/',
                           p_usrusearc  => 0,
                           p_usrusegtw  => 0,
                           p_usrwprof   => 'DEFAULT_PROFILE',
                           p_reclogname => 'BARS_INTGR',
                           p_recpasswd  => 'bars_intgr',
                           p_recappauth => null,
                           p_recprof    => null,
                           p_recdefrole => null,
                           p_recrsgrp   => null);
            commit;
    end;
    begin
        select 1 into l_res from dba_users where username = 'BARS_INTGR';
    exception
        when no_data_found then 
            dbms_output.put_line('Нет пользователя oracle - создаем');
            EXECUTE IMMEDIATE 'CREATE USER BARS_INTGR IDENTIFIED BY bars_intgr';
    end;
end;
/
begin 
	bars.bars_login.login_user(sys_guid, 1, null, null);
	update bars.staff$base set cschema = 'BARS_INTGR' where logname = 'BARS_INTGR';
	commit;
end;
/
prompt grants
-- Grant/Revoke role privileges 
grant bars_access_defrole to BARS_INTGR;
grant connect to BARS_INTGR;
-- Grant/Revoke system privileges 
grant create job to BARS_INTGR;
grant create procedure to BARS_INTGR;
grant create sequence to BARS_INTGR;
grant create table to BARS_INTGR;
grant create type to BARS_INTGR;
grant create view to BARS_INTGR; 
grant create table to BARS_INTGR;
grant create trigger to BARS_INTGR;
grant create materialized view to BARS_INTGR;
grant debug connect session to BARS_INTGR;
GRANT EXECUTE ON SYS.DBMS_CRYPTO TO BARS_INTGR;

grant select any table to bars_intgr with admin option;
grant unlimited tablespace to bars_intgr;

