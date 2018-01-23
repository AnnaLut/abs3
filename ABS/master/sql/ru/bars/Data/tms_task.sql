prompt Актуализация спецпараметров CCK (cck_upd_sparams)
declare
id_ number;
begin
suda;
begin
    select codeoper
    into id_
    from operlist
    where funcname = 'F1_Select(12, " P_CCK_UPDATE_SPARAMS(gl.bd, gl.bd+1) " )'
    or name = 'Актуализация спецпараметров CCK';

    update operlist
    set funcname = 'SqlPrepareAndExecute(hSql(),"BEGIN P_CCK_UPDATE_SPARAMS(gl.bd, gl.bd+1);COMMIT;END;")',
        name = 'Актуализация спецпараметров CCK'
    where codeoper = id_;
exception
    when no_data_found then
                
        --------------------------------------
        id_ := abs_utils.add_function(func_name => 'SqlPrepareAndExecute(hSql(),"BEGIN P_CCK_UPDATE_SPARAMS(gl.bd, gl.bd+1);COMMIT;END;")',
                               role_name => null,
                               sem       => 'Актуализация спецпараметров CCK',
                               full_name => null);
        tuda;
        abs_utils.add_funclist_finish(p_codeoper => id_,
                                      p_checked  => 1,
                                      p_position => 26);
    when too_many_rows then
        update operlist
        set funcname = 'SqlPrepareAndExecute(hSql(),"BEGIN P_CCK_UPDATE_SPARAMS(gl.bd, gl.bd+1);COMMIT;END;")',
            name = 'Актуализация спецпараметров CCK'
        where funcname = 'F1_Select(12, " P_CCK_UPDATE_SPARAMS(gl.bd, gl.bd+1) " )';
end;
--------------------------------------  
commit;
suda;
-----------------------------------
end;
/