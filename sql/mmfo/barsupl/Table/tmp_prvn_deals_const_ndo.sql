
PROMPT ========================================================================================= 
PROMPT *** Run *** == Scripts /Sql/BARSUPL/Table/TMP_PRVN_DEALS_CONST_NDO.sql =*** Run *** =====
PROMPT ========================================================================================= 
-- ***************************************************************************
-- ETL-24849      UPL - Исключить из выгрузки механизм упреждающей выгрузки отсутствующих полей для файлов CREDKZ, PRVN_DEALS_KL
-- COBUMMFO-8179  Для ММФО та Міленіум. Просимо відключити механізм опрацювання відсутності полей NDG і NDO при формуванні вивантаження файлів CREDKZ, PRVN_DEALS_KL
-- ***************************************************************************
-- пока поля PRVN_FLOW_DEALS_CONST.NDO нет в таблице, используем TEMPORARY TABLE для выгрузки

/*
PROMPT *** Create  global temporary table TMP_PRVN_DEALS_CONST_NDO ***
begin
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARSUPL.TMP_PRVN_DEALS_CONST_NDO
                    ( ID          NUMBER,
                      ND          NUMBER,
                      NDO         NUMBER,
                      KF          VARCHAR2(6)
                    ) ON COMMIT PRESERVE ROWS';
exception when others then
  if sqlcode=-955 then null; else raise; end if;
end;
/
*/

begin
  execute immediate 'drop table BARSUPL.TMP_PRVN_DEALS_CONST_NDO';
exception when others then
  if sqlcode=-942 then null; else raise; end if;
end;
/


PROMPT ========================================================================================= 
PROMPT *** End *** == Scripts /Sql/BARSUPL/Table/TMP_PRVN_DEALS_CONST_NDO.sql =*** End *** =====
PROMPT ========================================================================================= 
