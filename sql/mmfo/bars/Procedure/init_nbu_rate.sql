

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/INIT_NBU_RATE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure INIT_NBU_RATE ***

  CREATE OR REPLACE PROCEDURE BARS.INIT_NBU_RATE 
     	   ( dummy	IN	NUMBER)

IS

	l_kv		NUMBER				 ;

        l_prev_date	DATE				 ;
        l_curr_date	DATE				 ;

        l_bsum		NUMBER				 ;
        l_NBUrate	NUMBER				 ;
        l_rate_b	NUMBER				 ;
        l_rate_s	NUMBER				 ;

        CURSOR cur_prev_rate IS

            SELECT kv
                 , bsum
                 , rate_o
                 , rate_b
                 , rate_s
            FROM   cur_rates
            WHERE  vdate = l_prev_date;

	erm		VARCHAR2 (80)			 ;
        ern		CONSTANT POSITIVE       := 717	 ;
        err		EXCEPTION			 ;
BEGIN

    IF deb.debug THEN
	deb.trace (ern, 'module/0','init_nbu_rate');
    END IF;

    --
    -- Get current business date
    --
    --
    gl.param;
    l_curr_date := gl.bd;

    IF deb.debug
    THEN
        deb.trace (ern, 'Current business date', l_curr_date );
    END IF;

    --
    -- Get previous business date
    --
    --
    BEGIN

       SELECT MAX(vdate)
       INTO   l_prev_date
       FROM   cur_rates
       WHERE  vdate < l_curr_date;

    EXCEPTION
         WHEN NO_DATA_FOUND THEN

        IF deb.debug
        THEN
            deb.trace (ern, 'There are no rates prior', l_curr_date );
        END IF;

    END;

    IF deb.debug
    THEN
        deb.trace (ern, 'Previous business date', l_prev_date );
    END IF;


    FOR  prev_rec IN cur_prev_rate	-- Scan all rates for previous date
    LOOP

        IF deb.debug
        THEN
                deb.trace (ern, 'Currency:', prev_rec.kv );
                deb.trace (ern, 'Base sum:', prev_rec.bsum );
                deb.trace (ern, 'NBU Rate:', prev_rec.rate_o );
                deb.trace (ern, 'Bid Rate:', prev_rec.rate_b );
                deb.trace (ern, 'Off Rate:', prev_rec.rate_s );
        END IF;

        BEGIN

            --
            -- Check if the record exists for the fetched currency and current
            -- business date

            SELECT bsum
                 , rate_o
                 , rate_b
                 , rate_s
            INTO   l_bsum
                 , l_NBUrate
                 , l_rate_b
                 , l_rate_s
            FROM   cur_rates
            WHERE  kv    = prev_rec.kv
              AND  vdate = l_curr_date;

            --
            -- If the previous statement has not fired exception, then
            -- we just need to update this record in case of rate_b or/and
            -- rate_s happen to be NULL
            --

            IF  l_rate_b        IS     NULL
            AND prev_rec.rate_b IS NOT NULL
            THEN

                IF deb.debug
                THEN
                   deb.trace (ern, '== Update bid rate =', prev_rec.rate_b );
                END IF;

                UPDATE cur_rates
                   SET rate_b = prev_rec.rate_b
                WHERE  kv    = prev_rec.kv
                  AND  vdate = l_curr_date;

            END IF;

            IF l_rate_s         IS     NULL
            AND prev_rec.rate_s IS NOT NULL
            THEN

                IF deb.debug
                THEN
                   deb.trace (ern, '== Update offer rate =', prev_rec.rate_s );
                END IF;

                UPDATE cur_rates
                   SET rate_s = prev_rec.rate_s
                WHERE  kv    = prev_rec.kv
                  AND  vdate = l_curr_date;

            END IF;

        EXCEPTION  WHEN NO_DATA_FOUND
        THEN

             IF deb.debug
             THEN
                deb.trace (ern, '== Insert new record for', prev_rec.kv );
             END IF;

             INSERT INTO cur_rates
                    (
                      kv
                    , vdate
                    , bsum
                    , rate_o
                    , rate_b
                    , rate_s
                    )
             VALUES (
                      prev_rec.kv
                    , l_curr_date
                    , prev_rec.bsum
                    , prev_rec.rate_o
                    , prev_rec.rate_b
                    , prev_rec.rate_s
                    );
        END;

    END LOOP;


EXCEPTION
	WHEN err
        THEN
            raise_application_error(-(20000+ern),'\'||erm,TRUE);

	WHEN OTHERS
        THEN
	    raise_application_error(-(20000+ern),SQLERRM,TRUE);


END init_nbu_rate;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/INIT_NBU_RATE.sql =========*** End
PROMPT ===================================================================================== 
