begin
update meta_nsifunction t set CUSTOM_OPTIONS='{"isFuncOnly":true,"RowParamsNames":["P_ATTRIBUTE_VALUE"],"PROC_NAME":"UPDATE  BRANCH_ATTRIBUTE_VALUE R  SET  ATTRIBUTE_VALUE = :P_ATTRIBUTE_VALUE WHERE  R.attribute_code = ''$BASE'' AND R.BRANCH_CODE = ''/300465/''","PROC_EXEC":"ONCE","ParamsInfo":[{"IsInput":true,"SelectDefValue" : "SELECT T.ATTRIBUTE_VALUE FROM BRANCH_ATTRIBUTE_VALUE T WHERE T.ATTRIBUTE_CODE = ''$BASE'' AND T.BRANCH_CODE = ''/300465/''","ColumnInfo":{"COLNAME":"P_ATTRIBUTE_VALUE","COLTYPE":"N","SEMANTIC":"значення атрибута"}}]}'
where t.tabid =1012937 and t.funcid = 9;
end;
/