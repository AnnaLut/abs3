-- ===================================================================================
-- Module : UPL
-- Date   : 19.04.2017
-- ===================================================================================
-- 
-- ===================================================================================

delete from BARSUPL.UPL_CONSTRAINTS 
   where (file_id) in ( 350, 134, 352, 139 )
;


---
--- Добавлен constraint  insdl(RNK,KF)_$_customer(RNK,KF)
---
prompt Добавлен constraint  insdl(RNK,KF)_$_customer(RNK,KF)

Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (350, 'insdl(KF)_$_banks(MFO)', 1, 402);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (350, 'insdl(BRANCH)_$_branch(BRANCH)', 1, 103);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (350, 'insdl(STAFF_ID)_$_staffad(ID)', 1, 182);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (350, 'insdl(STAFF_ID,KF)_$_staff(ID,KF)', 1, 181);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (350, 'insdl(PARTNER_ID,KF)_$_insprt(ID,KF)', 1, 351);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (350, 'insdl(TYPE_ID)_$_instypes(ID)', 1, 352);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (350, 'insdl(STATUS_ID)_$_insdlsts(ID)', 1, 354);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (350, 'insdl(INS_RNK,KF)_$_customer(RNK,KF)', 1, 121);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (350, 'insdl(OBJECT_TYPE)_$_insobjtp(ID)', 1, 353);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (350, 'insdl(RENEW_ID,KF)_$_insdl(ID,KF)', 1, 350);
--new
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (350, 'insdl(RNK,KF)_$_customer(RNK,KF)', 1, 121);

---
--- Добавлен constraint  S080FIN(FIN)_$_STFIN23(FIN) S080_FIN --> STAN_FIN23
---
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (134, 'S080FIN(FIN)_$_STFIN23(FIN)', 1, 128);

---
--- Добавлен constraint  instyp(OBJECT_TYPE)_$_insobtyp(ID) INS_TYPES --> INS_OBJECT_TYPES
---
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (352, 'instyp(OBJECT_TYPE)_$_insobtyp(ID)', 1, 353);

---
--- Добавлен constraint  accpard(ACC,KF)_$_accounts(ACC,KF) SPECPARAM_INT --> ACCOUNTS
---
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (139, 'accpard(ACC,KF)_$_accounts(ACC,KF)', 1, 102);


COMMIT;
