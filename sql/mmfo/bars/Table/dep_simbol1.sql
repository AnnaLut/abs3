

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DEP_SIMBOL1.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DEP_SIMBOL1 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DEP_SIMBOL1'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DEP_SIMBOL1'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DEP_SIMBOL1'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DEP_SIMBOL1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.DEP_SIMBOL1 
   (	SIMBOL CHAR(2), 
	NBS CHAR(4), 
	KV NUMBER, 
	OB22 CHAR(2)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DEP_SIMBOL1 ***
 exec bpa.alter_policies('DEP_SIMBOL1');


COMMENT ON TABLE BARS.DEP_SIMBOL1 IS '';
COMMENT ON COLUMN BARS.DEP_SIMBOL1.SIMBOL IS '';
COMMENT ON COLUMN BARS.DEP_SIMBOL1.NBS IS '';
COMMENT ON COLUMN BARS.DEP_SIMBOL1.KV IS '';
COMMENT ON COLUMN BARS.DEP_SIMBOL1.OB22 IS '';




PROMPT *** Create  constraint SYS_C004984 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEP_SIMBOL1 MODIFY (SIMBOL NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004985 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEP_SIMBOL1 MODIFY (NBS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004986 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEP_SIMBOL1 MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004987 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEP_SIMBOL1 MODIFY (OB22 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_DEP_SIMBOL1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEP_SIMBOL1 ADD CONSTRAINT XPK_DEP_SIMBOL1 PRIMARY KEY (SIMBOL, NBS, KV, OB22)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_DEP_SIMBOL1 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_DEP_SIMBOL1 ON BARS.DEP_SIMBOL1 (SIMBOL, NBS, KV, OB22) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DEP_SIMBOL1 ***
grant FLASHBACK,SELECT                                                       on DEP_SIMBOL1     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DEP_SIMBOL1     to BARS_DM;
grant FLASHBACK,SELECT                                                       on DEP_SIMBOL1     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DEP_SIMBOL1.sql =========*** End *** =
PROMPT ===================================================================================== 
