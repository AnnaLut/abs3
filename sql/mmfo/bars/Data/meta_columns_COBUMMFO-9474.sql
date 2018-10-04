
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/patch_data_META_COLUMNS.sql =========**
PROMPT ===================================================================================== 

Begin
   INSERT INTO META_COLUMNS(TABID,COLID,COLNAME,COLTYPE,SEMANTIC,SHOWWIDTH,SHOWMAXCHAR,SHOWPOS,SHOWIN_RO,SHOWRETVAL,INSTNSSEMANTIC,EXTRNVAL,SHOWREL_CTYPE,SHOWFORMAT,SHOWIN_FLTR,SHOWREF,SHOWRESULT,CASE_SENSITIVE,NOT_TO_EDIT,NOT_TO_SHOW,SIMPLE_FILTER,FORM_NAME,BRANCH,WEB_FORM_NAME,OPER_ID,INPUT_IN_NEW_RECORD) VALUES (4552,8,'KF','C','Код~філіалу',null,null,12,0,0,0,0,'','',1,0,'',null,1,0,0,'','/','',null,0);
    exception when dup_val_on_index then null;
end;
/
COMMIT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/patch_data_META_COLUMNS.sql =========**
PROMPT ===================================================================================== 
