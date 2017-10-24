

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_DATE_VALUE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ATTRIBUTE_DATE_VALUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ATTRIBUTE_DATE_VALUE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ATTRIBUTE_DATE_VALUE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ATTRIBUTE_DATE_VALUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ATTRIBUTE_DATE_VALUE 
   (	OBJECT_ID NUMBER(12,0), 
	ATTRIBUTE_ID NUMBER(5,0), 
	VALUE DATE
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
  TABLESPACE BRSDYND 
  PARTITION BY RANGE (ATTRIBUTE_ID) INTERVAL (1) 
 (PARTITION INITIAL_PARTITION  VALUES LESS THAN (1) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE BRSDYND ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ATTRIBUTE_DATE_VALUE ***
 exec bpa.alter_policies('ATTRIBUTE_DATE_VALUE');


COMMENT ON TABLE BARS.ATTRIBUTE_DATE_VALUE IS 'Значення атрибутів типу Дата';
COMMENT ON COLUMN BARS.ATTRIBUTE_DATE_VALUE.OBJECT_ID IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_DATE_VALUE.ATTRIBUTE_ID IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_DATE_VALUE.VALUE IS '';




PROMPT *** Create  constraint FK_DATE_VAL_REF_ATTR_KIND ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_DATE_VALUE ADD CONSTRAINT FK_DATE_VAL_REF_ATTR_KIND FOREIGN KEY (ATTRIBUTE_ID)
	  REFERENCES BARS.ATTRIBUTE_KIND (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002861356 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_DATE_VALUE MODIFY (VALUE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002861355 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_DATE_VALUE MODIFY (ATTRIBUTE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002861354 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_DATE_VALUE MODIFY (OBJECT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index OBJ_DATE_ATTR_IDX ***
begin   
 execute immediate '
  CREATE INDEX BARS.OBJ_DATE_ATTR_IDX ON BARS.ATTRIBUTE_DATE_VALUE (OBJECT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index OBJ_DATE_ATTR_IDX2 ***
begin   
 execute immediate '
  CREATE INDEX BARS.OBJ_DATE_ATTR_IDX2 ON BARS.ATTRIBUTE_DATE_VALUE (VALUE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255  LOCAL
 (PARTITION INITIAL_PARTITION 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSDYND ) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_DATE_VALUE.sql =========*** 
PROMPT ===================================================================================== 
