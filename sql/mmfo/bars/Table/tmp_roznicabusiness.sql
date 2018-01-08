

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ROZNICABUSINESS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ROZNICABUSINESS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_ROZNICABUSINESS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_ROZNICABUSINESS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_ROZNICABUSINESS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ROZNICABUSINESS ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_ROZNICABUSINESS 
   (	OKPO VARCHAR2(10), 
	NAME VARCHAR2(110), 
	ND VARCHAR2(30), 
	MFO NUMBER, 
	NLS VARCHAR2(14), 
	KOL NUMBER, 
	SUMMA NUMBER, 
	PERIOD VARCHAR2(70), 
	ID NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_ROZNICABUSINESS ***
 exec bpa.alter_policies('TMP_ROZNICABUSINESS');


COMMENT ON TABLE BARS.TMP_ROZNICABUSINESS IS '';
COMMENT ON COLUMN BARS.TMP_ROZNICABUSINESS.OKPO IS '';
COMMENT ON COLUMN BARS.TMP_ROZNICABUSINESS.NAME IS '';
COMMENT ON COLUMN BARS.TMP_ROZNICABUSINESS.ND IS '';
COMMENT ON COLUMN BARS.TMP_ROZNICABUSINESS.MFO IS '';
COMMENT ON COLUMN BARS.TMP_ROZNICABUSINESS.NLS IS '';
COMMENT ON COLUMN BARS.TMP_ROZNICABUSINESS.KOL IS '';
COMMENT ON COLUMN BARS.TMP_ROZNICABUSINESS.SUMMA IS '';
COMMENT ON COLUMN BARS.TMP_ROZNICABUSINESS.PERIOD IS '';
COMMENT ON COLUMN BARS.TMP_ROZNICABUSINESS.ID IS '';



PROMPT *** Create  grants  TMP_ROZNICABUSINESS ***
grant SELECT                                                                 on TMP_ROZNICABUSINESS to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_ROZNICABUSINESS to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_ROZNICABUSINESS to START1;
grant SELECT                                                                 on TMP_ROZNICABUSINESS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ROZNICABUSINESS.sql =========*** E
PROMPT ===================================================================================== 
