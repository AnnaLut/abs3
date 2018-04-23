prompt Обновление customer_extern.id (и customer_rel соответственно)
declare
g_test constant boolean := false;
l_id number;
begin
    for kf in (select kf from mv_kf)
    loop
        bc.go(kf.kf);
        for rec in (select ce.id from customer c, customer_extern ce where c.rnk = ce.id)
        loop
            select bars_sqnc.get_nextval('S_CUSTOMER') into l_id from dual;
            update customer_extern
            set id = l_id
            where id = rec.id;
            update customer_rel
            set rel_rnk = l_id
            where rel_rnk = rec.id /*and rel_intext?*/;
            dbms_output.put_line(kf.kf||': customer_extern id='||rec.id||' => '||l_id);
            if g_test then 
                dbms_output.put_line('Тестовый режим - откатываемся');
                rollback;
            else
                dbms_output.put_line('Закрепляем изменения'); 
                commit;
            end if;
        end loop;
    end loop;
    bc.home;
end;
/