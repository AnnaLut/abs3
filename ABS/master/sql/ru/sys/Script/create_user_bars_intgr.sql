

DECLARE
  my_user     VARCHAR2(30) := 'BARS_INTGR';
  my_password VARCHAR2(15) := 'bars_intgr';
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
grant bars_access_defrole to BARS_INTGR;
grant connect to BARS_INTGR;
-- Grant/Revoke system privileges 
grant create job to BARS_INTGR;
grant create procedure to BARS_INTGR;
grant create sequence to BARS_INTGR;
grant create table to BARS_INTGR;
grant create type to BARS_INTGR;
grant create view to BARS_INTGR; 
grant create table to BARS_INTGR;
grant create trigger to BARS_INTGR;
grant create materialized view to BARS_INTGR;
grant debug connect session to BARS_INTGR;
GRANT EXECUTE ON SYS.DBMS_CRYPTO TO BARS_INTGR;
/
