

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_MODEL.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_MODEL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_MODEL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SW_MODEL'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SW_MODEL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_MODEL ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_MODEL 
   (	MT NUMBER(3,0), 
	NUM NUMBER(5,0), 
	SEQ CHAR(1), 
	SUBSEQ CHAR(2), 
	TAG CHAR(2), 
	OPT CHAR(1), 
	STATUS CHAR(1), 
	EMPTY CHAR(1), 
	SEQSTAT CHAR(1), 
	RPBLK VARCHAR2(10), 
	TRANS CHAR(1), 
	SPEC CHAR(1), 
	DTMTAG CHAR(5), 
	MTDTAG CHAR(5), 
	NAME VARCHAR2(70), 
	EDITVAL CHAR(1) DEFAULT ''Y'', 
	STATUS2 VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_MODEL ***
 exec bpa.alter_policies('SW_MODEL');


COMMENT ON TABLE BARS.SW_MODEL IS 'Шаблоны сообщений';
COMMENT ON COLUMN BARS.SW_MODEL.MT IS 'Тип сообщения';
COMMENT ON COLUMN BARS.SW_MODEL.NUM IS 'Порядковый номер поля';
COMMENT ON COLUMN BARS.SW_MODEL.SEQ IS 'Блок';
COMMENT ON COLUMN BARS.SW_MODEL.SUBSEQ IS 'Подблок';
COMMENT ON COLUMN BARS.SW_MODEL.TAG IS 'Таг';
COMMENT ON COLUMN BARS.SW_MODEL.OPT IS 'Опция';
COMMENT ON COLUMN BARS.SW_MODEL.STATUS IS 'Обязательность заполнения тэга M/O';
COMMENT ON COLUMN BARS.SW_MODEL.EMPTY IS 'Признак обязательности пустого тэга';
COMMENT ON COLUMN BARS.SW_MODEL.SEQSTAT IS '';
COMMENT ON COLUMN BARS.SW_MODEL.RPBLK IS 'Признак повторяющегося блока/повторяющегося поля';
COMMENT ON COLUMN BARS.SW_MODEL.TRANS IS 'Признак использования транслитерации для поля';
COMMENT ON COLUMN BARS.SW_MODEL.SPEC IS '';
COMMENT ON COLUMN BARS.SW_MODEL.DTMTAG IS 'Поле доп.реквизита Документ->Сообщение';
COMMENT ON COLUMN BARS.SW_MODEL.MTDTAG IS 'Поле доп.реквизита Сообщение->Документ';
COMMENT ON COLUMN BARS.SW_MODEL.NAME IS 'Наименование поля';
COMMENT ON COLUMN BARS.SW_MODEL.EDITVAL IS '';
COMMENT ON COLUMN BARS.SW_MODEL.STATUS2 IS '';




PROMPT *** Create  constraint CC_SWMODEL_EDITVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MODEL ADD CONSTRAINT CC_SWMODEL_EDITVAL CHECK (editval in (''Y'', ''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SWMODEL ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MODEL ADD CONSTRAINT PK_SWMODEL PRIMARY KEY (MT, NUM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWMODEL_EDITVAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MODEL MODIFY (EDITVAL CONSTRAINT CC_SWMODEL_EDITVAL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWMODEL_SEQSTAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MODEL MODIFY (SEQSTAT CONSTRAINT CC_SWMODEL_SEQSTAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWMODEL_EMPTY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MODEL MODIFY (EMPTY CONSTRAINT CC_SWMODEL_EMPTY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWMODEL_STATUS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MODEL MODIFY (STATUS CONSTRAINT CC_SWMODEL_STATUS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWMODEL_TAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MODEL MODIFY (TAG CONSTRAINT CC_SWMODEL_TAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWMODEL_SEQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MODEL MODIFY (SEQ CONSTRAINT CC_SWMODEL_SEQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWMODEL_NUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MODEL MODIFY (NUM CONSTRAINT CC_SWMODEL_NUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWMODEL_RPBLK ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MODEL ADD CONSTRAINT CC_SWMODEL_RPBLK CHECK (rpblk in (''RI'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWMODEL_DTMTAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MODEL ADD CONSTRAINT CC_SWMODEL_DTMTAG CHECK (replace(dtmtag, ''a'', ''A'') = upper(dtmtag)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWMODEL_MTDTAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MODEL ADD CONSTRAINT CC_SWMODEL_MTDTAG CHECK (replace(mtdtag, ''a'', ''A'') = upper(mtdtag)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWMODEL_EMPTY ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MODEL ADD CONSTRAINT CC_SWMODEL_EMPTY CHECK (empty in (''Y'', ''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWMODEL_TRANS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MODEL ADD CONSTRAINT CC_SWMODEL_TRANS CHECK (trans in (''Y'', ''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWMODEL_SPEC ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MODEL ADD CONSTRAINT CC_SWMODEL_SPEC CHECK (spec in (''Y'', ''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWMODEL_STATUS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MODEL ADD CONSTRAINT CC_SWMODEL_STATUS CHECK (status in (''M'', ''O'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWMODEL_SWMT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MODEL ADD CONSTRAINT FK_SWMODEL_SWMT FOREIGN KEY (MT)
	  REFERENCES BARS.SW_MT (MT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWMODEL_SWSEQ ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MODEL ADD CONSTRAINT FK_SWMODEL_SWSEQ FOREIGN KEY (SEQ)
	  REFERENCES BARS.SW_SEQ (SEQ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWMODEL_SWTAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MODEL ADD CONSTRAINT FK_SWMODEL_SWTAG FOREIGN KEY (TAG)
	  REFERENCES BARS.SW_TAG (TAG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SWMODEL_SWOPT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MODEL ADD CONSTRAINT FK_SWMODEL_SWOPT FOREIGN KEY (OPT)
	  REFERENCES BARS.SW_OPT (OPT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWMODEL_MT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MODEL MODIFY (MT CONSTRAINT CC_SWMODEL_MT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWMODEL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWMODEL ON BARS.SW_MODEL (MT, NUM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_MODEL ***
grant SELECT                                                                 on SW_MODEL        to BARS013;
grant SELECT                                                                 on SW_MODEL        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SW_MODEL        to BARS_DM;
grant SELECT                                                                 on SW_MODEL        to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_MODEL        to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to SW_MODEL ***

  CREATE OR REPLACE PUBLIC SYNONYM SW_MODEL FOR BARS.SW_MODEL;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_MODEL.sql =========*** End *** ====
PROMPT ===================================================================================== 
