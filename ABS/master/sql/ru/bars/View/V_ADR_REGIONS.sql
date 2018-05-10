create or replace view v_adr_regions as
select  case region_id
          when 1  then '302076'   /*Вiнницьке*/
          when 2  then '303398'   /*Волинське*/
          when 3  then '305482'   /*Днiпропетровське*/
          when 4  then '335106'   /*Донецьке*/
          when 5  then '311647'   /*Житомирське*/
          when 6  then '312356'   /*Закарпатське*/
          when 7  then '313957'   /*Запорiзьке*/
          when 8  then '336503'   /*Iвано-Франкiвське*/
          when 9  then '300465'   /*Київ */
          when 10 then '322669'   /*Київ область*/
          when 11 then '323475'   /*Кiровоградське*/
          when 12 then '324805'   /*Кримське респуб.*/
          when 13 then '304665'   /*Луганське*/
          when 14 then '325796'   /*Львiвське*/
          when 15 then '326461'   /*Миколаївське*/
          when 16 then '328845'   /*Одеське*/
          when 17 then '331467'   /*Полтавське*/
          when 18 then '333368'   /*Рiвненське*/
          when 19 then ''
          when 20 then '337568'   /*Сумське*/
          when 21 then '338545'   /*Тернопiльське*/
          when 22 then '351823'   /*Харкiвське */
          when 23 then '315784'   /*Херсонське*/
          when 24 then '352457'   /*Хмельницьке*/
          when 25 then '354507'   /*Черкаське*/
          when 26 then '356334'   /*Чернiвецьке*/
          when 27 then '353553'   /*Чернiгiвське*/
        end MFO,
        r.region_id,
        r.region_name region_nm,
        r.region_name_ru,
        r.country_id,
        r.koatuu,
        r.iso3166_2
from ADR_REGIONS r;


GRANT SELECT ON v_adr_regions TO BARS_ACCESS_DEFROLE;
