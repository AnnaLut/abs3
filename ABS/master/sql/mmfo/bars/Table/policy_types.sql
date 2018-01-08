

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/POLICY_TYPES.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to POLICY_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''POLICY_TYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''POLICY_TYPES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''POLICY_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table POLICY_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.POLICY_TYPES 
   (	POLICY_TYPE VARCHAR2(30), 
	 CONSTRAINT PK_PLCTYPES PRIMARY KEY (POLICY_TYPE) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to POLICY_TYPES ***
 exec bpa.alter_policies('POLICY_TYPES');


COMMENT ON TABLE BARS.POLICY_TYPES IS 'Типы политик';
COMMENT ON COLUMN BARS.POLICY_TYPES.POLICY_TYPE IS 'Тип политики';




PROMPT *** Create  constraint CC_PLCTYPES_PLCTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.POLICY_TYPES MODIFY (POLICY_TYPE CONSTRAINT CC_PLCTYPES_PLCTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PLCTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.POLICY_TYPES ADD CONSTRAINT PK_PLCTYPES PRIMARY KEY (POLICY_TYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PLCTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PLCTYPES ON BARS.POLICY_TYPES (POLICY_TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  POLICY_TYPES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on POLICY_TYPES    to ABS_ADMIN;
grant SELECT                                                                 on POLICY_TYPES    to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on POLICY_TYPES    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on POLICY_TYPES    to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on POLICY_TYPES    to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on POLICY_TYPES    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/POLICY_TYPES.sql =========*** End *** 
PROMPT ===================================================================================== 
