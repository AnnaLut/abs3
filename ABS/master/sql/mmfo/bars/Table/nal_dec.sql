

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NAL_DEC.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NAL_DEC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NAL_DEC ***
begin 
  execute immediate '
  CREATE TABLE BARS.NAL_DEC 
   (	NLS VARCHAR2(15), 
	DD VARCHAR2(2), 
	RR VARCHAR2(4), 
	PP VARCHAR2(4), 
	NMS VARCHAR2(210), 
	NMS1 VARCHAR2(210), 
	PPS VARCHAR2(10), 
	ORD NUMBER(38,0), 
	FORMULA VARCHAR2(15), 
	FORMUL1 VARCHAR2(15), 
	NLSG VARCHAR2(15)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NAL_DEC ***
 exec bpa.alter_policies('NAL_DEC');


COMMENT ON TABLE BARS.NAL_DEC IS '';
COMMENT ON COLUMN BARS.NAL_DEC.NLS IS '';
COMMENT ON COLUMN BARS.NAL_DEC.DD IS '';
COMMENT ON COLUMN BARS.NAL_DEC.RR IS '';
COMMENT ON COLUMN BARS.NAL_DEC.PP IS '';
COMMENT ON COLUMN BARS.NAL_DEC.NMS IS '';
COMMENT ON COLUMN BARS.NAL_DEC.NMS1 IS '';
COMMENT ON COLUMN BARS.NAL_DEC.PPS IS '';
COMMENT ON COLUMN BARS.NAL_DEC.ORD IS '';
COMMENT ON COLUMN BARS.NAL_DEC.FORMULA IS '';
COMMENT ON COLUMN BARS.NAL_DEC.FORMUL1 IS '';
COMMENT ON COLUMN BARS.NAL_DEC.NLSG IS '';




PROMPT *** Create  index XPK_NALDEC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_NALDEC ON BARS.NAL_DEC (NLS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NAL_DEC ***
grant SELECT                                                                 on NAL_DEC         to BARSREADER_ROLE;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on NAL_DEC         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NAL_DEC         to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on NAL_DEC         to NALOG;
grant DELETE,INSERT,SELECT,UPDATE                                            on NAL_DEC         to NAL_DEC;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on NAL_DEC         to START1;
grant SELECT                                                                 on NAL_DEC         to UPLD;
grant FLASHBACK,SELECT                                                       on NAL_DEC         to WR_REFREAD;



PROMPT *** Create SYNONYM  to NAL_DEC ***

  CREATE OR REPLACE PUBLIC SYNONYM NAL_DEC FOR BARS.NAL_DEC;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NAL_DEC.sql =========*** End *** =====
PROMPT ===================================================================================== 
