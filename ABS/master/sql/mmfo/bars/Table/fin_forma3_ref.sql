

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_FORMA3_REF.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_FORMA3_REF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_FORMA3_REF'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_FORMA3_REF'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_FORMA3_REF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_FORMA3_REF ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_FORMA3_REF 
   (	ID NUMBER, 
		IDF VARCHAR2(1), 
		KOD VARCHAR2(4), 
		ORD NUMBER, 
		NAME VARCHAR2(254), 
		TYPE_ROW VARCHAR2(2), 
		COL3 VARCHAR2(1), 
		COL4 VARCHAR2(1), 
		SQL_TEXT3 VARCHAR2(512), 
		SQL_TEXT4 VARCHAR2(512), 
		FM VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_FORMA3_REF ***
 exec bpa.alter_policies('FIN_FORMA3_REF');


COMMENT ON TABLE BARS.FIN_FORMA3_REF IS 'Довідник для форми3';
COMMENT ON COLUMN BARS.FIN_FORMA3_REF.ID IS '';
COMMENT ON COLUMN BARS.FIN_FORMA3_REF.IDF IS '3-форма3, 4 -форма3непрямий метод';
COMMENT ON COLUMN BARS.FIN_FORMA3_REF.KOD IS 'Код показника';
COMMENT ON COLUMN BARS.FIN_FORMA3_REF.ORD IS 'Сортування';
COMMENT ON COLUMN BARS.FIN_FORMA3_REF.NAME IS 'Стаття';
COMMENT ON COLUMN BARS.FIN_FORMA3_REF.TYPE_ROW IS '';
COMMENT ON COLUMN BARS.FIN_FORMA3_REF.COL3 IS 'За звітний період(Форма3) надходження(форма3 з непрямий метод) ';
COMMENT ON COLUMN BARS.FIN_FORMA3_REF.COL4 IS '                          видаток(форма3 з непрямий метод)';
COMMENT ON COLUMN BARS.FIN_FORMA3_REF.SQL_TEXT3 IS 'Формули';
COMMENT ON COLUMN BARS.FIN_FORMA3_REF.SQL_TEXT4 IS 'Формули';
COMMENT ON COLUMN BARS.FIN_FORMA3_REF.FM IS 'Тип звітності';




PROMPT *** Create  constraint XPK_FIN_FORMA3_REF ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_FORMA3_REF ADD CONSTRAINT XPK_FIN_FORMA3_REF PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FIN_FORMA3_REF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FIN_FORMA3_REF ON BARS.FIN_FORMA3_REF (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_FORMA3_REF ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_FORMA3_REF  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_FORMA3_REF  to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_FORMA3_REF.sql =========*** End **
PROMPT ===================================================================================== 
