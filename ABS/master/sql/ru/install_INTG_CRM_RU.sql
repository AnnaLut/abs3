set verify off
set echo off
set serveroutput on size 1000000
spool log\install.log
set lines 3000


prompt...
prompt ...
prompt ... loading params
prompt ...

@params.sql

prompt +==============================================
prompt |    patch params 
prompt +==============================================
prompt | Input Database Name:
prompt | dbname      = &&dbname
prompt +==============================================

prompt ..........................................
prompt ...
prompt ... Conecting as SYS to database &&dbname
prompt ...
prompt ..........................................
WHENEVER SQLERROR EXIT
conn sys/&&sys_pass@&&dbname as sysdba
WHENEVER SQLERROR CONTINUE

prompt -> @sys\bars_dm_types.sql
@Sql\sys\bars_dm_types.sql

prompt +==============================================
prompt | Conecting as BARS to database &&dbname
prompt +==============================================

conn bars/&&bars_pass@&&dbname

col val format a40 heading "аг"

select to_char(sysdate,'DD/MM/YYYY HH24:MI:SS') "Start at" from dual;

select val from params$base where par in ('MFO', 'NAME');

col val clear

prompt -> grants.sql
@Sql\bars\Grant\grants.sql


prompt +==============================================
prompt | Conecting as BARS_DM to database &&dbname 
prompt +==============================================

conn bars_dm/&&barsdm_pass@&&dbname


prompt -> @table\bankmon.sql
@Sql\bars_dm\table\bankmon.sql
prompt -> @table\bpk.sql
@Sql\bars_dm\table\bpk.sql
prompt -> @table\credits_dyn.sql
@Sql\bars_dm\table\credits_dyn.sql
prompt -> @table\credits_stat.sql
@Sql\bars_dm\table\credits_stat.sql
prompt -> @table\customers.sql
@Sql\bars_dm\table\customers.sql
prompt -> @table\customers_segment.sql
@Sql\bars_dm\table\customers_segment.sql
prompt -> @table\custur.sql
@Sql\bars_dm\table\custur.sql
prompt -> @table\custur_rel.sql
@Sql\bars_dm\table\custur_rel.sql
prompt -> @table\d_lcs_tt_type.sql
@Sql\bars_dm\table\d_lcs_tt_type.sql
prompt -> @table\deposits.sql
@Sql\bars_dm\table\deposits.sql
prompt -> @table\dm_accounts.sql
@Sql\bars_dm\table\dm_accounts.sql
prompt -> @table\dm_assurances_gouk.sql
@Sql\bars_dm\table\dm_assurances_gouk.sql
prompt -> @table\dm_obj.sql
@Sql\bars_dm\table\dm_obj.sql
prompt -> @table\dm_stats.sql
@Sql\bars_dm\table\dm_stats.sql
prompt -> @table\imp_sheduler.sql
@Sql\bars_dm\table\imp_sheduler.sql
prompt -> @table\imp_types.sql
@Sql\bars_dm\table\imp_types.sql
prompt -> @table\indsafe.sql
@Sql\bars_dm\table\indsafe.sql
prompt -> @table\kaznzob.sql
@Sql\bars_dm\table\kaznzob.sql
prompt -> @table\period_type.sql
@Sql\bars_dm\table\period_type.sql
prompt -> @table\periods.sql
@Sql\bars_dm\table\periods.sql
prompt -> @table\regions.sql
@Sql\bars_dm\table\regions.sql
prompt -> @table\zastava.sql
@Sql\bars_dm\table\zastava.sql


prompt -> @table\bpk_plt.sql
@Sql\bars_dm\table\bpk_plt.sql

prompt -> @table\deposit_plt.sql
@Sql\bars_dm\table\deposit_plt.sql

prompt -> @table\customers_plt.sql
@Sql\bars_dm\table\customers_plt.sql

prompt -> @procedure\mark_periods.prc
@Sql\bars_dm\procedure\mark_periods.prc

prompt -> @function\f_get_val_func.sql
@Sql\bars_dm\function\f_get_val_func.sql

prompt -> @table\credits_ES.sql
@Sql\bars_dm\table\credits_ES.sql

prompt -> @header\dm_import.pks
@Sql\bars_dm\header\dm_import.pks

prompt -> @package\dm_import.pkb
@Sql\bars_dm\package\dm_import.pkb

prompt -> @grant\grants.sql
@Sql\bars_dm\grant\grants.sql

prompt -> @data\dm_obj_initial.sql
@Sql\bars_dm\data\dm_obj_initial.sql

prompt -> @data\dm_obj.sql
@Sql\bars_dm\data\dm_obj.sql

prompt +==============================================
prompt | Conecting as BARSUPL to database &&dbname
prompt +==============================================

conn barsupl/&&barsupl@&&dbname

prompt -> @data\upl_sql_initial.sql
@Sql\barsupl\data\upl_sql_initial.sql
prompt -> @data\upl_files_initial.sql
@Sql\barsupl\data\upl_files_initial.sql
prompt -> @data\upl_columns_initial.sql
@Sql\barsupl\data\upl_columns_initial.sql
prompt -> @data\upl_filegroups_rln_initial.sql
@Sql\barsupl\data\upl_filegroups_rln_initial.sql

prompt -> @data\bpk_sql.sql
@Sql\barsupl\data\bpk_sql.sql

prompt -> @data\deposits_sql.sql
@Sql\barsupl\data\deposits_sql.sql

prompt -> @data\customers_sql.sql
@Sql\barsupl\data\customers_sql.sql

prompt -> @data\credits_sql.sql
@Sql\barsupl\data\credits_sql.sql

prompt -> @data\file_bpk.sql
@Sql\barsupl\data\file_bpk.sql

prompt -> @data\file_deposits.sql
@Sql\barsupl\data\file_deposits.sql

prompt -> @data\file_customers.sql
@Sql\barsupl\data\file_customers.sql

prompt -> @data\columns_bpk.sql
@Sql\barsupl\data\columns_bpk.sql

prompt -> @data\columns_deposits.sql
@Sql\barsupl\data\columns_deposits.sql

prompt -> @data\columns_customers.sql
@Sql\barsupl\data\columns_customers.sql

prompt -> @data\credits_columns.sql
@Sql\barsupl\data\credits_columns.sql

prompt -> @data\file_groups.sql
@Sql\barsupl\data\file_groups.sql

prompt -> @data\pawn_fix.sql
@Sql\barsupl\data\pawn_fix.sql

spool off

quit

