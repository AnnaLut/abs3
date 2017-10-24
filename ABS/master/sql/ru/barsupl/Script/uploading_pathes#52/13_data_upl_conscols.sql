-- ===================================================================================
-- Module : UPL
-- Date   : 19.05.2017
-- ===================================================================================
-- 
-- ===================================================================================

  
delete from BARSUPL.UPL_CONS_COLUMNS 
   where (file_id) in ( 546, 350, 351, 355, 356 )
;

delete from BARSUPL.UPL_CONS_COLUMNS 
   where (file_id, constr_name) in ( (555, 'nbu23rez(S250)_$_kls250(S250)'),
                                     (555, 'nbu23rez(GRP)_$_grpportf(GRP)'),
									 (555, 'nbu23rez(S080)_$_s080fin(S080)')
                                   )
;

prompt FEEADJTXN0
-- FEEADJTXN0 (feeadjtxn0) / 546 ( ETL-18533 UPL - выгрузить корпроводки по дисконтам ежемесячно в Т0 )
-- новый файл
--
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (546, 'feeadjtxn0(ACC,KF)_$_account(ACC,KF)', 2, 'KF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (546, 'feeadjtxn0(ACC,KF)_$_account(ACC,KF)', 1, 'ACC');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (546, 'feeadjtxn0(DK)_$_dk(DK)', 1, 'DK');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (546, 'feeadjtxn0(FDAT)_$_bankdates(FDAT)', 1, 'FDAT');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (546, 'feeadjtxn0(KF)_$_banks(MFO)', 1, 'KF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (546, 'feeadjtxn0(TT)_$_tts(TT)', 1, 'TT');

Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (555, 'nbu23rez(S250)_$_kls250(S250)',  1, 'S250');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (555, 'nbu23rez(GRP)_$_grpportf(GRP)',  1, 'GRP');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (555, 'nbu23rez(S080)_$_s080fin(S080)', 1, 'S080');

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

Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (351, 'inspart(KF)_$_banks(MFO)', 1, 'KF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (351, 'inspart(RNK,KF)_$_customer(RNK,KF)', 1, 'RNK');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (351, 'inspart(RNK,KF)_$_customer(RNK,KF)', 2, 'KF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (351, 'inspart(CUSTTYPE)_$_custtype(CUSTTYPE)', 1, 'CUSTTYPE');

Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (355, 'insaddagr(KF)_$_banks(MFO)', 1, 'KF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (355, 'insaddagr(BRANCH)_$_branch(BRANCH)', 1, 'BRANCH');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (355, 'insaddagr(STAFF_ID)_$_staffad(ID)', 1, 'STAFF_ID');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (355, 'insaddagr(STAFF_ID,KF)_$_staff(ID,KF)', 1, 'STAFF_ID');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (355, 'insaddagr(STAFF_ID,KF)_$_staff(ID,KF)', 2, 'KF');

Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (356, 'inspaysh(KF)_$_banks(MFO)', 1, 'KF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (356, 'inspaysh(TYPE,DEAL_ID,KF)_$_insdl(TYPE,ID,KF)', 1, 'TYPE');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (356, 'inspaysh(TYPE,DEAL_ID,KF)_$_insdl(TYPE,ID,KF)', 2, 'DEAL_ID');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (356, 'inspaysh(TYPE,DEAL_ID,KF)_$_insdl(TYPE,ID,KF)', 3, 'KF');

COMMIT;
