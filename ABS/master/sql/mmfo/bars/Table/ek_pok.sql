

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EK_POK.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EK_POK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EK_POK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EK_POK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EK_POK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EK_POK ***
begin 
  execute immediate '
  CREATE TABLE BARS.EK_POK 
   (	POK NUMBER(*,0), 
	MPOK VARCHAR2(10), 
	NAME VARCHAR2(35), 
	FPOK VARCHAR2(35), 
	SPOK NUMBER, 
	GRAN NUMBER(*,0), 
	SORT_ORDER NUMBER(10,0), 
	PR_MOD NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EK_POK ***
 exec bpa.alter_policies('EK_POK');


COMMENT ON TABLE BARS.EK_POK IS '';
COMMENT ON COLUMN BARS.EK_POK.POK IS '';
COMMENT ON COLUMN BARS.EK_POK.MPOK IS '';
COMMENT ON COLUMN BARS.EK_POK.NAME IS '';
COMMENT ON COLUMN BARS.EK_POK.FPOK IS '';
COMMENT ON COLUMN BARS.EK_POK.SPOK IS '';
COMMENT ON COLUMN BARS.EK_POK.GRAN IS '';
COMMENT ON COLUMN BARS.EK_POK.SORT_ORDER IS '';
COMMENT ON COLUMN BARS.EK_POK.PR_MOD IS '';




PROMPT *** Create  constraint XPK_EK_POK ***
begin   
 execute immediate '
  ALTER TABLE BARS.EK_POK ADD CONSTRAINT XPK_EK_POK PRIMARY KEY (POK)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_EK_POK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_EK_POK ON BARS.EK_POK (POK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EK_POK ***
grant SELECT                                                                 on EK_POK          to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on EK_POK          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EK_POK          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on EK_POK          to EK_POK;
grant SELECT                                                                 on EK_POK          to UPLD;
grant FLASHBACK,SELECT                                                       on EK_POK          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EK_POK.sql =========*** End *** ======
PROMPT ===================================================================================== 
