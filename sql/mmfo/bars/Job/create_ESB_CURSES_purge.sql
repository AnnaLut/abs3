 
BEGIN
    DBMS_SCHEDULER.create_job (
        job_name          => 'ESB_CURSES_purge',
        job_type          => 'stored_procedure',
        job_action        => 'esb_sync.purge_old_data',
        start_date        => TO_TIMESTAMP_TZ ('11-12-2018 04:00 Europe/Kiev',
                                              'dd-mm-yyyy hh24:mi tzr'),
        repeat_interval   => 'Freq=monthly;bymonthday=1',
        end_date          => NULL,
        enabled           => TRUE,
        auto_drop         => FALSE,
        comments          => 'Очистка устаревших данных в витринах курсов BARS_INTGR');
EXCEPTION
    WHEN OTHERS
    THEN
        IF SQLCODE = -27477
        THEN
            NULL;
        END IF;
END;
/