

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/POS.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to POS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''POS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''POS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''POS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table POS ***
begin 
  execute immediate '
  CREATE TABLE BARS.POS 
   (	POS NUMBER(1,0), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to POS ***
 exec bpa.alter_policies('POS');


COMMENT ON TABLE BARS.POS IS 'Признак основного счета';
COMMENT ON COLUMN BARS.POS.POS IS 'Код';
COMMENT ON COLUMN BARS.POS.NAME IS 'Наименование';




PROMPT *** Create  constraint PK_POS ***
begin   
 execute immediate '
  ALTER TABLE BARS.POS ADD CONSTRAINT PK_POS PRIMARY KEY (POS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_POS_POS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.POS MODIFY (POS CONSTRAINT CC_POS_POS_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_POS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.POS MODIFY (NAME CONSTRAINT CC_POS_NAME_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_POS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_POS ON BARS.POS (POS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  POS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on POS             to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on POS             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on POS             to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on POS             to POS;
grant SELECT                                                                 on POS             to START1;
grant SELECT                                                                 on POS             to TECH001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on POS             to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on POS             to WR_REFREAD;
grant SELECT                                                                 on POS             to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/POS.sql =========*** End *** =========
PROMPT ===================================================================================== 
