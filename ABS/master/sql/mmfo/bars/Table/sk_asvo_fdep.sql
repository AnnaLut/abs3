

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SK_ASVO_FDEP.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SK_ASVO_FDEP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SK_ASVO_FDEP'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SK_ASVO_FDEP'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''SK_ASVO_FDEP'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/



PROMPT *** Create  table SK_ASVO_FDEP ***
begin 
  execute immediate '
    create table BARS.SK_ASVO_FDEP
    (
      fio        VARCHAR2(60),
      idcode     VARCHAR2(10),
      doctype    NUMBER(1),
      pasp_s     VARCHAR2(2),
      pasp_n     VARCHAR2(8),
      pasp_w     VARCHAR2(120),
      pasp_d     DATE,
      birthdat   DATE,
      birthpl    VARCHAR2(120),
      sex        NUMBER(1),
      postidx    VARCHAR2(10),
      region     VARCHAR2(30),
      district   VARCHAR2(30),
      city       VARCHAR2(30),
      address    VARCHAR2(120),
      phone_h    VARCHAR2(20),
      phone_j    VARCHAR2(20),
      landcod    NUMBER(5),
      regdate    DATE,
      depcode    VARCHAR2(16),
      depvidname VARCHAR2(120),
      acc_card   VARCHAR2(10),
      depname    VARCHAR2(120),
      nls        VARCHAR2(20),
      id         VARCHAR2(7),
      dato       DATE,
      ost        NUMBER(16),
      sum        NUMBER(16),
      datn       DATE,
      attr       VARCHAR2(16),
      mark       VARCHAR2(1),
      ver        NUMBER(4),
      kod_otd    VARCHAR2(10),
      branch     VARCHAR2(30),
      bsd        VARCHAR2(7),
      ob22de     VARCHAR2(2),
      bsn        VARCHAR2(7),
      ob22ie     VARCHAR2(7),
      bsd7       VARCHAR2(7),
      ob22d7     VARCHAR2(2),
      num_load   NUMBER(38,0),
      KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
    )
    SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


PROMPT *** ALTER_POLICIES to SK_ASVO_FDEP ***
 exec bpa.alter_policies('SK_ASVO_FDEP');

COMMENT ON COLUMN BARS.SK_ASVO_FDEP.NUM_LOAD IS 'Номер відповідного завантаження';
 
PROMPT *** Create  index ASVO_FDEP_LOAD ***
begin   
 execute immediate '
  CREATE INDEX BARS.ASVO_FDEP_LOAD ON BARS.SK_ASVO_FDEP (NUM_LOAD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/  


PROMPT *** Create  grants  SK_ASVO_FDEP ***

grant DELETE,INSERT,SELECT,UPDATE                                            on SK_ASVO_FDEP       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SK_ASVO_FDEP       to BARSR;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SK_ASVO_FDEP.sql =========*** End *** ===
PROMPT ===================================================================================== 
