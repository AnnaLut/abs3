-- ===================================================================================
-- Module : UPL
-- Date   : 19.05.2017
-- ===================================================================================
-- 
-- ===================================================================================

  
delete from BARSUPL.UPL_CONS_COLUMNS 
   where (file_id) in ( 171, 547, 7171 )
;

--- ETL-19131 - ANL - �������� ��������� �� ������������� ����������� �������������
--- XOZ_REF(171) ��������� ��������� (������� �� ������� ��� ���.���)
--- ����� ����
prompt 171 �������� ��� XOZ_REF
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (171, 'xozref(ACC,KF)_$_accounts(ACC,KF)', 1, 'ACC');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (171, 'xozref(ACC,KF)_$_accounts(ACC,KF)', 2, 'KF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (171, 'xozref(PRG)_$_xozprg(PRG)', 1, 'PRG');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (171, 'xozref(RNK,KF)_$_custmer(RNK,KF)', 1, 'RNK');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (171, 'xozref(RNK,KF)_$_custmer(RNK,KF)', 2, 'KF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (171, 'xozref(TIP)_$_tips(TIP)', 1, 'TIP');

prompt 7171 �������� ��� XOZ_REF0
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (7171, 'xozref0(ACC,KF)_$_accounts(ACC,KF)', 1, 'ACC');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (7171, 'xozref0(ACC,KF)_$_accounts(ACC,KF)', 2, 'KF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (7171, 'xozref0(PRG)_$_xozprg(PRG)', 1, 'PRG');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (7171, 'xozref0(RNK,KF)_$_custmer(RNK,KF)', 1, 'RNK');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (7171, 'xozref0(RNK,KF)_$_custmer(RNK,KF)', 2, 'KF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (7171, 'xozref0(TIP)_$_tips(TIP)', 1, 'TIP');

--- ETL-19474 - UPL - �������� � �������� ��� T0 �������������� �������� �� ��������� ���.��������� ��������� ������ (�� �������� � MIR.SRC_PRFTADJTXN0)
--- ����� ����
prompt 547 ������������� �� ������ XOZ
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (547, 'prfxoz0(ACC,KF)_$_account(ACC,KF)', 1, 'ACC');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (547, 'prfxoz0(ACC,KF)_$_account(ACC,KF)', 2, 'KF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (547, 'prfxoz0(DK)_$_dk(DK)', 1, 'DK');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (547, 'prfxoz0(FDAT)_$_bankdates(FDAT)', 1, 'FDAT');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (547, 'prfxoz0(KF)_$_banks(MFO)', 1, 'KF');
Insert into BARSUPL.UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (547, 'prfxoz0(TT)_$_tts(TT)', 1, 'TT');

COMMIT;


