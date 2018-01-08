

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ISTVAL.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ISTVAL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ISTVAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_ISTVAL 
   (	NN NUMBER(*,0), 
	S1 VARCHAR2(15), 
	S2 VARCHAR2(1000), 
	S3 NUMBER, 
	S4 NUMBER, 
	S5 NUMBER, 
	S6 NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_ISTVAL ***
 exec bpa.alter_policies('TMP_ISTVAL');


COMMENT ON TABLE BARS.TMP_ISTVAL IS '';
COMMENT ON COLUMN BARS.TMP_ISTVAL.NN IS '';
COMMENT ON COLUMN BARS.TMP_ISTVAL.S1 IS '';
COMMENT ON COLUMN BARS.TMP_ISTVAL.S2 IS '';
COMMENT ON COLUMN BARS.TMP_ISTVAL.S3 IS '';
COMMENT ON COLUMN BARS.TMP_ISTVAL.S4 IS '';
COMMENT ON COLUMN BARS.TMP_ISTVAL.S5 IS '';
COMMENT ON COLUMN BARS.TMP_ISTVAL.S6 IS '';



PROMPT *** Create  grants  TMP_ISTVAL ***
grant SELECT                                                                 on TMP_ISTVAL      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_ISTVAL      to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_ISTVAL      to START1;
grant SELECT                                                                 on TMP_ISTVAL      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ISTVAL.sql =========*** End *** ==
PROMPT ===================================================================================== 
