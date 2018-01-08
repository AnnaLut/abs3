

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EK_POK_DAY.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EK_POK_DAY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EK_POK_DAY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EK_POK_DAY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EK_POK_DAY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EK_POK_DAY ***
begin 
  execute immediate '
  CREATE TABLE BARS.EK_POK_DAY 
   (	POK NUMBER(*,0), 
	FDAT DATE, 
	S NUMBER(24,2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EK_POK_DAY ***
 exec bpa.alter_policies('EK_POK_DAY');


COMMENT ON TABLE BARS.EK_POK_DAY IS '';
COMMENT ON COLUMN BARS.EK_POK_DAY.POK IS '';
COMMENT ON COLUMN BARS.EK_POK_DAY.FDAT IS '';
COMMENT ON COLUMN BARS.EK_POK_DAY.S IS '';




PROMPT *** Create  constraint XPK_EK_POK_DAY ***
begin   
 execute immediate '
  ALTER TABLE BARS.EK_POK_DAY ADD CONSTRAINT XPK_EK_POK_DAY PRIMARY KEY (POK, FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_EK_POK_DAY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_EK_POK_DAY ON BARS.EK_POK_DAY (POK, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EK_POK_DAY ***
grant DELETE,INSERT,SELECT,UPDATE                                            on EK_POK_DAY      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EK_POK_DAY      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on EK_POK_DAY      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EK_POK_DAY.sql =========*** End *** ==
PROMPT ===================================================================================== 
