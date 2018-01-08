

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ANALIT.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ANALIT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ANALIT ***
begin 
  execute immediate '
  CREATE TABLE BARS.ANALIT 
   (	KOD_PAR VARCHAR2(4), 
	FILE VARCHAR2(8), 
	PR VARCHAR2(4), 
	TXT VARCHAR2(96), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	REM VARCHAR2(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ANALIT ***
 exec bpa.alter_policies('ANALIT');


COMMENT ON TABLE BARS.ANALIT IS '';
COMMENT ON COLUMN BARS.ANALIT.KOD_PAR IS '';
COMMENT ON COLUMN BARS.ANALIT.FILE IS '';
COMMENT ON COLUMN BARS.ANALIT.PR IS '';
COMMENT ON COLUMN BARS.ANALIT.TXT IS '';
COMMENT ON COLUMN BARS.ANALIT.D_OPEN IS '';
COMMENT ON COLUMN BARS.ANALIT.D_CLOSE IS '';
COMMENT ON COLUMN BARS.ANALIT.REM IS '';



PROMPT *** Create  grants  ANALIT ***
grant SELECT                                                                 on ANALIT          to BARSREADER_ROLE;
grant SELECT                                                                 on ANALIT          to BARS_DM;
grant SELECT                                                                 on ANALIT          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ANALIT.sql =========*** End *** ======
PROMPT ===================================================================================== 
