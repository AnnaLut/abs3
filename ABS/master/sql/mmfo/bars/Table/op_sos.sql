

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OP_SOS.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OP_SOS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OP_SOS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OP_SOS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OP_SOS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OP_SOS ***
begin 
  execute immediate '
  CREATE TABLE BARS.OP_SOS 
   (	SOS NUMBER(2,0), 
	NAME VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OP_SOS ***
 exec bpa.alter_policies('OP_SOS');


COMMENT ON TABLE BARS.OP_SOS IS 'Состояния операций';
COMMENT ON COLUMN BARS.OP_SOS.SOS IS 'Код';
COMMENT ON COLUMN BARS.OP_SOS.NAME IS 'Наименование';




PROMPT *** Create  constraint PK_OPSOS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP_SOS ADD CONSTRAINT PK_OPSOS PRIMARY KEY (SOS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPSOS_SOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP_SOS MODIFY (SOS CONSTRAINT CC_OPSOS_SOS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OPSOS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP_SOS MODIFY (NAME CONSTRAINT CC_OPSOS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OPSOS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OPSOS ON BARS.OP_SOS (SOS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OP_SOS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OP_SOS          to ABS_ADMIN;
grant SELECT                                                                 on OP_SOS          to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OP_SOS          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OP_SOS          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OP_SOS          to OP_SOS;
grant SELECT                                                                 on OP_SOS          to START1;
grant SELECT                                                                 on OP_SOS          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OP_SOS          to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on OP_SOS          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OP_SOS.sql =========*** End *** ======
PROMPT ===================================================================================== 
