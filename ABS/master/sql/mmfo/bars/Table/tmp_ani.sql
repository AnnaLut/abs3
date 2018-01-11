

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ANI.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ANI ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_ANI'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_ANI'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_ANI'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ANI ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_ANI 
   (	YYYY_MM CHAR(7), 
	DAT DATE, 
	TE NUMBER(*,0), 
	MO NUMBER(*,0), 
	BRANCH VARCHAR2(15), 
	ID NUMBER(*,0), 
	N1 NUMBER, 
	N2 NUMBER, 
	N3 NUMBER, 
	N4 NUMBER, 
	N5 NUMBER, 
	N6 NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_ANI ***
 exec bpa.alter_policies('TMP_ANI');


COMMENT ON TABLE BARS.TMP_ANI IS '';
COMMENT ON COLUMN BARS.TMP_ANI.YYYY_MM IS '';
COMMENT ON COLUMN BARS.TMP_ANI.DAT IS '';
COMMENT ON COLUMN BARS.TMP_ANI.TE IS '';
COMMENT ON COLUMN BARS.TMP_ANI.MO IS '';
COMMENT ON COLUMN BARS.TMP_ANI.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_ANI.ID IS '';
COMMENT ON COLUMN BARS.TMP_ANI.N1 IS '';
COMMENT ON COLUMN BARS.TMP_ANI.N2 IS '';
COMMENT ON COLUMN BARS.TMP_ANI.N3 IS '';
COMMENT ON COLUMN BARS.TMP_ANI.N4 IS '';
COMMENT ON COLUMN BARS.TMP_ANI.N5 IS '';
COMMENT ON COLUMN BARS.TMP_ANI.N6 IS '';



PROMPT *** Create  grants  TMP_ANI ***
grant SELECT                                                                 on TMP_ANI         to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_ANI         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_ANI         to BARS_DM;
grant SELECT                                                                 on TMP_ANI         to RPBN001;
grant SELECT                                                                 on TMP_ANI         to SALGL;
grant SELECT                                                                 on TMP_ANI         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ANI.sql =========*** End *** =====
PROMPT ===================================================================================== 
