-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 158
--define ssql_id  = 158,1158,2158,3158,4158,5158

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 158');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (158))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 158,1158,2158,3158,4158,5158');
end;
/
-- ***************************************************************************
-- TSK-0000806 ANL - анализ выгрузки кредита рассрочка (instalment)
-- COBUINST-14   Вивантаження даних для СД по продукту Instalment
-- добавить поле ACC15 для выгрузки счета 9129* для договоров Instolment
-- TSK-0001284 UPL - отключить  из АБС выгрузку ARR_ACC_2 для ND_TYPE=9
-- Для ND_TYPE=9 связки выгружаются в ARRACC6. По-этому в ARRACC2 они не нужны
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (158,1158,2158,3158,4158,5158);

declare l_clob clob;
begin
l_clob:= to_clob('with dt  as ( select bars_upload_usr.get_last_work_date(to_date(:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date(:param1, ''dd/mm/yyyy'') dt2 from dual ),
     --ac  as ( select au.acc, au.nbs, au.ob22, au.DAZS, au.globalbd, au.effectdate, au.daos  from BARS.ACCOUNTS_UPDATE au, dt where au.effectdate <= dt.dt2 ),
     ac1 as ( select unique a.ACC
                from BARS.ACCOUNTS a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_N,1,4) = a.nbs AND SubStr(f.nbs_N,5,2) = a.ob22 )
               --where f.MOD_ABS in ( 0, 1, 4, 5, 6 )
              union
              select unique a.ACC
                from dt, BARS.ACCOUNTS a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_P,1,4) = a.nbs AND SubStr(f.nbs_P,5,2) = a.ob22 )
               where ( a.DAZS Is Null or a.DAZS >= dt.dt2 )
                 --and f.MOD_ABS in ( 0, 1, 4, 5, 6 )
                 and f.nbs_P Is NOt Null
                 and a.ACC not In ( select ACC_SP from BARS.PRVN_FIN_DEB where ACC_SP is not null )
              union
              select unique b.ACC_SS
                from BARS.PRVN_FIN_DEB b
                ),
     --счета ФДЗ в архиве
     ac2 as ( select b.ACC_SS as acc, max(b.CLS_DT) as CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b
               group by b.ACC_SS
              union
              select b.ACC_SP, max(b.CLS_DT) as CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b
               where b.ACC_SP not in ( select ACC_SP from BARS.PRVN_FIN_DEB where ACC_SP is not null)
              group by b.ACC_SP),
     ac0 as ( select /*+ materialise */ acc from ac1 union select acc from ac2),
     --счета из архива, которые не проходят по маппингу (надо прислать с D)
     ac3 as ( select /*+ materialise */ ac2.acc, ac2.CLS_DT from ac2 left join ac1 on (ac2.acc = ac1.acc) where ac1.acc is null )
select w4.ND, 4 nd_type, bars.gl.kf, w4.chgaction,
       w4.ACC_PK,    w4.ACC_OVR,  w4.ACC_9129, w4.ACC_3570, w4.ACC_2208,
       w4.ACC_2627,  w4.ACC_2207, w4.ACC_3579, w4.ACC_2209, w4.ACC_2625X,
       w4.ACC_2627X, w4.ACC_2625D, w4.ACC_2628, w4.ACC_2203, w4.ACC_9129I, ''w'' PR_TYPE
  from BARS.W4_ACC_UPDATE w4
 where idupd in ( select MAX(IDUPD)
                    from BARS.w4_ACC_update, dt
                   where EFFECTDATE <= dt.dt2
                   group by nd )
 union all
select bpk.ND, 4 ND_TYPE, KF, bpk.chgaction,
       bpk.acc_pk, bpk.acc_ovr, bpk.acc_9129, bpk.acc_3570, bpk.acc_2208,
       null, bpk.acc_2207, bpk.acc_3579, bpk.acc_2209, bpk.acc_tovr,
       null, null, null, null, null, ''b'' PR_TYPE
  from BARS.BPK_ACC_UPDATE bpk
 where IDUPD in ( select MAX(IDUPD)
                    from BARS.BPK_ACC_UPDATE, dt
                   where EFFECTDATE <= dt.dt2
                   group by nd )
 union all
