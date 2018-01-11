

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_USER_RESPONSIBILITY.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_USER_RESPONSIBILITY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_USER_RESPONSIBILITY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_USER_RESPONSIBILITY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_USER_RESPONSIBILITY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_USER_RESPONSIBILITY ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_USER_RESPONSIBILITY 
   (	STAFF_ID NUMBER, 
	SRV_ID VARCHAR2(100), 
	SRV_HIERARCHY VARCHAR2(100), 
	BRANCH VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_USER_RESPONSIBILITY ***
 exec bpa.alter_policies('WCS_USER_RESPONSIBILITY');


COMMENT ON TABLE BARS.WCS_USER_RESPONSIBILITY IS 'Відповідальність користувачів по завкам';
COMMENT ON COLUMN BARS.WCS_USER_RESPONSIBILITY.STAFF_ID IS 'Ідентифікатор користувача';
COMMENT ON COLUMN BARS.WCS_USER_RESPONSIBILITY.SRV_ID IS 'Ідентифікатор служби';
COMMENT ON COLUMN BARS.WCS_USER_RESPONSIBILITY.SRV_HIERARCHY IS 'Рівень ієрархії служби';
COMMENT ON COLUMN BARS.WCS_USER_RESPONSIBILITY.BRANCH IS 'Код відділення';




PROMPT *** Create  constraint PK_WCSUSRRESP ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_USER_RESPONSIBILITY ADD CONSTRAINT PK_WCSUSRRESP PRIMARY KEY (STAFF_ID, SRV_ID, SRV_HIERARCHY, BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSUSRRESP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSUSRRESP ON BARS.WCS_USER_RESPONSIBILITY (STAFF_ID, SRV_ID, SRV_HIERARCHY, BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_USER_RESPONSIBILITY ***
grant SELECT                                                                 on WCS_USER_RESPONSIBILITY to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on WCS_USER_RESPONSIBILITY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_USER_RESPONSIBILITY to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_USER_RESPONSIBILITY to START1;
grant SELECT                                                                 on WCS_USER_RESPONSIBILITY to UPLD;
grant FLASHBACK,SELECT                                                       on WCS_USER_RESPONSIBILITY to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_USER_RESPONSIBILITY.sql =========*
PROMPT ===================================================================================== 
