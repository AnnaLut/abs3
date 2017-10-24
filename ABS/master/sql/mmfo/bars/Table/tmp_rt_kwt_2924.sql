

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_RT_KWT_2924.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_RT_KWT_2924 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_RT_KWT_2924 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_RT_KWT_2924 
   (	ACC NUMBER, 
	REF NUMBER, 
	FDAT DATE, 
	S NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_RT_KWT_2924 ***
 exec bpa.alter_policies('TMP_RT_KWT_2924');


COMMENT ON TABLE BARS.TMP_RT_KWT_2924 IS '';
COMMENT ON COLUMN BARS.TMP_RT_KWT_2924.ACC IS '';
COMMENT ON COLUMN BARS.TMP_RT_KWT_2924.REF IS '';
COMMENT ON COLUMN BARS.TMP_RT_KWT_2924.FDAT IS '';
COMMENT ON COLUMN BARS.TMP_RT_KWT_2924.S IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_RT_KWT_2924.sql =========*** End *
PROMPT ===================================================================================== 
