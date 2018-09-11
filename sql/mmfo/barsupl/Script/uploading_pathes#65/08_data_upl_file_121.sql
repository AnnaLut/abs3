-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 121
--define ssql_id  = 1121

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 121');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (121))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 1121');
end;
/
-- ***************************************************************************
-- Оптимизация ежедневной выгрузки клиентов
-- 
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (1121);

declare l_clob clob;
begin
l_clob:= to_clob('with dt as ( select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual ),
     tabc as ( select u.* from bars.customer_update u
                where (u.rnk,u.idupd) in (select /*+ index(cu IDX_CUSTOMERUPD_GLBDT_EFFDT)*/ cu.rnk, max(cu.idupd)
                                            from bars.customer_update cu, dt
                                           where global_bdate >= dt.dt1
                                                and (effectdate <= dt.dt2 or effectdate > dt.dt2 and chgaction = 1)
                                           group by rnk) ),
     tabp as ( select *  from bars.person_update u
                where (rnk,idupd) in  (select /*+ index(cu IDX_PERSONUPD_GLBDT_EFFDT)*/ rnk, max(idupd)
                                         from bars.person_update cu, dt
                                           where global_bdate >= dt.dt1
                                                and (effectdate <= dt.dt2 or effectdate > dt.dt2 and chgaction = ''I'')
                                        group by rnk) ),
--     tabr as ( select *  from bars.corps_update u
--                where (rnk,idupd) in  (select rnk, max(idupd)
--                                         from bars.corps_update cu, dt
--                                           where global_bdate >= dt.dt1
--                                                and (effectdate <= dt.dt2 or effectdate > dt.dt2 and chgaction = ''I'')
--                                        group by rnk) ),
     tabw as (select * from bars.customerw_update w
               where w.idupd in (select max(cwu.idupd)
                                            from bars.customerw_update cwu, dt
                                           where cwu.chgdate >= dt1 and coalesce(cwu.effectdate,cwu.chgdate) < dt2+1
                                            and cwu.tag in (
                                                select tag
                                                from barsupl.upl_tag_lists l
                                                where l.tag_table = ''CUST_FIELD''
                                            )
                                           group by cwu.rnk) ),
     trnk as (select rnk from tabc union select rnk from tabp union select rnk from tabw)
select c.rnk, c.custtype, c.country, c.nmk, c.nmkv, c.codcagent, c.prinsider, c.okpo,
    c.adr, c.c_reg, c.c_dst, c.adm, c.date_on, c.date_off, c.notes, c.crisk, c.rnkp,
    c.ise, c.fs, c.oe, c.ved, c.sed, c.mb, c.bc, c.branch, bars.gl.kf, c.k050, c.isp, trim(w.val) vipk,
    case when i.rnk is null then (case when c.sab is null then 0 else 1 end ) else 2 end corp2flag,
    case when ca.rezid is null then 0 else 2 - ca.rezid end resident,
    c.nmkk, c.nmku
from (select t.rnk, cc.nmku,     --  cc.nmku має братися із оперативної таблиці
        nvl2(cu.rnk, cu.sab,       c.sab)       sab,
        nvl2(cu.rnk, cu.custtype,  c.custtype)  custtype,
        nvl2(cu.rnk, cu.country,   c.country)   country,
        nvl2(cu.rnk, cu.prinsider, c.prinsider) prinsider,
        nvl2(cu.rnk, cu.date_off,  c.date_off)  date_off,
        nvl2(cu.rnk, cu.notes,     c.notes)     notes,
        nvl2(cu.rnk, cu.crisk,     c.crisk)     crisk,
        nvl2(cu.rnk, cu.rnkp,      c.rnkp)      rnkp,
        nvl2(cu.rnk, cu.ise,       c.ise)       ise,
        nvl2(cu.rnk, cu.fs,        c.fs)        fs,
        nvl2(cu.rnk, cu.oe,        c.oe)        oe,
        nvl2(cu.rnk, cu.ved,       c.ved)       ved,
        nvl2(cu.rnk, trim(cu.sed), trim(c.sed)) sed,
        nvl2(cu.rnk, cu.mb,        c.mb)        mb,
        nvl2(cu.rnk, cu.bc,        c.bc)        bc,
        nvl2(cu.rnk, cu.branch,    c.branch)    branch,
        nvl2(cu.rnk, cu.k050,      c.k050)      k050,
        nvl2(cu.rnk, cu.isp,       c.isp)       isp,
        nvl2(cu.rnk, cu.nmkk,      c.nmkk)      nmkk,
        nvl2(cu.rnk, cu.nmk,       c.nmk)       nmk,
        nvl2(cu.rnk, cu.nmkv,      c.nmkv)      nmkv,
        nvl2(cu.rnk, cu.okpo,      c.okpo)      okpo,
        nvl2(cu.rnk, cu.adr,       c.adr)       adr,
        nvl2(cu.rnk, cu.adm,       c.adm)       adm,
        nvl2(cu.rnk, cu.c_reg,     c.c_reg)     c_reg,
        nvl2(cu.rnk, cu.c_dst,     c.c_dst)     c_dst,
        nvl2(cu.rnk, cu.date_on,   c.date_on)   date_on,
        nvl2(cu.rnk, cu.codcagent, c.codcagent) codcagent
      from  bars.customer c, tabc  cu, trnk t, bars.corps cc
      where  c.rnk = t.rnk  and c.rnk = cu.rnk(+) and c.rnk=cc.rnk(+)
    ) c,
    (select t.rnk,  substr(trim(coalesce(wu.value ,w.value )),1,1) val
      from bars.customerw   w, tabw  wu,  trnk t
     where w.rnk = t.rnk and w.rnk = wu.rnk (+) and wu.tag(+) = ''VIP_K'' and w.tag = ''VIP_K''
    ) w,
    barsaq.ibank_rnk i,
    bars.codcagent   ca
where c.rnk     = w.rnk(+)
    and c.rnk     = i.rnk(+)
    and c.codcagent = ca.codcagent(+)');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (1121, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Клієнти', '6.9');

end;
/

-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (sfile_id);

-- ***********************
-- UPL_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (sfile_id);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (sfile_id);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (sfile_id);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (sfile_id);

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
