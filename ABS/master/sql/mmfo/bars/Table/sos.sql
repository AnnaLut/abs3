

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SOS.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SOS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SOS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SOS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SOS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SOS ***
begin 
  execute immediate '
  CREATE TABLE BARS.SOS 
   (	SOS NUMBER(1,0), 
	NAME VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SOS ***
 exec bpa.alter_policies('SOS');


COMMENT ON TABLE BARS.SOS IS 'Состояния документов';
COMMENT ON COLUMN BARS.SOS.SOS IS 'Код';
COMMENT ON COLUMN BARS.SOS.NAME IS 'Наименование';




PROMPT *** Create  constraint PK_SOS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOS ADD CONSTRAINT PK_SOS PRIMARY KEY (SOS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOS_SOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOS MODIFY (SOS CONSTRAINT CC_SOS_SOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SOS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SOS MODIFY (NAME CONSTRAINT CC_SOS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SOS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SOS ON BARS.SOS (SOS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SOS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SOS             to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SOS             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SOS             to BARS_DM;
grant SELECT                                                                 on SOS             to RPBN001;
grant DELETE,INSERT,SELECT,UPDATE                                            on SOS             to SOS;
grant SELECT                                                                 on SOS             to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SOS             to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SOS             to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SOS.sql =========*** End *** =========
PROMPT ===================================================================================== 
