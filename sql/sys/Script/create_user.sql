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
-- Grant/Revoke system privileges 
grant create job to BARSTRANS;
grant create procedure to BARSTRANS;
grant create sequence to BARSTRANS;
grant create table to BARSTRANS;
grant create type to BARSTRANS;
grant create view to BARSTRANS; 
grant debug connect session to BARSTRANS;
grant unlimited tablespace to BARSTRANS;
GRANT EXECUTE ON SYS.DBMS_CRYPTO TO BARSTRANS;
/

 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/create_user.sql =========*** 
 PROMPT ===================================================================================== 