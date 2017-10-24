CREATE OR REPLACE FORCE VIEW BARS.V_EBKC_LEGAL_PERSON
as /* Дані по юр.особах для ЄБК */
select c.kf,                                      -- Код РУ (код МФО)
       c.rnk,                                     -- Реєстр. № (РНК)
       greatest( ( select max(cu.CHGDATE) from BARS.CUSTOMER_UPDATE  cu where cu.RNK = c.RNK )
               , ( select max(cu.CHGDATE) from BARS.CUSTOMERW_UPDATE cu where cu.RNK = c.RNK )
               , ( select max(cu.CHGDATE) from BARS.CORPS_UPDATE     cu where cu.RNK = c.RNK )
               ) as lastChangeDt,                  -- Дата останньої модифікації
       c.date_off,                                               --дата закриття
       c.date_on,                                              --Дата реєстрації
       c.nmk  as full_Name,                        --Найменування клієнта (нац.)
       c.nmkv as full_Name_International,                 --Найменування (міжн.)
       c.nmkk as full_Name_Abbreviated,               --Найменування (скорочене)
       1 as k014,                                           --Тип клієнта (К014)
       c.country as k040,                                --Країна клієнта (К040)
       c.tgr     as build_State_Register,               --Тип державного реєстру
       c.okpo,                                            --Ідентифікаційний код
      (SELECT cw.VALUE
         FROM customerw cw
        WHERE cw.tag = 'EOKPO' AND c.rnk = cw.rnk)        
             as is_Okpo_Exclusion,                     --Ознака виключення Ідент
       c.prinsider as k060,                            --Ознака інсайдера (К060)
       (select rezid from bars.codcagent where codcagent=c.codcagent) 
             as k030,                                     --Резидентність (К030)
       c.branch as off_Balance_Dep_Code,         --Код безбалансового відділення  
       (select name from branch where branch = c.branch) 
             as off_Balance_Dep_Name,          --Назва безбалансового відділення  
       c.ise as k070,                            --Інст. сектор економіки (К070)
       c.fs  as k080,                                   --Форма власності (К080)
       c.ved as k110,                                 --Вид ек. діяльності(К110)
       c.k050,                                     --Форма господарювання (К050)
       trim(c.sed) as k051,                        --Форма господарювання (К051)
       -- Юридична адреса  
       au.zip as au_zip,                                                --Індекс
       au.territory_id as au_terid,                              --Код території
       au.domain as au_region,                                         --Область
       au.region as au_area,                                             --Район
       au.locality as au_locality,                             --Населений пункт
       au.country as au_contry,                          --Країна клієнта (К040) 
       au.address as au_adress,                                  --Вул.,буд., кв
       --Фактична адреса
       af.zip as af_zip,                                                --Індекс
       af.territory_id as af_terid,                              --Код території
       af.domain as af_region,                                         --Область
       af.region as af_area,                                             --Район
       af.locality as af_locality,                             --Населений пункт
       af.country as af_contry,                          --Країна клієнта (К040)
       af.address as af_adress,                                  --Вул.,буд., кв
       --Реквізити платника податків
       c.c_reg as regional_Pi,                                      --Обласна ПІ
       c.c_dst as area_Pi,                                          --Районна ПІ
       c.adm   as adm_Reg_Authority,         --Адміністративний орган реєстрації
       c.datea as adm_Reg_Date,                            --Дата реєстр. у Адм.
       c.datet as pi_Reg_Date,                               --Дата реєстр. у ПІ
       c.rgadm as dpa_Reg_Number,                       --Номер реєстрації у ДПА
       to_date (null) as dpi_Reg_Date,                     --?Дата реєстр. у ДПІ
       (select value from bars.CUSTOMERW cw where cw.tag='N_RPP' and c.rnk=cw.rnk)       
        as vat_Data,                                     --Дані про платника ПДВ
       (select value from bars.CUSTOMERW cw where cw.tag='N_RPN' and c.rnk=cw.rnk) 
        as vat_Cert_Number,  --№ свідоцтва платника ПДВ
       (select value from bars.CUSTOMERW cw where cw.tag='FIRMA' and c.rnk=cw.rnk)        
        as name_By_Status,                             --Найменування по статуту
       C.CRISK as borrower_Class,                            --Клас позичальника
       '' as regional_Holding_Number,                         --?Рег. № холдингу
       (select value from bars.CUSTOMERW cw where cw.tag='K013 ' and c.rnk=cw.rnk)       
        as k013,                                         --Код виду клієнта (K013)
       (select value from bars.CUSTOMERW cw where cw.tag='MS_GR' and c.rnk=cw.rnk)       
        as group_Affiliation,                                 --КП-г.53 Приналежність до групи
       --(select value from bars.CUSTOMERW cw where cw.tag='N_RPD' and c.rnk=cw.rnk)       
       to_date (null) as income_Tax_Payer_Reg_Date,      --?Дата реєстрації як платника податку на прибуток
       (select value from bars.CUSTOMERW cw where cw.tag='KVPKK' and c.rnk=cw.rnk)
        as separate_Div_Corp_Code,                    --Код відокремленого підрозділу корп. Клієнта
       (select value from bars.CUSTOMERW cw where cw.tag='CCVED' and c.rnk=cw.rnk)       
        as economic_Activity_Type,              --Вид (види) господарської (економічної) діяльності
       (select value from bars.CUSTOMERW cw where cw.tag='DATVR' and c.rnk=cw.rnk)       
        as first_Acc_Date,                          --Дата відкриття першого рахунку
       (select value from bars.CUSTOMERW cw where cw.tag='DATZ ' and c.rnk=cw.rnk)       
        as initial_Form_Fill_Date,                        --Дата первинного заповнення анкети
       (select value from bars.CUSTOMERW cw where cw.tag='O_REP' and c.rnk=cw.rnk)       
        as evaluation_Reputation,                                       --Оцінка репутації клієнта
       (select value from bars.CUSTOMERW cw where cw.tag='FSRSK' and c.rnk=cw.rnk)       
        as authorized_Capital_Size,                   --Оцінка фiн.стану: Розмiр статутного капiталу
       (select value from bars.CUSTOMERW cw where cw.tag='RIZIK' and c.rnk=cw.rnk)       
        as risk_Level,                                                  --Рiвень ризику
       (select value from bars.CUSTOMERW cw where cw.tag='DJER ' and c.rnk=cw.rnk)       
        as revenue_Sources_Character,                  --Характеристика джерел надходжень коштiв
       (select value from bars.CUSTOMERW cw where cw.tag='SUTD ' and c.rnk=cw.rnk)       
        as essence_Character,                           --Характеристика суті діяльності
       (select value from bars.CUSTOMERW cw where cw.tag='UUDV' and c.rnk=cw.rnk)       
        as national_Property,                                      --Частка державної власності
       (select value from bars.CUSTOMERW cw where cw.tag='VIP_K' and c.rnk=cw.rnk)       
        as vip_Sign,                                             --Ознака VIP-клієнта
       (select value from bars.CUSTOMERW cw where cw.tag='NOTAX' and c.rnk=cw.rnk)       
        as no_Taxpayer_Sign                                      --Ознака неплатника податків
  from customer c
     , corps p
     , ( select rnk, type_id, country,zip, domain, region, locality_type, locality, address, street_type, street, 
                home_type, home, homepart_type, homepart, room_type, room , territory_id
           from bars.customer_address ca
          where type_id ='1' 
        ) au
     , ( select rnk, type_id, country,zip, domain, region, locality_type, locality, address, street_type, street, 
                home_type, home, homepart_type, homepart, room_type, room , territory_id
           from bars.customer_address ca
          where type_id ='2'
        ) af
 where c.custtype = 2
   and c.rnk = p.rnk
   and c.rnk=au.rnk(+)
   and c.rnk=af.rnk(+);
  
GRANT SELECT ON BARS.V_EBKC_LEGAL_PERSON TO BARS_ACCESS_DEFROLE;  
