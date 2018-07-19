-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = ###
--define ssql_id  = 161,1161

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 161');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (161))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 161,1161');
end;
/
-- ***************************************************************************
-- ETL-24849      UPL - Исключить из выгрузки механизм упреждающей выгрузки отсутствующих полей для файлов CREDKZ, PRVN_DEALS_KL
-- COBUMMFO-8179  Для ММФО та Міленіум. Просимо відключити механізм опрацювання відсутності полей NDG і NDO при формуванні вивантаження файлів CREDKZ, PRVN_DEALS_KL
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (161,1161);

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
       sp.initiator,
       cc.ndg
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
 Values
   (161, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Кредитні угоди + МБДК', '7.2');

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
       sp.initiator,
       cc.ndg
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
 Values
   (1161, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Кредитні угоди + МБДК', '7.2');

end;
/

-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (161);

-- ***********************
-- UPL_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (161);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (161);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (161);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (161);

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
