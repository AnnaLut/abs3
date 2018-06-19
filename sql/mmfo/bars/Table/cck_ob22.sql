

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_OB22.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_OB22 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CCK_OB22'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CCK_OB22'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_OB22 ***
begin 
  execute immediate '
  CREATE TABLE BARS.CCK_OB22 
   (	NBS CHAR(4), 
	OB22 CHAR(2), 
	SPI CHAR(2), 
	SDI CHAR(2), 
	SP CHAR(2), 
	SN CHAR(2), 
	SPN CHAR(2), 
	SLN CHAR(2), 
	SD_N CHAR(2), 
	SD_I CHAR(2), 
	SD_M CHAR(2), 
	SD_J CHAR(2), 
	S903 CHAR(2), 
	S950 VARCHAR2(8), 
	S952 CHAR(2), 
	CR9 CHAR(2), 
	ACCREZ CHAR(4), 
	SREZ CHAR(2), 
	ACC77 CHAR(4), 
	S77 CHAR(2), 
	ACC77R CHAR(4), 
	S77R CHAR(2), 
	S9N VARCHAR2(8), 
	SL VARCHAR2(8), 
	S9601 VARCHAR2(8), 
	S9611 VARCHAR2(8), 
	CRD VARCHAR2(8), 
	SG CHAR(2), 
	SK0 CHAR(2), 
	SK9 CHAR(2), 
	SPN_31 CHAR(2), 
	SPN_61 CHAR(2), 
	SPN_181 CHAR(2), 
	SK9_31 CHAR(2), 
	SK9_61 CHAR(2), 
	SK9_181 CHAR(2), 
	SLK CHAR(2), 
	SD_9129 CHAR(2), 
	SD_SK0 CHAR(2), 
	SD_SK4 CHAR(2), 
	S260 CHAR(2), 
	ISG CHAR(2), 
	S36 CHAR(2), 
	SD8 CHAR(2), 
	PSTART VARCHAR2(50), 
	PFINIS VARCHAR2(50), 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_OB22 ***
 exec bpa.alter_policies('CCK_OB22');


COMMENT ON TABLE BARS.CCK_OB22 IS 'Связи через ОБ22 в КП';
COMMENT ON COLUMN BARS.CCK_OB22.D_CLOSE IS 'Дата закриття продукту';
COMMENT ON COLUMN BARS.CCK_OB22.NBS IS 'БС  ~тела~кр';
COMMENT ON COLUMN BARS.CCK_OB22.OB22 IS 'ob22~тела~кр';
COMMENT ON COLUMN BARS.CCK_OB22.SPI IS 'ob22~премии~***5';
COMMENT ON COLUMN BARS.CCK_OB22.SDI IS 'ob22~дискон~***6';
COMMENT ON COLUMN BARS.CCK_OB22.SP IS 'ob22~просрч~***7';
COMMENT ON COLUMN BARS.CCK_OB22.SN IS 'ob22~нач.% ~***8';
COMMENT ON COLUMN BARS.CCK_OB22.SPN IS 'ob22~прсрч%~***9';
COMMENT ON COLUMN BARS.CCK_OB22.SLN IS 'ob22~сомн.%~***?';
COMMENT ON COLUMN BARS.CCK_OB22.SD_N IS 'ob22~% от н~6***';
COMMENT ON COLUMN BARS.CCK_OB22.SD_I IS 'ob22~% от i~6***';
COMMENT ON COLUMN BARS.CCK_OB22.SD_M IS 'ob22~А от н~6***';
COMMENT ON COLUMN BARS.CCK_OB22.SD_J IS 'ob22~А от i~6***';
COMMENT ON COLUMN BARS.CCK_OB22.S903 IS 'ob22~для~903*';
COMMENT ON COLUMN BARS.CCK_OB22.S950 IS 'ob22~для~950*';
COMMENT ON COLUMN BARS.CCK_OB22.S952 IS 'ob22~для~952*';
COMMENT ON COLUMN BARS.CCK_OB22.CR9 IS 'ob22~для~9129';
COMMENT ON COLUMN BARS.CCK_OB22.ACCREZ IS '';
COMMENT ON COLUMN BARS.CCK_OB22.SREZ IS '';
COMMENT ON COLUMN BARS.CCK_OB22.ACC77 IS '';
COMMENT ON COLUMN BARS.CCK_OB22.S77 IS '';
COMMENT ON COLUMN BARS.CCK_OB22.ACC77R IS '';
COMMENT ON COLUMN BARS.CCK_OB22.S77R IS '';
COMMENT ON COLUMN BARS.CCK_OB22.S9N IS '';
COMMENT ON COLUMN BARS.CCK_OB22.SL IS '';
COMMENT ON COLUMN BARS.CCK_OB22.S9601 IS '';
COMMENT ON COLUMN BARS.CCK_OB22.S9611 IS '';
COMMENT ON COLUMN BARS.CCK_OB22.CRD IS '';
COMMENT ON COLUMN BARS.CCK_OB22.SG IS '';
COMMENT ON COLUMN BARS.CCK_OB22.SK0 IS '';
COMMENT ON COLUMN BARS.CCK_OB22.SK9 IS '';
COMMENT ON COLUMN BARS.CCK_OB22.SPN_31 IS 'ob22~SPN~прс%~>30 дн';
COMMENT ON COLUMN BARS.CCK_OB22.SPN_61 IS 'ob22~SPN~прс%~>60 дн';
COMMENT ON COLUMN BARS.CCK_OB22.SPN_181 IS 'ob22~SPN~прс%~>180 дн';
COMMENT ON COLUMN BARS.CCK_OB22.SK9_31 IS 'ob22~SK9~прсK~>30 дн';
COMMENT ON COLUMN BARS.CCK_OB22.SK9_61 IS 'ob22~SK9~прсK~>60 дн';
COMMENT ON COLUMN BARS.CCK_OB22.SK9_181 IS 'ob22~SK9~прсK~>180 дн';
COMMENT ON COLUMN BARS.CCK_OB22.SLK IS 'ob22~SLK~сомн.К';
COMMENT ON COLUMN BARS.CCK_OB22.SD_9129 IS 'OB22~ рах. доходiв ~ для комiсiї~ на 9129';
COMMENT ON COLUMN BARS.CCK_OB22.SD_SK0 IS 'OB22~ рах. доходiв ~ для щомiсячної ~комiсiї';
COMMENT ON COLUMN BARS.CCK_OB22.SD_SK4 IS '';
COMMENT ON COLUMN BARS.CCK_OB22.S260 IS '';
COMMENT ON COLUMN BARS.CCK_OB22.ISG IS 'ob22~ISG~дох майб період';
COMMENT ON COLUMN BARS.CCK_OB22.S36 IS '';
COMMENT ON COLUMN BARS.CCK_OB22.SD8 IS '';
COMMENT ON COLUMN BARS.CCK_OB22.PSTART IS 'Процедура доп.бизнес-логики. Автоматически Выполняется при авторизации или по требованию';
COMMENT ON COLUMN BARS.CCK_OB22.PFINIS IS 'Процедура доп.бизнес-логики. Автоматически Выполняется при завершении (job) КД или по требованию';




PROMPT *** Create  constraint XPK_CCKOB22 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_OB22 ADD CONSTRAINT XPK_CCKOB22 PRIMARY KEY (NBS, OB22)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CCKOB22 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CCKOB22 ON BARS.CCK_OB22 (NBS, OB22) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

begin EXECUTE IMMEDIATE 'alter table bars.cck_ob22 add ( K9 int ) ';
exception when others then   if SQLCODE = -01430 then null;   else raise; end if;   -- ORA-01430: column being added already exists in table
end;
/

COMMENT ON COLUMN BARS.CCK_OB22.K9    IS 'Числовой код по IFRS=принцип обліку по МСФЗ-9 ("корзина")';

begin EXECUTE IMMEDIATE 'alter table bars.cck_ob22 add ( KL1 int ) ';
exception when others then   if SQLCODE = -01430 then null;   else raise; end if;   -- ORA-01430: column being added already exists in table
end;
/
COMMENT ON COLUMN BARS.CCK_OB22.KL1    IS 'РЕЗЕРВНОЕ ПОЛЕ';

PROMPT *** Create  grants  CCK_OB22 ***

grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CCK_OB22        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CCK_OB22        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_OB22        to RCC_DEAL;
grant SELECT                                                                 on CCK_OB22        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CCK_OB22        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on CCK_OB22        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_OB22.sql =========*** End *** ====
PROMPT ===================================================================================== 
