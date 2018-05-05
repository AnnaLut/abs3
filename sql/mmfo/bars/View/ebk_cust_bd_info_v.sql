-- ======================================================================================
-- Module : CDM (ЄБК)
-- Author : BAA
-- Date   : 21.09.2017
-- ======================================================================================
-- create view EBK_CUST_BD_INFO_V ( contains data for send to EBK )
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500

prompt -- ======================================================
prompt -- create view EBK_CUST_BD_INFO_V
prompt -- ======================================================

create or replace view EBK_CUST_BD_INFO_V
as
select c.KF as kf,
       c.rnk as rnk,           -- Реєстр. № (РНК)
       c.date_on as date_on,   -- дата  реєстрації
       c.date_off as date_off, -- дата закриття
       c.nmk as nmk,           -- Найменування клієнта (нац.)
       (select cw.value from customerw cw  where cw.tag='SN_LN' and c.rnk=cw.rnk) as sn_ln, -- Прізвище клієнта
       (select cw.value from customerw cw  where cw.tag='SN_FN' and c.rnk=cw.rnk) as sn_fn, -- Ім'я клієнта
       (select cw.value from customerw cw  where cw.tag='SN_MN' and c.rnk=cw.rnk) as sn_mn, -- По-батькові клієнта
       c.nmkv as nmkv, -- Найменування (міжн.)
       (select cw.value from customerw cw  where cw.tag='SN_GC' and c.rnk=cw.rnk) as sn_gc, --ПІБ клієнта в родовому відмінку
       c.codcagent as codcagent, --характеристика клієнта (К010)
       (select cw.value from customerw cw  where cw.tag='K013' and c.rnk=cw.rnk) as k013, --Код виду клієнта (K013)
       c.country as country, --країна клієнта (К040)
       c.prinsider as prinsider, --ознака інсайдера (К060)
       c.tgr as tgr, --тип держ. реєстру
       c.okpo as okpo, --Ідентифікаційний код
       p.passp as passp, -- вид документу 
       p.ser as ser, --серія
       p.numdoc as numdoc, --номер
       p.organ as organ, --ким виданий 
       p.pdate as pdate, --дата видачі
       p.date_photo as date_photo, --Дата вклеювання фото в паспорт
       p.bday as bday, --дата народження 
       p.bplace as bplace, -- місце народження
       p.sex as sex,       -- стать
       p.actual_date,      -- Дійсний до
       p.eddr_id,          -- Унікальний номер запису ЄДДР
       c.branch as branch, -- код. безбалансового відділення
       c.adr as adr,       -- Адреса (єдине поле)
       --
       ad.zip           as ur_zip, -- Юр.адр:Индекс
       ad.domain        as ur_domain, --Юр.адр:Область
       ad.region        as ur_region, --Юр.адр:Регион
       ad.locality      as ur_locality, --Юр.адр:Населенный пукт
       ad.address       as ur_address, --Юр.адр:Адрес(улица,дом,кв.)
       ad.territory_id  as ur_territory_id, --Юр.адр:Код адреса
       ad.locality_type as ur_locality_type, --Юр.адр:Тип насел.пункта
       ad.street_type   as ur_street_type, --Юр.адр:Тип улицы
       ad.street        as ur_street, --Юр.адр:Улица
       ad.home_type     as ur_home_type, --Юр.адр:Тип дома
       ad.home          as ur_home, --Юр.адр:№ дома
       ad.homepart_type as ur_homepart_type, --Юр.адр:Тип дел.дома
       ad.homepart      as ur_home_part, --Юр.адр:№ типа дел.дома
       ad.room_type     as ur_room_type, --Юр.адр:Тип жилого помещения
       ad.room          as ur_room, -- Юр.адр:№ жилого помещения
       (select cw.value from customerw cw  where cw.tag='FGADR' and c.rnk=cw.rnk) as fgadr, --Адр:вулиця,буд.,кв.
       (select cw.value from customerw cw  where cw.tag='FGDST' and c.rnk=cw.rnk) as fgdst, --Адреса: район
       (select cw.value from customerw cw  where cw.tag='FGOBL' and c.rnk=cw.rnk) as fgobl, --адреса: область
       (select cw.value from customerw cw  where cw.tag='FGTWN' and c.rnk=cw.rnk) as fgtwn, --адреса: населений пункт
       (select cw.value from customerw cw  where cw.tag='MPNO'  and c.rnk=cw.rnk) as mpno,  --мобільний телефон
       p.cellphone as cellphone, --мобіьний тел.
       p.teld as teld,--домашній тел.
       p.telw as telw, --робочий тел.
       (select cw.value from customerw cw  where cw.tag='EMAIL' and c.rnk=cw.rnk) as email,--адреса електронної пошти
       c.ise as ise , --інст.сектор.економіки (К070)
       c.fs as fs,-- форма власності (К080)
       c.ved as ved, --вид ек. діяльності (К110)
       c.k050 as k050, --форма господарювання (К050)
       (select cw.value from customerw cw  where cw.tag='PC_Z2' and c.rnk=cw.rnk) as pc_z2,     -- БПК. Закордонний паспорт. Номер
       (select cw.value from customerw cw  where cw.tag='PC_Z1' and c.rnk=cw.rnk) as pc_z1,     -- БПК. Закордонний паспорт. Серія
       (select cw.value from customerw cw  where cw.tag='PC_Z5' and c.rnk=cw.rnk) as pc_z5,     -- БПК. Закордонний паспорт. Коли виданий
       (select cw.value from customerw cw  where cw.tag='PC_Z3' and c.rnk=cw.rnk) as pc_z3,     -- БПК. Закордонний паспорт. Ким виданий
       (select cw.value from customerw cw  where cw.tag='PC_Z4' and c.rnk=cw.rnk) as pc_z4,     -- БПК. Закордонний паспорт. Дійсний до
       (select cw.value from customerw cw  where cw.tag='SAMZ'  and c.rnk=cw.rnk) as samz,      -- Вiдмiтка про самозайнятiсть фiзособи
       (select cw.value from customerw cw  where cw.tag='VIP_K' and c.rnk=cw.rnk) as vip_k,     -- Ознака VIP-клієнта  
       (select cw.value from customerw cw  where cw.tag='WORK'  and c.rnk=cw.rnk) as work_place,-- Місце роботи, посада 
       (select cw.value from customerw cw  where cw.tag='PUBLP' and c.rnk=cw.rnk) as publp,     -- Належнiсть до публiчних дiячiв
       (select cw.value from customerw cw  where cw.tag='CIGPO' and c.rnk=cw.rnk) as cigpo,     -- Статус зайнятості особи
       (select cw.value from customerw cw  where cw.tag='CHORN' and c.rnk=cw.rnk) as chorn,     -- Категорiя громадян, якi постраждали внаслiдок Чорноб.катастрофи
       (select cw.value from customerw cw  where cw.tag='SPMRK' and c.rnk=cw.rnk) as spmrk,     -- Код Особливої Вiдмiтки нестандартного клієнта ФО
       (select cw.value from customerw cw  where cw.tag='WORKB' and c.rnk=cw.rnk) as workb,     -- Приналежнiсть до працiвникiв банку
       (select cw.value from customerw cw  where cw.tag='EXCLN' and c.rnk=cw.rnk) as okpo_exclusion,
       ( case when exists (select * from w4_acc w, accounts a where w.acc_pk = a.acc and a.dazs is null and a.rnk = c.rnk ) then 1 else 0 end ) as bank_card,
       ( case when exists (select * from cc_deal cc where cc.rnk = c.rnk and cc.sos not in (0,2,14,15) ) then 1 else 0 end ) as credit,
       ( case when exists (select * from dpt_deposit dd where dd.rnk = c.rnk) then 1 else 0 end) as deposit,
       ( case when exists (select * from accounts ac where ac.rnk = c.rnk and ac.dazs is null and nbs='2620') then 1 else 0 end) as current_account,
       0 as other
  from CUSTOMER c
  left
  join PERSON p
    on ( p.RNK = c.RNK )
  left
  join CUSTOMER_ADDRESS ad
    on ( ad.RNK = c.RNK and ad.TYPE_ID = 1 )
;

show err

prompt =========================================
prompt Grants
prompt ==========================================

grant SELECT on EBK_CUST_BD_INFO_V to BARS_ACCESS_DEFROLE;
grant SELECT on EBK_CUST_BD_INFO_V to BARSREADER_ROLE;
