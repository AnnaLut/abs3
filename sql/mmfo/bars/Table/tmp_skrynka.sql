

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SKRYNKA.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SKRYNKA ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SKRYNKA ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_SKRYNKA 
   (	O_SK NUMBER, 
	N_SK NUMBER, 
	SNUM VARCHAR2(64 CHAR), 
	KEYUSED NUMBER, 
	ISP_MO NUMBER, 
	KEYNUMBER VARCHAR2(30), 
	BRANCH VARCHAR2(30), 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SKRYNKA ***
 exec bpa.alter_policies('TMP_SKRYNKA');


COMMENT ON TABLE BARS.TMP_SKRYNKA IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA.O_SK IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA.N_SK IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA.SNUM IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA.KEYUSED IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA.ISP_MO IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA.KEYNUMBER IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_SKRYNKA.KF IS '';



PROMPT *** Create  grants  TMP_SKRYNKA ***
grant SELECT                                                                 on TMP_SKRYNKA     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SKRYNKA.sql =========*** End *** =
PROMPT ===================================================================================== 
