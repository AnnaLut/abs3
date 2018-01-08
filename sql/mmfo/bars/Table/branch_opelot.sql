

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BRANCH_OPELOT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BRANCH_OPELOT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BRANCH_OPELOT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BRANCH_OPELOT'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''BRANCH_OPELOT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BRANCH_OPELOT ***
begin 
  execute immediate '
  CREATE TABLE BARS.BRANCH_OPELOT 
   (	BRANCH VARCHAR2(15), 
	OB22 CHAR(2), 
	NAME VARCHAR2(25), 
	PR1 NUMBER(6,4), 
	BS1 CHAR(4), 
	OB1 CHAR(2), 
	PR2 NUMBER(6,4), 
	BS2 CHAR(4), 
	OB2 CHAR(2), 
	PR3 NUMBER(6,4), 
	BS3 CHAR(4), 
	OB3 CHAR(2), 
	MFO VARCHAR2(6), 
	NLS VARCHAR2(14), 
	OKPO VARCHAR2(8), 
	NAZN1 VARCHAR2(160), 
	NAZN2 VARCHAR2(160), 
	DATP DATE, 
	REZ_OB22 CHAR(2), 
	REZ_SUM NUMBER(10,2), 
	PRZ NUMBER(*,0), 
	REF1 NUMBER(*,0), 
	REF2 NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BRANCH_OPELOT ***
 exec bpa.alter_policies('BRANCH_OPELOT');


COMMENT ON TABLE BARS.BRANCH_OPELOT IS 'Розрахунки з фiлiями операторiв лотерей';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.REF1 IS 'Реф.перерахування оператору';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.REF2 IS '';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.BRANCH IS 'Бранч ОБ';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.OB22 IS 'Код Оператора~ОБ22';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.NAME IS 'Назва~фiлiї~Оператора';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.PR1 IS 'Сума 1~%';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.BS1 IS 'Сума 1~Бал.рах';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.OB1 IS 'Сума 1~ОБ22';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.PR2 IS 'Сума 2~%';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.BS2 IS 'Сума 2~Бал.рах';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.OB2 IS 'Сума 2~ОБ22';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.PR3 IS 'Сума 3~%';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.BS3 IS 'Сума 3~Бал.рах';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.OB3 IS 'Сума 3~ОБ22';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.MFO IS 'МФО банку~фiлiї~Оператора';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.NLS IS 'Рахунок~фiлiї~Оператора';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.OKPO IS 'Iд.код~фiлiї~Оператора';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.NAZN1 IS 'Призначення пл. для док-1(розщепдення)';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.NAZN2 IS 'Призначення пл. для док-2(перерахування коштiв)';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.DATP IS 'Дата попереднього розрахунку';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.REZ_OB22 IS 'об22 для 2905 по несниж.остатку';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.REZ_SUM IS 'сумма несниж.остаткa';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.PRZ IS 'Признак закриття сальдо рах(0- по сист.дням, 1 - по банк)';



PROMPT *** Create  grants  BRANCH_OPELOT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BRANCH_OPELOT   to ABS_ADMIN;
grant SELECT                                                                 on BRANCH_OPELOT   to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BRANCH_OPELOT   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BRANCH_OPELOT   to BARS_DM;
grant SELECT,UPDATE                                                          on BRANCH_OPELOT   to PYOD001;
grant SELECT                                                                 on BRANCH_OPELOT   to UPLD;
grant FLASHBACK,SELECT                                                       on BRANCH_OPELOT   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BRANCH_OPELOT.sql =========*** End ***
PROMPT ===================================================================================== 
