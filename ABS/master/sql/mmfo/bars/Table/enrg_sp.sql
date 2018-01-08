

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ENRG_SP.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ENRG_SP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ENRG_SP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ENRG_SP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ENRG_SP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ENRG_SP ***
begin 
  execute immediate '
  CREATE TABLE BARS.ENRG_SP 
   (	ORGID NUMBER(*,0), 
	TYPE NUMBER(*,0), 
	REGION NUMBER(*,0), 
	MFO NUMBER(*,0), 
	NLS NUMBER(14,0), 
	NAME VARCHAR2(40), 
	ORD NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ENRG_SP ***
 exec bpa.alter_policies('ENRG_SP');


COMMENT ON TABLE BARS.ENRG_SP IS '';
COMMENT ON COLUMN BARS.ENRG_SP.ORGID IS '';
COMMENT ON COLUMN BARS.ENRG_SP.TYPE IS '';
COMMENT ON COLUMN BARS.ENRG_SP.REGION IS '';
COMMENT ON COLUMN BARS.ENRG_SP.MFO IS '';
COMMENT ON COLUMN BARS.ENRG_SP.NLS IS '';
COMMENT ON COLUMN BARS.ENRG_SP.NAME IS '';
COMMENT ON COLUMN BARS.ENRG_SP.ORD IS '';




PROMPT *** Create  constraint XPK_ENRG_SP ***
begin   
 execute immediate '
  ALTER TABLE BARS.ENRG_SP ADD CONSTRAINT XPK_ENRG_SP PRIMARY KEY (ORD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ENRG_SP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ENRG_SP ON BARS.ENRG_SP (ORD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ENRG_SP ***
grant SELECT                                                                 on ENRG_SP         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ENRG_SP         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ENRG_SP         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ENRG_SP         to START1;
grant SELECT                                                                 on ENRG_SP         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ENRG_SP.sql =========*** End *** =====
PROMPT ===================================================================================== 
