

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAPROS_FMT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAPROS_FMT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAPROS_FMT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ZAPROS_FMT'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ZAPROS_FMT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAPROS_FMT ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAPROS_FMT 
   (	ID NUMBER(2,0), 
	NAME VARCHAR2(60)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAPROS_FMT ***
 exec bpa.alter_policies('ZAPROS_FMT');


COMMENT ON TABLE BARS.ZAPROS_FMT IS 'Форматы каталогизированных запросов';
COMMENT ON COLUMN BARS.ZAPROS_FMT.ID IS 'Идентификатор формата';
COMMENT ON COLUMN BARS.ZAPROS_FMT.NAME IS 'Наименование формата';




PROMPT *** Create  constraint PK_ZAPROSFMT ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAPROS_FMT ADD CONSTRAINT PK_ZAPROSFMT PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAPROSFMT_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAPROS_FMT MODIFY (ID CONSTRAINT CC_ZAPROSFMT_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAPROSFMT_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAPROS_FMT MODIFY (NAME CONSTRAINT CC_ZAPROSFMT_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ZAPROSFMT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ZAPROSFMT ON BARS.ZAPROS_FMT (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAPROS_FMT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAPROS_FMT      to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAPROS_FMT      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ZAPROS_FMT      to BARS_DM;
grant SELECT                                                                 on ZAPROS_FMT      to DPT_ADMIN;
grant SELECT                                                                 on ZAPROS_FMT      to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ZAPROS_FMT      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAPROS_FMT.sql =========*** End *** ==
PROMPT ===================================================================================== 
