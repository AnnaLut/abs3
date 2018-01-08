

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K044.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K044 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K044 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K044 
   (	K044 VARCHAR2(2), 
	TXT VARCHAR2(80)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_K044 ***
 exec bpa.alter_policies('KL_K044');


COMMENT ON TABLE BARS.KL_K044 IS '';
COMMENT ON COLUMN BARS.KL_K044.K044 IS '';
COMMENT ON COLUMN BARS.KL_K044.TXT IS '';



PROMPT *** Create  grants  KL_K044 ***
grant SELECT                                                                 on KL_K044         to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K044.sql =========*** End *** =====
PROMPT ===================================================================================== 
