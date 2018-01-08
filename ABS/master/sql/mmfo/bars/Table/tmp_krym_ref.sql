

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_KRYM_REF.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_KRYM_REF ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_KRYM_REF ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_KRYM_REF 
   (	ND NUMBER(10,0), 
	KV NUMBER(3,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_KRYM_REF ***
 exec bpa.alter_policies('TMP_KRYM_REF');


COMMENT ON TABLE BARS.TMP_KRYM_REF IS '';
COMMENT ON COLUMN BARS.TMP_KRYM_REF.ND IS '';
COMMENT ON COLUMN BARS.TMP_KRYM_REF.KV IS '';




PROMPT *** Create  constraint XPK_TMPKRYMREF_NDKV ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_KRYM_REF ADD CONSTRAINT XPK_TMPKRYMREF_NDKV PRIMARY KEY (ND, KV)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_TMPKRYMREFNDKV ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_TMPKRYMREFNDKV ON BARS.TMP_KRYM_REF (ND, KV) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_KRYM_REF ***
grant SELECT                                                                 on TMP_KRYM_REF    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_KRYM_REF    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_KRYM_REF    to START1;
grant SELECT                                                                 on TMP_KRYM_REF    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_KRYM_REF.sql =========*** End *** 
PROMPT ===================================================================================== 
