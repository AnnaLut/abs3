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

prompt  ...
prompt  dbname     = &&dbname
prompt  sys_pass   = &&sys_pass
prompt  bars_pass  = &&bars_pass
prompt  ...


--whenever error exit
prompt ...
prompt ... connecting as bars
prompt ...
conn bars/&&bars_pass@&&dbname


prompt ...
prompt ... TABLE
prompt ...

@Sql\Bars\Table\skrynka_all.sql;
@Sql\Bars\Table\skrynka_acc_tip.sql;
@Sql\Bars\Table\skrynka_staff_tip.sql;
@Sql\Bars\Table\skrynka_tag.sql;
@Sql\Bars\Table\skrynka_tariff.sql;
@Sql\Bars\Table\skrynka_tariff1.sql;
@Sql\Bars\Table\skrynka_tariff2.sql;
@Sql\Bars\Table\skrynka_tariff_skidka.sql;
@Sql\Bars\Table\skrynka_tariff_tip.sql;
@Sql\Bars\Table\skrynka_nd.sql;
@Sql\Bars\Table\skrynka_nd_acc.sql;
@Sql\Bars\Table\skrynka_nd_ref.sql;
@Sql\Bars\Table\skrynka_nd_arc.sql;
@Sql\Bars\Table\skrynka.sql;
@Sql\Bars\Table\skrynka_acc.sql;
@Sql\Bars\Table\skrynka_acc_arc.sql;
@Sql\Bars\Table\skrynka_arc.sql;
@Sql\Bars\Table\skrynka_menu.sql;
@Sql\Bars\Table\skrynka_tip.sql;
@Sql\Bars\Table\skrynka_visit.sql;
@Sql\Bars\Table\skrynka_sync_queue.sql;
@Sql\Bars\Table\skrynka_tip_etalon.sql;
@Sql\Bars\Table\skrynka_etalon_tariff.sql;
@Sql\Bars\Table\skrynka_nd_update.sql;
@Sql\Bars\Table\skrynka_etalon_tariff_value.sql;
@Sql\Bars\Table\skrynka_sync_type.sql;
@Sql\Bars\Table\skrynka_attorney.sql;
@Sql\Bars\Table\skrynka_nd_branch.sql;
@Sql\Bars\Table\skrynka_tip_branch.sql;
@Sql\Bars\Table\skr_import_deals.sql;
@Sql\Bars\Table\skr_import_safes.sql;
@Sql\Bars\Table\skrynka_staff.sql;

prompt ...
prompt ... CONSTRAINTS
prompt ...

@Sql\Bars\constraint\skrynka_all.sql;
@Sql\Bars\constraint\skrynka_tip_etalon.sql;
@Sql\Bars\constraint\skrynka_etalon_tariff.sql;
@Sql\Bars\constraint\skrynka_etalon_tariff_value.sql;
@Sql\Bars\constraint\skrynka_tip.sql;
@Sql\Bars\constraint\skrynka_tariff_tip.sql;
@Sql\Bars\constraint\skrynka_acc_tip.sql;
@Sql\Bars\constraint\skrynka_staff_tip.sql;
@Sql\Bars\constraint\skrynka_tag.sql;
@Sql\Bars\constraint\skrynka_tariff.sql;
@Sql\Bars\constraint\skrynka_tariff1.sql;
@Sql\Bars\constraint\skrynka_tariff2.sql;
@Sql\Bars\constraint\skrynka_tariff_skidka.sql;
@Sql\Bars\constraint\skrynka.sql;
@Sql\Bars\constraint\skrynka_nd.sql;
@Sql\Bars\constraint\skrynka_nd_acc.sql;
@Sql\Bars\constraint\skrynka_nd_ref.sql;
@Sql\Bars\constraint\skrynka_acc.sql;
@Sql\Bars\constraint\skrynka_acc_arc.sql;
@Sql\Bars\constraint\skrynka_arc.sql;
@Sql\Bars\constraint\skrynka_menu.sql;
@Sql\Bars\constraint\skrynka_visit.sql;
@Sql\Bars\constraint\skrynka_sync_type.sql;
@Sql\Bars\constraint\skrynka_sync_queue.sql;
@Sql\Bars\constraint\skrynka_attorney.sql;
@Sql\Bars\constraint\skrynka_nd_arc.sql;
@Sql\Bars\constraint\skrynka_tip_branch.sql;
@Sql\Bars\constraint\skrynka_nd_branch.sql;
@Sql\Bars\constraint\skr_import_deals.sql;
@Sql\Bars\constraint\skr_import_safes.sql;
@Sql\Bars\constraint\skrynka_staff.sql;

prompt ...
prompt ... INDEX
prompt ...

