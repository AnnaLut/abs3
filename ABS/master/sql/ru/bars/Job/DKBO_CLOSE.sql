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
                                                                FOR c IN ( WITH TT as  (select av.object_id
                                                                                      from  bars.attribute_number_value av                                                                                         
                                                                                               join bars.accounts  a on  a.acc = av.value
                                                                                                        and a.nbs = ''2625''
                                                                                                        AND a.tip LIKE ''W4%''
                                                                                                        and a.dazs is null
                                                                                              where av.attribute_id in(select ak.id from bars.attribute_kind ak where ak.attribute_code = ''DKBO_ACC_LIST'')           
                                                                                    )                              
                                                      SELECT d.customer_id from bars.deal d
                                                                          JOIN bars.customer c ON c.rnk  = d.customer_id
                                                                           where not exists (select null from tt y where d.id = y.object_id)
                                                                           and d.close_date is null
                                                                           AND d.deal_type_id in(select tt.id from bars.object_type tt where tt.type_code = ''DKBO'')
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
