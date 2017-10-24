

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/USR_GRANT_ARM.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure USR_GRANT_ARM ***

  CREATE OR REPLACE PROCEDURE BARS.USR_GRANT_ARM ( user_id_ NUMBER, arm_ VARCHAR2 ) IS
-- Грантит права пользователю для данного АРМ-а

user_logname_  VARCHAR2(50);
secure_  INTEGER;
CID	     INTEGER;

CURSOR ARM_ROLES IS
 SELECT rolename FROM
    -- роли для функций в АРМ-е
    (SELECT unique UPPER(l.rolename) rolename  FROM operlist l, operapp a
     WHERE l.codeoper=a.codeoper AND a.codeapp=arm_
           AND l.rolename is NOT NULL
     UNION
    -- роли для справочников в АРМ-е
     SELECT unique UPPER(role2edit)  FROM references r, refapp a
     WHERE r.tabid=a.tabid AND a.codeapp=arm_
           AND role2edit is NOT NULL) A
 WHERE  rolename NOT IN
    -- если такая роль уже есть в функе или справочнике, которой(которым)
    -- обладает пользователь
  (   SELECT unique  UPPER(rolename)  rol
      FROM operlist l, operapp a, applist_staff s
      WHERE decode(secure_,0,secure_,nvl(s.approve,0) )=secure_
            AND l.codeoper=a.codeoper
            AND s.codeapp=a.codeapp
            AND decode(secure_,0,secure_,nvl(a.approve,0) )=secure_
      AND s.id=user_id_ AND rolename is NOT NULL AND a.codeapp<>arm_
      UNION
      SELECT unique UPPER(role2edit)
      FROM references r, refapp a,  applist_staff s
      WHERE r.tabid=a.tabid
            AND decode(secure_,0,secure_,nvl(a.approve,0) )=secure_
            AND decode(secure_,0,secure_,nvl(s.approve,0) )=secure_
      AND s.codeapp=a.codeapp AND role2edit is NOT NULL AND a.codeapp<>arm_
      AND s.id=user_id_
  );

BEGIN

  SELECT logname INTO user_logname_ FROM staff WHERE id=user_id_;
  BEGIN
     SELECT decode(val,0, 1, 0)  INTO secure_  FROM params WHERE par='LOSECURE';
  EXCEPTION
      WHEN NO_DATA_FOUND THEN
           secure_:= 1;     -- enhanced secure level
  END;

  FOR C IN ARM_ROLES LOOP
    BEGIN
        CID := DBMS_SQL.OPEN_CURSOR;
        dbms_output.put_line('GRANT ' || c.rolename || ' TO ' || user_logname_);
		DBMS_SQL.PARSE(CID, 'GRANT ' || c.rolename || ' TO ' || user_logname_, DBMS_SQL.V7);
        DBMS_SQL.CLOSE_CURSOR( CID );
	  EXCEPTION
	    WHEN OTHERS THEN NULL;
	  END;
  END LOOP;
END;

 
/
show err;

PROMPT *** Create  grants  USR_GRANT_ARM ***
grant EXECUTE                                                                on USR_GRANT_ARM   to ABS_ADMIN;
grant EXECUTE                                                                on USR_GRANT_ARM   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on USR_GRANT_ARM   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/USR_GRANT_ARM.sql =========*** End
PROMPT ===================================================================================== 
