-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
define sfile_id = 154
define ssql_id  = 154,1154,2154,3154

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: &&sfile_id');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (&&sfile_id))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # &&ssql_id');
end;
/
-- ***************************************************************************
--ETL-19975 UPL - выделить в выгрузке для DWH договора внешних заимствований
-- CC_ADD (154) Доп.соглашения
-- добавлены в выгрузку vidd внешних заимствований (2700, 2701, 3660, 3661)
-- добавлены новые поля N_NBU, D_NBU
--ETL-20783 (изменилась привязка с credits на credkz)
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

--ММФО фулл
Insert into UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (154, 'with tpdt as (select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual),
     cc   as (select ND, ADDS, AIM, S, KV, BDATE, WDATE, SOUR, FREQ, KF, ACCS
                 from bars.cc_add_update
                where idupd in (select MAX (idupd) idupd
                                  from bars.cc_add_update, tpdt
                                 where effectdate < tpdt.dt2
                                 group by nd, adds
                               )
             ),
     i    as ( select iu0.freq, iu0.acc --, id
                 from bars.int_accn_update iu0
                where iu0.idupd in (select max(iu.idupd)
                                      from bars.int_accn_update iu,
                                           bars.accounts a,
                                           tpdt
                                     where iu.id = 0 --только активы
                                       and iu.acc <> 0
                                       and iu.effectdate < tpdt.dt2
                                       and iu.acc = a.acc
                                       and a.nls like ''8999%''
                                     group by iu.acc, iu.id)
             ),
     ii   as ( select iu0.freq, iu0.acc -- для внешних заимствований (2700, 2701, 3660, 3661)
                 from bars.int_accn_update iu0
                where iu0.idupd in (select max(iu.idupd)
                                      from bars.int_accn_update iu,
                                           bars.nd_acc n,
                                           bars.cc_deal d,
                                           tpdt
                                     where iu.id = 1 --только пасивы
                                       and iu.acc <> 0
                                       and iu.effectdate < tpdt.dt2
                                       and iu.acc = n.acc
                                       and d.nd = n.nd
                                       and d.vidd in ( select vidd from bars.v_mbdk_product where tipp = 1)
                                     group by iu.acc, iu.id)
             )
select cc.ND, cc.ADDS, cc.AIM, cc.S, cc.KV, cc.BDATE, cc.WDATE, cc.SOUR, cc.FREQ, cc.KF, 3 ND_TYPE, coalesce(d.freq, dd.freq) freqp, ad.n_nbu, ad.d_nbu
  from cc
       left join (select unique n.nd, i.freq
                    from i, bars.nd_acc_update n
                   where n.acc = i.acc
                 ) d on (cc.nd = d.nd)
       left join (select unique n.nd, ii.freq, n.acc
                    from ii, bars.nd_acc_update n
                   where n.acc = ii.acc
                 ) dd on (cc.nd = dd.nd and cc.accs = dd.acc)
       left join bars.cc_add ad on (cc.nd = ad.nd and cc.adds = ad.adds)',
   'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
   NULL, 'Доп.соглашения ММФО', '1.3');

--ММФО дельта
Insert into UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (1154, 'with tpdt as (select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual),
     cc   as (select ND, ADDS, AIM, S, KV, BDATE, WDATE, SOUR, FREQ, KF, ACCS
                 from bars.cc_add_update
                where idupd in (select MAX (idupd) idupd
                                  from bars.cc_add_update, tpdt
                                 where effectdate between tpdt.dt1 and tpdt.dt2
                                 group by nd, adds
                               )
             ),
     i    as ( select iu0.freq, iu0.acc --, id
               from bars.int_accn_update iu0
               where iu0.idupd in (select max(iu.idupd)
                                 from bars.int_accn_update iu, bars.accounts a, tpdt
                                where iu.id = 0 --только активы
                                  and iu.acc <> 0
                                  and iu.effectdate < tpdt.dt2
                                  and iu.acc = a.acc
                                  and a.nls like ''8999%''
                                group by iu.acc, iu.id
                              )
             ),
     ii   as ( select iu0.freq, iu0.acc -- для внешних заимствований (2700, 2701, 3660, 3661)
                 from bars.int_accn_update iu0
                where iu0.idupd in (select max(iu.idupd)
                                      from bars.int_accn_update iu,
                                           bars.nd_acc n,
                                           bars.cc_deal d,
                                           tpdt
                                     where iu.id = 1 --только пасивы
                                       and iu.acc <> 0
                                       and iu.effectdate < tpdt.dt2
                                       and iu.acc = n.acc
                                       and d.nd = n.nd
                                       and d.vidd in ( select vidd from bars.v_mbdk_product where tipp = 1)
                                     group by iu.acc, iu.id)
             )
select cc.ND, cc.ADDS, cc.AIM, cc.S, cc.KV, cc.BDATE, cc.WDATE, cc.SOUR, cc.FREQ, cc.KF, 3 ND_TYPE, coalesce(d.freq, dd.freq) freqp, ad.n_nbu, ad.d_nbu
  from cc
       left join (select unique n.nd, i.freq
                    from i, bars.nd_acc_update n
                   where n.acc = i.acc
                 ) d on (cc.nd = d.nd)
       left join (select unique n.nd, ii.freq, n.acc
                    from ii, bars.nd_acc_update n
                   where n.acc = ii.acc
                 ) dd on (cc.nd = dd.nd and cc.accs = dd.acc)
       left join bars.cc_add ad on (cc.nd = ad.nd and cc.adds = ad.adds)',
   'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
   NULL, 'Доп.соглашения ММФО', '1.3');

