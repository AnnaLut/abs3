

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_OPERW_110.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_OPERW_110 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_OPERW_110'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SW_OPERW_110'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SW_OPERW_110'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_OPERW_110 ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_OPERW_110 
   (	SWREF NUMBER, 
	TAG CHAR(2), 
	SEQ CHAR(1), 
	N NUMBER(38,0), 
	OPT CHAR(1), 
	VALUE VARCHAR2(1024)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_OPERW_110 ***
 exec bpa.alter_policies('SW_OPERW_110');


COMMENT ON TABLE BARS.SW_OPERW_110 IS '';
COMMENT ON COLUMN BARS.SW_OPERW_110.SWREF IS '';
COMMENT ON COLUMN BARS.SW_OPERW_110.TAG IS '';
COMMENT ON COLUMN BARS.SW_OPERW_110.SEQ IS '';
COMMENT ON COLUMN BARS.SW_OPERW_110.N IS '';
COMMENT ON COLUMN BARS.SW_OPERW_110.OPT IS '';
COMMENT ON COLUMN BARS.SW_OPERW_110.VALUE IS '';




PROMPT *** Create  constraint SYS_C006568 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPERW_110 MODIFY (SWREF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006569 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPERW_110 MODIFY (TAG NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006570 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPERW_110 MODIFY (SEQ NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006571 ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_OPERW_110 MODIFY (N NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_OPERW_110 ***
grant SELECT                                                                 on SW_OPERW_110    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_OPERW_110    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_OPERW_110    to START1;
grant SELECT                                                                 on SW_OPERW_110    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_OPERW_110.sql =========*** End *** 
PROMPT ===================================================================================== 
