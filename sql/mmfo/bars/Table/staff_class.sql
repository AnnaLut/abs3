

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAFF_CLASS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAFF_CLASS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAFF_CLASS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STAFF_CLASS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''STAFF_CLASS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAFF_CLASS ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAFF_CLASS 
   (	CLSID NUMBER(38,0), 
	NAME VARCHAR2(35), 
	MARK NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAFF_CLASS ***
 exec bpa.alter_policies('STAFF_CLASS');


COMMENT ON TABLE BARS.STAFF_CLASS IS 'Классы персонала';
COMMENT ON COLUMN BARS.STAFF_CLASS.CLSID IS 'Идентификатор класса';
COMMENT ON COLUMN BARS.STAFF_CLASS.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.STAFF_CLASS.MARK IS 'Уровень приоритет';




PROMPT *** Create  constraint PK_STAFFCLS ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_CLASS ADD CONSTRAINT PK_STAFFCLS PRIMARY KEY (CLSID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFCLS_CLSID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_CLASS MODIFY (CLSID CONSTRAINT CC_STAFFCLS_CLSID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFCLS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_CLASS MODIFY (NAME CONSTRAINT CC_STAFFCLS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFCLS_MARK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_CLASS MODIFY (MARK CONSTRAINT CC_STAFFCLS_MARK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STAFFCLS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STAFFCLS ON BARS.STAFF_CLASS (CLSID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STAFF_CLASS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFF_CLASS     to ABS_ADMIN;
grant SELECT                                                                 on STAFF_CLASS     to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STAFF_CLASS     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STAFF_CLASS     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFF_CLASS     to STAFF_CLASS;
grant SELECT                                                                 on STAFF_CLASS     to START1;
grant SELECT                                                                 on STAFF_CLASS     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STAFF_CLASS     to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on STAFF_CLASS     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAFF_CLASS.sql =========*** End *** =
PROMPT ===================================================================================== 
