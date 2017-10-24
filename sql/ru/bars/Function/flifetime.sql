
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/flifetime.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FLIFETIME (logname_ in varchar2) RETURN NUMBER IS
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
         select to_number(limit)
         into   limit_
         FROM   dba_profiles
         WHERE  resource_name='PASSWORD_LIFE_TIME' and profile=profile_;
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
 
PROMPT *** Create  grants  FLIFETIME ***
grant EXECUTE                                                                on FLIFETIME       to ABS_ADMIN;
grant EXECUTE                                                                on FLIFETIME       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FLIFETIME       to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/flifetime.sql =========*** End *** 
 PROMPT ===================================================================================== 
 