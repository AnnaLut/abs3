

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/ARMS_GRANT_ROLE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure ARMS_GRANT_ROLE ***

  CREATE OR REPLACE PROCEDURE BARS.ARMS_GRANT_ROLE 
( CODEAPP_ CHAR, ROLE_NAME_ VARCHAR2 ) IS
  NUM_  NUMBER;
  CID	INTEGER;
  LOSECURE_	INTEGER;
  I     BINARY_INTEGER := 0;

CURSOR ARM_USERS IS
  SELECT DISTINCT A.LOGNAME
    FROM STAFF A, APPLIST_STAFF B
	WHERE A.ID=B.ID AND B.CODEAPP=CODEAPP_;

TYPE   TUSER_TAB IS TABLE OF ARM_USERS%ROWTYPE INDEX BY BINARY_INTEGER;
USERS_ TUSER_TAB;

BEGIN


   BEGIN
        SELECT val INTO LOSECURE_ FROM params WHERE par='LOSECURE';
   EXCEPTION
         WHEN NO_DATA_FOUND  THEN LOSECURE_ := 0;
   END;



   dbms_output.put_line('IN PROCEDURE !!!!! losecure='||LOSECURE_);
  --Õ”∆ÕŒ À» √–¿Õ“»“‹ ¬ŒŒ¡Ÿ≈
  IF ROLE_NAME_ IS NULL OR (ROLE_NAME_ IS NOT NULL AND LENGTH( LTRIM(ROLE_NAME_)) = 0) THEN
    dbms_output.put_line('returning - rolrname - NULL');
	RETURN;
  END IF;

-- IN LOW SECURE MODE -----------------------
   IF LOSECURE_ >=1 THEN
     SELECT COUNT(*) INTO NUM_ FROM
            (  SELECT A.CODEOPER
               FROM   OPERAPP A,  OPERLIST B
               WHERE  A.CODEOPER=B.CODEOPER AND A.CODEAPP=CODEAPP_ AND
  	                  UPPER(B.ROLENAME)=UPPER(ROLE_NAME_)
  	           UNION ALL
               SELECT A.TABID
               FROM REFAPP A,  REFERENCES B
               WHERE   A.TABID=B.TABID AND A.CODEAPP=CODEAPP_ AND
             	       UPPER(B.ROLE2EDIT)=UPPER(ROLE_NAME_)
    	    );
   ELSE
       SELECT COUNT(*) INTO NUM_ FROM
            (  SELECT A.CODEOPER
               FROM   OPERAPP A,  OPERLIST B
               WHERE  A.CODEOPER=B.CODEOPER AND A.CODEAPP=CODEAPP_ AND
  	                  UPPER(B.ROLENAME)=UPPER(ROLE_NAME_)
					  AND NVL(approve,0)=1
  	           UNION ALL
               SELECT A.TABID
               FROM REFAPP A,  REFERENCES B
               WHERE   A.TABID=B.TABID AND A.CODEAPP=CODEAPP_ AND
             	       UPPER(B.ROLE2EDIT)=UPPER(ROLE_NAME_)
					   AND NVL(approve,0)=1
    	    );
   END IF;


   --√–¿Õ“»“‹ Õ”ÕŒ (Õ≈ –¿«¡»–¿ﬂ—‹, ¿ ≈—“‹ À» ŒÕ¿ ” œŒÀ‹«Œ¬¿“≈Àﬂ ”∆≈ ¬ ƒ–”√ŒÃ ¿–ÃÂ)
    dbms_output.put_line('NUM_= '||NUM_);
    IF NUM_=0 THEN
     dbms_output.put_line('NUM_=0 ');
	--¬—≈’ œŒÀ‹«Œ¬¿“≈À≈… ¬ “¿¡À»÷”
    FOR C1 IN ARM_USERS LOOP
       I := I + 1;
       USERS_(I) := C1;
    END LOOP;
    --√–¿Õ“»Ã
	FOR I IN 1 .. USERS_.COUNT LOOP
	  BEGIN
        CID := DBMS_SQL.OPEN_CURSOR;
        DBMS_SQL.PARSE(CID, 'GRANT ' || ROLE_NAME_ || ' TO ' || USERS_(I).LOGNAME, DBMS_SQL.V7);
		dbms_output.put_line('grant '||ROLE_NAME_|| ' TO ' || USERS_(I).LOGNAME);
        DBMS_SQL.CLOSE_CURSOR( CID );
	  EXCEPTION
	    WHEN OTHERS THEN NULL;
	  END;
	END LOOP;
  END IF;
END ARMS_GRANT_ROLE;
/
show err;

PROMPT *** Create  grants  ARMS_GRANT_ROLE ***
grant EXECUTE                                                                on ARMS_GRANT_ROLE to ABS_ADMIN;
grant EXECUTE                                                                on ARMS_GRANT_ROLE to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on ARMS_GRANT_ROLE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/ARMS_GRANT_ROLE.sql =========*** E
PROMPT ===================================================================================== 
