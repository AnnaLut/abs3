

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OB22_TMP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OB22_TMP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OB22_TMP ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_OB22_TMP 
   (	PRIZN CHAR(1), 
	PRIZN_D CHAR(1), 
	NLSN_D VARCHAR2(15), 
	OB22_D VARCHAR2(2), 
	PRIZN_K CHAR(1), 
	NLSN_K VARCHAR2(15), 
	OB22_K VARCHAR2(2), 
	FDAT DATE, 
	REF NUMBER, 
	NLSD VARCHAR2(15), 
	NLSK VARCHAR2(15), 
	S NUMBER, 
	NAZN VARCHAR2(160), 
	NMSN VARCHAR2(70), 
	VOB NUMBER, 
	VDAT DATE, 
	STMT NUMBER, 
	OTM NUMBER(*,0), 
	TT CHAR(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OB22_TMP ***
 exec bpa.alter_policies('TMP_OB22_TMP');


COMMENT ON TABLE BARS.TMP_OB22_TMP IS '';
COMMENT ON COLUMN BARS.TMP_OB22_TMP.PRIZN IS '';
COMMENT ON COLUMN BARS.TMP_OB22_TMP.PRIZN_D IS '';
COMMENT ON COLUMN BARS.TMP_OB22_TMP.NLSN_D IS '';
COMMENT ON COLUMN BARS.TMP_OB22_TMP.OB22_D IS '';
COMMENT ON COLUMN BARS.TMP_OB22_TMP.PRIZN_K IS '';
COMMENT ON COLUMN BARS.TMP_OB22_TMP.NLSN_K IS '';
COMMENT ON COLUMN BARS.TMP_OB22_TMP.OB22_K IS '';
COMMENT ON COLUMN BARS.TMP_OB22_TMP.FDAT IS '';
COMMENT ON COLUMN BARS.TMP_OB22_TMP.REF IS '';
COMMENT ON COLUMN BARS.TMP_OB22_TMP.NLSD IS '';
COMMENT ON COLUMN BARS.TMP_OB22_TMP.NLSK IS '';
COMMENT ON COLUMN BARS.TMP_OB22_TMP.S IS '';
COMMENT ON COLUMN BARS.TMP_OB22_TMP.NAZN IS '';
COMMENT ON COLUMN BARS.TMP_OB22_TMP.NMSN IS '';
COMMENT ON COLUMN BARS.TMP_OB22_TMP.VOB IS '';
COMMENT ON COLUMN BARS.TMP_OB22_TMP.VDAT IS '';
COMMENT ON COLUMN BARS.TMP_OB22_TMP.STMT IS '';
COMMENT ON COLUMN BARS.TMP_OB22_TMP.OTM IS '';
COMMENT ON COLUMN BARS.TMP_OB22_TMP.TT IS '';




PROMPT *** Create  index UK_TMP_OB22_TMP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_TMP_OB22_TMP ON BARS.TMP_OB22_TMP (REF, STMT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OB22_TMP.sql =========*** End *** 
PROMPT ===================================================================================== 