select a.ACC as ND, 17 as ND_TYPE, a.KF,
       case
         when ac3.CLS_DT is not Null and f.ACC_SS is Null then ''D''
         else decode(a.CHGACTION, 1, ''I'', ''U'')
       end     as CHGACTION,
       a.ACC, f.ACC_SP,
       null, null, null, null, null, null, null, null, null, null, null, null, null, null
  from dt, BARS.ACCOUNTS_UPDATE a
  left  join BARS.PRVN_FIN_DEB f      on ( f.ACC_SS = a.ACC )
  left  join ac3                      on ( ac3.ACC = a.ACC )
 where a.IDUPD in ( select max(u.IDUPD)
                      from BARS.ACCOUNTS_UPDATE u, dt, ac0
                     where u.effectdate <= dt.dt2
                       and u.ACC = ac0.acc
                     group by u.ACC )
   and a.DAOS <= dt.dt2');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (158, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
   NULL, 'Зв''язок угода-рахунок для виду 2 (БПК w4 + old + ФДЗ)', '5.4');

end;
/

declare l_clob clob;
begin
l_clob:= to_clob('with dt  as ( select bars_upload_usr.get_last_work_date(to_date(:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date(:param1, ''dd/mm/yyyy'') dt2 from dual ),
     ac  as ( select au.acc, au.nbs, au.ob22, au.DAZS, au.globalbd, au.effectdate, au.daos  from BARS.ACCOUNTS_UPDATE au, dt where au.globalbd >= dt.dt1 and au.effectdate <= dt.dt2 ),
     --измененные счета ФДЗ по маппингу
     ac1 as ( select unique a.ACC
                from ac a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_N,1,4) = a.nbs AND SubStr(f.nbs_N,5,2) = a.ob22 )
               --where f.MOD_ABS in ( 0, 1, 4, 5, 6 )
              union
              select unique a.ACC
                from dt, ac a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_P,1,4) = a.nbs AND SubStr(f.nbs_P,5,2) = a.ob22 )
               where ( a.DAZS Is Null or a.DAZS >= dt.dt2 )
                 --and f.MOD_ABS in ( 0, 1, 4, 5, 6 )
                 and f.nbs_P Is NOt Null
                 and a.ACC not In ( select ACC_SP from BARS.PRVN_FIN_DEB where ACC_SP is not null )
              union
              select unique b.ACC_SS
                from BARS.PRVN_FIN_DEB b, dt
               where b.EFFECTDATE between dt.dt2 and bars.gl.bd
               ),
     --счета ФДЗ в архиве
     ac2 as ( select b.ACC_SS as acc, max(b.CLS_DT) as CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b, dt
               where b.CLS_DT between dt.dt2 and bars.gl.bd
              group by b.ACC_SS
              union
              select b.ACC_SP, max(b.CLS_DT) as CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b, dt
               where b.CLS_DT between dt.dt2 and bars.gl.bd
                 and b.ACC_SP not in ( select ACC_SP from BARS.PRVN_FIN_DEB where ACC_SP is not null)
               group by b.ACC_SP),
     ac0 as ( select /*+ materialise */ acc from ac1 union select acc from ac2),
     --счета из архива, которые не проходят по маппингу (надо прислать с D)
     ac3 as ( select /*+ materialise */ ac2.acc, ac2.CLS_DT from ac2 left join ac1 on (ac2.acc = ac1.acc) where ac1.acc is null )
select w4.ND, 4 nd_type, bars.gl.kf, w4.chgaction,
       w4.ACC_PK,    w4.ACC_OVR,  w4.ACC_9129, w4.ACC_3570, w4.ACC_2208,
       w4.ACC_2627,  w4.ACC_2207, w4.ACC_3579, w4.ACC_2209, w4.ACC_2625X,
       w4.ACC_2627X, w4.ACC_2625D, w4.ACC_2628, w4.ACC_2203, w4.ACC_9129I, ''w'' PR_TYPE
  from BARS.W4_ACC_UPDATE w4
 where idupd in ( select MAX(IDUPD)
                    from BARS.w4_ACC_update, dt
                   where EFFECTDATE   <= dt.dt2
                     and GLOBAL_BDATE >= dt.dt1
                   group by nd )
 union all
select bpk.ND, 4 nd_type, KF, bpk.chgaction,
       bpk.acc_pk, bpk.acc_ovr, bpk.acc_9129, bpk.acc_3570, bpk.acc_2208,
       null,  bpk.acc_2207, bpk.acc_3579, bpk.acc_2209, bpk.acc_tovr,
       null, null, null, null, null, ''b'' PR_TYPE
  from BARS.BPK_ACC_UPDATE bpk
 where IDUPD in ( select MAX(IDUPD)
                    from BARS.BPK_ACC_UPDATE, dt
                   where EFFECTDATE   <= dt.dt2
                     and GLOBAL_BDATE >= dt.dt1
                   group by nd )
 union all
