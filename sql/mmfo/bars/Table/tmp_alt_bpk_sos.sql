

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ALT_BPK_SOS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ALT_BPK_SOS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ALT_BPK_SOS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_ALT_BPK_SOS 
   (	ID NUMBER(3,0), 
	NAME VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_ALT_BPK_SOS ***
 exec bpa.alter_policies('TMP_ALT_BPK_SOS');


COMMENT ON TABLE BARS.TMP_ALT_BPK_SOS IS '';
COMMENT ON COLUMN BARS.TMP_ALT_BPK_SOS.ID IS '';
COMMENT ON COLUMN BARS.TMP_ALT_BPK_SOS.NAME IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ALT_BPK_SOS.sql =========*** End *
PROMPT ===================================================================================== 
