PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/patch_data_BRANCH_ATTRIBUTE.sql =======
PROMPT ===================================================================================== 

Begin
   INSERT INTO BRANCH_ATTRIBUTE(ATTRIBUTE_CODE,ATTRIBUTE_DESC,ATTRIBUTE_DATATYPE,ATTRIBUTE_FORMAT,ATTRIBUTE_MODULE) 
     select 'LINK_FOR_ABSBARS_WEBROZDRIB','������ ������-������ ��� ������ ���-������� �� webrozdrib','C','',''
       from dual where not exists (select 1 from BRANCH_ATTRIBUTE where  ATTRIBUTE_CODE = 'LINK_FOR_ABSBARS_WEBROZDRIB');

   INSERT INTO BRANCH_ATTRIBUTE(ATTRIBUTE_CODE,ATTRIBUTE_DESC,ATTRIBUTE_DATATYPE,ATTRIBUTE_FORMAT,ATTRIBUTE_MODULE) 
     select 'WS_AUTOKASSA','URL ��� ������ �����䳿 � �� "��������"','C','',''
       from dual where not exists (select 1 from BRANCH_ATTRIBUTE where  ATTRIBUTE_CODE = 'WS_AUTOKASSA');

   INSERT INTO BRANCH_ATTRIBUTE(ATTRIBUTE_CODE,ATTRIBUTE_DESC,ATTRIBUTE_DATATYPE,ATTRIBUTE_FORMAT,ATTRIBUTE_MODULE) 
     select 'WS_EXT_AUTOKASSA','URL ��� ���������� ������� ���-������ �� "��������"','C','',''
       from dual where not exists (select 1 from BRANCH_ATTRIBUTE where  ATTRIBUTE_CODE = 'WS_EXT_AUTOKASSA');


    exception when dup_val_on_index then null;
end;
/

COMMIT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/patch_data_BRANCH_ATTRIBUTE.sql =======
PROMPT ===================================================================================== 
