

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_SVK.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_SVK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_SVK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_SVK'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_SVK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_SVK ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_SVK 
   (	ID NUMBER(*,0), 
	SFILE CHAR(12), 
	NAME VARCHAR2(75), 
	KOM1 NUMBER, 
	INSU_PAW NUMBER, 
	INSU_CCK NUMBER, 
	INSU_TIT NUMBER, 
	SUM_NOTE NUMBER, 
	SUM_REES NUMBER, 
	PRC_MITO NUMBER, 
	SUM_BTI NUMBER, 
	KOMRK NUMBER, 
	PRC_PF NUMBER, 
	INSU_CV NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_SVK ***
 exec bpa.alter_policies('CC_SVK');


COMMENT ON TABLE BARS.CC_SVK IS 'Шаблони для звiту "Сукупна вартiсть кредиту"';
COMMENT ON COLUMN BARS.CC_SVK.ID IS '№ пп';
COMMENT ON COLUMN BARS.CC_SVK.SFILE IS 'Файл-шаблон';
COMMENT ON COLUMN BARS.CC_SVK.NAME IS 'Назва-коментар';
COMMENT ON COLUMN BARS.CC_SVK.KOM1 IS '% разової комiсiї';
COMMENT ON COLUMN BARS.CC_SVK.INSU_PAW IS '% пл.по страхуванню забезпечення';
COMMENT ON COLUMN BARS.CC_SVK.INSU_CCK IS '% пл.по страхуванню зайомщика';
COMMENT ON COLUMN BARS.CC_SVK.INSU_TIT IS '% пл.по страхуванню титулу';
COMMENT ON COLUMN BARS.CC_SVK.SUM_NOTE IS 'Послуги (сума) нотариуса';
COMMENT ON COLUMN BARS.CC_SVK.SUM_REES IS 'Послуги (сума) реестратора';
COMMENT ON COLUMN BARS.CC_SVK.PRC_MITO IS 'державне мито';
COMMENT ON COLUMN BARS.CC_SVK.SUM_BTI IS 'послуги БТI(МРЕО)';
COMMENT ON COLUMN BARS.CC_SVK.KOMRK IS '% розра-кас.обслуг.';
COMMENT ON COLUMN BARS.CC_SVK.PRC_PF IS '% в Пенс.фонд';
COMMENT ON COLUMN BARS.CC_SVK.INSU_CV IS 'Сума пл.по страхуванню цив.вiдпов.';




PROMPT *** Create  constraint XPK_CC_SVK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SVK ADD CONSTRAINT XPK_CC_SVK PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CC_SVK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CC_SVK ON BARS.CC_SVK (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_SVK ***
grant SELECT                                                                 on CC_SVK          to BARSREADER_ROLE;
grant SELECT                                                                 on CC_SVK          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_SVK          to BARS_DM;
grant SELECT                                                                 on CC_SVK          to RCC_DEAL;
grant SELECT                                                                 on CC_SVK          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_SVK          to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to CC_SVK ***

  CREATE OR REPLACE PUBLIC SYNONYM CC_SVK FOR BARS.CC_SVK;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_SVK.sql =========*** End *** ======
PROMPT ===================================================================================== 
