
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_tagsum.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_TAGSUM (Rnk_ number, Tag_ varchar2, Dat1_ date, Dat2_ date)
RETURN varchar2 IS
  s_ number;
  sTmp_	varchar2(2000);
BEGIN
  sTmp_ := '';
  BEGIN
    SELECT nvl(count(distinct a.acc),0) INTO s_
    FROM accounts a, cust_acc b
    WHERE a.acc=b.acc AND b.rnk=Rnk_ AND a.dapp is not null ;
  EXCEPTION WHEN NO_DATA_FOUND THEN
    s_ := 0 ;
  END;
  IF s_ = 0 THEN
    BEGIN
      SELECT nvl(sum(to_number(value)),0) INTO s_ FROM customerw
      WHERE rnk=Rnk_ AND trim(tag)=trim(Tag_) ;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      s_ := 0 ;
    END;
    IF substr(Tag_,1,4) = 'COUN' THEN
      sTmp_ := to_char(s_) ;
    ELSIF substr(Tag_,1,3) = 'SUM' THEN
      sTmp_ := to_char(s_, '99999999999990D99') ;
    END IF;
  ELSE
    IF substr(Tag_,1,4) = 'COUN' THEN
      BEGIN
        SELECT count(o.ref) INTO s_ FROM opldok o, cust_acc b
        WHERE o.acc=b.acc and b.rnk=Rnk_ AND o.sos=5 AND
              o.fdat>=Dat1_ AND o.fdat<=Dat2_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
        s_ := 0 ;
      END;
      sTmp_ := to_char(s_) ;
    ELSIF substr(Tag_,1,3) = 'SUM' THEN
      BEGIN
        SELECT nvl(sum(gl.p_icurval(a.kv,o.s,o.fdat)),0)/100 INTO s_
        FROM opldok o, cust_acc b, accounts a
        WHERE o.acc=b.acc and b.rnk=Rnk_ AND o.sos=5 AND o.acc=a.acc AND
              o.fdat>=Dat1_ AND o.fdat<=Dat2_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
        s_ := 0 ;
      END;
      sTmp_ := to_char(s_, '99999999999990D99') ;
    END IF;
  END IF;
  RETURN sTmp_;
END f_tagsum;
/
 show err;
 
PROMPT *** Create  grants  F_TAGSUM ***
grant EXECUTE                                                                on F_TAGSUM        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_tagsum.sql =========*** End *** =
 PROMPT ===================================================================================== 
 