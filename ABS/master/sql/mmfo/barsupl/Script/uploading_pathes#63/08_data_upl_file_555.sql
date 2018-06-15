-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = ###
--define ssql_id  = ###

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 555');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (555))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 555');
end;
/
-- ***************************************************************************
-- ETL-24573 UPL - добавить в выгрузку в NBU23REZ поля для IFRS 9
-- 
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (555, 1555, 2555);

declare l_clob clob;
begin
l_clob:= to_clob('select bars.gl.kf as KF, nbu.FDAT, nbu.ID, nbu.RNK, nbu.NBS, nbu.KV, nbu.ND, nbu.CC_ID, nbu.ACC, nbu.NLS, nbu.BRANCH, nbu.FIN, nbu.OBS,
       nbu.KAT, nbu.K, nbu.IRR, nbu.ZAL, nbu.BV, nbu.PV, nbu.REZ, nbu.REZQ, nbu.DD, nbu.DDD, nbu.BVQ, nbu.CUSTTYPE, nbu.IDR, nbu.WDATE,
       nbu.OKPO, nbu.NMK, nbu.RZ, nbu.PAWN, nbu.ISTVAL, nbu.R013, nbu.REZN, nbu.REZNQ, nbu.ARJK, cast(null as number) REZD, nbu.PVZ, nbu.PVZQ, nbu.ZALQ,
       nbu.ZPR, nbu.ZPRQ, nbu.PVQ, nbu.RU, nbu.INN, nbu.NRC, nbu.SDATE, nbu.IR, nbu.S031, nbu.K040, nbu.PROD, nbu.K110, nbu.K070, nbu.K051,
       nbu.S260, nbu.R011, nbu.R012, nbu.S240, nbu.S180, nbu.S580, nbu.NLS_REZ, nbu.NLS_REZN, nbu.S250, nbu.ACC_REZ, nbu.FIN_R, nbu.DISKONT,
       nbu.ISP, nbu.OB22, nbu.TIP, nbu.SPEC, nbu.ZAL_BL, nbu.S280_290, nbu.ZAL_BLQ, nbu.ACC_REZN, nbu.OB22_REZ, nbu.OB22_REZN, nbu.IR0, nbu.IRR0,
       to_number(nbu.ND_CP, ''fm999999999999'') ND_CP, nbu.SUM_IMP, nbu.SUMQ_IMP, nbu.PV_ZAL, nbu.VKR, nbu.S_L, nbu.SQ_L, nbu.ZAL_SV, nbu.ZAL_SVQ,
       nbu.GRP, nbu.KOL_SP, nbu.REZ39, nbu.PVP, nbu.BV_30, nbu.BVQ_30, nbu.REZ_30, nbu.REZQ_30, nbu.NLS_REZ_30, nbu.ACC_REZ_30, nbu.OB22_REZ_30,
       nbu.BV_0, nbu.BVQ_0, nbu.REZ_0, nbu.REZQ_0, nbu.NLS_REZ_0, nbu.ACC_REZ_0, nbu.OB22_REZ_0, nbu.KAT39, nbu.REZQ39, nbu.S250_39, nbu.REZ23,
       nbu.REZQ23, nbu.KAT23, nbu.S250_23, nbu.tipa, DAT_MI, BVUQ, BVU,
       nbu.EAD, nbu.EADQ, nbu.CR, nbu.CRQ, nbu.FIN_351, nbu.KOL_351, nbu.KPZ, nbu.KL_351, nbu.LGD, nbu.OVKR, nbu.P_DEF, nbu.OVD,
       nbu.OPD, nbu.ZAL_351, nbu.ZALQ_351, nbu.RC, nbu.RCQ, nbu.CCF, nbu.TIP_351,
       nbu.PD_0, nbu.FIN_Z, nbu.ISTVAL_351, nbu.RPB, nbu.S080, NBU.S080_Z, nbu.ddd_6b, NBU.FIN_P, nbu.fin_d, nbu.z, nbu.pd, nbu.rez9, nbu.rezq9
  from BARS.NBU23_REZ nbu,
       ( select MAX(TRUNC(ADD_MONTHS(dat, 1), ''MM'')) dat
           from BARS.REZ_PROTOCOL
          where dat <= TO_DATE (:param1, ''dd/mm/yyyy'')
       ) d
 where nbu.FDAT = d.DAT');
Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
Values (555, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Протокол розрах реп по НБУ-23', '1.5');
end;
/

declare l_clob clob;
begin 
l_clob:= to_clob('select bars.gl.kf as KF, nbu.FDAT, nbu.ID, nbu.RNK, nbu.NBS, nbu.KV, nbu.ND, nbu.CC_ID, nbu.ACC, nbu.NLS, nbu.BRANCH, nbu.FIN, nbu.OBS,
       nbu.KAT, nbu.K, nbu.IRR, nbu.ZAL, nbu.BV, nbu.PV, nbu.REZ, nbu.REZQ, nbu.DD, nbu.DDD, nbu.BVQ, nbu.CUSTTYPE, nbu.IDR, nbu.WDATE,
       nbu.OKPO, nbu.NMK, nbu.RZ, nbu.PAWN, nbu.ISTVAL, nbu.R013, nbu.REZN, nbu.REZNQ, nbu.ARJK, cast(null as number) REZD, nbu.PVZ, nbu.PVZQ, nbu.ZALQ,
       nbu.ZPR, nbu.ZPRQ, nbu.PVQ, nbu.RU, nbu.INN, nbu.NRC, nbu.SDATE, nbu.IR, nbu.S031, nbu.K040, nbu.PROD, nbu.K110, nbu.K070, nbu.K051,
       nbu.S260, nbu.R011, nbu.R012, nbu.S240, nbu.S180, nbu.S580, nbu.NLS_REZ, nbu.NLS_REZN, nbu.S250, nbu.ACC_REZ, nbu.FIN_R, nbu.DISKONT,
       nbu.ISP, nbu.OB22, nbu.TIP, nbu.SPEC, nbu.ZAL_BL, nbu.S280_290, nbu.ZAL_BLQ, nbu.ACC_REZN, nbu.OB22_REZ, nbu.OB22_REZN, nbu.IR0, nbu.IRR0,
       to_number(nbu.ND_CP, ''fm999999999999'') ND_CP, nbu.SUM_IMP, nbu.SUMQ_IMP, nbu.PV_ZAL, nbu.VKR, nbu.S_L, nbu.SQ_L, nbu.ZAL_SV, nbu.ZAL_SVQ,
       nbu.GRP, nbu.KOL_SP, nbu.REZ39, nbu.PVP, nbu.BV_30, nbu.BVQ_30, nbu.REZ_30, nbu.REZQ_30, nbu.NLS_REZ_30, nbu.ACC_REZ_30, nbu.OB22_REZ_30,
       nbu.BV_0, nbu.BVQ_0, nbu.REZ_0, nbu.REZQ_0, nbu.NLS_REZ_0, nbu.ACC_REZ_0, nbu.OB22_REZ_0, nbu.KAT39, nbu.REZQ39, nbu.S250_39, nbu.REZ23,
       nbu.REZQ23, nbu.KAT23, nbu.S250_23, nbu.tipa, DAT_MI, BVUQ, BVU,
       nbu.EAD, nbu.EADQ, nbu.CR, nbu.CRQ, nbu.FIN_351, nbu.KOL_351, nbu.KPZ, nbu.KL_351, nbu.LGD, nbu.OVKR, nbu.P_DEF, nbu.OVD,
       nbu.OPD, nbu.ZAL_351, nbu.ZALQ_351, nbu.RC, nbu.RCQ, nbu.CCF, nbu.TIP_351,
       nbu.PD_0, nbu.FIN_Z, nbu.ISTVAL_351, nbu.RPB, nbu.S080, NBU.S080_Z, nbu.ddd_6b, NBU.FIN_P, nbu.fin_d, nbu.z, nbu.pd, nbu.rez9, nbu.rezq9
  from BARS.NBU23_REZ nbu,
       ( select MAX(TRUNC(ADD_MONTHS(dat, 1), ''MM'')) dat
           from BARS.REZ_PROTOCOL
          where dat_bank = TO_DATE (:param1, ''dd/mm/yyyy'')
       ) d
 where nbu.FDAT = d.DAT');
Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
Values (1555, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Протокол розрах реп по НБУ-23', '1.5');
end;
/

declare l_clob clob;
begin
l_clob:= to_clob('select bars.gl.kf as KF, nbu.FDAT, nbu.ID, nbu.RNK, nbu.NBS, nbu.KV, nbu.ND, nbu.CC_ID, nbu.ACC, nbu.NLS, nbu.BRANCH, nbu.FIN, nbu.OBS,
       nbu.KAT, nbu.K, nbu.IRR, nbu.ZAL, nbu.BV, nbu.PV, nbu.REZ, nbu.REZQ, nbu.DD, nbu.DDD, nbu.BVQ, nbu.CUSTTYPE, nbu.IDR, nbu.WDATE,
       nbu.OKPO, nbu.NMK, nbu.RZ, nbu.PAWN, nbu.ISTVAL, nbu.R013, nbu.REZN, nbu.REZNQ, nbu.ARJK, cast(null as number) REZD, nbu.PVZ, nbu.PVZQ, nbu.ZALQ,
       nbu.ZPR, nbu.ZPRQ, nbu.PVQ, nbu.RU, nbu.INN, nbu.NRC, nbu.SDATE, nbu.IR, nbu.S031, nbu.K040, nbu.PROD, nbu.K110, nbu.K070, nbu.K051,
       nbu.S260, nbu.R011, nbu.R012, nbu.S240, nbu.S180, nbu.S580, nbu.NLS_REZ, nbu.NLS_REZN, nbu.S250, nbu.ACC_REZ, nbu.FIN_R, nbu.DISKONT,
       nbu.ISP, nbu.OB22, nbu.TIP, nbu.SPEC, nbu.ZAL_BL, nbu.S280_290, nbu.ZAL_BLQ, nbu.ACC_REZN, nbu.OB22_REZ, nbu.OB22_REZN, nbu.IR0, nbu.IRR0,
       to_number(nbu.ND_CP, ''fm999999999999'') ND_CP, nbu.SUM_IMP, nbu.SUMQ_IMP, nbu.PV_ZAL, nbu.VKR, nbu.S_L, nbu.SQ_L, nbu.ZAL_SV, nbu.ZAL_SVQ,
       nbu.GRP, nbu.KOL_SP, nbu.REZ39, nbu.PVP, nbu.BV_30, nbu.BVQ_30, nbu.REZ_30, nbu.REZQ_30, nbu.NLS_REZ_30, nbu.ACC_REZ_30, nbu.OB22_REZ_30,
       nbu.BV_0, nbu.BVQ_0, nbu.REZ_0, nbu.REZQ_0, nbu.NLS_REZ_0, nbu.ACC_REZ_0, nbu.OB22_REZ_0, nbu.KAT39, nbu.REZQ39, nbu.S250_39, nbu.REZ23,
       nbu.REZQ23, nbu.KAT23, nbu.S250_23, nbu.tipa, DAT_MI, BVUQ, BVU,
       nbu.EAD, nbu.EADQ, nbu.CR, nbu.CRQ, nbu.FIN_351, nbu.KOL_351, nbu.KPZ, nbu.KL_351, nbu.LGD, nbu.OVKR, nbu.P_DEF, nbu.OVD,
       nbu.OPD, nbu.ZAL_351, nbu.ZALQ_351, nbu.RC, nbu.RCQ, nbu.CCF, nbu.TIP_351,
       nbu.PD_0, nbu.FIN_Z, nbu.ISTVAL_351, nbu.RPB, nbu.S080, NBU.S080_Z, nbu.ddd_6b, NBU.FIN_P, nbu.fin_d, nbu.z, nbu.pd, nbu.rez9, nbu.rezq9
  from BARS.NBU23_REZ nbu
 where nbu.FDAT = TRUNC(TO_DATE (:param1, ''dd/mm/yyyy''), ''MM'')');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
Values (2555, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
              NULL, 'Протокол розрах реп по НБУ-23 (для переходу на IFRS9)', '1.0');
end;
/

-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (555);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (555);

Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 0, 'KF', 'Код філіалу (МФО)', 'CHAR', 6, NULL, NULL, 'Y', 'N', NULL, NULL, '0', 1, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 1, 'FDAT', 'Зв.дата(01.11.2012.', 'DATE', 8, NULL, 'ddmmyyyy', 'Y', 'N', NULL, NULL, '31/12/9999', 2, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 2, 'ID', 'Перв ключ:Мод+ид', 'VARCHAR2', 50, NULL, NULL, 'Y', 'N', NULL, NULL, '0', 3, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 3, 'RNK', 'Реєстраційний номер клієнта (РНК)', 'NUMBER', 15, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 4, 'NBS', 'Бал.рах', 'CHAR', 4, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 5, 'KV', 'Вал дог', 'NUMBER', 3, 0, NULL, 'Y', 'N', NULL, NULL, '0', 4, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 6, 'ND', 'Реф дог', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 7, 'CC_ID', 'Ид.дог', 'VARCHAR2', 50, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 8, 'ACC', 'Внутренний номер счета', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 9, 'NLS', '№ рах', 'VARCHAR2', 20, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 10, 'BRANCH', 'Код отделения', 'VARCHAR2', 22, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 11, 'FIN', 'Фин.клас', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 12, 'OBS', 'Обсуг.', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 13, 'KAT', 'Кат.якост', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 14, 'K', 'Коефіціент ризику', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 15, 'IRR', 'Эфф.% ст КД - использованная', 'NUMBER', 20, 12, '99999990D000000000000', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 16, 'ZAL', 'Забезпеч.', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 17, 'BV', 'Бал.варт', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 18, 'PV', 'Справ.варт', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 19, 'REZ', 'Рез-ном.', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 20, 'REZQ', 'Рез-екв.', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 21, 'DD', 'DD', 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 22, 'DDD', 'DDD', 'CHAR', 3, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 23, 'BVQ', 'Бал.варт активу, екв в 1.00', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 24, 'CUSTTYPE', 'Тип клієнта', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 25, 'IDR', NULL, 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 26, 'WDATE', 'WDATE', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31/12/9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 27, 'OKPO', NULL, 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 28, 'NMK', 'Назва клієнта', 'VARCHAR2', 35, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 29, 'RZ', NULL, 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 30, 'PAWN', 'вид залога', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 31, 'ISTVAL', NULL, 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 32, 'R013', NULL, 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 33, 'REZN', NULL, 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 34, 'REZNQ', NULL, 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 35, 'ARJK', NULL, 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 36, 'REZD', NULL, 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 37, 'PVZ', 'Враховане (частина або все Справ.варт) забезпечення, ном в 1.00', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 38, 'PVZQ', 'Враховане (частина або все Справ.варт) забезпечення, екв в 1.00', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 39, 'ZALQ', 'Лiкв.забез~екв~ZALq', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 40, 'ZPR', NULL, 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 41, 'ZPRQ', NULL, 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 42, 'PVQ', 'Теперішня вартість майбутніх грошових потоків на звітну дату за ефективною ставкою (еквівалент)', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 43, 'RU', NULL, 'VARCHAR2', 70, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 44, 'INN', NULL, 'VARCHAR2', 20, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 45, 'NRC', NULL, 'VARCHAR2', 70, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 46, 'SDATE', 'Дата начала договора', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31/12/9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 47, 'IR', 'Ном.% ст сч - текущая', 'NUMBER', 20, 12, '99999990D000000000000', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 48, 'S031', 'код вида залога по классификации НБУ', 'VARCHAR2', 2, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 49, 'K040', 'K040', 'VARCHAR2', 3, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 50, 'PROD', NULL, 'VARCHAR2', 50, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 51, 'K110', 'K110', 'VARCHAR2', 5, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 52, 'K070', 'K070', 'VARCHAR2', 5, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 53, 'K051', 'K051', 'VARCHAR2', 2, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 54, 'S260', NULL, 'CHAR', 2, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 55, 'R011', NULL, 'VARCHAR2', 1, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 56, 'R012', NULL, 'VARCHAR2', 1, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 57, 'S240', NULL, 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 58, 'S180', NULL, 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 59, 'S580', NULL, 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 60, 'NLS_REZ', 'Рахунок для вiдобра~рез~NLS_REZ', 'VARCHAR2', 15, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 61, 'NLS_REZN', 'Рахунок для вiдобра~рез(нал)~NLS_REZN', 'VARCHAR2', 15, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 62, 'S250', NULL, 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 63, 'ACC_R', 'ACC счета резерва вкл.в налоговый', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 64, 'FIN_R', NULL, 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 65, 'DISKONT', 'Сума Зменшення рез за рахунок дисконту', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 66, 'ISP', 'Виконавець по рахунку актива', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 67, 'OB22', NULL, 'CHAR', 2, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 68, 'TIP', NULL, 'CHAR', 3, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 69, 'SPEC', NULL, 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 70, 'ZAL_BL', 'Сума Залога балансовая', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 71, 'S280_290', 'код количества дней просрочки', 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 72, 'ZAL_BLQ', 'Сума Залога балансовая (екв.)', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 73, 'ACC_RN', 'ACC счета резерва не вкл.в налоговый', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 74, 'OB22_REZ', 'OB22 для счета резерва вкл.в налоговый', 'CHAR', 2, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 75, 'OB22_REZN', 'OB22 для счета резерва не вкл.в налоговый', 'CHAR', 2, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 76, 'IR0', 'Ном.% ст сч - начальная', 'NUMBER', 20, 12, '99999990D000000000000', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 77, 'IRR0', 'Эфф.% ст КД - известная', 'NUMBER', 20, 12, '99999990D000000000000', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 78, 'ND_CP', 'Ном.договора для группировки по резервам', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 79, 'SUM_IMP', 'Затраты на реализацию (ном.)', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 80, 'SUMQ_IMP', 'Затраты на реализацию (экв.)', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 81, 'PV_ZAL', 'Поток*К', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 82, 'VKR', 'Внутр.кред.рейтинг', 'VARCHAR2', 10, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 83, 'S_L', 'Залог*коэф.ликв.-затраты на реал.(ном.)', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 84, 'SQ_L', 'Залог*коэф.ликв.-затраты на реал.(экв.)', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 85, 'ZAL_SV', 'Справедлива вартість забезпечення (ном.)', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 86, 'ZAL_SVQ', 'Справедлива вартість забезпечення (екв.)', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 87, 'GRP', 'група активу портфельного методу', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 88, 'KOL_SP', 'Кількість днів прострочки', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 89, 'REZ39', 'Сумма резерва (ном.) из FINEVARE', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 90, 'PVP', 'Сума очікуваних майбутніх грошових потоків за кредитом відповідно до договору ', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 91, 'BV_30', 'Просрочено свыше 30 дней ном.', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 92, 'BVQ_30', 'Просрочено свыше 30 дней укв.', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 93, 'REZ_30', 'Резерв свыше 30 дней ном.', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 94, 'REZQ_30', 'Резерв свыше 30 дней укв.', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 95, 'NLS_REZ_30', 'счет резерва по нач.% проср.>30 дней', 'VARCHAR2', 15, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 96, 'ACC_R30', 'acc счета резерва по нач.% проср.>30 дней', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 97, 'OB22_REZ_30', 'Ob22 счета резерва по нач.% проср.>30 дней', 'CHAR', 2, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 98, 'BV_0', 'Просрочено менее 30 дней ном.', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 99, 'BVQ_0', 'Просрочено менее 30 дней екв.', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 100, 'REZ_0', 'Резерв менее 30 дней ном.', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 101, 'REZQ_0', 'Резерв менее 30 дней укв.', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 102, 'NLS_REZ_0', 'счет резерва по нач.% проср.<30 дней', 'VARCHAR2', 15, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 103, 'ACC_R0', 'acc счета резерва по нач.% проср.<30 дней', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 104, 'OB22_REZ_0', 'Ob22 счета резерва по нач.% проср.<30 дней', 'CHAR', 2, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 105, 'KAT39', 'Категория риска из FINEVARE', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 106, 'REZQ39', 'Сумма резерва (экв.) из FINEVARE', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 107, 'S250_39', 'Метка расчета резерва на индивидуальной или коллективной основе', 'VARCHAR2', 1, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 108, 'REZ23', 'Сумма резерва ПО 23 ПОСТ (ном.)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 109, 'REZQ23', 'Сумма резерва ПО 23 ПОСТ (экв.)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 110, 'KAT23', 'Категория риска из FINEVARE', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 111, 'S250_23', 'Метка расчета резерва на индивидуальной или коллективной основе', 'VARCHAR2', 1, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 112, 'TIPA', 'Тип.актива', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 113, 'DAT_MI', 'Дата миграции кредита', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31/12/9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 114, 'BVUQ', 'Зкоригована бал.варт.екв', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 115, 'BVU', 'Зкоригована бал.варт.ном', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 116, 'EAD', '(BV - SNA) - EAD(ном.) Експозиція під риз-ком на дату оцінки', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 117, 'EADQ', '(BVQ - SNAQ) - EADQ(екв.) Експозиція під риз-ком на дату оцінки', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 118, 'CR', 'Кредитний ризик CR (ном.)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 119, 'CRQ', 'Кредитний ризик CRQ (екв.)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 120, 'FIN_351', 'Скоригований клас (351)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 121, 'KOL_351', 'К-ть днів прострочки (351)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 122, 'KPZ', 'Коеф-т покриття забезпеченням (Кпз)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 123, 'KL_351', 'Коеф.ліквідності забезпечення (351)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 124, 'LGD', 'Втрати в разі дефолту (LGD)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 125, 'OVKR', 'Ознаки високого кредитного ризику', 'VARCHAR2', 50, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 126, 'P_DEF', 'Події дефолту', 'VARCHAR2', 50, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 127, 'OVD', 'Ознаки визнання дефолту', 'VARCHAR2', 50, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 128, 'OPD', 'Ознаки припинення дефолту', 'VARCHAR2', 50, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 129, 'ZAL_351', 'Рівень повернення боргу за рахунок реалізації забезпечення ном.(CV*k)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 130, 'ZALQ_351', 'Рівень повернення боргу за рахунок реалізації забезпечення екв.(CV*k)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 131, 'RC', 'Рівень повернення боргу за рахунок інших надходжень ном.(RC)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 132, 'RCQ', 'Рівень повернення боргу за рахунок інших надходжень екв.(RCQ)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 133, 'CCF', 'Коефіцієнт кредитної конверсії (CCF)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 134, 'TIP_351', 'Тип актива 351 постанова', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 135, 'PD_0', 'Безризикові (PD=0)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 136, 'FIN_Z', 'Клас контрагента, визначений на основі інтегрального показника', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 137, 'ISTVAL_351', 'Джерело валютної виручки згідно з постановою 351', 'NUMBER', 1, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 138, 'RPB', 'Рівень покриття боргу', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 139, 'S080', 'Параметр Фин.класа по FIN_351', 'VARCHAR2', 1, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 140, 'S080_Z', 'Параметр Фин.класа по FIN_Z', 'VARCHAR2', 1, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 141, 'DDD_6B', 'DDD для файла #6B', 'VARCHAR2', 3, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 142, 'FIN_P', 'Скоригований клас з вр. прост.', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 143, 'FIN_D', 'Скоригований клас на події/ознаки дефолту', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 144, 'Z', 'Інтегральний показник', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 145, 'PD', 'Коеф. імовірності дефолту', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 146, 'REZ9', 'Резерв по стандарту МСФЗ-9 ном.', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (555, 147, 'REZQ9', 'Резерв по стандарту МСФЗ-9 екв.', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL, NULL);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (555);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (555);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (555);

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
