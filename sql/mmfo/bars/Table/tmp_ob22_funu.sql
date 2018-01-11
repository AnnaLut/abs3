

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OB22_FUNU.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OB22_FUNU ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OB22_FUNU ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_OB22_FUNU 
   (	PRIZN CHAR(1), 
	PRIZN_D CHAR(1), 
	ACCD NUMBER, 
	NLSN_D VARCHAR2(15), 
	OB22_D VARCHAR2(2), 
	PRIZN_K CHAR(1), 
	ACCK NUMBER, 
	NLSN_K VARCHAR2(15), 
	OB22_K VARCHAR2(2), 
	FDAT DATE, 
	REF NUMBER, 
	NLSD VARCHAR2(15), 
	NLSK VARCHAR2(15), 
	S NUMBER, 
	NAZN VARCHAR2(160), 
	NMSN VARCHAR2(70), 
	VOB NUMBER, 
	VDAT DATE, 
	STMT NUMBER, 
	OTM NUMBER(*,0), 
	TT CHAR(3), 
	P080_D VARCHAR2(4), 
	P080_K VARCHAR2(4)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OB22_FUNU ***
 exec bpa.alter_policies('TMP_OB22_FUNU');


COMMENT ON TABLE BARS.TMP_OB22_FUNU IS '';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.PRIZN IS 'Ознака обов язковост_ загальна';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.PRIZN_D IS 'Ознака обов язковост_ ДТ';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.ACCD IS 'ID рахунка ПО ДТ';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.NLSN_D IS 'Рахунок ПО ДТ';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.OB22_D IS 'ОБ22 ДТ';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.PRIZN_K IS 'Ознака обов язковост_ КТ';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.ACCK IS 'ID рахунка ПО КТ';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.NLSN_K IS 'Рахунок ПО КТ';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.OB22_K IS 'ОБ22 КТ';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.FDAT IS 'Дата сплати';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.REF IS 'Рефернес';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.NLSD IS 'Рахунок ФО ДТ';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.NLSK IS 'Рахунок ФО КТ';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.S IS 'Сума';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.NAZN IS 'Призначення платежу';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.NMSN IS 'Назва показника';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.VOB IS 'Вид документа';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.VDAT IS 'Дата валютування (по Oper)';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.STMT IS 'Ид проводки';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.OTM IS 'В_дм_тка обробки';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.TT IS 'Код операц_ї';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.P080_D IS '';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.P080_K IS '';




PROMPT *** Create  index UK_TMP_OB22_FUNU ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_TMP_OB22_FUNU ON BARS.TMP_OB22_FUNU (REF, STMT) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_OB22_FUNU ***
grant SELECT                                                                 on TMP_OB22_FUNU   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_OB22_FUNU   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_OB22_FUNU   to NALOG;
grant SELECT                                                                 on TMP_OB22_FUNU   to UPLD;



PROMPT *** Create SYNONYM  to TMP_OB22_FUNU ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_OB22_FUNU FOR BARS.TMP_OB22_FUNU;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OB22_FUNU.sql =========*** End ***
PROMPT ===================================================================================== 
