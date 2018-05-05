-- ======================================================================================
-- Module : CDM (ЄБК)
-- Author : BAA
-- Date   : 12.02.2018
-- ======================================================================================
-- create view EBK_QUEUE_UPDATECARD_V
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500

prompt -- ======================================================
prompt -- create view EBK_QUEUE_UPDATECARD_V
prompt -- ======================================================

create or replace force view EBK_QUEUE_UPDATECARD_V
( KF
, RNK
, DATEON
, DATEOFF
, NMK
, SNLN
, SNFN
, SNMN
, NMKV
, SNGC
, CODCAGENT
, K013
, COUNTRY
, PRINSIDER
, TGR
, OKPO
, PASSP
, SER
, NUMDOC
, ORGAN
, PDATE
, DATEPHOTO
, BDAY
, BPLACE
, SEX
, ACTUALDATE
, EDDRID
, BRANCH
, ADR
, URZIP
, URDOMAIN
, URREGION
, URLOCALITY
, URADDRESS
, URTERRITORYID
, URLOCALITYTYPE
, URSTREETTYPE
, URSTREET
, URHOMETYPE
, URHOME
, URHOMEPARTTYPE
, URHOMEPART
, URROOMTYPE
, URROOM
, FGADR
, FGDST
, FGOBL
, FGTWN
, MPNO
, CELLPHONE
, TELD
, TELW
, EMAIL
, ISE
, FS
, VED
, K050
, PCZ2
, PCZ1
, PCZ5
, PCZ3
, PCZ4
, SAMZ
, VIPK
, WORKPLACE
, PUBLP
, CIGPO
, CHORN
, SPMRK
, WORKB
, OKPOEXCLUSION
, BANKCARD
, CREDIT
, DEPOSIT
, CURRENTACCOUNT
, OTHER
, LASTCHANGEDT
, CUST_ID
, GCIF
, RCIF
) as
select q.KF,                          -- Код РУ (код МФО)
       case
         when ( EBK_PARAMS.IS_CUT_RNK = 1 )
         then trunc(q.RNK/100)
         else q.RNK
       end as RNK,                      -- Реєстр. № (РНК)
       ecbi.date_ON  as dateON ,        -- Дата реєстрації
       ecbi.date_OFF as dateOFF,        -- Дата закриття
       ecbi.nmk,                        -- Найменування клієнта (нац.)
       ecbi.sn_Ln as snLn,              -- Прізвище клієнта
       ecbi.sn_Fn as snFn,              -- Ім`я клієнта
       ecbi.sn_Mn snMn,                 -- По-батькові клієнта
       ecbi.nmkv,                       -- Найменування (міжн.)
       ecbi.sn_Gc as snGc,              -- ПІБ клієнта в родовому відмінку
       ecbi.codcagent,                  -- Характеристика клієнта (К010)
       ecbi.k013,                       -- Код виду клієнта (K013)
       ecbi.country,                    -- Країна клієнта (К040)
       ecbi.prinsider,                  -- Ознака інсайдера (К060)
       ecbi.tgr,                        -- Тип держ. реєстру
       ecbi.okpo,                       -- Ідентифікаційний код
       ecbi.passp,                      -- Вид документу
       ecbi.ser,                        -- Серія
       ecbi.numdoc,                     -- Номер
       ecbi.organ,                      -- Ким виданий
       ecbi.pdate,                      -- Дата видачі
       ecbi.date_Photo datePhoto,       -- Дата вклеювання фото в паспорт
       ecbi.bday,                       -- Дата народження
       ecbi.bplace,                     -- Місце народження
       ecbi.sex,                        -- Стать
       ecbi.actual_date as actualdate,  -- Дійсний до
       ecbi.eddr_id as eddrid,          -- Унікальний номер запису в ЄДДР
       ecbi.branch,                     --
       ecbi.adr,                        -- Адреса (єдине поле)
       ecbi.ur_Zip as urZip,                    -- Юр.адр:Индекс
       ecbi.ur_Domain as urDomain,              -- Юр.адр:Область
       ecbi.ur_Region as urRegion,              -- Юр.адр:Регион
       ecbi.ur_Locality as urLocality,          -- Юр.адр:Населенный пукт
       ecbi.ur_Address as urAddress,            -- Юр.адр:Адрес(улица,дом,кв.)
       ecbi.ur_Territory_Id as urTerritoryId,   -- Юр.адр:Код адреса
       ecbi.ur_Locality_Type as urLocalityType, -- Юр.адр:Тип насел.пункта
       ecbi.ur_Street_Type as urStreetType,     -- Юр.адр:Тип улицы
       ecbi.ur_Street as urStreet,              -- Юр.адр:Улица
       ecbi.ur_Home_Type as urHomeType,         -- Юр.адр:Тип дома
       ecbi.ur_Home as urHome,                  -- Юр.адр:№ дома
       ecbi.ur_Homepart_Type as urHomepartType, -- Юр.адр:Тип дел.дома
       ecbi.ur_Home_part as urHomepart,         -- Юр.адр:№ типа дел.дома
       ecbi.ur_Room_Type urRoomType,            -- Юр.адр:Тип жилого помещения
       ecbi.ur_Room urRoom,                     -- Юр.адр:№ жилого помещения
       ecbi.fgadr,                  -- Адреса: вулиця,буд.,кв.
       ecbi.fgdst,                  -- Адреса: район
       ecbi.fgobl,                  -- Адреса: область
       ecbi.fgtwn,                  -- Адреса: населений пункт
       ecbi.mpno,                   -- Мобільний телефон
       ecbi.cellphone,              -- Мобіьний тел.
       ecbi.teld,                   -- Домашній тел.
       ecbi.telw,                   -- Робочий тел.
       ecbi.email,                  -- Адреса електронної пошти
       ecbi.ise,                    -- Інст.сектор.економіки (К070)
       ecbi.fs ,                    -- Форма власності (К080)
       ecbi.ved ,                   -- Вид ек. діяльності (К110)
       ecbi.k050 ,                  -- Форма господарювання (К050)
       ecbi.pc_Z2 as pcZ2,          -- БПК. Закордонний паспорт. Номер
       ecbi.pc_Z1 as pcZ1,          -- БПК. Закордонний паспорт. Серія
       ecbi.pc_Z5 as pcZ5,          -- БПК. Закордонний паспорт. Коли виданий
       ecbi.pc_Z3 as pcZ3,          -- БПК. Закордонний паспорт. Ким виданий
       ecbi.pc_Z4 as pcZ4,          -- БПК. Закордонний паспорт. Дійсний до
       ecbi.samz,                   -- Вiдмiтка про самозайнятiсть фiзособи
       ecbi.vip_K as vipK,          -- Ознака VIP-клієнта
       ecbi.work_Place as workPlace,-- Місце роботи, посада
       ecbi.publp,                  -- Належнiсть до публiчних дiячiв
       ecbi.cigpo,                  -- Статус зайнятості особи
       ecbi.chorn,                  -- Категорiя громадян, якi постраждали внаслiдок Чорноб.катастрофи
       ecbi.spmrk,                  -- Код Особливої Вiдмiтки нестандартного клієнта ФО
       ecbi.workb,                  -- Приналежнiсть до працiвникiв банку
       nvl(ecbi.okpo_Exclusion, 0) as okpoExclusion,
       ecbi.bank_card as BankCard,
       ecbi.credit,
       ecbi.deposit,
       ecbi.current_account as CurrentAccount,
       ecbi.other,
       q.INSERT_DATE as lastChangeDt,
       q.RNK as CUST_ID,
       g.GCIF,
       cast( null as number ) as RCIF
  from ( select KF, RNK, INSERT_DATE
           from EBK_QUEUE_UPDATECARD
          where STATUS = 0
          order by ROWID
       ) q
  join EBK_CUST_BD_INFO_V  ecbi
    on ( ecbi.RNK = q.RNK )
  left outer
  join EBKC_GCIF g
    on ( g.RNK = q.RNK )
;

show errors;

grant SELECT on EBK_QUEUE_UPDATECARD_V to BARS_ACCESS_DEFROLE;
grant SELECT on EBK_QUEUE_UPDATECARD_V to BARSREADER_ROLE;