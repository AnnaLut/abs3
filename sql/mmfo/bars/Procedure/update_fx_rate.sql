

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/UPDATE_FX_RATE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure UPDATE_FX_RATE ***

  CREATE OR REPLACE PROCEDURE BARS.UPDATE_FX_RATE 
	   (    l_curr 		IN	VARCHAR2,	-- Currency
     		l_vdate 	IN	DATE,		-- Value Date
     		l_s        	IN	NUMBER,		-- Sum in Currency
     		l_sq        	IN	NUMBER )	-- Base equivalent
IS
	l_kv		NUMBER				 ;
        l_nv		NUMBER				 ;
        l_bsum		NUMBER				 ;
        l_NBUrate	NUMBER				 ;
--        l_cleared	NUMBER			:=	5;
--        l_forward	NUMBER			:=	3;
        l_fxrate	NUMBER				 ;
        l_saldov	NUMBER				 ;
        l_saldoq	NUMBER				 ;
        l_tv		NUMBER				 ;
        l_tq		NUMBER				 ;
        l_bdate		DATE				 ;
        l_pdate		DATE				 ;
        l_d		DATE				 ;
        l_vp		CONSTANT VARCHAR2(3)	:= 'VP'  ;
	erm		VARCHAR2 (80)			 ;
        ern		CONSTANT POSITIVE       := 711	 ;
        err		EXCEPTION			 ;
BEGIN
    IF deb.debug THEN
	deb.trace (ern, 'module/0','update_fx_rate');
        deb.trace (ern, 'Currency', l_curr );
        deb.trace (ern, 'Date', l_vdate );
        deb.trace (ern, 'Sum', l_s );
        deb.trace (ern, 'Base equivalent', l_sq );
    END IF;
    --
    -- Check data consistency
    --
    --
    IF    l_sq = 0
       OR l_s  = 0
       OR l_sq IS NULL
       OR l_s  IS NULL
    THEN
         IF deb.debug
         THEN
            deb.trace (ern, 'Improper sum', 0 );
         END IF;
         RETURN;
    END IF;
    --
    -- Get current business date
    --
    --
    gl.param;
    l_bdate := gl.bd;
    IF deb.debug
    THEN
        deb.trace (ern, 'Current business date', l_bdate );
    END IF;
    --
    -- Check if value date is not for the past
    -- (Back valued rate change is forbidden)
    --
    --
    IF   l_vdate < l_bdate
    THEN
         IF deb.debug
         THEN
            deb.trace (ern, 'Return because of back value date', l_vdate );
         END IF;
	 RETURN;
    END IF;
    --
    -- Get currency numeric code
    --
    --
    BEGIN
          SELECT  kv
            INTO  l_kv
            FROM  tabval
            WHERE lcv = l_curr;
    EXCEPTION
            WHEN NO_DATA_FOUND THEN
            erm := 'Invalid currency code';
            RAISE err;
    END;
    IF deb.debug
    THEN
        deb.trace (ern, 'Currency code', l_kv );
    END IF;
    --
    -- Get base currency code
    --
    --
    BEGIN
          SELECT  TO_NUMBER(val)
            INTO  l_nv
            FROM  params
            WHERE par = 'BASEVAL';
    EXCEPTION
            WHEN NO_DATA_FOUND THEN
            erm := 'No base currency defined';
            RAISE err;
    END;
    IF l_kv = l_nv THEN
       RETURN;				-- The currency is the base one
    END IF;
    --
    -- Get previous spot rate
    --
    --
    BEGIN
        SELECT  rate_spot
              , vdate
              , bsum
              , rate_o
          INTO  l_fxrate
              , l_pdate
              , l_bsum
              , l_NBUrate
          FROM  cur_rates
          WHERE  kv = l_kv
            AND vdate = ( SELECT MAX(vdate)
                          FROM   cur_rates
                          WHERE  kv = l_kv
                          AND    vdate < l_vdate );
    EXCEPTION
         WHEN NO_DATA_FOUND                     -- There was no rate before
         THEN
        IF deb.debug
        THEN
            deb.trace (ern, 'There is no previous rate', l_vdate );
        END IF;
        RETURN;
    END;
    IF deb.debug
    THEN
        deb.trace (ern, 'Selected previous fx_rate is', l_fxrate );
        deb.trace (ern, 'Previous date is', l_pdate );
    END IF;
    IF l_fxrate IS NULL
    THEN
       l_fxrate := l_NBUrate/l_bsum;
       UPDATE  cur_rates
         SET   rate_spot = l_fxrate
         WHERE vdate = l_pdate
         AND   kv = l_kv;
       IF deb.debug
       THEN
            deb.trace (ern, 'Set previous fx_rate to', l_fxrate );
       END IF;
    END IF;
    			--------------- (1)
                        --------------- Start of day Position (cleared)
    SELECT  NVL( SUM( ABS( ostc + dos - kos )), 0)
      INTO  l_saldov
      FROM  accounts
     WHERE  kv = l_kv AND RTRIM(tip) = l_vp;
                        ---------------
                        ---------------
    l_saldoq := l_saldov * l_fxrate;	-- Base equivalent of the position
    IF deb.debug
    THEN
         deb.trace (ern, 'Start of day position    ', l_saldov );
         deb.trace (ern, 'Eqv start of day position', l_saldoq );
    END IF;
    IF l_vdate = l_bdate   --================ Update the current spot rate
    THEN
        IF deb.debug
        THEN
            deb.trace (ern, 'About to update spot rate for', l_vdate );
        END IF;
        --
        -- Get current spot rate
        --
        --
        BEGIN
        SELECT  rate_spot
          INTO  l_fxrate
          FROM  cur_rates
          WHERE kv = l_kv
            AND vdate = l_vdate;
        EXCEPTION
         WHEN NO_DATA_FOUND              -- There is no current spot rate yet
         THEN
            l_fxrate := NULL;
            INSERT INTO cur_rates   (
                             kv
                           , vdate
                           , bsum
                           , rate_o )
                   VALUES           (
                             l_kv
                           , l_vdate
                           , l_bsum
                           , l_NBUrate );
            IF deb.debug
            THEN
                deb.trace (ern, 'Insert new record for', l_vdate);
            END IF;
        END;
        IF deb.debug
        THEN
            deb.trace (ern, 'Selected current spot rate is', l_fxrate );
        END IF;
        IF l_fxrate IS NULL
        THEN
            l_fxrate := l_saldoq/l_saldov;    -- restore the previous value
        END IF;
    			--------------- (2)
                        --------------- Cashflow during the current day
                        --------------- (not neccessary cleared)
        SELECT  NVL(SUM(ABS( o.s  )), 0)
          INTO  l_tv
          FROM  opldok o, accounts a, oper r
         WHERE  o.acc         = a.acc     AND
                a.kv          = l_kv      AND
                RTRIM(a.tip)  = l_vp      AND
                r.ref         = o.ref     AND
                r.vdat        = l_vdate;
        l_tq := l_tv * l_fxrate;    -- Count today's equivalent based on the
                                    -- current spot rate
        IF deb.debug
        THEN
             deb.trace (ern, 'Cashflow of the current day ', l_tv );
             deb.trace (ern, 'Equivalent of it            ', l_tq );
        END IF;
        --
        -- Update the current spot rate
        --
        --
        IF   l_saldov+l_tv <> 0
        THEN
           l_fxrate := ( l_saldoq + l_tq + l_sq) /
                       ( l_saldov + l_tv + l_s );
           UPDATE   cur_rates		-- Update the current spot rate
              SET   rate_spot = l_fxrate
            WHERE   kv = l_kv AND vdate = l_vdate;
           IF deb.debug
           THEN
              deb.trace (ern, 'Set spot rate to', l_fxrate );
           END IF;
        END IF;
    ELSE    	           --===================== Update forward rates
         IF deb.debug
         THEN
            deb.trace (ern, 'About to update forward rate for', l_vdate );
         END IF;
                        --------------- (2+3)
                        --------------- Cashflow of the current day +
                        --------------- the one up to the value date
        SELECT  NVL(SUM(ABS( o.s  )), 0),
                NVL(SUM(ABS( o.sq )), 0)
          INTO  l_tv,
                l_tq
          FROM  opldok o, accounts a, oper r
         WHERE  o.acc           =  a.acc     AND
                a.kv            =  l_kv      AND
                RTRIM(a.tip)    =  l_vp      AND
