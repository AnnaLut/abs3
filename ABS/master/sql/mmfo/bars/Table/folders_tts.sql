

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FOLDERS_TTS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FOLDERS_TTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FOLDERS_TTS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FOLDERS_TTS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''FOLDERS_TTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FOLDERS_TTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.FOLDERS_TTS 
   (	IDFO NUMBER(38,0), 
	TT CHAR(3), 
	 CONSTRAINT PK_FOLDERSTTS PRIMARY KEY (IDFO, TT) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FOLDERS_TTS ***
 exec bpa.alter_policies('FOLDERS_TTS');


COMMENT ON TABLE BARS.FOLDERS_TTS IS 'Связка папки <-> Операции';
COMMENT ON COLUMN BARS.FOLDERS_TTS.IDFO IS 'Идентификатор папки';
COMMENT ON COLUMN BARS.FOLDERS_TTS.TT IS 'Тип операции';




PROMPT *** Create  constraint CC_FOLDERSTTS_IDFO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FOLDERS_TTS MODIFY (IDFO CONSTRAINT CC_FOLDERSTTS_IDFO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FOLDERSTTS_TT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FOLDERS_TTS MODIFY (TT CONSTRAINT CC_FOLDERSTTS_TT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_FOLDERSTTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.FOLDERS_TTS ADD CONSTRAINT PK_FOLDERSTTS PRIMARY KEY (IDFO, TT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FOLDERSTTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FOLDERSTTS ON BARS.FOLDERS_TTS (IDFO, TT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FOLDERS_TTS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on FOLDERS_TTS     to ABS_ADMIN;
grant SELECT                                                                 on FOLDERS_TTS     to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FOLDERS_TTS     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FOLDERS_TTS     to BARS_DM;
grant SELECT                                                                 on FOLDERS_TTS     to KLBX;
grant SELECT                                                                 on FOLDERS_TTS     to PYOD001;
grant SELECT                                                                 on FOLDERS_TTS     to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on FOLDERS_TTS     to TECH005;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FOLDERS_TTS     to WR_ALL_RIGHTS;
grant SELECT                                                                 on FOLDERS_TTS     to WR_DOC_INPUT;
grant FLASHBACK,SELECT                                                       on FOLDERS_TTS     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FOLDERS_TTS.sql =========*** End *** =
PROMPT ===================================================================================== 
