

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Table/UPL_DOMAINS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  table UPL_DOMAINS ***
begin 
  execute immediate '
  CREATE TABLE BARSUPL.UPL_DOMAINS 
   (	DOMAIN_CODE VARCHAR2(6), 
	DESCRIPT VARCHAR2(500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSUPLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSUPL.UPL_DOMAINS IS '';
COMMENT ON COLUMN BARSUPL.UPL_DOMAINS.DOMAIN_CODE IS '';
COMMENT ON COLUMN BARSUPL.UPL_DOMAINS.DESCRIPT IS '';




PROMPT *** Create  constraint PK_UPLDOMAINS ***
begin   
 execute immediate '
  ALTER TABLE BARSUPL.UPL_DOMAINS ADD CONSTRAINT PK_UPLDOMAINS PRIMARY KEY (DOMAIN_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_UPLDOMAINS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSUPL.PK_UPLDOMAINS ON BARSUPL.UPL_DOMAINS (DOMAIN_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSUPLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Table/UPL_DOMAINS.sql =========*** End **
PROMPT ===================================================================================== 
