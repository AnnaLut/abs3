declare
    l_cursor sys_refcursor;
    l_date   date := gl.bd;
    l_list   number_list;
    l_limit  number := 1000;
begin
    -- получить дату последнего расчет
    l_date := trunc(l_date, 'month') - 1;
    dbms_output.put_line(l_date);
    for k in (select * from bars.mv_kf) loop
        bars.bc.go(k.kf);
        open l_cursor for
            select i.account_id
              from int_reckonings i
                  ,int_accn ia 
             where i.date_through = l_date
               and i.state_id = interest_utl.RECKONING_STATE_ONLY_INFO
               and i.interest_kind_id = 1
               and i.account_id = ia.acc
               and ia.id = 1
               and ia.acr_dat < i.date_through
               and i.date_from < i.date_through;
        loop   
             fetch l_cursor bulk collect into l_list limit l_limit;
             exit when l_list.count() = 0;
             forall k in 1 .. l_list.count
                 update int_accn t
                    set t.acr_dat = l_date
                       ,t.s = 0
                  where t.acc = l_list(k)
                    and t.id = 1;
        end loop;    
        commit;
        close l_cursor;
    end loop;
    bars.bc.go('/');
exception
    when others then
      if l_cursor%isOpen then
        close l_cursor;
      end if;
      raise;
end;
/
