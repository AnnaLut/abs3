-- ===================================================================================
-- Module : UPL
-- Date   : 17.05.2017
-- ===================================================================================
-- Запити на вивантаження даних у файли для DWH
-- ===================================================================================

delete from BARSUPL.UPL_SQL 
 where mod(SQL_ID,1000) IN (248, 343, 385, 386, 546, 261)	;	

delete from BARSUPL.UPL_SQL 
	where SQL_ID IN (134, 350, 351, 352, 353, 354, 355, 356 );


--
-- ETL-18563 UPL - Во время выгрузки файла 1248 Донецкого РУ ошибка ORA-01722: invalid number
--
prompt  Обновление запросов 248, 1248

Insert into BARSUPL.UPL_SQL  (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (248, 'select u.acc, bars.gl.kf, to_number(translate(trim(u.value),''.'','',''),''999999999990D0099999999'', '' NLS_NUMERIC_CHARACTERS = '''',.'''''') value, u.chgaction
  from BARS.ACCOUNTSW_UPDATE u
 where u.idupd in ( select MAX(u1.idupd)
                      from BARS.ACCOUNTSW_UPDATE u1
                     where u1.effectdate <= TO_DATE(:param1, ''dd/mm/yyyy'')
                       and u1.tag = ''SHTAR''
                     group by u1.acc )
   and u.value is not null', 'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Связь счета с пакетом тарифов',  '1.2');
Insert into BARSUPL.UPL_SQL  (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (1248, 'with dt as ( select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual )
select u.acc, bars.gl.kf, to_number(translate(trim(u.value),''.'','',''),''999999999990D0099999999'', '' NLS_NUMERIC_CHARACTERS = '''',.'''''') value, u.chgaction
  from BARS.ACCOUNTSW_UPDATE u
 where u.idupd in ( select MAX(u1.idupd)
                      from BARS.ACCOUNTSW_UPDATE u1, dt
                     where u1.effectdate between dt.dt1 and dt2
                       and u1.tag = ''SHTAR''
                     group by u1.acc )
   and u.value is not null', 'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Связь счета с пакетом тарифов',   '1.2');

-- 
-- UPL - ETL-18549 добавить в выгрузку файла COLLTYPES поля по 351 постанове: KOD_351, NAME_351, KL_351, KPZ_351
--

prompt  Обновление запроса 343

Insert into BARSUPL.UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (343, 'select ct.PAWN, ct.NAME, ct.S031, ct.D_CLOSE, ct.CODE,
       ct.GRP23    as GRP,
       cp.proc_imp as IMPL_PERCENT,
       cp.sum_imp  as IMPL_AMOUNT,
       cp.day_imp  as IMPL_DAYS,
       cp.EF       as EF,
       cp.HCC_M    as HCC_M,
       cp.ATR      as ATR,
       ct.PAWN_23  as PAWN_23 ,
       ct.KOD_351  as KOD_351,
       ct.NAME_351 as NAME_351,
       cp.KL_351   as KL_351,
       cp.KPZ_351  as KPZ_351
  from BARS.CC_PAWN ct
  left
  join BARS.CC_PAWN23ADD cp on ( cp.PAWN = ct.PAWN )
', 'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Види забезпечення', 
    '1.3');

--
-- UPL - ETL-18652 выгрузить справочник KL_S250 с созданием соответствующей ссылки на nbu23rez
--

prompt  Обновление запроса 385

Insert into BARSUPL.UPL_SQL    (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (385, 'select kl_.S250, kl_.TXT, kl_.DATA_O, kl_.DATA_C , kl_.DATA_M  from BARS.KL_S250 kl_ ', 'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', '', 'KL_S250 ', '1.0');

--
-- UPL - ETL-18654 выгрузить справочник GRP_PORTFEL с созданием соответствующей ссылки на nbu23rez
--

prompt  Обновление запроса 386

Insert into BARSUPL.UPL_SQL   (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (386, 'select spr.GRP, SPR.NAME , spr.name_short  from bars.GRP_PORTFEL  spr', 'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', '', 'Довідник груп несуттєвих фінансових активів', '1.0');


prompt FEEADJTXN0
-- FEEADJTXN0 (feeadjtxn0) / 546 ( ETL-18533 UPL - выгрузить корпроводки по дисконтам ежемесячно в Т0 )
-- новый файл
--
Insert into BARSUPL.UPL_SQL   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (546, 'select o.REF, o.STMT, o.KF, o.FDAT, o.S, o.SQ, o.TT, o.DK, o.ACC, d.VDAT
  from BARS.OPLDOK o join BARS.OPER d on ( d.REF = o.REF )
 where o.REF in ( select t.REF
                    from BARS.OPLDOK t
                    join BARS.OPER d
                      on ( d.REF = t.REF )
                   where ( t.FDAT, t.ACC ) in ( select FDAT, ACC
                                                  from BARS.SALDOA
                                                 where ACC in ( select ACC
                                                                  from BARS.ACCOUNTS
                                                                 where (NBS in (1215,1216,1315,1316,1325,1326,1335,1336,1406,1407,1416,
                                                                               1417,1426,1427,1436,1437,1446,1447,1515,1516,1525,1526,1615,
                                                                               1616,1625,1626,2015,2016,2026,2036,2065,2066,2075,2076,2085,
                                                                               2086,2105,2106,2115,2116,2125,2126,2135,2136,2205,2206,2215,
                                                                               2216,2226,2235,2236,2616,2617,2636,2637,2653,2656,2706,2707,
                                                                               3016,3017,3116,3117,3216,3217,3306,3307,3316,3317,3326,3327,
                                                                               3336,3337,3346,3347,3600,3666,3667)
                                                                    or TIP in (''SDI'', ''SPI''))
                                                                   and DAOS < trunc(to_date(:param1,''dd/mm/yyyy''),''MM'')
                                                                   and ( DAZS is Null or DAZS > trunc(to_date(:param1,''dd/mm/yyyy''),''MM'') )
                                                              )
                                                   and FDAT >= trunc(to_date(:param1,''dd/mm/yyyy''),''MM'')
                                                   and ( DOS <> 0 OR KOS <> 0 )
                                              )
                     and t.SOS = 5
                     and d.VOB = 96
                     and d.VDAT = BARS.DAT_NEXT_U(trunc(to_date(:param1,''dd/mm/yyyy''),''MM''),-1)
                )
   and o.TT not like ''PO_''
   and o.TT not like ''ZG_''',
   'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', '', 'Коригуючі транзакції по рахунках дисконту (для FineVare)', '1.0');

---
--- ETL-18408 UPL - выгрузить файлы по страховым договорам
---
prompt Запросы по таблицам страховых договоров

Insert into BARSUPL.UPL_SQL   (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (350, 'select bars.gl.kf as KF, 20 as TYPE, i.ID, i.BRANCH, i.STAFF_ID, i.CRT_DATE, i.PARTNER_ID, i.TYPE_ID, i.STATUS_ID, i.STATUS_DATE, i.STATUS_COMM, i.INS_RNK, i.SER, i.NUM, i.SDATE, i.EDATE, i.SUM, i.SUM_KV, i.INSU_TARIFF, i.INSU_SUM, i.OBJECT_TYPE, i.RNK, i.GRT_ID, i.ND, i.PAY_FREQ, i.RENEW_NEED, i.RENEW_NEWID
  from BARS.INS_DEALS i', 'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
   NULL, 'Страхові договори',   '1.0');
Insert into BARSUPL.UPL_SQL   (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (351, 'select bars.gl.kf as KF, i.ID, i.NAME, i.RNK, i.AGR_NO, i.AGR_SDATE, i.AGR_EDATE, i.TARIFF_ID, i.FEE_ID, i.LIMIT_ID, i.ACTIVE, i.CUSTTYPE
  from BARS.INS_PARTNERS i', 
  'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
   NULL, 'Акредитовані страхові компанії', '1.0');
Insert into BARSUPL.UPL_SQL   (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (352, 'select i.ID, i.NAME, i.OBJECT_TYPE
  from BARS.INS_TYPES i', 
  'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', 
  NULL, 'Типи договорiв страхування','1.0');
Insert into BARSUPL.UPL_SQL   (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (353, 'select i.ID, i.NAME
  from BARS.INS_OBJECT_TYPES i', 
  'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
   NULL, 'Типи обєктів страхування', '1.0');
Insert into BARSUPL.UPL_SQL   (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (354, 'select i.ID, i.NAME
  from BARS.INS_DEAL_STATUSES i', 
  'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
  NULL, 'Статуси договорів страхування', '1.0');
Insert into BARSUPL.UPL_SQL   (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (355, 'select bars.gl.kf as KF, i.ID, i.DEAL_ID, i.BRANCH, i.STAFF_ID, i.CRT_DATE, i.SER, i.NUM, i.SDATE
  from BARS.INS_ADD_AGREEMENTS i', 
  'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
   NULL, 'Дод. угоди до страхових договорів', '1.0');
Insert into BARSUPL.UPL_SQL   (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (356, 'select bars.gl.kf as KF, i.ID, 20 as TYPE, i.DEAL_ID, i.PLAN_DATE, i.FACT_DATE, i.PLAN_SUM, i.FACT_SUM, i.PMT_NUM, i.PMT_COMM, i.PAYED
  from BARS.INS_PAYMENTS_SCHEDULE i', 
  'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
   NULL, 'Графік платежів по страховим договорам', '1.0');

--- 
--- UPL - ETL-18729 - выгрузить справочник S080_FIN с созданием соответствующей ссылки на nbu23rez
--- 
prompt 134 справочник S080_FIN

Insert into BARSUPL.UPL_SQL   (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (134, 'select bars.gl.kf as KF, s.S080, s.TIP_FIN, s.FIN from BARS.S080_FIN s', 
  'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', 
  NULL, 'Таблица определения s080 по фин.стану',  '1.0');

--- 
--- UPL - ETL- - добавить новый тип договоров  20 - Договори страхування
--- 
prompt 261 справочник ARR_TYPES

Insert into BARSUPL.UPL_SQL
   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (261, 'select 1 as TYPE_ID, ''Депозити ФО'' as DESCRIPT from dual
 union all
select 2, ''Депозити ЮО'' from dual
 union all
select 3, ''Кредити''  from dual
 union all
select 4, ''БПК'' from dual
 union all
select 5, ''Забезпечення'' from dual
 union all
select 6, ''Текущие счета'' from dual
 union all
select 7, ''Транши'' from dual
 union all
select 8, ''Казначейство'' from dual
 union all
select 9, ''Ценные бумаги'' from dual
 union all
select 10, ''Овердрафты'' from dual
 union all
select 11, ''Договора РКО'' from dual
 union all
select 12, ''Договора абонплати'' from dual
 union all
select 13, ''Віртуальні субдоговора КП'' from dual
 union all
select 14, ''Документарні операції'' from dual
 union all
select 15, ''Дебіторська заборгованістості'' from dual
 union all
select 16, ''Віртуальні субдоговора БПК'' from dual
 union all
select 17, ''Віртуальні договора Фін. Дебіторки'' from dual
 union all
select 18, ''Депозитні сейфи'' from dual
 union all
select 19, ''Депозити КД'' from dual
 union all
select 20, ''Договори страхування'' from dual',
NULL, NULL, 'Види угод', '3.6');

--------------------------------------------------------------------------------------------------
prompt UPDATE BARSUPL.UPL_SQL.BEFORE_PROC
-- в BEFORE_PROC добавлен commit для пущей уверенности

-- RECEIVABLES / 113, 1113 Фінансова дебіторська заборгованість
--
update BARSUPL.UPL_SQL
   set vers = '1.3', 
 before_proc = 
 'begin' ||chr(13)||chr(10)||
 '  bars.tuda;' ||chr(13)||chr(10)||
 '  BARS.prvn_flow.ADD_FIN_DEB( to_date(:param1,''dd/mm/yyyy'') );' ||chr(13)||chr(10)||
 '  commit;' ||chr(13)||chr(10)||
 '  exception when' ||chr(13)||chr(10)|| 
 '      others then' ||chr(13)||chr(10)||  
 '       if sqlcode = -6550' ||chr(13)||chr(10)||  
 '           then null;' ||chr(13)||chr(10)||
 '           else raise;' ||chr(13)||chr(10)|| 
 '       end if;' ||chr(13)||chr(10)||
 'end;'
 where sql_id = 113;

update BARSUPL.UPL_SQL
   set vers = '1.3', before_proc = 
'begin' ||chr(13)||chr(10)||
' bars.tuda;' ||chr(13)||chr(10)||
' BARS.prvn_flow.ADD_FIN_DEB( to_date(:param1,''dd/mm/yyyy'') );' ||chr(13)||chr(10)||
' commit;' ||chr(13)||chr(10)||
' exception' ||chr(13)||chr(10)||
'  when others then' ||chr(13)||chr(10)||
'   if sqlcode = -6550' ||chr(13)||chr(10)||
'     then null;' ||chr(13)||chr(10)||
'     else raise;' ||chr(13)||chr(10)||
'   end if;' ||chr(13)||chr(10)||
'end;'
 where sql_id = 1113;

-- lossevent / 541, 7541 Події дефолту
--
update BARSUPL.UPL_SQL
   set vers = '1.10', before_proc = 
'declare' ||chr(13)||chr(10)||
'  l_report_date    date;  -- звітна дата' ||chr(13)||chr(10)||
'  l_last_work_day  date;  -- остан. робочий день звітного місяця' ||chr(13)||chr(10)||
'begin' ||chr(13)||chr(10)||
'  bars.tuda;' ||chr(13)||chr(10)||
'  l_report_date   := trunc(sysdate,''MM'');' ||chr(13)||chr(10)||
'  l_last_work_day := BARS.DAT_NEXT_U(last_day(to_date(:param1,''dd/mm/yyyy''))+1,-1);' ||chr(13)||chr(10)||
'  if ( to_date(:param1,''dd/mm/yyyy'') = l_last_work_day )' ||chr(13)||chr(10)||
'  then' ||chr(13)||chr(10)||
'    -- Формування місячного балансу' ||chr(13)||chr(10)||
'    begin' ||chr(13)||chr(10)||
'      BARS.MDRAPS(l_report_date-1);' ||chr(13)||chr(10)||
'    exception' ||chr(13)||chr(10)||
'      when OTHERS then' ||chr(13)||chr(10)||
'        bars.bars_audit.info(''BARSUPL: MDRAPS exit with error.'');' ||chr(13)||chr(10)||
'    end;' ||chr(13)||chr(10)||
'    -- Визначення критеріїв дефолту (без коригуючих)' ||chr(13)||chr(10)||
'    BARS.BARS_LOSS_EVENTS.loss_events( l_report_date, 0 );' ||chr(13)||chr(10)||
'    commit;' ||chr(13)||chr(10)||
'  end if;' ||chr(13)||chr(10)||
'end;'
 where sql_id = 541;

update BARSUPL.UPL_SQL
   set vers = '1.7', before_proc = 
'declare' ||chr(13)||chr(10)||
'  l_report_date    date;  -- звітна дата' ||chr(13)||chr(10)||
'begin' ||chr(13)||chr(10)||
'  bars.tuda;' ||chr(13)||chr(10)||
'  l_report_date := trunc(to_date(:param1,''dd/mm/yyyy''),''MM'');' ||chr(13)||chr(10)||
'  -- Визначення критеріїв дефолту (з коригуючими)' ||chr(13)||chr(10)||
'  BARS.BARS_LOSS_EVENTS.loss_events( l_report_date, 1 );' ||chr(13)||chr(10)||
'  commit;' ||chr(13)||chr(10)||
'end;'
 where sql_id = 7541;

-- PRVN_DEALS / 543, 7543 Таблиця КД-угод для сховища с доп. инфо на звитну дату
--
update BARSUPL.UPL_SQL
   set vers = '2.2', before_proc = 
'declare' ||chr(13)||chr(10)||
'  l_report_date    date;  -- звітна дата' ||chr(13)||chr(10)||
'  l_last_work_day  date;  -- остан. робочий день звітного місяця' ||chr(13)||chr(10)||
'begin' ||chr(13)||chr(10)||
'  bars.tuda;' ||chr(13)||chr(10)||
'  l_report_date   := trunc(sysdate,''MM'');' ||chr(13)||chr(10)||
'  l_last_work_day := BARS.DAT_NEXT_U(last_day(to_date(:param1,''dd/mm/yyyy''))+1,-1);' ||chr(13)||chr(10)||
'  if ( to_date(:param1,''dd/mm/yyyy'') = l_last_work_day )' ||chr(13)||chr(10)||
'  then' ||chr(13)||chr(10)||
'    -- Добавити НОВІ угоди по дату' ||chr(13)||chr(10)||
'    BARS.PRVN_FLOW.ADD1( l_report_date );' ||chr(13)||chr(10)||
'    -- Перерахунок Гр.потоків: Повний' ||chr(13)||chr(10)||
'    BARS.PRVN_FLOW.ADD2( 0, 0, l_report_date, 0 );' ||chr(13)||chr(10)||
'    commit;' ||chr(13)||chr(10)||
'  end if;' ||chr(13)||chr(10)||
'end;'
 where sql_id = 543;

update BARSUPL.UPL_SQL
   set vers = '1.9', before_proc = 
'declare' ||chr(13)||chr(10)||
'  l_report_date    date;  -- звітна дата' ||chr(13)||chr(10)||
'begin' ||chr(13)||chr(10)||
'  bars.tuda;' ||chr(13)||chr(10)||
'  l_report_date := trunc(to_date(:param1,''dd/mm/yyyy''),''MM'');' ||chr(13)||chr(10)||
'  -- Перерахунок Гр.потоків: Повний' ||chr(13)||chr(10)||
'  BARS.PRVN_FLOW.ADD2( 0, 0, l_report_date, 1 );' ||chr(13)||chr(10)||
'  commit;' ||chr(13)||chr(10)||
'end;'
 where sql_id = 7543;

-- CARD_LOANS / 545, 7545 Договора кредитних лімітів під БПК
--
update BARSUPL.UPL_SQL
   set vers = '1.4', before_proc = 
'declare' ||chr(13)||chr(10)||
'  l_report_date    date;  -- звітна дата' ||chr(13)||chr(10)||
'  l_last_work_day  date;  -- остан. робочий день звітного місяця' ||chr(13)||chr(10)||
'  l_adj_tp         pls_integer;  -- 1 - з / 0 - без коригуючих' ||chr(13)||chr(10)||
'begin' ||chr(13)||chr(10)||
'  bars.tuda;' ||chr(13)||chr(10)||
'  l_report_date   := trunc(sysdate,''MM'');' ||chr(13)||chr(10)||
'  l_last_work_day := BARS.DAT_NEXT_U(last_day(to_date(:param1,''dd/mm/yyyy''))+1,-1);' ||chr(13)||chr(10)||
'  if ( to_date(:param1,''dd/mm/yyyy'') = l_last_work_day )' ||chr(13)||chr(10)||
'  then' ||chr(13)||chr(10)||
'    l_adj_tp := 0; -- без коригуючих' ||chr(13)||chr(10)||
'    BARS.BPK_CREDITS.FILL_BPK_CREDIT_DEAL( l_report_date, l_adj_tp );' ||chr(13)||chr(10)||
'    commit;' ||chr(13)||chr(10)||
'  end if;' ||chr(13)||chr(10)||
'end;'
 where sql_id = 545;

update BARSUPL.UPL_SQL
   set vers = '1.2', before_proc = 
'declare' ||chr(13)||chr(10)||
'  l_report_date    date;  -- звітна дата' ||chr(13)||chr(10)||
'begin' ||chr(13)||chr(10)||
'  bars.tuda;' ||chr(13)||chr(10)||
'  l_report_date := trunc(to_date(:param1,''dd/mm/yyyy''),''MM'');' ||chr(13)||chr(10)||
'  BARS.BPK_CREDITS.FILL_BPK_CREDIT_DEAL( l_report_date, 1 );' ||chr(13)||chr(10)||
'  commit;' ||chr(13)||chr(10)||
'end;'
 where sql_id = 7545;



prompt UPDATE  bars.tuda -> barsupl.bars_upload_usr.tuda
-- все вызовы bars.tuda в before_proc переключить на barsupl.bars_upload_usr.tuda

update barsupl.upl_sql
   set before_proc = replace(before_proc, 'bars.tuda', 'barsupl.bars_upload_usr.tuda')
 where lower(before_proc) like '%bars.tuda%'
   and (sql_id between 100 and 9999 or sql_id > 99000);

commit;


