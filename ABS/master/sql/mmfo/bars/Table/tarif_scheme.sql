

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TARIF_SCHEME.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TARIF_SCHEME ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TARIF_SCHEME'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TARIF_SCHEME'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''TARIF_SCHEME'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TARIF_SCHEME ***
begin 
  execute immediate '
  CREATE TABLE BARS.TARIF_SCHEME 
   (	ID NUMBER, 
	NAME VARCHAR2(100), 
	D_CLOSE DATE, 
	OPRTIME CHAR(4), 
	DOC_NOPAY NUMBER, 
	FLAG_EDIT NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TARIF_SCHEME ***
 exec bpa.alter_policies('TARIF_SCHEME');


COMMENT ON TABLE BARS.TARIF_SCHEME IS 'Пакеты тарифов';
COMMENT ON COLUMN BARS.TARIF_SCHEME.ID IS 'Код пакета';
COMMENT ON COLUMN BARS.TARIF_SCHEME.NAME IS 'Название';
COMMENT ON COLUMN BARS.TARIF_SCHEME.D_CLOSE IS '';
COMMENT ON COLUMN BARS.TARIF_SCHEME.OPRTIME IS '';
COMMENT ON COLUMN BARS.TARIF_SCHEME.DOC_NOPAY IS '';
COMMENT ON COLUMN BARS.TARIF_SCHEME.FLAG_EDIT IS 'Признак возможности редактирования тарифов в карточке счета: 0-запретить, 1-разрешить';




PROMPT *** Create  constraint PK_TARIFSCHEME ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF_SCHEME ADD CONSTRAINT PK_TARIFSCHEME PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TARIFSCHEME_FLAGEDIT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF_SCHEME ADD CONSTRAINT CC_TARIFSCHEME_FLAGEDIT_NN CHECK (flag_edit is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TARIFSCHEME_FLAGEDIT ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF_SCHEME ADD CONSTRAINT CC_TARIFSCHEME_FLAGEDIT CHECK (flag_edit in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TARIFSCHEME_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF_SCHEME MODIFY (ID CONSTRAINT CC_TARIFSCHEME_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TARIFSCHEME ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TARIFSCHEME ON BARS.TARIF_SCHEME (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TARIF_SCHEME ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TARIF_SCHEME    to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TARIF_SCHEME    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TARIF_SCHEME    to BARS_DM;
grant SELECT                                                                 on TARIF_SCHEME    to START1;
grant FLASHBACK,SELECT                                                       on TARIF_SCHEME    to WR_REFREAD;



PROMPT *** Create SYNONYM  to TARIF_SCHEME ***

  CREATE OR REPLACE PUBLIC SYNONYM TARIF_SCHEME FOR BARS.TARIF_SCHEME;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TARIF_SCHEME.sql =========*** End *** 
PROMPT ===================================================================================== 
