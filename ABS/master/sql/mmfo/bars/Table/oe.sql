

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OE.sql =========*** Run *** ==========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OE ***
begin 
  execute immediate '
  CREATE TABLE BARS.OE 
   (	OE CHAR(5), 
	NAME VARCHAR2(210), 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OE ***
 exec bpa.alter_policies('OE');


COMMENT ON TABLE BARS.OE IS 'Справочник форм хозяйственности';
COMMENT ON COLUMN BARS.OE.OE IS 'Код отрасли';
COMMENT ON COLUMN BARS.OE.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.OE.D_CLOSE IS 'Дата закрытия';




PROMPT *** Create  constraint CC_OE_OE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OE MODIFY (OE CONSTRAINT CC_OE_OE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OE_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OE MODIFY (NAME CONSTRAINT CC_OE_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OE ***
begin   
 execute immediate '
  ALTER TABLE BARS.OE ADD CONSTRAINT PK_OE PRIMARY KEY (OE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OE ON BARS.OE (OE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OE              to ABS_ADMIN;
grant SELECT                                                                 on OE              to BARSREADER_ROLE;
grant SELECT                                                                 on OE              to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OE              to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OE              to BARS_DM;
grant SELECT                                                                 on OE              to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on OE              to OE;
grant SELECT                                                                 on OE              to START1;
grant SELECT                                                                 on OE              to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OE              to WR_ALL_RIGHTS;
grant SELECT                                                                 on OE              to WR_CUSTREG;
grant FLASHBACK,SELECT                                                       on OE              to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OE.sql =========*** End *** ==========
PROMPT ===================================================================================== 
