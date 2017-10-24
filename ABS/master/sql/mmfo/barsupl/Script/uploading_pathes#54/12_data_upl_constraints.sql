-- ===================================================================================
-- Module : UPL
-- Date   : 19.04.2017
-- ===================================================================================
-- 
-- ===================================================================================

delete from BARSUPL.UPL_CONSTRAINTS 
   where (file_id) in ( 171, 547, 7171 )
;


--- ETL-19131 - ANL - выгрузку договоров по хозяйственной дебиторской задолженности
--- XOZ_REF(171) Картотека дебиторов (предназ по задумке для хоз.деб)
--- новый файл
prompt 171 договора ХДЗ XOZ_REF
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (171, 'xozref(ACC,KF)_$_accounts(ACC,KF)', 1, 102);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (171, 'xozref(PRG)_$_xozprg(PRG)', 1, 172);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (171, 'xozref(RNK,KF)_$_custmer(RNK,KF)', 1, 121);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (171, 'xozref(TIP)_$_tips(TIP)', 1, 418);

prompt 7171 договора ХДЗ XOZ_REF0
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (7171, 'xozref0(ACC,KF)_$_accounts(ACC,KF)', 1, 102);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (7171, 'xozref0(PRG)_$_xozprg(PRG)', 1, 172);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (7171, 'xozref0(RNK,KF)_$_custmer(RNK,KF)', 1, 121);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (7171, 'xozref0(TIP)_$_tips(TIP)', 1, 418);

--- ETL-19474 - UPL - добавить в выгрузку для T0 корректирующих проводок по договорам хоз.дебеторки отдельным файлом (по аналогии с MIR.SRC_PRFTADJTXN0)
--- новый файл
prompt 547 корректировки по счетам XOZ
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (547, 'prfxoz0(ACC,KF)_$_account(ACC,KF)', 3, 102);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (547, 'prfxoz0(DK)_$_dk(DK)', 1, 405);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (547, 'prfxoz0(FDAT)_$_bankdates(FDAT)', 1, 342);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (547, 'prfxoz0(KF)_$_banks(MFO)', 2, 402);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (547, 'prfxoz0(TT)_$_tts(TT)', 3, 346);



COMMIT;
