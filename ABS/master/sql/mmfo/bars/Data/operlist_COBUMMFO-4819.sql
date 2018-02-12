prompt operlist DPT. Архів депозитів ФО, DPT. Архів депозитів ФО - знімок

set define off

declare
l_new_path varchar2(4000) :=
'/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_DPT_ARCHIVE&accessCode=1&sPar=[PAR=>
:A(SEM=Дата,TYPE=D),
:B(SEM=Вид депозиту-пусто-всі,TYPE=N,REF=DPT_VIDD),
:C(SEM=Код підрозділу-пусто-всі,TYPE=С,REF=OUR_BRANCH)]
[PROC=>DPT_RPT_UTIL.SET_ARCHV_CD(:A,:B,:C)][EXEC=>BEFORE]
[CONDITIONS=> (RPT_DT = DPT_RPT_UTIL.GET_FINISH_DT or (RPT_DT is null and DPT_RPT_UTIL.GET_FINISH_DT is null))
              and VIDD_ID = nvl(DPT_RPT_UTIL.GET_VIDD_CD, VIDD_ID )
              and BRANCH = nvl(DPT_RPT_UTIL.GET_BRANCH_CD, BRANCH)]';
begin
    operlist_adm.modify_func_by_name(p_name => 'DPT. Архів депозитів ФО', p_new_funcpath =>  l_new_path);
end;
/

declare
l_new_path varchar2(4000) :=
'/barsroot/ndi/referencebook/GetRefBookData/?tableName=V_DPT_ARCHIVE_SNAPSHOT&accessCode=1';
l_id number;
begin
    l_id := operlist_adm.add_new_func(p_name => 'DPT. Архів депозитів ФО - знімок', p_funcname => l_new_path, p_frontend => 1, p_runnable => 1); 
    operlist_adm.add_func_to_arm(p_codeoper => l_id,
                                 p_codeapp  => '$RM_DPTA',
                                 p_approve  => true);
end;
/
commit;
/
set define on