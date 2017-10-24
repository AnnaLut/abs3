SET DEFINE OFF;
--CURRENT

begin
    execute immediate 
'Insert into MBM_PARAMETERS
   (PARAMETER_NAME, PARAMETER_VALUE, DESCRIPTION)
 Values
   (''CorpLight.BaseApiUrl'', ''https://10.10.10.15/bars.api.web.client/'', ''URL для підключення до CorpLight'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 
'Insert into MBM_PARAMETERS
   (PARAMETER_NAME, PARAMETER_VALUE, DESCRIPTION)
 Values
   (''CorpLight.AppicationId'', ''ABS-302076'', ''ID додатку зареєстрованого в CorpLight'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 
'Insert into MBM_PARAMETERS
   (PARAMETER_NAME, PARAMETER_VALUE, DESCRIPTION)
 Values
   (''CorpLight.AppicationSecret'', ''b37b23ac-d798-47b4-97da-5905cdb4f48c'', ''Secret додатку зареєстрованого в CorpLight'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 
'Insert into MBM_PARAMETERS
   (PARAMETER_NAME, PARAMETER_VALUE, DESCRIPTION)
 Values
   (''CorpLight.CrtRequestsExportPath'', ''c:\crtrequests'', ''Шлях для вивантаження запитів на підключення сертифікатів'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 
'Insert into MBM_PARAMETERS
   (PARAMETER_NAME, PARAMETER_VALUE, DESCRIPTION)
 Values
   (''Acsk.BaseServiceUrl'', ''https://134.249.121.28:5444/gate/'', ''URL для підключення до АЦСК Nokk'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/

begin
    execute immediate 
'Insert into MBM_PARAMETERS
   (PARAMETER_NAME, PARAMETER_VALUE, DESCRIPTION)
 Values
   (''Acsk.AuthorityKey'', ''3939D15354040BF71ACFFFFA20A52284B0D7AD5F9C769D35ACBD7329315ABBF9'', ''Ключ АЦСК Nokk'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/

begin
    execute immediate 
'Insert into MBM_PARAMETERS
   (PARAMETER_NAME, PARAMETER_VALUE, DESCRIPTION)
 Values
   (''Acsk.VisaCount'', ''1'', ''Кількість віз для відправки в АЦСК'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/

COMMIT;
