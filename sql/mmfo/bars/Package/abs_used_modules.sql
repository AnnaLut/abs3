
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/abs_used_modules.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.ABS_USED_MODULES 
IS
  core_version  constant pls_integer := 2016;  -- ABS current core version
  core_release  constant pls_integer := 57;    -- ABS current core release

  fin_mon       constant boolean     := true;
  fin_mon_ver   constant pls_integer := 1;

END ABS_USED_MODULES;
/

 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/abs_used_modules.sql =========*** En
 PROMPT ===================================================================================== 
 