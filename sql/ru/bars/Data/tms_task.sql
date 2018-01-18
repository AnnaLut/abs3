prompt Добавляем новую ф-ю закрытия дня - обновление спецпараметров ССК (cck_upd_sparams)
declare
id_ number;
begin
suda;
--------------------------------------
id_ := abs_utils.add_function(func_name => 'F1_Select(12, " P_CCK_UPDATE_SPARAMS(gl.bd, gl.bd+1) " )',
                       role_name => null,
                       sem       => 'Актуализация спецпараметров CCK',
                       full_name => null);
tuda;
abs_utils.add_funclist_finish(p_codeoper => id_,
                              p_checked  => 1,
                              p_position => 26);
--------------------------------------  
commit;
suda;
-----------------------------------
end;
/