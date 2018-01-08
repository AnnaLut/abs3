

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_FM_TURN_ARC.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_FM_TURN_ARC ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_FM_TURN_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_FM_TURN_ARC 
   (	DAT DATE, 
	RNK NUMBER, 
	KV NUMBER, 
	TURN_IN NUMBER, 
	TURN_INQ NUMBER, 
	TURN_OUT NUMBER, 
	TURN_OUTQ NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_FM_TURN_ARC ***
 exec bpa.alter_policies('TMP_FM_TURN_ARC');


COMMENT ON TABLE BARS.TMP_FM_TURN_ARC IS '';
COMMENT ON COLUMN BARS.TMP_FM_TURN_ARC.DAT IS '';
COMMENT ON COLUMN BARS.TMP_FM_TURN_ARC.RNK IS '';
COMMENT ON COLUMN BARS.TMP_FM_TURN_ARC.KV IS '';
COMMENT ON COLUMN BARS.TMP_FM_TURN_ARC.TURN_IN IS '';
COMMENT ON COLUMN BARS.TMP_FM_TURN_ARC.TURN_INQ IS '';
COMMENT ON COLUMN BARS.TMP_FM_TURN_ARC.TURN_OUT IS '';
COMMENT ON COLUMN BARS.TMP_FM_TURN_ARC.TURN_OUTQ IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_FM_TURN_ARC.sql =========*** End *
PROMPT ===================================================================================== 
