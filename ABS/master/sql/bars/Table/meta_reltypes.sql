

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/META_RELTYPES.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to META_RELTYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''META_RELTYPES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''META_RELTYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table META_RELTYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.META_RELTYPES 
   (	CODE CHAR(1), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to META_RELTYPES ***
 exec bpa.alter_policies('META_RELTYPES');


COMMENT ON TABLE BARS.META_RELTYPES IS 'Метаописание. Виды связей между таблицами';
COMMENT ON COLUMN BARS.META_RELTYPES.CODE IS 'Код вида связи';
COMMENT ON COLUMN BARS.META_RELTYPES.NAME IS 'Наименование вида связи';




PROMPT *** Create  constraint PK_METARELTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_RELTYPES ADD CONSTRAINT PK_METARELTYPES PRIMARY KEY (CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METARELTYPES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_RELTYPES MODIFY (NAME CONSTRAINT CC_METARELTYPES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_METARELTYPES_CODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.META_RELTYPES MODIFY (CODE CONSTRAINT CC_METARELTYPES_CODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_METARELTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_METARELTYPES ON BARS.META_RELTYPES (CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  META_RELTYPES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on META_RELTYPES   to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on META_RELTYPES   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on META_RELTYPES   to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on META_RELTYPES   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/META_RELTYPES.sql =========*** End ***
PROMPT ===================================================================================== 
