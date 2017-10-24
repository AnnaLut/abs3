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

prompt +==============================================
prompt | Conecting as BARS to database &&dbname
prompt +==============================================

conn bars/&&bars_pass@&&dbname

col val format a40 heading "аг"

select to_char(sysdate,'DD/MM/YYYY HH24:MI:SS') "Start at" from dual;

select val from params$base where par in ('MFO', 'NAME');

col val clear

prompt -> cig_mgr.pkb
@Sql\bars\Package\cig_mgr.pkb

spool off

quit