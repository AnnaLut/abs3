

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TTSAP.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TTSAP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TTSAP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TTSAP'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''TTSAP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TTSAP ***
begin 
  execute immediate '
  CREATE TABLE BARS.TTSAP 
   (	TTAP CHAR(3), 
	TT CHAR(3), 
	DK NUMBER(1,0) DEFAULT 0, 
	 CONSTRAINT PK_TTSAP PRIMARY KEY (TTAP, TT, DK) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TTSAP ***
 exec bpa.alter_policies('TTSAP');


COMMENT ON TABLE BARS.TTSAP IS 'Связанные  ОПЕРАЦИИ';
COMMENT ON COLUMN BARS.TTSAP.TTAP IS 'Тип транзакции';
COMMENT ON COLUMN BARS.TTSAP.TT IS 'Тип транзакции';
COMMENT ON COLUMN BARS.TTSAP.DK IS 'Признак дебета-кредита';




PROMPT *** Create  constraint CC_TTSAP_TTAP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTSAP MODIFY (TTAP CONSTRAINT CC_TTSAP_TTAP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TTSAP_TT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTSAP MODIFY (TT CONSTRAINT CC_TTSAP_TT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TTSAP_DK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTSAP MODIFY (DK CONSTRAINT CC_TTSAP_DK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_TTSAP ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTSAP ADD CONSTRAINT PK_TTSAP PRIMARY KEY (TTAP, TT, DK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TTSAP_DK ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTSAP ADD CONSTRAINT FK_TTSAP_DK FOREIGN KEY (DK)
	  REFERENCES BARS.DK (DK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TTSAP_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTSAP ADD CONSTRAINT FK_TTSAP_TTS FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TTSAP_TTS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTSAP ADD CONSTRAINT FK_TTSAP_TTS2 FOREIGN KEY (TTAP)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TTSAP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TTSAP ON BARS.TTSAP (TTAP, TT, DK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TTSAP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TTSAP           to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TTSAP           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TTSAP           to PYOD001;
grant SELECT                                                                 on TTSAP           to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on TTSAP           to TECH005;
grant DELETE,INSERT,SELECT,UPDATE                                            on TTSAP           to TTSAP;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TTSAP           to WR_ALL_RIGHTS;
grant SELECT                                                                 on TTSAP           to WR_DOC_INPUT;
grant SELECT                                                                 on TTSAP           to WR_IMPEXP;
grant FLASHBACK,SELECT                                                       on TTSAP           to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TTSAP.sql =========*** End *** =======
PROMPT ===================================================================================== 
