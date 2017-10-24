

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/DYNAMIC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure DYNAMIC ***

  CREATE OR REPLACE PROCEDURE BARS.DYNAMIC 

	 ( statement 	IN	VARCHAR2 )
IS
        cursor_name	INTEGER			:= DBMS_SQL.OPEN_CURSOR;
        ret		INTEGER					       ;

	erm		VARCHAR2 (80)				       ;
        ern		CONSTANT POSITIVE       := 714		       ;
        err		EXCEPTION				       ;

BEGIN

    IF deb.debug THEN
	deb.trace (ern, 'module/0','dynamic');
        deb.trace (ern, 'Statement', statement );
    END IF;

    DBMS_SQL.PARSE ( cursor_name,
    		     statement,
                     DBMS_SQL.V7 );

    ret := DBMS_SQL.LAST_ERROR_POSITION;

    IF deb.debug THEN
	deb.trace (ern, 'After PARSE error position is',ret);
    END IF;


    ret := DBMS_SQL.EXECUTE ( cursor_name );

    IF deb.debug THEN
	deb.trace (ern, 'After EXECUTE error position is',ret);
    END IF;

    DBMS_SQL.CLOSE_CURSOR ( cursor_name );


EXCEPTION
	WHEN err
        THEN
            raise_application_error(-(20000+ern),'\'||erm,TRUE);

	WHEN OTHERS
        THEN
            IF DBMS_SQL.IS_OPEN ( cursor_name ) THEN
               DBMS_SQL.CLOSE_CURSOR ( cursor_name );
            END IF;

	    raise_application_error(-(20000+ern),SQLERRM,TRUE);

END dynamic;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/DYNAMIC.sql =========*** End *** =
PROMPT ===================================================================================== 
