 set define off;
    begin
      operlist_adm.modify_func_by_path('/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0&sPar=NOSTRO_DEAL[EDIT_MODE=>MULTI_EDIT,CARRIAGE_RALLBACK]',
                                      '/barsroot/ndi/referencebook/GetRefBookData/?accessCode=0&sPar=NOSTRO_DEAL[NSIFUNCTION][EDIT_MODE=>MULTI_EDIT,CARRIAGE_RALLBACK][SAVE_COLUMNS=>BY_DEFAULT]' ,
                                      'НОСТРО-рахунки. Портфель Дог.');
                                      commit;
      end;
/