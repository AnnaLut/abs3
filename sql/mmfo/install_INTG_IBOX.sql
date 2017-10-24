set verify off
set echo off
set serveroutput on size 1000000
spool log\install.log
set lines 3000
set termout on
prompt load params.sql
@params.sql

whenever sqlerror exit
prompt перев≥рка лог≥ну п≥д bars@&&database
conn bars/&&bars_pass@&&database
whenever sqlerror continue
--whenever sqlerror exit rollback
SET DEFINE OFF

prompt ========== Установка функциональности интеграции с IBOX ==========

prompt ******** TABLE *********
@Sql\bars\TABLE\ibx_types.sql;
prompt ******** TABLE  ibx_types done  *********
@Sql\bars\TABLE\ibx_files.sql;
prompt ******** TABLE  ibx_files done *********
@Sql\bars\TABLE\ibx_recs.sql;
prompt ******** TABLE  ibx_recs done *********


prompt ******** HEADER *********
@Sql\bars\header\ibx_pack.pks;
prompt ******** PACKAGE *********
@Sql\bars\PACKAGE\ibx_pack.pkb;
show error;

prompt ******** VIEW *********
@Sql\bars\VIEW\v_ibx_payments.pdc;

prompt ******** SCRIPT *********

prompt ******** GRANTS *********
grant execute on ibx_pack to bars_access_defrole;

prompt ******** DATA *********
@Sql\bars\DATA\createuser_tech.sql
@Sql\bars\DATA\et_MAS.SQL
SET DEFINE ON
@Sql\bars\DATA\ibx_types.SQL
SET DEFINE OFF
spool off
exit