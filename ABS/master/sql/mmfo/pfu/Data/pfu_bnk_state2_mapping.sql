PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Data/pfu_bnk_state2_mapping.sql =========*** Run *** =
PROMPT ===================================================================================== 

merge into pfu_bnk_state2_mapping m
using (select 1 as id, 2 as pfu_result, 'ser_num' as pfu_tag, 'Не співпадає серія та номер документа з існуючим клієнтом РНК' as msg from dual
       union all
       select 2 as id, 2 as pfu_result, 'date_birth' as pfu_tag, 'Не співпадає дата народження з існуючим клієнтом РНК' as msg from dual
       union all
       select 3 as id, 2 as pfu_result, '' as pfu_tag, 'Невідповідність формату даних, отриманих від ПФУ, або не заповнено' as msg from dual
       union all
       select 4 as id, 4 as pfu_result, '' as pfu_tag, 'Помилка перевипуску картки: ORA-20097: BPK-00107 Заборонено формувати запит з типом 9 для карт Instant' as msg from dual
       union all
       select 5 as id, 4 as pfu_result, '' as pfu_tag, 'Помилка перевипуску картки: ORA-20097: BPK-00102 По рахунку 26258551504945 є несквитовані заявк' as msg from dual
       union all
       select 6 as id, 4 as pfu_result, '' as pfu_tag, 'Помилка відкриття картки: ORA-20097: BPK-00052 Не заповнено обов`язкові реквізити клієнта' as msg from dual
       union all
       select 7 as id, 4 as pfu_result, '' as pfu_tag, 'Помилка відкриття картки: ORA-20097: BPK-00051 Невідомий тип картки' as msg from dual
       union all
       select 8 as id, 4 as pfu_result, 'lnf_lat' as pfu_tag, 'Помилка відкриття картки: ORA-20000: Загальна кількість символів в імені та прізвищі, що ембосуються, має бути 25' as msg from dual
       union all
       select 9 as id, 4 as pfu_result, '' as pfu_tag, 'Помилка перевипуску картки: ORA-20097: BRS-00203 Модифiкацiя даних об''єкта "BARS.ACCOUNTS" заборонена' as msg from dual
       union all
       select 10 as id, 4 as pfu_result, '' as pfu_tag, 'Помилка перевипуску картки: ORA-01400: невозможно вставить NULL в ("BARS"."ACCOUNTSW"."KF")' as msg from dual
       union all
       select 11 as id, 4 as pfu_result, '' as pfu_tag, 'Помилка перевипуску картки: ORA-01400: cannot insert NULL into ("BARS"."ACCOUNTSW"."KF")' as msg from dual
       union all
       select 12 as id, 4 as pfu_result, 'ser_num' as pfu_tag, 'Помилка відкриття картки: ORA-20097: BPK-00059 Некоректна серія документу' as msg from dual
       union all
       select 13 as id, 3 as pfu_result, 'bank_num' as pfu_tag, 'Не найден филиал с кодом' as msg from dual
       union all
       select 14 as id, 2 as pfu_result, '' as pfu_tag, 'Клиент с одинаковыми серией и номером паспорта, и не пустым RegNumberClient' as msg from dual
       ) t on (t.id = m.id)
when matched then 
  update set m.pfu_result = t.pfu_result, 
             m.msg = t.msg
when not matched then
  insert (m.id, m.pfu_result, m.pfu_tag, m.msg)
  values (t.id, t.pfu_result, t.pfu_tag, t.msg);

commit;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/pfu_bnk_state2_mapping.sql =========*** End *** =
PROMPT ===================================================================================== 
