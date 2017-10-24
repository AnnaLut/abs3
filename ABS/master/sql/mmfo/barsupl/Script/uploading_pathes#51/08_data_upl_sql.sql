-- ===================================================================================
-- Module : UPL
-- Date   : 05.05.2017
-- ===================================================================================
-- Запити на вивантаження даних у файли для DWH
-- ===================================================================================

delete from BARSUPL.UPL_SQL 
 where mod(SQL_ID,1000) IN (125, 411, 412, 194, 525, 181, 182,  123, 160, 116, 534, 537, 555);

delete from BARSUPL.UPL_SQL 
    where SQL_ID IN (6113, 6241, 99104, 99196);


prompt custaddress
-- custaddress (CUSTOMER_ADDRESS) / 125 (ETL-17984 - брати KF з поля BRANCH батьківської таблиці)
--
Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
    values (125
, 'select ca.rnk, bars.gl.kf, ca.type_id, ca.country, ca.zip, ca.domain, ca.region, ca.locality,
       ca.address, ca.territory_id, ca.locality_type, ca.street_type, ca.street, ca.home_type, ca.home,
       ca.homepart_type, ca.homepart, ca.room_type, ca.room
from bars.customer_address ca join bars.customer c on ca.rnk=c.rnk
where c.branch like ''/''|| bars.gl.kf||''%'''
, 'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;'
, null, 'Адреси клієнтів (full)', '1.1'
);

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
    values (1125
, 'select ca.rnk, bars.gl.kf, ca.type_id, ca.country, ca.zip, ca.domain, ca.region, ca.locality,
    ca.address, ca.territory_id, ca.locality_type, ca.street_type, ca.street, ca.home_type, ca.home,
    ca.homepart_type, ca.homepart, ca.room_type, ca.room
from bars.customer_address_update ca
where ca.idupd in ( 
        select max(ca.idupd)
        from bars.customer_address_update ca join bars.customer c 
                on ca.rnk=c.rnk and c.branch like ''/''|| bars.gl.kf||''%''
        where effectdate = to_date(:param1, ''dd/mm/yyyy'')
        group by ca.rnk, ca.type_id 
    )'
, 'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;'
, null, 'Адреси клієнтів (part)', '1.1'
);

prompt receivables
-- receivables (RECEIVABLES) / 6113 (ETL-17774 - перелік ідентифікаторів CUSTOMER, ACCOUNT, AGREEMENT із оперативних таблиць)
--
Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
    values (6113
, '( select 17 as nd_type, a.acc nd, a.kf, cast(null as date) as sdate, cast(null as date) as wdate,
        cast(null as date) as date_close, 0 as sos, '' '' as cc_id, 0 rnk, '' '' branch
    from bars.fin_debt f join bars.accounts a on a.nbs=substr(f.nbs_n,1,4) and a.ob22=substr(f.nbs_n,5,2)
    where f.mod_abs in ( 0, 1, 4, 5, 6 )
  union all
  select 17 as nd_type, a.acc nd, a.kf, cast(null as date) as sdate, cast(null as date) as wdate,
        cast(null as date) as date_close, 0 as sos, '' '' as cc_id, 0 rnk, '' '' branch
    from bars.fin_debt f join bars.accounts a on a.nbs=substr(f.nbs_p,1,4) and a.ob22=substr(f.nbs_p,5,2)
        left join bars.prvn_fin_deb p on a.acc=p.acc_sp
    where f.mod_abs in ( 0, 1, 4, 5, 6 ) and p.acc_sp is null
)
union
select 17 as nd_type, acc_ss nd, bars.gl.kf kf, cast(null as date) as sdate, cast(null as date) as wdate,
        cast(null as date) as date_close, 0 as sos, '' '' as cc_id, 0 rnk, '' '' branch 
    from bars.prvn_fin_deb'
, 'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;'
, null, '!!! Для перевірки повноти інформації - всі УГОДИ ФДЗ із оперативної таблиці', '1.0'
);


prompt cards (BPK_UPL)
-- cards (BPK_UPL) / 6241 (ETL-17774 - перелік ідентифікаторів CUSTOMER, ACCOUNT, AGREEMENT із оперативних таблиць)
--
Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
    values (6241
, 'select 4 type, b.nd, bars.gl.kf, '' '' project_id, 0 product_id, 0 kv, 0 rnk, '' '' branch,
        cast(null as date) as DATE_BEGIN, cast(null as date) as DATE_END,
        cast(null as date) as DATE_CLOSE, 0 fin23, 0 obs23, 0 kat23, 0 k23, ''   '' tip
    from bars.bpk_acc b
union all
select 4 type, b.nd, bars.gl.kf, '' '' project_id, 0 product_id, 0 kv, 0 rnk, '' '' branch,
        cast(null as date) as DATE_BEGIN, cast(null as date) as DATE_END,
        cast(null as date) as DATE_CLOSE, 0 fin23, 0 obs23, 0 kat23, 0 k23, ''   '' tip
    from bars.w4_acc b'
, 'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;'
, null, '!!! Для перевірки повноти інформації - всі КАРТКОВІ УГОДИ із оперативної таблиці', '1.0'
);

prompt TRANSACTIONS
-- 99-а група - ETL-17786 - створено вивантаження для звіряння коригуючих проводок 
--      за період 01/11/2016 - 08/02/2017, запити 99104, 99196
Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
    values (99104
, 'select a.ref, a.stmt, a.kf,  a.fdat, a.s, a.sq, a.txt,  a.tt,
       decode (bars.gl.kf, ''300465'', ''/300465/000000/'', o.branch) as branch,
       o.sk,
       decode(vob,  96, 1,  99, 2,  0) adjflg,
       decode (bars.gl.kf, ''300465'', (select substr(value,1,2) from bars.operw w where w.ref = o.ref and W.TAG = ''CP_IN''), null) as initcode,
       a.dk,
       a.acc
  FROM bars.opldok a, bars.oper o
 WHERE a.REF = o.REF
   AND a.sos = 5
   AND o.vob in (96,97,98,99) 
   AND a.fdat between  TO_DATE (''01/11/2016'', ''dd/mm/yyyy'') and TO_DATE (''08/02/2017'', ''dd/mm/yyyy'')'
, 'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;'
, null, 'only once - ETL-17786'
, '1.0'
);

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
  values (99196
, 'select distinct o.REF, o.DEAL_TAG, o.TT, o.VOB, o.ND, o.PDAT, o.VDAT, o.KV, o.DK,
       o.S, o.SK, o.DATD, o.NAM_A, o.NLSA, o.MFOA, o.NAM_B, o.NLSB, o.MFOB, o.NAZN,
       o.ID_A, o.ID_B, o.BRANCH, o.USERID, o.KF, o.KV2, o.S2, o.REFL, o.REF_A
  FROM bars.opldok a, bars.oper o
 WHERE a.REF = o.REF
   AND a.sos = 5
   AND o.vob in (96,97,98,99) 
   AND a.fdat between  TO_DATE (''01/11/2016'', ''dd/mm/yyyy'') and TO_DATE (''08/02/2017'', ''dd/mm/yyyy'')'
, 'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;'
, null, 'only once - ETL-17786'
, '1.0'
);

--*************************************
prompt CCK_COLBB
-- из-за политик перед выполнением sql_text надо сделать suda и затем tuda
--
Insert into BARSUPL.UPL_SQL
   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (411, 'select COLBB_ID as ID, COLBB_NAME as NAME from BARS.CCK_COLBB', 
   'begin barsupl.bars_upload_usr.suda; end;',
   'begin barsupl.bars_upload_usr.tuda(null); end;',
   'Довідник: Колегіальний орган Банку, який прийняв рішення', 
   '1.0');

--*************************************
prompt CCK_CUSSEG
-- из-за политик перед выполнением sql_text надо сделать suda и затем tuda
--
Insert into BARSUPL.UPL_SQL
   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (412, 'select CUSSEG_ID as ID, CUSSEG_NAME as NAME from BARS.CCK_CUSSEG',
   'begin barsupl.bars_upload_usr.suda; end;',
   'begin barsupl.bars_upload_usr.tuda(null); end;',
   'Довідник: Сегмент клієнту', '1.0');


--*************************************
prompt OPER_BACK
-- дублі в REVERSALS за 29.03.2017 Закарпатське РУ (ETL-18090)
--
Insert into BARSUPL.UPL_SQL
   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (194, 'SELECT REF,  KF,   TT,  VOB,   DK, ND, VDAT, DATD, PDAT,
       MFOA, NLSA, KV,  NAM_A, S,  ID_A,
       MFOB, NLSB, KV2, NAM_B, S2, ID_B,
       NAZN, SK,   USERID,
       BRANCH, RVRS_DATE, RVRS_USERID, RVRS_VISA, RVRS_REASON
  FROM ( select o.REF,  o.KF,   o.TT,  o.VOB,  o.DK,  o.ND,
                o.VDAT, o.DATD, o.PDAT,
                o.MFOA, o.NLSA, o.KV,  o.NAM_A, o.S,  o.ID_A,
                o.MFOB, o.NLSB, o.KV2, o.NAM_B, o.S2, o.ID_B,
                o.NAZN, o.SK,   o.USERID,
                o.branch,
                v.dat     as rvrs_date,
                v.userid  as rvrs_userid,
                v.groupid as rvrs_visa,
                w.value   as rvrs_reason,
                rank() over (partition by v.ref order by v.dat, v.sqnc desc) as rec_amt
           from BARS.OPER o
           left
           join BARS.OPERW     w on (w.ref = o.ref)
           left
           join BARS.OPER_VISA v on (v.ref = o.ref)
          where o.vdat = to_date(:param1,''dd/mm/yyyy'')
            and o.sos < 0
            and w.tag = ''BACKR''
            and v.status = 3
       )
 WHERE REC_AMT = 1',
 'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Сторновані документи', '1.3');


--*************************************
prompt CP_MANY
-- KF брать из OPER
-- 
Insert into BARSUPL.UPL_SQL
   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (2525, 'select 9 as TYPE, o.KF, c.REF, c.FDAT, c.SS1, c.SDP, c.SN2 from BARS.CP_MANY c, bars.oper o where o.ref = c.ref',
    'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Грошові потоки по угодам з ЦП (full)', '1.1');
Insert into BARSUPL.UPL_SQL
   (sql_id, sql_text, before_proc, after_proc, descript, 
    vers)
 Values
   (3525, 'select 9 as TYPE, o.kf  as KF, u.REF, u.FDAT,
       u.SS1 as SS_AMOUNT,
       u.SDP as DP_AMOUNT,
       u.SN2 as SN_AMOUNT
  from BARS.CP_MANY_UPDATE u,
       bars.oper o
 where u.IDUPD in ( select max(IDUPD)
                      from BARS.CP_MANY_UPDATE
                      where REF in ( select REF
                                       from BARS.CP_MANY_UPDATE
                                      where EFFECTDATE = TO_DATE(:param1, ''dd/mm/yyyy'') )
                        and EFFECTDATE <= TO_DATE(:param1, ''dd/mm/yyyy'')
                      group by REF, FDAT )
   and u.CHGACTION <> ''D''
   and o.ref = u.ref',
   'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Грошові потоки по угодам з ЦП (part)', '1.3');

--*************************************
prompt CUSVALS
-- политики отключены БАРСом, сам накладываю фильтр по KF
-- 2116/5116 - полная выгрузка по тагу MPNO ETL-18397
Insert into BARSUPL.UPL_SQL   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (116, 'select rnk, bars.gl.kf, tag, value, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') chgaction
  from bars.customerw_update u
 where u.idupd in (select max(u1.idupd)
                     from bars.customerw_update u1, barsupl.upl_tag_lists l
                    where trim(u1.tag) = l.tag
                      and l.tag_table = ''CUST_FIELD''
                      and coalesce(u1.effectdate, chgdate) < to_date (:param1, ''dd/mm/yyyy'')+1
                    group by u1.rnk, u1.tag
                 )', 'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Значення додаткових реквізитів клієнта', 
    '2.3');

Insert into BARSUPL.UPL_SQL   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (1116, 'select rnk, bars.gl.kf, tag, value, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') chgaction
  from bars.customerw_update u
 where u.idupd in ( select max(u1.idupd)
                      from bars.customerw_update u1, barsupl.upl_tag_lists l
                     where trim(u1.tag) = l.tag
                       and l.tag_table = ''CUST_FIELD''
                       and greatest(coalesce(u1.effectdate,u1.chgdate),u1.chgdate) >= bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1
                       and coalesce(u1.effectdate,u1.chgdate) < to_date (:param1, ''dd/mm/yyyy'')+1
                     group by rnk, u1.tag
                  )',
 'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Значення додаткових реквізитів клієнта', 
    '2.4');

Insert into BARSUPL.UPL_SQL  (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (2116, 'select rnk, bars.gl.kf, tag, value, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') chgaction
  from bars.customerw_update u
 where u.idupd in ( select max(u1.idupd)
                      from bars.customerw_update u1,
                           barsupl.upl_tag_lists l
                     where trim(u1.tag) = l.tag
                       and l.tag_table = ''CUST_FIELD''
                       and greatest(coalesce(u1.effectdate,u1.chgdate),u1.chgdate) >= bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1
                       and coalesce(u1.effectdate,u1.chgdate) < to_date (:param1, ''dd/mm/yyyy'')+1
                       and l.tag not in (''MPNO'')
                     group by rnk, u1.tag
                  )
union all
select rnk, bars.gl.kf, tag, value, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') chgaction
  from bars.customerw_update u
 where u.idupd in ( select max(u1.idupd)
                      from bars.customerw_update u1,
                           barsupl.upl_tag_lists l
                     where trim(u1.tag) = l.tag
                       and l.tag_table = ''CUST_FIELD''
                       and coalesce(u1.effectdate, chgdate) < to_date (:param1, ''dd/mm/yyyy'')+1
                       and l.tag in (''MPNO'')
                     group by rnk, u1.tag
                  )',
'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, '!!! Часто потрібна версія запиту на щоденне вивантаження + повне ЛИШЕ за вказаними тегами', 
    '1.2');

Insert into BARSUPL.UPL_SQL  (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (5116, 'select rnk, bars.gl.kf, tag, value, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') chgaction
  from bars.customerw_update u
 where u.kf = bars.gl.kf
   and u.idupd in ( select max(u1.idupd)
                      from bars.customerw_update u1,
                           barsupl.upl_tag_lists l
                     where trim(u1.tag) = l.tag
                       and l.tag_table = ''CUST_FIELD''
                       and greatest(coalesce(u1.effectdate,u1.chgdate),u1.chgdate) >= bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1
                       and coalesce(u1.effectdate,u1.chgdate) < to_date (:param1, ''dd/mm/yyyy'')+1
                       and l.tag not in (''MPNO'')
                     group by rnk, u1.tag
                  )
union all
select rnk, bars.gl.kf, tag, value, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') chgaction
  from bars.customerw_update u
 where u.kf = bars.gl.kf
   and u.idupd in ( select max(u1.idupd)
                      from bars.customerw_update u1,
                           barsupl.upl_tag_lists l
                     where trim(u1.tag) = l.tag
                       and l.tag_table = ''CUST_FIELD''
                       and coalesce(u1.effectdate, chgdate) < to_date (:param1, ''dd/mm/yyyy'')+1
                       and l.tag in (''MPNO'')
                     group by rnk, u1.tag
                  )',
'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, '!!! Часто потрібна версія запиту на щоденне вивантаження + повне ЛИШЕ за вказаними тегами', 
    '1.2');

Insert into BARSUPL.UPL_SQL   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (3116, 'select rnk, bars.gl.kf, tag, value, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') chgaction
  from bars.customerw_update u
 where u.kf = bars.gl.kf
   and u.idupd in (  select max(u1.idupd)
                       from bars.customerw_update u1,
                            barsupl.upl_tag_lists l
                      where trim(u1.tag) = l.tag
                        and l.tag_table = ''CUST_FIELD''
                        and coalesce(u1.effectdate, chgdate) < to_date (:param1, ''dd/mm/yyyy'')+1
                      group by u1.rnk, u1.tag )', 'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Значення додаткових реквізитів клієнта', 
    '2.4');

Insert into BARSUPL.UPL_SQL   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (4116, 'select rnk, bars.gl.kf, tag, value, decode(chgaction, 2, ''U'', 3, ''D'', ''I'') chgaction
  from bars.customerw_update u
 where u.kf = bars.gl.kf
   and u.idupd in ( select max(u1.idupd)
                      from bars.customerw_update u1,
                           barsupl.upl_tag_lists l
                     where trim(u1.tag) = l.tag
                       and l.tag_table = ''CUST_FIELD''
                       and greatest(coalesce(u1.effectdate,u1.chgdate),u1.chgdate) >= bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1
                       and coalesce(u1.effectdate,u1.chgdate) < to_date (:param1, ''dd/mm/yyyy'')+1
                     group by rnk, u1.tag )', 'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Значення додаткових реквізитів клієнта', 
    '2.5');

--
prompt STAFF (staff) / 181 (ETL-18165 - UPL - переносим в справочники 
-- STAFFAD (staffad) в выгрузку файл 182 поле "Учетная запись в AD")
-- (181 возвращаем на предыдущую версию)
--
Insert into BARSUPL.UPL_SQL
   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (181, 'with is_mmfo_bd as (select /* materialize */ count(*) mmfo_bd from bars.mv_kf),
       is_mmfo_kf as (select /* materialize */ count(*) mmfo_kf from bars.mv_kf where kf = bars.gl.kf)
select s.ID, bars.gl.kf kf, s.FIO, s.LOGNAME, s.TYPE,
       s.TABN, s.DISABLE, s.CLSID,
       s.branch,
       s.ACTIVE, s.CREATED,
       case
         when s.BAX = 1 then CAST(Null AS DATE)
         else s.TBAX
       end EXPIRED
  from bars.staff$base    s,
       is_mmfo_bd mb
  where mb.mmfo_bd < 2
    and (s.branch like  ''/''||bars.gl.kf||''/%''
     or length(s.branch) < 8)',
    'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', 
     NULL, 'Справочник персонала банка', 
    '1.4');

prompt STAFF_AD (staffad)
-- 182 (ETL-18165 - UPL - создаем справочник, ( в staff убираем KF и додобавляем  поле "Учетная запись в AD")
--
Insert into BARSUPL.UPL_SQL
   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (182, 'select s.ID , 
       s.FIO, s.LOGNAME, s.TYPE,
       s.TABN, s.DISABLE, s.CLSID,
       s.branch,
       s.ACTIVE, s.CREATED,
       case
         when s.BAX = 1 then CAST(Null AS DATE)
         else s.TBAX
       end EXPIRED,
       A.ACTIVE_DIRECTORY_NAME
  from bars.staff$base    s left join  bars.staff_ad_user a on (S.ID=A.USER_ID)', 
 'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Справочник персонала банка', 
    '1.0');

--
prompt PERSON (person) / 123 (ETL-18224 - добавлена колонка "ORGAN")
--
Insert into BARSUPL.UPL_SQL
   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (123, 'select p.RNK,
       p.SEX,
       p.BDAY,
       p.PASSP,
       p.NUMDOC,
       p.SER,
       p.PDATE,
       p.TELD,
       p.TELW,
       BARS.GL.KF,
       p.organ
  from BARS.PERSON p
  join BARS.CUSTOMER c
    on ( c.RNK = p.RNK AND c.CUSTTYPE = 3 )
',
 'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Клієнти - фізичні особи', 
 '3.4');

Insert into BARSUPL.UPL_SQL
   (sql_id, sql_text, before_proc, after_proc, descript,  vers)
 Values
   (1123, 'with dt as ( select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual ),
     tabc as ( select cu.rnk
                 from bars.customer_update cu, dt
                   where global_bdate >= dt.dt1
                        and (effectdate <= dt.dt2 or effectdate > dt.dt2 and chgaction = 1)
                  and cu.custtype = 3
                group by rnk
             ),
     tabw as (select cwu.rnk
                from bars.customerw_update cwu, dt
                where cwu.chgdate >= dt1 and coalesce(cwu.effectdate,cwu.chgdate) < dt2+1
                     and cwu.tag in (
                        select tag
                        from barsupl.upl_tag_lists l
                        where l.tag_table = ''CUST_FIELD''
                     )
               group by cwu.rnk
             ),
     tabp as ( select cu.rnk
                 from bars.person_update cu, dt
                   where global_bdate >= dt.dt1
                        and (effectdate <= dt.dt2 or effectdate > dt.dt2 and chgaction = ''I'')
                group by cu.rnk
             ),
        t as (select rnk from tabc union select rnk from tabp union select rnk from tabw)
select u.rnk, u.sex, u.bday, u.passp, u.numdoc, u.ser, u.pdate, u.teld, u.telw, bars.gl.kf, u.organ
  from bars.person_update u
where u.idupd in (select max(cu.idupd)
                     from bars.person_update cu, t, dt
                    where global_bdate >= dt.dt1
                        and (effectdate <= dt.dt2 or effectdate > dt.dt2 and chgaction = ''I'')
                      and cu.rnk = t.rnk
                    group by cu.rnk)',
  'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Клієнти - фізичні особи', 
  '3.5');

--*************************************
prompt ARRACC3
-- политики на dpt_deposit_clos отключены БАРСом, сам накладываю фильтр по KF
-- ETL-18319 - в файлі ARRACC3 від головного приходять дані від криму 
--
Insert into BARSUPL.UPL_SQL
   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (160, 'select deposit_id nd, acc, d.kf, 1 ND_TYPE, decode(d.action_id, 0, ''I'', ''U'') chgaction
  from bars.dpt_deposit_clos d
 where idupd in (select MAX (idupd)
                   from bars.dpt_deposit_clos
                  where bdate <= TO_DATE (:param1, ''dd/mm/yyyy'')
                    and kf = bars.gl.kf
                  group by deposit_id)
union all
select d.dpu_id ND, d.acc, d.kf, 2 ND_TYPE,
       case when typeu = 0 then ''I'' when typeu in (2, 3, 1) then ''U'' when typeu = 9 then ''D'' end chgaction
  from bars.dpu_deal_update d
 where idu in (select MAX (idu)
                 from bars.dpu_deal_update
                where bdate <= TO_DATE (:param1, ''dd/mm/yyyy'')
                group by dpu_id)',
 'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Связ договор счет для  депозитных договоров (фл+юл)', 
    '2.7');

Insert into BARSUPL.UPL_SQL
   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (1160, 'select d.deposit_id, d.acc, d.kf, 1 ND_TYPE, decode(d.action_id, 0, ''I'', ''U'') chgaction
  from bars.dpt_deposit_clos d
 where idupd in (select MAX (idupd)
                   from bars.dpt_deposit_clos
                  where bdate between bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1
                                  and to_date (:param1, ''dd/mm/yyyy'')
                    and kf = bars.gl.kf
                  group by deposit_id)
union all
select d.dpu_id ND, d.acc, d.kf, 2 ND_TYPE,
       case when typeu = 0          then ''I''
            when typeu in (2, 3, 1) then ''U''
            when typeu = 9          then ''D'' end chgaction
  from bars.dpu_deal_update d
 where idu in (select MAX (idu)
                 from bars.dpu_deal_update
                where bdate between bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1
                                and to_date (:param1, ''dd/mm/yyyy'')
                group by dpu_id)',
 'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Связ договор счет для  депозитных договоров (фл+юл)', '2.8');

prompt ACNT_ADJ_BAL
-- CALCULATE_PROVISION( l_report_date, bars.gl.kf ) - добавлен параметр KF
--
Insert into BARSUPL.UPL_SQL
   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (537, 'select BARS.GL.KF, b.ACC,
       b.OST  - b.CRDOS  + b.CRKOS  as OST_COR,
       b.OSTQ - b.CRDOSQ + b.CRKOSQ as OST_COR_UAH
  from BARS.AGG_MONBALS b
  join BARS.ACCOUNTS    a
    on ( a.acc = b.acc )
  join BARSUPL.T0_NBS_LIST l
    on ( l.nbs = a.nbs AND nvl(a.OB22,''XX'') like l.OB22 )
 where b.fdat = add_months(trunc(to_date(:param1,''dd/mm/yyyy''),''MM''),-1)
   and ( b.CRDOS <> 0 or b.CRKOS <> 0 )
   and a.daos < trunc(to_date(:param1,''dd/mm/yyyy''),''MM'')
   and ( a.dazs is null or a.dazs >= trunc(to_date(:param1,''dd/mm/yyyy''),''MM'') )',
'declare' ||chr(13)||chr(10)||
'  l_report_date    date;  -- звітна дата' ||chr(13)||chr(10)||
'begin' ||chr(13)||chr(10)||
'  BARSUPL.bars_upload_usr.tuda;' ||chr(13)||chr(10)||
'  l_report_date := trunc(to_date(:param1,''dd/mm/yyyy''),''MM'');' ||chr(13)||chr(10)||
'  -- Формування резервів по НБУ23 у відкладеному режимі' ||chr(13)||chr(10)||
'  BARSUPL.CALCULATE_PROVISION( l_report_date, bars.gl.kf );' ||chr(13)||chr(10)||
'end;',
NULL, 'Залишки рахунків змінені коригуючими документами (для FineVare)', '1.7');


prompt CUST_CHANGES
-- CALCULATE_PROVISION1( l_report_date, bars.gl.kf ) - добавлен параметр KF
--
Insert into BARSUPL.UPL_SQL
   (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (534, 'with CUSTM as ( select BARS.GL.KF, c1.RNK,
                       NULLIF( c1.VED,     c0.VED     ) as VED,
                       NULLIF( c1.ISE,     c0.ISE     ) as ISE,
                       NULLIF( c1.K050,    c0.K050    ) as K050,
                       NULLIF( c1.COUNTRY, c0.COUNTRY ) as COUNTRY
                  from ( select RNK, VED, ISE, K050, COUNTRY
                           from BARS.CUSTOMER_UPDATE
                          where IDUPD in ( select max(IDUPD)
                                             from BARS.CUSTOMER_UPDATE
                                            where EFFECTDATE < trunc(to_date(:param1,''dd/mm/yyyy''),''MM'')
                                            group by RNK )
                       ) c0
                  join ( select RNK, VED, ISE, K050, COUNTRY
                           from BARS.CUSTOMER_UPDATE
                          where IDUPD in ( select max(IDUPD)
                                             from BARS.CUSTOMER_UPDATE
                                            where EFFECTDATE <= to_date(:param1,''dd/mm/yyyy'')
                                            group by RNK )
                       ) c1
                    on ( c1.RNK = c0.RNK )
                 where DECODE( c1.VED,     c0.VED,     1, 0 ) = 0
                    or DECODE( c1.ISE,     c0.ISE,     1, 0 ) = 0
                    or DECODE( c1.K050,    c0.K050,    1, 0 ) = 0
                    or DECODE( c1.COUNTRY, c0.COUNTRY, 1, 0 ) = 0 )
select KF, RNK
     , 1   as PAR_ID
     , VED as PAR_VAL
  from CUSTM
 where VED is Not Null
 union all
select KF, RNK, 2, ISE
  from CUSTM
 where ISE is Not Null
 union all
select KF, RNK, 3, K050
  from CUSTM
 where K050 is Not Null
  union all
select KF, RNK, 4, to_char(COUNTRY)
  from CUSTM
 where COUNTRY is Not Null',
'declare' ||chr(13)||chr(10)||
'  l_report_date    date;  -- звітна дата' ||chr(13)||chr(10)||
'begin' ||chr(13)||chr(10)||
'  BARSUPL.bars_upload_usr.tuda;' ||chr(13)||chr(10)||
'  l_report_date := trunc(to_date(:param1,''dd/mm/yyyy''),''MM'');' ||chr(13)||chr(10)||
'  -- Формування місячного балансу' ||chr(13)||chr(10)||
'  -- BARS_UTL_SNAPSHOT.sync_month(l_report_date-1);' ||chr(13)||chr(10)||
'  BARS.MDRAPS(l_report_date-1);' ||chr(13)||chr(10)||
'  -- Формування резервів по НБУ23 у відкладеному режимі' ||chr(13)||chr(10)||
'  BARSUPL.CALCULATE_PROVISION1( l_report_date, bars.gl.kf );' ||chr(13)||chr(10)||
'end;',
NULL, 'Змінені параметри клієнтів (для FineVare)', '1.9');

--*************************************
prompt NBU23_REZ
-- DWH ETL-18425 UPL - добавить в выгрузку NBU_23_REZ поля
--
Insert into BARSUPL.UPL_SQL
   (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (555, 'select bars.gl.kf as KF, nbu.FDAT, nbu.ID, nbu.RNK, nbu.NBS, nbu.KV, nbu.ND, nbu.CC_ID, nbu.ACC, nbu.NLS, nbu.BRANCH, nbu.FIN, nbu.OBS,
       nbu.KAT, nbu.K, nbu.IRR, nbu.ZAL, nbu.BV, nbu.PV, nbu.REZ, nbu.REZQ, nbu.DD, nbu.DDD, nbu.BVQ, nbu.CUSTTYPE, nbu.IDR, nbu.WDATE,
       nbu.OKPO, nbu.NMK, nbu.RZ, nbu.PAWN, nbu.ISTVAL, nbu.R013, nbu.REZN, nbu.REZNQ, nbu.ARJK, cast(null as number) REZD, nbu.PVZ, nbu.PVZQ, nbu.ZALQ,
       nbu.ZPR, nbu.ZPRQ, nbu.PVQ, nbu.RU, nbu.INN, nbu.NRC, nbu.SDATE, nbu.IR, nbu.S031, nbu.K040, nbu.PROD, nbu.K110, nbu.K070, nbu.K051,
       nbu.S260, nbu.R011, nbu.R012, nbu.S240, nbu.S180, nbu.S580, nbu.NLS_REZ, nbu.NLS_REZN, nbu.S250, nbu.ACC_REZ, nbu.FIN_R, nbu.DISKONT,
       nbu.ISP, nbu.OB22, nbu.TIP, nbu.SPEC, nbu.ZAL_BL, nbu.S280_290, nbu.ZAL_BLQ, nbu.ACC_REZN, nbu.OB22_REZ, nbu.OB22_REZN, nbu.IR0, nbu.IRR0,
       to_number(nbu.ND_CP, ''fm999999999999'') ND_CP, nbu.SUM_IMP, nbu.SUMQ_IMP, nbu.PV_ZAL, nbu.VKR, nbu.S_L, nbu.SQ_L, nbu.ZAL_SV, nbu.ZAL_SVQ,
       nbu.GRP, nbu.KOL_SP, nbu.REZ39, nbu.PVP, nbu.BV_30, nbu.BVQ_30, nbu.REZ_30, nbu.REZQ_30, nbu.NLS_REZ_30, nbu.ACC_REZ_30, nbu.OB22_REZ_30,
       nbu.BV_0, nbu.BVQ_0, nbu.REZ_0, nbu.REZQ_0, nbu.NLS_REZ_0, nbu.ACC_REZ_0, nbu.OB22_REZ_0, nbu.KAT39, nbu.REZQ39, nbu.S250_39, nbu.REZ23,
       nbu.REZQ23, nbu.KAT23, nbu.S250_23, nbu.tipa, DAT_MI, BVUQ, BVU,
       nbu.EAD, nbu.EADQ, nbu.CR, nbu.CRQ, nbu.FIN_351, nbu.KOL_351, nbu.KPZ, nbu.KL_351, nbu.LGD, nbu.OVKR, nbu.P_DEF, nbu.OVD,
       nbu.OPD, nbu.ZAL_351, nbu.ZALQ_351, nbu.RC, nbu.RCQ, nbu.CCF, nbu.TIP_351,
       nbu.PD_0, nbu.FIN_Z, nbu.ISTVAL_351, nbu.RPB, nbu.S080, NBU.S080_Z, nbu.ddd_6b, NBU.FIN_P, nbu.fin_d, nbu.z, nbu.pd
  from BARS.NBU23_REZ nbu,
       ( select MAX(TRUNC(ADD_MONTHS(dat, 1), ''MM'')) dat
           from BARS.REZ_PROTOCOL
          where dat <= TO_DATE (:param1, ''dd/mm/yyyy'')
       ) d
 where nbu.FDAT = d.DAT', 'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Протокол розрах реп по НБУ-23', 
    '1.5');

Insert into BARSUPL.UPL_SQL
   (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (1555, 'select bars.gl.kf as KF, nbu.FDAT, nbu.ID, nbu.RNK, nbu.NBS, nbu.KV, nbu.ND, nbu.CC_ID, nbu.ACC, nbu.NLS, nbu.BRANCH, nbu.FIN, nbu.OBS,
       nbu.KAT, nbu.K, nbu.IRR, nbu.ZAL, nbu.BV, nbu.PV, nbu.REZ, nbu.REZQ, nbu.DD, nbu.DDD, nbu.BVQ, nbu.CUSTTYPE, nbu.IDR, nbu.WDATE,
       nbu.OKPO, nbu.NMK, nbu.RZ, nbu.PAWN, nbu.ISTVAL, nbu.R013, nbu.REZN, nbu.REZNQ, nbu.ARJK, cast(null as number) REZD, nbu.PVZ, nbu.PVZQ, nbu.ZALQ,
       nbu.ZPR, nbu.ZPRQ, nbu.PVQ, nbu.RU, nbu.INN, nbu.NRC, nbu.SDATE, nbu.IR, nbu.S031, nbu.K040, nbu.PROD, nbu.K110, nbu.K070, nbu.K051,
       nbu.S260, nbu.R011, nbu.R012, nbu.S240, nbu.S180, nbu.S580, nbu.NLS_REZ, nbu.NLS_REZN, nbu.S250, nbu.ACC_REZ, nbu.FIN_R, nbu.DISKONT,
       nbu.ISP, nbu.OB22, nbu.TIP, nbu.SPEC, nbu.ZAL_BL, nbu.S280_290, nbu.ZAL_BLQ, nbu.ACC_REZN, nbu.OB22_REZ, nbu.OB22_REZN, nbu.IR0, nbu.IRR0,
       to_number(nbu.ND_CP, ''fm999999999999'') ND_CP, nbu.SUM_IMP, nbu.SUMQ_IMP, nbu.PV_ZAL, nbu.VKR, nbu.S_L, nbu.SQ_L, nbu.ZAL_SV, nbu.ZAL_SVQ,
       nbu.GRP, nbu.KOL_SP, nbu.REZ39, nbu.PVP, nbu.BV_30, nbu.BVQ_30, nbu.REZ_30, nbu.REZQ_30, nbu.NLS_REZ_30, nbu.ACC_REZ_30, nbu.OB22_REZ_30,
       nbu.BV_0, nbu.BVQ_0, nbu.REZ_0, nbu.REZQ_0, nbu.NLS_REZ_0, nbu.ACC_REZ_0, nbu.OB22_REZ_0, nbu.KAT39, nbu.REZQ39, nbu.S250_39, nbu.REZ23,
       nbu.REZQ23, nbu.KAT23, nbu.S250_23, nbu.tipa, DAT_MI, BVUQ, BVU,
       nbu.EAD, nbu.EADQ, nbu.CR, nbu.CRQ, nbu.FIN_351, nbu.KOL_351, nbu.KPZ, nbu.KL_351, nbu.LGD, nbu.OVKR, nbu.P_DEF, nbu.OVD,
       nbu.OPD, nbu.ZAL_351, nbu.ZALQ_351, nbu.RC, nbu.RCQ, nbu.CCF, nbu.TIP_351,
       nbu.PD_0, nbu.FIN_Z, nbu.ISTVAL_351, nbu.RPB, nbu.S080, NBU.S080_Z, nbu.ddd_6b, NBU.FIN_P, nbu.fin_d, nbu.z, nbu.pd
  from BARS.NBU23_REZ nbu,
       ( select MAX(TRUNC(ADD_MONTHS(dat, 1), ''MM'')) dat
           from BARS.REZ_PROTOCOL
          where dat_bank = TO_DATE (:param1, ''dd/mm/yyyy'')
       ) d
 where nbu.FDAT = d.DAT', 'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Протокол розрах реп по НБУ-23', 
    '1.5');

commit;
