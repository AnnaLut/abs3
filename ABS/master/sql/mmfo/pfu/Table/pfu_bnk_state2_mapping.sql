

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/pfu_bnk_state2_mapping.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  table pfu_bnk_state2_mapping ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_BNK_STATE2_MAPPING 
   (ID               NUMBER(10,0),
    PFU_RESULT       NUMBER(1,0),
    PFU_TAG          VARCHAR2(4000),
    MSG              VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** Add comments to the table PFU.pfu_bnk_state2_mapping ***
COMMENT ON TABLE PFU.pfu_bnk_state2_mapping IS 'Маппінг результатів опрацювання кожного запису файлу для квитанції 2 (PUT_EPP_PACKET_BNK_STATE_2)';

PROMPT *** Add comments to the columns of table PFU.pfu_bnk_state2_mapping *** 
COMMENT ON COLUMN PFU.pfu_bnk_state2_mapping.PFU_RESULT IS 'Результат опрацювання кожного запису файлу';
COMMENT ON COLUMN PFU.pfu_bnk_state2_mapping.MSG IS 'Під-строка для пошуку в тексті';



PROMPT *** Create  grants  pfu_bnk_state2_mapping ***
grant SELECT                                                                 on pfu_bnk_state2_mapping    to BARSREADER_ROLE;
grant SELECT                                                                 on pfu_bnk_state2_mapping    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/pfu_bnk_state2_mapping.sql =========*** End *** =
PROMPT ===================================================================================== 
