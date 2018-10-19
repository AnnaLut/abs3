

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K190.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K190 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_K190'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K190 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K190 
   (	K190 VARCHAR2(4), 
	RATING VARCHAR2(4), 
	DESCR VARCHAR2(100), 
	DT_OPEN DATE, 
	DT_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_K190 ***
 exec bpa.alter_policies('KL_K190');


COMMENT ON TABLE BARS.KL_K190 IS '';
COMMENT ON COLUMN BARS.KL_K190.K190 IS '';
COMMENT ON COLUMN BARS.KL_K190.RATING IS '';
COMMENT ON COLUMN BARS.KL_K190.DESCR IS '';
COMMENT ON COLUMN BARS.KL_K190.DT_OPEN IS '';
COMMENT ON COLUMN BARS.KL_K190.DT_CLOSE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K190.sql =========*** End *** =====
PROMPT ===================================================================================== 
