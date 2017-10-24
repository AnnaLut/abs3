

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAFF_WEB_LONG_SESSION.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAFF_WEB_LONG_SESSION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAFF_WEB_LONG_SESSION'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAFF_WEB_LONG_SESSION ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAFF_WEB_LONG_SESSION 
   (	CLIENT_IDENTIFIER VARCHAR2(64), 
	EXPIRES DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAFF_WEB_LONG_SESSION ***
 exec bpa.alter_policies('STAFF_WEB_LONG_SESSION');


COMMENT ON TABLE BARS.STAFF_WEB_LONG_SESSION IS '';
COMMENT ON COLUMN BARS.STAFF_WEB_LONG_SESSION.CLIENT_IDENTIFIER IS 'Ідетнифікатор клієнта';
COMMENT ON COLUMN BARS.STAFF_WEB_LONG_SESSION.EXPIRES IS 'Діє по';




PROMPT *** Create  constraint PK_STAFF_WEB_LONG_SESSION ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_WEB_LONG_SESSION ADD CONSTRAINT PK_STAFF_WEB_LONG_SESSION PRIMARY KEY (CLIENT_IDENTIFIER)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119219 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_WEB_LONG_SESSION MODIFY (CLIENT_IDENTIFIER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STAFF_WEB_LONG_SESSION ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STAFF_WEB_LONG_SESSION ON BARS.STAFF_WEB_LONG_SESSION (CLIENT_IDENTIFIER) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAFF_WEB_LONG_SESSION.sql =========**
PROMPT ===================================================================================== 
