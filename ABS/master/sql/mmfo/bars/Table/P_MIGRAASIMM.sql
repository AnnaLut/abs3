

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/P_MIGRAASIMM.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to P_MIGRAASIMM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''P_MIGRAASIMM'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''P_MIGRAASIMM'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''P_MIGRAASIMM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/


PROMPT *** Create  table P_MIGRAASIMM ***
begin 
  execute immediate '
    create table bars.P_MIGRAASIMM
    (
      action       VARCHAR2(64),
      procname     VARCHAR2(64),
      errmask      VARCHAR2(64),
      ordnung      INTEGER,
      prov_sql     VARCHAR2(20),
      date_begin   DATE,
      date_end     DATE,
      done         NUMBER,
      err          NUMBER,
      n            NUMBER,
      mistake_show VARCHAR2(100),
      pasteid      NUMBER
    )
    SEGMENT CREATION IMMEDIATE 
      PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
     NOCOMPRESS LOGGING
      TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

comment on table  BARS.P_MIGRAASIMM               is 'Справочник импорта неподвижных вкладов АСВО';
-- Add comments to the columns   
comment on column BARS.P_MIGRAASIMM.action       is 'Действие';
comment on column BARS.P_MIGRAASIMM.procname     is 'Наименование процедуры импорта';
comment on column BARS.P_MIGRAASIMM.errmask      is 'Маска ошибок';
comment on column BARS.P_MIGRAASIMM.ordnung      is 'Порядок сортировки';
comment on column BARS.P_MIGRAASIMM.prov_sql     is 'Имя вюшки - Проверочный SQL';
comment on column BARS.P_MIGRAASIMM.date_begin   is 'Дата початку';
comment on column BARS.P_MIGRAASIMM.date_end     is 'Дата закінчення';
comment on column BARS.P_MIGRAASIMM.done         is 'Виконано';
comment on column BARS.P_MIGRAASIMM.err          is 'Помилки';



PROMPT *** ALTER_POLICIES to P_MIGRAASIMM ***
 exec bpa.alter_policies('P_MIGRAASIMM');



PROMPT *** Create  grants  P_MIGRAASIMM ***
grant DELETE,INSERT,SELECT,UPDATE                                            on P_MIGRAASIMM to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on P_MIGRAASIMM to BARSR;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/P_MIGRAASIMM.sql =========*** End 
PROMPT ===================================================================================== 
