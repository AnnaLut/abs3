

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SEX.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SEX ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SEX'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SEX'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SEX'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SEX ***
begin 
  execute immediate '
  CREATE TABLE BARS.SEX 
   (	ID CHAR(1), 
	NAME VARCHAR2(15)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SEX ***
 exec bpa.alter_policies('SEX');


COMMENT ON TABLE BARS.SEX IS 'Пол';
COMMENT ON COLUMN BARS.SEX.ID IS 'Идентификатор пола';
COMMENT ON COLUMN BARS.SEX.NAME IS 'Наименование пола';




PROMPT *** Create  constraint CC_SEX_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEX MODIFY (ID CONSTRAINT CC_SEX_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SEX_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEX MODIFY (NAME CONSTRAINT CC_SEX_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SEX ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEX ADD CONSTRAINT PK_SEX PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SEX ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SEX ON BARS.SEX (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SEX ***
grant SELECT                                                                 on SEX             to BARSREADER_ROLE;
grant SELECT                                                                 on SEX             to BARSUPL;
grant SELECT                                                                 on SEX             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SEX             to BARS_DM;
grant SELECT                                                                 on SEX             to CUST001;
grant SELECT                                                                 on SEX             to DPT_ROLE;
grant SELECT                                                                 on SEX             to RCC_DEAL;
grant SELECT                                                                 on SEX             to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SEX             to WR_ALL_RIGHTS;
grant SELECT                                                                 on SEX             to WR_CUSTREG;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SEX.sql =========*** End *** =========
PROMPT ===================================================================================== 
