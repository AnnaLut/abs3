-- ======================================================================================
-- Module :
-- Author : BAA
-- Date   :
-- ===================================== <Comments> =====================================
-- Script for insert or update table "ADR_REGIONS"
-- ======================================================================================
SET FEEDBACK     OFF

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 1, 'Вінницька обл.', 'Винницкая обл.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = 'Вінницька обл.',
           REGION_NAME_RU = 'Винницкая обл.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 1;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 2, 'Волинська обл.', 'Волынская обл.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = 'Волинська обл.',
           REGION_NAME_RU = 'Волынская обл.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 2;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 3, 'Дніпропетровська обл.', 'Днепропетровская обл.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = 'Дніпропетровська обл.',
           REGION_NAME_RU = 'Днепропетровская обл.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 3;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 4, 'Донецька обл.', 'Донецкая обл.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = 'Донецька обл.',
           REGION_NAME_RU = 'Донецкая обл.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 4;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 5, 'Житомирська обл.', 'Житомирская обл.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = 'Житомирська обл.',
           REGION_NAME_RU = 'Житомирская обл.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 5;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 6, 'Закарпатська обл.', 'Закарпатская обл.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = 'Закарпатська обл.',
           REGION_NAME_RU = 'Закарпатская обл.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 6;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 7, 'Запорізька обл.', 'Запорожская обл.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = 'Запорізька обл.',
           REGION_NAME_RU = 'Запорожская обл.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 7;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 8, 'Івано-Франківська обл.', 'Ивано-Франковская обл.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = 'Івано-Франківська обл.',
           REGION_NAME_RU = 'Ивано-Франковская обл.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 8;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 9, 'Київ', 'Киев', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = 'Київ',
           REGION_NAME_RU = 'Киев',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 9;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 10, 'Київська обл.', 'Киевская обл.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = 'Київська обл.',
           REGION_NAME_RU = 'Киевская обл.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 10;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 11, 'Кіровоградська обл.', 'Кировоградская обл.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = 'Кіровоградська обл.',
           REGION_NAME_RU = 'Кировоградская обл.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 11;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 12, 'Крим', 'Крым', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = 'Крим',
           REGION_NAME_RU = 'Крым',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 12;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 13, 'Луганська обл.', 'Луганская обл.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = 'Луганська обл.',
           REGION_NAME_RU = 'Луганская обл.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 13;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 14, 'Львівська обл.', 'Львовская обл.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = 'Львівська обл.',
           REGION_NAME_RU = 'Львовская обл.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 14;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 15, 'Миколаївська обл.', 'Николаевская обл.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = 'Миколаївська обл.',
           REGION_NAME_RU = 'Николаевская обл.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 15;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 16, 'Одеська обл.', 'Одесская обл.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = 'Одеська обл.',
           REGION_NAME_RU = 'Одесская обл.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 16;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 17, 'Полтавська обл.', 'Полтавская обл.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = 'Полтавська обл.',
           REGION_NAME_RU = 'Полтавская обл.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 17;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 18, 'Рівненська обл.', 'Ровенская обл.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = 'Рівненська обл.',
           REGION_NAME_RU = 'Ровенская обл.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 18;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 19, 'Севастополь', 'Севастополь', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = 'Севастополь',
           REGION_NAME_RU = 'Севастополь',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 19;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 20, 'Сумська обл.', 'Сумская обл.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = 'Сумська обл.',
           REGION_NAME_RU = 'Сумская обл.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 20;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 21, 'Тернопільська обл.', 'Тернопольская обл.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = 'Тернопільська обл.',
           REGION_NAME_RU = 'Тернопольская обл.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 21;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 22, 'Харківська обл.', 'Харьковская обл.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = 'Харківська обл.',
           REGION_NAME_RU = 'Харьковская обл.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 22;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 23, 'Херсонська обл.', 'Херсонская обл.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = 'Херсонська обл.',
           REGION_NAME_RU = 'Херсонская обл.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 23;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 24, 'Хмельницька обл.', 'Хмельницкая обл.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = 'Хмельницька обл.',
           REGION_NAME_RU = 'Хмельницкая обл.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 24;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 25, 'Черкаська обл.', 'Черкасская обл.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = 'Черкаська обл.',
           REGION_NAME_RU = 'Черкасская обл.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 25;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 26, 'Чернівецька обл.', 'Черновицкая обл.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = 'Чернівецька обл.',
           REGION_NAME_RU = 'Черновицкая обл.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 26;
end;
/

begin
  Insert into BARS.ADR_REGIONS
    ( REGION_ID,REGION_NAME,REGION_NAME_RU,COUNTRY_ID,KOATUU,ISO3166_2 )
  Values
    ( 27, 'Чернігівська обл.', 'Черниговская обл.', 804, null, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_REGIONS
       set REGION_NAME = 'Чернігівська обл.',
           REGION_NAME_RU = 'Черниговская обл.',
           COUNTRY_ID = 804,
           KOATUU = null,
           ISO3166_2 = null
     where REGION_ID = 27;
end;
/


commit;
