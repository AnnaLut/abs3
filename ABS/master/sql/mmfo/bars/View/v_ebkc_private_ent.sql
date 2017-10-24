CREATE OR REPLACE FORCE VIEW BARS.V_EBKC_PRIVATE_ENT
as /* Дані по ФОПах для ЄБК  */
select c.kf,                                                 -- Код РУ (код МФО)
       c.rnk,                                                 -- Реєстр. № (РНК)
       GREATEST( ( select max(cu.CHGDATE) from BARS.CUSTOMER_UPDATE  cu where cu.RNK = c.RNK )
               , ( select max(cu.CHGDATE) from BARS.CUSTOMERW_UPDATE cu where cu.RNK = c.RNK )
               , ( select max(cu.CHGDATE) from BARS.PERSON_UPDATE    cu where cu.RNK = c.RNK )
               ) AS lastChangeDt,                   --Дата останньої модифікації
       c.date_off,                                               --Дата закриття
       c.date_on,                                              --Дата реєстрації
       c.nmk,                                      --Найменування клієнта (нац.)
       c.nmkv,                                            --Найменування (міжн.)
       c.nmkk,                                        --Найменування (скорочене)
       2 AS k014,                                           --Тип клієнта (К014)
       c.country,                                        --Країна клієнта (К040)
       c.tgr,                                           --Тип державного реєстру
       c.okpo,                                            --Ідентифікаційний код
       ( SELECT cw.VALUE FROM customerw cw 
          WHERE cw.tag = 'EXCLN' AND cw.rnk = c.rnk
       ) as OKPO_EXCLUSION,                           -- Ознака виключення Ідент
       c.prinsider,                                   -- Ознака інсайдера (К060)
       c.codcagent as k010,                      --Характеристика клієнта (К010)
       --Економічні нормативи    
       c.ise,                                    --Інст. сектор економіки (К070)
       c.fs,                                            --Форма власності (К080)
       c.ved,                                         --Вид ек. діяльності(К110)
       c.k050,                                     --Форма господарювання (К050)
       trim(c.sed) as sed,                         --Форма господарювання (К051)
       -- Юридична адреса
       a.au_zip,                                                        --Індекс
       a.au_terid,                                               --Код території
       a.au_domain as au_region,                                        --Область
       a.au_region as au_area,                                            --Район
       a.au_locality,                                          --Населений пункт
       a.au_adress,                                         --вул., просп., б-р.
       a.au_home,                                                  --№ буд., д/в
       a.au_homepart,                                           --№ корп., секц.
       a.au_room,                                            --№ кв., кімн., оф.
       '' as au_comm,                                                 --Примітка
       --Фактична адреса
       a.af_zip,                                                        --Індекс
       a.af_terid,                                               --Код території
       a.af_domain as af_region,                                       --Область
       a.af_region as af_area,                                           --Район
       a.af_locality,                                          --Населений пункт
       a.af_adress,                                         --вул., просп., б-р.
       a.af_home,                                                  --№ буд., д/в
       a.af_homepart,                                           --№ корп., секц.
       a.af_room,                                            --№ кв., кімн., оф.
       '' as af_comm,                                                 --Примітка
       --Реквізити платника податків
       c.c_reg,                                                     --Обласна ПІ
       c.c_dst,                                                     --Районна ПІ
       c.adm,                                --Адміністративний орган реєстрації
       c.datea,                                           --Дата реєстр. у Адм.
       c.datet,                                             --Дата реєстр. у ПІ
       c.rgadm,                                         --Номер реєстрації у ДПА
       c.rgtax,                                             --Реєстр. номер у ПІ
       '' as pcod_k050,                                 --?Податковий код (К050)
       --Реквізити клієнта      
       p.passp,                                                  --Тип документа
       p.ser,                                                  --Серія документа
       p.numdoc,                                               --Номер документа
       p.organ,                                                    --Ким виданий
       p.pdate,                                                   --Коли виданий
       p.actual_date,                                               --Дійсний до
       p.eddr_id,                                 --Унікальний номер запису ЄДДР
       p.bday,                                                 --Дата народження
       p.bplace,                                              --Місце народження
       p.sex,                                                            --Стать
       p.cellphone,                                                  --Моб. тел.    
       --Додаткова інформація
       c.crisk,                                              --Клас позичальника
       c.mb   ,                                --приналежність до малого бізнесу
       --Додаткові реквізити
       ( select value from bars.CUSTOMERW cw 
          where cw.tag='K013 ' and c.rnk=cw.rnk
       ) as k013,                                     -- Код виду клієнта (K013)
       ( select value from bars.CUSTOMERW cw
          where cw.tag='MS_GR' and c.rnk=cw.rnk
       ) as ms_gr,                             -- КП-г.53 Приналежність до групи
       ( select value from bars.CUSTOMERW cw
          where cw.tag='EMAIL' and c.rnk=cw.rnk
       ) as email,                                   -- Адреса електронної пошти
       ( select value from bars.CUSTOMERW cw
          where cw.tag='CIGPO' and c.rnk=cw.rnk
       ) as cigpo                                     -- Статус зайнятості особи
  from CUSTOMER c
     , PERSON   p
     , ( select rnk,
                "'1'_C1"  au_contry,
                "'1'_C2"  au_zip,
                "'1'_C3"  au_domain,
                "'1'_C4"  au_region,
                "'1'_C5"  au_locality_type,
                "'1'_C6"  au_locality,
                "'1'_C7"  au_adress,
                "'1'_C8"  au_street_type,
                "'1'_C9"  au_street,
                "'1'_C10" au_home_type,
                "'1'_C11" au_home,
                "'1'_C12" au_homepart_type,
                "'1'_C13" au_homepart,
                "'1'_C14" au_room_type,
                "'1'_C15" au_room,
                "'1'_C16" au_terid,
                "'2'_C1"  af_contry,
                "'2'_C2"  af_zip,
                "'2'_C3"  af_domain,
                "'2'_C4"  af_region,
                "'2'_C5"  af_locality_type,
                "'2'_C6"  af_locality,
                "'2'_C7"  af_adress,
                "'2'_C8"  af_street_type,
                "'2'_C9"  af_street,
                "'2'_C10" af_home_type,
                "'2'_C11" af_home,
                "'2'_C12" af_homepart_type,
                "'2'_C13" af_homepart,
                "'2'_C14" af_room_type,
                "'2'_C15" af_room,
                "'2'_C16" af_terid
          from ( select rnk, type_id, country,zip, domain, region, locality_type, locality, address, street_type, street, 
                        home_type, home, homepart_type, homepart, room_type, room, territory_id
                   from BARS.CUSTOMER_ADDRESS
               )  pivot ( max(country) c1, max(zip) c2, max(domain) c3, max(region) c4, max(locality_type) c5, max(locality) c6, 
                          max(address) c7, max(street_type) c8, max(street) c9, max(home_type) c10, max(home) c11, 
                          max(homepart_type) c12, max(homepart) c13, max(room_type) c14, max(room) c15, max(territory_id) c16
                      for type_id in ('1', '2') )
       ) a
 where c.custtype = 3
   and c.sed = '91  '
   and c.rnk = p.rnk
   and c.rnk=a.rnk(+);

GRANT SELECT ON BARS.V_EBKC_PRIVATE_ENT TO BARS_ACCESS_DEFROLE;
