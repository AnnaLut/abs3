

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BS1.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BS1 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BS1'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BS1'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BS1'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BS1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.BS1 
   (	PU NUMBER(*,0), 
	KOD VARCHAR2(10), 
	ID NUMBER(38,0), 
	NAME VARCHAR2(111), 
	ORD NUMBER(38,0), 
	SSQL VARCHAR2(4000), 
	FORM VARCHAR2(4000), 
	IDZ NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BS1 ***
 exec bpa.alter_policies('BS1');


COMMENT ON TABLE BARS.BS1 IS 'Баланс в структурi показникiв ОБ';
COMMENT ON COLUMN BARS.BS1.PU IS 'Признак пок. (-1,1,2,0)';
COMMENT ON COLUMN BARS.BS1.KOD IS 'XLS-код показателя';
COMMENT ON COLUMN BARS.BS1.ID IS 'Вн.код пок (на нач.этапе=№ строки в XLS-табл)';
COMMENT ON COLUMN BARS.BS1.NAME IS 'Назва пок';
COMMENT ON COLUMN BARS.BS1.ORD IS 'Порядок сортировки(на нач.этапе=ID)';
COMMENT ON COLUMN BARS.BS1.SSQL IS '"Оригинальная" формула из XLS';
COMMENT ON COLUMN BARS.BS1.FORM IS 'Транслированная SQL-формула';
COMMENT ON COLUMN BARS.BS1.IDZ IS '';




PROMPT *** Create  constraint PK_BS1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BS1 ADD CONSTRAINT PK_BS1 PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_BS1_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.BS1 MODIFY (ID CONSTRAINT NK_BS1_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BS1 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BS1 ON BARS.BS1 (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BS1 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BS1             to ABS_ADMIN;
grant SELECT                                                                 on BS1             to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BS1             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BS1             to BARS_DM;
grant SELECT,UPDATE                                                          on BS1             to SALGL;
grant SELECT                                                                 on BS1             to UPLD;
grant FLASHBACK,SELECT                                                       on BS1             to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BS1.sql =========*** End *** =========
PROMPT ===================================================================================== 
