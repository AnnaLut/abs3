

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_PAWN23ADD.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_PAWN23ADD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_PAWN23ADD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_PAWN23ADD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CC_PAWN23ADD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_PAWN23ADD ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_PAWN23ADD 
   (	PAWN NUMBER, 
	DAY_IMP NUMBER, 
	SUM_IMP NUMBER, 
	PROC_IMP NUMBER, 
	EF NUMBER, 
	HCC_M NUMBER, 
	ATR NUMBER, 
	KL_351 NUMBER, 
	KPZ_351 NUMBER, 
	KL_351S NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_PAWN23ADD ***
 exec bpa.alter_policies('CC_PAWN23ADD');


COMMENT ON TABLE BARS.CC_PAWN23ADD IS 'доп.рекв по обеспечению для НБУ-23 ';
COMMENT ON COLUMN BARS.CC_PAWN23ADD.KL_351 IS 'Коефіцієнт ліквідності згідно пост.№351';
COMMENT ON COLUMN BARS.CC_PAWN23ADD.KPZ_351 IS 'Мінімальний коефіцієнт покриття боргу забезпеченням';
COMMENT ON COLUMN BARS.CC_PAWN23ADD.KL_351S IS 'Коефіцієнт ліквідності згідно пост.№351';
COMMENT ON COLUMN BARS.CC_PAWN23ADD.PAWN IS '';
COMMENT ON COLUMN BARS.CC_PAWN23ADD.DAY_IMP IS 'ПЛАНОВОЕ КОЛИЧЕСТВО ДНЕЙ   ДЛЯ РЕАЛИЗАЦИИ ЗАЛОГА ЭТОГО ВИДА';
COMMENT ON COLUMN BARS.CC_PAWN23ADD.SUM_IMP IS 'ПЛАНОВые накладные расходы в коп ДЛЯ РЕАЛИЗАЦИИ ЗАЛОГА ЭТОГО ВИДА';
COMMENT ON COLUMN BARS.CC_PAWN23ADD.PROC_IMP IS 'Сума реализации Залога %';
COMMENT ON COLUMN BARS.CC_PAWN23ADD.EF IS 'Фактор ефективності реалізації майна';
COMMENT ON COLUMN BARS.CC_PAWN23ADD.HCC_M IS 'Мультиплікативний фактор ризику';
COMMENT ON COLUMN BARS.CC_PAWN23ADD.ATR IS 'Середній строк реалізації забезпечення, дні';




PROMPT *** Create  constraint PK_CC_PAWN23ADD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_PAWN23ADD ADD CONSTRAINT PK_CC_PAWN23ADD PRIMARY KEY (PAWN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CC_PAWN23ADD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CC_PAWN23ADD ON BARS.CC_PAWN23ADD (PAWN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_PAWN23ADD ***
grant SELECT                                                                 on CC_PAWN23ADD    to BARSUPL;
grant SELECT                                                                 on CC_PAWN23ADD    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_PAWN23ADD    to BARS_DM;
grant SELECT                                                                 on CC_PAWN23ADD    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_PAWN23ADD.sql =========*** End *** 
PROMPT ===================================================================================== 
