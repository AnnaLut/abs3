-- ===================================================================================
-- Module : UPL
-- Date   : 19.04.2017
-- ===================================================================================
-- 
-- ===================================================================================

delete from BARSUPL.UPL_CONSTRAINTS 
   where (file_id) in ( 546, 350 )
;

delete from BARSUPL.UPL_CONSTRAINTS 
   where (file_id, constr_name) in ( (555, 'nbu23rez(S250)_$_kls250(S250)'),
                                     (555, 'nbu23rez(GRP)_$_grpportf(GRP)'),
									 (555, 'nbu23rez(S080)_$_s080fin(S080)')
                                   )
;

prompt FEEADJTXN0
-- FEEADJTXN0 (feeadjtxn0) / 546 ( ETL-18533 UPL - выгрузить корпроводки по дисконтам ежемесячно в Т0 )
-- новый файл
--
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (546, 'feeadjtxn0(ACC,KF)_$_account(ACC,KF)', 3, 102);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (546, 'feeadjtxn0(DK)_$_dk(DK)', 1, 405);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (546, 'feeadjtxn0(FDAT)_$_bankdates(FDAT)', 1, 342);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (546, 'feeadjtxn0(KF)_$_banks(MFO)', 2, 402);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (546, 'feeadjtxn0(TT)_$_tts(TT)', 3, 346);

Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (555, 'nbu23rez(S250)_$_kls250(S250)',  1, 385);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (555, 'nbu23rez(GRP)_$_grpportf(GRP)',  1, 386);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (555, 'nbu23rez(S080)_$_s080fin(S080)', 1, 134);

---
--- ETL-18408 UPL - выгрузить файлы по страховым договорам
---
prompt —траховые договора

delete from BARSUPL.UPL_CONSTRAINTS 
   where file_id in ( 350, 351, 355, 356);

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

Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (351, 'inspart(KF)_$_banks(MFO)', 1, 402);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (351, 'inspart(RNK,KF)_$_customer(RNK,KF)', 1, 121);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (351, 'inspart(CUSTTYPE)_$_custtype(CUSTTYPE)', 1, 288);

Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (355, 'insaddagr(KF)_$_banks(MFO)', 1, 402);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (355, 'insaddagr(BRANCH)_$_branch(BRANCH)', 1, 103);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (355, 'insaddagr(STAFF_ID)_$_staffad(ID)', 1, 182);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (355, 'insaddagr(STAFF_ID,KF)_$_staff(ID,KF)', 1, 181);

Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (356, 'inspaysh(KF)_$_banks(MFO)', 1, 402);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (356, 'inspaysh(TYPE,DEAL_ID,KF)_$_insdl(TYPE,ID,KF)', 1, 350);

COMMIT;
