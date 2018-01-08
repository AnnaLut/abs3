

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAFFTIP_APP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAFFTIP_APP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAFFTIP_APP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STAFFTIP_APP'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''STAFFTIP_APP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAFFTIP_APP ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAFFTIP_APP 
   (	ID NUMBER(22,0), 
	CODEAPP VARCHAR2(30 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAFFTIP_APP ***
 exec bpa.alter_policies('STAFFTIP_APP');


COMMENT ON TABLE BARS.STAFFTIP_APP IS 'Типов_ користувач_ <-> АРМи';
COMMENT ON COLUMN BARS.STAFFTIP_APP.ID IS 'Код типового користувача';
COMMENT ON COLUMN BARS.STAFFTIP_APP.CODEAPP IS 'Код АРМу';




PROMPT *** Create  constraint PK_STAFFTIPAPP ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFFTIP_APP ADD CONSTRAINT PK_STAFFTIPAPP PRIMARY KEY (ID, CODEAPP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFFTIPAPP_STAFFTIPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFFTIP_APP ADD CONSTRAINT FK_STAFFTIPAPP_STAFFTIPS FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF_TIPS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFTIPAPP_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFFTIP_APP MODIFY (ID CONSTRAINT CC_STAFFTIPAPP_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFTIPAPP_CODEAPP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFFTIP_APP MODIFY (CODEAPP CONSTRAINT CC_STAFFTIPAPP_CODEAPP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STAFFTIPAPP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STAFFTIPAPP ON BARS.STAFFTIP_APP (ID, CODEAPP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STAFFTIP_APP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFFTIP_APP    to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFFTIP_APP    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STAFFTIP_APP    to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAFFTIP_APP.sql =========*** End *** 
PROMPT ===================================================================================== 
