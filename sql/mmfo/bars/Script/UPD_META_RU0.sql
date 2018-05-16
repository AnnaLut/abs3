update META_NSIFUNCTION
   set WEB_FORM_NAME =
'sPar=V_CCK_RU0[NSIFUNCTION][ACCESSCODE=>1][PROC=>MSFZ9.PUL9 (:ND) ][EXEC=>BEFORE][showDialogWindow=>false]'
where TABID = bars_metabase.get_tabid('V_CCK_RU')
and WEB_FORM_NAME like 'sPar=V_CCK_RU0[NSIFUNCTION]%' ;


update META_NSIFUNCTION
   set WEB_FORM_NAME ='/barsroot/customerlist/custacc.aspx?type=7'
where TABID = bars_metabase.get_tabid('V_CCK_RU0')
and WEB_FORM_NAME like 'sPar=ACCOUNT1[%' ;


COMMIT;