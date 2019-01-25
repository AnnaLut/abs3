PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TELLER_OPER_STATUSES.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TELLER_OPER_STATUSES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TELLER_OPER_STATUSES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TELLER_OPER_STATUSES ***
begin 
  execute immediate '
  CREATE TABLE BARS.TELLER_OPER_STATUSES 
   (	STATUS VARCHAR2(2), 
	DESCRIPTION VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TELLER_OPER_STATUSES ***
 exec bpa.alter_policies('TELLER_OPER_STATUSES');


COMMENT ON TABLE BARS.TELLER_OPER_STATUSES IS '';
COMMENT ON COLUMN BARS.TELLER_OPER_STATUSES.STATUS IS '';
COMMENT ON COLUMN BARS.TELLER_OPER_STATUSES.DESCRIPTION IS '';




PROMPT *** Create  constraint SYS_C0027573 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_OPER_STATUSES MODIFY (STATUS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint TEL_OP_STA_PL ***
begin   
 execute immediate '
  ALTER TABLE BARS.TELLER_OPER_STATUSES ADD CONSTRAINT TEL_OP_STA_PL PRIMARY KEY (STATUS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index TEL_OP_STA_PL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.TEL_OP_STA_PL ON BARS.TELLER_OPER_STATUSES (STATUS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TELLER_OPER_STATUSES.sql =========*** 
PROMPT ===================================================================================== 
