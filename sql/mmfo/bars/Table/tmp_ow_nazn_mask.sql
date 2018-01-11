

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OW_NAZN_MASK.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OW_NAZN_MASK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OW_NAZN_MASK ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_OW_NAZN_MASK 
   (	MASKID VARCHAR2(30), 
	NAZN VARCHAR2(160)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OW_NAZN_MASK ***
 exec bpa.alter_policies('TMP_OW_NAZN_MASK');


COMMENT ON TABLE BARS.TMP_OW_NAZN_MASK IS '';
COMMENT ON COLUMN BARS.TMP_OW_NAZN_MASK.MASKID IS '';
COMMENT ON COLUMN BARS.TMP_OW_NAZN_MASK.NAZN IS '';




PROMPT *** Create  constraint SYS_C00119189 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OW_NAZN_MASK MODIFY (MASKID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_OW_NAZN_MASK ***
grant SELECT                                                                 on TMP_OW_NAZN_MASK to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_OW_NAZN_MASK to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OW_NAZN_MASK.sql =========*** End 
PROMPT ===================================================================================== 
