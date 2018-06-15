-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 568
--define ssql_id  = 4568, 5568

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 568');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (568))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 4568,5568');
end;
/
-- ***************************************************************************
-- ETL-25020   UPL- выгружать файл REZ_CR в 98 группе вместе с NBU_23_REZ
-- 
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (4568, 5568);

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (4568, 'select rez.FDAT, rez.RNK, rez.CUSTTYPE, rez.ACC, rez.KV, rez.NBS, rez.TIP, rez.NLS, rez.ND, rez.VIDD, rez.FIN, rez.FINP,
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
 from BARS.rez_cr rez
where rez.fdat = TRUNC(TO_DATE (:param1, ''dd/mm/yyyy''), ''MM'')',
'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
 null, 'Кредитний ризик за активними банківськими операціями (IFRS) ММФО', '1.0');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (5568, 'select rez.FDAT, rez.RNK, rez.CUSTTYPE, rez.ACC, rez.KV, rez.NBS, rez.TIP, rez.NLS, rez.ND, rez.VIDD, rez.FIN, rez.FINP,
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
 from BARS.rez_cr rez
where rez.fdat = TRUNC(TO_DATE (:param1, ''dd/mm/yyyy''), ''MM'')',
'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
 null, 'Кредитний ризик за активними банківськими операціями (IFRS) РУ', '1.0');


--declare l_clob clob;
--begin
--l_clob:= to_clob();
--end;
--/

-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (568);

-- ***********************
-- UPL_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (568);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (568);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (568);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (568);

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
