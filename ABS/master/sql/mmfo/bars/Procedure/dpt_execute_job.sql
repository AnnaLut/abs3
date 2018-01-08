
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/DPT_EXECUTE_JOB.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure DPT_EXECUTE_JOB ***

CREATE OR REPLACE PROCEDURE DPT_EXECUTE_JOB(P_JOBCODE IN DPT_JOBS_LIST.JOB_CODE%TYPE,
                                            P_JOBMODE IN NUMBER DEFAULT NULL) IS
  -- HO - с обслуживанием вкладов в выходные и праздничные дни
  G_MODCODE    VARCHAR2(3) := 'DPT';
  TITLE        VARCHAR2(60);
  L_INITBDATE  DATE;
  L_BDATE      DATE;
  L_USERID     STAFF.ID%TYPE := GL.AUID;
  L_JOBREC     DPT_JOBS_LIST%ROWTYPE;
  L_CURKF      BANKS.MFO%TYPE;
  L_KF         BANKS.MFO%TYPE;
  L_RUNID      DPT_JOBS_JRNL.RUN_ID%TYPE;
  L_PLSQLBLOCK VARCHAR2(250);
  TYPE T_BRANCHLIST IS TABLE OF BRANCH.BRANCH%TYPE;
  L_BRANCHLIST T_BRANCHLIST;
  L_CURSOR     INTEGER;
  L_TMPNUM     INTEGER;
  EXPTNOBD EXCEPTION;
  --
  -- поиск банк.даты в данном МФО
  --
  FUNCTION GET_BANKDATE(P_MFO BANKS.MFO%TYPE) RETURN DATE IS
    L_PAR   PARAMS.PAR%TYPE := 'BANKDATE';
    L_BDATE DATE;
  BEGIN
    SELECT TO_DATE(VAL, 'MM-DD-YYYY')
      INTO L_BDATE
      FROM PARAMS$BASE
     WHERE PAR = L_PAR
       AND KF = P_MFO;
    RETURN L_BDATE;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RAISE EXPTNOBD;
  END GET_BANKDATE;
  ---
