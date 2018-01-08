

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIREWALL_USER_MODULE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIREWALL_USER_MODULE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIREWALL_USER_MODULE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FIREWALL_USER_MODULE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIREWALL_USER_MODULE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIREWALL_USER_MODULE ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIREWALL_USER_MODULE 
   (	USRID NUMBER(*,0), 
	ORD NUMBER(*,0), 
	MODULE VARCHAR2(48), 
	ACTION NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIREWALL_USER_MODULE ***
 exec bpa.alter_policies('FIREWALL_USER_MODULE');


COMMENT ON TABLE BARS.FIREWALL_USER_MODULE IS 'FIREWALL: Правила по имени модуля';
COMMENT ON COLUMN BARS.FIREWALL_USER_MODULE.USRID IS 'Код пользователя';
COMMENT ON COLUMN BARS.FIREWALL_USER_MODULE.ORD IS 'Номер правила';
COMMENT ON COLUMN BARS.FIREWALL_USER_MODULE.MODULE IS 'Маска имени модуля';
COMMENT ON COLUMN BARS.FIREWALL_USER_MODULE.ACTION IS 'Код действия';




PROMPT *** Create  constraint XPK_FIREWALL_USER_MODULE ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIREWALL_USER_MODULE ADD CONSTRAINT XPK_FIREWALL_USER_MODULE PRIMARY KEY (USRID, ORD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_FIREWALL_USER_MODULE_USRID ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIREWALL_USER_MODULE ADD CONSTRAINT FK_FIREWALL_USER_MODULE_USRID FOREIGN KEY (USRID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_FIREWALL_USER_MODULE_ACTION ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIREWALL_USER_MODULE ADD CONSTRAINT FK_FIREWALL_USER_MODULE_ACTION FOREIGN KEY (ACTION)
	  REFERENCES BARS.FIREWALL_USER_ACTION (CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FIREWALL_USER_MODULE_MODULE ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIREWALL_USER_MODULE MODIFY (MODULE CONSTRAINT CC_FIREWALL_USER_MODULE_MODULE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FIREWALL_USER_MODULE_ACTION ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIREWALL_USER_MODULE MODIFY (ACTION CONSTRAINT CC_FIREWALL_USER_MODULE_ACTION NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FIREWALL_USER_MODULE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FIREWALL_USER_MODULE ON BARS.FIREWALL_USER_MODULE (USRID, ORD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIREWALL_USER_MODULE ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIREWALL_USER_MODULE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIREWALL_USER_MODULE to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIREWALL_USER_MODULE to FIREWALL_USER_MODULE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIREWALL_USER_MODULE to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on FIREWALL_USER_MODULE to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIREWALL_USER_MODULE.sql =========*** 
PROMPT ===================================================================================== 
