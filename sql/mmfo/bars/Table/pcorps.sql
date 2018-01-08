

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PCORPS.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PCORPS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PCORPS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PCORPS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PCORPS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PCORPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.PCORPS 
   (	FIO VARCHAR2(25), 
	NAM VARCHAR2(12), 
	ADR VARCHAR2(50), 
	MFO VARCHAR2(12), 
	NLS VARCHAR2(15), 
	OKPO VARCHAR2(14)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PCORPS ***
 exec bpa.alter_policies('PCORPS');


COMMENT ON TABLE BARS.PCORPS IS '';
COMMENT ON COLUMN BARS.PCORPS.FIO IS '';
COMMENT ON COLUMN BARS.PCORPS.NAM IS '';
COMMENT ON COLUMN BARS.PCORPS.ADR IS '';
COMMENT ON COLUMN BARS.PCORPS.MFO IS '';
COMMENT ON COLUMN BARS.PCORPS.NLS IS '';
COMMENT ON COLUMN BARS.PCORPS.OKPO IS '';




PROMPT *** Create  constraint PK_PCORPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PCORPS ADD CONSTRAINT PK_PCORPS PRIMARY KEY (FIO, NAM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PCORPS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PCORPS ON BARS.PCORPS (FIO, NAM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PCORPS ***
grant FLASHBACK,SELECT                                                       on PCORPS          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PCORPS          to BARS_DM;
grant FLASHBACK,SELECT                                                       on PCORPS          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PCORPS.sql =========*** End *** ======
PROMPT ===================================================================================== 
