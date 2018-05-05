prompt Пересоздаем типы r_slave_client_ebk и t_slave_client_ebk
begin
    execute immediate 'drop type bars.t_slave_client_ebk';
exception
    when others then
        if sqlcode = -4043 then null; else raise; end if;
end;
/
create or replace type r_slave_client_ebk as object ( kf varchar2(6),
                                                      rnk number(38),
                                                      gcif varchar2(30),
                                                      mastergcif varchar2(30));
/                                                      
create or replace type t_slave_client_ebk as table of r_slave_client_ebk;
/
grant execute on t_slave_client_ebk to bars_access_defrole;
grant execute on r_slave_client_ebk to bars_access_defrole;