-- ===================================================================================
-- Module : UPL
-- Date   : 19.05.2017
-- ===================================================================================
-- 
-- ===================================================================================

  
delete from BARSUPL.UPL_CONS_COLUMNS 
   where (file_id) in ( 350, 134, 352, 139 )
;

---
--- Добавлен constraint  insdl(RNK,KF)_$_customer(RNK,KF)
---
prompt Добавлен constraint  insdl(RNK,KF)_$_customer(RNK,KF)

Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (350, 'insdl(KF)_$_banks(MFO)', 1, 'KF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (350, 'insdl(BRANCH)_$_branch(BRANCH)', 1, 'BRANCH');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (350, 'insdl(STAFF_ID)_$_staffad(ID)', 1, 'STAFF_ID');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (350, 'insdl(STAFF_ID,KF)_$_staff(ID,KF)', 1, 'STAFF_ID');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (350, 'insdl(STAFF_ID,KF)_$_staff(ID,KF)', 2, 'KF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (350, 'insdl(PARTNER_ID,KF)_$_insprt(ID,KF)', 1, 'PARTNER_ID');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (350, 'insdl(PARTNER_ID,KF)_$_insprt(ID,KF)', 2, 'KF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (350, 'insdl(TYPE_ID)_$_instypes(ID)', 1, 'TYPE_ID');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (350, 'insdl(STATUS_ID)_$_insdlsts(ID)', 1, 'STATUS_ID');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (350, 'insdl(INS_RNK,KF)_$_customer(RNK,KF)', 1, 'INS_RNK');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (350, 'insdl(INS_RNK,KF)_$_customer(RNK,KF)', 2, 'KF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (350, 'insdl(OBJECT_TYPE)_$_insobjtp(ID)', 1, 'OBJECT_TYPE');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (350, 'insdl(RENEW_ID,KF)_$_insdl(ID,KF)', 1, 'RENEW_ID');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (350, 'insdl(RENEW_ID,KF)_$_insdl(ID,KF)', 2, 'KF');
--new
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (350, 'insdl(RNK,KF)_$_customer(RNK,KF)', 1, 'RNK');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (350, 'insdl(RNK,KF)_$_customer(RNK,KF)', 2, 'KF');


---
--- Добавлен constraint  S080FIN(FIN)_$_STFIN23(FIN) S080_FIN --> STAN_FIN23
---
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (134, 'S080FIN(FIN)_$_STFIN23(FIN)', 1, 'FIN');

---
--- Добавлен constraint  instyp(OBJECT_TYPE)_$_insobtyp(ID) INS_TYPES --> INS_OBJECT_TYPES
---
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (352, 'instyp(OBJECT_TYPE)_$_insobtyp(ID)', 1, 'OBJECT_TYPE');

---
--- Добавлен constraint  accpard(ACC,KF)_$_accounts(ACC,KF) SPECPARAM_INT --> ACCOUNTS
---
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (139, 'accpard(ACC,KF)_$_accounts(ACC,KF)', 1, 'ACC');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (139, 'accpard(ACC,KF)_$_accounts(ACC,KF)', 2, 'KF');


COMMIT;


