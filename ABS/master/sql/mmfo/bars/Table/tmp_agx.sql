

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_AGX.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_AGX ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_AGX'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_AGX'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_AGX ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_AGX 
   (	ND NUMBER, 
	NDOC VARCHAR2(30), 
	NMK VARCHAR2(70), 
	ISP NUMBER, 
	RNK NUMBER(*,0), 
	NLS VARCHAR2(15), 
	VOST NUMBER(24,0), 
	SN NUMBER(24,0), 
	SU NUMBER(24,0), 
	SP NUMBER(24,0), 
	OST NUMBER(24,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_AGX ***
 exec bpa.alter_policies('TMP_AGX');


COMMENT ON TABLE BARS.TMP_AGX IS '';
COMMENT ON COLUMN BARS.TMP_AGX.ND IS '';
COMMENT ON COLUMN BARS.TMP_AGX.NDOC IS '';
COMMENT ON COLUMN BARS.TMP_AGX.NMK IS '';
COMMENT ON COLUMN BARS.TMP_AGX.ISP IS '';
COMMENT ON COLUMN BARS.TMP_AGX.RNK IS '';
COMMENT ON COLUMN BARS.TMP_AGX.NLS IS '';
COMMENT ON COLUMN BARS.TMP_AGX.VOST IS '';
COMMENT ON COLUMN BARS.TMP_AGX.SN IS '';
COMMENT ON COLUMN BARS.TMP_AGX.SU IS '';
COMMENT ON COLUMN BARS.TMP_AGX.SP IS '';
COMMENT ON COLUMN BARS.TMP_AGX.OST IS '';



PROMPT *** Create  grants  TMP_AGX ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on TMP_AGX         to BARS009;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_AGX         to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to TMP_AGX ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_AGX FOR BARS.TMP_AGX;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_AGX.sql =========*** End *** =====
PROMPT ===================================================================================== 
