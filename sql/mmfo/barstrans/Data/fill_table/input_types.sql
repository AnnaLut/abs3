begin
Insert into INPUT_TYPES
   (TYPE_NAME, TYPE_DESC, SESS_TYPE, ACT_TYPE, 
    OUTPUT_DATA_TYPE, INPUT_DATA_TYPE, PRIORITY, CONT_TYPE, JSON2XML, 
    XML2JSON, COMPRESS_TYPE, INPUT_DECOMPRESS, OUTPUT_COMPRESS, INPUT_BASE_64, 
    OUTPUT_BASE_64, STORE_HEAD, ADD_HEAD, LOGING)
 Values
   ('NBU_DOCUMENT_FO', 'qqq', 'SYNCH', 'begin nbu_gateway.nbu_601_parse_xml.p_parse_document_fo(:id); end;', 
    'CLOB', 'CLOB', 1, 93, 0, 
    0, 'GZIP', 1, 1, 1, 
    1, 0, 0, 1);
exception when dup_val_on_index then
null;
end;
/
begin
Insert into INPUT_TYPES
   (TYPE_NAME, TYPE_DESC, SESS_TYPE, ACT_TYPE, 
    OUTPUT_DATA_TYPE, INPUT_DATA_TYPE, PRIORITY, CONT_TYPE, JSON2XML, 
    XML2JSON, COMPRESS_TYPE, INPUT_DECOMPRESS, OUTPUT_COMPRESS, INPUT_BASE_64, 
    OUTPUT_BASE_64, STORE_HEAD, ADD_HEAD, LOGING)
 Values
   ('NBU_ADDRESS_FO', 'qqq', 'SYNCH', 'begin nbu_gateway.nbu_601_parse_xml.p_parse_address_fo(:id); end;', 
    'CLOB', 'CLOB', 1, 93, 0, 
    0, 'GZIP', 1, 1, 1, 
    1, 0, 0, 1);
exception when dup_val_on_index then
null;
end;
/
begin
Insert into INPUT_TYPES
   (TYPE_NAME, TYPE_DESC, SESS_TYPE, ACT_TYPE, 
    OUTPUT_DATA_TYPE, INPUT_DATA_TYPE, PRIORITY, CONT_TYPE, JSON2XML, 
    XML2JSON, COMPRESS_TYPE, INPUT_DECOMPRESS, OUTPUT_COMPRESS, INPUT_BASE_64, 
    OUTPUT_BASE_64, STORE_HEAD, ADD_HEAD, LOGING)
 Values
   ('NBU_PERSON_UO', 'qqq', 'SYNCH', 'begin nbu_gateway.nbu_601_parse_xml.p_parse_person_uo(:id); end;', 
    'CLOB', 'CLOB', 1, 93, 0, 
    0, 'GZIP', 1, 1, 1, 
    1, 0, 0, 1);
exception when dup_val_on_index then
null;
end;
/
begin
Insert into INPUT_TYPES
   (TYPE_NAME, TYPE_DESC, SESS_TYPE, ACT_TYPE, 
    OUTPUT_DATA_TYPE, INPUT_DATA_TYPE, PRIORITY, CONT_TYPE, JSON2XML, 
    XML2JSON, COMPRESS_TYPE, INPUT_DECOMPRESS, OUTPUT_COMPRESS, INPUT_BASE_64, 
    OUTPUT_BASE_64, STORE_HEAD, ADD_HEAD, LOGING)
 Values
   ('NBU_FINPERFORMANCE_UO', 'qqq', 'SYNCH', 'begin nbu_gateway.nbu_601_parse_xml.p_parse_finperformance_uo(:id); end;', 
    'CLOB', 'CLOB', 1, 93, 0, 
    0, 'GZIP', 1, 1, 1, 
    1, 0, 0, 1);
exception when dup_val_on_index then
null;
end;
/
begin
Insert into INPUT_TYPES
   (TYPE_NAME, TYPE_DESC, SESS_TYPE, ACT_TYPE, 
    OUTPUT_DATA_TYPE, INPUT_DATA_TYPE, PRIORITY, CONT_TYPE, JSON2XML, 
    XML2JSON, COMPRESS_TYPE, INPUT_DECOMPRESS, OUTPUT_COMPRESS, INPUT_BASE_64, 
    OUTPUT_BASE_64, STORE_HEAD, ADD_HEAD, LOGING)
 Values
   ('NBU_FINPERFORMANCEGR_UO', 'qqq', 'SYNCH', 'begin nbu_gateway.nbu_601_parse_xml.p_parse_finperformancegr_uo(:id); end;', 
    'CLOB', 'CLOB', 1, 93, 0, 
    0, 'GZIP', 1, 1, 1, 
    1, 0, 0, 1);
