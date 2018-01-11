

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_BACK_BPK.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_BACK_BPK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_BACK_BPK ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_BACK_BPK 
   (	REF NUMBER, 
	NLS VARCHAR2(30), 
	ERR VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_BACK_BPK ***
 exec bpa.alter_policies('TMP_BACK_BPK');


COMMENT ON TABLE BARS.TMP_BACK_BPK IS '';
COMMENT ON COLUMN BARS.TMP_BACK_BPK.REF IS '';
COMMENT ON COLUMN BARS.TMP_BACK_BPK.NLS IS '';
COMMENT ON COLUMN BARS.TMP_BACK_BPK.ERR IS '';



PROMPT *** Create  grants  TMP_BACK_BPK ***
grant SELECT                                                                 on TMP_BACK_BPK    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_BACK_BPK.sql =========*** End *** 
PROMPT ===================================================================================== 
