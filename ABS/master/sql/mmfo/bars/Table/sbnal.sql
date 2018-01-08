

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SBNAL.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SBNAL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SBNAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.SBNAL 
   (	R020 CHAR(4), 
	P080 CHAR(4), 
	R020_FA CHAR(4), 
	OB22 CHAR(2), 
	TXT VARCHAR2(254), 
	AP CHAR(1), 
	PRIZN_VIDP CHAR(1), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	COD_ACT CHAR(1), 
	GR_FA CHAR(4), 
	GR_IN CHAR(1)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SBNAL ***
 exec bpa.alter_policies('SBNAL');


COMMENT ON TABLE BARS.SBNAL IS '';
COMMENT ON COLUMN BARS.SBNAL.R020 IS '';
COMMENT ON COLUMN BARS.SBNAL.P080 IS '';
COMMENT ON COLUMN BARS.SBNAL.R020_FA IS '';
COMMENT ON COLUMN BARS.SBNAL.OB22 IS '';
COMMENT ON COLUMN BARS.SBNAL.TXT IS '';
COMMENT ON COLUMN BARS.SBNAL.AP IS '';
COMMENT ON COLUMN BARS.SBNAL.PRIZN_VIDP IS '';
COMMENT ON COLUMN BARS.SBNAL.D_OPEN IS '';
COMMENT ON COLUMN BARS.SBNAL.D_CLOSE IS '';
COMMENT ON COLUMN BARS.SBNAL.COD_ACT IS '';
COMMENT ON COLUMN BARS.SBNAL.GR_FA IS '';
COMMENT ON COLUMN BARS.SBNAL.GR_IN IS '';



PROMPT *** Create  grants  SBNAL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SBNAL           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SBNAL           to START1;



PROMPT *** Create SYNONYM  to SBNAL ***

  CREATE OR REPLACE PUBLIC SYNONYM SBNAL FOR BARS.SBNAL;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SBNAL.sql =========*** End *** =======
PROMPT ===================================================================================== 