select a.ACC as ND, 17 as ND_TYPE, a.KF,
       case
         when ac3.CLS_DT is not Null and f.ACC_SS is Null then ''D''
         else decode(a.CHGACTION, 1, ''I'', ''U'')
       end     as CHGACTION,
       a.ACC, f.ACC_SP,
       null, null, null, null, null, null, null, null, null, null, null, null, null, null
  from dt, BARS.ACCOUNTS_UPDATE a
  left  join BARS.PRVN_FIN_DEB f      on ( f.ACC_SS = a.ACC )
  left  join ac3                      on ( ac3.ACC = a.ACC )
 where a.IDUPD in ( select max(u.IDUPD)
                      from BARS.ACCOUNTS_UPDATE u, dt, ac0
                     where u.effectdate <= dt.dt2
                       and u.ACC = ac0.acc
                     group by u.ACC )
   and a.DAOS <= dt.dt2');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (1158, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
   NULL, 'Зв''язок угода-рахунок для виду 2 (БПК w4 + old + ФДЗ)', '5.4');

end;
/

declare l_clob clob;
begin
l_clob:= to_clob('with dt  as ( select bars_upload_usr.get_last_work_date(to_date(:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date(:param1, ''dd/mm/yyyy'') dt2 from dual ),
     ac  as ( select au.acc, au.nbs, au.ob22, au.DAZS, au.globalbd, au.effectdate, au.daos  from BARS.ACCOUNTS_UPDATE au, dt where au.globalbd >= dt.dt1 and au.effectdate <= dt.dt2 ),
     --измененные счета ФДЗ по маппингу
     ac1 as ( select unique a.ACC
                from ac a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_N,1,4) = a.nbs AND SubStr(f.nbs_N,5,2) = a.ob22 )
               --where f.MOD_ABS in ( 0, 1, 4, 5, 6 )
              union
              select unique a.ACC
                from dt, ac a
                join BARS.FIN_DEBT f
                  on ( SubStr(f.nbs_P,1,4) = a.nbs AND SubStr(f.nbs_P,5,2) = a.ob22 )
               where ( a.DAZS Is Null or a.DAZS >= dt.dt2 )
                 --and f.MOD_ABS in ( 0, 1, 4, 5, 6 )
                 and f.nbs_P Is NOt Null
                 and a.ACC not In ( select ACC_SP from BARS.PRVN_FIN_DEB where ACC_SP is not null )
              union
              select unique b.ACC_SS
                from BARS.PRVN_FIN_DEB b, dt
               where b.EFFECTDATE between dt.dt2 and bars.gl.bd
               ),
     --счета ФДЗ в архиве
     ac2 as ( select b.ACC_SS as acc, max(b.CLS_DT) as CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b, dt
               where b.CLS_DT between dt.dt2 and bars.gl.bd
               group by b.ACC_SS
              union
              select b.ACC_SP, max(b.CLS_DT) as CLS_DT
                from BARS.PRVN_FIN_DEB_ARCH b, dt
               where b.CLS_DT between dt.dt2 and bars.gl.bd
                 and b.ACC_SP not in ( select ACC_SP from BARS.PRVN_FIN_DEB where ACC_SP is not null)
               group by b.ACC_SP),
     ac0 as ( select /*+ materialise */ acc from ac1 union select acc from ac2),
     --счета из архива, которые не проходят по маппингу (надо прислать с D)
     ac3 as ( select /*+ materialise */ ac2.acc, ac2.CLS_DT from ac2 left join ac1 on (ac2.acc = ac1.acc) where ac1.acc is null )
select w4.ND, 4 nd_type, bars.gl.kf, w4.chgaction,
       w4.ACC_PK,    w4.ACC_OVR,  w4.ACC_9129, w4.ACC_3570, w4.ACC_2208,
       w4.ACC_2627,  w4.ACC_2207, w4.ACC_3579, w4.ACC_2209, w4.ACC_2625X,
       w4.ACC_2627X, w4.ACC_2625D, w4.ACC_2628, w4.ACC_2203, ''w'' PR_TYPE
  from BARS.W4_ACC_UPDATE w4
 where idupd in ( select MAX(IDUPD)
                    from BARS.w4_ACC_update, dt
                   where EFFECTDATE <= dt.dt2
                   group by nd )
 union all
