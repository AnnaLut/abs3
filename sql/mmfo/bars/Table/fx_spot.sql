

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FX_SPOT.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FX_SPOT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FX_SPOT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FX_SPOT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FX_SPOT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FX_SPOT ***
begin 
  execute immediate '
  CREATE TABLE BARS.FX_SPOT 
   (	CODCAGENT NUMBER(*,0), 
	KV NUMBER(*,0), 
	NLS9200 VARCHAR2(15), 
	NLS9210 VARCHAR2(15), 
	NLS9202 VARCHAR2(15), 
	NLS9212 VARCHAR2(15), 
	NLS3540 VARCHAR2(15), 
	NLS3640 VARCHAR2(15)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FX_SPOT ***
 exec bpa.alter_policies('FX_SPOT');


COMMENT ON TABLE BARS.FX_SPOT IS '';
COMMENT ON COLUMN BARS.FX_SPOT.CODCAGENT IS '';
COMMENT ON COLUMN BARS.FX_SPOT.KV IS '';
COMMENT ON COLUMN BARS.FX_SPOT.NLS9200 IS '';
COMMENT ON COLUMN BARS.FX_SPOT.NLS9210 IS '';
COMMENT ON COLUMN BARS.FX_SPOT.NLS9202 IS '';
COMMENT ON COLUMN BARS.FX_SPOT.NLS9212 IS '';
COMMENT ON COLUMN BARS.FX_SPOT.NLS3540 IS '';
COMMENT ON COLUMN BARS.FX_SPOT.NLS3640 IS '';




PROMPT *** Create  constraint PK_FXSPOT ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_SPOT ADD CONSTRAINT PK_FXSPOT PRIMARY KEY (CODCAGENT, KV)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_FXSPOT_CODCAGENT ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_SPOT ADD CONSTRAINT FK_FXSPOT_CODCAGENT FOREIGN KEY (CODCAGENT)
	  REFERENCES BARS.CODCAGENT (CODCAGENT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FXSPOT_CODCAGENT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_SPOT MODIFY (CODCAGENT CONSTRAINT CC_FXSPOT_CODCAGENT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FXSPOT_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_SPOT MODIFY (KV CONSTRAINT CC_FXSPOT_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FXSPOT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FXSPOT ON BARS.FX_SPOT (CODCAGENT, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FX_SPOT ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FX_SPOT         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FX_SPOT         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FX_SPOT         to START1;
grant FLASHBACK,SELECT                                                       on FX_SPOT         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FX_SPOT.sql =========*** End *** =====
PROMPT ===================================================================================== 
