SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET DEFINE       OFF

declare 
  l_codeoper    operlist.codeoper%type;
begin   
  
  l_codeoper := OPERLIST_ADM.ADD_NEW_FUNC
                ( p_name     => 'Документи-кандидати на заповнення реквізитів 1-ПБ'
                , p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_NBUR_1PB_EXPORT_CNDT[NSIFUNCTION]'
                , p_frontend => 1
                );
  
end;
/

commit;

declare
  l_codeoper    operlist.codeoper%type;
begin
  
  l_codeoper := OPERLIST_ADM.ADD_NEW_FUNC
                ( p_name     => 'Імпорт файлу документів з реквізитами 1-ПБ'
                , p_funcname => '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=1&sPar=V_NBUR_1PB_IMPORTED[NSIFUNCTION]'
                , p_frontend => 1
                );
  
end;
/

commit;
