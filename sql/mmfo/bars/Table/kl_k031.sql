

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K031.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K031 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K031 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K031 
   (	K031 VARCHAR2(1), 
	TXT VARCHAR2(48)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_K031 ***
 exec bpa.alter_policies('KL_K031');


COMMENT ON TABLE BARS.KL_K031 IS '';
COMMENT ON COLUMN BARS.KL_K031.K031 IS '';
COMMENT ON COLUMN BARS.KL_K031.TXT IS '';



PROMPT *** Create  grants  KL_K031 ***
grant SELECT                                                                 on KL_K031         to BARSREADER_ROLE;
grant SELECT                                                                 on KL_K031         to BARS_DM;
grant SELECT                                                                 on KL_K031         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K031.sql =========*** End *** =====
PROMPT ===================================================================================== 
