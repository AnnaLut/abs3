-- ===================================================================================
-- Module : UPL
-- Date   : 19.05.2017
-- ===================================================================================
-- 
-- ===================================================================================

  
delete from BARSUPL.UPL_CONS_COLUMNS 
   where (file_id) in ( 566 )
;

--
-- COBUSUPMMFO-212 Барс ММФО, відсутня міграція функціоналу з Барс Міленіум Вигрузка протоколу формування файлу #A7».
--
prompt  566 выгрузка A7
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (566, 'a7upl(DATF)_$_bankdates(FDAT)', 1, 'DATF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (566, 'a7upl(TOBO)_$_branch(BRANCH)', 1, 'TOBO');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (566, 'a7upl(KV)_$_tabval(KV)', 1, 'KV');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (566, 'a7upl(ACC,KF)_$_accounts(ACC,KF)', 1, 'ACC');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (566, 'a7upl(ACC,KF)_$_accounts(ACC,KF)', 2, 'KF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (566, 'a7upl(NBS)_$_klr020(R020)', 1, 'NBS');
--Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (566, 'a7upl(KV1)_$_tabval(KV)', 1, 'KV1');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (566, 'a7upl(S240)_$_kls240(S240)', 1, 'S240');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (566, 'a7upl(RNK,KF)_$_custmer(RNK,KF)', 1, 'RNK');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (566, 'a7upl(RNK,KF)_$_custmer(RNK,KF)', 2, 'KF');

Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (566, 'a7upl(ISP,KF)_$_accounts(ISP,KF)', 1, 'ISP');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (566, 'a7upl(ISP,KF)_$_accounts(ISP,KF)', 2, 'KF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (566, 'a7upl(ISP)_$_accounts(ISP)', 1, 'ISP');


COMMIT;
