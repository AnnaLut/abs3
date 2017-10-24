-- ===================================================================================
-- Module : UPL
-- Date   : 19.04.2017
-- ===================================================================================
-- 
-- ===================================================================================

delete from BARSUPL.UPL_CONSTRAINTS 
   where (file_id) in ( 566 )
;


--
-- COBUSUPMMFO-212 Барс ММФО, відсутня міграція функціоналу з Барс Міленіум Вигрузка протоколу формування файлу #A7».
--
prompt  566 выгрузка A7
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (566, 'a7upl(DATF)_$_bankdates(FDAT)', 1, 342);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (566, 'a7upl(TOBO)_$_branch(BRANCH)', 1, 103);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (566, 'a7upl(KV)_$_tabval(KV)', 1, 296);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (566, 'a7upl(ACC,KF)_$_accounts(ACC,KF)', 1, 102);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (566, 'a7upl(NBS)_$_klr020(R020)', 1, 107);
-- Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (566, 'a7upl(KV1)_$_tabval(KV)', 1, 296);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (566, 'a7upl(S240)_$_kls240(S240)', 1, 396);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (566, 'a7upl(RNK,KF)_$_custmer(RNK,KF)', 1, 121);

Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (566, 'a7upl(ISP,KF)_$_accounts(ISP,KF)', 1, 181);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (566, 'a7upl(ISP)_$_accounts(ISP)', 1, 182);

COMMIT;


566	a7upl(ISP,KF)_$_accounts(ISP,KF)	1	ISP				
566	a7upl(ISP,KF)_$_accounts(ISP,KF)	2	KF				
566	a7upl(ISP)_$_accounts(ISP,KF)	1	ISP				
				566	a7upl(ISP)_$accounts(ISP)	1	182
				566	a7upl(ISP,KF)_$accounts(ISP,KF)	1	181
				523	cpdat(KF)_$_banks(KF)	1	402
				104	transaction(C_ACC, KF)_$_account(ACC,KF)	1	102
				104	transaction(D_ACC, KF)_$_account(ACC,KF)	1	102
				285	dpuvidd(ACC7)_$_account(ACC7)	2	102
				264	balance(KV)_$_tabval(KV)	3	296