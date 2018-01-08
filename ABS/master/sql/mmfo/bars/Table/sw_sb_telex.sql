

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_SB_TELEX.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_SB_TELEX ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_SB_TELEX'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SW_SB_TELEX'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''SW_SB_TELEX'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_SB_TELEX ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_SB_TELEX 
   (	REF NUMBER, 
	SWREF NUMBER, 
	RNK NUMBER, 
	FN VARCHAR2(15), 
	DAT DATE, 
	FDAT DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_SB_TELEX ***
 exec bpa.alter_policies('SW_SB_TELEX');


COMMENT ON TABLE BARS.SW_SB_TELEX IS 'SWT. Сформированные реестры сообщений для клиентов';
COMMENT ON COLUMN BARS.SW_SB_TELEX.REF IS 'Референс документа, порожденного по SWIFT сообщению';
COMMENT ON COLUMN BARS.SW_SB_TELEX.SWREF IS 'Референс SWIFT сообщения';
COMMENT ON COLUMN BARS.SW_SB_TELEX.RNK IS 'Код клиента';
COMMENT ON COLUMN BARS.SW_SB_TELEX.FN IS 'Имя сформированного файла реестра';
COMMENT ON COLUMN BARS.SW_SB_TELEX.DAT IS 'Дата и время формирования файла реестра';
COMMENT ON COLUMN BARS.SW_SB_TELEX.FDAT IS 'Банковская дата зачисления';
COMMENT ON COLUMN BARS.SW_SB_TELEX.KF IS '';




PROMPT *** Create  constraint PK_SWSBTELEX ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_SB_TELEX ADD CONSTRAINT PK_SWSBTELEX PRIMARY KEY (KF, REF, SWREF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWSBTELEX_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_SB_TELEX MODIFY (REF CONSTRAINT CC_SWSBTELEX_REF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWSBTELEX_SWREF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_SB_TELEX MODIFY (SWREF CONSTRAINT CC_SWSBTELEX_SWREF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWSBTELEX_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_SB_TELEX MODIFY (RNK CONSTRAINT CC_SWSBTELEX_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWSBTELEX_FN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_SB_TELEX MODIFY (FN CONSTRAINT CC_SWSBTELEX_FN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWSBTELEX_DAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_SB_TELEX MODIFY (DAT CONSTRAINT CC_SWSBTELEX_DAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWSBTELEX_FDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_SB_TELEX MODIFY (FDAT CONSTRAINT CC_SWSBTELEX_FDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWSBTELEX_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_SB_TELEX MODIFY (KF CONSTRAINT CC_SWSBTELEX_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_SWSBTELEX ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_SWSBTELEX ON BARS.SW_SB_TELEX (RNK, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWSBTELEX ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWSBTELEX ON BARS.SW_SB_TELEX (KF, REF, SWREF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_SB_TELEX ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_SB_TELEX     to BARS013;
grant SELECT                                                                 on SW_SB_TELEX     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_SB_TELEX     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SW_SB_TELEX     to BARS_DM;
grant SELECT                                                                 on SW_SB_TELEX     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_SB_TELEX     to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to SW_SB_TELEX ***

  CREATE OR REPLACE PUBLIC SYNONYM SW_SB_TELEX FOR BARS.SW_SB_TELEX;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_SB_TELEX.sql =========*** End *** =
PROMPT ===================================================================================== 
