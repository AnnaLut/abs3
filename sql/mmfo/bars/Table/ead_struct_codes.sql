

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EAD_STRUCT_CODES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EAD_STRUCT_CODES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EAD_STRUCT_CODES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EAD_STRUCT_CODES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''EAD_STRUCT_CODES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EAD_STRUCT_CODES ***
begin 
  execute immediate '
  CREATE TABLE BARS.EAD_STRUCT_CODES 
   (	ID NUMBER, 
	NAME VARCHAR2(300)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EAD_STRUCT_CODES ***
 exec bpa.alter_policies('EAD_STRUCT_CODES');


COMMENT ON TABLE BARS.EAD_STRUCT_CODES IS 'Статуси документів для передачі у ЕА';
COMMENT ON COLUMN BARS.EAD_STRUCT_CODES.ID IS 'Код структури документа';
COMMENT ON COLUMN BARS.EAD_STRUCT_CODES.NAME IS 'Тип документа';




PROMPT *** Create  constraint PK_EADSTRUCTCODES ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_STRUCT_CODES ADD CONSTRAINT PK_EADSTRUCTCODES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EADSTRUCTCODES_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_STRUCT_CODES MODIFY (ID CONSTRAINT CC_EADSTRUCTCODES_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_EADSTRUCTCODES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.EAD_STRUCT_CODES MODIFY (NAME CONSTRAINT CC_EADSTRUCTCODES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_EADSTRUCTCODES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EADSTRUCTCODES ON BARS.EAD_STRUCT_CODES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EAD_STRUCT_CODES ***
grant SELECT                                                                 on EAD_STRUCT_CODES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EAD_STRUCT_CODES to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EAD_STRUCT_CODES.sql =========*** End 
PROMPT ===================================================================================== 
