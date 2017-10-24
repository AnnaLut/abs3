

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/POLICY_RESPONSIBLE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to POLICY_RESPONSIBLE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table POLICY_RESPONSIBLE ***
begin 
  execute immediate '
  CREATE TABLE BARS.POLICY_RESPONSIBLE 
   (	TABLE_NAME VARCHAR2(30), 
	RESPONSIBLE_DEVELOPER VARCHAR2(30), 
	VALIDATED VARCHAR2(1), 
	ADMIN_VALIDATED VARCHAR2(1), 
	 CONSTRAINT PK_POLICYRESP PRIMARY KEY (TABLE_NAME) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYNI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to POLICY_RESPONSIBLE ***
 exec bpa.alter_policies('POLICY_RESPONSIBLE');


COMMENT ON TABLE BARS.POLICY_RESPONSIBLE IS 'Ответственные за политики разработчики';
COMMENT ON COLUMN BARS.POLICY_RESPONSIBLE.TABLE_NAME IS 'Имя таблицы или представления(view)';
COMMENT ON COLUMN BARS.POLICY_RESPONSIBLE.RESPONSIBLE_DEVELOPER IS 'Краткое имя разработчика';
COMMENT ON COLUMN BARS.POLICY_RESPONSIBLE.VALIDATED IS 'Y/null - признак валидации политик (Y - проверено)';
COMMENT ON COLUMN BARS.POLICY_RESPONSIBLE.ADMIN_VALIDATED IS '';




PROMPT *** Create  constraint FK_POLICYRESP_DEVELOPERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.POLICY_RESPONSIBLE ADD CONSTRAINT FK_POLICYRESP_DEVELOPERS FOREIGN KEY (RESPONSIBLE_DEVELOPER)
	  REFERENCES BARS.DEVELOPERS (DEVELOPER_NICK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_POLICYRESP_TABLENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.POLICY_RESPONSIBLE MODIFY (TABLE_NAME CONSTRAINT CC_POLICYRESP_TABLENAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_POLICYRESP ***
begin   
 execute immediate '
  ALTER TABLE BARS.POLICY_RESPONSIBLE ADD CONSTRAINT PK_POLICYRESP PRIMARY KEY (TABLE_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_POLICYRESP_TABLENAME_CC ***
begin   
 execute immediate '
  ALTER TABLE BARS.POLICY_RESPONSIBLE ADD CONSTRAINT CC_POLICYRESP_TABLENAME_CC CHECK (upper(table_name)=table_name) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_POLICYRESP_ADMVALIDATED_CC ***
begin   
 execute immediate '
  ALTER TABLE BARS.POLICY_RESPONSIBLE ADD CONSTRAINT CC_POLICYRESP_ADMVALIDATED_CC CHECK (admin_validated=''Y'') ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_POLICYRESP_VALIDATED_CC ***
begin   
 execute immediate '
  ALTER TABLE BARS.POLICY_RESPONSIBLE ADD CONSTRAINT CC_POLICYRESP_VALIDATED_CC CHECK (validated=''Y'') ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_POLICYRESP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_POLICYRESP ON BARS.POLICY_RESPONSIBLE (TABLE_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  POLICY_RESPONSIBLE ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on POLICY_RESPONSIBLE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/POLICY_RESPONSIBLE.sql =========*** En
PROMPT ===================================================================================== 
