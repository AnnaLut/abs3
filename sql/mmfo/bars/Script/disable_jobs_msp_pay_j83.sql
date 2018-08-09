BEGIN
  SYS.DBMS_SCHEDULER.disable('BARS.MSP_PAY');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.disable('BARS.J83');
END;
/

BEGIN
  SYS.DBMS_SCHEDULER.DROP_JOB
    (job_name  => 'BARS.TRANSFER_FORECAST_NEW');
exception when others then
if sqlcode = -27475 then null; else raise; end if;
END;
/