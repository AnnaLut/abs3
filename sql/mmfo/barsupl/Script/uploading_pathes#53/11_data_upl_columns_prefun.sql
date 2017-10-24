-- ================================================================================
-- Module : UPL
-- Date   : 11.01.2016
-- ================================================================================
-- Опис полів файлу вивантаження
-- ================================================================================


update barsupl.upl_columns set PREFUN = 'TRUNC_E2' where FILE_ID = 235 and COL_ID = 1 and COL_NAME='ND';
update barsupl.upl_columns set PREFUN = 'TRUNC_E2' where FILE_ID = 235 and COL_ID = 50 and COL_NAME='RNK';
update barsupl.upl_columns set PREFUN = 'TRUNC_E2' where FILE_ID = 236 and COL_ID = 1 and COL_NAME='ND';
update barsupl.upl_columns set PREFUN = 'TRUNC_E2' where FILE_ID = 236 and COL_ID = 2 and COL_NAME='REF';
update barsupl.upl_columns set PREFUN = 'TRUNC_E2' where FILE_ID = 350 and COL_ID = 2  and COL_NAME='ID';
update barsupl.upl_columns set PREFUN = 'TRUNC_E2' where FILE_ID = 350 and COL_ID = 11 and COL_NAME='INS_RNK';
update barsupl.upl_columns set PREFUN = 'TRUNC_E2' where FILE_ID = 350 and COL_ID = 21 and COL_NAME='RNK';
update barsupl.upl_columns set PREFUN = 'TRUNC_E2' where FILE_ID = 351 and COL_ID = 1 and COL_NAME='ID';
update barsupl.upl_columns set PREFUN = 'TRUNC_E2' where FILE_ID = 351 and COL_ID = 3 and COL_NAME='RNK';
update barsupl.upl_columns set PREFUN = 'TRUNC_E2' where FILE_ID = 355 and COL_ID = 2 and COL_NAME='DEAL_ID';
update barsupl.upl_columns set PREFUN = 'TRUNC_E2' where FILE_ID = 356 and COL_ID = 3 and COL_NAME='DEAL_ID';

update barsupl.upl_columns set PREFUN = 'TRUNC_E2' where FILE_ID = 139 and COL_ID = 1 and COL_NAME='ACC';