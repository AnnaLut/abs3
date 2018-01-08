

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FX_DEAL_REF.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FX_DEAL_REF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FX_DEAL_REF'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FX_DEAL_REF'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FX_DEAL_REF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FX_DEAL_REF ***
begin 
  execute immediate '
  CREATE TABLE BARS.FX_DEAL_REF 
   (	REF NUMBER(*,0), 
	DEAL_TAG NUMBER(*,0), 
	SOS NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FX_DEAL_REF ***
 exec bpa.alter_policies('FX_DEAL_REF');


COMMENT ON TABLE BARS.FX_DEAL_REF IS '';
COMMENT ON COLUMN BARS.FX_DEAL_REF.REF IS '';
COMMENT ON COLUMN BARS.FX_DEAL_REF.DEAL_TAG IS '';
COMMENT ON COLUMN BARS.FX_DEAL_REF.SOS IS 'Cтан для FXK =0-не було звортн_х, <>0=Ref зворотньої';




PROMPT *** Create  constraint CC_FXDEALREF_DEALTAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_DEAL_REF ADD CONSTRAINT CC_FXDEALREF_DEALTAG CHECK (deal_tag is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FXDEALREF_REF ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_DEAL_REF ADD CONSTRAINT CC_FXDEALREF_REF CHECK (ref is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_FXDEALREF ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_DEAL_REF ADD CONSTRAINT PK_FXDEALREF PRIMARY KEY (DEAL_TAG, REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FXDEALREF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FXDEALREF ON BARS.FX_DEAL_REF (DEAL_TAG, REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FX_DEAL_REF ***
grant SELECT                                                                 on FX_DEAL_REF     to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on FX_DEAL_REF     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FX_DEAL_REF     to BARS_DM;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on FX_DEAL_REF     to FOREX;
grant DELETE,INSERT,SELECT,UPDATE                                            on FX_DEAL_REF     to START1;
grant SELECT                                                                 on FX_DEAL_REF     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FX_DEAL_REF.sql =========*** End *** =
PROMPT ===================================================================================== 
