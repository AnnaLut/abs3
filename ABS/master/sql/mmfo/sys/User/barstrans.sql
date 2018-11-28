 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/sys/Script/create_user.sql =========*** 
 PROMPT ===================================================================================== 

DECLARE
  my_user     VARCHAR2(30) := 'BARSTRANS';
  my_password VARCHAR2(9) := 'barstrans';
BEGIN
  EXECUTE IMMEDIATE 'CREATE USER ' || my_user || ' IDENTIFIED BY ' ||
                    my_password;
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE = -1920 THEN
      NULL;
    ELSE
      RAISE;
    END IF;
END;
/
-- Grant/Revoke role privileges 
grant bars_access_defrole to BARSTRANS;
grant connect to BARSTRANS;
GRANT SCHEDULER_ADMIN TO BARSTRANS WITH ADMIN OPTION;
ALTER USER BARSTRANS DEFAULT ROLE ALL;
-- Grant/Revoke system privileges 
grant create job to BARSTRANS;
GRANT CREATE MATERIALIZED VIEW TO BARSTRANS;
grant create procedure to BARSTRANS;
grant create sequence to BARSTRANS;
GRANT CREATE TRIGGER TO BARSTRANS;
GRANT CREATE SESSION TO BARSTRANS;
grant create table to BARSTRANS;
grant create type to BARSTRANS;
grant create view to BARSTRANS;
GRANT DEBUG ANY PROCEDURE TO BARSTRANS; 
grant debug connect session to BARSTRANS;
GRANT MANAGE SCHEDULER TO BARSTRANS;
grant unlimited tablespace to BARSTRANS;
GRANT EXECUTE ON SYS.DBMS_CRYPTO TO BARSTRANS;
GRANT EXECUTE, DEBUG ON BARS.BARS_AUDIT TO BARSTRANS;
GRANT EXECUTE, DEBUG ON BARS.BARS_CONTEXT TO BARSTRANS;
GRANT EXECUTE, DEBUG ON BARS.BARS_LOGIN TO BARSTRANS;
GRANT EXECUTE, DEBUG ON BARS.BRANCH_ATTRIBUTE_UTL TO BARSTRANS WITH GRANT OPTION;
GRANT EXECUTE ON BARS.F_OURMFO TO BARSTRANS;
GRANT EXECUTE, DEBUG ON BARS.LIST_UTL TO BARSTRANS WITH GRANT OPTION;
GRANT EXECUTE, DEBUG ON BARS.LOB_UTL TO BARSTRANS WITH GRANT OPTION;
GRANT EXECUTE, DEBUG ON BARS.NUMBER_LIST TO BARSTRANS;
GRANT EXECUTE, DEBUG ON BARS.OW_BATCH_OPENING TO BARSTRANS;
GRANT EXECUTE, DEBUG ON BARS.STRING_LIST TO BARSTRANS;
GRANT EXECUTE, DEBUG ON BARS.TOOLS TO BARSTRANS WITH GRANT OPTION;
GRANT EXECUTE ON BARS.USER_ID TO BARSTRANS;
GRANT SELECT ON BARS.WEB_BARSCONFIG TO BARSTRANS;
GRANT EXECUTE, DEBUG ON BARS.WSM_MGR TO BARSTRANS;
/

 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/create_user.sql =========*** 
 PROMPT ===================================================================================== 