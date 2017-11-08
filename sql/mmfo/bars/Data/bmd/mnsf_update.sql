begin
MERGE INTO BARS.META_NSIFUNCTION A USING
 (SELECT
  1011623 as TABID,
  28 as FUNCID,
  'КП: Дострокове погашення/перебудова ГПК' as DESCR,
  NULL as PROC_NAME,
  NULL as PROC_PAR,
  'ONCE' as PROC_EXEC,
  NULL as QST,
  NULL as MSG,
  '107' as FORM_NAME,
  NULL as CHECK_FUNC,
  'sPar=CC_VP_DOSR[ACCESSCODE=>0][DESCR=>Дострокове погашення /погашення/перебудова ГПК/][showDialogWindow=>false][CONDITIONS=> nd=:ND]' as WEB_FORM_NAME,
  107 as ICON_ID
  FROM DUAL) B
ON (A.TABID = B.TABID and A.FUNCID = B.FUNCID)
WHEN NOT MATCHED THEN 
INSERT (
  TABID, FUNCID, DESCR, PROC_NAME, PROC_PAR, 
  PROC_EXEC, QST, MSG, FORM_NAME, CHECK_FUNC, 
  WEB_FORM_NAME, ICON_ID)
VALUES (
  B.TABID, B.FUNCID, B.DESCR, B.PROC_NAME, B.PROC_PAR, 
  B.PROC_EXEC, B.QST, B.MSG, B.FORM_NAME, B.CHECK_FUNC, 
  B.WEB_FORM_NAME, B.ICON_ID)
WHEN MATCHED THEN
UPDATE SET 
  A.DESCR = B.DESCR,
  A.PROC_NAME = B.PROC_NAME,
  A.PROC_PAR = B.PROC_PAR,
  A.PROC_EXEC = B.PROC_EXEC,
  A.QST = B.QST,
  A.MSG = B.MSG,
  A.FORM_NAME = B.FORM_NAME,
  A.CHECK_FUNC = B.CHECK_FUNC,
  A.WEB_FORM_NAME = B.WEB_FORM_NAME,
  A.ICON_ID = B.ICON_ID;
end;
/
COMMIT;
begin

  update meta_nsifunction t
     set t.web_form_name = '/barsroot/CreditUi/NewCredit/Authorization/?nd=:ND'
     ,t.proc_name='',t.proc_par='',t.qst='',t.msg=''
   where t.tabid = get_tabid('V_CCK_NF')
     and t.descr = 'КД: Авторизація КД';
  commit;
end;
/
COMMIT;