

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_TT_TTS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_TT_TTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_TT_TTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SW_TT_TTS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SW_TT_TTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_TT_TTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_TT_TTS 
   (	SWTT CHAR(3), 
	TT CHAR(3), 
	 CONSTRAINT PK_SWTTTTS PRIMARY KEY (SWTT, TT) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_TT_TTS ***
 exec bpa.alter_policies('SW_TT_TTS');


COMMENT ON TABLE BARS.SW_TT_TTS IS 'SWT. Связь типа транзакции SWIFT и типа операции АБС';
COMMENT ON COLUMN BARS.SW_TT_TTS.SWTT IS 'Код типа транзакции SWIFT';
COMMENT ON COLUMN BARS.SW_TT_TTS.TT IS 'Код типа операции АБС';




PROMPT *** Create  constraint CC_SWTTTTS_SWTT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_TT_TTS MODIFY (SWTT CONSTRAINT CC_SWTTTTS_SWTT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWTTTTS_TT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_TT_TTS MODIFY (TT CONSTRAINT CC_SWTTTTS_TT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SWTTTTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_TT_TTS ADD CONSTRAINT PK_SWTTTTS PRIMARY KEY (SWTT, TT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWTTTTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWTTTTS ON BARS.SW_TT_TTS (SWTT, TT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_TT_TTS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_TT_TTS       to BARS013;
grant SELECT                                                                 on SW_TT_TTS       to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_TT_TTS       to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_TT_TTS       to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to SW_TT_TTS ***

  CREATE OR REPLACE PUBLIC SYNONYM SW_TT_TTS FOR BARS.SW_TT_TTS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_TT_TTS.sql =========*** End *** ===
PROMPT ===================================================================================== 
