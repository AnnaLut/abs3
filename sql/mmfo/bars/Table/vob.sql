

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VOB.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VOB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''VOB'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''VOB'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''VOB'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VOB ***
begin 
  execute immediate '
  CREATE TABLE BARS.VOB 
   (	VOB NUMBER(38,0), 
	NAME VARCHAR2(35) DEFAULT null, 
	FLV NUMBER(1,0) DEFAULT null, 
	REP_PREFIX VARCHAR2(8), 
	OVRD4IPMT VARCHAR2(1), 
	KDOC CHAR(2), 
	REP_PREFIX_FR VARCHAR2(11), 
	KOD CHAR(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to VOB ***
 exec bpa.alter_policies('VOB');


COMMENT ON TABLE BARS.VOB IS 'Справочник видов банковских документов';
COMMENT ON COLUMN BARS.VOB.VOB IS 'Вид банковского документа';
COMMENT ON COLUMN BARS.VOB.NAME IS 'Наименование';
COMMENT ON COLUMN BARS.VOB.FLV IS 'Флаг возможности ввода (0 - нельзя, 1 - можно вводить программой
ввода)';
COMMENT ON COLUMN BARS.VOB.REP_PREFIX IS 'Имя файла шаблона';
COMMENT ON COLUMN BARS.VOB.OVRD4IPMT IS '';
COMMENT ON COLUMN BARS.VOB.KDOC IS '';
COMMENT ON COLUMN BARS.VOB.REP_PREFIX_FR IS '';
COMMENT ON COLUMN BARS.VOB.KOD IS '';




PROMPT *** Create  constraint CC_VOB_OVRD4IPMT ***
begin   
 execute immediate '
  ALTER TABLE BARS.VOB ADD CONSTRAINT CC_VOB_OVRD4IPMT CHECK (ovrd4ipmt in (''Y'', ''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_VOB ***
begin   
 execute immediate '
  ALTER TABLE BARS.VOB ADD CONSTRAINT PK_VOB PRIMARY KEY (VOB)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_VOB_FLV ***
begin   
 execute immediate '
  ALTER TABLE BARS.VOB ADD CONSTRAINT CC_VOB_FLV CHECK (flv in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_VOB_VOB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.VOB MODIFY (VOB CONSTRAINT CC_VOB_VOB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_VOB_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.VOB MODIFY (NAME CONSTRAINT CC_VOB_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_VOB_FLV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.VOB MODIFY (FLV CONSTRAINT CC_VOB_FLV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_VOB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_VOB ON BARS.VOB (VOB) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  VOB ***
grant DELETE,INSERT,SELECT,UPDATE                                            on VOB             to ABS_ADMIN;
grant SELECT                                                                 on VOB             to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on VOB             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VOB             to BARS_DM;
grant ALTER,DEBUG,DELETE,FLASHBACK,INDEX,INSERT,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on VOB             to FINMON;
grant SELECT                                                                 on VOB             to FINMON01;
grant SELECT                                                                 on VOB             to KLBX;
grant SELECT                                                                 on VOB             to START1;
grant UPDATE                                                                 on VOB             to TECH005;
grant SELECT                                                                 on VOB             to UPLD;
grant DELETE,INSERT,SELECT,UPDATE                                            on VOB             to VOB;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on VOB             to WR_ALL_RIGHTS;
grant SELECT                                                                 on VOB             to WR_DOCVIEW;
grant SELECT                                                                 on VOB             to WR_DOC_INPUT;
grant FLASHBACK,SELECT                                                       on VOB             to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VOB.sql =========*** End *** =========
PROMPT ===================================================================================== 
