

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MIGR_USER_TYPES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MIGR_USER_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MIGR_USER_TYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''MIGR_USER_TYPES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''MIGR_USER_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MIGR_USER_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.MIGR_USER_TYPES 
   (	TYPE_ID NUMBER, 
	TYPE_NAME VARCHAR2(30), 
	LOGNAME VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MIGR_USER_TYPES ***
 exec bpa.alter_policies('MIGR_USER_TYPES');


COMMENT ON TABLE BARS.MIGR_USER_TYPES IS 'Типи користувачів для імпорту у веб';
COMMENT ON COLUMN BARS.MIGR_USER_TYPES.TYPE_ID IS 'Номер';
COMMENT ON COLUMN BARS.MIGR_USER_TYPES.TYPE_NAME IS 'Найменування';
COMMENT ON COLUMN BARS.MIGR_USER_TYPES.LOGNAME IS 'Ім`я еталонного користувача в АБС';




PROMPT *** Create  constraint PK_MIGRUSERTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.MIGR_USER_TYPES ADD CONSTRAINT PK_MIGRUSERTYPES PRIMARY KEY (TYPE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MIGRUSERTYPES_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MIGR_USER_TYPES MODIFY (TYPE_ID CONSTRAINT CC_MIGRUSERTYPES_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_MIGRUSERTYPES_LOGNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.MIGR_USER_TYPES MODIFY (LOGNAME CONSTRAINT CC_MIGRUSERTYPES_LOGNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_MIGRUSERTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_MIGRUSERTYPES ON BARS.MIGR_USER_TYPES (TYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MIGR_USER_TYPES ***
grant SELECT                                                                 on MIGR_USER_TYPES to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on MIGR_USER_TYPES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MIGR_USER_TYPES to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on MIGR_USER_TYPES to START1;
grant SELECT                                                                 on MIGR_USER_TYPES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MIGR_USER_TYPES.sql =========*** End *
PROMPT ===================================================================================== 
