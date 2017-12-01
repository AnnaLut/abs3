 set define off;
    begin
      operlist_adm.modify_func_by_path('/barsroot/barsweb/dynform.aspx?form=bpkw4.frm.portfolio_uo',
                                      '/barsroot/way4bpk/way4bpk?custtype=2' ,
                                      'Way4. Портфель БПК(ЮО)');
                                      commit;
      end;
/