

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIREWALL_USER_IP_ADDRESS.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIREWALL_USER_IP_ADDRESS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIREWALL_USER_IP_ADDRESS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FIREWALL_USER_IP_ADDRESS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIREWALL_USER_IP_ADDRESS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIREWALL_USER_IP_ADDRESS ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIREWALL_USER_IP_ADDRESS 
   (	USRID NUMBER(*,0), 
	ORD NUMBER(*,0), 
	IP_ADDRESS VARCHAR2(15), 
	ACTION NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIREWALL_USER_IP_ADDRESS ***
 exec bpa.alter_policies('FIREWALL_USER_IP_ADDRESS');


COMMENT ON TABLE BARS.FIREWALL_USER_IP_ADDRESS IS 'FIREWALL: Правила по ip-адресам';
COMMENT ON COLUMN BARS.FIREWALL_USER_IP_ADDRESS.USRID IS 'Код пользователя';
COMMENT ON COLUMN BARS.FIREWALL_USER_IP_ADDRESS.ORD IS 'Номер правила';
COMMENT ON COLUMN BARS.FIREWALL_USER_IP_ADDRESS.IP_ADDRESS IS 'Маска ip-адреса';
COMMENT ON COLUMN BARS.FIREWALL_USER_IP_ADDRESS.ACTION IS 'Код действия';




PROMPT *** Create  constraint XPK_FIREWALL_USER_IP_ADDRESS ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIREWALL_USER_IP_ADDRESS ADD CONSTRAINT XPK_FIREWALL_USER_IP_ADDRESS PRIMARY KEY (USRID, ORD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_FIREWALL_USER_IP_ADR_ACTION ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIREWALL_USER_IP_ADDRESS ADD CONSTRAINT FK_FIREWALL_USER_IP_ADR_ACTION FOREIGN KEY (ACTION)
	  REFERENCES BARS.FIREWALL_USER_ACTION (CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_FIREWALL_USER_IP_ADR_USRID ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIREWALL_USER_IP_ADDRESS ADD CONSTRAINT FK_FIREWALL_USER_IP_ADR_USRID FOREIGN KEY (USRID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FIREWALL_USER_IP_ADR_IP_ADR ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIREWALL_USER_IP_ADDRESS MODIFY (IP_ADDRESS CONSTRAINT CC_FIREWALL_USER_IP_ADR_IP_ADR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FIREWALL_USER_IP_ADR_ACTION ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIREWALL_USER_IP_ADDRESS MODIFY (ACTION CONSTRAINT CC_FIREWALL_USER_IP_ADR_ACTION NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FIREWALL_USER_IP_ADDRESS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FIREWALL_USER_IP_ADDRESS ON BARS.FIREWALL_USER_IP_ADDRESS (USRID, ORD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIREWALL_USER_IP_ADDRESS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIREWALL_USER_IP_ADDRESS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIREWALL_USER_IP_ADDRESS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIREWALL_USER_IP_ADDRESS to FIREWALL_USER_IP_ADDRESS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIREWALL_USER_IP_ADDRESS to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on FIREWALL_USER_IP_ADDRESS to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIREWALL_USER_IP_ADDRESS.sql =========
PROMPT ===================================================================================== 
