-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую)
define sfile_id = 7110
define ssql_id  = 7110

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
-- ETL-20446   UPL - Оптимизация выгрузки uploading_pathes#56
-- collatnd0 (7110) Звязок договорів забезпечення з кредитними договорами  (для FineVare)
-- оптимизирован, условия не изменились
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

declare cl clob;
begin
cl:= to_clob(
'with       dt as ( select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual ),
     ARRG_ACC as ( select ACC, ACCS, max(IDUPD) as MAX_IDUPD
                     from BARS.CC_ACCP_UPDATE, dt
                    where EFFECTDATE between trunc(dt.dt1,''MM'') and dt.dt1
                      and CHGACTION in (''I'',''D'')
                    group by ACC, ACCS
                 ),
     ACCP_MCD as ( select u.ACC
                     from BARS.ACCOUNTS_UPDATE u, dt
                    where u.ACC in ( select ACC from ARRG_ACC )
                    group by u.ACC
                   having min(u.CHGDATE) < trunc(min(dt.dt1),''MM'')
                 ),
     ACCC_MCD as ( select u.ACC
                     from BARS.ACCOUNTS_UPDATE u, dt
                    where u.ACC in ( select ACCS from ARRG_ACC )
                    group by u.ACC
                   having min(u.CHGDATE) < trunc(min(dt.dt1),''MM'')
                 ),
       AGRACC as ( select KF, ACC, ACCS, CHGACTION
                     from BARS.CC_ACCP_UPDATE
                    where IDUPD in ( select ar.MAX_IDUPD
                                       from ARRG_ACC ar
                                       join ACCP_MCD ap on ( ap.ACC = ar.ACC )
                                       join ACCC_MCD ac on ( ac.ACC = ar.ACCS ) )
                 ),
            h as ( select /*+ MATERIALIZE */ kf, nd,
                         case vidd when 10 then 10 when 110 then 10 else 3 end as nd_type
                     from bars.cc_deal_update
                    where idupd in (select max(idupd) idupd
                                      from bars.cc_deal_update, dt
                                     where effectdate <= dt.dt1
                                     group by kf, nd)
                 ),
       CRDREL as ( select ni.ND, ni.ACC,
                          pi.ACC as COLL_ID,
                          count(unique ni.ACC) over (partition by ni.ND, pi.ACC) as TTL_ACC_QTY,
                          sum(case when ni.ACC = AGRACC.ACCS then 1 else 0 end) over (partition by ni.ND, pi.ACC) as CHG_ACC_QTY,
                          agracc.CHGACTION,
                          agracc.KF,
                          h.nd_type
                     from BARS.ND_ACC  ni
                          join h               on ( ni.kf = h.kf and ni.nd = h.nd )
                          join BARS.CC_ACCP pi on ( pi.ACCS = ni.ACC )
                          join AGRACC          on ( agracc.ACC = pi.ACC )
                 )
select UNIQUE
       5 as TYPE,
       COLL_ID,
       ND_TYPE,
       ND,
       KF,
       CHGACTION
  from CRDREL
 where ( CHGACTION = ''I'' and TTL_ACC_QTY = CHG_ACC_QTY )
    or ( CHGACTION = ''D'' and TTL_ACC_QTY = 0 )
 union all -- овердрафти
select UNIQUE
       5 as TYPE,
       AGRACC.ACC,
       10 as ND_TYPE,
       ov.ND,
       AGRACC.KF,
       AGRACC.CHGACTION
  from AGRACC,
       BARS.ACC_OVER ov
 where AGRACC.accS in ( coalesce(ov.acc,0), coalesce(ov.acco,0), coalesce(ov.acc_9129,0), coalesce(ov.acc_2067,0), coalesce(ov.acc_2069,0) )
    and coalesce(ov.sos,0) <> 110
 union all -- BPK (W4_ACC)
select UNIQUE
       5 as TYPE,
       AGRACC.ACC,
       4 as ND_TYPE,
       w4.ND,
       AGRACC.KF,
       AGRACC.CHGACTION
  from AGRACC,
       BARS.W4_ACC w4
 where AGRACC.accS in ( coalesce(w4.acc_ovr,0),  coalesce(w4.acc_pk,0),   coalesce(w4.acc_9129,0), coalesce(w4.acc_2209,0),
                        coalesce(w4.acc_2208,0), coalesce(w4.acc_2207,0), coalesce(w4.acc_2203,0) )
 union all -- BPK (BPK_ACC)
select UNIQUE
       5 as TYPE,
       AGRACC.ACC,
       4 as ND_TYPE,
       pk.nd,
       AGRACC.KF,
       AGRACC.CHGACTION
  from AGRACC,
       BARS.BPK_ACC pk
 where AGRACC.accS in ( coalesce(pk.acc_ovr,0),  coalesce(pk.acc_pk,0),   coalesce(pk.acc_9129,0), coalesce(pk.acc_2209,0),
                        coalesce(pk.acc_2208,0), coalesce(pk.acc_2207,0), coalesce(pk.acc_tovr, 0) )
 union all -- ЦП
select UNIQUE
       5 as TYPE,
       AGRACC.ACC,
       9 as ND_TYPE,
       cp.CP_REF as ND,
       AGRACC.KF,
       AGRACC.CHGACTION
  from AGRACC
  join BARS.CP_ACCOUNTS cp on ( cp.CP_ACC = AGRACC.accS )');


Insert into UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
    (7110, cl,
  'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', 
  NULL, 'Звязок договорів забезпечення з кредитними договорами  (для FineVare)', '2.2');
end;
/

-- ***********************
-- UPL_FILES
-- ***********************

-- ***********************
-- UPL_COLUMNS
-- ***********************

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
