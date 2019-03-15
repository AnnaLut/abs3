PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/patch_data_BRANCH_ATTRIBUTE_VALUE.sql =======
PROMPT ===================================================================================== 

Begin
   INSERT INTO BRANCH_ATTRIBUTE_VALUE(ATTRIBUTE_CODE,BRANCH_CODE,ATTRIBUTE_VALUE) 
     select  'LINK_FOR_ABSBARS_WEBROZDRIB','/', replace(ATTRIBUTE_VALUE,'.ua/',':4030.ua/')
      from  BRANCH_ATTRIBUTE_VALUE 
      where attribute_code = 'LINK_FOR_ABSBARS_SOAPWEBSERVICES'
        and not exists (select 1 from branch_attribute_value where attribute_code = 'LINK_FOR_ABSBARS_WEBROZDRIB');

   INSERT INTO BRANCH_ATTRIBUTE_VALUE(ATTRIBUTE_CODE,BRANCH_CODE,ATTRIBUTE_VALUE) 
     select 'WS_AUTOKASSA','/','AutocasaService.asmx' from dual where not exists (select 1 from branch_attribute_value where attribute_code = 'WS_AUTOKASSA');

   INSERT INTO BRANCH_ATTRIBUTE_VALUE(ATTRIBUTE_CODE,BRANCH_CODE,ATTRIBUTE_VALUE) 
     select 'WS_EXT_AUTOKASSA','/','https://mqtest-00-01.oschadbank.ua:7846/Avtokassa/OschadIntegrationService' 
       from dual where not exists (select 1 from branch_attribute_value where attribute_code = 'WS_EXT_AUTOKASSA');

    exception when dup_val_on_index then null;

end;
/

COMMIT;