--                o.sos   = l_forward AND  -- Count only forward sums
                r.ref           =  o.ref     AND
                l_bdate         <= r.vdat    AND  -- between the business and
                r.vdat          <  l_vdate;       -- value dates
                        ---------------
                        ---------------
        IF deb.debug
        THEN
             deb.trace (ern, 'Cashflow up to value date    ', l_tv );
             deb.trace (ern, 'Eqv cashflow up to value date', l_tq );
        END IF;
        l_saldov := l_saldov + l_tv;
        l_saldoq := l_saldoq + l_tq;
        DECLARE
            CURSOR fw IS
                   SELECT vdate
                   FROM   cur_rates
                   WHERE  kv = l_kv AND vdate >= l_vdate
                   FOR UPDATE;
        BEGIN
            FOR  fw_rec IN fw		-- Update all rates between business
            LOOP			-- and given forward dates
                        --------------- (4)
                        --------------- Cashflow in the value date +
                        --------------- the one up to the fetched forward date
                SELECT  NVL(SUM( o.s ), 0), NVL(SUM( o.sq ), 0)
                 INTO   l_tv, 		    l_tq
                 FROM   opldok o, accounts a, oper r
                 WHERE  o.acc          =  a.acc     AND
                        a.kv           =  l_kv      AND
                        RTRIM(a.tip)   =  l_vp      AND
--                        o.sos   = l_forward AND  -- Count only forward sums
                        r.ref          =  o.ref     AND
                        l_vdate        <= r.vdat    AND  -- between the value and
                        r.vdat         <= fw_rec.vdate;  -- fetched forward dates
                        ---------------
                        ---------------
                IF deb.debug
                THEN
                   deb.trace (ern, 'Forward date is', fw_rec.vdate );
                   deb.trace (ern, 'Cashflow up to forward date    ', l_tv );
                   deb.trace (ern, 'Eqv cashflow up to forward date', l_tq );
                END IF;
                IF l_tv <> 0 AND
                   l_tq <> 0 THEN
                     l_fxrate := (l_saldoq + l_tq)/(l_saldov + l_tv);
                     UPDATE cur_rates
                     SET    rate_forward = l_fxrate
                     WHERE CURRENT OF fw;
                    IF deb.debug
                    THEN
                       deb.trace (ern, 'Set forward rate to', l_fxrate );
                    END IF;
                END IF;
            END LOOP;
        END;
    END IF;
END update_fx_rate;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/UPDATE_FX_RATE.sql =========*** En
PROMPT ===================================================================================== 
