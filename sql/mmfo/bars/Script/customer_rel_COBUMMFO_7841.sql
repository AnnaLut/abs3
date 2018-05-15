prompt Удаляем ошибочно внесенные в update-таблицу записи + customer_rel

begin
    for rec in (select * from bars.mv_kf)
    loop
        bc.go(rec.kf);
        dbms_output.put_line('KF:'||rec.kf);
        update customer_rel t
        set rel_intext = 0
        where rel_intext=1 and not exists (select 1 from customer c where c.rnk = t.rel_rnk);
        dbms_output.put_line('cust_rel updated:'||sql%rowcount);
        delete
        from customer_rel_update t
        where rel_intext = 0
        and doneby = 'BARS' and chgdate>=sysdate-5
        and not exists (select 1 from customer_extern where id = t.rel_rnk);
        dbms_output.put_line('cust_rel_update custext deleted:'||sql%rowcount);
        delete 
        from customer_rel_update t
        where rel_intext = 1
        and not exists (select 1 from customer c where t.rel_rnk = c.rnk);
        dbms_output.put_line('cust_rel_update customer deleted:'||sql%rowcount);
        commit;
    end loop;
end;
/
begin
    bc.home;
end;
/




