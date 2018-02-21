-- ***************************************************************************
set verify off
set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
define sfile_id = 568
define ssql_id  = 568,1568,2568,3568

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: &&sfile_id');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (&&sfile_id))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # &&ssql_id');
end;
/
-- ***************************************************************************
-- ETL-22184   UPL - upload new 11 columns to MIR.SRC_REZ_CR
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

declare l_clob clob;
begin
l_clob:= to_clob('select rez.FDAT, rez.RNK, rez.CUSTTYPE, rez.ACC, rez.KV, rez.NBS, rez.TIP, rez.NLS, rez.ND, rez.VIDD, rez.FIN, rez.FINP,
       rez.FINV, rez.VKR, rez.BV, rez.BVQ, rez.BV02, rez.BV02Q, rez.EAD, rez.EADQ, rez.IDF, rez.PD, rez.CR, rez.CRQ,
       rez.CR_LGD, rez.KOL, rez.FIN23, rez.CCF, rez.PAWN, rez.TIP_ZAL, rez.KPZ, rez.KL_351, rez.ZAL, rez.ZALQ, rez.ZAL_BV,
       rez.ZAL_BVQ, rez.LGD, rez.RZ, rez.TEXT, rez.NMK, rez.PRINSIDER, rez.COUNTRY, rez.ISE, rez.SDATE, rez.DATE_V,
       rez.WDATE, rez.S250, rez.ISTVAL, rez.RC, rez.RCQ, rez.FAKTOR, rez.K_FAKTOR, rez.K_DEFOLT, rez.DV, rez.FIN_KOR,
       rez.TIPA, rez.OVKR, rez.P_DEF, rez.OVD, rez.OPD, rez.KOL23, rez.KOL24, rez.KOL25, rez.KOL26, rez.KOL27, rez.KOL28,
       rez.KOL29, rez.FIN_Z, rez.PD_0, rez.CC_ID, rez.KOL17, rez.KOL31, rez.S180, rez.T4, rez.RPB, rez.GRP, rez.OB22,
       rez.KOL30, rez.S080, rez.S080_Z, rez.TIP_FIN, rez.DDD_6B,
       rez.KF, rez.LGD_LONG,
       rez.Z, rez.FIN_KOL, rez.RNK_SK, rez.FIN_SK, rez.FIN_PK, Z_GRP, FIN_GRP, FIN_GRP_KOR, FIN_RNK_KOR, FIN_RNK,
       OZ_165_NOT, DAT_165_NOT, OZ_166_NOT, DAT_166_NOT, OZ_165, DAT_165
from BARS.rez_cr rez,
       ( select MAX(TRUNC(ADD_MONTHS(dat, 1), ''MM'')) dat
           from BARS.REZ_PROTOCOL
          where dat < TO_DATE (:param1, ''dd/mm/yyyy'')
       ) d
where rez.fdat = d.dat');

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (568, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
   NULL, 'Кредитний ризик за активними банківськими операціями ММФО', '1.1');
end;
/


declare l_clob clob;
begin
l_clob:= to_clob('select rez.FDAT, rez.RNK, rez.CUSTTYPE, rez.ACC, rez.KV, rez.NBS, rez.TIP, rez.NLS, rez.ND, rez.VIDD, rez.FIN, rez.FINP,
       rez.FINV, rez.VKR, rez.BV, rez.BVQ, rez.BV02, rez.BV02Q, rez.EAD, rez.EADQ, rez.IDF, rez.PD, rez.CR, rez.CRQ,
       rez.CR_LGD, rez.KOL, rez.FIN23, rez.CCF, rez.PAWN, rez.TIP_ZAL, rez.KPZ, rez.KL_351, rez.ZAL, rez.ZALQ, rez.ZAL_BV,
       rez.ZAL_BVQ, rez.LGD, rez.RZ, rez.TEXT, rez.NMK, rez.PRINSIDER, rez.COUNTRY, rez.ISE, rez.SDATE, rez.DATE_V,
       rez.WDATE, rez.S250, rez.ISTVAL, rez.RC, rez.RCQ, rez.FAKTOR, rez.K_FAKTOR, rez.K_DEFOLT, rez.DV, rez.FIN_KOR,
       rez.TIPA, rez.OVKR, rez.P_DEF, rez.OVD, rez.OPD, rez.KOL23, rez.KOL24, rez.KOL25, rez.KOL26, rez.KOL27, rez.KOL28,
       rez.KOL29, rez.FIN_Z, rez.PD_0, rez.CC_ID, rez.KOL17, rez.KOL31, rez.S180, rez.T4, rez.RPB, rez.GRP, rez.OB22,
       rez.KOL30, rez.S080, rez.S080_Z, rez.TIP_FIN, rez.DDD_6B,
       rez.KF, rez.LGD_LONG,
       rez.Z, rez.FIN_KOL, rez.RNK_SK, rez.FIN_SK, rez.FIN_PK, Z_GRP, FIN_GRP, FIN_GRP_KOR, FIN_RNK_KOR, FIN_RNK,
       OZ_165_NOT, DAT_165_NOT, OZ_166_NOT, DAT_166_NOT, OZ_165, DAT_165
from BARS.rez_cr rez,
       ( select MAX(TRUNC(ADD_MONTHS(dat, 1), ''MM'')) dat
           from BARS.REZ_PROTOCOL
          where dat_bank = TO_DATE (:param1, ''dd/mm/yyyy'')
       ) d
where rez.fdat = d.dat');

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (1568, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
   NULL, 'Кредитний ризик за активними банківськими операціями ММФО', '1.1');
end;
/


declare l_clob clob;
begin
l_clob:= to_clob('select rez.FDAT, rez.RNK, rez.CUSTTYPE, rez.ACC, rez.KV, rez.NBS, rez.TIP, rez.NLS, rez.ND, rez.VIDD, rez.FIN, rez.FINP,
       rez.FINV, rez.VKR, rez.BV, rez.BVQ, rez.BV02, rez.BV02Q, rez.EAD, rez.EADQ, rez.IDF, rez.PD, rez.CR, rez.CRQ,
       rez.CR_LGD, rez.KOL, rez.FIN23, rez.CCF, rez.PAWN, rez.TIP_ZAL, rez.KPZ, rez.KL_351, rez.ZAL, rez.ZALQ, rez.ZAL_BV,
       rez.ZAL_BVQ, rez.LGD, rez.RZ, rez.TEXT, rez.NMK, rez.PRINSIDER, rez.COUNTRY, rez.ISE, rez.SDATE, rez.DATE_V,
       rez.WDATE, rez.S250, rez.ISTVAL, rez.RC, rez.RCQ, rez.FAKTOR, rez.K_FAKTOR, rez.K_DEFOLT, rez.DV, rez.FIN_KOR,
       rez.TIPA, rez.OVKR, rez.P_DEF, rez.OVD, rez.OPD, rez.KOL23, rez.KOL24, rez.KOL25, rez.KOL26, rez.KOL27, rez.KOL28,
       rez.KOL29, rez.FIN_Z, rez.PD_0, rez.CC_ID, rez.KOL17, rez.KOL31, rez.S180, rez.T4, rez.RPB, rez.GRP, rez.OB22,
       rez.KOL30, rez.S080, rez.S080_Z, rez.TIP_FIN, rez.DDD_6B,
       bars.gl.kf as KF, cast(null as number) as LGD_LONG,
       rez.Z, rez.FIN_KOL, rez.RNK_SK, rez.FIN_SK, rez.FIN_PK, Z_GRP, FIN_GRP, FIN_GRP_KOR, FIN_RNK_KOR, FIN_RNK,
       OZ_165_NOT, DAT_165_NOT, OZ_166_NOT, DAT_166_NOT, OZ_165, DAT_165
from BARS.rez_cr rez,
       ( select MAX(TRUNC(ADD_MONTHS(dat, 1), ''MM'')) dat
           from BARS.REZ_PROTOCOL
          where dat < TO_DATE (:param1, ''dd/mm/yyyy'')
       ) d
where rez.fdat = d.dat');

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (2568, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
   NULL, 'Кредитний ризик за активними банківськими операціями РУ', '1.1');
end;
/

declare l_clob clob;
begin
l_clob:= to_clob('select rez.FDAT, rez.RNK, rez.CUSTTYPE, rez.ACC, rez.KV, rez.NBS, rez.TIP, rez.NLS, rez.ND, rez.VIDD, rez.FIN, rez.FINP,
       rez.FINV, rez.VKR, rez.BV, rez.BVQ, rez.BV02, rez.BV02Q, rez.EAD, rez.EADQ, rez.IDF, rez.PD, rez.CR, rez.CRQ,
       rez.CR_LGD, rez.KOL, rez.FIN23, rez.CCF, rez.PAWN, rez.TIP_ZAL, rez.KPZ, rez.KL_351, rez.ZAL, rez.ZALQ, rez.ZAL_BV,
       rez.ZAL_BVQ, rez.LGD, rez.RZ, rez.TEXT, rez.NMK, rez.PRINSIDER, rez.COUNTRY, rez.ISE, rez.SDATE, rez.DATE_V,
       rez.WDATE, rez.S250, rez.ISTVAL, rez.RC, rez.RCQ, rez.FAKTOR, rez.K_FAKTOR, rez.K_DEFOLT, rez.DV, rez.FIN_KOR,
       rez.TIPA, rez.OVKR, rez.P_DEF, rez.OVD, rez.OPD, rez.KOL23, rez.KOL24, rez.KOL25, rez.KOL26, rez.KOL27, rez.KOL28,
       rez.KOL29, rez.FIN_Z, rez.PD_0, rez.CC_ID, rez.KOL17, rez.KOL31, rez.S180, rez.T4, rez.RPB, rez.GRP, rez.OB22,
       rez.KOL30, rez.S080, rez.S080_Z, rez.TIP_FIN, rez.DDD_6B,
       bars.gl.kf as KF, cast(null as number) as LGD_LONG,
       rez.Z, rez.FIN_KOL, rez.RNK_SK, rez.FIN_SK, rez.FIN_PK, Z_GRP, FIN_GRP, FIN_GRP_KOR, FIN_RNK_KOR, FIN_RNK,
       OZ_165_NOT, DAT_165_NOT, OZ_166_NOT, DAT_166_NOT, OZ_165, DAT_165
from BARS.rez_cr rez,
       ( select MAX(TRUNC(ADD_MONTHS(dat, 1), ''MM'')) dat
           from BARS.REZ_PROTOCOL
          where dat_bank = TO_DATE (:param1, ''dd/mm/yyyy'')
       ) d
where rez.fdat = d.dat');

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (3568, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
   NULL, 'Кредитний ризик за активними банківськими операціями РУ', '1.1');
end;
/

-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (&&sfile_id);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (&&sfile_id);

Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 1, 'FDAT', 'Звітна дата', 'DATE', 8, NULL, 'ddmmyyyy', 'Y', 'Y', NULL, NULL, '31.12.9999', 4, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 2, 'RNK', 'Код (номер) контрагента', 'NUMBER', 15, 0, NULL, 'Y', 'Y', NULL, NULL, '0', 2, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 3, 'CUSTTYPE', 'Тип контрагента', 'NUMBER', 1, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 4, 'ACC', 'Ун. номер рах.', 'NUMBER', 15, 0, NULL, 'Y', 'Y', NULL, NULL, '0', 3, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 5, 'KV', 'Код валюти', 'NUMBER', 3, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 6, 'NBS', 'Бал. рахунок', 'VARCHAR2', 4, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 7, 'TIP', 'Тип рахунку', 'CHAR', 3, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 8, 'NLS', 'Номер рахунку', 'VARCHAR2', 15, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 9, 'ND', 'Номер договору', 'NUMBER', 22, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 10, 'VIDD', 'Вид договору', 'NUMBER', 5, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 11, 'FIN', 'PD :Клас боржника, визначений на підставі оцінки фінансового стану', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 12, 'FINP', NULL, 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 13, 'FINV', NULL, 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 14, 'VKR', 'Внутренний кредитный рейтинг', 'VARCHAR2', 3, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 15, 'BV', 'BV - Балансова вартість (ном.)-SNA-SDI', 'NUMBER', 36, 12, '999999999999999999999990D009999999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 16, 'BVQ', 'BV - Балансова вартість (екв.)-SNA-SDI', 'NUMBER', 36, 12, '999999999999999999999990D009999999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 17, 'BV02', 'BV - Балансова вартість (ном.)по балансу', 'NUMBER', 36, 12, '999999999999999999999990D009999999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 18, 'BV02Q', 'BV - Балансова вартість (екв.)по балансу', 'NUMBER', 36, 12, '999999999999999999999990D009999999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 19, 'EAD', '(BV - SNA) - EAD(ном.) експозиція під риз-ком(EAD за акт.операц.,крім над.фін.зобов"язань/EAD*CCF за над. фін-вими зобов.) на дату оцінки', 'NUMBER', 36, 12, '999999999999999999999990D009999999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 20, 'EADQ', '(BVQ- SNAQ)- EAD(екв.) експозиція під риз-ком(EAD за акт.операц.,крім над.фін.зобов"язань/EAD*CCF за над. фін-вими зобов.) на дату оцінки', 'NUMBER', 36, 12, '999999999999999999999990D009999999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 21, 'IDF', 'Тип для определения PD', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 22, 'PD', 'PD :Вначення коефіцієнта PD, застосоване для визначення кредитного ризику', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 23, 'CR', 'CR :Резерв (ном.) - розмір кредитного ризику за активом', 'NUMBER', 36, 12, '999999999999999999999990D009999999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 24, 'CRQ', 'CR :Резерв (екв.) - розмір кредитного ризику за активом', 'NUMBER', 36, 12, '999999999999999999999990D009999999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 25, 'CR_LGD', NULL, 'NUMBER', 36, 12, '999999999999999999999990D009999999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 26, 'KOL', NULL, 'NUMBER', 22, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 27, 'FIN23', NULL, 'NUMBER', 22, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 28, 'CCF', NULL, 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 29, 'PAWN', 'LGD:Код виду забезпе-чення', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 30, 'TIP_ZAL', 'LGD:Тип забезпе-чення', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 31, 'KPZ', 'LGD:Коефіцієнт покриття забезпеченням', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 32, 'KL_351', 'Коефіцієнт ліквідності забезпечення', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 33, 'ZAL', 'LGD:Сума забез-печення (CV*k) ном.', 'NUMBER', 36, 12, '999999999999999999999990D009999999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 34, 'ZALQ', 'LGD:Сума забез-печення (CV*k) екв.', 'NUMBER', 36, 12, '999999999999999999999990D009999999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 35, 'ZAL_BV', 'LGD:Сума забез-печення (CV) ном.', 'NUMBER', 36, 12, '999999999999999999999990D009999999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 36, 'ZAL_BVQ', 'LGD:Сума забез-печення (CV) екв.', 'NUMBER', 36, 12, '999999999999999999999990D009999999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 37, 'LGD', 'LGD:Значення коефіцієнта LGD (1-RR)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 38, 'RZ', NULL, 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 39, 'TEXT', NULL, 'VARCHAR2', 250, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 40, 'NMK', 'Наймену-вання контрагента', 'VARCHAR2', 70, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 41, 'PRINSIDER', 'Код типу пов"язаної з банком особи', 'NUMBER', 38, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 42, 'COUNTRY', 'Код країни контра-гента', 'NUMBER', 3, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 43, 'ISE', 'Код інститу-ційного сектора економіки', 'CHAR', 5, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 44, 'SDATE', 'Дата договору', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31.12.9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 45, 'DATE_V', 'Дата виникнення боргу/наданих фінансових зобов"язань', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31.12.9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 46, 'WDATE', 'Дата погашення боргу/наданих фінансових зобов"язань', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31.12.9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 47, 'S250', NULL, 'NUMBER', 1, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 48, 'ISTVAL', NULL, 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 49, 'RC', 'LGD:Інші надход-ження  (RС)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 50, 'RCQ', NULL, 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 51, 'FAKTOR', 'PD :Інформація про наявність факторів, які потребують коригування класу боржника', 'NUMBER', 38, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 52, 'K_FAKTOR', 'PD :Код фактору, на підставі якого скоригований клас боржника', 'NUMBER', 38, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 53, 'K_DEFOLT', 'PD :Код ознаки дефолту боржника щодо якої банк довів відсутність дефолту', 'NUMBER', 38, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 54, 'DV', NULL, 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 55, 'FIN_KOR', 'PD :Клас боржника з урахуванням коригуючих факторів, що застосований для визначення кредитного ризику', 'NUMBER', 38, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 56, 'TIPA', 'Тип актива', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 57, 'OVKR', NULL, 'VARCHAR2', 50, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 58, 'P_DEF', NULL, 'VARCHAR2', 50, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 59, 'OVD', NULL, 'VARCHAR2', 50, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 60, 'OPD', NULL, 'VARCHAR2', 50, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 61, 'KOL23', NULL, 'VARCHAR2', 500, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 62, 'KOL24', NULL, 'VARCHAR2', 500, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 63, 'KOL25', NULL, 'VARCHAR2', 500, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 64, 'KOL26', NULL, 'VARCHAR2', 500, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 65, 'KOL27', NULL, 'VARCHAR2', 500, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 66, 'KOL28', NULL, 'VARCHAR2', 500, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 67, 'KOL29', NULL, 'VARCHAR2', 500, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 68, 'FIN_Z', NULL, 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 69, 'PD_0', NULL, 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 70, 'CC_ID', NULL, 'VARCHAR2', 50, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 71, 'KOL17', NULL, 'VARCHAR2', 50, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 72, 'KOL31', NULL, 'VARCHAR2', 100, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 73, 'S180', NULL, 'VARCHAR2', 1, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 74, 'T4', NULL, 'NUMBER', 1, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 75, 'RPB', 'група фінансових активів', 'NUMBER', 38, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 76, 'GRP', NULL, 'NUMBER', 38, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 77, 'OB22', 'ОБ22 рахунку', 'CHAR', 2, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 78, 'KOL30', NULL, 'VARCHAR2', 500, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 79, 'S080', 'Параметр фин.класа по FIN_351', 'VARCHAR2', 1, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 80, 'S080_Z', 'Параметр фин.класа по FIN_Z', 'VARCHAR2', 1, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 81, 'TIP_FIN', 'Тип фин.класу: 0 -> 1-2, 1 -> 1-5, 2 -> 1-10', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 82, 'DDD_6B', 'DDD из kl_f3_29 по kf="6B"', 'CHAR', 3, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 83, 'KF', NULL, 'VARCHAR2', 6, NULL, NULL, 'Y', 'N', NULL, NULL, 'N/A', 1, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 84, 'LGD_LONG', NULL, 'NUMBER', 38, 20, '999999999999999990D00999999999999999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 85, 'Z', 'Інтегральний показник', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 86, 'FIN_KOL', 'Клас боржника-юридичної особи (визначений на підставі оцінки фінансового стану) з урахуванням своєчасності сплати ним боргу', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 87, 'RNK_SK', 'Боржник належить до групи юридичних осіб під спільним контролем', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 88, 'FIN_SK', 'Скоригований клас боржника з урахуванням належності до групи під спільним контрорлем', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 89, 'FIN_PK', 'Скоригований клас боржника з урахуванням належності до групи належності до групи пов"язаних контрагентів', 'NUMBER', 38, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 90, 'Z_GRP', 'інтегральний показник групи', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 91, 'FIN_GRP', 'Клас групи, визначений на підставі оцінки фінансового стану', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 92, 'FIN_GRP_KOR', 'скоригований клас групи', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 93, 'FIN_RNK_KOR', 'скоригований клас контрагента, який належить до групи пов"язаних контрагентів', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 94, 'FIN_RNK', 'клас контрагента, який належить до групи пов"язаних контрагентів', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 95, 'OZ_165_NOT', 'порядковий номер ознак п. 165 Положення №351 за останнім припиненням визнання дефолту за подіями, визначеними в п. 165 за якими не має винятків', 'VARCHAR2', 500, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 96, 'DAT_165_NOT', 'дата останнього припинення визнання дефолту', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31.12.9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 97, 'OZ_166_NOT', 'порядковий номер ознак п. 166 Положення №351 за останнім припиненням визнання дефолту за подіями, визначеними в п. 166 за якими не має винятків', 'VARCHAR2', 500, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 98, 'DAT_166_NOT', 'дата останнього припинення визнання дефолту', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31.12.9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 99, 'OZ_165', 'порядковий номер ознак п. 165 Положення №351 за останнім припиненням визнання дефолту за подіями, визначеними в п. 165 за якими є винятки', 'VARCHAR2', 500, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (568, 100, 'DAT_165', 'дата останнього припинення визнання дефолту', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31.12.9999', NULL, NULL);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (&&sfile_id);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (&&sfile_id);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (&&sfile_id);

/*
begin
    if  barsupl.bars_upload_utl.is_mmfo > 1 then
         -- ************* MMFO *************
    else
         -- ************* RU *************
    end if;
end;
/
*/
