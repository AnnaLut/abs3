begin
    sys.dbms_scheduler.drop_job( job_name => 'DKBO_CLOSE' );
  exception
    when OTHERS then null;
end;
/
begin
  sys.dbms_scheduler.create_job(job_name            => 'BARS.DKBO_CLOSE',
                                job_type            => 'PLSQL_BLOCK',
                                job_action          => 'begin
    for cur in (select kf from mv_kf)
    loop
      bc.go(p_branch => cur.kf);
      DECLARE
          out_deal_id NUMBER;
        BEGIN
          FOR c IN (WITH TT as (select av.object_id
                                from attribute_values avs
                                   JOIN (select  max(t.nested_table_id) keep (dense_rank last order by t.value_date) nested_table_id ,
                                                 t.object_id,
                                                 t.attribute_id
                                          from ATTRIBUTE_VALUE_BY_DATE t
                                          group by t.object_id, t.attribute_id)  av   on av.nested_table_id = avs.nested_table_id
                                                                                          AND av.attribute_id IN
                                                                     (SELECT ak.id
                                                                        FROM attribute_kind ak
                                                                       WHERE ak.attribute_code = ''DKBO_ACC_LIST'')
                                   join accounts  a on  a.acc = avs.NUMBER_VALUES 
                                                  and   a.nbs = ''2625''
                                                  AND a.tip LIKE ''W4%''
                                                  and a.dazs is null 
                               )
                    SELECT d.customer_id from deal d
                    JOIN customer c ON c.rnk  = d.customer_id
                     where not exists (select null from tt y where d.id = y.object_id)
                     and d.close_date is null                     
                     AND d.deal_type_id=101
                     )
          LOOP
            pkg_dkbo_utl.p_acc_map_to_dkbo(in_customer_id => c.customer_id
                                          ,out_deal_id    => out_deal_id);
          commit;
        END LOOP;
      END;
    end loop;
  end;',
                                start_date          => to_date('01-06-2016 00:00:00', 'dd-mm-yyyy hh24:mi:ss'),
                                repeat_interval     => 'Freq=Daily;ByHour=00;ByMinute=00;BySecond=00',
                                end_date            => to_date(null),
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => true,
                                auto_drop           => false,
                                comments            => 'Закриття договорів ДКБО');
exception
  when others then
    if sqlcode = -27477 then
      null;
    else
      raise;
    end if;
end;
/
