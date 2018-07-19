
PROMPT ===================================================================================== 
PROMPT *** Run *** ===== Scripts /Sql/BARSUPL/Table/TMP_CREDKZ_NDG.sql ====*** Run *** =====
PROMPT ===================================================================================== 
-- ***************************************************************************
-- ETL-24849      UPL - Исключить из выгрузки механизм упреждающей выгрузки отсутствующих полей для файлов CREDKZ, PRVN_DEALS_KL
-- COBUMMFO-8179  Для ММФО та Міленіум. Просимо відключити механізм опрацювання відсутності полей NDG і NDO при формуванні вивантаження файлів CREDKZ, PRVN_DEALS_KL
-- ***************************************************************************

/*
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
*/

begin
  execute immediate 'drop table BARSUPL.TMP_CREDKZ_NDG';
exception when others then
  if sqlcode=-942 then null; else raise; end if;
end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ===== Scripts /Sql/BARSUPL/Table/TMP_CREDKZ_NDG.sql ====*** End *** =====
PROMPT ===================================================================================== 