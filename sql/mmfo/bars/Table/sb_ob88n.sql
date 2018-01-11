

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SB_OB88N.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SB_OB88N ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SB_OB88N ***
begin 
  execute immediate '
  CREATE TABLE BARS.SB_OB88N 
   (	R020 CHAR(4), 
	OB88 CHAR(4), 
	TXT VARCHAR2(254), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	COD_ACT CHAR(1), 
	A010 CHAR(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SB_OB88N ***
 exec bpa.alter_policies('SB_OB88N');


COMMENT ON TABLE BARS.SB_OB88N IS '';
COMMENT ON COLUMN BARS.SB_OB88N.R020 IS '';
COMMENT ON COLUMN BARS.SB_OB88N.OB88 IS '';
COMMENT ON COLUMN BARS.SB_OB88N.TXT IS '';
COMMENT ON COLUMN BARS.SB_OB88N.D_OPEN IS '';
COMMENT ON COLUMN BARS.SB_OB88N.D_CLOSE IS '';
COMMENT ON COLUMN BARS.SB_OB88N.COD_ACT IS '';
COMMENT ON COLUMN BARS.SB_OB88N.A010 IS '';



PROMPT *** Create  grants  SB_OB88N ***
grant SELECT                                                                 on SB_OB88N        to BARSREADER_ROLE;
grant SELECT                                                                 on SB_OB88N        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SB_OB88N        to SB_OB88N;
grant SELECT                                                                 on SB_OB88N        to UPLD;



PROMPT *** Create SYNONYM  to SB_OB88N ***

  CREATE OR REPLACE PUBLIC SYNONYM SB_OB88N FOR BARS.SB_OB88N;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SB_OB88N.sql =========*** End *** ====
PROMPT ===================================================================================== 
