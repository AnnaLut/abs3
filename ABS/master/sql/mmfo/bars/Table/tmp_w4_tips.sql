

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_W4_TIPS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_W4_TIPS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_W4_TIPS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_W4_TIPS 
   (	TIP CHAR(3), 
	TERM_MIN NUMBER(10,0), 
	TERM_MAX NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_W4_TIPS ***
 exec bpa.alter_policies('TMP_W4_TIPS');


COMMENT ON TABLE BARS.TMP_W4_TIPS IS '';
COMMENT ON COLUMN BARS.TMP_W4_TIPS.TIP IS '';
COMMENT ON COLUMN BARS.TMP_W4_TIPS.TERM_MIN IS '';
COMMENT ON COLUMN BARS.TMP_W4_TIPS.TERM_MAX IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_W4_TIPS.sql =========*** End *** =
PROMPT ===================================================================================== 
