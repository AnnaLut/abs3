

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_PERSON_22_01.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_PERSON_22_01 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_PERSON_22_01 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_PERSON_22_01 
   (	F VARCHAR2(50), 
	I VARCHAR2(50), 
	O VARCHAR2(50), 
	C VARCHAR2(50), 
	D VARCHAR2(50), 
	DR DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_PERSON_22_01 ***
 exec bpa.alter_policies('TMP_PERSON_22_01');


COMMENT ON TABLE BARS.TMP_PERSON_22_01 IS '';
COMMENT ON COLUMN BARS.TMP_PERSON_22_01.F IS '';
COMMENT ON COLUMN BARS.TMP_PERSON_22_01.I IS '';
COMMENT ON COLUMN BARS.TMP_PERSON_22_01.O IS '';
COMMENT ON COLUMN BARS.TMP_PERSON_22_01.C IS '';
COMMENT ON COLUMN BARS.TMP_PERSON_22_01.D IS '';
COMMENT ON COLUMN BARS.TMP_PERSON_22_01.DR IS '';



PROMPT *** Create  grants  TMP_PERSON_22_01 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_PERSON_22_01 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_PERSON_22_01 to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_PERSON_22_01 to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_PERSON_22_01.sql =========*** End 
PROMPT ===================================================================================== 
