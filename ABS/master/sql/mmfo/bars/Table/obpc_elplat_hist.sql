

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OBPC_ELPLAT_HIST.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OBPC_ELPLAT_HIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OBPC_ELPLAT_HIST'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OBPC_ELPLAT_HIST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OBPC_ELPLAT_HIST'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OBPC_ELPLAT_HIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.OBPC_ELPLAT_HIST 
   (	ID NUMBER(38,0), 
	NLS VARCHAR2(14), 
	S NUMBER(38,2), 
	SOS NUMBER(38,0), 
	INS_DATE DATE DEFAULT sysdate, 
	REF NUMBER(38,0), 
	KV NUMBER(*,0) DEFAULT 980
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OBPC_ELPLAT_HIST ***
 exec bpa.alter_policies('OBPC_ELPLAT_HIST');


COMMENT ON TABLE BARS.OBPC_ELPLAT_HIST IS 'Архив справочника начисления З/П (ELPLAT1.TXT)';
COMMENT ON COLUMN BARS.OBPC_ELPLAT_HIST.ID IS 'Код';
COMMENT ON COLUMN BARS.OBPC_ELPLAT_HIST.NLS IS 'Бал~счет';
COMMENT ON COLUMN BARS.OBPC_ELPLAT_HIST.S IS 'Сумма';
COMMENT ON COLUMN BARS.OBPC_ELPLAT_HIST.SOS IS 'Состояние';
COMMENT ON COLUMN BARS.OBPC_ELPLAT_HIST.INS_DATE IS 'Дата архивации';
COMMENT ON COLUMN BARS.OBPC_ELPLAT_HIST.REF IS 'Референс';
COMMENT ON COLUMN BARS.OBPC_ELPLAT_HIST.KV IS '';




PROMPT *** Create  constraint PK_OBPCELPLATHIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_ELPLAT_HIST ADD CONSTRAINT PK_OBPCELPLATHIST PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OBPCELPLATHIST_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_ELPLAT_HIST ADD CONSTRAINT FK_OBPCELPLATHIST_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCELPLATHIST_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_ELPLAT_HIST MODIFY (ID CONSTRAINT CC_OBPCELPLATHIST_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCELPLATHIST_NLS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_ELPLAT_HIST MODIFY (NLS CONSTRAINT CC_OBPCELPLATHIST_NLS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCELPLATHIST_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_ELPLAT_HIST MODIFY (KV CONSTRAINT CC_OBPCELPLATHIST_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OBPCELPLATHIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OBPCELPLATHIST ON BARS.OBPC_ELPLAT_HIST (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OBPC_ELPLAT_HIST ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_ELPLAT_HIST to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OBPC_ELPLAT_HIST to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_ELPLAT_HIST to OBPC;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OBPC_ELPLAT_HIST to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OBPC_ELPLAT_HIST.sql =========*** End 
PROMPT ===================================================================================== 
