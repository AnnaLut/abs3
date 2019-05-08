
begin
  sys.dbms_scheduler.create_job(job_name        => 'BARS.JOB_BPK_DATEOFKK',
                                job_type            => 'STORED_PROCEDURE',
                                job_action          => 'BARS.bpk_credits.set_accw_DATEOFKK',
                                start_date          => to_date('07-05-2019 05:00:00', 'dd-mm-yyyy hh24:mi:ss'),
                                repeat_interval     => 'Freq=DAILY',
                                end_date            => to_date(null),
                                job_class           => 'DEFAULT_JOB_CLASS',
                                enabled             => true,
                                auto_drop           => false,
                                comments            => '���������� ��������� DATEOFKK �� ������������ �������� ���');
end;
/
