
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/patch_data_BRANCH_ATTRIBUTE.sql =======
PROMPT ===================================================================================== 

Begin
   INSERT INTO BRANCH_ATTRIBUTE(ATTRIBUTE_CODE,ATTRIBUTE_DESC,ATTRIBUTE_DATATYPE,ATTRIBUTE_FORMAT,ATTRIBUTE_MODULE) VALUES ('SMS_SEND_START','Час початку відправки СМС (формат ГОДХВ)','C','','');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO BRANCH_ATTRIBUTE(ATTRIBUTE_CODE,ATTRIBUTE_DESC,ATTRIBUTE_DATATYPE,ATTRIBUTE_FORMAT,ATTRIBUTE_MODULE) VALUES ('SMS_SEND_STOP','Час, в який смс не відправляти (формат ГОДХВ)','C','','');
    exception when dup_val_on_index then null;
end;
/
COMMIT;



PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/patch_data_BRANCH_ATTRIBUTE_VALUE.sql =
PROMPT ===================================================================================== 

Begin
   INSERT INTO BRANCH_ATTRIBUTE_VALUE(ATTRIBUTE_CODE,BRANCH_CODE,ATTRIBUTE_VALUE) VALUES ('SMS_SEND_START','/322669/','800');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO BRANCH_ATTRIBUTE_VALUE(ATTRIBUTE_CODE,BRANCH_CODE,ATTRIBUTE_VALUE) VALUES ('SMS_SEND_START','/300465/','800');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO BRANCH_ATTRIBUTE_VALUE(ATTRIBUTE_CODE,BRANCH_CODE,ATTRIBUTE_VALUE) VALUES ('SMS_SEND_STOP','/322669/','2100');
    exception when dup_val_on_index then null;
end;
/
Begin
   INSERT INTO BRANCH_ATTRIBUTE_VALUE(ATTRIBUTE_CODE,BRANCH_CODE,ATTRIBUTE_VALUE) VALUES ('SMS_SEND_STOP','/300465/','2100');
    exception when dup_val_on_index then null;
end;
/
COMMIT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/patch_data_BRANCH_ATTRIBUTE_VALUE.sql =
PROMPT ===================================================================================== 



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/patch_data_BRANCH_ATTRIBUTE.sql =======
PROMPT ===================================================================================== 
