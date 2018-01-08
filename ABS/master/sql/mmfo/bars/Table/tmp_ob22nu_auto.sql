

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OB22NU_AUTO.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OB22NU_AUTO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_OB22NU_AUTO'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_OB22NU_AUTO'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_OB22NU_AUTO'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OB22NU_AUTO ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_OB22NU_AUTO 
   (	ACC NUMBER(38,0), 
	NLS VARCHAR2(15), 
	NMS VARCHAR2(70), 
	NBS CHAR(4), 
	P080 VARCHAR2(4), 
	OB22 VARCHAR2(2), 
	ACCN NUMBER(38,0), 
	NLSN VARCHAR2(15), 
	NMSN VARCHAR2(70), 
	NBSN VARCHAR2(4), 
	NP080 VARCHAR2(4), 
	NOB22 VARCHAR2(2), 
	PRIZN CHAR(1), 
	NMS8 VARCHAR2(254), 
	AP CHAR(1), 
	KS VARCHAR2(15)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OB22NU_AUTO ***
 exec bpa.alter_policies('TMP_OB22NU_AUTO');


COMMENT ON TABLE BARS.TMP_OB22NU_AUTO IS '';
COMMENT ON COLUMN BARS.TMP_OB22NU_AUTO.ACC IS '';
COMMENT ON COLUMN BARS.TMP_OB22NU_AUTO.NLS IS '';
COMMENT ON COLUMN BARS.TMP_OB22NU_AUTO.NMS IS '';
COMMENT ON COLUMN BARS.TMP_OB22NU_AUTO.NBS IS '';
COMMENT ON COLUMN BARS.TMP_OB22NU_AUTO.P080 IS '';
COMMENT ON COLUMN BARS.TMP_OB22NU_AUTO.OB22 IS '';
COMMENT ON COLUMN BARS.TMP_OB22NU_AUTO.ACCN IS '';
COMMENT ON COLUMN BARS.TMP_OB22NU_AUTO.NLSN IS '';
COMMENT ON COLUMN BARS.TMP_OB22NU_AUTO.NMSN IS '';
COMMENT ON COLUMN BARS.TMP_OB22NU_AUTO.NBSN IS '';
COMMENT ON COLUMN BARS.TMP_OB22NU_AUTO.NP080 IS '';
COMMENT ON COLUMN BARS.TMP_OB22NU_AUTO.NOB22 IS '';
COMMENT ON COLUMN BARS.TMP_OB22NU_AUTO.PRIZN IS '';
COMMENT ON COLUMN BARS.TMP_OB22NU_AUTO.NMS8 IS '';
COMMENT ON COLUMN BARS.TMP_OB22NU_AUTO.AP IS '';
COMMENT ON COLUMN BARS.TMP_OB22NU_AUTO.KS IS '';



PROMPT *** Create  grants  TMP_OB22NU_AUTO ***
grant SELECT                                                                 on TMP_OB22NU_AUTO to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_OB22NU_AUTO to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_OB22NU_AUTO to START1;
grant SELECT                                                                 on TMP_OB22NU_AUTO to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OB22NU_AUTO.sql =========*** End *
PROMPT ===================================================================================== 
