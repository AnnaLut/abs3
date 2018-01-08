

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_RULE.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_RULE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_RULE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SW_RULE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SW_RULE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_RULE ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_RULE 
   (	SWRULE NUMBER(*,0), 
	MT NUMBER(*,0), 
	SEQ CHAR(1) DEFAULT ''A'', 
	TAG CHAR(2), 
	STATUS CHAR(1), 
	UNIQ_IND CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_RULE ***
 exec bpa.alter_policies('SW_RULE');


COMMENT ON TABLE BARS.SW_RULE IS '';
COMMENT ON COLUMN BARS.SW_RULE.SWRULE IS '';
COMMENT ON COLUMN BARS.SW_RULE.MT IS '';
COMMENT ON COLUMN BARS.SW_RULE.SEQ IS '';
COMMENT ON COLUMN BARS.SW_RULE.TAG IS '';
COMMENT ON COLUMN BARS.SW_RULE.STATUS IS '';
COMMENT ON COLUMN BARS.SW_RULE.UNIQ_IND IS '';




PROMPT *** Create  constraint XPK_SW_RULE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_RULE ADD CONSTRAINT XPK_SW_RULE PRIMARY KEY (SWRULE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009737 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_RULE MODIFY (SWRULE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_SW_RULE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_SW_RULE ON BARS.SW_RULE (SWRULE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_RULE ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SW_RULE         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_RULE         to SWIFT001;
grant FLASHBACK,SELECT                                                       on SW_RULE         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_RULE.sql =========*** End *** =====
PROMPT ===================================================================================== 
