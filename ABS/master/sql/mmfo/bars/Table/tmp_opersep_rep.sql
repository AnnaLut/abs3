

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/tmp_opersep_rep.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to tmp_opersep_rep ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''tmp_opersep_rep'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''tmp_opersep_rep'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''tmp_opersep_rep'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table tmp_opersep_rep ***
begin 
 execute immediate '
create table TMP_OPERSEP_REP
(
  ref  NUMBER(38) not null,
  s    NUMBER(24),
  nlsa VARCHAR2(15),
  nd   VARCHAR2(10),
  pdat DATE,
  nazn VARCHAR2(160),
  td   VARCHAR2(3)
)
 
tablespace BRSDYND
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited)
';

exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

COMMENT ON TABLE BARS.tmp_opersep_rep IS 'Тимчасова таблиця звіту СЕП Повернуті платежі';
COMMENT ON COLUMN BARS.tmp_opersep_rep.ref IS 'REF документу';
COMMENT ON COLUMN BARS.tmp_opersep_rep.s IS 'Сума документу';
COMMENT ON COLUMN BARS.tmp_opersep_rep.nlsa IS 'Рахунок А';
COMMENT ON COLUMN BARS.tmp_opersep_rep.nd IS 'Номер документу';
COMMENT ON COLUMN BARS.tmp_opersep_rep.pdat IS 'Дата документу';
COMMENT ON COLUMN BARS.tmp_opersep_rep.nazn IS 'Призначення платежу';
COMMENT ON COLUMN BARS.tmp_opersep_rep.td  IS 'Тип даних (IN/OUT)';
    



PROMPT *** Create  grants TMP_OPERSEP_REP ***
grant SELECT                                                                 on TMP_OPERSEP_REP to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_OPERSEP_REP to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_OPERSEP_REP to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OPERSEP_REP.SQL =========*** End
PROMPT ===================================================================================== 
