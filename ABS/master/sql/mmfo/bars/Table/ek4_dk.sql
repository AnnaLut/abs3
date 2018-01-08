

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EK4_DK.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EK4_DK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EK4_DK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EK4_DK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EK4_DK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EK4_DK ***
begin 
  execute immediate '
  CREATE TABLE BARS.EK4_DK 
   (	NBS VARCHAR2(4), 
	NAME VARCHAR2(40), 
	PAP NUMBER(38,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EK4_DK ***
 exec bpa.alter_policies('EK4_DK');


COMMENT ON TABLE BARS.EK4_DK IS '';
COMMENT ON COLUMN BARS.EK4_DK.NBS IS '';
COMMENT ON COLUMN BARS.EK4_DK.NAME IS '';
COMMENT ON COLUMN BARS.EK4_DK.PAP IS '';




PROMPT *** Create  constraint XPK_EK4_DK ***
begin   
 execute immediate '
  ALTER TABLE BARS.EK4_DK ADD CONSTRAINT XPK_EK4_DK PRIMARY KEY (NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005372 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EK4_DK MODIFY (NBS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_EK4_DK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_EK4_DK ON BARS.EK4_DK (NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EK4_DK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on EK4_DK          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EK4_DK          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on EK4_DK          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EK4_DK.sql =========*** End *** ======
PROMPT ===================================================================================== 
