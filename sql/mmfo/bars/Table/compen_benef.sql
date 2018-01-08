

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/COMPEN_BENEF.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to COMPEN_BENEF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''COMPEN_BENEF'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''COMPEN_BENEF'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''COMPEN_BENEF'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table COMPEN_BENEF ***
begin 
  execute immediate '
  CREATE TABLE BARS.COMPEN_BENEF 
   (	ID_COMPEN NUMBER(14,0), 
	IDB NUMBER(*,0), 
	CODE CHAR(1), 
	FIOB VARCHAR2(256), 
	COUNTRYB NUMBER(*,0) DEFAULT 804, 
	FULLADDRESSB VARCHAR2(999), 
	ICODB VARCHAR2(128), 
	DOCTYPEB NUMBER(*,0) DEFAULT 1, 
	DOCSERIALB VARCHAR2(16), 
	DOCNUMBERB VARCHAR2(32), 
	DOCORGB VARCHAR2(256), 
	DOCDATEB DATE, 
	CLIENTBDATEB DATE, 
	CLIENTSEXB CHAR(1) DEFAULT ''0'', 
	CLIENTPHONEB VARCHAR2(128)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to COMPEN_BENEF ***
 exec bpa.alter_policies('COMPEN_BENEF');


COMMENT ON TABLE BARS.COMPEN_BENEF IS 'Бенефіціари';
COMMENT ON COLUMN BARS.COMPEN_BENEF.ID_COMPEN IS 'm_f_o_00000000 (ASVO_COMPEN.ID)';
COMMENT ON COLUMN BARS.COMPEN_BENEF.IDB IS 'PK';
COMMENT ON COLUMN BARS.COMPEN_BENEF.CODE IS 'Код бенефіціара (N-спадкоємець,D-довір.особа)';
COMMENT ON COLUMN BARS.COMPEN_BENEF.FIOB IS 'ПІБ';
COMMENT ON COLUMN BARS.COMPEN_BENEF.COUNTRYB IS 'Код країни';
COMMENT ON COLUMN BARS.COMPEN_BENEF.FULLADDRESSB IS 'Адреса';
COMMENT ON COLUMN BARS.COMPEN_BENEF.ICODB IS 'Код ОКПО';
COMMENT ON COLUMN BARS.COMPEN_BENEF.DOCTYPEB IS 'Вид документу';
COMMENT ON COLUMN BARS.COMPEN_BENEF.DOCSERIALB IS 'Серія документу';
COMMENT ON COLUMN BARS.COMPEN_BENEF.DOCNUMBERB IS 'Номер документу';
COMMENT ON COLUMN BARS.COMPEN_BENEF.DOCORGB IS 'Орган, що видав документ';
COMMENT ON COLUMN BARS.COMPEN_BENEF.DOCDATEB IS 'Дата видачі документу';
COMMENT ON COLUMN BARS.COMPEN_BENEF.CLIENTBDATEB IS 'Дата народження';
COMMENT ON COLUMN BARS.COMPEN_BENEF.CLIENTSEXB IS 'Стать';
COMMENT ON COLUMN BARS.COMPEN_BENEF.CLIENTPHONEB IS 'Телефон';




PROMPT *** Create  constraint FK_COMPEN_BENEF_PORTFOLIO ***
begin   
 execute immediate '
  ALTER TABLE BARS.COMPEN_BENEF ADD CONSTRAINT FK_COMPEN_BENEF_PORTFOLIO FOREIGN KEY (ID_COMPEN)
	  REFERENCES BARS.COMPEN_PORTFOLIO (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_COMPEN_BENEF ***
begin   
 execute immediate '
  ALTER TABLE BARS.COMPEN_BENEF ADD CONSTRAINT PK_COMPEN_BENEF PRIMARY KEY (IDB)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_COMPEN_BENEF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_COMPEN_BENEF ON BARS.COMPEN_BENEF (IDB) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  COMPEN_BENEF ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on COMPEN_BENEF    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on COMPEN_BENEF    to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on COMPEN_BENEF    to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on COMPEN_BENEF    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/COMPEN_BENEF.sql =========*** End *** 
PROMPT ===================================================================================== 
