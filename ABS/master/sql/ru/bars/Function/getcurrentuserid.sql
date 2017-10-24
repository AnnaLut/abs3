
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/getcurrentuserid.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GETCURRENTUSERID return number is
begin
  return gl.auid;
end;
/
 show err;
 
PROMPT *** Create  grants  GETCURRENTUSERID ***
grant EXECUTE                                                                on GETCURRENTUSERID to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GETCURRENTUSERID to WR_ALL_RIGHTS;
grant EXECUTE                                                                on GETCURRENTUSERID to WR_CHCKINNR_ALL;
grant EXECUTE                                                                on GETCURRENTUSERID to WR_CHCKINNR_SELF;
grant EXECUTE                                                                on GETCURRENTUSERID to WR_CUSTREG;
grant EXECUTE                                                                on GETCURRENTUSERID to WR_TOBO_ACCOUNTS_LIST;
grant EXECUTE                                                                on GETCURRENTUSERID to WR_USER_ACCOUNTS_LIST;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/getcurrentuserid.sql =========*** E
 PROMPT ===================================================================================== 
 