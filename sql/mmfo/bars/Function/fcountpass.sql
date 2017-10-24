
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fcountpass.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FCOUNTPASS (logname_ in varchar2) RETURN NUMBER IS
   profile_  dba_users.profile%type;
   limit_    number;
BEGIN
   BEGIN
      SELECT profile
      INTO   profile_
      FROM   dba_users
      WHERE  username=logname_;
--    if profile_ like 'PF$%' then
      begin
         select to_number(limit)/2
         into   limit_
         FROM   dba_profiles
         WHERE  resource_name='FAILED_LOGIN_ATTEMPTS' and profile=profile_;
      EXCEPTION WHEN OTHERS THEN
         return null;
      end;
      return limit_;
--    else
--       return null;
--    end if;
   end;
END;
 
/
 show err;
 
PROMPT *** Create  grants  FCOUNTPASS ***
grant EXECUTE                                                                on FCOUNTPASS      to ABS_ADMIN;
grant EXECUTE                                                                on FCOUNTPASS      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FCOUNTPASS      to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fcountpass.sql =========*** End ***
 PROMPT ===================================================================================== 
 