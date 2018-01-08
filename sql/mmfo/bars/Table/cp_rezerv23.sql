

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_REZERV23.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_REZERV23 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_REZERV23'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_REZERV23'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_REZERV23'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_REZERV23 ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_REZERV23 
   (	ID NUMBER(*,0), 
	REF NUMBER, 
	DATE_REPORT DATE, 
	S_REZERV23 NUMBER, 
	CP_COUNT NUMBER(*,0), 
	PEREOC23 NUMBER, 
	FL_ALG23 NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_REZERV23 ***
 exec bpa.alter_policies('CP_REZERV23');


COMMENT ON TABLE BARS.CP_REZERV23 IS 'Отчет по уровням иерархии в разрезе кодов ЦП';
COMMENT ON COLUMN BARS.CP_REZERV23.ID IS 'ID ЦП';
COMMENT ON COLUMN BARS.CP_REZERV23.REF IS 'REF сделки';
COMMENT ON COLUMN BARS.CP_REZERV23.DATE_REPORT IS 'Отчетная дата для резерва23';
COMMENT ON COLUMN BARS.CP_REZERV23.S_REZERV23 IS 'Сумма для резерва23';
COMMENT ON COLUMN BARS.CP_REZERV23.CP_COUNT IS 'Количество штук в пакете';
COMMENT ON COLUMN BARS.CP_REZERV23.PEREOC23 IS 'Сумма переоценки';
COMMENT ON COLUMN BARS.CP_REZERV23.FL_ALG23 IS 'Алгоритм переоценки по 23 постанове';




PROMPT *** Create  constraint PK_CP_REZERV23 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_REZERV23 ADD CONSTRAINT PK_CP_REZERV23 PRIMARY KEY (REF, DATE_REPORT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006169 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_REZERV23 MODIFY (DATE_REPORT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CP_REZERV23 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CP_REZERV23 ON BARS.CP_REZERV23 (REF, DATE_REPORT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_REZERV23 ***
grant SELECT                                                                 on CP_REZERV23     to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CP_REZERV23     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_REZERV23     to BARS_DM;
grant SELECT                                                                 on CP_REZERV23     to UPLD;
grant FLASHBACK,SELECT                                                       on CP_REZERV23     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_REZERV23.sql =========*** End *** =
PROMPT ===================================================================================== 
