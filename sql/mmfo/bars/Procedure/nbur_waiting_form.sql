create or replace procedure nbur_waiting_form(p_kod_filii        varchar2
                                              , p_report_date      date
                                              , p_old_file_code    varchar2
                                              , p_title_mes        varchar2) as
  c_sleep_time      constant number := 30; --����� �������� ����� ������� ��������
begin

  --��������� ���� �� ������ ������ � ������� �� ������������
  --���� ���, �� ��������� ������ ��������� � ������� ����� ���������� �������
  --���� ��, �� ����� �����, ���� ��� ���������� � �� ������ ������� �������������� �� ������
  if f_nbur_check_file_in_queue(p_file_code => p_old_file_code
                              , p_kf => p_kod_filii
                              , p_report_date => p_report_date
                               )
  then
    logger.trace(p_title_mes || ' The file ' || p_old_file_code || ' in queue. Waiting procedure and use it''s data');

    loop
      --���� ���� ���������� ������ ��������� ���������� ������
      dbms_lock.sleep(seconds => c_sleep_time);

      --������ ����� ����� � ������� ��� ���
      if f_nbur_check_file_in_queue(
                                      p_file_code => p_old_file_code
                                      , p_kf => p_kod_filii
                                      , p_report_date => p_report_date
                                    )
      then
        logger.trace(p_title_mes || ' File ' || p_old_file_code || ' in queue. Waiting more...');
      else
        logger.trace(p_title_mes || ' File ' || p_old_file_code || ' not in queue. Stop waiting and process it data');
        exit;
      end if ;
    end loop;
  else
    logger.trace(p_title_mes || ' The file ' || p_old_file_code || ' not in queue.');
  end if;
end;
/  