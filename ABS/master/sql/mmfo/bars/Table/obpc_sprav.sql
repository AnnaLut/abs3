

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OBPC_SPRAV.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OBPC_SPRAV ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OBPC_SPRAV'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OBPC_SPRAV'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OBPC_SPRAV'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OBPC_SPRAV ***
begin 
  execute immediate '
  CREATE TABLE BARS.OBPC_SPRAV 
   (	NUM_CONV NUMBER(38,0), 
	VID_Z NUMBER(38,0), 
	VID_S NUMBER(38,0), 
	FIO VARCHAR2(40), 
	ACC_SBON VARCHAR2(19), 
	ACC_CARD VARCHAR2(10), 
	ACC_BAL VARCHAR2(25)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OBPC_SPRAV ***
 exec bpa.alter_policies('OBPC_SPRAV');


COMMENT ON TABLE BARS.OBPC_SPRAV IS 'ЛЗ: АКТИВНЫЙ справочник клиентов-счетов (SPRAV.TXT)';
COMMENT ON COLUMN BARS.OBPC_SPRAV.NUM_CONV IS '№ конверта';
COMMENT ON COLUMN BARS.OBPC_SPRAV.VID_Z IS 'Вид~зачисления';
COMMENT ON COLUMN BARS.OBPC_SPRAV.VID_S IS 'Вид~системы';
COMMENT ON COLUMN BARS.OBPC_SPRAV.FIO IS 'Ф.И.О.';
COMMENT ON COLUMN BARS.OBPC_SPRAV.ACC_SBON IS 'Счет~СБОН';
COMMENT ON COLUMN BARS.OBPC_SPRAV.ACC_CARD IS 'Тех.карт~счет';
COMMENT ON COLUMN BARS.OBPC_SPRAV.ACC_BAL IS 'Бал~счет';




PROMPT *** Create  constraint XPK_OBPC_SPRAV ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_SPRAV ADD CONSTRAINT XPK_OBPC_SPRAV PRIMARY KEY (NUM_CONV, VID_Z)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OBPCSPRAV_NUMCONV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_SPRAV MODIFY (NUM_CONV CONSTRAINT CC_OBPCSPRAV_NUMCONV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_OBPCSPRAV_ACCBAL ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_OBPCSPRAV_ACCBAL ON BARS.OBPC_SPRAV (ACC_BAL) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_OBPC_SPRAV ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_OBPC_SPRAV ON BARS.OBPC_SPRAV (NUM_CONV, VID_Z) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OBPC_SPRAV ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OBPC_SPRAV      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OBPC_SPRAV      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_SPRAV      to OBPC;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_SPRAV      to OBPC_SPRAV;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OBPC_SPRAV      to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on OBPC_SPRAV      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OBPC_SPRAV.sql =========*** End *** ==
PROMPT ===================================================================================== 
