

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS_DM/Table/CREDITS_OPER.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  table CREDITS_OPER ***
begin 
  execute immediate '
  CREATE TABLE BARS_DM.CREDITS_OPER 
   (
     PER_ID NUMBER 
    ,KF     VARCHAR2(6)
    ,ND_cre NUMBER(38,0)
    ,CC_ID  VARCHAR2(50)
    ,VIDD   INTEGER 
    ,ref  number(38)
    ,nd     varchar2(10)
    ,mfoa varchar2(12)
    ,nlsa varchar2(15)
    ,s      number(24)
    ,kv     integer
    ,vdat date
    ,s2     number(24)
    ,kv2  NUMBER(38)
    ,mfob varchar2(12)
    ,nlsb varchar2(15)
    ,sk     number(2)
    ,datd date
    ,nazn varchar2(160)
    ,tt     varchar2(3)
    ,tobo varchar2(30)
    ,ida  varchar2(14)
    ,nama varchar2(38)
    ,idb  varchar2(14)
    ,namb varchar2(38)
    ,vob  number(38)
    ,pdat date
    ,odat date
   ) tablespace BRSDMIMP
PARTITION BY LIST (PER_ID) SUBPARTITION by list (KF)
SUBPARTITION TEMPLATE
         (SUBPARTITION KF_300465 VALUES (''300465''),
            SUBPARTITION KF_302076 VALUES (''302076''),
            SUBPARTITION KF_303398 VALUES (''303398''),
            SUBPARTITION KF_304665 VALUES (''304665''),
            SUBPARTITION KF_305482 VALUES (''305482''),
            SUBPARTITION KF_311647 VALUES (''311647''),
            SUBPARTITION KF_312356 VALUES (''312356''),
            SUBPARTITION KF_313957 VALUES (''313957''),
            SUBPARTITION KF_315784 VALUES (''315784''),
            SUBPARTITION KF_322669 VALUES (''322669''),
            SUBPARTITION KF_323475 VALUES (''323475''),
            SUBPARTITION KF_324805 VALUES (''324805''),
            SUBPARTITION KF_325796 VALUES (''325796''),
            SUBPARTITION KF_326461 VALUES (''326461''),
            SUBPARTITION KF_328845 VALUES (''328845''),
            SUBPARTITION KF_331467 VALUES (''331467''),
            SUBPARTITION KF_333368 VALUES (''333368''),
            SUBPARTITION KF_335106 VALUES (''335106''),
            SUBPARTITION KF_336503 VALUES (''336503''),
            SUBPARTITION KF_337568 VALUES (''337568''),
            SUBPARTITION KF_338545 VALUES (''338545''),
            SUBPARTITION KF_351823 VALUES (''351823''),
            SUBPARTITION KF_352457 VALUES (''352457''),
            SUBPARTITION KF_353553 VALUES (''353553''),
            SUBPARTITION KF_354507 VALUES (''354507''),
            SUBPARTITION KF_356334 VALUES (''356334'')
          )
(PARTITION INITIAL_PARTITION VALUES (0)) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

-- Add comments to the columns 
comment on column CREDITS_OPER.kf        is 'Регіональне управління ';
comment on column CREDITS_OPER.nd_cre    is 'Номер договору (Барс) ';
comment on column CREDITS_OPER.cc_id     is '№ договору';
comment on column CREDITS_OPER.vidd      is 'Тип договору';
comment on column CREDITS_OPER.ref       is 'Внутренний номер документа';
comment on column CREDITS_OPER.nd        is 'Номер документу';
comment on column CREDITS_OPER.mfoa      is 'МФО платника';
comment on column CREDITS_OPER.nlsa      is 'Рахунок платника';
comment on column CREDITS_OPER.s         is 'Сума';
comment on column CREDITS_OPER.kv        is 'Код валюти рахунку платника';
comment on column CREDITS_OPER.vdat      is 'Дата валютування';
comment on column CREDITS_OPER.s2        is 'Сума у валюті рахунку одержувача';
comment on column CREDITS_OPER.kv2       is 'Код валюти рахунку одержувача';
comment on column CREDITS_OPER.mfob      is 'МФО одержувача ';
comment on column CREDITS_OPER.nlsb      is 'Номер рахунку одержувача';
comment on column CREDITS_OPER.sk        is 'СКП';
comment on column CREDITS_OPER.datd      is 'Дата документу';
comment on column CREDITS_OPER.nazn      is 'Призначення платежу';
comment on column CREDITS_OPER.tt        is 'Код операції';
comment on column CREDITS_OPER.tobo      is 'Код безб. відділення';
comment on column CREDITS_OPER.ida       is 'РНОКПП платника  ';
comment on column CREDITS_OPER.nama      is 'Назва рахунку платника';
comment on column CREDITS_OPER.idb       is 'РНОКПП одержувача ';
comment on column CREDITS_OPER.namb      is 'Назва рахунку одержувача ';
comment on column CREDITS_OPER.vob       is 'Вид документа';
comment on column CREDITS_OPER.pdat      is 'Дата створення';
comment on column CREDITS_OPER.odat      is 'Дата оплати';


PROMPT *** Create  index I_CRED_OPER_PERID ***
begin   
 execute immediate '
  CREATE INDEX BARS_DM.I_CRED_OPER_PERID ON BARS_DM.CREDITS_OPER (PER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CREDITS_OPER ***
grant SELECT                                                                 on CREDITS_OPER     to BARS;
grant SELECT                                                                 on CREDITS_OPER     to BARSUPL;
grant SELECT                                                                 on CREDITS_OPER     to UPLD;
grant SELECT                                                                 on CREDITS_OPER     to BARS_ACCESS_DEFROLE;

prompt *** Create  errlog to CREDITS_OPER
begin
    dbms_errlog.create_error_log(dml_table_name => 'CREDITS_OPER');
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS_DM/Table/CREDITS_OPER.sql =========*** End **
PROMPT ===================================================================================== 