exception when dup_val_on_index then
null;
end;
/
begin
Insert into INPUT_TYPES
   (TYPE_NAME, TYPE_DESC, SESS_TYPE, ACT_TYPE, 
    OUTPUT_DATA_TYPE, INPUT_DATA_TYPE, PRIORITY, CONT_TYPE, JSON2XML, 
    XML2JSON, COMPRESS_TYPE, INPUT_DECOMPRESS, OUTPUT_COMPRESS, INPUT_BASE_64, 
    OUTPUT_BASE_64, STORE_HEAD, ADD_HEAD, LOGING)
 Values
   ('NBU_OWNERJUR_UO', 'qqq', 'SYNCH', 'begin nbu_gateway.nbu_601_parse_xml.p_parse_ownerjur_uo(:id); end;', 
    'CLOB', 'CLOB', 1, 93, 0, 
    0, 'GZIP', 1, 1, 1, 
    1, 0, 0, 1);
exception when dup_val_on_index then
null;
end;
/
begin
Insert into INPUT_TYPES
   (TYPE_NAME, TYPE_DESC, SESS_TYPE, ACT_TYPE, 
    OUTPUT_DATA_TYPE, INPUT_DATA_TYPE, PRIORITY, CONT_TYPE, JSON2XML, 
    XML2JSON, COMPRESS_TYPE, INPUT_DECOMPRESS, OUTPUT_COMPRESS, INPUT_BASE_64, 
    OUTPUT_BASE_64, STORE_HEAD, ADD_HEAD, LOGING)
 Values
   ('NBU_OWNERPP_UO', 'qqq', 'SYNCH', 'begin nbu_gateway.nbu_601_parse_xml.p_parse_ownerpp_uo(:id); end;', 
    'CLOB', 'CLOB', 1, 93, 0, 
    0, 'GZIP', 1, 1, 1, 
    1, 0, 0, 1);
exception when dup_val_on_index then
null;
end;
/
begin
Insert into INPUT_TYPES
   (TYPE_NAME, TYPE_DESC, SESS_TYPE, ACT_TYPE, 
    OUTPUT_DATA_TYPE, INPUT_DATA_TYPE, PRIORITY, CONT_TYPE, JSON2XML, 
    XML2JSON, COMPRESS_TYPE, INPUT_DECOMPRESS, OUTPUT_COMPRESS, INPUT_BASE_64, 
    OUTPUT_BASE_64, STORE_HEAD, ADD_HEAD, LOGING)
 Values
   ('NBU_PARTNERS_UO', 'qqq', 'SYNCH', 'begin nbu_gateway.nbu_601_parse_xml.p_parse_partners_uo(:id); end;', 
    'CLOB', 'CLOB', 1, 93, 0, 
    0, 'GZIP', 1, 1, 1, 
    1, 0, 0, 1);
exception when dup_val_on_index then
null;
end;
/
begin
Insert into INPUT_TYPES
   (TYPE_NAME, TYPE_DESC, SESS_TYPE, ACT_TYPE, 
    OUTPUT_DATA_TYPE, INPUT_DATA_TYPE, PRIORITY, CONT_TYPE, JSON2XML, 
    XML2JSON, COMPRESS_TYPE, INPUT_DECOMPRESS, OUTPUT_COMPRESS, INPUT_BASE_64, 
    OUTPUT_BASE_64, STORE_HEAD, ADD_HEAD, LOGING)
 Values
   ('NBU_CREDIT', 'qqq', 'SYNCH', 'begin nbu_gateway.nbu_601_parse_xml.p_parse_credit(:id); end;', 
    'CLOB', 'CLOB', 1, 93, 0, 
    0, 'GZIP', 1, 1, 1, 
    1, 0, 0, 1);
