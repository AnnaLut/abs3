begin
    dbms_scheduler.create_job(job_name            => 'SBON.STO_PAY_OFF',
                              job_type            => 'STORED_PROCEDURE',
                              job_action          => 'bars.sto_payment_utl.pay_off_order_amounts',
                              start_date          => to_date('01-01-2000 00:00:00', 'dd-mm-yyyy hh24:mi:ss'),
                              repeat_interval     => 'Freq=Daily;Interval=1',
                              end_date            => to_date(null),
                              job_class           => 'DEFAULT_JOB_CLASS',
                              enabled             => true,
                              auto_drop           => false,
                              comments            => '');
end;
/
