

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_VALID.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_VALID ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_VALID'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SW_VALID'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SW_VALID'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_VALID ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_VALID 
   (	OPT CHAR(1), 
	SWRULE NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_VALID ***
 exec bpa.alter_policies('SW_VALID');


COMMENT ON TABLE BARS.SW_VALID IS '';
COMMENT ON COLUMN BARS.SW_VALID.OPT IS '';
COMMENT ON COLUMN BARS.SW_VALID.SWRULE IS '';




PROMPT *** Create  constraint SYS_C009783 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_VALID MODIFY (OPT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009784 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_VALID MODIFY (SWRULE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_SW_VALID ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_VALID ADD CONSTRAINT XPK_SW_VALID PRIMARY KEY (OPT, SWRULE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_SW_VALID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_SW_VALID ON BARS.SW_VALID (OPT, SWRULE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_VALID ***
grant SELECT                                                                 on SW_VALID        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_VALID        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_VALID        to START1;
grant SELECT                                                                 on SW_VALID        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_VALID.sql =========*** End *** ====
PROMPT ===================================================================================== 
