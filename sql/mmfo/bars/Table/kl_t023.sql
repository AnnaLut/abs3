

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_T023.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_T023 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_T023 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_T023 
   (	T023 VARCHAR2(1), 
	NAME VARCHAR2(20), 
	D_OPEN DATE, 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_T023 ***
 exec bpa.alter_policies('KL_T023');


COMMENT ON TABLE BARS.KL_T023 IS '';
COMMENT ON COLUMN BARS.KL_T023.T023 IS '';
COMMENT ON COLUMN BARS.KL_T023.NAME IS '';
COMMENT ON COLUMN BARS.KL_T023.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_T023.D_CLOSE IS '';



PROMPT *** Create  grants  KL_T023 ***
grant SELECT                                                                 on KL_T023         to BARSREADER_ROLE;
grant SELECT                                                                 on KL_T023         to BARS_DM;
grant SELECT                                                                 on KL_T023         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_T023.sql =========*** End *** =====
PROMPT ===================================================================================== 