--РУ фулл
Insert into UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (2154, 'with tpdt as (select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual),
     cc   as (select ND, ADDS, AIM, S, KV, BDATE, WDATE, SOUR, FREQ, KF, ACCS
                 from bars.cc_add_update
                where idupd in (select MAX (idupd) idupd
                                  from bars.cc_add_update, tpdt
                                 where effectdate < tpdt.dt2
                                 group by nd, adds
                               )
             ),
     i    as ( select iu0.freq, iu0.acc --, id
                 from bars.int_accn_update iu0
                where iu0.idupd in (select max(iu.idupd)
                                      from bars.int_accn_update iu,
                                           bars.accounts a,
                                           tpdt
                                     where iu.id = 0 --только активы
                                       and iu.acc <> 0
                                       and iu.effectdate < tpdt.dt2
                                       and iu.acc = a.acc
                                       and a.nls like ''8999%''
                                     group by iu.acc, iu.id)
             ),
     ii   as ( select iu0.freq, iu0.acc -- для внешних заимствований (2700, 2701, 3660, 3661)
                 from bars.int_accn_update iu0
                where iu0.idupd in (select max(iu.idupd)
                                      from bars.int_accn_update iu,
                                           bars.nd_acc n,
                                           bars.cc_deal d,
                                           tpdt
                                     where iu.id = 1 --только пасивы
                                       and iu.acc <> 0
                                       and iu.effectdate < tpdt.dt2
                                       and iu.acc = n.acc
                                       and d.nd = n.nd
                                       and d.vidd in ( select vidd from bars.v_mbdk_product where tipp = 1)
                                     group by iu.acc, iu.id)
             )
select cc.ND, cc.ADDS, cc.AIM, cc.S, cc.KV, cc.BDATE, cc.WDATE, cc.SOUR, cc.FREQ, cc.KF, 3 ND_TYPE, coalesce(d.freq, dd.freq) freqp, cast(null as varchar2(300)) n_nbu, cast(null as date) d_nbu
  from cc
       left join (select unique n.nd, i.freq
                    from i, bars.nd_acc_update n
                   where n.acc = i.acc
                 ) d on (cc.nd = d.nd)
       left join (select unique n.nd, ii.freq, n.acc
                    from ii, bars.nd_acc_update n
                   where n.acc = ii.acc
                 ) dd on (cc.nd = dd.nd and cc.accs = dd.acc)
       left join bars.cc_add ad on (cc.nd = ad.nd and cc.adds = ad.adds)',
   'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
   NULL, 'Доп.соглашения РУ', '1.3');

--РУ дельта
Insert into UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (3154, 'with tpdt as (select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual),
     cc   as (select ND, ADDS, AIM, S, KV, BDATE, WDATE, SOUR, FREQ, KF, ACCS
                 from bars.cc_add_update
                where idupd in (select MAX (idupd) idupd
                                  from bars.cc_add_update, tpdt
                                 where effectdate between tpdt.dt1 and tpdt.dt2
                                 group by nd, adds
                               )
             ),
     i    as ( select iu0.freq, iu0.acc --, id
               from bars.int_accn_update iu0
               where iu0.idupd in (select max(iu.idupd)
                                 from bars.int_accn_update iu, bars.accounts a, tpdt
                                where iu.id = 0 --только активы
                                  and iu.acc <> 0
                                  and iu.effectdate < tpdt.dt2
                                  and iu.acc = a.acc
                                  and a.nls like ''8999%''
                                group by iu.acc, iu.id
                              )
             ),
     ii   as ( select iu0.freq, iu0.acc -- для внешних заимствований (2700, 2701, 3660, 3661)
                 from bars.int_accn_update iu0
                where iu0.idupd in (select max(iu.idupd)
                                      from bars.int_accn_update iu,
                                           bars.nd_acc n,
                                           bars.cc_deal d,
                                           tpdt
                                     where iu.id = 1 --только пасивы
                                       and iu.acc <> 0
                                       and iu.effectdate < tpdt.dt2
                                       and iu.acc = n.acc
                                       and d.nd = n.nd
                                       and d.vidd in ( select vidd from bars.v_mbdk_product where tipp = 1)
                                     group by iu.acc, iu.id)
             )
select cc.ND, cc.ADDS, cc.AIM, cc.S, cc.KV, cc.BDATE, cc.WDATE, cc.SOUR, cc.FREQ, cc.KF, 3 ND_TYPE, coalesce(d.freq, dd.freq) freqp, cast(null as varchar2(300)) n_nbu, cast(null as date) d_nbu
  from cc
       left join (select unique n.nd, i.freq
                    from i, bars.nd_acc_update n
                   where n.acc = i.acc
                 ) d on (cc.nd = d.nd)
       left join (select unique n.nd, ii.freq, n.acc
                    from ii, bars.nd_acc_update n
                   where n.acc = ii.acc
                 ) dd on (cc.nd = dd.nd and cc.accs = dd.acc)
       left join bars.cc_add ad on (cc.nd = ad.nd and cc.adds = ad.adds)',
   'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
   NULL, 'Доп.соглашения РУ', '1.3');

