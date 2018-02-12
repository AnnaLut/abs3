SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET DEFINE       OFF

declare 
  l_codeoper    operlist.codeoper%type;
begin   
  
  l_codeoper := OPERLIST_ADM.ADD_NEW_FUNC
                ( p_name     => 'Редагування планів держзакупівлі'
                , p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0&sPar=KOD_DZR[PROC=>BARS.P_KODDZ(:Par0)][PAR=>:Par0(SEM=0-Поточний 1-Минулий рiк,TYPE=N)][EXEC=>BEFORE]'
                , p_frontend => 1
                );
  operlist_adm.add_func_to_arm(p_codeoper => l_codeoper,
                               p_codeapp => '$RM_KODZ');
							   
  for DZR in (select m.*
                from meta_columns m, meta_tables t
               where m.tabid = t.tabid
                 and upper(t.tabname) = 'KOD_DZR') loop
    update meta_columns met
       set met.not_to_edit = decode(met.colname,
                                    'PLAN_CUR',
                                    0,
                                    'FACT_CUR',
                                    0,
                                    1)
     where met.tabid = DZR.tabid
       and met.colid = DZR.colid
       and met.colname = DZR.colname;
  end loop;
  
end;
/

commit;


