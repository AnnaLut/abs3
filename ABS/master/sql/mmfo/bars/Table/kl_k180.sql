

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K180.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K180 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K180 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K180 
   (	K180 VARCHAR2(1), 
	TXT VARCHAR2(128), 
	DATA_O DATE, 
	DATA_C DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_K180 ***
 exec bpa.alter_policies('KL_K180');


COMMENT ON TABLE BARS.KL_K180 IS '';
COMMENT ON COLUMN BARS.KL_K180.K180 IS '';
COMMENT ON COLUMN BARS.KL_K180.TXT IS '';
COMMENT ON COLUMN BARS.KL_K180.DATA_O IS '';
COMMENT ON COLUMN BARS.KL_K180.DATA_C IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K180.sql =========*** End *** =====
PROMPT ===================================================================================== 
