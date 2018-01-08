

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_ENVELOPE_STATE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_ENVELOPE_STATE ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_ENVELOPE_STATE 
   (	CODE VARCHAR2(30), 
	NAME VARCHAR2(60)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_ENVELOPE_STATE IS 'Статус конверта';
COMMENT ON COLUMN PFU.PFU_ENVELOPE_STATE.CODE IS 'Код статуса';
COMMENT ON COLUMN PFU.PFU_ENVELOPE_STATE.NAME IS 'Наименование статуса';



PROMPT *** Create  grants  PFU_ENVELOPE_STATE ***
grant SELECT                                                                 on PFU_ENVELOPE_STATE to BARSREADER_ROLE;
grant SELECT                                                                 on PFU_ENVELOPE_STATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_ENVELOPE_STATE.sql =========*** End
PROMPT ===================================================================================== 
