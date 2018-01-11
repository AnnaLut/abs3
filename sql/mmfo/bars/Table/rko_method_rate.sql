

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RKO_METHOD_RATE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RKO_METHOD_RATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RKO_METHOD_RATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''RKO_METHOD_RATE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''RKO_METHOD_RATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RKO_METHOD_RATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.RKO_METHOD_RATE 
   (	ID NUMBER(10,0), 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RKO_METHOD_RATE ***
 exec bpa.alter_policies('RKO_METHOD_RATE');


COMMENT ON TABLE BARS.RKO_METHOD_RATE IS 'Спосіб зміни процентної ставки за договором банківського рахунку';
COMMENT ON COLUMN BARS.RKO_METHOD_RATE.ID IS '';
COMMENT ON COLUMN BARS.RKO_METHOD_RATE.NAME IS '';




PROMPT *** Create  constraint PK_RKOMETHODRATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_METHOD_RATE ADD CONSTRAINT PK_RKOMETHODRATE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RKOMETHODRATE_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_METHOD_RATE MODIFY (ID CONSTRAINT CC_RKOMETHODRATE_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RKOMETHODRATE_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_METHOD_RATE MODIFY (NAME CONSTRAINT CC_RKOMETHODRATE_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_RKOMETHODRATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_RKOMETHODRATE ON BARS.RKO_METHOD_RATE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RKO_METHOD_RATE ***
grant SELECT                                                                 on RKO_METHOD_RATE to BARSREADER_ROLE;
grant SELECT                                                                 on RKO_METHOD_RATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RKO_METHOD_RATE to BARS_DM;
grant SELECT                                                                 on RKO_METHOD_RATE to CUST001;
grant SELECT                                                                 on RKO_METHOD_RATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RKO_METHOD_RATE.sql =========*** End *
PROMPT ===================================================================================== 
