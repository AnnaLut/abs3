

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MP_TURN_TMP.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MP_TURN_TMP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MP_TURN_TMP ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.MP_TURN_TMP 
   (	FDAT DATE, 
	REF NUMBER, 
	ACC NUMBER, 
	DK NUMBER(1,0), 
	S NUMBER, 
	SQ NUMBER, 
	STMT NUMBER
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MP_TURN_TMP ***
 exec bpa.alter_policies('MP_TURN_TMP');


COMMENT ON TABLE BARS.MP_TURN_TMP IS '';
COMMENT ON COLUMN BARS.MP_TURN_TMP.FDAT IS '';
COMMENT ON COLUMN BARS.MP_TURN_TMP.REF IS '';
COMMENT ON COLUMN BARS.MP_TURN_TMP.ACC IS '';
COMMENT ON COLUMN BARS.MP_TURN_TMP.DK IS '';
COMMENT ON COLUMN BARS.MP_TURN_TMP.S IS '';
COMMENT ON COLUMN BARS.MP_TURN_TMP.SQ IS '';
COMMENT ON COLUMN BARS.MP_TURN_TMP.STMT IS '';



PROMPT *** Create  grants  MP_TURN_TMP ***
grant SELECT                                                                 on MP_TURN_TMP     to BARSREADER_ROLE;
grant SELECT                                                                 on MP_TURN_TMP     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MP_TURN_TMP.sql =========*** End *** =
PROMPT ===================================================================================== 
