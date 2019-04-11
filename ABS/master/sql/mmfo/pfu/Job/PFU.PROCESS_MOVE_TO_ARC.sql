 

DECLARE
    l_job_name   VARCHAR2 (100) DEFAULT 'PFU.PROCESS_MOVE_TO_ARC';
    l_aciton     VARCHAR2 (2000) 
        DEFAULT q'{
    DECLARE
    l_firstdaymont   DATE;
BEGIN
    SELECT MIN (dat)
    INTO   l_firstdaymont
    FROM   (SELECT     TRUNC (SYSDATE, 'month') + LEVEL - 1 AS dat
            FROM       DUAL
            CONNECT BY LEVEL <= 31)
    WHERE  dat NOT IN (SELECT holiday
                       FROM   bars.holiday
                       WHERE  kv = 980);

    IF TRUNC (SYSDATE) <> l_firstdaymont
    THEN
        RETURN;
    END IF;

    pfu.pfu_files_utl.move_to_arc_matchsend_job;
END;}';

BEGIN
    DBMS_SCHEDULER.create_job (
        job_name          => l_job_name,
        job_type          => 'plsql_block',
        job_action        => l_aciton,
        start_date        => TO_TIMESTAMP_TZ ('06-12-2018 06:00 Europe/Kiev',
                                              'dd-mm-yyyy hh24:mi tzr'),
        repeat_interval   => 'Freq=daily;interval=1',
        end_date          => NULL,
        enabled           => TRUE,
        auto_drop         => FALSE,
        comments          => 'Перенос в архив подвтвержденных файлов ПФУ');
EXCEPTION
    WHEN OTHERS
    THEN
        IF SQLCODE = -27477
        THEN
            NULL;
        END IF;
END;
/
 