-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (&&sfile_id);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (&&sfile_id);

Insert into UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (154, 1, 'ND', 'Номер договора (референц)', 'NUMBER', 15, 0, NULL, 'Y', 'N', NULL, NULL, '0', 1, 'TRUNC_E2');
Insert into UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (154, 2, 'ADDS', 'N доп. соглащения', 'NUMBER', 15, 0, NULL, 'Y', 'N', NULL, NULL, '0', 2, NULL);
Insert into UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (154, 3, 'AIM', 'Целевое назначение договора', 'NUMBER', 5, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (154, 4, 'S', 'Сумма договора', 'NUMBER', 22, 4, '999999999999999990D0000', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (154, 5, 'KV', 'Код вал', 'NUMBER', 3, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (154, 6, 'BDATE', 'Дата начала действия', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '-', NULL, NULL);
Insert into UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (154, 7, 'WDATE', 'Дата выдачи', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '-', NULL, NULL);
Insert into UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (154, 8, 'SOUR', 'Источник кредитования', 'NUMBER', 5, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (154, 9, 'FREQ', 'Периодичность погашения основного долга', 'NUMBER', 5, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (154, 10, 'KF', 'Код филиала', 'VARCHAR2', 6, NULL, NULL, NULL, 'N', NULL, NULL, '-', NULL, NULL);
Insert into UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (154, 11, 'ND_TYPE', 'Тип договора, кредиты = 3', 'NUMBER', 2, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (154, 12, 'FREQP', 'Периодичность погашения процентов', 'NUMBER', 5, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (154, 13, 'N_NBU', 'Номер свідоцтва НБУ', 'VARCHAR2', 300, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);
Insert into UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (154, 14, 'D_NBU', 'Дата реєстрації в НБУ', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '-', NULL, NULL);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (&&sfile_id);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (154, 'ccadd(FREQ)_$_FREQ(FREQ)', 1, 321);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (154, 'ccadd(FREQP)_$_FREQ(FREQ)', 1, 321);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (154, 'ccadd(KF)_$_banks(MFO)', 1, 402);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (154, 'ccadd(ND_TYPE,ND,KF)_$_credkz(TYPE,ND,KF)', 1, 161);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (&&sfile_id);
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (154, 'ccadd(FREQ)_$_FREQ(FREQ)', 1, 'FREQ');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (154, 'ccadd(FREQP)_$_FREQ(FREQ)', 1, 'FREQP');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (154, 'ccadd(KF)_$_banks(MFO)', 1, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (154, 'ccadd(ND_TYPE,ND,KF)_$_credkz(TYPE,ND,KF)', 1, 'ND_TYPE');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (154, 'ccadd(ND_TYPE,ND,KF)_$_credkz(TYPE,ND,KF)', 2, 'ND');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (154, 'ccadd(ND_TYPE,ND,KF)_$_credkz(TYPE,ND,KF)', 3, 'KF');

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (&&sfile_id);


begin
    if  barsupl.bars_upload_utl.is_mmfo > 1 then
         -- ************* MMFO *************
        Insert into UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (1, 154, 154);
        Insert into UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (2, 154, 1154);
        Insert into UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (3, 154, 154);
        Insert into UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (4, 154, 1154);
    else
         -- ************* RU *************
        Insert into UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (1, 154, 2154);
        Insert into UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (2, 154, 3154);
        Insert into UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (3, 154, 2154);
        Insert into UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (4, 154, 3154);
    end if;
end;
/

