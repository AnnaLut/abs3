-- ===================================================================================
-- Module : UPL
-- Date   : 19.04.2017
-- ===================================================================================
-- 
-- ===================================================================================

delete from BARSUPL.UPL_CONSTRAINTS
   where constr_name like '%_staffad%'
      or (file_id, constr_name) in ( (121, 'customer(ISP)_$_staffad(ID)'),
                                     (121, 'customer(ISP)_$_staff(ID,KF)')
                                   )
;

--
-- STAFF_AD (staffad) / 182 (ETL-18165) - UPL - добавить в выгрузку файл-справочник STAFF_AD со структурой таблицы STAFF (без KF) с новым полем "Учетная запись в AD"
--
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (201, 'credits(USER_ID)_$_staffad(ID)', 2, 182);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (194, 'revsal(USERID)_$_staffad(ID)', 1, 182);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (194, 'revsal(RUSERID)_$_staffad(ID)', 1, 182);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (221, 'deposit(USERID)_$_staffad(ID)', 2, 182);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (222, 'cdepos(USER_ID)_$_staffad(ID)', 2, 182);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (232, 'skry(ISP_MO)_$_staffad(ID)', 2, 182);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (500, 'accstaff(STAFF_ID)_$_staffad(ID)', 1, 182);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (533, 'objchghist(CHANGE_USER)_$_staffad(ID)', 2, 182);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (196, 'oper(USERID)_$_staffad(ID)', 1, 182);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (197, 'oper_visa(USERID)_$_staffad(ID)', 1, 182);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (235, 'skrynd(ISP_DOV)_$_staffad(ID)', 2, 182);

Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (121, 'customer(ISP)_$_staffad(ID)', 2, 182);
Insert into BARSUPL.UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (121, 'customer(ISP)_$_staff(ID,KF)', 2, 181);


COMMIT;
