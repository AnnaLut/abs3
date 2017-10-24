

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BASEM.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BASEM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BASEM'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BASEM'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BASEM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BASEM ***
begin 
  execute immediate '
  CREATE TABLE BARS.BASEM 
   (	BASEM NUMBER(1,0), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BASEM ***
 exec bpa.alter_policies('BASEM');


COMMENT ON TABLE BARS.BASEM IS '% Ѕазовые мес€ца';
COMMENT ON COLUMN BARS.BASEM.BASEM IS ' од мес€ца';
COMMENT ON COLUMN BARS.BASEM.NAME IS 'Ќаименование базового мес€ца';




PROMPT *** Create  constraint CC_BASEM_BASEM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BASEM MODIFY (BASEM CONSTRAINT CC_BASEM_BASEM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BASEM_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BASEM MODIFY (NAME CONSTRAINT CC_BASEM_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BASEM ***
begin   
 execute immediate '
  ALTER TABLE BARS.BASEM ADD CONSTRAINT PK_BASEM PRIMARY KEY (BASEM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BASEM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BASEM ON BARS.BASEM (BASEM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BASEM ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BASEM           to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BASEM           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BASEM           to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BASEM           to BASEM;
grant SELECT                                                                 on BASEM           to CUST001;
grant SELECT                                                                 on BASEM           to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BASEM           to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on BASEM           to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BASEM.sql =========*** End *** =======
PROMPT ===================================================================================== 
