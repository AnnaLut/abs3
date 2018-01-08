

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/EBK_QUEUE_UPDATECARD_V.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  view EBK_QUEUE_UPDATECARD_V ***

  CREATE OR REPLACE FORCE VIEW BARS.EBK_QUEUE_UPDATECARD_V ("KF", "RNK", "DATEON", "DATEOFF", "NMK", "SNLN", "SNFN", "SNMN", "NMKV", "SNGC", "CODCAGENT", "K013", "COUNTRY", "PRINSIDER", "TGR", "OKPO", "PASSP", "SER", "NUMDOC", "ORGAN", "PDATE", "DATEPHOTO", "BDAY", "BPLACE", "SEX", "ACTUALDATE", "EDDRID", "BRANCH", "ADR", "URZIP", "URDOMAIN", "URREGION", "URLOCALITY", "URADDRESS", "URTERRITORYID", "URLOCALITYTYPE", "URSTREETTYPE", "URSTREET", "URHOMETYPE", "URHOME", "URHOMEPARTTYPE", "URHOMEPART", "URROOMTYPE", "URROOM", "FGADR", "FGDST", "FGOBL", "FGTWN", "MPNO", "CELLPHONE", "TELD", "TELW", "EMAIL", "ISE", "FS", "VED", "K050", "PCZ2", "PCZ1", "PCZ5", "PCZ3", "PCZ4", "SAMZ", "VIPK", "WORKPLACE", "PUBLP", "CIGPO", "CHORN", "SPMRK", "WORKB", "OKPOEXCLUSION", "BANKCARD", "CREDIT", "DEPOSIT", "CURRENTACCOUNT", "OTHER", "LASTCHANGEDT") AS 
  select equ.KF,                          -- Код РУ (код МФО)
       case
         when ( EBK_PARAMS.IS_CUT_RNK = 1 )
         then trunc(equ.RNK/100)
         else equ.RNK
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
       ecbi.branch,
       ecbi.adr, --Адреса (єдине поле)
       ecbi.ur_Zip as urZip, -- Юр.адр:Индекс
       ecbi.ur_Domain as urDomain, --Юр.адр:Область
       ecbi.ur_Region as urRegion, --Юр.адр:Регион
       ecbi.ur_Locality as urLocality, --Юр.адр:Населенный пукт
       ecbi.ur_Address as urAddress, --Юр.адр:Адрес(улица,дом,кв.)
       ecbi.ur_Territory_Id as urTerritoryId, --Юр.адр:Код адреса
       ecbi.ur_Locality_Type as urLocalityType, --Юр.адр:Тип насел.пункта
       ecbi.ur_Street_Type as urStreetType, --Юр.адр:Тип улицы
       ecbi.ur_Street as urStreet, --Юр.адр:Улица
       ecbi.ur_Home_Type as urHomeType, --Юр.адр:Тип дома
       ecbi.ur_Home as urHome, --Юр.адр:№ дома
       ecbi.ur_Homepart_Type as urHomepartType, --Юр.адр:Тип дел.дома
       ecbi.ur_Home_part as urHomepart, --Юр.адр:№ типа дел.дома
       ecbi.ur_Room_Type urRoomType, --Юр.адр:Тип жилого помещения
       ecbi.ur_Room urRoom, -- Юр.адр:№ жилого помещения
       ecbi.fgadr, --Адр:вулиця,буд.,кв.
       ecbi.fgdst, --Адреса: район
       ecbi.fgobl, --адреса: область
       ecbi.fgtwn, --адреса: населений пункт
       ecbi.mpno,                       -- мобільний телефон
       ecbi.cellphone,                  -- мобіьний тел.
       ecbi.teld,                       -- домашній тел.
       ecbi.telw,                       -- робочий тел.
       ecbi.email,                      -- адреса електронної пошти
       ecbi.ise, -- інст.сектор.економіки (К070)
       ecbi.fs , -- форма власності (К080)
       ecbi.ved , --вид ек. діяльності (К110)
       ecbi.k050 , --форма господарювання (К050)
       ecbi.pc_Z2 as pcZ2,--БПК. Закордонний паспорт. Номер
       ecbi.pc_Z1 as pcZ1,--БПК. Закордонний паспорт. Серія
       ecbi.pc_Z5 as pcZ5,--БПК. Закордонний паспорт. Коли виданий
       ecbi.pc_Z3 as pcZ3,--БПК. Закордонний паспорт. Ким виданий
       ecbi.pc_Z4 as pcZ4,--БПК. Закордонний паспорт. Дійсний до
       ecbi.samz,--Вiдмiтка про самозайнятiсть фiзособи
       ecbi.vip_K as vipK,--Ознака VIP-клієнта
       ecbi.work_Place as workPlace,--Місце роботи, посада
       ecbi.publp,--Належнiсть до публiчних дiячiв
       ecbi.cigpo,--Статус зайнятості особи
       ecbi.chorn,--Категорiя громадян, якi постраждали внаслiдок Чорноб.катастрофи
       ecbi.spmrk,--Код Особливої Вiдмiтки нестандартного клієнта ФО
       ecbi.workb, --Приналежнiсть до працiвникiв банку
       nvl(ecbi.okpo_Exclusion, 0) as okpoExclusion,
       ecbi.bank_card as BankCard,
       ecbi.credit ,
       ecbi.deposit,
       ecbi.current_account as CurrentAccount,
       ecbi.other,
       /*(select max( chgdate) from
            ( select trunc (cu.chgdate) as chgdate
                  from bars.customer_update cu
               where rnk = equ.rnk
                union all
               select trunc (cwu.chgdate) as chgdate
                 from bars.customerw_update cwu
                 where rnk = equ.rnk
               union all
              select trunc (pu.chgdate) as chgdate
                from bars.person_update pu
                  where rnk = equ.rnk))*/
       equ.insert_date as lastChangeDt
  from BARS.EBK_QUEUE_UPDATECARD equ
  join BARS.EBK_CUST_BD_INFO_V  ecbi
    on ( ecbi.RNK = equ.RNK )
 where equ.status = 0;

PROMPT *** Create  grants  EBK_QUEUE_UPDATECARD_V ***
grant SELECT                                                                 on EBK_QUEUE_UPDATECARD_V to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/EBK_QUEUE_UPDATECARD_V.sql =========***
PROMPT ===================================================================================== 
