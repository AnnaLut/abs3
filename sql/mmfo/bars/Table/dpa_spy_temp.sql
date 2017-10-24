

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPA_SPY_TEMP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPA_SPY_TEMP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPA_SPY_TEMP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPA_SPY_TEMP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPA_SPY_TEMP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPA_SPY_TEMP ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPA_SPY_TEMP 
   (	REF NUMBER, 
	TT CHAR(3), 
	ACCA NUMBER, 
	S NUMBER(38,0), 
	KV NUMBER(3,0), 
	SK NUMBER, 
	DK NUMBER, 
	ACCB NUMBER, 
	FDAT DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPA_SPY_TEMP ***
 exec bpa.alter_policies('DPA_SPY_TEMP');


COMMENT ON TABLE BARS.DPA_SPY_TEMP IS '';
COMMENT ON COLUMN BARS.DPA_SPY_TEMP.REF IS '';
COMMENT ON COLUMN BARS.DPA_SPY_TEMP.TT IS '';
COMMENT ON COLUMN BARS.DPA_SPY_TEMP.ACCA IS '';
COMMENT ON COLUMN BARS.DPA_SPY_TEMP.S IS '';
COMMENT ON COLUMN BARS.DPA_SPY_TEMP.KV IS '';
COMMENT ON COLUMN BARS.DPA_SPY_TEMP.SK IS '';
COMMENT ON COLUMN BARS.DPA_SPY_TEMP.DK IS '';
COMMENT ON COLUMN BARS.DPA_SPY_TEMP.ACCB IS '';
COMMENT ON COLUMN BARS.DPA_SPY_TEMP.FDAT IS '';




PROMPT *** Create  constraint XPK_DPA_SPY_TEMP ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPA_SPY_TEMP ADD CONSTRAINT XPK_DPA_SPY_TEMP PRIMARY KEY (REF, TT, DK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_DPA_SPY_TEMP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_DPA_SPY_TEMP ON BARS.DPA_SPY_TEMP (REF, TT, DK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPA_SPY_TEMP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPA_SPY_TEMP    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPA_SPY_TEMP    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPA_SPY_TEMP    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPA_SPY_TEMP.sql =========*** End *** 
PROMPT ===================================================================================== 
