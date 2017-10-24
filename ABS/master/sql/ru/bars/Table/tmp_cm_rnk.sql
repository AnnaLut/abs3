

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CM_RNK.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CM_RNK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CM_RNK ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_CM_RNK 
   (	RNK NUMBER, 
	MFO NUMBER, 
	STATUS VARCHAR2(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_CM_RNK ***
 exec bpa.alter_policies('TMP_CM_RNK');


COMMENT ON TABLE BARS.TMP_CM_RNK IS '';
COMMENT ON COLUMN BARS.TMP_CM_RNK.RNK IS '';
COMMENT ON COLUMN BARS.TMP_CM_RNK.MFO IS '';
COMMENT ON COLUMN BARS.TMP_CM_RNK.STATUS IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CM_RNK.sql =========*** End *** ==
PROMPT ===================================================================================== 
