

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/VERIFY_ALIEN.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure VERIFY_ALIEN ***

  CREATE OR REPLACE PROCEDURE BARS.VERIFY_ALIEN (acc_ IN  NUMBER,
                                          sab_ IN  CHAR,
                                          fl_  OUT NUMBER) IS
--Ver 3.1.1.2 2009/05/19/05/
  ern CONSTANT POSITIVE := 223; -- Cannot obtain verify_alien
begin
  SELECT 1
  INTO   fl_
  FROM   customer c,
         accounts a
  WHERE  acc_=a.acc  AND
         a.rnk=c.rnk AND
         UPPER(c.sab)=sab_;
EXCEPTION WHEN TOO_MANY_ROWS THEN
  fl_ := 1;
          WHEN NO_DATA_FOUND THEN
  begin
    select 1
    INTO   fl_
    from   accounts a,
           klp_top  k,
           customer c
    where  a.acc=acc_   and
           k.rnk=a.rnk  and
           c.rnk=k.rnkp and
           UPPER(c.sab)=sab_;
  EXCEPTION WHEN TOO_MANY_ROWS THEN
    fl_ := 1;
            WHEN NO_DATA_FOUND THEN
    fl_ := 0;
            WHEN OTHERS THEN
    raise_application_error(-(20000+ern),SQLERRM,TRUE);
  end;
          WHEN OTHERS THEN
  raise_application_error(-(20000+ern),SQLERRM,TRUE);
end verify_alien;
/
show err;

PROMPT *** Create  grants  VERIFY_ALIEN ***
grant EXECUTE                                                                on VERIFY_ALIEN    to ABS_ADMIN;
grant EXECUTE                                                                on VERIFY_ALIEN    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on VERIFY_ALIEN    to TECH_MOM1;
grant EXECUTE                                                                on VERIFY_ALIEN    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/VERIFY_ALIEN.sql =========*** End 
PROMPT ===================================================================================== 
