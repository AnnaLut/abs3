

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INT_ION.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INT_ION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INT_ION'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''INT_ION'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''INT_ION'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INT_ION ***
begin 
  execute immediate '
  CREATE TABLE BARS.INT_ION 
   (	IO NUMBER(38,0), 
	NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INT_ION ***
 exec bpa.alter_policies('INT_ION');


COMMENT ON TABLE BARS.INT_ION IS 'Типы остатков для начисления процентов';
COMMENT ON COLUMN BARS.INT_ION.IO IS 'Код типа остатка';
COMMENT ON COLUMN BARS.INT_ION.NAME IS 'Название типа остатка';




PROMPT *** Create  constraint PK_INTION ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ION ADD CONSTRAINT PK_INTION PRIMARY KEY (IO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTION_IO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ION MODIFY (IO CONSTRAINT CC_INTION_IO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INTION_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INT_ION MODIFY (NAME CONSTRAINT CC_INTION_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INTION ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INTION ON BARS.INT_ION (IO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INT_ION ***
grant SELECT                                                                 on INT_ION         to BARS009;
grant SELECT                                                                 on INT_ION         to BARS010;
grant SELECT                                                                 on INT_ION         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_ION         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on INT_ION         to BARS_DM;
grant SELECT                                                                 on INT_ION         to DPT;
grant SELECT                                                                 on INT_ION         to DPT_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on INT_ION         to RCC_DEAL;
grant SELECT                                                                 on INT_ION         to RPBN001;
grant SELECT                                                                 on INT_ION         to START1;
grant SELECT                                                                 on INT_ION         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on INT_ION         to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to INT_ION ***

  CREATE OR REPLACE PUBLIC SYNONYM INT_ION FOR BARS.INT_ION;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INT_ION.sql =========*** End *** =====
PROMPT ===================================================================================== 
