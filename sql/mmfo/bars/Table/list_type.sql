

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/LIST_TYPE.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to LIST_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''LIST_TYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''LIST_TYPE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''LIST_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table LIST_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.LIST_TYPE 
   (	ID NUMBER(5,0), 
	LIST_CODE VARCHAR2(30 CHAR), 
	LIST_NAME VARCHAR2(300 CHAR), 
	IS_ACTIVE CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to LIST_TYPE ***
 exec bpa.alter_policies('LIST_TYPE');


COMMENT ON TABLE BARS.LIST_TYPE IS 'Довідник типів списків
';
COMMENT ON COLUMN BARS.LIST_TYPE.ID IS '';
COMMENT ON COLUMN BARS.LIST_TYPE.LIST_CODE IS '';
COMMENT ON COLUMN BARS.LIST_TYPE.LIST_NAME IS '';
COMMENT ON COLUMN BARS.LIST_TYPE.IS_ACTIVE IS '';




PROMPT *** Create  constraint SYS_C006183 ***
begin   
 execute immediate '
  ALTER TABLE BARS.LIST_TYPE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006184 ***
begin   
 execute immediate '
  ALTER TABLE BARS.LIST_TYPE MODIFY (LIST_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006185 ***
begin   
 execute immediate '
  ALTER TABLE BARS.LIST_TYPE MODIFY (LIST_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006186 ***
begin   
 execute immediate '
  ALTER TABLE BARS.LIST_TYPE MODIFY (IS_ACTIVE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_LIST_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.LIST_TYPE ADD CONSTRAINT PK_LIST_TYPE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint AK_KEY_2_LIST_TYP ***
begin   
 execute immediate '
  ALTER TABLE BARS.LIST_TYPE ADD CONSTRAINT AK_KEY_2_LIST_TYP UNIQUE (LIST_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_LIST_TYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_LIST_TYPE ON BARS.LIST_TYPE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index AK_KEY_2_LIST_TYP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.AK_KEY_2_LIST_TYP ON BARS.LIST_TYPE (LIST_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  LIST_TYPE ***
grant SELECT                                                                 on LIST_TYPE       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on LIST_TYPE       to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/LIST_TYPE.sql =========*** End *** ===
PROMPT ===================================================================================== 
