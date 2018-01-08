

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_W4_STO_TTS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_W4_STO_TTS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_W4_STO_TTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_W4_STO_TTS 
   (	TT CHAR(3), 
	DESCRIPTION VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_W4_STO_TTS ***
 exec bpa.alter_policies('TMP_W4_STO_TTS');


COMMENT ON TABLE BARS.TMP_W4_STO_TTS IS '';
COMMENT ON COLUMN BARS.TMP_W4_STO_TTS.TT IS '';
COMMENT ON COLUMN BARS.TMP_W4_STO_TTS.DESCRIPTION IS '';




PROMPT *** Create  constraint SYS_C00119209 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_W4_STO_TTS MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_W4_STO_TTS.sql =========*** End **
PROMPT ===================================================================================== 
