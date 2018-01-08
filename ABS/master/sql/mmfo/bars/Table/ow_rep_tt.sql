

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OW_REP_TT.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OW_REP_TT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OW_REP_TT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OW_REP_TT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OW_REP_TT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OW_REP_TT ***
begin 
  execute immediate '
  CREATE TABLE BARS.OW_REP_TT 
   (	TT CHAR(3), 
	NAZN VARCHAR2(160)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OW_REP_TT ***
 exec bpa.alter_policies('OW_REP_TT');


COMMENT ON TABLE BARS.OW_REP_TT IS 'Таблица операций и назначений платежа для отчета в ПФ';
COMMENT ON COLUMN BARS.OW_REP_TT.TT IS 'Операция';
COMMENT ON COLUMN BARS.OW_REP_TT.NAZN IS 'Назначение платежа';




PROMPT *** Create  constraint CC_OWREPTT_TT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_REP_TT MODIFY (TT CONSTRAINT CC_OWREPTT_TT_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OWREPTT_NAZN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OW_REP_TT MODIFY (NAZN CONSTRAINT CC_OWREPTT_NAZN_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OW_REP_TT ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OW_REP_TT       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OW_REP_TT       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OW_REP_TT       to OW;
grant SELECT                                                                 on OW_REP_TT       to RPBN001;
grant FLASHBACK,SELECT                                                       on OW_REP_TT       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OW_REP_TT.sql =========*** End *** ===
PROMPT ===================================================================================== 
