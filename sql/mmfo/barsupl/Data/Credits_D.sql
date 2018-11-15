prompt barsupl Файл выгрузки: CREDITS_D
prompt sql
prompt delta
declare
l_sql_text clob := to_clob(q'[
select
                           nd
                          ,rnk
                          ,kf
                          ,cc_id
                          ,sdate
                          ,branch
                          ,vidd
                          ,next_pay
                          ,probl_rozgl
                          ,probl_date
                          ,probl
                          ,cred_change
                          ,cred_datechange
                          ,borg
                          ,borg_tilo
                          ,borg_proc
                          ,prosr1
                          ,prosr2
                          ,prosrcnt
                          ,borg_prosr
                          ,borg_tilo_prosr
                          ,borg_proc_prosr
                          ,penja
                          ,shtraf
                          ,pay_tilo
                          ,pay_proc
                          ,cat_ryzyk
                          ,cred_to_prosr
                          ,borg_to_pbal
                          ,vart_majna
                          ,pog_finish
                          ,prosr_fact_cnt
                          ,next_pay_all
                          ,next_pay_tilo
                          ,next_pay_proc
                          ,sos
                          ,last_pay_date
                          ,last_pay_suma
                          ,prosrcnt_proc
                          ,tilo_prosr_uah
                          ,proc_prosr_uah
                          ,borg_tilo_uah
                          ,borg_proc_uah
                          ,pay_vdvs
                          ,amount_commission
                          ,amount_prosr_commission
                          ,ES000
                          ,ES003
                          ,VIDD_CUSTTYPE
						  ,stp_dat
                      from bars_dm.credits_dyn c
                      where c.per_id=bars_dm.dm_import.GET_PERIOD_ID('DAY',nvl(to_date(:param1, 'dd/mm/yyyy'), trunc(sysdate)))
					  and kf = sys_context('bars_context', 'user_mfo')
]');
l_descript varchar2(250) := q'[Кредити для CRM (динамічні дані)]';
begin
    insert into upl_sql(sql_id, sql_text, descript, vers)
    values (53, l_sql_text, l_descript, '1.0');
exception
    when dup_val_on_index then
        update barsupl.upl_sql
        set sql_text = l_sql_text,
            descript = l_descript,
            vers = '1.3'
        where sql_id = 53;
end;
/


prompt columns
begin
    delete from barsupl.upl_columns
    where file_id = 53;

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 1, 'nd', 'id договору', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, 'TRUNC_E2');

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 2, 'rnk', 'РНК', 'NUMBER', 15, 0, null, null, 'Y', null, null, null, null, 'TRUNC_E2');

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 3, 'kf', 'Регіональне управління', 'CHAR', 6, null, null, null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 4, 'cc_id', '№ договору', 'CHAR', 30, null, null, null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 5, 'sdate', 'Дата укладання договору', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 6, 'branch', 'Відділення, за яким закріплено повернення кредиту', 'CHAR', 30, null, null, null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 7, 'vidd', 'Тип договору', 'NUMBER', 3, 0, null, null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 8, 'next_pay', 'Дата здійснення наступного платежу', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 9, 'probl_rozgl', 'На стадії розгляду питання про визнання проблемним', 'CHAR', 50, null, null, null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 10, 'probl_date', 'Дата визнання кредиту проблемним', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 11, 'probl', 'Визнання кредиту проблемним', 'CHAR', 10, null, null, null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 12, 'cred_change', 'Зміна умов кредитування', 'CHAR', 50, null, null, null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 13, 'cred_datechange', 'Дата здійснення зміни умов кредитування', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 14, 'borg', 'Сума заборгованості за кредитом у валюті кредиту', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 15, 'borg_tilo', 'Сума заборгованості за тілом кредиту у валюті кредиту', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 16, 'borg_proc', 'Сума заборгованості за відсотками у валюті кредиту', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 17, 'prosr1', 'Дата виникнення першої прострочки за кредитом', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 18, 'prosr2', 'Дата виникнення другої прострочки за кредитом', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 19, 'prosrcnt', 'Кількість прострочених платежів', 'NUMBER', 3, 0, null, null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 20, 'borg_prosr', 'Сума простроченої заборгованості за кредитом у валюті кредиту', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 21, 'borg_tilo_prosr', 'Сума простроченої заборгованості за тілом у валюті кредиту', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 22, 'borg_proc_prosr', 'Сума простроченої заборгованості за процентами у валюті кредиту', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 23, 'penja', 'Сума пені у валюті кредиту', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 24, 'shtraf', 'Сума нарахованих штрафів у валюті кредиту', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 25, 'pay_tilo', 'Сума повернутих коштів по кредиту в поточному році, грн', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 26, 'pay_proc', 'Сума повернутих процентів за кредитом в поточному році, грн', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 27, 'cat_ryzyk', 'Категорія ризику кредитної операції', 'CHAR', 50, null, null, null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 28, 'cred_to_prosr', 'Дата віднесення кредиту на рахунок простроченої заборгованості', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 29, 'borg_to_pbal', 'Дата перенесення заборгованості на позабалансові рахунки', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 30, 'vart_majna', 'Вартість прийнятого майна на баланс, грн', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 31, 'pog_finish', 'Чинна дата погашення кредиту згідно з останніми змінами', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 32, 'prosr_fact_cnt', 'Кількість фактів виходу на просрочку', 'NUMBER', 4, 0, null, null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 33, 'next_pay_all', 'Сума наступного платежу, всього', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 34, 'next_pay_tilo', 'Сума наступного платежу, тіло', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 35, 'next_pay_proc', 'Сума наступного платежу, проценти', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 36, 'sos', 'Стан договору', 'NUMBER', 15, 0, null, null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 37, 'last_pay_date', 'Дата останнього платежу', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 38, 'last_pay_suma', 'Сума останнього платежу', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 39, 'prosrcnt_proc', 'Кількість непогашених прострочених платежів по відсотках', 'NUMBER', 3, 0, null, null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 40, 'tilo_prosr_uah', 'Сума прострочки по тілу в гривні', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 41, 'proc_prosr_uah', 'Сума прострочки по відсотках в гривні', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 42, 'borg_tilo_uah', 'Сума заборгованості за тілом у гривні', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 43, 'borg_proc_uah', 'Сума заборгованості за відсотками у гривні', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 44, 'pay_vdvs', 'Всього перераховано коштів від ВДВС, грн.', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 45, 'amount_commission', 'Сума комісії за КД у валюті кредиту', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 46, 'amount_prosr_commission', 'Сума простроченої комісії за КД у валюті кредиту', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 47, 'es000', 'Статус КД в реєстрі', 'VARCHAR2', 24, null, null, null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 48, 'es003', 'Дата отримання відшкодування', 'VARCHAR2', 24, null, null, null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 49, 'vidd_custtype', 'Тип клиента по виду договора: 3 - физическое лицо, 2 - юридическое лицо, 1 - банк', 'NUMBER', 1, 0, null, null, 'Y', null, null, null, null, null);

      insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
      values (53, 50, 'stp_dat', 'Дата завершення нарахування відсотків', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);
end;
/
commit;