@Sql\Bars\Index\skrynka_acc_tip.sql;
@Sql\Bars\Index\skrynka_staff_tip.sql;
@Sql\Bars\Index\skrynka_tag.sql;
@Sql\Bars\Index\skrynka_tariff.sql;
@Sql\Bars\Index\skrynka_tariff1.sql;
@Sql\Bars\Index\skrynka_tariff2.sql;
@Sql\Bars\Index\skrynka_tariff_skidka.sql;
@Sql\Bars\Index\skrynka_tariff_tip.sql;
@Sql\Bars\Index\skrynka_nd.sql;
@Sql\Bars\Index\skrynka_nd_acc.sql;
@Sql\Bars\Index\skrynka_nd_ref.sql;
@Sql\Bars\Index\skrynka_nd_arc.sql;
@Sql\Bars\Index\skrynka.sql;
@Sql\Bars\Index\skrynka_acc.sql;
@Sql\Bars\Index\skrynka_acc_arc.sql;
@Sql\Bars\Index\skrynka_arc.sql;
@Sql\Bars\Index\skrynka_menu.sql;
@Sql\Bars\Index\skrynka_tip.sql;
@Sql\Bars\Index\skrynka_visit.sql;
@Sql\Bars\Index\skrynka_sync_queue.sql;
@Sql\Bars\Index\skrynka_tip_etalon.sql;
@Sql\Bars\Index\skrynka_etalon_tariff.sql;
@Sql\Bars\Index\skrynka_nd_update.sql;
@Sql\Bars\Index\skrynka_etalon_tariff_value.sql;
@Sql\Bars\Index\skrynka_sync_type.sql;
@Sql\Bars\Index\skrynka_all.sql;
@Sql\Bars\Index\skrynka_tip_branch.sql;
@Sql\Bars\Index\skr_import_deals.sql;
@Sql\Bars\Index\skr_import_safes.sql;
@Sql\Bars\Index\skrynka_staff.sql;

prompt ...
prompt ... TRIGGER
prompt ...
 
@Sql\Bars\Trigger\tiu_skrynka_nd.sql;
@Sql\Bars\Trigger\tai_skrynka_tariff.sql;
@Sql\Bars\Trigger\tai_skrynka_tip.sql;
@Sql\Bars\Trigger\tiu_skrynka_nd_sync.sql;
@Sql\Bars\Trigger\taiu_skrynka_tip.sql;
@Sql\Bars\Trigger\tbi_skrynka_sync_queue.sql;
@Sql\Bars\Trigger\taiud_skrynkand_update.sql;
@Sql\Bars\Trigger\tiu_skrynkand_sos.sql;
@Sql\Bars\Trigger\taiu_skrynka_tariff2.sql;
@Sql\Bars\Trigger\ti_skrynka.sql;
@Sql\Bars\Trigger\td_skrynka_acc.sql;
@Sql\Bars\Trigger\td_skrynka_nd.sql;
@Sql\Bars\Trigger\td_skrynka.sql;
@Sql\Bars\Trigger\tiu_skrynka_acc.sql;

prompt ...
prompt ... VIEW
prompt ...

@Sql\Bars\View\v_skrynka_nd.sql;
@Sql\Bars\View\v_skrynka_acc.sql;
@Sql\Bars\View\v_skrynka.sql;
@Sql\Bars\View\v_safe_deposit_archive.sql;
@Sql\Bars\View\v_safe_deposit.sql;

prompt ...
prompt ... SEQUENCE
prompt ...

@Sql\Bars\Sequence\s_skrynka_nd_update.sql;
@Sql\Bars\Sequence\s_skrynka_n_sk.sql;
@Sql\Bars\Sequence\s_skrynka_sync_queue.sql;
@Sql\Bars\Sequence\s_skrynka_tariff.sql;
@Sql\Bars\Sequence\s_skrynka_tip.sql;

prompt ...
prompt ... ERRORS
prompt ...
@Sql\Bars\Error\err_skr.sql ;


prompt ...
prompt ... HEADER
prompt ...
@Sql\Bars\Header\safe_deposit.pks;
@Sql\Bars\Header\skrn.pks;
@Sql\Bars\Header\skrynka_sync.pks;
@Sql\Bars\Header\t_skrynka.pks;

prompt ...
prompt ... PACKAGE
prompt ...

@Sql\Bars\Package\safe_deposit.pkb;
@Sql\Bars\Package\skrn.pkb;
@Sql\Bars\Package\skrynka_sync.pkb;
@Sql\Bars\Package\t_skrynka.pkb;

prompt ...
prompt ... PROCEDURE
prompt ...

@Sql\Bars\Procedure\import_safes.sql;
@Sql\Bars\Procedure\import_deals.sql;
@Sql\Bars\Procedure\skrn_free_cell.sql;


prompt ...
prompt ... JOB
prompt ...
@Sql\Bars\Job\skrynka_sync.sql;

prompt ...
prompt ... DATA
prompt ...

@Sql\Bars\Data\data_skrynka_menu.sql;
@Sql\Bars\Data\data_skrynka_staff_tip.sql;
@Sql\Bars\Data\data_skrynka_sync_type.sql;
@Sql\Bars\Data\data_skrynka_tag.sql;
@Sql\Bars\Data\data_skrynka_tariff_tip.sql;

@Sql\Bars\Data\bmd_skrynka_tariff.sql;
@Sql\Bars\Data\bmd_skrynka_tariff1.sql;
@Sql\Bars\Data\bmd_skrynka_tariff2.sql;
@Sql\Bars\Data\bmd_skrynka_tariff_tip.sql;
@Sql\Bars\Data\bmd_skrynka_tip.sql;
@Sql\Bars\Data\bmd_skrynka_visit.sql;

@Sql\Bars\Data\reports_3999.sql
@Sql\Bars\Data\reports_brs_sber_skrn_3997.sql
@Sql\Bars\Data\reports_brs_sber_skrn_3998.sql




spool off

quit

