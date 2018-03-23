

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/META_TACCESS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to META_TACCESS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''META_TACCESS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''META_TACCESS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table META_TACCESS ***
begin 
  execute immediate '
  CREATE TABLE BARS.META_TACCESS 
   (	ACODE VARCHAR2(8), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to META_TACCESS ***
 exec bpa.alter_policies('META_TACCESS');


COMMENT ON TABLE BARS.META_TACCESS IS 'Метаописание. Типы доступа к справочникам';
COMMENT ON COLUMN BARS.META_TACCESS.ACODE IS 'Код типа доступа';
COMMENT ON COLUMN BARS.META_TACCESS.NAME IS 'Наименование типа доступа';




PROMPT *** Create  constraint PK_METATACCESS ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_TACCESS ADD CONSTRAINT PK_METATACCESS PRIMARY KEY (ACODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METATACCESS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_TACCESS MODIFY (NAME CONSTRAINT CC_METATACCESS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METATACCESS_ACODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_TACCESS MODIFY (ACODE CONSTRAINT CC_METATACCESS_ACODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_METATACCESS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_METATACCESS ON BARS.META_TACCESS (ACODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  META_TACCESS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on META_TACCESS    to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on META_TACCESS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on META_TACCESS    to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on META_TACCESS    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/META_TACCESS.sql =========*** End *** 
PROMPT ===================================================================================== 
