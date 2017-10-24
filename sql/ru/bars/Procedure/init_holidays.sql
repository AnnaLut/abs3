

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/INIT_HOLIDAYS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure INIT_HOLIDAYS ***

  CREATE OR REPLACE PROCEDURE BARS.INIT_HOLIDAYS 
( l_curr                IN      VARCHAR2,
  l_year                IN      NUMBER
)
IS

  l_kv            NUMBER;
  l_i             NUMBER;
  l_days          NUMBER;
  l_weekday       NUMBER;
  l_inserted      NUMBER := 0;
  l_day           DATE;
  l_tmp           DATE;

  ern             NUMBER;
  err             EXCEPTION;

BEGIN

    IF deb.debug THEN
       deb.trace (ern, 'module/0','init_holidays');
       deb.trace (ern, 'Currency', l_curr );
       deb.trace (ern, 'Year', l_year );
    END IF;

    BEGIN                           -- Get currency numeric code
      SELECT  kv
        INTO  l_kv
        FROM  tabval
        WHERE lcv = l_curr;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        -- 'Invalid currency code';
        ern := 4;
        RAISE err;
    END;

    IF deb.debug
    THEN
       deb.trace (ern, 'Literal curr code', l_kv );
    END IF;

    l_day  := TO_DATE ('01/01/'|| TO_CHAR(l_year  ), 'MM/DD/YYYY');
    l_days := TO_DATE ('01/01/'|| TO_CHAR(l_year+1), 'MM/DD/YYYY') -
                  l_day;
    IF deb.debug
    THEN
       deb.trace ( ern, 'l_day=', l_day );
       deb.trace ( ern, 'l_days=', l_days );
    END IF;

    l_i := 0;
    WHILE l_i < l_days
    LOOP
        l_weekday := TO_CHAR (l_day, 'D');

        IF  l_weekday = 1                   -- Sunday
        OR
            l_weekday = 7                   -- Saturday
        THEN
           BEGIN
               SELECT  holiday
                   INTO  l_tmp
                   FROM  holiday
                   WHERE kv = l_kv AND holiday = l_day;
           EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                 INSERT INTO holiday (  kv,  holiday)
                        VALUES       ( l_kv, l_day );
                 IF SQL%ROWCOUNT = 1
                 THEN
                    l_inserted := l_inserted +1;
                 END IF;
           END;
        END IF;
        l_day := l_day + 1;
        l_i    := l_i   + 1;
    END LOOP;
    IF deb.debug
    THEN
            deb.trace ( ern, 'Inserted', l_inserted );
    END IF;

EXCEPTION
  WHEN err THEN
       bars_error.raise_error('SVC', ern);
END init_holidays;
/
show err;

PROMPT *** Create  grants  INIT_HOLIDAYS ***
grant EXECUTE                                                                on INIT_HOLIDAYS   to ABS_ADMIN;
grant EXECUTE                                                                on INIT_HOLIDAYS   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on INIT_HOLIDAYS   to TECH005;
grant EXECUTE                                                                on INIT_HOLIDAYS   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/INIT_HOLIDAYS.sql =========*** End
PROMPT ===================================================================================== 
