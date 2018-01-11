

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_2625_REBRANCH.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_2625_REBRANCH ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_2625_REBRANCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_2625_REBRANCH 
   (	NLS VARCHAR2(16), 
	BRANCH_OLD VARCHAR2(22), 
	BRANCH_NEW VARCHAR2(22)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_2625_REBRANCH ***
 exec bpa.alter_policies('TMP_2625_REBRANCH');


COMMENT ON TABLE BARS.TMP_2625_REBRANCH IS '';
COMMENT ON COLUMN BARS.TMP_2625_REBRANCH.NLS IS '';
COMMENT ON COLUMN BARS.TMP_2625_REBRANCH.BRANCH_OLD IS '';
COMMENT ON COLUMN BARS.TMP_2625_REBRANCH.BRANCH_NEW IS '';



PROMPT *** Create  grants  TMP_2625_REBRANCH ***
grant SELECT                                                                 on TMP_2625_REBRANCH to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_2625_REBRANCH to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_2625_REBRANCH to START1;
grant SELECT                                                                 on TMP_2625_REBRANCH to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_2625_REBRANCH.sql =========*** End
PROMPT ===================================================================================== 
