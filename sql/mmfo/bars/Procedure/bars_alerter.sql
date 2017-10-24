

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/BARS_ALERTER.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure BARS_ALERTER ***

  CREATE OR REPLACE PROCEDURE BARS.BARS_ALERTER (mode_ number)
IS
  pipenm VARCHAR2(64);
  sid_   INTEGER;
BEGIN
  toroot;
  if mode_=0 then
    if f_tableexists('TMP_bars_alerter')=1 then
      begin
        execute immediate 'update SEC_RECTYPE
                           set    SEC_ALARM=''Y''
                           where  SEC_RECTYPE in (select SEC_RECTYPE
                                                  from   TMP_bars_alerter)';
        commit;
      exception when OTHERS then
        rollback;
        bars_audit.error('BARS_ALERTER(0): UPDATE SEC_RECTYPE - '||sqlerrm);
      end;
--
      begin
        execute immediate 'DROP TABLE TMP_bars_alerter';
      exception when OTHERS then
        if sqlcode=-942 then
          null;
        else
          bars_audit.error('BARS_ALERTER(1): DROP TABLE TMP_bars_alerter - '||sqlerrm);
        end if;
      end;
    end if;
--
    begin
      execute immediate 'CREATE TABLE TMP_bars_alerter
                         (SEC_RECTYPE  VARCHAR2(10))';
    exception when OTHERS then
      if sqlcode=-955 then
        null;
      else
        bars_audit.error('BARS_ALERTER(2): CREATE TABLE TMP_bars_alerter - '||sqlerrm);
      end if;
    end;
--
    begin
      execute immediate 'INSERT
                         INTO   TMP_bars_alerter
                         select SEC_RECTYPE
                         FROM   SEC_RECTYPE
                         where  SEC_ALARM=''Y''';
      execute immediate 'update SEC_RECTYPE
                         set    SEC_ALARM=''N''
                         where  SEC_RECTYPE in (select SEC_RECTYPE
                                                from   TMP_bars_alerter)';
      commit;
    exception when OTHERS then
      rollback;
      bars_audit.error('BARS_ALERTER(3): INSERT INTO TMP_bars_alerter - '||sqlerrm);
    end;
  else -- mode_=1
    begin
      execute immediate 'update SEC_RECTYPE
                         set    SEC_ALARM=''Y''
                         where  SEC_RECTYPE in (select SEC_RECTYPE
                                                from   TMP_bars_alerter)';
      commit;
    exception when OTHERS then
      rollback;
      bars_audit.error('BARS_ALERTER(4): UPDATE SEC_RECTYPE - '||sqlerrm);
    end;
--
    begin
      execute immediate 'DROP TABLE TMP_bars_alerter';
    exception when OTHERS then
      if sqlcode=-942 then
        null;
      else
        bars_audit.error('BARS_ALERTER(5): DROP TABLE TMP_bars_alerter - '||sqlerrm);
      end if;
    end;
  end if;
END BARS_ALERTER;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/BARS_ALERTER.sql =========*** End 
PROMPT ===================================================================================== 
