begin
    execute immediate 'alter table dpt_poas
     add  POST_ENG VARCHAR2(100)';
    exception when others then 
     if sqlcode = -1430 then null; else raise; 
     end if; 
end;
/ 

begin
    execute immediate 'alter table dpt_poas
     add  TVBV_NUM VARCHAR2(15)';
    exception when others then 
     if sqlcode = -1430 then null; else raise; 
     end if; 
end;
/ 

begin
    execute immediate 'alter table dpt_poas
     add  doc_basis VARCHAR2(2000)';
    exception when others then 
     if sqlcode = -1430 then null; else raise; 
     end if; 
end;
/

COMMENT ON COLUMN BARS.DPT_POAS.POST_ENG IS 'Посада підписанта на англ.';

COMMENT ON COLUMN BARS.DPT_POAS.TVBV_NUM IS 'N ТВБВ';

COMMENT ON COLUMN BARS.DPT_POAS.doc_basis IS 'Документ підстава(наказ/довіреність)';

COMMENT ON COLUMN BARS.DPT_POAS.doc_basis IS 'Документ підстава(наказ/довіреність)';
