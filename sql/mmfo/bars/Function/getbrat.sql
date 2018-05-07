prompt function/getbrat.sql
 
  CREATE OR REPLACE FUNCTION BARS.GETBRAT (dat_ DATE,nb_ SMALLINT,kv_ SMALLINT,s_ SMALLINT)
RETURN NUMBER IS
br_ NUMBER;
 CURSOR C0 IS
    SELECT t.rate,t.s,b.br_type
      FROM br_tier t,brates b
     WHERE t.br_id=b.br_id AND t.br_id=nb_ AND t.kv=kv_ AND
           t.bdate=(SELECT MAX(bdate)
                      FROM  br_tier
                     WHERE bdate<=dat_ AND br_id=nb_ AND kv=kv_)
            ORDER BY s;
BEGIN
   br_ := 0;
   BEGIN
     SELECT rate INTO br_
       FROM br_normal
      WHERE br_id=nb_ AND kv=kv_ AND
            bdate=(SELECT MAX(bdate) FROM br_normal
                  WHERE bdate<=dat_ AND br_id=nb_ AND kv=kv_);
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         FOR tie IN C0 LOOP
             br_ := tie.rate;
/*2*/        EXIT WHEN tie.s >= s_;
/*3*/
         END LOOP;
   END;
--   deb.trace(111,'br_',br_);
   RETURN br_;
END getbrat;

 
/
 show err;
 
PROMPT *** Create  grants  GETBRAT ***
grant EXECUTE                                                                on GETBRAT         to ABS_ADMIN;
grant EXECUTE                                                                on GETBRAT         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GETBRAT         to CC_DOC;
grant EXECUTE                                                                on GETBRAT         to DPT;
grant EXECUTE                                                                on GETBRAT         to DPT_ROLE;
grant EXECUTE                                                                on GETBRAT         to WR_ALL_RIGHTS;
grant EXECUTE                                                                on GETBRAT         to BARS_INTGR;

