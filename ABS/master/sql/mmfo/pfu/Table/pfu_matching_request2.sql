

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/pfu_matching_request2.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  table pfu_matching_request2 ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_MATCHING_REQUEST2 
   (BATCH_REQUEST_ID NUMBER(10,0),
    STATE            VARCHAR2(10) DEFAULT ''NEW'', 
    CREATE_DATE      DATE DEFAULT SYSDATE,
    XML_DATA         CLOB,
    COMM             VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** Add comments to the table PFU.PFU_MATCHING_REQUEST2 ***
COMMENT ON TABLE PFU.pfu_matching_request2 IS 'Файли квитанції 2 (PUT_EPP_PACKET_BNK_STATE_2)';

PROMPT *** Add comments to the columns of table PFU.PFU_MATCHING_REQUEST2 *** 
COMMENT ON COLUMN PFU.pfu_matching_request2.BATCH_REQUEST_ID IS '';
COMMENT ON COLUMN PFU.pfu_matching_request2.STATE IS 'Стан файлу квитанції';
COMMENT ON COLUMN PFU.pfu_matching_request2.CREATE_DATE IS 'Дата створення файлу';
COMMENT ON COLUMN PFU.pfu_matching_request2.XML_DATA IS 'Файл квитанції';
COMMENT ON COLUMN PFU.pfu_matching_request2.COMM IS 'Коментар';


begin
    execute immediate 'create index I_MATCH_REQ2_BATCH_REQ_ID on PFU.PFU_MATCHING_REQUEST2 (BATCH_REQUEST_ID)';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/


PROMPT *** Create  grants  pfu_matching_request2 ***
grant SELECT                                                                 on pfu_matching_request2    to BARSREADER_ROLE;
grant SELECT                                                                 on pfu_matching_request2    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/pfu_matching_request2.sql =========*** End *** =
PROMPT ===================================================================================== 
