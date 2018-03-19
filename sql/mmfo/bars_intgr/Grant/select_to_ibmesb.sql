prompt Раздаем гранты на все представления для пользователя IBMESB

begin
    for rec in (select * from user_views t)
    loop
        dbms_output.put_line('grant select on bars_intgr.'||rec.view_name||' to IBMESB'); 
		execute immediate 'grant select on '||rec.view_name||' to IBMESB';
    end loop;
end;
/