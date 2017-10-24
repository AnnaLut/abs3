

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/E_TARIF.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to E_TARIF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''E_TARIF'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''E_TARIF'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''E_TARIF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table E_TARIF ***
begin 
  execute immediate '
  CREATE TABLE BARS.E_TARIF 
   (	ID NUMBER(*,0), 
	NAME VARCHAR2(120), 
	SUMT1 NUMBER, 
	SUMT NUMBER, 
	NLS6 VARCHAR2(200), 
	NDS NUMBER, 
	OB22_3570 VARCHAR2(2), 
	OB22_3579 VARCHAR2(2), 
	NPD_3570 VARCHAR2(160), 
	NPK_3570 VARCHAR2(160), 
	NPD_3579 VARCHAR2(160), 
	NPK_3579 VARCHAR2(160), 
	OB22_6110 VARCHAR2(2), 
	ID_GLOB NUMBER, 
	FL1 NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to E_TARIF ***
 exec bpa.alter_policies('E_TARIF');


COMMENT ON TABLE BARS.E_TARIF IS 'Дов_дник електроних послуг';
COMMENT ON COLUMN BARS.E_TARIF.ID IS 'Идентификатор тарифа';
COMMENT ON COLUMN BARS.E_TARIF.NAME IS 'Наименование тарифа';
COMMENT ON COLUMN BARS.E_TARIF.SUMT1 IS 'Сумма тарифа за 1 док';
COMMENT ON COLUMN BARS.E_TARIF.SUMT IS 'Общая сумма тирифа';
COMMENT ON COLUMN BARS.E_TARIF.NLS6 IS 'Формула для рах-ку 6-класу';
COMMENT ON COLUMN BARS.E_TARIF.NDS IS '';
COMMENT ON COLUMN BARS.E_TARIF.OB22_3570 IS '';
COMMENT ON COLUMN BARS.E_TARIF.OB22_3579 IS '';
COMMENT ON COLUMN BARS.E_TARIF.NPD_3570 IS '';
COMMENT ON COLUMN BARS.E_TARIF.NPK_3570 IS '';
COMMENT ON COLUMN BARS.E_TARIF.NPD_3579 IS '';
COMMENT ON COLUMN BARS.E_TARIF.NPK_3579 IS '';
COMMENT ON COLUMN BARS.E_TARIF.OB22_6110 IS 'ОБ22 для 6110';
COMMENT ON COLUMN BARS.E_TARIF.ID_GLOB IS 'Код Глоб. тарифу';
COMMENT ON COLUMN BARS.E_TARIF.FL1 IS '1 - тариф за повний м_сяць';




PROMPT *** Create  constraint NK_E_TARIF_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_TARIF MODIFY (ID CONSTRAINT NK_E_TARIF_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_E_TARIF ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_TARIF ADD CONSTRAINT XPK_E_TARIF PRIMARY KEY (KF,ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


begin
execute immediate 'alter table E_TARIF
  add constraint FK_ETARIF_KF_IDGLOB foreign key (KF, ID_GLOB)
  references TARIF (KF, KOD)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


PROMPT *** Create  grants  E_TARIF ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on E_TARIF         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on E_TARIF         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on E_TARIF         to ELT;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on E_TARIF         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on E_TARIF         to WR_REFREAD;



PROMPT *** Create SYNONYM  to E_TARIF ***

  CREATE OR REPLACE PUBLIC SYNONYM E_TARIF FOR BARS.E_TARIF;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/E_TARIF.sql =========*** End *** =====
PROMPT ===================================================================================== 
