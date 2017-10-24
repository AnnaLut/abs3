
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fldlevel.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FLDLEVEL (appid_ INTEGER)
RETURN INTEGER
IS
cod_    INTEGER;
cur_    INTEGER;
max_    INTEGER;
CURSOR  Branches_ IS
       SELECT codeoper FROM operlist WHERE parentid=appid_;
BEGIN
    SELECT count(*) INTO cur_ FROM operlist WHERE parentid=appid_;
    IF cur_ IS NULL THEN
       cur_ := 0;
    END IF;
    IF cur_=0 THEN
       RETURN 0;
    ELSE
       max_ := 0;
       OPEN Branches_;
       LOOP
            FETCH Branches_ INTO cod_;
            EXIT WHEN Branches_%NotFound;

            cur_ := fldlevel(cod_);
            IF cur_ > max_ THEN
                max_ := cur_;
            END IF;
       END LOOP;

       CLOSE Branches_;

       RETURN max_+1;
    END IF;
END;
/
 show err;
 
PROMPT *** Create  grants  FLDLEVEL ***
grant EXECUTE                                                                on FLDLEVEL        to ABS_ADMIN;
grant EXECUTE                                                                on FLDLEVEL        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FLDLEVEL        to START1;
grant EXECUTE                                                                on FLDLEVEL        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fldlevel.sql =========*** End *** =
 PROMPT ===================================================================================== 
 