select bpk.ND, 4 nd_type, KF, bpk.chgaction,
       bpk.acc_pk, bpk.acc_ovr, bpk.acc_9129, bpk.acc_3570, bpk.acc_2208,
       null,  bpk.acc_2207, bpk.acc_3579, bpk.acc_2209, bpk.acc_tovr,
       null,      null,     null,     null, ''b'' PR_TYPE
  from BARS.BPK_ACC_UPDATE bpk
 where IDUPD in ( select MAX(IDUPD)
                    from BARS.BPK_ACC_UPDATE, dt
                   where EFFECTDATE   <= dt.dt2
                     and GLOBAL_BDATE >= dt.dt1
                   group by nd ) union all
select REF nd, 9 nd_type, bars.gl.kf, CHGACTION,
       acc, accd, accp, accr, accs, accr2,
       ACCEXPN, ACCEXPR, accr3,
       accunrec, null, null, null, null, null
  from BARS.CP_DEAL_UPDATE
 where IDUPD in ( select MAX(idupd)
                    from BARS.CP_DEAL_UPDATE, dt
                   where EFFECTDATE between dt.dt1 and dt.dt2
                   group by ref )
 union all
select a.ACC as ND, 17 as ND_TYPE, a.KF,
       case
         when ac3.CLS_DT is not Null and f.ACC_SS is Null then ''D''
         else decode(a.CHGACTION, 1, ''I'', ''U'')
       end     as CHGACTION,
       a.ACC, f.ACC_SP,
       null, null, null, null, null, null, null, null, null, null, null, null, null
  from dt, BARS.ACCOUNTS_UPDATE a
  left  join BARS.PRVN_FIN_DEB f      on ( f.ACC_SS = a.ACC )
  left  join ac3                      on ( ac3.ACC = a.ACC )
 where a.IDUPD in ( select max(u.IDUPD)
                      from BARS.ACCOUNTS_UPDATE u, dt, ac0
                     where u.effectdate <= dt.dt2
                       and u.ACC = ac0.acc
                     group by u.ACC )
   and a.DAOS <= dt.dt2');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (2158, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
   NULL, 'Зв''язок угода-рахунок для виду 2 (дельта + Full по W4) ММФО', '1.4');
end;
/

