-- ===================================================================================
-- Module : UPL
-- Date   : 19.04.2017
-- ===================================================================================
-- 
-- ===================================================================================

  
delete from BARSUPL.UPL_CONS_COLUMNS 
   where constr_name like '%_staffad%'
      or (file_id, constr_name) in ( (121, 'customer(ISP)_$_staffad(ID)'),
                                     (121, 'customer(ISP)_$_staff(ID,KF)')
                                   )
   ;


--
-- STAFF_AD (staffad) / 182 (ETL-18165) - UPL - добавить в выгрузку файл-справочник STAFF_AD со структурой таблицы STAFF (без KF) с новым полем "Учетная запись в AD"
--
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (194, 'revsal(RUSERID)_$_staffad(ID)', 1, 'RUSERID');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (194, 'revsal(USERID)_$_staffad(ID)', 1, 'USERID');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (196, 'oper(USERID)_$_staffad(ID)', 1, 'USERID');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (197, 'oper_visa(USERID)_$_staffad(ID)', 1, 'USERID');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (201, 'credits(USER_ID)_$_staffad(ID)', 32, 'USER_ID');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (221, 'deposit(USERID)_$_staffad(ID)', 32, 'USERID');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (222, 'cdepos(USER_ID)_$_staffad(ID)', 6, 'USER_ID');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (232, 'skry(ISP_MO)_$_staffad(ID)', 5, 'ISP_MO');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (235, 'skrynd(ISP_DOV)_$_staffad(ID)', 20, 'ISP_DOV');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (500, 'accstaff(STAFF_ID)_$_staffad(ID)', 1, 'STAFF_ID');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (533, 'objchghist(CHANGE_USER)_$_staffad(ID)', 1, 'CHANGE_USER');

Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (121, 'customer(ISP)_$_staffad(ID)', 1, 'ISP');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (121, 'customer(ISP)_$_staff(ID,KF)', 1, 'ISP');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (121, 'customer(ISP)_$_staff(ID,KF)', 2, 'KF');



COMMIT;
