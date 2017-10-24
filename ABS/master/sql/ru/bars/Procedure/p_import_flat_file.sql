prompt ------------------------------------------
prompt  создание процедуры IMPORT_FLAT_FILE
prompt ------------------------------------------
/
CREATE OR REPLACE procedure BARS.import_flat_file(p_clob clob)
 as language java name 'ImportFile.importf(oracle.sql.CLOB)';
/
grant execute on BARS.import_flat_file to bars_access_defrole;
/
