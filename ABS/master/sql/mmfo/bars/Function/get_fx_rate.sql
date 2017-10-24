
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_fx_rate.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_FX_RATE 

		( l_curr 		IN	VARCHAR2,
		  l_vdate 		IN	DATE
                )
		  RETURN NUMBER
IS

	l_kv		NUMBER			;
        l_nv		NUMBER			;
        l_fxrate	NUMBER	:=	NULL	;
        l_bdate		DATE			;

	erm		VARCHAR2 (80)				;
        ern		CONSTANT POSITIVE       := 711		;
        err		EXCEPTION				;
BEGIN

    IF deb.debug THEN
	deb.trace (ern, 'module/0','get_fx_rate');
        deb.trace (ern, 'Currency', l_curr );
        deb.trace (ern, 'Date', l_vdate );
    END IF;

    BEGIN				-- Get currency numeric code
          SELECT  kv
            INTO l_kv
            FROM  tabval
            WHERE lcv = l_curr;
    EXCEPTION
            WHEN NO_DATA_FOUND THEN
            erm := 'Invalid currency code';
            RAISE err;
    END;

    IF deb.debug
    THEN
        deb.trace (ern, 'Literal curr code', l_kv );
    END IF;

    BEGIN				-- Get base currency code
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
       RETURN 1;			-- The currency is the base one
    END IF;

    l_bdate := gl.bd;			-- Get current business date

    BEGIN
	IF l_vdate <= l_bdate		-- Date is for the past
    	THEN
    		SELECT  rate_spot
        	INTO    l_fxrate
        	FROM    cur_rates
        	WHERE   vdate = l_vdate AND kv = l_kv;

        ELSE				-- Date is in the future
    		SELECT rate_forward
        	INTO   l_fxrate
        	FROM   cur_rates
        	WHERE  vdate = l_vdate AND kv = l_kv;
	END IF;

    EXCEPTION                   	-- No rate exists for the given date
            WHEN NO_DATA_FOUND THEN
            l_fxrate := 1;
    END;

RETURN l_fxrate;

EXCEPTION
	WHEN err
        THEN
            raise_application_error(-(20000+ern),'\'||erm,TRUE);

	WHEN OTHERS
        THEN
	    raise_application_error(-(20000+ern),SQLERRM,TRUE);

END get_fx_rate;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_fx_rate.sql =========*** End **
 PROMPT ===================================================================================== 
 