

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OB22NU.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OB22NU ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OB22NU ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_OB22NU 
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
	AP CHAR(1)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OB22NU ***
 exec bpa.alter_policies('TMP_OB22NU');


COMMENT ON TABLE BARS.TMP_OB22NU IS '';
COMMENT ON COLUMN BARS.TMP_OB22NU.ACC IS '';
COMMENT ON COLUMN BARS.TMP_OB22NU.NLS IS '';
COMMENT ON COLUMN BARS.TMP_OB22NU.NMS IS '';
COMMENT ON COLUMN BARS.TMP_OB22NU.NBS IS '';
COMMENT ON COLUMN BARS.TMP_OB22NU.P080 IS '';
COMMENT ON COLUMN BARS.TMP_OB22NU.OB22 IS '';
COMMENT ON COLUMN BARS.TMP_OB22NU.ACCN IS '';
COMMENT ON COLUMN BARS.TMP_OB22NU.NLSN IS '';
COMMENT ON COLUMN BARS.TMP_OB22NU.NMSN IS '';
COMMENT ON COLUMN BARS.TMP_OB22NU.NBSN IS '';
COMMENT ON COLUMN BARS.TMP_OB22NU.NP080 IS '';
COMMENT ON COLUMN BARS.TMP_OB22NU.NOB22 IS '';
COMMENT ON COLUMN BARS.TMP_OB22NU.PRIZN IS '';
COMMENT ON COLUMN BARS.TMP_OB22NU.NMS8 IS '';
COMMENT ON COLUMN BARS.TMP_OB22NU.AP IS '';




PROMPT *** Create  index UK_TMP_OB22NU ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_TMP_OB22NU ON BARS.TMP_OB22NU (ACC, AP) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_OB22NU ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_OB22NU      to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_OB22NU      to NALOG;
grant SELECT                                                                 on TMP_OB22NU      to RPBN001;



PROMPT *** Create SYNONYM  to TMP_OB22NU ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_OB22NU FOR BARS.TMP_OB22NU;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OB22NU.sql =========*** End *** ==
PROMPT ===================================================================================== 
