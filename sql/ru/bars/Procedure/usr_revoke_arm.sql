

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/USR_REVOKE_ARM.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure USR_REVOKE_ARM ***

  CREATE OR REPLACE PROCEDURE BARS.USR_REVOKE_ARM ( user_id_ NUMBER, arm_ VARCHAR2 ) IS
-- Отбирает права у пользователя для данного АРМ-а

user_logname_  VARCHAR2(50);
secure_  INTEGER;
CID	     INTEGER;

-- cursor for low security
CURSOR ARM_ROLES_LSEC IS
 SELECT rolename FROM
    -- роли для функций в АРМ-е
    (SELECT unique UPPER(l.rolename) rolename  FROM operlist l, operapp a
     WHERE l.codeoper=a.codeoper AND a.codeapp=arm_  AND l.rolename is NOT NULL
     UNION
    -- роли для справочников в АРМ-е
     SELECT unique UPPER(role2edit)  FROM references r, refapp a
     WHERE r.tabid=a.tabid AND a.codeapp=arm_ AND role2edit is NOT NULL) A
 WHERE  rolename NOT IN
    -- и этой роли нету в никаких других функах и справочниках
  (   SELECT unique  UPPER(rolename)  rol
      FROM operlist l, operapp a, applist_staff s
      WHERE l.codeoper=a.codeoper AND s.codeapp=a.codeapp
            AND s.id=user_id_ AND rolename is NOT NULL  AND a.codeapp<>arm_
      UNION
      SELECT unique UPPER(role2edit)
      FROM references r, refapp a,  applist_staff s
      WHERE r.tabid=a.tabid AND s.codeapp=a.codeapp AND role2edit is NOT NULL
           AND s.id=user_id_ AND a.codeapp<>arm_
  );

-- cursor for hight security
CURSOR ARM_ROLES_HSEC IS
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
    -- и этой роли нету в никаких других функах и справочниках
  (   SELECT unique  UPPER(rolename)  rol
      FROM operlist l, operapp a, applist_staff s
      WHERE s.approve = 1  AND l.codeoper=a.codeoper   AND s.codeapp=a.codeapp
            AND a.approve = 1  AND s.id=user_id_ AND rolename is NOT NULL
            AND a.codeapp<>arm_
      UNION
      SELECT unique UPPER(role2edit)
      FROM references r, refapp a,  applist_staff s
      WHERE r.tabid=a.tabid AND a.approve=1 AND s.approve = 1
           AND s.codeapp=a.codeapp AND role2edit is NOT NULL
           AND s.id=user_id_ AND a.codeapp<>arm_
  );

BEGIN

  SELECT logname INTO user_logname_ FROM staff WHERE id=user_id_;

  dbms_output.put_line('user_id_ = '|| user_id_);

  BEGIN
     SELECT val INTO secure_  FROM params WHERE par='LOSECURE';
  EXCEPTION
      WHEN NO_DATA_FOUND THEN
           secure_:= 0;     -- enhanced secure level
  END;

  dbms_output.put_line('sec level= '||secure_);

  IF secure_=0 THEN   -- hight security
     FOR C IN ARM_ROLES_HSEC LOOP
     BEGIN
        CID := DBMS_SQL.OPEN_CURSOR;
        dbms_output.put_line('REVOKE ' || c.rolename || ' FORM ' || user_logname_);
		DBMS_SQL.PARSE(CID, 'REVOKE ' || c.rolename || ' FROM ' || user_logname_, DBMS_SQL.V7);
        DBMS_SQL.CLOSE_CURSOR( CID );
	  EXCEPTION
	    WHEN OTHERS THEN NULL;
	  END;
      END LOOP;
  END IF;

  IF secure_=1 THEN -- low security
     FOR C IN ARM_ROLES_LSEC LOOP
     BEGIN
        CID := DBMS_SQL.OPEN_CURSOR;
        dbms_output.put_line('REVOKE ' || c.rolename || ' FORM ' || user_logname_);
		DBMS_SQL.PARSE(CID, 'REVOKE ' || c.rolename || ' FROM ' || user_logname_, DBMS_SQL.V7);
        DBMS_SQL.CLOSE_CURSOR( CID );
	  EXCEPTION
	    WHEN OTHERS THEN NULL;
	  END;
      END LOOP;
  END IF;

END;
/
show err;

PROMPT *** Create  grants  USR_REVOKE_ARM ***
grant EXECUTE                                                                on USR_REVOKE_ARM  to ABS_ADMIN;
grant EXECUTE                                                                on USR_REVOKE_ARM  to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on USR_REVOKE_ARM  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/USR_REVOKE_ARM.sql =========*** En
PROMPT ===================================================================================== 
