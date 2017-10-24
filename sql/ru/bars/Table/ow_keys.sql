

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_KEYS.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_KEYS ***


BEGIN 
        execute immediate  
          'begin  
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
COMMENT ON COLUMN BARS.OW_KEYS.KEY_ID IS '������������� �����';
COMMENT ON COLUMN BARS.OW_KEYS.KEY_VALUE IS '�������� �����';
COMMENT ON COLUMN BARS.OW_KEYS.START_DATE IS '����� ������� 䳿 �����';
COMMENT ON COLUMN BARS.OW_KEYS.END_DATE IS '����� ��������� 䳿 �����';
COMMENT ON COLUMN BARS.OW_KEYS.IS_ACTIVE IS '������(Y-��������(��-������������), N-�� �������� )';
COMMENT ON COLUMN BARS.OW_KEYS.TYPE IS '';




PROMPT *** Create  constraint FK_KEYSTOKEYTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_KEYS ADD CONSTRAINT FK_KEYSTOKEYTYPES FOREIGN KEY (TYPE)
	  REFERENCES BARS.KEYTYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002951430 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_KEYS MODIFY (END_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002951429 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_KEYS MODIFY (START_DATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002951428 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_KEYS MODIFY (KEY_VALUE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002951427 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_KEYS MODIFY (KEY_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




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




PROMPT *** Create  constraint SYS_C002951431 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_KEYS MODIFY (IS_ACTIVE NOT NULL ENABLE)';
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





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_KEYS.sql =========*** End *** =====
PROMPT ===================================================================================== 
