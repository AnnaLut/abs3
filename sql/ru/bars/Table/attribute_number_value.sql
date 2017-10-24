

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_NUMBER_VALUE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ATTRIBUTE_NUMBER_VALUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ATTRIBUTE_NUMBER_VALUE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ATTRIBUTE_NUMBER_VALUE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ATTRIBUTE_NUMBER_VALUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ATTRIBUTE_NUMBER_VALUE 
   (	OBJECT_ID NUMBER(12,0), 
	ATTRIBUTE_ID NUMBER(5,0), 
	VALUE NUMBER(32,12)
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




PROMPT *** ALTER_POLICIES to ATTRIBUTE_NUMBER_VALUE ***
 exec bpa.alter_policies('ATTRIBUTE_NUMBER_VALUE');


COMMENT ON TABLE BARS.ATTRIBUTE_NUMBER_VALUE IS 'Числові значення атрибутів об'єктів';
COMMENT ON COLUMN BARS.ATTRIBUTE_NUMBER_VALUE.OBJECT_ID IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_NUMBER_VALUE.ATTRIBUTE_ID IS '';
COMMENT ON COLUMN BARS.ATTRIBUTE_NUMBER_VALUE.VALUE IS '';




PROMPT *** Create  constraint FK_NUM_VAL_REF_ATTR_KIND ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_NUMBER_VALUE ADD CONSTRAINT FK_NUM_VAL_REF_ATTR_KIND FOREIGN KEY (ATTRIBUTE_ID)
	  REFERENCES BARS.ATTRIBUTE_KIND (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ATTRNV_VAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_NUMBER_VALUE MODIFY (VALUE CONSTRAINT CC_ATTRNV_VAL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ATTRNV_ATTR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_NUMBER_VALUE MODIFY (ATTRIBUTE_ID CONSTRAINT CC_ATTRNV_ATTR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ATTRNV_OBJ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ATTRIBUTE_NUMBER_VALUE MODIFY (OBJECT_ID CONSTRAINT CC_ATTRNV_OBJ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index OBJ_NUMBER_ATTR_IDX ***
begin   
 execute immediate '
  CREATE INDEX BARS.OBJ_NUMBER_ATTR_IDX ON BARS.ATTRIBUTE_NUMBER_VALUE (OBJECT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index OBJ_NUMBER_ATTR_IDX2 ***
begin   
 execute immediate '
  CREATE INDEX BARS.OBJ_NUMBER_ATTR_IDX2 ON BARS.ATTRIBUTE_NUMBER_VALUE (VALUE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255  LOCAL
 (PARTITION INITIAL_PARTITION 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING 
  TABLESPACE BRSDYND ) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ATTRIBUTE_NUMBER_VALUE ***
grant SELECT                                                                 on ATTRIBUTE_NUMBER_VALUE to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ATTRIBUTE_NUMBER_VALUE.sql =========**
PROMPT ===================================================================================== 
