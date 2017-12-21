-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
define sfile_id = 161
define ssql_id  = 161,1161

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
-- ETL-20783 UPL - создать новый файл с объедененными договорами credits и kazna
-- 
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

declare l_clob clob;
begin
l_clob:= to_clob('with dt as ( select /*+ materialize */ bars_upload_usr.get_last_work_date(to_date (:param1,''dd/mm/yyyy''))+1 dt1, to_date(:param1,''dd/mm/yyyy'') dt2 from dual),
    ccv as ( select /*+ materialize */ v.vidd, v.custtype, v.tipd
               from BARS.CC_VIDD v
              where (v.custtype = 1
                 or v.tipd = 1
                 or v.vidd in (select vidd from bars.v_mbdk_product where tipp = 1)
                 ) -- для МБК также актив+пасив, для остальных только актив (tipd=1) или вн.займ.
                and v.vidd Not In (137,237,337))
select case cc.vidd when 10 then 10 when 110 then 10 else 3 end as TYPE,
       cc.nd, cc.SOS, cc.CC_ID, cc.SDATE, cc.WDATE, cc.RNK, cc.VIDD, cc.LIMIT, cc.BRANCH, cc.KF, cc.IR,
       case when cc.PROD is null and v.custtype = 1 then a.nbs || nvl(a.ob22,''00'') else cc.PROD end as PROD,
       cc.SDOG, cc.FIN23, cc.NDI, cc.OBS23, cc.KAT23,
       case when nt.TXT = ''1'' then ''0'' else ''1'' end as RESTORE_FLAG,
       case when cc.VIDD in ( 2, 3, 12, 13, 9, 19, 29, 39 ) then 1 else 0 end as CRD_FACILITY,
       cc.K23, s.GPK_TYPE, coalesce(s.KV, ad.KV) KV, nvl(s.istval,0) as ISTVAL,
       case when v.custtype = 1 then decode(cc.sos, 15, d1.EFFECTDATE, decode(cc.chgaction, ''D'', cc.EFFECTDATE, Null ))
            else s.date_close_899 -- может прийти будущая для не банков
       end as DATE_CLOSE,
       cc.chgaction,
       cc.user_id,
       sp.initiator
  from bars.cc_deal_update  cc
  join ccv v  on ( v.vidd = cc.vidd )
  left join BARS.CC_ADD ad on ( ad.nd   = cc.nd  and ad.adds = 0 and ad.kf = cc.kf )
  left join BARS.ACCOUNTS a on ( a.acc  = ad.accs )
  left join BARS.SPECPARAM_CP_OB sp on ( sp.acc  = ad.accs )
  left join bars.nd_txt nt on ( nt.ND = cc.ND and nt.TAG = ''I_CR9'' )
  left join ( select n.nd, a.vid as GPK_TYPE, a.kv, s.ISTVAL, a.dazs as date_close_899
                from BARS.ND_ACC    n,
                     BARS.ACCOUNTS  a,
                     BARS.SPECPARAM s
               where n.acc = a.acc
                 and a.nls like ''899%''
                 and a.acc = s.acc(+)
            ) s  on ( s.nd = cc.nd )
  left join (select ud.effectdate, ud.nd
               from bars.cc_deal_update ud
              where ud.idupd in (select min(u.idupd) idupd
                                   from dt, bars.cc_deal_update u
                                    left join (select max(idupd) idupd, nd
                                                 from bars.cc_deal_update, dt
                                                where sos <> 15
                                                  and effectdate <= dt.dt2
                                                group by nd) u1 on (u.nd = u1.nd)
                                  where u.sos = 15
                                    and u.idupd >= nvl(u1.idupd,0)
                                    and effectdate <= dt.dt2
                                  group by u.nd, u1.nd
                                )
            ) d1 on (cc.nd = d1.nd)
 where cc.idupd = ( select max(idupd)
                      from BARS.CC_DEAL_UPDATE cu, dt
                     where cu.ND = cc.ND
                       and cu.EFFECTDATE <= dt.dt2 )
  and cc.sos > 0');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values (161, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Кредитні угоди + МБДК', '7.0');
end;
/

