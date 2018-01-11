

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_BPK_SCHEME.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_BPK_SCHEME ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_BPK_SCHEME ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_BPK_SCHEME 
   (	ID NUMBER(22,0), 
	NAME VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_BPK_SCHEME ***
 exec bpa.alter_policies('TMP_BPK_SCHEME');


COMMENT ON TABLE BARS.TMP_BPK_SCHEME IS '';
COMMENT ON COLUMN BARS.TMP_BPK_SCHEME.ID IS '';
COMMENT ON COLUMN BARS.TMP_BPK_SCHEME.NAME IS '';




PROMPT *** Create  constraint SYS_C00119177 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_BPK_SCHEME MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_BPK_SCHEME ***
grant SELECT                                                                 on TMP_BPK_SCHEME  to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_BPK_SCHEME  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_BPK_SCHEME.sql =========*** End **
PROMPT ===================================================================================== 