exception when dup_val_on_index then
null;
end;
/
begin
Insert into INPUT_TYPES
   (TYPE_NAME, TYPE_DESC, SESS_TYPE, ACT_TYPE, 
    OUTPUT_DATA_TYPE, INPUT_DATA_TYPE, PRIORITY, CONT_TYPE, JSON2XML, 
    XML2JSON, COMPRESS_TYPE, INPUT_DECOMPRESS, OUTPUT_COMPRESS, INPUT_BASE_64, 
    OUTPUT_BASE_64, STORE_HEAD, ADD_HEAD, LOGING)
 Values
   ('NBU_CREDIT_PLEDGE', 'qqq', 'SYNCH', 'begin nbu_gateway.nbu_601_parse_xml.p_parse_credit_pledge(:id); end;', 
    'CLOB', 'CLOB', 1, 93, 0, 
    0, 'GZIP', 1, 1, 1, 
    1, 0, 0, 1);
exception when dup_val_on_index then
null;
end;
/
begin
Insert into INPUT_TYPES
   (TYPE_NAME, TYPE_DESC, SESS_TYPE, ACT_TYPE, 
    OUTPUT_DATA_TYPE, INPUT_DATA_TYPE, PRIORITY, CONT_TYPE, JSON2XML, 
    XML2JSON, COMPRESS_TYPE, INPUT_DECOMPRESS, OUTPUT_COMPRESS, INPUT_BASE_64, 
    OUTPUT_BASE_64, STORE_HEAD, ADD_HEAD, LOGING)
 Values
   ('NBU_PERSON_FO', 'qqq', 'SYNCH', 'begin nbu_gateway.nbu_601_parse_xml.p_parse_person_fo(:id); end; ', 
    'CLOB', 'CLOB', 1, 93, 0, 
    0, 'GZIP', 1, 1, 1, 
    1, 0, 0, 1);
exception when dup_val_on_index then
null;
end;
/
begin
Insert into INPUT_TYPES
   (TYPE_NAME, TYPE_DESC, SESS_TYPE, ACT_TYPE, 
    OUTPUT_DATA_TYPE, INPUT_DATA_TYPE, PRIORITY, CONT_TYPE, JSON2XML, 
    XML2JSON, COMPRESS_TYPE, INPUT_DECOMPRESS, OUTPUT_COMPRESS, INPUT_BASE_64, 
    OUTPUT_BASE_64, STORE_HEAD, ADD_HEAD, LOGING)
 Values
   ('NBU_PLEDGE_DEP', 'qqq', 'SYNCH', 'begin nbu_gateway.nbu_601_parse_xml.p_parse_pledge_dep(:id); end;', 
    'CLOB', 'CLOB', 1, 93, 0, 
    0, 'GZIP', 1, 1, 1, 
    1, 0, 0, 1);
exception when dup_val_on_index then
null;
end;
/
begin
Insert into INPUT_TYPES
   (TYPE_NAME, TYPE_DESC, SESS_TYPE, ACT_TYPE, 
    OUTPUT_DATA_TYPE, INPUT_DATA_TYPE, PRIORITY, CONT_TYPE, JSON2XML, 
    XML2JSON, COMPRESS_TYPE, INPUT_DECOMPRESS, OUTPUT_COMPRESS, INPUT_BASE_64, 
    OUTPUT_BASE_64, STORE_HEAD, ADD_HEAD, LOGING)
 Values
   ('EDECL_GET_PDF', 'EDECL_GET_PDF', 'SYNCH', 'begin bars.eds_intg.create_report(:id); end;', 
    'CLOB', 'CLOB', 1, 93, 0, 
    0, 'GZIP', 0, 0, 0, 
    0, 0, 0, 1);
exception when dup_val_on_index then
null;
end;
/
begin
Insert into INPUT_TYPES
   (TYPE_NAME, TYPE_DESC, SESS_TYPE, ACT_TYPE, 
    OUTPUT_DATA_TYPE, INPUT_DATA_TYPE, PRIORITY, CONT_TYPE, JSON2XML, 
    XML2JSON, COMPRESS_TYPE, INPUT_DECOMPRESS, OUTPUT_COMPRESS, INPUT_BASE_64, 
    OUTPUT_BASE_64, STORE_HEAD, ADD_HEAD, LOGING)
 Values
   ('BILLS_REQUEST', 'Request from region to cdb', 'SYNCH', 'begin bills.bill_service_mgr.bypass_request(:id); end;', 
    'CLOB', 'CLOB', 1, 93, 0, 
    0, 'GZIP', 0, 0, 0, 
    0, 0, 0, 1);
