

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SPARAM_CODES.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SPARAM_CODES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SPARAM_CODES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SPARAM_CODES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SPARAM_CODES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SPARAM_CODES ***
begin 
  execute immediate '
  CREATE TABLE BARS.SPARAM_CODES 
   (	CODE VARCHAR2(30), 
	NAME VARCHAR2(30), 
	ORD NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SPARAM_CODES ***
 exec bpa.alter_policies('SPARAM_CODES');


COMMENT ON TABLE BARS.SPARAM_CODES IS 'Коды разделов спецпараметров';
COMMENT ON COLUMN BARS.SPARAM_CODES.CODE IS 'Код';
COMMENT ON COLUMN BARS.SPARAM_CODES.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.SPARAM_CODES.ORD IS 'Сортировка';




PROMPT *** Create  constraint PK_SPARAMCODES ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPARAM_CODES ADD CONSTRAINT PK_SPARAMCODES PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SPARAMCODES_CODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SPARAM_CODES MODIFY (CODE CONSTRAINT CC_SPARAMCODES_CODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SPARAMCODES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SPARAMCODES ON BARS.SPARAM_CODES (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SPARAM_CODES ***
grant SELECT                                                                 on SPARAM_CODES    to BARSREADER_ROLE;
grant SELECT                                                                 on SPARAM_CODES    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SPARAM_CODES    to BARS_DM;
grant SELECT                                                                 on SPARAM_CODES    to CUST001;
grant SELECT                                                                 on SPARAM_CODES    to START1;
grant SELECT                                                                 on SPARAM_CODES    to UPLD;



PROMPT *** Create SYNONYM  to SPARAM_CODES ***

  CREATE OR REPLACE PUBLIC SYNONYM SPARAM_CODES FOR BARS.SPARAM_CODES;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SPARAM_CODES.sql =========*** End *** 
PROMPT ===================================================================================== 
