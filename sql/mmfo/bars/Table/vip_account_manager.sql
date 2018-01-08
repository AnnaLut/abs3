

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VIP_ACCOUNT_MANAGER.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VIP_ACCOUNT_MANAGER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''VIP_ACCOUNT_MANAGER'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''VIP_ACCOUNT_MANAGER'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VIP_ACCOUNT_MANAGER ***
begin 
  execute immediate '
  CREATE TABLE BARS.VIP_ACCOUNT_MANAGER 
   (	ID NUMBER, 
	RELATIVE VARCHAR2(20)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to VIP_ACCOUNT_MANAGER ***
 exec bpa.alter_policies('VIP_ACCOUNT_MANAGER');


COMMENT ON TABLE BARS.VIP_ACCOUNT_MANAGER IS '';
COMMENT ON COLUMN BARS.VIP_ACCOUNT_MANAGER.ID IS '';
COMMENT ON COLUMN BARS.VIP_ACCOUNT_MANAGER.RELATIVE IS '';




PROMPT *** Create  constraint CC_RELATIVES_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.VIP_ACCOUNT_MANAGER MODIFY (ID CONSTRAINT CC_RELATIVES_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RELATIVES_RELATIVE ***
begin   
 execute immediate '
  ALTER TABLE BARS.VIP_ACCOUNT_MANAGER MODIFY (RELATIVE CONSTRAINT CC_RELATIVES_RELATIVE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  VIP_ACCOUNT_MANAGER ***
grant SELECT                                                                 on VIP_ACCOUNT_MANAGER to BARSREADER_ROLE;
grant SELECT                                                                 on VIP_ACCOUNT_MANAGER to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VIP_ACCOUNT_MANAGER to START1;
grant SELECT                                                                 on VIP_ACCOUNT_MANAGER to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VIP_ACCOUNT_MANAGER.sql =========*** E
PROMPT ===================================================================================== 
