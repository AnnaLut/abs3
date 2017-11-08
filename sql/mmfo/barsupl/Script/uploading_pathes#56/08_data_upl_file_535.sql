-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую)
define sfile_id = 535
define ssql_id  = 535

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
-- ETL-XXX
-- agrmchg0 (535) Змінені параметри договорів (для FineVare)
-- изменения в связи с выделением ФДЗ
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

declare cl clob;
begin
cl:= to_clob(
 'with dt as ( select trunc(to_date (:param1, ''dd/mm/yyyy''),''MM'') dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual ),
     DEAL0 as ( select ND, WDATE, KAT23, case vidd when 10 then 10 when 110 then 10 when 26 then 19 else 3 end as ND_TYPE0
                  from BARS.CC_DEAL_UPDATE
                 where IDUPD in ( select max(IDUPD)
                                    from BARS.CC_DEAL_UPDATE, dt
                                   where EFFECTDATE < dt.dt1
                                   group by ND )
                   and SOS  >= 10
                   and VIDD Not in (3902,3903) ),
     DEALS as ( select d1.KF, d1.ND,
                        case d1.vidd when 10 then 10 when 110 then 10 when 26 then 19 else 3 end as ND_TYPE,
                       NULLIF( d1.WDATE, d0.WDATE ) as WDATE,
                       NULLIF( d1.KAT23, d0.KAT23 ) as KAT23
                  from DEAL0 d0
                  join ( select KF, ND, WDATE, KAT23, vidd
                           from BARS.CC_DEAL_UPDATE
                          where IDUPD in ( select max(IDUPD)
                                             from BARS.CC_DEAL_UPDATE, dt
                                            where EFFECTDATE <= dt.dt2
                                            group by ND )
                            and SOS  >= 10
                            and VIDD Not in (3902,3903)
                       ) d1
                    on ( d1.ND = d0.ND )
                 where NULLIF( d1.WDATE, d0.WDATE ) is Not Null
                    or NULLIF( d1.KAT23, d0.KAT23 ) is Not Null ),
    ACCLST as ( select a.KF, a.ACC, a.MDATE
                  from BARS.ACCOUNTS_UPDATE a, dt
                 where a.IDUPD in ( select max(u.IDUPD)
                                      from dt, BARS.ACCOUNTS_UPDATE u
                                      join BARS.PRVN_FIN_DEB al on ( al.ACC_SS = u.ACC )
                                     where u.EFFECTDATE between dt.dt1 and dt.dt2
                                     group by u.ACC )
              ),
    RECVBL as ( select 17 as ND_TYPE, a.KF, a.ACC as ND, NULLIF( a.MDATE, al0.MDATE ) as WDATE
                  from BARS.ACCOUNTS_UPDATE a,
                       ACCLST al0, dt
                 where a.IDUPD in ( select max(u.IDUPD)
                                      from dt, BARS.ACCOUNTS_UPDATE u
                                      join ACCLST al on ( al.ACC = u.ACC )
                                     where u.EFFECTDATE < dt.dt1
                                     group by u.ACC )
                   and al0.acc = a.acc
                   and NULLIF( a.MDATE, al0.MDATE ) is Not Null
                   and a.DAOS < dt.dt1
              ),
     SCRTD as ( select REF as ND, ACC, ID, ERAT
                  from BARS.CP_DEAL_UPDATE
                 where IDUPD in ( select max(IDUPD)
                                    from BARS.CP_DEAL_UPDATE, dt
                                   where EFFECTDATE < dt.dt1
                                   group by REF )
                   and ACTIVE = 1 ),
     SCRTS as ( select BARS.GL.KF, 9 as ND_TYPE, sd.ND, sd.ERAT
                     , sk.VNCRR, sk.KAT23, sk.IR
                  from SCRTD sd
                  join ( select s1.ID
                              , NULLIF( s1.VNCRR, s0.VNCRR ) as VNCRR
                              , NULLIF( s1.KAT23, s0.KAT23 ) as KAT23
                              , NULLIF( s1.IR,    s0.IR    ) as IR
                           from ( select ID, VNCRR, KAT23, IR
                                    from BARS.CP_KOD_UPDATE
                                   where IDUPD in ( select max(IDUPD)
                                                      from BARS.CP_KOD_UPDATE, dt
                                                     where EFFECTDATE < dt.dt1
                                                    group by ID )
                                ) s0
                           join ( select ID, VNCRR, KAT23, IR, DOK
                                    from BARS.CP_KOD_UPDATE
                                   where IDUPD in ( select max(IDUPD)
                                                      from BARS.CP_KOD_UPDATE, dt
                                                     where EFFECTDATE <= dt.dt2
                                                    group by ID )
                                ) s1
                             on ( s1.ID = s0.ID ),
                             dt
                          where DECODE( s1.VNCRR, s0.VNCRR, 1, 0 ) = 0
                             or DECODE( s1.KAT23, s0.KAT23, 1, 0 ) = 0
                             or ( DECODE( s1.IR, s0.IR, 1, 0 ) = 0 AND s1.DOK < dt.dt1 )
                       ) sk
                    on ( sk.ID = sd.ID )
              ),
     SCRTM as ( select BARS.GL.KF, 9 as ND_TYPE,
                       m1.ND, NULLIF( m1.MDATE, m0.MDATE ) as WDATE
                  from ( select au.ACC, au.MDATE
                           from BARS.ACCOUNTS_UPDATE au
                           join SCRTD sc
                             on ( sc.ACC = au.ACC )
                          where IDUPD = ( select max(IDUPD)
                                            from BARS.ACCOUNTS_UPDATE a, dt
                                           where a.EFFECTDATE < dt.dt1
                                             and a.ACC = au.ACC
                                           group by a.ACC )
                       ) m0
                  join ( select sc.ND, au.ACC, au.MDATE
                           from BARS.ACCOUNTS_UPDATE au
                           join SCRTD sc
                             on ( sc.ACC = au.ACC )
                          where IDUPD = ( select max(IDUPD)
                                            from BARS.ACCOUNTS_UPDATE a, dt
                                           where EFFECTDATE <= dt.dt2
                                             and a.ACC = au.ACC
                                           group by a.ACC )
                       ) m1
                    on ( m1.ACC = m0.ACC )
                 where NULLIF( m1.MDATE, m0.MDATE ) is Not Null
              ),
     OVERS as ( select o1.KF, 10 as ND_TYPE, o1.ND
                     , NULLIF( o1.KAT23, o0.KAT23 ) as KAT23
                  from ( select ND, KAT23
                           from BARS.ACC_OVER_UPDATE
                          where IDUPD in ( select max(IDUPD)
                                             from BARS.ACC_OVER_UPDATE, dt
                                            where EFFECTDATE < dt.dt1
                                              and ACC = ACCO
                                            group by ACC, ND )
                       ) o0
                  join ( select KF, ND, KAT23
                           from BARS.ACC_OVER_UPDATE
                          where IDUPD in ( select max(IDUPD)
                                             from BARS.ACC_OVER_UPDATE, dt
                                            where EFFECTDATE <= dt.dt2
                                              and ACC = ACCO
                                            group by ACC, ND )
                       ) o1
                    on ( o1.ND = o0.ND )
                 where NULLIF( o1.KAT23, o0.KAT23 ) is Not Null ),
    CARDS0 as ( select ND, KAT23, DAT_END
                  from BARS.W4_ACC_UPDATE
                 where IDUPD in ( select max(IDUPD)
                                    from BARS.W4_ACC_UPDATE, dt
                                   where EFFECTDATE < dt.dt1
                                   group by ND )
                 UNION ALL
                select ND, KAT23, Null
                  from BARS.BPK_ACC_UPDATE
                 where IDUPD in ( select max(IDUPD)
                                    from BARS.BPK_ACC_UPDATE, dt
                                   where EFFECTDATE < dt.dt1
                                   group by ND )
                   and CHGACTION <> ''D'' ),
     CARDS as ( select BARS.GL.KF, 4 as ND_TYPE, w1.ND
                     , NULLIF( w1.KAT23,   w0.KAT23   ) as KAT23
                     , NULLIF( w1.DAT_END, w0.DAT_END ) as DAT_END
                 from CARDS0 w0
                 join ( select ND, KAT23, DAT_END
                          from BARS.W4_ACC_UPDATE
                         where IDUPD in ( select max(IDUPD)
                                            from BARS.W4_ACC_UPDATE, dt
                                           where EFFECTDATE <= dt.dt2
                                           group by ND )
                         UNION ALL
                        select ND, KAT23, Null
                          from BARS.BPK_ACC_UPDATE
                         where IDUPD in ( select max(IDUPD)
                                            from BARS.BPK_ACC_UPDATE, dt
                                           where EFFECTDATE <= dt.dt2
                                           group by ND )
                           and CHGACTION <> ''D''
                      ) w1
                   on ( w1.ND = w0.ND )
                where NULLIF( w1.KAT23,   w0.KAT23   ) is Not Null
                   or NULLIF( w1.DAT_END, w0.DAT_END ) is Not Null ),
     XOZ   as ( select x.KF, 21 as ND_TYPE, ID as ND, X.MDATE
                  from bars.xoz_ref x
                  join bars.accounts a on (a.acc = x.acc)
                 where X.MDATE is not null )
select KF, ND_TYPE, ND,
       6, to_char(WDATE,''dd/mm/yyyy'')
  from DEALS
 where WDATE is Not Null
 UNION ALL
select KF, ND_TYPE, ND,
       7, to_char(KAT23)
  from DEALS
 where KAT23 is Not Null
 UNION ALL
select KF, ND_TYPE, ND,
       6, to_char(WDATE,''dd/mm/yyyy'')
  from RECVBL
 UNION ALL
select BARS.GL.KF, t0.ND_TYPE0 as ND_TYPE, t1.ND,
       case
         when t1.TAG = ''CPROD'' then 8
         when t1.TAG = ''VNCRR'' then 9
         else null
       end as PAR_ID,
       t1.TXT as PAR_VAL
  from BARS.ND_TXT_UPDATE t1
  join DEAL0 t0 -- договора кред. які існували на ост. роб. день міс.
    on ( t0.ND = t1.ND )
 where t1.IDUPD in ( select max(IDUPD)
                       from BARS.ND_TXT_UPDATE, dt
                      where TAG in ( ''CPROD'', ''VNCRR'' )
                        and EFFECTDATE between dt.dt1 and dt.dt2
                      group by ND, TAG )
 UNION ALL
select BARS.GL.KF, 4 as ND_TYPE, b1.ND,
       9 as PAR_ID,
       b1.VALUE as PAR_VAL
  from BARS.BPK_PARAMETERS_UPDATE b1
  join CARDS0 b0 -- договора БПК які існували на ост. роб. день міс.
    on ( b0.ND = b1.ND )
 where b1.IDUPD in ( select max(IDUPD)
                       from BARS.BPK_PARAMETERS_UPDATE, dt
                      where TAG in ( ''VNCRR'' )
                        and EFFECTDATE between dt.dt1 and dt.dt2
                      group by ND, TAG )
 UNION ALL
select KF, ND_TYPE, ND,
       9, VNCRR
  from SCRTS
 where VNCRR is Not Null
 UNION ALL
select KF, ND_TYPE, ND,
       7, to_char(KAT23)
  from SCRTS
 where KAT23 is Not Null
 UNION ALL
select KF, ND_TYPE, ND,
       11, to_char(IR,''FM99999900D009999999999'')
  from SCRTS
 where IR is Not Null
 UNION ALL
select KF, ND_TYPE, ND,
       12, to_char(ERAT,''FM99999900D009999999999'')
  from SCRTS
 where IR is Not Null
 UNION ALL
select KF, ND_TYPE, ND,
       6, to_char(WDATE,''dd/mm/yyyy'')
  from SCRTM
 UNION ALL
select KF, ND_TYPE, ND,
       7, to_char(KAT23)
  from OVERS
 where KAT23 is Not Null
  UNION ALL
select KF, ND_TYPE, ND, 6,
       to_char(DAT_END,''dd/mm/yyyy'')
  from CARDS
 where DAT_END is Not Null
 UNION ALL
select KF, ND_TYPE, ND, 7,
       to_char(KAT23)
  from CARDS
 where KAT23 is Not Null
 UNION ALL
select KF, ND_TYPE, ND,
       6, to_char(MDATE,''dd/mm/yyyy'')
  from XOZ');

Insert into UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
Values (535, cl,
       'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
        NULL, 'Змінені параметри договорів (для FineVare)', '2.2');
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