BEGIN

  TITLE := 'dpt_execute_job(' || LOWER(P_JOBCODE) || '):';

  BARS_AUDIT.TRACE('%s entry with %s/%s',
                   TITLE,
                   P_JOBCODE,
                   TO_CHAR(P_JOBMODE));
  BARS_AUDIT.INFO(TITLE || 's entry with ' || P_JOBCODE || '/' ||
                  TO_CHAR(P_JOBMODE));

  -- установка контекста
  -- bars_context.set_context;
  L_INITBDATE := GL.BDATE;
  BARS_AUDIT.TRACE('%s init gl.bdate - %s',
                   TITLE,
                   TO_CHAR(L_INITBDATE, 'dd.mm.yyyy'));
  BARS_AUDIT.INFO(TITLE || ' init gl.bdate - ' ||
                  TO_CHAR(L_INITBDATE, 'dd.mm.yyyy'));

  -- поиск задания по символьному коду
  BEGIN
    SELECT * INTO L_JOBREC FROM DPT_JOBS_LIST WHERE JOB_CODE = P_JOBCODE;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      BARS_ERROR.RAISE_NERROR(G_MODCODE, 'JOB_NOT_FOUND', P_JOBCODE);
  END;
  BARS_AUDIT.TRACE('%s job № %s, %s',
                   TITLE,
                   TO_CHAR(L_JOBREC.JOB_ID),
                   L_JOBREC.JOB_PROC);
  BARS_AUDIT.INFO(TITLE || ' job № ' || TO_CHAR(L_JOBREC.JOB_ID) || ',' ||
                  L_JOBREC.JOB_PROC);

  IF P_JOBMODE IS NULL THEN
    L_PLSQLBLOCK := 'begin ' || L_JOBREC.JOB_PROC ||
                    '(:dptid, :runid, :branch, :date); end;';
  ELSE
    L_PLSQLBLOCK := 'begin ' || L_JOBREC.JOB_PROC ||
                    '(:dptid, :runid, :branch, :date, :mode); end;';
  END IF;

  -- фиксация запуска автомат.задания в журнале
  DPT_JOBS_AUDIT.P_START_JOB(P_JOBID  => L_JOBREC.JOB_ID,
                             P_BRANCH => SYS_CONTEXT('bars_context',
                                                     'user_branch'),
                             P_BDATE  => L_INITBDATE,
                             P_USER   => L_USERID,
                             P_RUN_ID => L_RUNID);
  BARS_AUDIT.TRACE('%s runid = %s', TITLE, TO_CHAR(L_RUNID));
  BARS_AUDIT.INFO(TITLE || ' runid = ' || TO_CHAR(L_RUNID));

  SELECT BRANCH
    BULK COLLECT
    INTO L_BRANCHLIST
    FROM OUR_BRANCH
   WHERE BRANCH <> '/';

  -- накопление врем.таблицы saldo_holiday для ускорения работы процедуры
  -- начисления процентов по календарным датам движения средств
  IF P_JOBCODE IN ('JOB_INTX', 'JOB_INTF', 'JOB_MINT') THEN
    COLLECT_SALDOHOLIDAY;
  END IF;

  -- для нарахування відсотків ОЩАДБАНКу
  IF (GETGLOBALOPTION('BANKTYPE') = 'SBER') AND (P_JOBCODE = 'JOB_MINT') THEN
  
    L_PLSQLBLOCK := 'begin dpt_web.auto_make_int_monthly_opt(:dptid, :runid, :branch, :date, :mode); end;';
  
    BARS_AUDIT.INFO(TITLE || L_PLSQLBLOCK);
    BARS_AUDIT.TRACE('%s branch = /all_branch/, bdate = %s',
                     TITLE,
                     TO_CHAR(L_BDATE, 'dd.mm.yyyy'));
    BARS_AUDIT.INFO(TITLE || ' branch = /all_branch/, bdate = ' ||
                    TO_CHAR(L_BDATE, 'dd.mm.yyyy'));
  
    L_BDATE := GL.BDATE; -- glb_bankdate;
  
    L_CURSOR := DBMS_SQL.OPEN_CURSOR;
  
    BEGIN
      DBMS_SQL.PARSE(L_CURSOR, L_PLSQLBLOCK, DBMS_SQL.NATIVE);
      DBMS_SQL.BIND_VARIABLE(L_CURSOR, 'dptid', 0);
      DBMS_SQL.BIND_VARIABLE(L_CURSOR, 'runid', L_RUNID);
      DBMS_SQL.BIND_VARIABLE(L_CURSOR, 'branch', '/all_branch/');
      DBMS_SQL.BIND_VARIABLE(L_CURSOR, 'date', L_BDATE);
      --if p_jobmode is not null then
      DBMS_SQL.BIND_VARIABLE(L_CURSOR, 'mode', NVL(P_JOBMODE, 0));
      --end if;
      L_TMPNUM := DBMS_SQL.EXECUTE(L_CURSOR);
      DBMS_SQL.CLOSE_CURSOR(L_CURSOR);
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_SQL.CLOSE_CURSOR(L_CURSOR);
        RAISE;
    END;
  
  ELSE
  
    -- цикл по подразделениям банка
    <<BRANCH_LOOP>>
    FOR I IN 1 .. L_BRANCHLIST.COUNT LOOP
    
      BARS_AUDIT.TRACE('%s branch = %s', TITLE, L_BRANCHLIST(I));
      BARS_AUDIT.INFO(TITLE || ' branch = ' || L_BRANCHLIST(I));
    
      BEGIN
      
        L_KF := BARS_CONTEXT.EXTRACT_MFO(L_BRANCHLIST(I));
        -- поиск банк.даты для 1-го подразделения очередного филиала
        IF (L_CURKF IS NULL OR L_CURKF <> L_KF) THEN
          L_BDATE  := GET_BANKDATE(L_KF);
          L_CURKF  := L_KF;
          GL.BDATE := L_BDATE;
          BARS_AUDIT.TRACE('%s gl.bdate := %s',
                           TITLE,
                           TO_CHAR(L_BDATE, 'dd.mm.yyyy'));
          BARS_AUDIT.INFO(TITLE || ' gl.bdate := ' ||
                          TO_CHAR(L_BDATE, 'dd.mm.yyyy'));
        END IF;
        BARS_CONTEXT.SUBST_BRANCH(L_BRANCHLIST(I));

        BARS_AUDIT.INFO(TITLE || ' L_BRANCHLIST(I) := ' ||L_BRANCHLIST(I)||' L_BDATE := '||L_BDATE);

        L_CURSOR := DBMS_SQL.OPEN_CURSOR;
        BEGIN
          DBMS_SQL.PARSE(L_CURSOR, L_PLSQLBLOCK, DBMS_SQL.NATIVE);
          DBMS_SQL.BIND_VARIABLE(L_CURSOR, 'dptid', 0);
          DBMS_SQL.BIND_VARIABLE(L_CURSOR, 'runid', L_RUNID);
          DBMS_SQL.BIND_VARIABLE(L_CURSOR, 'branch', L_BRANCHLIST(I));
          DBMS_SQL.BIND_VARIABLE(L_CURSOR, 'date', L_BDATE);
          IF P_JOBMODE IS NOT NULL THEN
            DBMS_SQL.BIND_VARIABLE(L_CURSOR, 'mode', P_JOBMODE);
          END IF;
          L_TMPNUM := DBMS_SQL.EXECUTE(L_CURSOR);
          DBMS_SQL.CLOSE_CURSOR(L_CURSOR);
        EXCEPTION
          WHEN OTHERS THEN
            DBMS_SQL.CLOSE_CURSOR(L_CURSOR);
            RAISE;
        END;
      
      EXCEPTION
        WHEN EXPTNOBD THEN
          BARS_AUDIT.ERROR(TITLE || ' не найдена банк.дата для МФО ' || L_KF);
      END;
    
    END LOOP BRANCH_LOOP;
  
  END IF;

  BARS_CONTEXT.SET_CONTEXT;
  GL.BDATE := L_INITBDATE;
  BARS_AUDIT.TRACE('%s gl.bdate := %s',
                   TITLE,
                   TO_CHAR(L_INITBDATE, 'dd.mm.yyyy'));
  BARS_AUDIT.INFO(TITLE || ' gl.bdate := ' ||
                  TO_CHAR(L_INITBDATE, 'dd.mm.yyyy'));

  BARS_AUDIT.INFO(TITLE || ' успешно выполнена процедура ' ||
                  L_JOBREC.JOB_NAME);

  -- фиксация успешного окончания автомат.задания в журнале
  DPT_JOBS_AUDIT.P_FINISH_JOB(L_RUNID);

  COMMIT;

