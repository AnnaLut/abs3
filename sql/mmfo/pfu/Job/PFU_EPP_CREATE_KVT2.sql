begin
    dbms_scheduler.create_job(job_name            => 'PFU_EPP_CREATE_KVT2',
                              job_type            => 'PLSQL_BLOCK',
                              job_action          => '
                                                       begin
                                                        -- ��������� ������� ���
                                                        pfu_service_utl.prepare_epp_kvt2_result;
                                                        --���������� ����� ��2
                                                        pfu_service_utl.prepare_epp_kvt2;
                                                        -- ����� ��������� �� ��������
                                                        pfu_service_utl.gen_epp_kvt2;
                                                        commit;
                                                       end;
                                                     ',
                              start_date          => to_timestamp_tz('11-04-2018 Europe/Kiev', 'dd-mm-yyyy tzr'),
                              repeat_interval     => 'Freq=Hourly;Interval=5',
                              end_date            => to_date(null),
                              job_class           => 'DEFAULT_JOB_CLASS',
                              enabled             => false,
                              auto_drop           => false,
                              comments            => '�������� ���� �� ���������� ��������� 2 ��� ��� �������� ����� ������� ������ �� ��� (P.S. �� ��������� ��������� 2, ������� ��������� �� ��������)');
    dbms_scheduler.disable('PFU_EPP_CREATE_KVT2');
 exception when others 
 then if sqlcode = -27477 then null; end if;
end;
/


