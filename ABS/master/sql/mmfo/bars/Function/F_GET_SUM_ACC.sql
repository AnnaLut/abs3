CREATE OR REPLACE FUNCTION BARS.F_GET_SUM_ACC (NLS_ VARCHAR2)  RETURN NUMBER
IS
       FACT_OST number;
       
BEGIN
        select ostc into FACT_OST from accounts where nls = NLS_ and KV = 980; 
return FACT_OST;
END;
/



grant execute on F_GET_SUM_ACC to bars_Access_defrole;

