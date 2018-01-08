

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BR_TYPES.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BR_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BR_TYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BR_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BR_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BR_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.BR_TYPES 
   (	BR_TYPE NUMBER(38,0), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BR_TYPES ***
 exec bpa.alter_policies('BR_TYPES');


COMMENT ON TABLE BARS.BR_TYPES IS 'Типы базовых процентных ставок';
COMMENT ON COLUMN BARS.BR_TYPES.BR_TYPE IS 'Тип базовой процентной ставки';
COMMENT ON COLUMN BARS.BR_TYPES.NAME IS 'Семантика';




PROMPT *** Create  constraint PK_BRTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_TYPES ADD CONSTRAINT PK_BRTYPES PRIMARY KEY (BR_TYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007326 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_TYPES MODIFY (BR_TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BRTYPES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_TYPES MODIFY (NAME CONSTRAINT CC_BRTYPES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BRTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BRTYPES ON BARS.BR_TYPES (BR_TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BR_TYPES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BR_TYPES        to ABS_ADMIN;
grant SELECT                                                                 on BR_TYPES        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BR_TYPES        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BR_TYPES        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BR_TYPES        to BR_TYPES;
grant SELECT                                                                 on BR_TYPES        to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on BR_TYPES        to DPT_ADMIN;
grant SELECT                                                                 on BR_TYPES        to START1;
grant SELECT                                                                 on BR_TYPES        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BR_TYPES        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on BR_TYPES        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BR_TYPES.sql =========*** End *** ====
PROMPT ===================================================================================== 
