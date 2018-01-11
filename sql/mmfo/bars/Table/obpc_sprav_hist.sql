

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OBPC_SPRAV_HIST.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OBPC_SPRAV_HIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OBPC_SPRAV_HIST'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OBPC_SPRAV_HIST'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OBPC_SPRAV_HIST'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OBPC_SPRAV_HIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.OBPC_SPRAV_HIST 
   (	INS_DATE DATE DEFAULT sysdate, 
	NUM_CONV NUMBER(38,0), 
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




PROMPT *** ALTER_POLICIES to OBPC_SPRAV_HIST ***
 exec bpa.alter_policies('OBPC_SPRAV_HIST');


COMMENT ON TABLE BARS.OBPC_SPRAV_HIST IS 'Архив справочника клиентов-счетов (SPRAV.TXT)';
COMMENT ON COLUMN BARS.OBPC_SPRAV_HIST.INS_DATE IS 'Дата архивации';
COMMENT ON COLUMN BARS.OBPC_SPRAV_HIST.NUM_CONV IS '№ конверта';
COMMENT ON COLUMN BARS.OBPC_SPRAV_HIST.VID_Z IS 'Вид~зачисления';
COMMENT ON COLUMN BARS.OBPC_SPRAV_HIST.VID_S IS 'Вид~системы';
COMMENT ON COLUMN BARS.OBPC_SPRAV_HIST.FIO IS 'Ф.И.О.';
COMMENT ON COLUMN BARS.OBPC_SPRAV_HIST.ACC_SBON IS 'Счет~СБОН';
COMMENT ON COLUMN BARS.OBPC_SPRAV_HIST.ACC_CARD IS 'Тех.карт~счет';
COMMENT ON COLUMN BARS.OBPC_SPRAV_HIST.ACC_BAL IS 'Бал~счет';




PROMPT *** Create  constraint CC_OBPCSPRAVHIST_NUMCONV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBPC_SPRAV_HIST MODIFY (NUM_CONV CONSTRAINT CC_OBPCSPRAVHIST_NUMCONV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OBPC_SPRAV_HIST ***
grant SELECT                                                                 on OBPC_SPRAV_HIST to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_SPRAV_HIST to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OBPC_SPRAV_HIST to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_SPRAV_HIST to OBPC;
grant SELECT                                                                 on OBPC_SPRAV_HIST to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OBPC_SPRAV_HIST to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OBPC_SPRAV_HIST.sql =========*** End *
PROMPT ===================================================================================== 
