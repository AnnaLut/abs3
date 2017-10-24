prompt —брасываем устаревшим документам статус на "отклонено барсом"

begin
    for rec in (select t.id from sto_payment t where t.value_date < date'2017-10-13' and t.state = 3)
        loop
            sto_payment_utl.set_payment_state(p_payment_id => rec.id,
                                              p_state      => 2,
                                              p_comment    => 'ѕрострочена дата сплати');
        end loop;
commit;
end;
/