

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OW_IIC_MSGCODE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OW_IIC_MSGCODE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OW_IIC_MSGCODE ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_OW_IIC_MSGCODE 
   (	TT CHAR(3), 
	MFOA VARCHAR2(6), 
	NLSA VARCHAR2(14), 
	MSGCODE VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OW_IIC_MSGCODE ***
 exec bpa.alter_policies('TMP_OW_IIC_MSGCODE');


COMMENT ON TABLE BARS.TMP_OW_IIC_MSGCODE IS '';
COMMENT ON COLUMN BARS.TMP_OW_IIC_MSGCODE.TT IS '';
COMMENT ON COLUMN BARS.TMP_OW_IIC_MSGCODE.MFOA IS '';
COMMENT ON COLUMN BARS.TMP_OW_IIC_MSGCODE.NLSA IS '';
COMMENT ON COLUMN BARS.TMP_OW_IIC_MSGCODE.MSGCODE IS '';




PROMPT *** Create  constraint SYS_C00119178 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OW_IIC_MSGCODE MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119181 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OW_IIC_MSGCODE MODIFY (MSGCODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119180 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OW_IIC_MSGCODE MODIFY (NLSA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119179 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OW_IIC_MSGCODE MODIFY (MFOA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OW_IIC_MSGCODE.sql =========*** En
PROMPT ===================================================================================== 
