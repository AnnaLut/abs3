

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EK_POK_MFO.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EK_POK_MFO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EK_POK_MFO'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EK_POK_MFO'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EK_POK_MFO'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EK_POK_MFO ***
begin 
  execute immediate '
  CREATE TABLE BARS.EK_POK_MFO 
   (	POK NUMBER(*,0), 
	FDAT DATE, 
	S NUMBER(24,2), 
	MFO VARCHAR2(12)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EK_POK_MFO ***
 exec bpa.alter_policies('EK_POK_MFO');


COMMENT ON TABLE BARS.EK_POK_MFO IS '';
COMMENT ON COLUMN BARS.EK_POK_MFO.POK IS '';
COMMENT ON COLUMN BARS.EK_POK_MFO.FDAT IS '';
COMMENT ON COLUMN BARS.EK_POK_MFO.S IS '';
COMMENT ON COLUMN BARS.EK_POK_MFO.MFO IS '';




PROMPT *** Create  constraint XPK_EK_POK_MFO ***
begin   
 execute immediate '
  ALTER TABLE BARS.EK_POK_MFO ADD CONSTRAINT XPK_EK_POK_MFO PRIMARY KEY (POK, FDAT, MFO)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_EK_POK_MFO ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_EK_POK_MFO ON BARS.EK_POK_MFO (POK, FDAT, MFO) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EK_POK_MFO ***
grant SELECT                                                                 on EK_POK_MFO      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on EK_POK_MFO      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EK_POK_MFO      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on EK_POK_MFO      to START1;
grant SELECT                                                                 on EK_POK_MFO      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EK_POK_MFO.sql =========*** End *** ==
PROMPT ===================================================================================== 
