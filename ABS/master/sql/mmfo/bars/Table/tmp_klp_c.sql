

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_KLP_C.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_KLP_C ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_KLP_C ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_KLP_C 
   (	ID NUMBER(*,0), 
	COMM VARCHAR2(256), 
	SID NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_KLP_C ***
 exec bpa.alter_policies('TMP_KLP_C');


COMMENT ON TABLE BARS.TMP_KLP_C IS '';
COMMENT ON COLUMN BARS.TMP_KLP_C.ID IS '';
COMMENT ON COLUMN BARS.TMP_KLP_C.COMM IS '';
COMMENT ON COLUMN BARS.TMP_KLP_C.SID IS '';



PROMPT *** Create  grants  TMP_KLP_C ***
grant SELECT,UPDATE                                                          on TMP_KLP_C       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_KLP_C       to BARS_DM;
grant SELECT,UPDATE                                                          on TMP_KLP_C       to TECH_MOM1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_KLP_C.sql =========*** End *** ===
PROMPT ===================================================================================== 
