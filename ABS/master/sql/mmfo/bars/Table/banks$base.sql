

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BANKS$BASE.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BANKS$BASE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BANKS$BASE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BANKS$BASE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BANKS$BASE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BANKS$BASE ***
begin 
  execute immediate '
  CREATE TABLE BARS.BANKS$BASE 
   (	MFO VARCHAR2(12), 
	SAB CHAR(4), 
	NB VARCHAR2(38), 
	KODG NUMBER(3,0), 
	BLK NUMBER(1,0), 
	MFOU VARCHAR2(12), 
	SSP NUMBER(1,0), 
	NMO CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BANKS$BASE ***
 exec bpa.alter_policies('BANKS$BASE');


COMMENT ON TABLE BARS.BANKS$BASE IS 'Справочник банков';
COMMENT ON COLUMN BARS.BANKS$BASE.MFO IS 'Код МФО банка';
COMMENT ON COLUMN BARS.BANKS$BASE.SAB IS 'Почтовый ящик (Идентификатор в СЭП)';
COMMENT ON COLUMN BARS.BANKS$BASE.NB IS 'Наименование банка';
COMMENT ON COLUMN BARS.BANKS$BASE.KODG IS 'Код группы';
COMMENT ON COLUMN BARS.BANKS$BASE.BLK IS 'Признак блокирования (1=заблокирован)';
COMMENT ON COLUMN BARS.BANKS$BASE.MFOU IS 'Код МФО банка';
COMMENT ON COLUMN BARS.BANKS$BASE.SSP IS 'Участие банка в ССП (1)';
COMMENT ON COLUMN BARS.BANKS$BASE.NMO IS 'Номер модели';




PROMPT *** Create  constraint FK_BANKS_BANKS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS$BASE ADD CONSTRAINT FK_BANKS_BANKS2 FOREIGN KEY (MFOU)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS$BASE ADD CONSTRAINT PK_BANKS PRIMARY KEY (MFO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKS_SSP ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS$BASE ADD CONSTRAINT CC_BANKS_SSP CHECK (ssp in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_BANKS_SAB ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS$BASE ADD CONSTRAINT UK_BANKS_SAB UNIQUE (SAB)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKS_MFO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS$BASE MODIFY (MFO CONSTRAINT CC_BANKS_MFO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKS_NB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS$BASE MODIFY (NB CONSTRAINT CC_BANKS_NB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BANKS_SAB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BANKS$BASE MODIFY (SAB CONSTRAINT CC_BANKS_SAB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I3_BANKS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I3_BANKS ON BARS.BANKS$BASE (MFOU, MFO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BANKS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BANKS ON BARS.BANKS$BASE (MFO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_BANKS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.I1_BANKS ON BARS.BANKS$BASE (SAB) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BANKS$BASE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BANKS$BASE      to ABS_ADMIN;
grant FLASHBACK,REFERENCES,SELECT                                            on BANKS$BASE      to BARSAQ with grant option;
grant REFERENCES,SELECT                                                      on BANKS$BASE      to BARSAQ_ADM with grant option;
grant SELECT                                                                 on BANKS$BASE      to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on BANKS$BASE      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BANKS$BASE      to BARS_DM;
grant SELECT                                                                 on BANKS$BASE      to BASIC_INFO;
grant SELECT                                                                 on BANKS$BASE      to CC_DOC;
grant SELECT                                                                 on BANKS$BASE      to DPT;
grant SELECT                                                                 on BANKS$BASE      to JBOSS_USR;
grant SELECT,SELECT                                                          on BANKS$BASE      to KLBX;
grant SELECT                                                                 on BANKS$BASE      to REFSYNC_USR;
grant SELECT                                                                 on BANKS$BASE      to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on BANKS$BASE      to TECH005;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BANKS$BASE      to WR_ALL_RIGHTS;
grant SELECT                                                                 on BANKS$BASE      to WR_CREPORTS;
grant SELECT                                                                 on BANKS$BASE      to WR_CUSTREG;
grant SELECT                                                                 on BANKS$BASE      to WR_DEPOSIT_U;
grant SELECT                                                                 on BANKS$BASE      to WR_DOCHAND;
grant SELECT                                                                 on BANKS$BASE      to WR_DOCVIEW;
grant SELECT                                                                 on BANKS$BASE      to WR_DOC_INPUT;
grant SELECT                                                                 on BANKS$BASE      to WR_KP;
grant SELECT                                                                 on BANKS$BASE      to WR_VIEWACC;



PROMPT *** Create SYNONYM  to BANKS$BASE ***

  CREATE OR REPLACE PUBLIC SYNONYM BANKS_ALL FOR BARS.BANKS$BASE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BANKS$BASE.sql =========*** End *** ==
PROMPT ===================================================================================== 
