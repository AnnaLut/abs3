

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NU_OB22_FUNU.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NU_OB22_FUNU ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NU_OB22_FUNU'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NU_OB22_FUNU'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NU_OB22_FUNU ***
begin 
  execute immediate '
  CREATE TABLE BARS.NU_OB22_FUNU 
   (	ID_USER NUMBER, 
	PRIZN CHAR(1), 
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
	VOB NUMBER, 
	VDAT DATE, 
	STMT NUMBER, 
	OTM NUMBER(*,0), 
	TT CHAR(3), 
	KSN_D VARCHAR2(15), 
	KSN_K VARCHAR2(15), 
	NMSN_D VARCHAR2(70), 
	NMSN_K VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NU_OB22_FUNU ***
 exec bpa.alter_policies('NU_OB22_FUNU');


COMMENT ON TABLE BARS.NU_OB22_FUNU IS '';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.ID_USER IS '';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.PRIZN IS 'Ознака обов язковост_ загальна';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.PRIZN_D IS 'Ознака обов язковост_ ДТ';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.ACCD IS 'ID рахунка ПО ДТ';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.NLSN_D IS 'Рахунок ПО ДТ';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.OB22_D IS 'ОБ22 ДТ';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.PRIZN_K IS 'Ознака обов язковост_ КТ';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.ACCK IS 'ID рахунка ПО КТ';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.NLSN_K IS 'Рахунок ПО КТ';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.OB22_K IS 'ОБ22 КТ';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.FDAT IS 'Дата сплати';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.REF IS 'Рефернес';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.NLSD IS 'Рахунок ФО ДТ';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.NLSK IS 'Рахунок ФО КТ';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.S IS 'Сума';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.NAZN IS 'Призначення платежу';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.VOB IS 'Вид документа';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.VDAT IS 'Дата валютування (по Oper)';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.STMT IS 'Ид проводки';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.OTM IS 'В_дм_тка обробки';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.TT IS 'Код операц_ї';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.KSN_D IS '';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.KSN_K IS '';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.NMSN_D IS '';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.NMSN_K IS '';




PROMPT *** Create  index UK_NU_OB22_FUNU ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_NU_OB22_FUNU ON BARS.NU_OB22_FUNU (ID_USER, REF, STMT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NU_OB22_FUNU ***
grant DELETE,INSERT,SELECT,UPDATE                                            on NU_OB22_FUNU    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on NU_OB22_FUNU    to NALOG;



PROMPT *** Create SYNONYM  to NU_OB22_FUNU ***

  CREATE OR REPLACE PUBLIC SYNONYM NU_OB22_FUNU FOR BARS.NU_OB22_FUNU;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NU_OB22_FUNU.sql =========*** End *** 
PROMPT ===================================================================================== 
