
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/CDB/package/cdb_exception.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE CDB.CDB_EXCEPTION is
    GENERAL_EXCEPTION              constant integer := -20000;
    NO_DATA_FOUND                  constant integer := -20001;
    HAVE_TO_WAIT_FOR_BARS          constant integer := -20002;
    CHECK_CLAIM_EXCEPTION          constant integer := -20003;
end;
/

 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/CDB/package/cdb_exception.sql =========*** End **
 PROMPT ===================================================================================== 
 