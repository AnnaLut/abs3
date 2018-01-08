

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DEVELOPERS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DEVELOPERS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DEVELOPERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DEVELOPERS 
   (	DEVELOPER_NICK VARCHAR2(30), 
	DEVELOPER_NAME VARCHAR2(64), 
	 CONSTRAINT PK_DEVELOPERS PRIMARY KEY (DEVELOPER_NICK) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYNI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DEVELOPERS ***
 exec bpa.alter_policies('DEVELOPERS');


COMMENT ON TABLE BARS.DEVELOPERS IS 'Разработчики АБС';
COMMENT ON COLUMN BARS.DEVELOPERS.DEVELOPER_NICK IS 'Краткое имя разработчика';
COMMENT ON COLUMN BARS.DEVELOPERS.DEVELOPER_NAME IS 'ФИО разработчика';




PROMPT *** Create  constraint CC_DEVELOPERS_NICK_CC ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEVELOPERS ADD CONSTRAINT CC_DEVELOPERS_NICK_CC CHECK (upper(developer_nick)=developer_nick) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEVELOPERS_NICK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEVELOPERS MODIFY (DEVELOPER_NICK CONSTRAINT CC_DEVELOPERS_NICK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEVELOPERS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEVELOPERS MODIFY (DEVELOPER_NAME CONSTRAINT CC_DEVELOPERS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DEVELOPERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEVELOPERS ADD CONSTRAINT PK_DEVELOPERS PRIMARY KEY (DEVELOPER_NICK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DEVELOPERS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DEVELOPERS ON BARS.DEVELOPERS (DEVELOPER_NICK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DEVELOPERS ***
grant SELECT                                                                 on DEVELOPERS      to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DEVELOPERS      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DEVELOPERS.sql =========*** End *** ==
PROMPT ===================================================================================== 
