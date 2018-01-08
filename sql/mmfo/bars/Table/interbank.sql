

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INTERBANK.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INTERBANK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INTERBANK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''INTERBANK'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''INTERBANK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INTERBANK ***
begin 
  execute immediate '
  CREATE TABLE BARS.INTERBANK 
   (	FLI NUMBER(1,0), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INTERBANK ***
 exec bpa.alter_policies('INTERBANK');


COMMENT ON TABLE BARS.INTERBANK IS 'Виды внешних интерфейсов';
COMMENT ON COLUMN BARS.INTERBANK.FLI IS 'Код интерфейса';
COMMENT ON COLUMN BARS.INTERBANK.NAME IS 'Наименование';




PROMPT *** Create  constraint PK_INTERBANK ***
begin   
 execute immediate '
  ALTER TABLE BARS.INTERBANK ADD CONSTRAINT PK_INTERBANK PRIMARY KEY (FLI)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTERBANK_FLI_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INTERBANK MODIFY (FLI CONSTRAINT CC_INTERBANK_FLI_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTERBANK_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INTERBANK MODIFY (NAME CONSTRAINT CC_INTERBANK_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INTERBANK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INTERBANK ON BARS.INTERBANK (FLI) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INTERBANK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on INTERBANK       to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on INTERBANK       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on INTERBANK       to BARS_DM;
grant SELECT                                                                 on INTERBANK       to START1;
grant SELECT                                                                 on INTERBANK       to TECH005;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on INTERBANK       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INTERBANK.sql =========*** End *** ===
PROMPT ===================================================================================== 
