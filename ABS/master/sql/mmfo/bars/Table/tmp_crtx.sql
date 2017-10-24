

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CRTX.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CRTX ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CRTX ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_CRTX 
   (	REF NUMBER(38,0), 
	DK NUMBER(1,0), 
	ACC NUMBER(38,0), 
	S NUMBER(20,0), 
	FDAT DATE, 
	VDAT DATE, 
	VOB NUMBER(3,0), 
	TIP NUMBER, 
	SQ NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_CRTX ***
 exec bpa.alter_policies('TMP_CRTX');


COMMENT ON TABLE BARS.TMP_CRTX IS '';
COMMENT ON COLUMN BARS.TMP_CRTX.REF IS '';
COMMENT ON COLUMN BARS.TMP_CRTX.DK IS '';
COMMENT ON COLUMN BARS.TMP_CRTX.ACC IS '';
COMMENT ON COLUMN BARS.TMP_CRTX.S IS '';
COMMENT ON COLUMN BARS.TMP_CRTX.FDAT IS '';
COMMENT ON COLUMN BARS.TMP_CRTX.VDAT IS '';
COMMENT ON COLUMN BARS.TMP_CRTX.VOB IS '';
COMMENT ON COLUMN BARS.TMP_CRTX.TIP IS '';
COMMENT ON COLUMN BARS.TMP_CRTX.SQ IS '';



PROMPT *** Create  grants  TMP_CRTX ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_CRTX        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CRTX.sql =========*** End *** ====
PROMPT ===================================================================================== 
