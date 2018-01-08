

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BARS_SUPP_MODULES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BARS_SUPP_MODULES ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BARS_SUPP_MODULES ***
begin 
  execute immediate '
  CREATE TABLE BARS.BARS_SUPP_MODULES 
   (	MOD_CODE VARCHAR2(3), 
	MOD_WIDECODE VARCHAR2(10), 
	MOD_NAME VARCHAR2(200)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BARS_SUPP_MODULES ***
 exec bpa.alter_policies('BARS_SUPP_MODULES');


COMMENT ON TABLE BARS.BARS_SUPP_MODULES IS 'Модули, поддерживаемые БАРС-ом';
COMMENT ON COLUMN BARS.BARS_SUPP_MODULES.MOD_CODE IS 'Код модуля для идентификации в БД';
COMMENT ON COLUMN BARS.BARS_SUPP_MODULES.MOD_WIDECODE IS 'Код модуля описательный(используется как аббревиатура) для документации, используется в module_list.doc';
COMMENT ON COLUMN BARS.BARS_SUPP_MODULES.MOD_NAME IS 'Наименование модуля';




PROMPT *** Create  constraint XUK_SUPP_MODULES_WIDECODE ***
begin   
 execute immediate '
  ALTER TABLE BARS.BARS_SUPP_MODULES ADD CONSTRAINT XUK_SUPP_MODULES_WIDECODE UNIQUE (MOD_WIDECODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_BARS_SUPP_MODULES ***
begin   
 execute immediate '
  ALTER TABLE BARS.BARS_SUPP_MODULES ADD CONSTRAINT XPK_BARS_SUPP_MODULES PRIMARY KEY (MOD_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XUK_SUPP_MODULES_WIDECODE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XUK_SUPP_MODULES_WIDECODE ON BARS.BARS_SUPP_MODULES (MOD_WIDECODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_BARS_SUPP_MODULES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_BARS_SUPP_MODULES ON BARS.BARS_SUPP_MODULES (MOD_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BARS_SUPP_MODULES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BARS_SUPP_MODULES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BARS_SUPP_MODULES to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BARS_SUPP_MODULES to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BARS_SUPP_MODULES to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to BARS_SUPP_MODULES ***

  CREATE OR REPLACE PUBLIC SYNONYM BARS_SUPP_MODULES FOR BARS.BARS_SUPP_MODULES;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BARS_SUPP_MODULES.sql =========*** End
PROMPT ===================================================================================== 