declare l_clob clob;
begin
l_clob:= to_clob('with dt as ( select /*+ materialize */ bars_upload_usr.get_last_work_date(to_date (:param1,''dd/mm/yyyy''))+1 dt1, to_date(:param1,''dd/mm/yyyy'') dt2 from dual),
    ccv as ( select /*+ materialize */ v.vidd, v.custtype, v.tipd
               from BARS.CC_VIDD v
              where (v.custtype = 1
                 or v.tipd = 1
                 or v.vidd in (select vidd from bars.v_mbdk_product where tipp = 1)
                 ) -- для МБК также актив+пасив, для остальных только актив (tipd=1) или вн.займ.
                and v.vidd Not In (137,237,337))
select case cc.vidd when 10 then 10 when 110 then 10 else 3 end as TYPE,
       cc.nd, cc.SOS, cc.CC_ID, cc.SDATE, cc.WDATE, cc.RNK, cc.VIDD, cc.LIMIT, cc.BRANCH, cc.KF, cc.IR,
       case when cc.PROD is null and v.custtype = 1 then a.nbs || nvl(a.ob22,''00'') else cc.PROD end as PROD,
       cc.SDOG, cc.FIN23, cc.NDI, cc.OBS23, cc.KAT23,
       case when nt.TXT = ''1'' then ''0'' else ''1'' end as RESTORE_FLAG,
       case when cc.VIDD in ( 2, 3, 12, 13, 9, 19, 29, 39 ) then 1 else 0 end as CRD_FACILITY,
       cc.K23, s.GPK_TYPE, coalesce(s.KV, ad.KV) KV, nvl(s.istval,0) as ISTVAL,
       case when v.custtype = 1 then decode(cc.sos, 15, d1.EFFECTDATE, decode(cc.chgaction, ''D'', cc.EFFECTDATE, Null ))
            else s.date_close_899 -- может прийти будущая для не банков
       end as DATE_CLOSE,
       cc.chgaction,
       cc.user_id,
       sp.initiator
  from bars.cc_deal_update  cc
  join ccv v  on ( v.vidd = cc.vidd )
  left join BARS.CC_ADD ad on ( ad.nd   = cc.nd  and ad.adds = 0 and ad.kf = cc.kf )
  left join BARS.ACCOUNTS a on ( a.acc  = ad.accs )
  left join BARS.SPECPARAM_CP_OB sp on ( sp.acc  = ad.accs )
  left join bars.nd_txt nt on ( nt.ND = cc.ND and nt.TAG = ''I_CR9'' )
  left join ( select n.nd, a.vid as GPK_TYPE, a.kv, s.ISTVAL, a.dazs as date_close_899
                from BARS.ND_ACC    n,
                     BARS.ACCOUNTS  a,
                     BARS.SPECPARAM s
               where n.acc = a.acc
                 and a.nls like ''899%''
                 and a.acc = s.acc(+)
            ) s  on ( s.nd = cc.nd )
  left join (select ud.effectdate, ud.nd
               from bars.cc_deal_update ud
              where ud.idupd in (select min(u.idupd) idupd
                                   from dt, bars.cc_deal_update u
                                    left join (select max(idupd) idupd, nd
                                                 from bars.cc_deal_update, dt
                                                where sos <> 15
                                                  and effectdate <= dt.dt2
                                                group by nd) u1 on (u.nd = u1.nd)
                                  where u.sos = 15
                                    and u.idupd >= nvl(u1.idupd,0)
                                    and effectdate <= dt.dt2
                                  group by u.nd, u1.nd
                                )
            ) d1 on (cc.nd = d1.nd)
 where cc.idupd = ( select max(idupd)
                      from BARS.CC_DEAL_UPDATE cu, dt
                     where cu.ND = cc.ND
                       and cu.EFFECTDATE between dt.dt1 and dt.dt2 )
  and cc.sos > 0');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values (1161, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', null, 'Кредитні угоди + МБДК', '7.0');
end;
/

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (&&sfile_id);

