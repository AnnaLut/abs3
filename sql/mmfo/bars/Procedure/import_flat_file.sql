

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/IMPORT_FLAT_FILE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure IMPORT_FLAT_FILE ***

  CREATE OR REPLACE PROCEDURE BARS.IMPORT_FLAT_FILE (p_clob clob)
 as language java name 'ImportFile.importf(oracle.sql.CLOB)';
/
show err;

PROMPT *** Create  grants  IMPORT_FLAT_FILE ***
grant EXECUTE                                                        on IMPORT_FLAT_FILE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/IMPORT_FLAT_FILE.sql =========*** 
PROMPT ===================================================================================== 
