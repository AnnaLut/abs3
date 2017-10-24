

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_BPK_TAGS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_BPK_TAGS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_BPK_TAGS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_BPK_TAGS 
   (	TAG VARCHAR2(30), 
	NAME VARCHAR2(100), 
	TYPE VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_BPK_TAGS ***
 exec bpa.alter_policies('TMP_BPK_TAGS');


COMMENT ON TABLE BARS.TMP_BPK_TAGS IS '';
COMMENT ON COLUMN BARS.TMP_BPK_TAGS.TAG IS '';
COMMENT ON COLUMN BARS.TMP_BPK_TAGS.NAME IS '';
COMMENT ON COLUMN BARS.TMP_BPK_TAGS.TYPE IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_BPK_TAGS.sql =========*** End *** 
PROMPT ===================================================================================== 
