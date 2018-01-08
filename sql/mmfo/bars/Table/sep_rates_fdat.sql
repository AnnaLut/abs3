

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SEP_RATES_FDAT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SEP_RATES_FDAT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SEP_RATES_FDAT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SEP_RATES_FDAT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SEP_RATES_FDAT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SEP_RATES_FDAT ***
begin 
  execute immediate '
  CREATE TABLE BARS.SEP_RATES_FDAT 
   (	FDAT DATE, 
	 CONSTRAINT PK_SEPRATESFDAT PRIMARY KEY (FDAT) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYND 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SEP_RATES_FDAT ***
 exec bpa.alter_policies('SEP_RATES_FDAT');


COMMENT ON TABLE BARS.SEP_RATES_FDAT IS '';
COMMENT ON COLUMN BARS.SEP_RATES_FDAT.FDAT IS '';




PROMPT *** Create  constraint CC_SEPRATESFDAT_FDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_RATES_FDAT MODIFY (FDAT CONSTRAINT CC_SEPRATESFDAT_FDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SEPRATESFDAT ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEP_RATES_FDAT ADD CONSTRAINT PK_SEPRATESFDAT PRIMARY KEY (FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SEPRATESFDAT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SEPRATESFDAT ON BARS.SEP_RATES_FDAT (FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SEP_RATES_FDAT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SEP_RATES_FDAT  to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SEP_RATES_FDAT  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SEP_RATES_FDAT.sql =========*** End **
PROMPT ===================================================================================== 
