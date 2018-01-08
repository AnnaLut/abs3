

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/COMPEN_MOTIONS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to COMPEN_MOTIONS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''COMPEN_MOTIONS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''COMPEN_MOTIONS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''COMPEN_MOTIONS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table COMPEN_MOTIONS ***
begin 
  execute immediate '
  CREATE TABLE BARS.COMPEN_MOTIONS 
   (	ID_COMPEN NUMBER(14,0), 
	IDM NUMBER(*,0), 
	SUMOP NUMBER, 
	OST NUMBER, 
	ZPR NUMBER, 
	DATP DATE, 
	PREA VARCHAR2(6), 
	OI VARCHAR2(4), 
	OL VARCHAR2(4), 
	DK NUMBER(*,0), 
	DATL DATE, 
	TYPO VARCHAR2(2), 
	MARK VARCHAR2(1), 
	VER NUMBER(4,0), 
	STAT VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to COMPEN_MOTIONS ***
 exec bpa.alter_policies('COMPEN_MOTIONS');


COMMENT ON TABLE BARS.COMPEN_MOTIONS IS 'Архів операцiй по рахунках';
COMMENT ON COLUMN BARS.COMPEN_MOTIONS.ID_COMPEN IS 'm_f_o_00000000 (ASVO_COMPEN.ID)';
COMMENT ON COLUMN BARS.COMPEN_MOTIONS.IDM IS 'PK';
COMMENT ON COLUMN BARS.COMPEN_MOTIONS.SUMOP IS 'Сума операції';
COMMENT ON COLUMN BARS.COMPEN_MOTIONS.OST IS 'Залишок пiсля операцiї';
COMMENT ON COLUMN BARS.COMPEN_MOTIONS.ZPR IS 'Залишок процентiв пiсля операцiї';
COMMENT ON COLUMN BARS.COMPEN_MOTIONS.DATP IS 'Дата нарахування процентiв операцiї';
COMMENT ON COLUMN BARS.COMPEN_MOTIONS.PREA IS 'Стан рахунку до операцiї';
COMMENT ON COLUMN BARS.COMPEN_MOTIONS.OI IS 'Номер операцiї в межах операцiйної дати';
COMMENT ON COLUMN BARS.COMPEN_MOTIONS.OL IS 'Номер пов'язаної операцiї';
COMMENT ON COLUMN BARS.COMPEN_MOTIONS.DK IS 'DK';
COMMENT ON COLUMN BARS.COMPEN_MOTIONS.DATL IS 'Дата операцiї';
COMMENT ON COLUMN BARS.COMPEN_MOTIONS.TYPO IS 'Тип операцiї';
COMMENT ON COLUMN BARS.COMPEN_MOTIONS.MARK IS 'Символ облiку в межах картотеки';
COMMENT ON COLUMN BARS.COMPEN_MOTIONS.VER IS 'Версiя рахунку';
COMMENT ON COLUMN BARS.COMPEN_MOTIONS.STAT IS 'Стан операцiї';




PROMPT *** Create  constraint FK_COMPEN_MOTIONS_PORTFOLIO ***
begin   
 execute immediate '
  ALTER TABLE BARS.COMPEN_MOTIONS ADD CONSTRAINT FK_COMPEN_MOTIONS_PORTFOLIO FOREIGN KEY (ID_COMPEN)
	  REFERENCES BARS.COMPEN_PORTFOLIO (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_COMPEN_MOTIONS ***
begin   
 execute immediate '
  ALTER TABLE BARS.COMPEN_MOTIONS ADD CONSTRAINT PK_COMPEN_MOTIONS PRIMARY KEY (IDM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_COMPEN_MOTIONS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_COMPEN_MOTIONS ON BARS.COMPEN_MOTIONS (IDM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  COMPEN_MOTIONS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on COMPEN_MOTIONS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on COMPEN_MOTIONS  to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on COMPEN_MOTIONS  to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on COMPEN_MOTIONS  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/COMPEN_MOTIONS.sql =========*** End **
PROMPT ===================================================================================== 
