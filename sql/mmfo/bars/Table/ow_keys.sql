

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_KEYS.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_KEYS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_KEYS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OW_KEYS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OW_KEYS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_KEYS ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_KEYS 
   (	KEY_ID NUMBER(18,0), 
	KEY_VALUE VARCHAR2(3900), 
	START_DATE DATE, 
	END_DATE DATE, 
	IS_ACTIVE VARCHAR2(1) DEFAULT ''Y'', 
	TYPE NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_KEYS ***
 exec bpa.alter_policies('OW_KEYS');


COMMENT ON TABLE BARS.OW_KEYS IS '';
COMMENT ON COLUMN BARS.OW_KEYS.KEY_ID IS 'Ідентифікатор ключа';
COMMENT ON COLUMN BARS.OW_KEYS.KEY_VALUE IS 'Значення ключа';
COMMENT ON COLUMN BARS.OW_KEYS.START_DATE IS 'Термін початку дії ключа';
COMMENT ON COLUMN BARS.OW_KEYS.END_DATE IS 'Термін закінчення дії ключа';
COMMENT ON COLUMN BARS.OW_KEYS.IS_ACTIVE IS 'Статус(Y-активний(по-замовчуванню), N-не активний )';
COMMENT ON COLUMN BARS.OW_KEYS.TYPE IS '';




PROMPT *** Create  constraint PK_OW_KEYS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_KEYS ADD CONSTRAINT PK_OW_KEYS PRIMARY KEY (KEY_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004812 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_KEYS MODIFY (KEY_ID NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004813 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_KEYS MODIFY (KEY_VALUE NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004814 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_KEYS MODIFY (START_DATE NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004815 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_KEYS MODIFY (END_DATE NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004816 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_KEYS MODIFY (IS_ACTIVE NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OW_KEYS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OW_KEYS ON BARS.OW_KEYS (KEY_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_KEYS ***
grant SELECT                                                                 on OW_KEYS         to BARSREADER_ROLE;
grant SELECT                                                                 on OW_KEYS         to BARS_DM;
grant SELECT                                                                 on OW_KEYS         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_KEYS.sql =========*** End *** =====
PROMPT ===================================================================================== 
