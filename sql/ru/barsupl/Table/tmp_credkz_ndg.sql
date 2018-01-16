

PROMPT ===================================================================================== 
PROMPT *** Run *** ===== Scripts /Sql/BARSUPL/Table/TMP_CREDKZ_NDG.sql ====*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  global temporary table TMP_CREDKZ_NDG ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARSUPL.TMP_CREDKZ_NDG
                    ( IDUPD       NUMBER,
                      NDG         NUMBER,
                      KF          VARCHAR2(6)
                    ) ON COMMIT PRESERVE ROWS';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT ===================================================================================== 
PROMPT *** End *** ===== Scripts /Sql/BARSUPL/Table/TMP_CREDKZ_NDG.sql ====*** End *** =====
PROMPT ===================================================================================== 
