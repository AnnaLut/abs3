

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PS.sql =========*** Run *** ==========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''PS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PS ***
begin 
  execute immediate '
  CREATE TABLE BARS.PS 
   (	NBS CHAR(4), 
	XAR NUMBER(2,0), 
	PAP NUMBER(1,0) DEFAULT 3, 
	NAME VARCHAR2(175) DEFAULT ''EMPTY'', 
	CLASS NUMBER(2,0) DEFAULT 0, 
	CHKNBS NUMBER(1,0), 
	AUTO_STOP NUMBER(1,0), 
	D_CLOSE DATE, 
	SB CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PS ***
 exec bpa.alter_policies('PS');


COMMENT ON TABLE BARS.PS IS 'План счетов';
COMMENT ON COLUMN BARS.PS.NBS IS 'Балансовый счет';
COMMENT ON COLUMN BARS.PS.XAR IS 'Код характеристики';
COMMENT ON COLUMN BARS.PS.PAP IS 'Признак актива/пассива';
COMMENT ON COLUMN BARS.PS.NAME IS 'Наименование бал счета';
COMMENT ON COLUMN BARS.PS.CLASS IS 'Класс БС для Бизнес-правил
0 - внутренние счета
1 - расчетные
2 - ссудные';
COMMENT ON COLUMN BARS.PS.CHKNBS IS 'Коды запрещения:
1- запрещен для коммерческого банка
2- запрещен для НБУ';
COMMENT ON COLUMN BARS.PS.AUTO_STOP IS 'Флаг автозакрытия';
COMMENT ON COLUMN BARS.PS.D_CLOSE IS 'Дата закрытия';
COMMENT ON COLUMN BARS.PS.SB IS '';




PROMPT *** Create  constraint CC_PS_NBS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS MODIFY (NBS CONSTRAINT CC_PS_NBS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PS_PAP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS MODIFY (PAP CONSTRAINT CC_PS_PAP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS MODIFY (NAME CONSTRAINT CC_PS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PS_CLASS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS MODIFY (CLASS CONSTRAINT CC_PS_CLASS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS ADD CONSTRAINT PK_PS PRIMARY KEY (NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PS_AUTOSTOP ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS ADD CONSTRAINT CC_PS_AUTOSTOP CHECK (auto_stop in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PS_DCLOSE ***
begin   
 execute immediate '
  ALTER TABLE BARS.PS ADD CONSTRAINT CC_PS_DCLOSE CHECK (d_close = trunc(d_close)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PS ON BARS.PS (NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on PS              to ABS_ADMIN;
grant SELECT                                                                 on PS              to BARSREADER_ROLE;
grant SELECT                                                                 on PS              to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PS              to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PS              to BARS_DM;
grant SELECT                                                                 on PS              to CUST001;
grant SELECT                                                                 on PS              to DPT_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on PS              to PS;
grant SELECT                                                                 on PS              to SALGL;
grant DELETE,INSERT,SELECT,UPDATE                                            on PS              to START1;
grant SELECT                                                                 on PS              to TECH005;
grant SELECT                                                                 on PS              to UPLD;
grant SELECT                                                                 on PS              to WEB_BALANS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PS              to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on PS              to WR_REFREAD;
grant SELECT                                                                 on PS              to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PS.sql =========*** End *** ==========
PROMPT ===================================================================================== 
