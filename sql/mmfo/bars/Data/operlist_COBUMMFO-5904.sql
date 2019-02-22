set define off

prompt updating funcpaths for FM functions (refer to FM_UTL package)

begin
    operlist_adm.modify_func_by_name(p_name => 'ФМ. Перевірка ТЕРОРИСТИ', p_new_funcpath => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=> fm_utl.run_deferred_task(''fm_terrorist_utl.check_terrorists'', ''Перевірку клієнтів на список терористів завершено. Перевірте довідник підозрілих клієнтів.'')][QST=>Запустити перевірку всіх клієнтів банку?][MSG=>Перевірку запущено, очікуйте повідомлення]');
    operlist_adm.modify_func_by_name(p_name => 'ФМ. Перевірка ПЕП БАЗОВИЙ', p_new_funcpath => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=[PROC=> fm_utl.run_deferred_task(''fm_public_utl.check_public'', ''Перевірку клієнтів на список публ. діячів завершено. Перевірте довідник ПЕП.'')][QST=>Запустити перевірку всіх клієнтів банку?][MSG=>Перевірку запущено, очікуйте повідомлення]');
    commit;
end;
/

set define on