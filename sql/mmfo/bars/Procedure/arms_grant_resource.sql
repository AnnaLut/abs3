

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/ARMS_GRANT_RESOURCE.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  procedure ARMS_GRANT_RESOURCE ***

  CREATE OR REPLACE PROCEDURE BARS.ARMS_GRANT_RESOURCE 

( CODEAPP_ VARCHAR2, RES_TYPE NUMBER, RES_ID VARCHAR2 ) IS

  -- RES_TYPE=1 - reference
  -- RES_TYPE=2 - functions

  NUM_  NUMBER;
  CID	INTEGER;
  LOSECURE_	INTEGER;
  I     BINARY_INTEGER := 0;
  ROLENAME_      VARCHAR2(50);

CURSOR ARM_USERS IS
  SELECT DISTINCT A.LOGNAME
    FROM STAFF A, APPLIST_STAFF B
	WHERE A.ID=B.ID AND B.CODEAPP=CODEAPP_
	      AND decode(LOSECURE_, 1, nvl(b.approve,0), LOSECURE_) = LOSECURE_;

TYPE   TUSER_TAB IS TABLE OF ARM_USERS%ROWTYPE INDEX BY BINARY_INTEGER;
USERS_ TUSER_TAB;

BEGIN

   BEGIN
        SELECT decode(val,'1','0','1') INTO LOSECURE_ FROM params WHERE par='LOSECURE';
   EXCEPTION
      WHEN NO_DATA_FOUND  THEN LOSECURE_ := 1;
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
   dbms_output.put_line('Rolename = '||ROLENAME_);

   IF RES_TYPE=1 THEN
      SELECT count(*) INTO NUM_
      FROM REFAPP A,  REFERENCES B
      WHERE   A.TABID=B.TABID AND A.CODEAPP=CODEAPP_ AND
              UPPER(B.role2edit) = ROLENAME_ AND A.TABID <> to_number(RES_ID)
              AND decode(LOSECURE_, 1, nvl(approve,0), LOSECURE_) = LOSECURE_;
   END IF;

   IF RES_TYPE=2 THEN
      SELECT count(*) INTO NUM_
      FROM   OPERAPP A,  OPERLIST B
      WHERE  A.CODEOPER=B.CODEOPER AND A.CODEAPP=CODEAPP_ AND
             UPPER(B.ROLENAME)=ROLENAME_ AND A.codeoper<>to_number(RES_ID)
             AND decode(LOSECURE_, 1, nvl(approve,0), LOSECURE_) = LOSECURE_;
   END IF;



   --√–¿Õ“»“‹ Õ”ÕŒ (Õ≈ –¿«¡»–¿ﬂ—‹, ¿ ≈—“‹ À» ŒÕ¿ ” œŒÀ‹«Œ¬¿“≈Àﬂ ”∆≈ ¬ ƒ–”√ŒÃ ¿–ÃÂ)

    dbms_output.put_line('NUM_= '||NUM_);
    IF NUM_=0 THEN
       dbms_output.put_line('NUM_=0 ');
       FOR C1 IN ARM_USERS LOOP
          I := I + 1;
          USERS_(I) := C1;
       END LOOP;

     --√–¿Õ“»Ã
       FOR I IN 1 .. USERS_.COUNT LOOP
         BEGIN
           CID := DBMS_SQL.OPEN_CURSOR;
           DBMS_SQL.PARSE(CID, 'GRANT ' || ROLENAME_ || ' TO ' || USERS_(I).LOGNAME, DBMS_SQL.V7);
   	   dbms_output.put_line('grant '||ROLENAME_|| ' TO ' || USERS_(I).LOGNAME);
           DBMS_SQL.CLOSE_CURSOR( CID );
           EXCEPTION
              WHEN OTHERS THEN NULL;
         END;
       END LOOP;
    END IF;
END;

 
/
show err;

PROMPT *** Create  grants  ARMS_GRANT_RESOURCE ***
grant EXECUTE                                                                on ARMS_GRANT_RESOURCE to ABS_ADMIN;
grant EXECUTE                                                                on ARMS_GRANT_RESOURCE to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on ARMS_GRANT_RESOURCE to START1;
grant EXECUTE                                                                on ARMS_GRANT_RESOURCE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/ARMS_GRANT_RESOURCE.sql =========*
PROMPT ===================================================================================== 