Insert into UPL_FILES (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, order_id, nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values (161, 161, 'CREDKZ', 'credkz', 0, '09', NULL, '10', 0, 'Кредитні угоди + МБДК', 9, 'null', 'DELTA', 'ARR', 1, NULL, 1, 'AR', 1, 1);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (&&sfile_id);

Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable,  null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 0, 'TYPE', 'Тип договора (кредиты)', 'NUMBER', 2, 0, NULL, 'Y', 'N', NULL, NULL, '0', 0, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 1, 'ND', 'Внутренний код договора для кредита', 'NUMBER', 15, 0, NULL, 'Y', 'N', NULL, NULL, '0', 1, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 2, 'SOS', 'СОСТОЯНИЕ договора', 'NUMBER', 2, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 3, 'CC_ID', 'Клиентски номер договора', 'VARCHAR2', 25, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', 'N/A', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 4, 'SDATE', 'Дата заключения договора', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '01.01.0001', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 5, 'WDATE', 'Дата завершения', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31.12.9999', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 6, 'RNK', 'Номер клиента', 'NUMBER', 15, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 7, 'VIDD', 'Код вида кредитного договора', 'NUMBER', 5, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 8, 'LIMIT', 'Лимит договора', 'NUMBER', 22, 4, '999999999999999990D0000', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 12, 'BRANCH', 'Код отделения', 'VARCHAR2', 22, NULL, NULL, NULL, 'N', NULL, NULL, 'N/A', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 13, 'KF', 'Код филиала', 'VARCHAR2', 6, NULL, NULL, 'Y', 'N', NULL, NULL, '0', 13, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 14, 'IR', 'Эталонная эффективная ставка для типов', 'NUMBER', 38, 30, '99999990D000000000000000000000000000000', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 15, 'PROD', 'Код продукта (nbs||ob22)', 'VARCHAR2', 6, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 16, 'SDOG', 'Начальная сумма 100.55 - в цел с коп', 'NUMBER', 22, 2, '99999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 18, 'FIN23', 'Класс заемщика по отношению к договору на основании фин.стана зхаемщика+обслуживание долга', 'NUMBER', 5, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 19, 'NDI', 'Внутренний код родительского кредитного договора для связанных договоров', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 21, 'OBS23', 'Код типа обслуживания долга', 'NUMBER', 5, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 22, 'KAT23', 'Код риска КД по НБУ (S080)', 'NUMBER', 5, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 23, 'RESTORE_FLAG', 'Возобновляемая или нет кр.линия', 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 24, 'CRD_FACILITY', 'Признак кредитной линии (0 - обычный кредит, 1 - кредит ная линия)', 'NUMBER', 1, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 28, 'K23', 'Коефициент риска', 'NUMBER', 22, 10, '999999999990D0000000000', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 29, 'GPK_TYPE', 'Тип графика (2 равными долями теля, 4 - ануитет)', 'NUMBER', 2, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 30, 'KV', 'Валюта договора', 'NUMBER', 3, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 31, 'ISTVAL', 'Наличие валютной выручки (1-да. 0 -нет)', 'NUMBER', 1, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 32, 'DATE_CLOSE', 'Дата закриття договору', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31.12.9999', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 33, 'CHGACTION', 'Тип изменений (I,U,D)', 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 34, 'USER_ID', 'Виконавець', 'NUMBER', 38, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 35, 'INITIATOR', 'Код инициатора', 'CHAR', 2, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (&&sfile_id);

Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (161, 'credkz(KF)_$_banks(KF)', 2, 402);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (161, 'credkz(kv)_$_tabval(kv)', 2, 296);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (161, 'credkz(BRANCH)_$_branch(BRANCH)', 2, 103);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (161, 'credkz(KF,RNK)_$_custmer(KF,RNK)', 3, 121);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (161, 'credkz(TYPE,NDI,KF)_$_credkz(TYPE,ND,KF)', 1, 161);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (161, 'credkz(USER_ID)_$_staffad(ID)', 2, 182);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (161, 'credkz(USER_ID,KF)_$_staff(ID,KF)', 2, 181);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (161, 'credkz(VIDD)_$_credtypes(VIDD)', 2, 301);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (161, 'credkz(fin23)_$_stanfin23(fin23)', 1, 128);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (161, 'credkz(kat23)_$_stanfin23(kat23)', 1, 127);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (161, 'credkz(obs23)_$_stanobs23(obs23)', 1, 126);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (&&sfile_id);

Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (161, 'credkz(KF)_$_banks(KF)', 1, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (161, 'credkz(kv)_$_tabval(kv)', 1, 'KV');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (161, 'credkz(BRANCH)_$_branch(BRANCH)', 1, 'BRANCH');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (161, 'credkz(KF,RNK)_$_custmer(KF,RNK)', 1, 'RNK');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (161, 'credkz(KF,RNK)_$_custmer(KF,RNK)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (161, 'credkz(TYPE,NDI,KF)_$_credkz(TYPE,ND,KF)', 1, 'TYPE');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (161, 'credkz(TYPE,NDI,KF)_$_credkz(TYPE,ND,KF)', 2, 'NDI');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (161, 'credkz(TYPE,NDI,KF)_$_credkz(TYPE,ND,KF)', 3, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (161, 'credkz(USER_ID)_$_staffad(ID)', 1, 'USER_ID');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (161, 'credkz(USER_ID,KF)_$_staff(ID,KF)', 1, 'USER_ID');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (161, 'credkz(USER_ID,KF)_$_staff(ID,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (161, 'credkz(VIDD)_$_credtypes(VIDD)', 1, 'VIDD');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (161, 'credkz(fin23)_$_stanfin23(fin23)', 1, 'FIN23');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (161, 'credkz(kat23)_$_stanfin23(kat23)', 1, 'KAT23');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (161, 'credkz(obs23)_$_stanobs23(obs23)', 1, 'OBS23');



-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (&&sfile_id);

Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (1, 161,  161);
Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (2, 161, 1161);
Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (3, 161,  161);
Insert into UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (4, 161, 1161);

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
