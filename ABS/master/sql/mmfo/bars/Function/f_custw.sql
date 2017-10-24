
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_custw.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CUSTW (rnk_ number, tag_ varchar2)
RETURN varchar2 IS
nByIsp_ number;
nCount_ number;
sTmp_	varchar2(2000);
BEGIN
  SELECT nvl(byisp,0) INTO nByIsp_ FROM customer_field
  WHERE trim(tag)=trim(tag_) ;

  SELECT count(tag) INTO nCount_ FROM customerw
  WHERE rnk=rnk_ AND trim(tag)=trim(tag_) AND
        isp in (select min(otd) from otd_user
                where userid=user_id and nvl(pr,0)=1);
  IF nCount_ = 0 THEN
    nByIsp_ := 0 ;
  END IF;

  sTmp_ := '';

  IF nByIsp_ = 1 THEN
    BEGIN
      SELECT value INTO sTmp_ FROM customerw
      WHERE rnk=rnk_ AND trim(tag)=trim(tag_) AND
            isp in (select min(otd) from otd_user
                    where userid=user_id and nvl(pr,0)=1) ;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      sTmp_ := '' ;
    END;
  ELSE
    FOR k IN (SELECT value FROM customerw
              WHERE rnk=rnk_ AND trim(tag)=trim(tag_))
    LOOP
      sTmp_ := sTmp_ || rpad(k.value,250,' ') ;
    END LOOP;
  END IF;
  return rpad(Trim(sTmp_),2000,' ');
END f_custw;
 
/
 show err;
 
PROMPT *** Create  grants  F_CUSTW ***
grant EXECUTE                                                                on F_CUSTW         to BARSDWH_ACCESS_USER;
grant EXECUTE                                                                on F_CUSTW         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_CUSTW         to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_custw.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 