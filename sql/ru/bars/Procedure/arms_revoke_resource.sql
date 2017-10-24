

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/ARMS_REVOKE_RESOURCE.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure ARMS_REVOKE_RESOURCE ***

  CREATE OR REPLACE PROCEDURE BARS.ARMS_REVOKE_RESOURCE 
( CODEAPP_ VARCHAR2, RES_TYPE NUMBER, RES_ID VARCHAR2 ) IS
  -- RES_TYPE=1 - reference
  -- RES_TYPE=2 - functions

  CID	      INTEGER;
  LOSECURE_	  INTEGER;
  I           BINARY_INTEGER := 0;
  ROLENAME_   VARCHAR2(50);

CURSOR ARM_USERS_NEED_GRANT IS
SELECT logname, codeapp FROM  STAFF A, APPLIST_STAFF B
WHERE  logname  NOT IN (
   -- Найдем пользователей у которых естьь АРМ-ы у которых есть есть наша роль
    SELECT unique logname FROM  STAFF A, APPLIST_STAFF B
    WHERE A.ID=B.ID
         AND  codeapp IN(
            -- АРМЫ - в которых существует данная роль в справочниках
            SELECT UNIQUE codeapp FROM  REFAPP A,  REFERENCES B
            WHERE a.tabid=b.tabid  AND decode(RES_TYPE,1,a.tabid, -1)<>to_number(RES_ID)
	           AND UPPER(role2edit)=ROLENAME_
               AND decode(LOSECURE_, 1, nvl(a.approve,0), LOSECURE_) = LOSECURE_
            UNION
            -- АРМЫ -  в которых существует данная роль в функах
            SELECT UNIQUE codeapp FROM  operapp  A,  operlist B
            WHERE a.codeoper=b.codeoper  AND decode(RES_TYPE, 2, a.codeoper, -1)<>to_number(RES_ID)
	           AND UPPER(rolename)=ROLENAME_
               AND decode(LOSECURE_, 1, nvl(a.approve,0), LOSECURE_) = LOSECURE_
		  )
	    AND logname IN
           -- Пользователи у которых есть НАШ арм
  	       ( SELECT logname  FROM  STAFF A, APPLIST_STAFF B
	       WHERE A.ID=B.ID AND b.codeapp=CODEAPP_
		   AND decode(LOSECURE_, 1, nvl(b.approve,0), LOSECURE_) = LOSECURE_)
)
AND A.ID=B.ID AND b.codeapp=CODEAPP_
AND decode(LOSECURE_, 1, nvl(b.approve,0), LOSECURE_) = LOSECURE_;


TYPE   TUSER_TAB IS TABLE OF ARM_USERS_NEED_GRANT%ROWTYPE INDEX BY BINARY_INTEGER;
USERS_ TUSER_TAB;

BEGIN

   BEGIN
      SELECT decode(val,'1','0','1') INTO LOSECURE_  FROM params WHERE par='LOSECURE';
   EXCEPTION  WHEN NO_DATA_FOUND  THEN LOSECURE_ := 1;
   END;

   dbms_output.put_line('IN PROCEDURE !!!!! losecure='||LOSECURE_);

   BEGIN
     IF RES_TYPE=1 THEN
         SELECT UPPER(role2edit)  INTO ROLENAME_ FROM references
         WHERE tabid=to_number(RES_ID) AND role2edit is not NULL;
     END IF;
     IF RES_TYPE=2 THEN
         SELECT UPPER(rolename) INTO ROLENAME_ FROM operlist
         WHERE codeoper=to_number(RES_ID) AND rolename is not NULL;
     END IF;
   END;

   FOR C1 IN ARM_USERS_NEED_GRANT LOOP
       I := I + 1;
       USERS_(I) := C1;
   END LOOP;

   FOR I IN 1 .. USERS_.COUNT LOOP
   BEGIN
    CID := DBMS_SQL.OPEN_CURSOR;
    DBMS_SQL.PARSE(CID, 'REVOKE ' || ROLENAME_ || ' FROM ' || USERS_(I).LOGNAME, DBMS_SQL.V7);
    dbms_output.put_line('REVOKE '||ROLENAME_|| ' FROM ' || USERS_(I).LOGNAME);
    DBMS_SQL.CLOSE_CURSOR( CID );
  EXCEPTION
  WHEN OTHERS THEN NULL;
  END;
  END LOOP;
END;
/
show err;

PROMPT *** Create  grants  ARMS_REVOKE_RESOURCE ***
grant EXECUTE                                                                on ARMS_REVOKE_RESOURCE to ABS_ADMIN;
grant EXECUTE                                                                on ARMS_REVOKE_RESOURCE to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on ARMS_REVOKE_RESOURCE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/ARMS_REVOKE_RESOURCE.sql =========
PROMPT ===================================================================================== 
