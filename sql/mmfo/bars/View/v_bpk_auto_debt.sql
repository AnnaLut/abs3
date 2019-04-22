create or replace force view v_bpk_auto_debt as
select o.ref, o.tt, pdat,  nextvisagrp, sos, if.fn, if.dat
  from xml_impfiles if, xml_impdocs ic, oper o 
 where  
       config = 'imp_7_0'                         -- настройка иморта - договірне списання 
   and imptype = 'cw'                             -- тип импорта XLS
   and if.dat > gl.bd - 1                         -- смотрим только сеголняшние документы
   and o.tt in ('2PD','RKP','G4W','F4W','3PD')    -- только операции по договорному списанию 
   and o.nextvisagrp <> '1E'                      -- не берем докумнеты те ук оторых 30я виза ПЦ. Для них ждем файла квитанции или атрансфера от ПЦ
   and ic.ref = o.ref                             
   and o.sos <> 5                                 -- документ еще не оплачен
   and if.fn = ic.fn
   and if.dat = ic.dat
   and if.kf = ic.kf
   and ic.ref is not null
   order by ref desc;



comment on table v_bpk_auto_debt is 'Документы для автоотбора вертушкой для автооплаты по договорному списанию БПК';