-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (158);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (158);

Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (158, 1, 'ND', 'Номер договору', 'NUMBER', 15, 0, NULL, 'Y', 'N', NULL, NULL, '-', 2, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (158, 2, 'ND_TYPE', 'Тип договора', 'NUMBER', 2, 0, NULL, 'Y', 'N', NULL, NULL, '0', 1, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (158, 3, 'KF', 'Код филиала', 'VARCHAR2', 6, NULL, NULL, 'Y', 'N', NULL, NULL, '-', 3, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (158, 4, 'CHGACTION', 'Тип изменений (I,U,D)', 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (158, 6, 'ACC1', 'Поточний картковий рахунок (ACC_PK)', 'NUMBER', 15, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (158, 7, 'ACC2', 'Кред. БПК (ACC_OVR)', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (158, 8, 'ACC3', 'Невикористаний ліміт(ACC_9129)', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (158, 9, 'ACC4', 'Нараховані доходи (комісії) (ACC_3570)', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (158, 11, 'ACC5', 'Счет проц.доходов за пользование кредитом (ACC_2208)', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (158, 12, 'ACC6', 'Нараховані доходи за кредитами овердрафт (ACC_2627)', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (158, 13, 'ACC7', 'Прострочена заборгованість за кредитами  (ACC_2207)', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (158, 14, 'ACC8', 'Прострочені нараховані доходи (комісії) (ACC_3579)', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (158, 15, 'ACC9', 'Прострочені нараховані доходи за кредитами  (ACC_2209)', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (158, 18, 'ACC10', '(ACC_2209)', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (158, 19, 'ACC11', 'Нараховані доходи за несанкціонований овердрафт (ACC_2627X)', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (158, 20, 'ACC12', 'Вклад на вимогу Мобільний (ACC_2625D)', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (158, 21, 'ACC13', 'Нараховані витрати за коштами на вимогу  (ACC_2628)', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (158, 22, 'ACC14', '(ACC_2203)', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (158, 23, 'ACC15', '(ACC_9129I)', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (158, 24, 'PR_TYPE', 'Тип процессинга (w/b - новый/старый)', 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);


-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (158);

Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (158, 'arracc2(ACC1,KF)_$_accounts(ACC,KF)',  1, 102);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (158, 'arracc2(ACC2,KF)_$_accounts(ACC,KF)',  1, 102);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (158, 'arracc2(ACC3,KF)_$_accounts(ACC,KF)',  1, 102);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (158, 'arracc2(ACC4,KF)_$_accounts(ACC,KF)',  1, 102);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (158, 'arracc2(ACC5,KF)_$_accounts(ACC,KF)',  1, 102);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (158, 'arracc2(ACC6,KF)_$_accounts(ACC,KF)',  1, 102);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (158, 'arracc2(ACC7,KF)_$_accounts(ACC,KF)',  1, 102);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (158, 'arracc2(ACC8,KF)_$_accounts(ACC,KF)',  1, 102);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (158, 'arracc2(ACC9,KF)_$_accounts(ACC,KF)',  1, 102);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (158, 'arracc2(ACC10,KF)_$_accounts(ACC,KF)', 1, 102);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (158, 'arracc2(ACC11,KF)_$_accounts(ACC,KF)', 1, 102);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (158, 'arracc2(ACC12,KF)_$_accounts(ACC,KF)', 1, 102);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (158, 'arracc2(ACC13,KF)_$_accounts(ACC,KF)', 1, 102);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (158, 'arracc2(ACC14,KF)_$_accounts(ACC,KF)', 1, 102);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (158, 'arracc2(ACC15,KF)_$_accounts(ACC,KF)', 1, 102);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (158, 'arracc2(KF)_$_banks(KF)', 1, 402);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (158, 'arracc2(ND_TYPE,ND,KF)_$_credkz(TYPE,ND,KF)', 1, 161);


-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (158);

Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC1,KF)_$_accounts(ACC,KF)', 1, 'ACC1');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC1,KF)_$_accounts(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC2,KF)_$_accounts(ACC,KF)', 1, 'ACC2');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC2,KF)_$_accounts(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC3,KF)_$_accounts(ACC,KF)', 1, 'ACC3');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC3,KF)_$_accounts(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC4,KF)_$_accounts(ACC,KF)', 1, 'ACC4');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC4,KF)_$_accounts(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC5,KF)_$_accounts(ACC,KF)', 1, 'ACC5');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC5,KF)_$_accounts(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC6,KF)_$_accounts(ACC,KF)', 1, 'ACC6');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC6,KF)_$_accounts(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC7,KF)_$_accounts(ACC,KF)', 1, 'ACC7');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC7,KF)_$_accounts(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC8,KF)_$_accounts(ACC,KF)', 1, 'ACC8');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC8,KF)_$_accounts(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC9,KF)_$_accounts(ACC,KF)', 1, 'ACC9');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC9,KF)_$_accounts(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC10,KF)_$_accounts(ACC,KF)', 1, 'ACC10');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC10,KF)_$_accounts(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC11,KF)_$_accounts(ACC,KF)', 1, 'ACC11');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC11,KF)_$_accounts(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC12,KF)_$_accounts(ACC,KF)', 1, 'ACC12');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC12,KF)_$_accounts(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC13,KF)_$_accounts(ACC,KF)', 1, 'ACC13');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC13,KF)_$_accounts(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC14,KF)_$_accounts(ACC,KF)', 1, 'ACC14');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC14,KF)_$_accounts(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC15,KF)_$_accounts(ACC,KF)', 1, 'ACC15');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ACC15,KF)_$_accounts(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(KF)_$_banks(KF)', 1, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ND_TYPE,ND,KF)_$_credkz(TYPE,ND,KF)', 3, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ND_TYPE,ND,KF)_$_credkz(TYPE,ND,KF)', 2, 'ND');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (158, 'arracc2(ND_TYPE,ND,KF)_$_credkz(TYPE,ND,KF)', 1, 'ND_TYPE');


-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (158);

Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (1, 158, 158);
Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (2, 158, 1158);
Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (3, 158, 158);
Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (4, 158, 1158);

/*
begin
    if  barsupl.bars_upload_utl.is_mmfo > 1 then
         -- ************* MMFO *************
    else
         -- ************* RU *************
    end if;
end;
/
*/
