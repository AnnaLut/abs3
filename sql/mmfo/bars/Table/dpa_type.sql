

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPA_TYPE.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPA_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPA_TYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPA_TYPE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPA_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPA_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPA_TYPE 
   (	TYPE VARCHAR2(3), 
	NAME VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPA_TYPE ***
 exec bpa.alter_policies('DPA_TYPE');


COMMENT ON TABLE BARS.DPA_TYPE IS 'Типы файлов';
COMMENT ON COLUMN BARS.DPA_TYPE.TYPE IS 'Тип файла';
COMMENT ON COLUMN BARS.DPA_TYPE.NAME IS 'Наименование типа';




PROMPT *** Create  constraint PK_DPATYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPA_TYPE ADD CONSTRAINT PK_DPATYPE PRIMARY KEY (TYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPATYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPATYPE ON BARS.DPA_TYPE (TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPA_TYPE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPA_TYPE        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPA_TYPE        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPA_TYPE        to RPBN002;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPA_TYPE        to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to DPA_TYPE ***

  CREATE OR REPLACE PUBLIC SYNONYM DPA_TYPE FOR BARS.DPA_TYPE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPA_TYPE.sql =========*** End *** ====
PROMPT ===================================================================================== 
