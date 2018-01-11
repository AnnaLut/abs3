

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/POLICY_MNEMONICS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to POLICY_MNEMONICS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table POLICY_MNEMONICS ***
begin 
  execute immediate '
  CREATE TABLE BARS.POLICY_MNEMONICS 
   (	POLICY_CHAR VARCHAR2(1), 
	POLICY_NAME_PREFIX VARCHAR2(30), 
	POLICY_FUNCTION VARCHAR2(61), 
	POLICY_TYPE VARCHAR2(30) DEFAULT ''SHARED_STATIC''
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to POLICY_MNEMONICS ***
 exec bpa.alter_policies('POLICY_MNEMONICS');


COMMENT ON TABLE BARS.POLICY_MNEMONICS IS 'Мнемоника политик';
COMMENT ON COLUMN BARS.POLICY_MNEMONICS.POLICY_CHAR IS 'Код';
COMMENT ON COLUMN BARS.POLICY_MNEMONICS.POLICY_NAME_PREFIX IS 'Префикс имени';
COMMENT ON COLUMN BARS.POLICY_MNEMONICS.POLICY_FUNCTION IS 'Имя функции';
COMMENT ON COLUMN BARS.POLICY_MNEMONICS.POLICY_TYPE IS 'Тип политики';




PROMPT *** Create  constraint CC_PLCMNEMONICS_PLCNMPREFIX_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.POLICY_MNEMONICS MODIFY (POLICY_NAME_PREFIX CONSTRAINT CC_PLCMNEMONICS_PLCNMPREFIX_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PLCMNEMONICS_PLCFUNC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.POLICY_MNEMONICS MODIFY (POLICY_FUNCTION CONSTRAINT CC_PLCMNEMONICS_PLCFUNC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PLCMNEMONICS_PLCTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.POLICY_MNEMONICS MODIFY (POLICY_TYPE CONSTRAINT CC_PLCMNEMONICS_PLCTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PLCMNEMONICS ***
begin   
 execute immediate '
  ALTER TABLE BARS.POLICY_MNEMONICS ADD CONSTRAINT PK_PLCMNEMONICS PRIMARY KEY (POLICY_CHAR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PLCMNEMONICS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PLCMNEMONICS ON BARS.POLICY_MNEMONICS (POLICY_CHAR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  POLICY_MNEMONICS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on POLICY_MNEMONICS to ABS_ADMIN;
grant SELECT                                                                 on POLICY_MNEMONICS to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on POLICY_MNEMONICS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on POLICY_MNEMONICS to BARS_DM;
grant SELECT                                                                 on POLICY_MNEMONICS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on POLICY_MNEMONICS to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on POLICY_MNEMONICS to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/POLICY_MNEMONICS.sql =========*** End 
PROMPT ===================================================================================== 
