CREATE OR REPLACE FUNCTION BARS.F_NEWNLS 
( ACC2_      int
, descrname_ varchar2
, nbs_       char
) return number
IS
begin
  return F_NEWNLS2( ACC2_, descrname_, nbs_, null, null );
END F_NEWNLS;
/

show err;

grant EXECUTE on F_NEWNLS to ABS_ADMIN;
grant EXECUTE on F_NEWNLS to BARS_ACCESS_DEFROLE;
grant EXECUTE on F_NEWNLS to CUST001;
grant EXECUTE on F_NEWNLS to DEP_SKRN;
grant EXECUTE on F_NEWNLS to START1;
grant EXECUTE on F_NEWNLS to WR_ALL_RIGHTS;
