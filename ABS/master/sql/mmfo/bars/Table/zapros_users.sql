

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAPROS_USERS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAPROS_USERS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAPROS_USERS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ZAPROS_USERS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ZAPROS_USERS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAPROS_USERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAPROS_USERS 
   (	KODZ NUMBER, 
	USER_ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAPROS_USERS ***
 exec bpa.alter_policies('ZAPROS_USERS');


COMMENT ON TABLE BARS.ZAPROS_USERS IS 'Связка кат.запрос <-->кто может выполнять';
COMMENT ON COLUMN BARS.ZAPROS_USERS.KODZ IS 'Код. запроса';
COMMENT ON COLUMN BARS.ZAPROS_USERS.USER_ID IS 'Пользователь';




PROMPT *** Create  constraint FK_ZAPROS_USERS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAPROS_USERS ADD CONSTRAINT FK_ZAPROS_USERS_ID FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_ZAPROS_USERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAPROS_USERS ADD CONSTRAINT XPK_ZAPROS_USERS PRIMARY KEY (KODZ, USER_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ZAPROS_USERS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ZAPROS_USERS ON BARS.ZAPROS_USERS (KODZ, USER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAPROS_USERS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAPROS_USERS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ZAPROS_USERS    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAPROS_USERS    to QUERY_EDITOR;
grant SELECT                                                                 on ZAPROS_USERS    to RPBN001;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAPROS_USERS    to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ZAPROS_USERS    to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to ZAPROS_USERS ***

  CREATE OR REPLACE PUBLIC SYNONYM ZAPROS_USERS FOR BARS.ZAPROS_USERS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAPROS_USERS.sql =========*** End *** 
PROMPT ===================================================================================== 