EXCEPTION
  WHEN OTHERS THEN
    BARS_CONTEXT.SET_CONTEXT;
    GL.BDATE := L_INITBDATE;
    BARS_AUDIT.TRACE('%s gl.bdate := %s',
                     TITLE,
                     TO_CHAR(L_INITBDATE, 'dd.mm.yyyy'));
    BARS_AUDIT.INFO(TITLE || ' gl.bdate := ' ||
                    TO_CHAR(L_INITBDATE, 'dd.mm.yyyy'));
    BARS_ERROR.RAISE_ERROR(G_MODCODE,
                           999,
                           SUBSTR(TITLE || ' ' || SQLERRM, 1, 254));
    -- фиксация окончания автомат.задания с ошибкой в журнале
    DPT_JOBS_AUDIT.P_FINISH_JOB(L_RUNID, SUBSTR(SQLERRM, 1, 254));
    ROLLBACK;
END;
/
show err;

PROMPT *** Create  grants  DPT_EXECUTE_JOB ***
grant EXECUTE                                                                on DPT_EXECUTE_JOB to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DPT_EXECUTE_JOB to DPT_ADMIN;
grant EXECUTE                                                                on DPT_EXECUTE_JOB to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/DPT_EXECUTE_JOB.sql =========*** E
PROMPT ===================================================================================== 


