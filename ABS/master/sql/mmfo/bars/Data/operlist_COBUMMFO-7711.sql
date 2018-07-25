PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/bars/data/operlist_COBUMMFO-7711.sql =========*** Run 
PROMPT ===================================================================================== 

declare
l_new_path varchar2(4000) := '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1' || chr(38) || 'sPar=[PROC=> bars.fm_utl.run_deferred_task(''fm_utl.check_terrorists'',''Перевірку завершено. Перевірте довідник підозрілих клієнтів.'')][QST=>Виконати перевірку всіх клієнтів банку?][MSG=>Завдання на перевірку запущено у фоновому режимі. Про виконання буде повідомлено по завершенні перевірки.]';
begin
    operlist_adm.modify_func_by_name(p_name => 'ФМ. Перевірка ТЕРОРИСТИ', p_new_funcpath =>  l_new_path);
end;
/
commit;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/bars/data/operlist_COBUMMFO-7711.sql =========*** End 
PROMPT ===================================================================================== 
