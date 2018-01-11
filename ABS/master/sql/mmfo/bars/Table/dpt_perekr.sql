

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_PEREKR.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_PEREKR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_PEREKR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_PEREKR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_PEREKR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_PEREKR ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_PEREKR 
   (	DPT_ID NUMBER, 
	MFOP VARCHAR2(12), 
	NLSP VARCHAR2(15), 
	NMSP VARCHAR2(38), 
	DPT_DEMAND NUMBER(38,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_PEREKR ***
 exec bpa.alter_policies('DPT_PEREKR');


COMMENT ON TABLE BARS.DPT_PEREKR IS '';
COMMENT ON COLUMN BARS.DPT_PEREKR.DPT_ID IS '';
COMMENT ON COLUMN BARS.DPT_PEREKR.MFOP IS '';
COMMENT ON COLUMN BARS.DPT_PEREKR.NLSP IS '';
COMMENT ON COLUMN BARS.DPT_PEREKR.NMSP IS '';
COMMENT ON COLUMN BARS.DPT_PEREKR.DPT_DEMAND IS '';




PROMPT *** Create  constraint DPT_PEREKR_UK ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_PEREKR ADD CONSTRAINT DPT_PEREKR_UK UNIQUE (DPT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005168 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_PEREKR MODIFY (DPT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index DPT_PEREKR_UK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.DPT_PEREKR_UK ON BARS.DPT_PEREKR (DPT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_PEREKR ***
grant SELECT                                                                 on DPT_PEREKR      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_PEREKR      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_PEREKR      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_PEREKR      to START1;
grant SELECT                                                                 on DPT_PEREKR      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_PEREKR.sql =========*** End *** ==
PROMPT ===================================================================================== 
