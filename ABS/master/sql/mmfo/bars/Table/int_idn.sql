

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INT_IDN.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INT_IDN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INT_IDN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''INT_IDN'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''INT_IDN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INT_IDN ***
begin 
  execute immediate '
  CREATE TABLE BARS.INT_IDN 
   (	ID NUMBER, 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INT_IDN ***
 exec bpa.alter_policies('INT_IDN');


COMMENT ON TABLE BARS.INT_IDN IS 'Типы процентных карточек';
COMMENT ON COLUMN BARS.INT_IDN.ID IS 'Код типа процентной карточки';
COMMENT ON COLUMN BARS.INT_IDN.NAME IS 'Название типа процентной карточки';




PROMPT *** Create  constraint PK_INTIDN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_IDN ADD CONSTRAINT PK_INTIDN PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTIDN_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_IDN MODIFY (ID CONSTRAINT CC_INTIDN_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTIDN_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_IDN MODIFY (NAME CONSTRAINT CC_INTIDN_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INTIDN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INTIDN ON BARS.INT_IDN (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INT_IDN ***
grant SELECT                                                                 on INT_IDN         to BARS009;
grant SELECT                                                                 on INT_IDN         to BARS010;
grant SELECT                                                                 on INT_IDN         to BARSREADER_ROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on INT_IDN         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on INT_IDN         to BARS_DM;
grant SELECT                                                                 on INT_IDN         to DPT;
grant SELECT                                                                 on INT_IDN         to DPT_ADMIN;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on INT_IDN         to RCC_DEAL;
grant SELECT                                                                 on INT_IDN         to RPBN001;
grant SELECT                                                                 on INT_IDN         to START1;
grant SELECT                                                                 on INT_IDN         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on INT_IDN         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INT_IDN.sql =========*** End *** =====
PROMPT ===================================================================================== 
