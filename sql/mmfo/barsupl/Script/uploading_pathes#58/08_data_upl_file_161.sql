-- ***************************************************************************
set verify off
-- sfile_id ������������� ����� ��������
-- ssql_id �������������� �������� ��� ����� �������� (������ ����� �������, ��� ��������)
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
-- ETL-***
-- � �������� �������� ���� NDG - ��� ������������ ��
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

declare l_clob clob; l_clob_before clob;
begin
l_clob:= to_clob('with dt as ( select /*+ materialize */ bars_upload_usr.get_last_work_date(to_date (:param1,''dd/mm/yyyy''))+1 dt1, to_date(:param1,''dd/mm/yyyy'') dt2 from dual),
    ccv as ( select /*+ materialize */ v.vidd, v.custtype, v.tipd
               from BARS.CC_VIDD v
              where (v.custtype = 1
                 or v.tipd = 1
                 or v.vidd in (select vidd from bars.v_mbdk_product where tipp = 1)
                 ) -- ��� ��� ����� �����+�����, ��� ��������� ������ ����� (tipd=1) ��� ��.����.
                and v.vidd Not In (137,237,337))
select case cc.vidd when 10 then 10 when 110 then 10 else 3 end as TYPE,
       cc.nd, cc.SOS, cc.CC_ID, cc.SDATE, cc.WDATE, cc.RNK, cc.VIDD, cc.LIMIT, cc.BRANCH, cc.KF, cc.IR,
       case when cc.PROD is null and v.custtype = 1 then a.nbs || nvl(a.ob22,''00'') else cc.PROD end as PROD,
       cc.SDOG, cc.FIN23, cc.NDI, cc.OBS23, cc.KAT23,
       case when nt.TXT = ''1'' then ''0'' else ''1'' end as RESTORE_FLAG,
       case when cc.VIDD in ( 2, 3, 12, 13, 9, 19, 29, 39 ) then 1 else 0 end as CRD_FACILITY,
       cc.K23, s.GPK_TYPE, coalesce(s.KV, ad.KV) KV, nvl(s.istval,0) as ISTVAL,
       case when v.custtype = 1 then decode(cc.sos, 15, d1.EFFECTDATE, decode(cc.chgaction, ''D'', cc.EFFECTDATE, Null ))
            else s.date_close_899 -- ����� ������ ������� ��� �� ������
       end as DATE_CLOSE,
       cc.chgaction,
       cc.user_id,
       sp.initiator,
       ng.ndg
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
   left join BARSUPL.TMP_CREDKZ_NDG ng on (cc.idupd = ng.idupd)
 where cc.idupd = ( select max(idupd)
                      from BARS.CC_DEAL_UPDATE cu, dt
                     where cu.ND = cc.ND
                       and cu.EFFECTDATE <= dt.dt2 )
  and cc.sos > 0');

l_clob_before:= to_clob('declare
  l_ndg_cnt number;
  l_stmt    varchar2(500);
begin
  -- ���� ���� CC_DEAL_UPDATE.NDG ��� � �������, ���������� TEMPORARY TABLE ��� ��������
  begin
    execute immediate ''begin barsupl.bars_upload_usr.tuda; end;'';
  exception when others then if sqlcode = -6550 then null; else raise; end if;
  end;

  begin
      l_stmt := ''CREATE GLOBAL TEMPORARY TABLE BARSUPL.TMP_CREDKZ_NDG
                    ( IDUPD       NUMBER,
                      NDG         NUMBER,
                      KF          VARCHAR2(6)
                    ) ON COMMIT PRESERVE ROWS'';
      execute immediate l_stmt;
  exception
    when others then
         if sqlcode = -955 then
          l_stmt := ''truncate table BARSUPL.TMP_CREDKZ_NDG'';
          execute immediate l_stmt;
          null;
         else raise;
         end if;
  end;

  select count(*)
    into l_ndg_cnt
    from all_TAB_COLS
   where owner = ''BARS''
     and table_name = ''CC_DEAL_UPDATE''
     and COLUMN_NAME = ''NDG'';

  if l_ndg_cnt > 0 then
     l_stmt := ''insert into BARSUPL.TMP_CREDKZ_NDG select idupd, ndg, kf from bars.CC_DEAL_UPDATE where ndg is not null'';
     execute immediate l_stmt;
     commit;
  end if;

end;');

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values (161, l_clob, l_clob_before, NULL, '������� ����� + ����', '7.1');

end;
/

declare l_clob clob; l_clob_before clob;
begin
l_clob:= to_clob('with dt as ( select /*+ materialize */ bars_upload_usr.get_last_work_date(to_date (:param1,''dd/mm/yyyy''))+1 dt1, to_date(:param1,''dd/mm/yyyy'') dt2 from dual),
    ccv as ( select /*+ materialize */ v.vidd, v.custtype, v.tipd
               from BARS.CC_VIDD v
              where (v.custtype = 1
                 or v.tipd = 1
                 or v.vidd in (select vidd from bars.v_mbdk_product where tipp = 1)
                 ) -- ��� ��� ����� �����+�����, ��� ��������� ������ ����� (tipd=1) ��� ��.����.
                and v.vidd Not In (137,237,337))
select case cc.vidd when 10 then 10 when 110 then 10 else 3 end as TYPE,
       cc.nd, cc.SOS, cc.CC_ID, cc.SDATE, cc.WDATE, cc.RNK, cc.VIDD, cc.LIMIT, cc.BRANCH, cc.KF, cc.IR,
       case when cc.PROD is null and v.custtype = 1 then a.nbs || nvl(a.ob22,''00'') else cc.PROD end as PROD,
       cc.SDOG, cc.FIN23, cc.NDI, cc.OBS23, cc.KAT23,
       case when nt.TXT = ''1'' then ''0'' else ''1'' end as RESTORE_FLAG,
       case when cc.VIDD in ( 2, 3, 12, 13, 9, 19, 29, 39 ) then 1 else 0 end as CRD_FACILITY,
       cc.K23, s.GPK_TYPE, coalesce(s.KV, ad.KV) KV, nvl(s.istval,0) as ISTVAL,
       case when v.custtype = 1 then decode(cc.sos, 15, d1.EFFECTDATE, decode(cc.chgaction, ''D'', cc.EFFECTDATE, Null ))
            else s.date_close_899 -- ����� ������ ������� ��� �� ������
       end as DATE_CLOSE,
       cc.chgaction,
       cc.user_id,
       sp.initiator,
       ng.ndg
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
   left join BARSUPL.TMP_CREDKZ_NDG ng on (cc.idupd = ng.idupd)
 where cc.idupd = ( select max(idupd)
                      from BARS.CC_DEAL_UPDATE cu, dt
                     where cu.ND = cc.ND
                       and cu.EFFECTDATE between dt.dt1 and dt.dt2 )
  and cc.sos > 0');
l_clob_before:= to_clob('declare
  l_ndg_cnt number;
  l_stmt    varchar2(500);
begin
  -- ���� ���� CC_DEAL_UPDATE.NDG ��� � �������, ���������� TEMPORARY TABLE ��� ��������
  begin
    execute immediate ''begin barsupl.bars_upload_usr.tuda; end;'';
  exception when others then if sqlcode = -6550 then null; else raise; end if;
  end;

  begin
      l_stmt := ''CREATE GLOBAL TEMPORARY TABLE BARSUPL.TMP_CREDKZ_NDG
                    ( IDUPD       NUMBER,
                      NDG         NUMBER,
                      KF          VARCHAR2(6)
                    ) ON COMMIT PRESERVE ROWS'';
      execute immediate l_stmt;
  exception
    when others then
         if sqlcode = -955 then
          l_stmt := ''truncate table BARSUPL.TMP_CREDKZ_NDG'';
          execute immediate l_stmt;
          null;
         else raise;
         end if;
  end;

  select count(*)
    into l_ndg_cnt
    from all_TAB_COLS
   where owner = ''BARS''
     and table_name = ''CC_DEAL_UPDATE''
     and COLUMN_NAME = ''NDG'';

  if l_ndg_cnt > 0 then
     l_stmt := ''insert into BARSUPL.TMP_CREDKZ_NDG select idupd, ndg, kf from bars.CC_DEAL_UPDATE where ndg is not null'';
     execute immediate l_stmt;
     commit;
  end if;

end;');

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values (1161, l_clob, l_clob_before, NULL, '������� ����� + ����', '7.1');

end;
/

-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (&&sfile_id);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (&&sfile_id);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 0, 'TYPE', '��� �������� (�������)', 'NUMBER', 2, 0, NULL, 'Y', 'N', NULL, NULL, '0', 0, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 1, 'ND', '���������� ��� �������� ��� �������', 'NUMBER', 15, 0, NULL, 'Y', 'N', NULL, NULL, '0', 1, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 2, 'SOS', '��������� ��������', 'NUMBER', 2, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 3, 'CC_ID', '��������� ����� ��������', 'VARCHAR2', 25, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 4, 'SDATE', '���� ���������� ��������', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '01.01.0001', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 5, 'WDATE', '���� ����������', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31.12.9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 6, 'RNK', '����� �������', 'NUMBER', 15, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 7, 'VIDD', '��� ���� ���������� ��������', 'NUMBER', 5, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 8, 'LIMIT', '����� ��������', 'NUMBER', 22, 4, '999999999999999990D0000', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 12, 'BRANCH', '��� ���������', 'VARCHAR2', 22, NULL, NULL, NULL, 'N', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 13, 'KF', '��� �������', 'VARCHAR2', 6, NULL, NULL, 'Y', 'N', NULL, NULL, '0', 13, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 14, 'IR', '��������� ����������� ������ ��� �����', 'NUMBER', 38, 30, '99999990D000000000000000000000000000000', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 15, 'PROD', '��� �������� (nbs||ob22)', 'VARCHAR2', 6, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 16, 'SDOG', '��������� ����� 100.55 - � ��� � ���', 'NUMBER', 22, 2, '99999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 18, 'FIN23', '����� �������� �� ��������� � �������� �� ��������� ���.����� ���������+������������ �����', 'NUMBER', 5, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 19, 'NDI', '���������� ��� ������������� ���������� �������� ��� ��������� ���������', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 21, 'OBS23', '��� ���� ������������ �����', 'NUMBER', 5, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 22, 'KAT23', '��� ����� �� �� ��� (S080)', 'NUMBER', 5, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 23, 'RESTORE_FLAG', '�������������� ��� ��� ��.�����', 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 24, 'CRD_FACILITY', '������� ��������� ����� (0 - ������� ������, 1 - ������ ��� �����)', 'NUMBER', 1, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 28, 'K23', '���������� �����', 'NUMBER', 22, 10, '999999999990D0000000000', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 29, 'GPK_TYPE', '��� ������� (2 ������� ������ ����, 4 - �������)', 'NUMBER', 2, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 30, 'KV', '������ ��������', 'NUMBER', 3, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 31, 'ISTVAL', '������� �������� ������� (1-��. 0 -���)', 'NUMBER', 1, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 32, 'DATE_CLOSE', '���� �������� ��������', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31.12.9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 33, 'CHGACTION', '��� ��������� (I,U,D)', 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 34, 'USER_ID', '����������', 'NUMBER', 38, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 35, 'INITIATOR', '��� ����������', 'CHAR', 2, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (161, 36, 'NDG', '��� ������������ ��', 'NUMBER', 38, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (&&sfile_id);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (&&sfile_id);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (&&sfile_id);

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
