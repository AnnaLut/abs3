

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SK_ASVO_FDEP.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SK_ASVO_FDEP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_SK_ASVO_FDEP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_SK_ASVO_FDEP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_SK_ASVO_FDEP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/


PROMPT *** Create  table TMP_SK_ASVO_FDEP ***
begin 
  execute immediate '
    create global temporary table bars.TMP_SK_ASVO_FDEP
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
      ob22d7     VARCHAR2(2)
    )
    on commit preserve rows
  TABLESPACE TEMP ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


PROMPT *** ALTER_POLICIES to TMP_SK_ASVO_FDEP ***
 exec bpa.alter_policies('TMP_SK_ASVO_FDEP');


PROMPT *** Create  grants  TMP_SK_ASVO_FDEP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_SK_ASVO_FDEP to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_SK_ASVO_FDEP to BARSR;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SK_ASVO_FDEP.sql =========*** End 
PROMPT ===================================================================================== 