exception when dup_val_on_index then
null;
end;
/
begin
Insert into INPUT_TYPES
   (TYPE_NAME, TYPE_DESC, SESS_TYPE, ACT_TYPE, 
    OUTPUT_DATA_TYPE, INPUT_DATA_TYPE, PRIORITY, CONT_TYPE, JSON2XML, 
    XML2JSON, COMPRESS_TYPE, INPUT_DECOMPRESS, OUTPUT_COMPRESS, INPUT_BASE_64, 
    OUTPUT_BASE_64, STORE_HEAD, ADD_HEAD, LOGING)
 Values
   ('EDECL_REQ_TO_MMFO', 'EDECL_REQ_TO_MMFO', 'ASYNCH', 'begin bars.eds_intg.pocess_request(:id); end;', 
    'CLOB', 'CLOB', 1, 93, 0, 
    0, 'GZIP', 0, 0, 0, 
    0, 0, 0, 1);
exception when dup_val_on_index then
null;
end;
/
begin
Insert into INPUT_TYPES
   (TYPE_NAME, TYPE_DESC, SESS_TYPE, ACT_TYPE, 
    OUTPUT_DATA_TYPE, INPUT_DATA_TYPE, PRIORITY, CONT_TYPE, JSON2XML, 
    XML2JSON, COMPRESS_TYPE, INPUT_DECOMPRESS, OUTPUT_COMPRESS, INPUT_BASE_64, 
    OUTPUT_BASE_64, STORE_HEAD, ADD_HEAD, LOGING)
 Values
   ('EDECL_GET_DECL', 'EDECL_GET_DECL', 'SYNCH', 'begin bars.eds_utl.search_decl(:id); end;', 
    'CLOB', 'CLOB', 1, 93, 0, 
    0, 'GZIP', 0, 0, 0, 
    0, 0, 0, 1);
exception when dup_val_on_index then
null;
end;
/
begin
Insert into INPUT_TYPES
   (TYPE_NAME, TYPE_DESC, SESS_TYPE, ACT_TYPE, 
    OUTPUT_DATA_TYPE, INPUT_DATA_TYPE, PRIORITY, CONT_TYPE, JSON2XML, 
    XML2JSON, COMPRESS_TYPE, INPUT_DECOMPRESS, OUTPUT_COMPRESS, INPUT_BASE_64, 
    OUTPUT_BASE_64, STORE_HEAD, ADD_HEAD, LOGING)
 Values
   ('NBU_GROUPUR_UO', 'form_601', 'SYNCH', 'begin nbu_gateway.nbu_601_parse_xml.p_parse_groupur_uo(:id); end;', 
    'CLOB', 'CLOB', 1, 93, 0, 
    0, 'GZIP', 1, 1, 1, 
    1, 0, 0, 1);
exception when dup_val_on_index then
null;
end;
/
begin
Insert into INPUT_TYPES
   (TYPE_NAME, TYPE_DESC, SESS_TYPE, ACT_TYPE, 
    OUTPUT_DATA_TYPE, INPUT_DATA_TYPE, PRIORITY, CONT_TYPE, JSON2XML, 
    XML2JSON, COMPRESS_TYPE, INPUT_DECOMPRESS, OUTPUT_COMPRESS, INPUT_BASE_64, 
    OUTPUT_BASE_64, STORE_HEAD, ADD_HEAD, LOGING)
 Values
   ('NBU_FINPERFORMANCEPR_UO', 'form_601', 'SYNCH', 'begin nbu_gateway.nbu_601_parse_xml.p_parse_finperformancepr_uo(:id); end;', 
    'CLOB', 'CLOB', 1, 93, 0, 
    0, 'GZIP', 1, 1, 1, 
    1, 0, 0, 1);
exception when dup_val_on_index then
null;
end;
/
begin
Insert into INPUT_TYPES
   (TYPE_NAME, TYPE_DESC, SESS_TYPE, ACT_TYPE, 
    OUTPUT_DATA_TYPE, INPUT_DATA_TYPE, PRIORITY, CONT_TYPE, JSON2XML, 
    XML2JSON, COMPRESS_TYPE, INPUT_DECOMPRESS, OUTPUT_COMPRESS, INPUT_BASE_64, 
    OUTPUT_BASE_64, STORE_HEAD, ADD_HEAD, LOGING)
 Values
   ('NBU_CREDIT_TRANCHE', 'form_601', 'SYNCH', 'begin nbu_gateway.nbu_601_parse_xml.p_parse_credit_tranche(:id); end;', 
    'CLOB', 'CLOB', 1, 93, 0, 
    0, 'GZIP', 1, 1, 1, 
    1, 0, 0, 1);
exception when dup_val_on_index then
null;
end;
/
COMMIT;
/