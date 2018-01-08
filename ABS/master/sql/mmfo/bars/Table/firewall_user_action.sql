

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIREWALL_USER_ACTION.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIREWALL_USER_ACTION ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIREWALL_USER_ACTION ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIREWALL_USER_ACTION 
   (	CODE NUMBER(*,0), 
	NAME VARCHAR2(32)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIREWALL_USER_ACTION ***
 exec bpa.alter_policies('FIREWALL_USER_ACTION');


COMMENT ON TABLE BARS.FIREWALL_USER_ACTION IS 'FIREWALL: Действия по правилам';
COMMENT ON COLUMN BARS.FIREWALL_USER_ACTION.CODE IS 'Код действия';
COMMENT ON COLUMN BARS.FIREWALL_USER_ACTION.NAME IS 'Наименование действия';




PROMPT *** Create  constraint XPK_FIREWALL_USER_ACTION ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIREWALL_USER_ACTION ADD CONSTRAINT XPK_FIREWALL_USER_ACTION PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FIREWALL_USER_ACTION ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FIREWALL_USER_ACTION ON BARS.FIREWALL_USER_ACTION (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIREWALL_USER_ACTION ***
grant SELECT                                                                 on FIREWALL_USER_ACTION to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIREWALL_USER_ACTION to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIREWALL_USER_ACTION to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIREWALL_USER_ACTION to FIREWALL_USER_ACTION;
grant SELECT                                                                 on FIREWALL_USER_ACTION to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIREWALL_USER_ACTION to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on FIREWALL_USER_ACTION to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIREWALL_USER_ACTION.sql =========*** 
PROMPT ===================================================================================== 
