-- ***************************************************************************
set verify off
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую)
define sfile_id = 147
define ssql_id  = 147,1147

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

-- ***********************
-- ETL-XXX
-- ccvals (147) Значення додаткових реквізитів угод банку
-- оптимизирован, условия не изменились
-- ***********************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

Insert into UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (147, 'with h as ( select /*+ MATERIALIZE */ kf, nd,
                   case vidd when 10 then 10 when 110 then 10 when 26 then 19 else 3 end as nd_type
              from bars.cc_deal_update
             where idupd in (select max(idupd) idupd
                               from bars.cc_deal_update
                              where effectdate <= to_date (:param1, ''dd/mm/yyyy'')
                              group by kf, nd))
select nd_.ND, nd_.TAG, nd_.TXT, nd_.KF,
       decode(nvl(tovr.nd, 0), 0, coalesce(h.nd_type,3), 10) as ND_TYPE,
       decode(chgaction, 2, ''U'', 3, ''D'', ''I'') as CHGACTION
  from BARS.ND_TXT_UPDATE nd_
       left join (select nd from BARS.acc_over_update group by nd) tovr on (nd_.nd=tovr.nd)
       left join h on (nd_.kf=h.kf and nd_.nd=h.nd)
where idupd in (select MAX(idupd)
                  from BARS.ND_TXT_UPDATE u, barsupl.upl_tag_lists l
                 where u.EFFECTDATE <= TO_DATE (:param1,''dd/mm/yyyy'')
                   and l.tag_table = ''CC_TAGS''
                   and trim(l.tag) = u.tag
                 group by u.nd, u.tag)
UNION ALL
select b.ND, b.TAG, b.VALUE, b.kf as KF, 4 as ND_TYPE, b.CHGACTION
  from BARS.BPK_PARAMETERS_UPDATE b
 where b.IDUPD in ( select MAX(u.idupd)
                      from BARS.BPK_PARAMETERS_UPDATE u
                      join BARSUPL.UPL_TAG_LISTS l on ( l.ISUSE = 1 and l.TAG = u.TAG )
                     where u.EFFECTDATE <= TO_DATE(:param1,''dd/mm/yyyy'')
                       and l.TAG_TABLE = ''BPK_TAGS''
                     group by u.ND, u.TAG )
   and b.CHGACTION <> ''D''
UNION ALL
select nd_.ND, nd_.TAG, nd_.TXT, nd_.KF, 19 as ND_TYPE,
       decode(chgaction, 2, ''U'', 3, ''D'', ''I'') as CHGACTION
  from BARS.ND_TXT_UPDATE nd_
 where idupd in (select MAX(idupd)
                   from BARS.ND_TXT_UPDATE u,
                        barsupl.upl_tag_lists l
                  where u.EFFECTDATE <= TO_DATE (:param1,''dd/mm/yyyy'')
                    and (l.tag_table = ''CD_TAGS''
                    and trim(l.tag) = u.tag)
                  group by u.nd, u.tag)',
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
 NULL, 'Значення додаткових реквізитів угод банку', 
    '2.2');

Insert into UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (1147, 'with tpdt as ( select bars_upload_usr.get_last_work_date(TO_DATE(:param1,''dd/mm/yyyy''))+1 as prv_bdate,
                      to_date(:param1,''dd/mm/yyyy'') as rpt_bdate
                 from dual ),
        h as (select /*+ MATERIALIZE */ kf, nd,
                     case vidd when 10 then 10 when 110 then 10 when 26 then 19 else 3 end as nd_type
                from bars.cc_deal_update
               where idupd in (select max(idupd) idupd
                                 from bars.cc_deal_update
                                where effectdate <= to_date (:param1, ''dd/mm/yyyy'')
                                group by kf, nd))
select nd_.ND, nd_.TAG, nd_.TXT, nd_.KF,
       decode(nvl(tovr.nd, 0), 0, coalesce(h.nd_type,3), 10) as ND_TYPE,
       decode(chgaction, 2, ''U'', 3, ''D'', ''I'') as CHGACTION
  from BARS.ND_TXT_UPDATE nd_
       left join (select nd from BARS.acc_over_update group by nd) tovr on nd_.nd=tovr.nd
       left join h on nd_.kf=h.kf and nd_.nd=h.nd
 where idupd in ( select MAX (idupd)
                    from BARS.ND_TXT_UPDATE u,
                         BARSUPL.UPL_TAG_LISTS l,
                         TPDT
                   where u.EFFECTDATE between tpdt.PRV_BDATE and tpdt.RPT_BDATE
                     and l.tag_table = ''CC_TAGS''
                     and l.tag = u.tag
                   group by u.nd, u.tag)
 union all
select b.ND, b.TAG, b.VALUE,
       BARS.gl.kf as KF, 4 as ND_TYPE, CHGACTION
  from BARS.BPK_PARAMETERS_UPDATE b
 where b.IDUPD in ( select MAX(u.idupd)
                      from BARS.BPK_PARAMETERS_UPDATE u
                      join BARSUPL.UPL_TAG_LISTS l on ( l.ISUSE = 1 and l.TAG = u.TAG )
                      join TPDT on ( u.EFFECTDATE between tpdt.PRV_BDATE and RPT_BDATE )
                     where l.TAG_TABLE = ''BPK_TAGS''
                     group by u.ND, u.TAG )
UNION ALL
select nd_.ND, nd_.TAG, nd_.TXT, nd_.KF,
       19 as ND_TYPE,
       decode(chgaction, 2, ''U'', 3, ''D'', ''I'') as CHGACTION
  from BARS.ND_TXT_UPDATE nd_
where idupd in (select MAX(idupd)
                   from BARS.ND_TXT_UPDATE u,
                        barsupl.upl_tag_lists l,
                        tpdt
                  where u.EFFECTDATE between tpdt.PRV_BDATE and tpdt.RPT_BDATE
                    and (l.tag_table = ''CD_TAGS''
                    and trim(l.tag) = u.tag)
                  group by u.nd, u.tag)',
'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
 NULL, 'Значення додаткових реквізитів угод банку', '2.2');

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

