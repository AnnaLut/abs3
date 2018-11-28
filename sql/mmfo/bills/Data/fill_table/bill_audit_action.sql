prompt fill BILL_AUDIT_ACTION
insert /*+ ignore_row_on_dupkey_index(bill_audit_action xpk_bill_audit_action)*/ into bill_audit_action (action, descript)
values ('SearchResolutionResult', 'Пошук рішення');
insert /*+ ignore_row_on_dupkey_index(bill_audit_action xpk_bill_audit_action)*/ into bill_audit_action (action, descript)
values ('DeleteReceiver', 'Видалення стягувача (локально)');
insert /*+ ignore_row_on_dupkey_index(bill_audit_action xpk_bill_audit_action)*/ into bill_audit_action (action, descript)
values ('ClearRequest', 'Відмова від роботи зі стягувачем');
insert /*+ ignore_row_on_dupkey_index(bill_audit_action xpk_bill_audit_action)*/ into bill_audit_action (action, descript)
values ('ConfirmRequest', 'Підтвердження запиту - завершення редагування');
insert /*+ ignore_row_on_dupkey_index(bill_audit_action xpk_bill_audit_action)*/ into bill_audit_action (action, descript)
values ('ConfirmRequestList', 'Формування витягу');
insert /*+ ignore_row_on_dupkey_index(bill_audit_action xpk_bill_audit_action)*/ into bill_audit_action (action, descript)
values ('Move2Work', 'Початок роботи зі стягувачем');
insert /*+ ignore_row_on_dupkey_index(bill_audit_action xpk_bill_audit_action)*/ into bill_audit_action (action, descript)
values ('UpdateReceiver', 'Оновлення даних стягувача');
insert /*+ ignore_row_on_dupkey_index(bill_audit_action xpk_bill_audit_action)*/ into bill_audit_action (action, descript)
values ('SendDocument', 'Відправка документа в ДКСУ');
insert /*+ ignore_row_on_dupkey_index(bill_audit_action xpk_bill_audit_action)*/ into bill_audit_action (action, descript)
values ('HandOutBills', 'Видача векселів стягувачу');
insert /*+ ignore_row_on_dupkey_index(bill_audit_action xpk_bill_audit_action)*/ into bill_audit_action (action, descript)
values ('CheckSignInternal', 'Перевірка внутрішнього ЕЦП');


commit;