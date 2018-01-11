

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OW_KEYS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OW_KEYS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OW_KEYS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_OW_KEYS 
   (	KEY_ID NUMBER(18,0), 
	KEY_VALUE VARCHAR2(3900), 
	START_DATE DATE, 
	END_DATE DATE, 
	IS_ACTIVE VARCHAR2(1), 
	TYPE NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OW_KEYS ***
 exec bpa.alter_policies('TMP_OW_KEYS');


COMMENT ON TABLE BARS.TMP_OW_KEYS IS '';
COMMENT ON COLUMN BARS.TMP_OW_KEYS.KEY_ID IS '';
COMMENT ON COLUMN BARS.TMP_OW_KEYS.KEY_VALUE IS '';
COMMENT ON COLUMN BARS.TMP_OW_KEYS.START_DATE IS '';
COMMENT ON COLUMN BARS.TMP_OW_KEYS.END_DATE IS '';
COMMENT ON COLUMN BARS.TMP_OW_KEYS.IS_ACTIVE IS '';
COMMENT ON COLUMN BARS.TMP_OW_KEYS.TYPE IS '';




PROMPT *** Create  constraint SYS_C00119182 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OW_KEYS MODIFY (KEY_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119183 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OW_KEYS MODIFY (KEY_VALUE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119184 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OW_KEYS MODIFY (START_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119185 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OW_KEYS MODIFY (END_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119186 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OW_KEYS MODIFY (IS_ACTIVE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_OW_KEYS ***
grant SELECT                                                                 on TMP_OW_KEYS     to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_OW_KEYS     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OW_KEYS.sql =========*** End *** =
PROMPT ===================================================================================== 
