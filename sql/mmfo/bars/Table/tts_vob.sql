

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TTS_VOB.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TTS_VOB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TTS_VOB'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TTS_VOB'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''TTS_VOB'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TTS_VOB ***
begin 
  execute immediate '
  CREATE TABLE BARS.TTS_VOB 
   (	TT CHAR(3), 
	VOB NUMBER(38,0), 
	ORD NUMBER(5,0), 
	 CONSTRAINT PK_TTSVOB PRIMARY KEY (TT, VOB) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TTS_VOB ***
 exec bpa.alter_policies('TTS_VOB');


COMMENT ON TABLE BARS.TTS_VOB IS 'ОПЕРАЦИИ <-> ВИДЫ документов';
COMMENT ON COLUMN BARS.TTS_VOB.TT IS 'Тип транзакции';
COMMENT ON COLUMN BARS.TTS_VOB.VOB IS 'Код вида документа';
COMMENT ON COLUMN BARS.TTS_VOB.ORD IS 'Порядок сортировки';




PROMPT *** Create  constraint FK_TTSVOB_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_VOB ADD CONSTRAINT FK_TTSVOB_TTS FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TTSVOB_VOB ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_VOB ADD CONSTRAINT FK_TTSVOB_VOB FOREIGN KEY (VOB)
	  REFERENCES BARS.VOB (VOB) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TTSVOB_TT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_VOB MODIFY (TT CONSTRAINT CC_TTSVOB_TT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TTSVOB_VOB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_VOB MODIFY (VOB CONSTRAINT CC_TTSVOB_VOB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_TTSVOB ***
begin   
 execute immediate '
  ALTER TABLE BARS.TTS_VOB ADD CONSTRAINT PK_TTSVOB PRIMARY KEY (TT, VOB)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TTSVOB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TTSVOB ON BARS.TTS_VOB (TT, VOB) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TTS_VOB ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TTS_VOB         to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TTS_VOB         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TTS_VOB         to PYOD001;
grant SELECT                                                                 on TTS_VOB         to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on TTS_VOB         to TECH005;
grant DELETE,INSERT,SELECT,UPDATE                                            on TTS_VOB         to TTS_VOB;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TTS_VOB         to WR_ALL_RIGHTS;
grant SELECT                                                                 on TTS_VOB         to WR_CREDIT;
grant SELECT                                                                 on TTS_VOB         to WR_DOC_INPUT;
grant FLASHBACK,SELECT                                                       on TTS_VOB         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TTS_VOB.sql =========*** End *** =====
PROMPT ===================================================================================== 
