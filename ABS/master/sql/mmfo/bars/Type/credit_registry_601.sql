CREATE OR REPLACE TYPE credit_registry_601  IS OBJECT(
okpo VARCHAR2(14),
rnk number(38),
nd  number(30),
kv  varchar2(3),
sum_all number(32),
kf  varchar2(6 char),
MAP MEMBER FUNCTION data_map RETURN NUMBER)
/

CREATE OR REPLACE TYPE BODY credit_registry_601
IS
   MAP MEMBER FUNCTION data_map RETURN NUMBER
   IS
   BEGIN
      RETURN OKPO||rnk||nd||kv||sum_all||kf;
   END;
END;
/