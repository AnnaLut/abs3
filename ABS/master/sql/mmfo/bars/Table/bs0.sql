

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BS0.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BS0 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BS0'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BS0'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BS0'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BS0 ***
begin 
  execute immediate '
  CREATE TABLE BARS.BS0 
   (	ID NUMBER(38,0), 
	NAME VARCHAR2(100), 
	DSQL VARCHAR2(4000), 
	ORD NUMBER(*,0), 
	NREP NUMBER(*,0), 
	SEK NUMBER(*,0), 
	GRP NUMBER(*,0), 
	KOEF NUMBER, 
	DESCR VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BS0 ***
 exec bpa.alter_policies('BS0');


COMMENT ON TABLE BARS.BS0 IS 'Отчеты с дин.SQL-формулами';
COMMENT ON COLUMN BARS.BS0.ORD IS 'Порядок сортировки';
COMMENT ON COLUMN BARS.BS0.NREP IS 'Код формы(отчета)';
COMMENT ON COLUMN BARS.BS0.SEK IS '№ секции';
COMMENT ON COLUMN BARS.BS0.GRP IS '№ группы';
COMMENT ON COLUMN BARS.BS0.KOEF IS 'Коеффициент';
COMMENT ON COLUMN BARS.BS0.DESCR IS 'Описание алгоритма расчета показателя';
COMMENT ON COLUMN BARS.BS0.ID IS 'Код показателя';
COMMENT ON COLUMN BARS.BS0.NAME IS 'Наименование показателя';
COMMENT ON COLUMN BARS.BS0.DSQL IS 'Дин.SQL-формула показателя';




PROMPT *** Create  constraint XPK_BS0 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BS0 ADD CONSTRAINT XPK_BS0 PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008424 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BS0 MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_BS0 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_BS0 ON BARS.BS0 (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BS0 ***
grant SELECT                                                                 on BS0             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BS0             to BARS_DM;
grant SELECT                                                                 on BS0             to RPBN001;
grant SELECT                                                                 on BS0             to SALGL;



PROMPT *** Create SYNONYM  to BS0 ***

  CREATE OR REPLACE PUBLIC SYNONYM BS0 FOR BARS.BS0;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BS0.sql =========*** End *** =========
PROMPT ===================================================================================== 
