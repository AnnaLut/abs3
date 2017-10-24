

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/ARMS_REVOKE_ROLE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure ARMS_REVOKE_ROLE ***

  CREATE OR REPLACE PROCEDURE BARS.ARMS_REVOKE_ROLE 
( CODEAPP_ VARCHAR2, ROLE_NAME_ VARCHAR2 ) IS
NUM_  NUMBER;
CID	  INTEGER;
I     BINARY_INTEGER := 0;

CURSOR ARM_USERS IS
  SELECT DISTINCT A.ID, A.LOGNAME
    FROM STAFF A, APPLIST_STAFF B
	WHERE A.ID=B.ID AND B.CODEAPP=CODEAPP_;


TYPE   TUSER_TAB IS TABLE OF ARM_USERS%ROWTYPE INDEX BY BINARY_INTEGER;
USERS_ TUSER_TAB;

FUNCTION NEED_REVOKE_FROM_USER(ROLE_ VARCHAR2, ID_ NUMBER) RETURN NUMBER IS
RESULT NUMBER;
BEGIN
  SELECT COUNT(*) INTO RESULT FROM (
    SELECT ROLENAME FROM APPLIST_STAFF A, OPERAPP B, OPERLIST C
    WHERE A.ID=ID_ AND A.CODEAPP=B.CODEAPP AND
    B.CODEOPER=C.CODEOPER AND C.ROLENAME=ROLE_
    UNION ALL
    SELECT ROLE2EDIT FROM APPLIST_STAFF A, REFAPP B, REFERENCES C
    WHERE A.ID=ID_ AND A.CODEAPP=B.CODEAPP AND
    B.TABID=C.TABID AND C.ROLE2EDIT=ROLE_);
  RETURN RESULT;
END;

BEGIN
  --мсфмн кх пебнвхрэ бннаые
  IF ROLE_NAME_ IS NULL OR (ROLE_NAME_ IS NOT NULL AND LENGTH( LTRIM(ROLE_NAME_)) = 0) THEN
    RETURN;
  END IF;
  SELECT COUNT(*) INTO NUM_ FROM (
    SELECT A.CODEOPER
       FROM OPERAPP A, OPERLIST B
       WHERE A.CODEOPER=B.CODEOPER AND A.CODEAPP=CODEAPP_ AND
	     UPPER(B.ROLENAME)=UPPER(ROLE_NAME_)
	UNION ALL
    SELECT A.TABID
       FROM REFAPP A, REFERENCES B
       WHERE A.TABID=B.TABID AND A.CODEAPP=CODEAPP_ AND
	     UPPER(B.ROLE2EDIT)=UPPER(ROLE_NAME_) );
  --пебнвхрэ мсмн (р.е. б юплЕ пнкх сфе мер)
  IF NUM_=0 THEN
    --бяеу онкэгнбюрекеи б рюакхжс
    FOR C1 IN ARM_USERS LOOP
       I := I + 1;
       USERS_(I) := C1;
    END LOOP;
    --пебнвхл
	FOR I IN 1 .. USERS_.COUNT LOOP
      BEGIN
	    IF NEED_REVOKE_FROM_USER( ROLE_NAME_, USERS_(I).ID ) =0 THEN --гюахпюел опхбхкецхч рнкэйн еякх ее сфе мер с онкэгнбюрекъ бннаые
          CID := DBMS_SQL.OPEN_CURSOR;
          DBMS_SQL.PARSE(CID, 'REVOKE ' || ROLE_NAME_ || ' FROM ' || USERS_(I).LOGNAME, DBMS_SQL.V7);
          DBMS_SQL.CLOSE_CURSOR( CID );
		END IF;
      EXCEPTION
	    WHEN OTHERS THEN NULL;
	  END;
	END LOOP;
  END IF;
END ARMS_REVOKE_ROLE;

 
/
show err;

PROMPT *** Create  grants  ARMS_REVOKE_ROLE ***
grant EXECUTE                                                                on ARMS_REVOKE_ROLE to ABS_ADMIN;
grant EXECUTE                                                                on ARMS_REVOKE_ROLE to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on ARMS_REVOKE_ROLE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/ARMS_REVOKE_ROLE.sql =========*** 
PROMPT ===================================================================================== 
