-- ======================================================================================
-- Module :
-- Author : BAA
-- Date   :
-- ===================================== <Comments> =====================================
-- Script for insert or update table "ADR_AREAS"
-- ======================================================================================

SET FEEDBACK     OFF

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 1, 1, 'Амвросіївський р-н', 'Амвросиевский р-н', 4, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 1,
           AREA_NAME = 'Амвросіївський р-н',
           AREA_NAME_RU = 'Амвросиевский р-н',
           REGION_ID = 4,
           KOATUU = null
     where AREA_ID = 1;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 2, 2, 'Ананьївський р-н', 'Ананьевский р-н', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 2,
           AREA_NAME = 'Ананьївський р-н',
           AREA_NAME_RU = 'Ананьевский р-н',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 2;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 3, 3, 'Андрушівський р-н', 'Андрушевский р-н', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 3,
           AREA_NAME = 'Андрушівський р-н',
           AREA_NAME_RU = 'Андрушевский р-н',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 3;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 4, 4, 'Антрацитівський р-н', 'Антрацитовский р-н', 13, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 4,
           AREA_NAME = 'Антрацитівський р-н',
           AREA_NAME_RU = 'Антрацитовский р-н',
           REGION_ID = 13,
           KOATUU = null
     where AREA_ID = 4;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 5, 5, 'Апостолівський р-н', 'Апостоловский р-н', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 5,
           AREA_NAME = 'Апостолівський р-н',
           AREA_NAME_RU = 'Апостоловский р-н',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 5;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 6, 6, 'Арбузинський р-н', 'Арбузинский р-н', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 6,
           AREA_NAME = 'Арбузинський р-н',
           AREA_NAME_RU = 'Арбузинский р-н',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 6;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 7, 7, 'Артемівський р-н', 'Артемовский р-н', 4, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 7,
           AREA_NAME = 'Артемівський р-н',
           AREA_NAME_RU = 'Артемовский р-н',
           REGION_ID = 4,
           KOATUU = null
     where AREA_ID = 7;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 8, 8, 'Арцизький р-н', 'Арцизский р-н', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 8,
           AREA_NAME = 'Арцизький р-н',
           AREA_NAME_RU = 'Арцизский р-н',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 8;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 9, 9, 'Балаклійський р-н', 'Балаклейский р-н', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 9,
           AREA_NAME = 'Балаклійський р-н',
           AREA_NAME_RU = 'Балаклейский р-н',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 9;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 10, 10, 'Балтський р-н', 'Балтский р-н', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 10,
           AREA_NAME = 'Балтський р-н',
           AREA_NAME_RU = 'Балтский р-н',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 10;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 11, 11, 'Баранівський р-н', 'Барановский р-н', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 11,
           AREA_NAME = 'Баранівський р-н',
           AREA_NAME_RU = 'Барановский р-н',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 11;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 12, 12, 'Барвінківський р-н', 'Барвинковский р-н', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 12,
           AREA_NAME = 'Барвінківський р-н',
           AREA_NAME_RU = 'Барвинковский р-н',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 12;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 13, 13, 'Баришівський р-н', 'Барышевский р-н', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 13,
           AREA_NAME = 'Баришівський р-н',
           AREA_NAME_RU = 'Барышевский р-н',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 13;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 14, 14, 'Барський р-н', 'Барский р-н', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 14,
           AREA_NAME = 'Барський р-н',
           AREA_NAME_RU = 'Барский р-н',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 14;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 15, 15, 'Бахмацький р-н', 'Бахмачский р-н', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 15,
           AREA_NAME = 'Бахмацький р-н',
           AREA_NAME_RU = 'Бахмачский р-н',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 15;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 16, 16, 'Бахчисарайський р-н', 'Бахчисарайский р-н', 12, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 16,
           AREA_NAME = 'Бахчисарайський р-н',
           AREA_NAME_RU = 'Бахчисарайский р-н',
           REGION_ID = 12,
           KOATUU = null
     where AREA_ID = 16;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 17, 17, 'Баштанський р-н', 'Баштанский р-н', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 17,
           AREA_NAME = 'Баштанський р-н',
           AREA_NAME_RU = 'Баштанский р-н',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 17;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 18, 18, 'Бердичівський р-н', 'Бердичевский р-н', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 18,
           AREA_NAME = 'Бердичівський р-н',
           AREA_NAME_RU = 'Бердичевский р-н',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 18;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 19, 19, 'Бердянський р-н', 'Бердянский р-н', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 19,
           AREA_NAME = 'Бердянський р-н',
           AREA_NAME_RU = 'Бердянский р-н',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 19;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 20, 20, 'Берегівський р-н', 'Береговский р-н', 6, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 20,
           AREA_NAME = 'Берегівський р-н',
           AREA_NAME_RU = 'Береговский р-н',
           REGION_ID = 6,
           KOATUU = null
     where AREA_ID = 20;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 21, 21, 'Бережанський р-н', 'Бережанский р-н', 21, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 21,
           AREA_NAME = 'Бережанський р-н',
           AREA_NAME_RU = 'Бережанский р-н',
           REGION_ID = 21,
           KOATUU = null
     where AREA_ID = 21;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 22, 22, 'Березанський р-н', 'Березанский р-н', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 22,
           AREA_NAME = 'Березанський р-н',
           AREA_NAME_RU = 'Березанский р-н',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 22;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 23, 23, 'Березівський р-н', 'Березовский р-н', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 23,
           AREA_NAME = 'Березівський р-н',
           AREA_NAME_RU = 'Березовский р-н',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 23;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 24, 24, 'Березнегуватський р-н', 'Березнеговатский р-н', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 24,
           AREA_NAME = 'Березнегуватський р-н',
           AREA_NAME_RU = 'Березнеговатский р-н',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 24;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 25, 25, 'Березнівський р-н', 'Березновский р-н', 18, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 25,
           AREA_NAME = 'Березнівський р-н',
           AREA_NAME_RU = 'Березновский р-н',
           REGION_ID = 18,
           KOATUU = null
     where AREA_ID = 25;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 26, 26, 'Бериславський р-н', 'Бериславский р-н', 23, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 26,
           AREA_NAME = 'Бериславський р-н',
           AREA_NAME_RU = 'Бериславский р-н',
           REGION_ID = 23,
           KOATUU = null
     where AREA_ID = 26;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 27, 27, 'Бершадський р-н', 'Бершадский р-н', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 27,
           AREA_NAME = 'Бершадський р-н',
           AREA_NAME_RU = 'Бершадский р-н',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 27;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 28, 28, 'Білгород-Дністровський р-н', 'Белгород-Днестровский р-н', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 28,
           AREA_NAME = 'Білгород-Дністровський р-н',
           AREA_NAME_RU = 'Белгород-Днестровский р-н',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 28;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 29, 29, 'Біловодський р-н', 'Беловодский р-н', 13, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 29,
           AREA_NAME = 'Біловодський р-н',
           AREA_NAME_RU = 'Беловодский р-н',
           REGION_ID = 13,
           KOATUU = null
     where AREA_ID = 29;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 30, 30, 'Білогірський р-н', 'Белогорский р-н', 12, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 30,
           AREA_NAME = 'Білогірський р-н',
           AREA_NAME_RU = 'Белогорский р-н',
           REGION_ID = 12,
           KOATUU = null
     where AREA_ID = 30;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 31, 30, 'Білогірський р-н', 'Белогорский р-н', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 30,
           AREA_NAME = 'Білогірський р-н',
           AREA_NAME_RU = 'Белогорский р-н',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 31;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 32, 31, 'Білозерський р-н', 'Белозерский р-н', 23, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 31,
           AREA_NAME = 'Білозерський р-н',
           AREA_NAME_RU = 'Белозерский р-н',
           REGION_ID = 23,
           KOATUU = null
     where AREA_ID = 32;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 33, 32, 'Білокуракинський р-н', 'Белокуракинский р-н', 13, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 32,
           AREA_NAME = 'Білокуракинський р-н',
           AREA_NAME_RU = 'Белокуракинский р-н',
           REGION_ID = 13,
           KOATUU = null
     where AREA_ID = 33;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 34, 33, 'Білопільський р-н', 'Белопольский р-н', 20, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 33,
           AREA_NAME = 'Білопільський р-н',
           AREA_NAME_RU = 'Белопольский р-н',
           REGION_ID = 20,
           KOATUU = null
     where AREA_ID = 34;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 35, 34, 'Білоцерківський р-н', 'Белоцерковский р-н', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 34,
           AREA_NAME = 'Білоцерківський р-н',
           AREA_NAME_RU = 'Белоцерковский р-н',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 35;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 36, 35, 'Біляївський р-н', 'Беляевский р-н', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 35,
           AREA_NAME = 'Біляївський р-н',
           AREA_NAME_RU = 'Беляевский р-н',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 36;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 37, 36, 'Близнюківський р-н', 'Близнюковский р-н', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 36,
           AREA_NAME = 'Близнюківський р-н',
           AREA_NAME_RU = 'Близнюковский р-н',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 37;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 38, 37, 'Бобринецький р-н', 'Бобринецкий р-н', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 37,
           AREA_NAME = 'Бобринецький р-н',
           AREA_NAME_RU = 'Бобринецкий р-н',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 38;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 39, 38, 'Бобровицький р-н', 'Бобровицкий р-н', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 38,
           AREA_NAME = 'Бобровицький р-н',
           AREA_NAME_RU = 'Бобровицкий р-н',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 39;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 40, 39, 'Богодухівський р-н', 'Богодуховский р-н', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 39,
           AREA_NAME = 'Богодухівський р-н',
           AREA_NAME_RU = 'Богодуховский р-н',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 40;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 41, 40, 'Богородчанський р-н', 'Богородчанский р-н', 8, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 40,
           AREA_NAME = 'Богородчанський р-н',
           AREA_NAME_RU = 'Богородчанский р-н',
           REGION_ID = 8,
           KOATUU = null
     where AREA_ID = 41;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 42, 41, 'Богуславський р-н', 'Богуславский р-н', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 41,
           AREA_NAME = 'Богуславський р-н',
           AREA_NAME_RU = 'Богуславский р-н',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 42;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 43, 42, 'Болградський р-н', 'Болградский р-н', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 42,
           AREA_NAME = 'Болградський р-н',
           AREA_NAME_RU = 'Болградский р-н',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 43;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 44, 44, 'Борзнянський р-н', 'Борзнянский р-н', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 44,
           AREA_NAME = 'Борзнянський р-н',
           AREA_NAME_RU = 'Борзнянский р-н',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 44;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 45, 45, 'Бориспільський р-н', 'Бориспольский р-н', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 45,
           AREA_NAME = 'Бориспільський р-н',
           AREA_NAME_RU = 'Бориспольский р-н',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 45;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 46, 46, 'Борівський р-н', 'Боровский р-н', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 46,
           AREA_NAME = 'Борівський р-н',
           AREA_NAME_RU = 'Боровский р-н',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 46;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 47, 47, 'Бородянський р-н', 'Бородянский р-н', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 47,
           AREA_NAME = 'Бородянський р-н',
           AREA_NAME_RU = 'Бородянский р-н',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 47;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 48, 48, 'Борщівський р-н', 'Борщевский р-н', 21, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 48,
           AREA_NAME = 'Борщівський р-н',
           AREA_NAME_RU = 'Борщевский р-н',
           REGION_ID = 21,
           KOATUU = null
     where AREA_ID = 48;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 49, 49, 'Братський р-н', 'Братский р-н', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 49,
           AREA_NAME = 'Братський р-н',
           AREA_NAME_RU = 'Братский р-н',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 49;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 50, 50, 'Броварський р-н', 'Броварской р-н', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 50,
           AREA_NAME = 'Броварський р-н',
           AREA_NAME_RU = 'Броварской р-н',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 50;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 51, 51, 'Бродівський р-н', 'Бродовский р-н', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 51,
           AREA_NAME = 'Бродівський р-н',
           AREA_NAME_RU = 'Бродовский р-н',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 51;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 52, 52, 'Брусилівський р-н', 'Брусиловский р-н', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 52,
           AREA_NAME = 'Брусилівський р-н',
           AREA_NAME_RU = 'Брусиловский р-н',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 52;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 53, 53, 'Буринський р-н', 'Бурынский р-н', 20, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 53,
           AREA_NAME = 'Буринський р-н',
           AREA_NAME_RU = 'Бурынский р-н',
           REGION_ID = 20,
           KOATUU = null
     where AREA_ID = 53;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 54, 54, 'Буський р-н', 'Бусский р-н', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 54,
           AREA_NAME = 'Буський р-н',
           AREA_NAME_RU = 'Бусский р-н',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 54;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 55, 55, 'Бучацький р-н', 'Бучачский р-н', 21, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 55,
           AREA_NAME = 'Бучацький р-н',
           AREA_NAME_RU = 'Бучачский р-н',
           REGION_ID = 21,
           KOATUU = null
     where AREA_ID = 55;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 56, 56, 'Валківський р-н', 'Валковский р-н', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 56,
           AREA_NAME = 'Валківський р-н',
           AREA_NAME_RU = 'Валковский р-н',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 56;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 57, 57, 'Варвинський р-н', 'Варвинский р-н', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 57,
           AREA_NAME = 'Варвинський р-н',
           AREA_NAME_RU = 'Варвинский р-н',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 57;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 58, 58, 'Василівський р-н', 'Васильевский р-н', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 58,
           AREA_NAME = 'Василівський р-н',
           AREA_NAME_RU = 'Васильевский р-н',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 58;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 59, 59, 'Васильківський р-н', 'Васильковский р-н', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 59,
           AREA_NAME = 'Васильківський р-н',
           AREA_NAME_RU = 'Васильковский р-н',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 59;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 60, 59, 'Васильківський р-н', 'Васильковский р-н', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 59,
           AREA_NAME = 'Васильківський р-н',
           AREA_NAME_RU = 'Васильковский р-н',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 60;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 61, 60, 'Великобагачанський р-н', 'Великобагачанский р-н', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 60,
           AREA_NAME = 'Великобагачанський р-н',
           AREA_NAME_RU = 'Великобагачанский р-н',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 61;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 62, 61, 'Великоберезнянський р-н', 'Великоберезнянский р-н', 6, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 61,
           AREA_NAME = 'Великоберезнянський р-н',
           AREA_NAME_RU = 'Великоберезнянский р-н',
           REGION_ID = 6,
           KOATUU = null
     where AREA_ID = 62;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 63, 62, 'Великобілозерський р-н', 'Великобелозерский р-н', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 62,
           AREA_NAME = 'Великобілозерський р-н',
           AREA_NAME_RU = 'Великобелозерский р-н',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 63;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 64, 63, 'Великобурлуцький р-н', 'Великобурлукский р-н', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 63,
           AREA_NAME = 'Великобурлуцький р-н',
           AREA_NAME_RU = 'Великобурлукский р-н',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 64;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 65, 64, 'Великолепетиський р-н', 'Великолепетихский р-н', 23, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 64,
           AREA_NAME = 'Великолепетиський р-н',
           AREA_NAME_RU = 'Великолепетихский р-н',
           REGION_ID = 23,
           KOATUU = null
     where AREA_ID = 65;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 66, 65, 'Великомихайлівський р-н', 'Великомихайловский р-н', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 65,
           AREA_NAME = 'Великомихайлівський р-н',
           AREA_NAME_RU = 'Великомихайловский р-н',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 66;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 67, 66, 'Великоновосілківський р-н', 'Великоновоселковский р-н', 4, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 66,
           AREA_NAME = 'Великоновосілківський р-н',
           AREA_NAME_RU = 'Великоновоселковский р-н',
           REGION_ID = 4,
           KOATUU = null
     where AREA_ID = 67;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 68, 67, 'Великоолександрівський р-н', 'Великоалександровский р-н', 23, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 67,
           AREA_NAME = 'Великоолександрівський р-н',
           AREA_NAME_RU = 'Великоалександровский р-н',
           REGION_ID = 23,
           KOATUU = null
     where AREA_ID = 68;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 69, 68, 'Великописарівський р-н', 'Великописаревский р-н', 20, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 68,
           AREA_NAME = 'Великописарівський р-н',
           AREA_NAME_RU = 'Великописаревский р-н',
           REGION_ID = 20,
           KOATUU = null
     where AREA_ID = 69;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 70, 69, 'Верхньодніпровський р-н', 'Верхнеднепровский р-н', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 69,
           AREA_NAME = 'Верхньодніпровський р-н',
           AREA_NAME_RU = 'Верхнеднепровский р-н',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 70;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 71, 70, 'Верхньорогачицький р-н', 'Верхнерогачикский р-н', 23, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 70,
           AREA_NAME = 'Верхньорогачицький р-н',
           AREA_NAME_RU = 'Верхнерогачикский р-н',
           REGION_ID = 23,
           KOATUU = null
     where AREA_ID = 71;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 72, 71, 'Верховинський р-н', 'Верховинский р-н', 8, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 71,
           AREA_NAME = 'Верховинський р-н',
           AREA_NAME_RU = 'Верховинский р-н',
           REGION_ID = 8,
           KOATUU = null
     where AREA_ID = 72;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 73, 72, 'Веселинівський р-н', 'Веселиновский р-н', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 72,
           AREA_NAME = 'Веселинівський р-н',
           AREA_NAME_RU = 'Веселиновский р-н',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 73;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 74, 73, 'Веселівський р-н', 'Веселовский р-н', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 73,
           AREA_NAME = 'Веселівський р-н',
           AREA_NAME_RU = 'Веселовский р-н',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 74;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 75, 74, 'Вижницький р-н', 'Вижницкий р-н', 26, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 74,
           AREA_NAME = 'Вижницький р-н',
           AREA_NAME_RU = 'Вижницкий р-н',
           REGION_ID = 26,
           KOATUU = null
     where AREA_ID = 75;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 76, 75, 'Виноградівський р-н', 'Виноградовский р-н', 6, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 75,
           AREA_NAME = 'Виноградівський р-н',
           AREA_NAME_RU = 'Виноградовский р-н',
           REGION_ID = 6,
           KOATUU = null
     where AREA_ID = 76;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 77, 76, 'Високопільський р-н', 'Высокопольский р-н', 23, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 76,
           AREA_NAME = 'Високопільський р-н',
           AREA_NAME_RU = 'Высокопольский р-н',
           REGION_ID = 23,
           KOATUU = null
     where AREA_ID = 77;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 78, 77, 'Вишгородський р-н', 'Вышгородский р-н', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 77,
           AREA_NAME = 'Вишгородський р-н',
           AREA_NAME_RU = 'Вышгородский р-н',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 78;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 79, 78, 'Вільнянський р-н', 'Вольнянский р-н', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 78,
           AREA_NAME = 'Вільнянський р-н',
           AREA_NAME_RU = 'Вольнянский р-н',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 79;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 80, 79, 'Вільшанський р-н', 'Ольшанский р-н', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 79,
           AREA_NAME = 'Вільшанський р-н',
           AREA_NAME_RU = 'Ольшанский р-н',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 80;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 81, 80, 'Вінницький р-н', 'Винницкий р-н', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 80,
           AREA_NAME = 'Вінницький р-н',
           AREA_NAME_RU = 'Винницкий р-н',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 81;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 82, 81, 'Віньковецький р-н', 'Виньковецкий р-н', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 81,
           AREA_NAME = 'Віньковецький р-н',
           AREA_NAME_RU = 'Виньковецкий р-н',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 82;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 83, 82, 'Вовчанський р-н', 'Вовчанский р-н', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 82,
           AREA_NAME = 'Вовчанський р-н',
           AREA_NAME_RU = 'Вовчанский р-н',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 83;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 84, 83, 'Вознесенський р-н', 'Вознесенский р-н', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 83,
           AREA_NAME = 'Вознесенський р-н',
           AREA_NAME_RU = 'Вознесенский р-н',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 84;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 85, 84, 'Волноваський р-н', 'Волновахский р-н', 4, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 84,
           AREA_NAME = 'Волноваський р-н',
           AREA_NAME_RU = 'Волновахский р-н',
           REGION_ID = 4,
           KOATUU = null
     where AREA_ID = 85;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 86, 85, 'Воловецький р-н', 'Воловецкий р-н', 6, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 85,
           AREA_NAME = 'Воловецький р-н',
           AREA_NAME_RU = 'Воловецкий р-н',
           REGION_ID = 6,
           KOATUU = null
     where AREA_ID = 86;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 87, 86, 'Володарський р-н', 'Володарский р-н', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 86,
           AREA_NAME = 'Володарський р-н',
           AREA_NAME_RU = 'Володарский р-н',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 87;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 88, 86, 'Володарський р-н', 'Володарский р-н', 4, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 86,
           AREA_NAME = 'Володарський р-н',
           AREA_NAME_RU = 'Володарский р-н',
           REGION_ID = 4,
           KOATUU = null
     where AREA_ID = 88;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 89, 87, 'Володарсько-Волинський р-н', 'Володарско-Волынский р-н', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 87,
           AREA_NAME = 'Володарсько-Волинський р-н',
           AREA_NAME_RU = 'Володарско-Волынский р-н',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 89;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 90, 88, 'Володимир-Волинський р-н', 'Владимир-Волынский р-н', 2, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 88,
           AREA_NAME = 'Володимир-Волинський р-н',
           AREA_NAME_RU = 'Владимир-Волынский р-н',
           REGION_ID = 2,
           KOATUU = null
     where AREA_ID = 90;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 91, 89, 'Володимирецький р-н', 'Владимирецкий р-н', 18, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 89,
           AREA_NAME = 'Володимирецький р-н',
           AREA_NAME_RU = 'Владимирецкий р-н',
           REGION_ID = 18,
           KOATUU = null
     where AREA_ID = 91;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 92, 90, 'Волочиський р-н', 'Волочисский р-н', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 90,
           AREA_NAME = 'Волочиський р-н',
           AREA_NAME_RU = 'Волочисский р-н',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 92;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 93, 91, 'Врадіївський р-н', 'Врадиевский р-н', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 91,
           AREA_NAME = 'Врадіївський р-н',
           AREA_NAME_RU = 'Врадиевский р-н',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 93;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 94, 92, 'Гадяцький р-н', 'Гадячский р-н', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 92,
           AREA_NAME = 'Гадяцький р-н',
           AREA_NAME_RU = 'Гадячский р-н',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 94;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 95, 93, 'Гайворонський р-н', 'Гайворонский р-н', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 93,
           AREA_NAME = 'Гайворонський р-н',
           AREA_NAME_RU = 'Гайворонский р-н',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 95;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 96, 94, 'Гайсинський р-н', 'Гайсинский р-н', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 94,
           AREA_NAME = 'Гайсинський р-н',
           AREA_NAME_RU = 'Гайсинский р-н',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 96;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 97, 95, 'Галицький р-н', 'Галичский р-н', 8, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 95,
           AREA_NAME = 'Галицький р-н',
           AREA_NAME_RU = 'Галичский р-н',
           REGION_ID = 8,
           KOATUU = null
     where AREA_ID = 97;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 98, 96, 'Генічеський р-н', 'Генический р-н', 23, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 96,
           AREA_NAME = 'Генічеський р-н',
           AREA_NAME_RU = 'Генический р-н',
           REGION_ID = 23,
           KOATUU = null
     where AREA_ID = 98;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 99, 97, 'Герцаївський р-н', 'Герцаевский р-н', 26, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 97,
           AREA_NAME = 'Герцаївський р-н',
           AREA_NAME_RU = 'Герцаевский р-н',
           REGION_ID = 26,
           KOATUU = null
     where AREA_ID = 99;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 100, 98, 'Глибоцький р-н', 'Глыбокский р-н', 26, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 98,
           AREA_NAME = 'Глибоцький р-н',
           AREA_NAME_RU = 'Глыбокский р-н',
           REGION_ID = 26,
           KOATUU = null
     where AREA_ID = 100;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 101, 99, 'Глобинський р-н', 'Глобинский р-н', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 99,
           AREA_NAME = 'Глобинський р-н',
           AREA_NAME_RU = 'Глобинский р-н',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 101;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 102, 100, 'Глухівський р-н', 'Глуховский р-н', 20, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 100,
           AREA_NAME = 'Глухівський р-н',
           AREA_NAME_RU = 'Глуховский р-н',
           REGION_ID = 20,
           KOATUU = null
     where AREA_ID = 102;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 103, 101, 'Голованівський р-н', 'Голованевский р-н', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 101,
           AREA_NAME = 'Голованівський р-н',
           AREA_NAME_RU = 'Голованевский р-н',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 103;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 104, 102, 'Голопристанський р-н', 'Голопристанский р-н', 23, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 102,
           AREA_NAME = 'Голопристанський р-н',
           AREA_NAME_RU = 'Голопристанский р-н',
           REGION_ID = 23,
           KOATUU = null
     where AREA_ID = 104;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 105, 103, 'Горностаївський р-н', 'Горностаевский р-н', 23, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 103,
           AREA_NAME = 'Горностаївський р-н',
           AREA_NAME_RU = 'Горностаевский р-н',
           REGION_ID = 23,
           KOATUU = null
     where AREA_ID = 105;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 106, 104, 'Городенківський р-н', 'Городенковский р-н', 8, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 104,
           AREA_NAME = 'Городенківський р-н',
           AREA_NAME_RU = 'Городенковский р-н',
           REGION_ID = 8,
           KOATUU = null
     where AREA_ID = 106;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 107, 105, 'Городищенський р-н', 'Городищенский р-н', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 105,
           AREA_NAME = 'Городищенський р-н',
           AREA_NAME_RU = 'Городищенский р-н',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 107;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 108, 106, 'Городнянський р-н', 'Городнянский р-н', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 106,
           AREA_NAME = 'Городнянський р-н',
           AREA_NAME_RU = 'Городнянский р-н',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 108;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 109, 107, 'Городоцький р-н', 'Городокский р-н', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 107,
           AREA_NAME = 'Городоцький р-н',
           AREA_NAME_RU = 'Городокский р-н',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 109;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 110, 107, 'Городоцький р-н', 'Городокский р-н', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 107,
           AREA_NAME = 'Городоцький р-н',
           AREA_NAME_RU = 'Городокский р-н',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 110;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 111, 108, 'Горохівський р-н', 'Гороховский р-н', 2, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 108,
           AREA_NAME = 'Горохівський р-н',
           AREA_NAME_RU = 'Гороховский р-н',
           REGION_ID = 2,
           KOATUU = null
     where AREA_ID = 111;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 112, 109, 'Гощанський р-н', 'Гощанский р-н', 18, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 109,
           AREA_NAME = 'Гощанський р-н',
           AREA_NAME_RU = 'Гощанский р-н',
           REGION_ID = 18,
           KOATUU = null
     where AREA_ID = 112;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 113, 110, 'Гребінківський р-н', 'Гребенковский р-н', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 110,
           AREA_NAME = 'Гребінківський р-н',
           AREA_NAME_RU = 'Гребенковский р-н',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 113;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 114, 111, 'Гуляйпільський р-н', 'Гуляйпольский р-н', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 111,
           AREA_NAME = 'Гуляйпільський р-н',
           AREA_NAME_RU = 'Гуляйпольский р-н',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 114;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 115, 112, 'Гусятинський р-н', 'Гусятинский р-н', 21, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 112,
           AREA_NAME = 'Гусятинський р-н',
           AREA_NAME_RU = 'Гусятинский р-н',
           REGION_ID = 21,
           KOATUU = null
     where AREA_ID = 115;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 116, 113, 'Дворічанський р-н', 'Двуречанский р-н', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 113,
           AREA_NAME = 'Дворічанський р-н',
           AREA_NAME_RU = 'Двуречанский р-н',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 116;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 117, 114, 'Демидівський р-н', 'Демидовский р-н', 18, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 114,
           AREA_NAME = 'Демидівський р-н',
           AREA_NAME_RU = 'Демидовский р-н',
           REGION_ID = 18,
           KOATUU = null
     where AREA_ID = 117;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 118, 115, 'Деражнянський р-н', 'Деражнянский р-н', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 115,
           AREA_NAME = 'Деражнянський р-н',
           AREA_NAME_RU = 'Деражнянский р-н',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 118;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 119, 116, 'Дергачівський р-н', 'Дергачевский р-н', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 116,
           AREA_NAME = 'Дергачівський р-н',
           AREA_NAME_RU = 'Дергачевский р-н',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 119;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 120, 117, 'Джанкойський р-н', 'Джанкойский р-н', 12, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 117,
           AREA_NAME = 'Джанкойський р-н',
           AREA_NAME_RU = 'Джанкойский р-н',
           REGION_ID = 12,
           KOATUU = null
     where AREA_ID = 120;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 121, 118, 'Диканський р-н', 'Диканьский р-н', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 118,
           AREA_NAME = 'Диканський р-н',
           AREA_NAME_RU = 'Диканьский р-н',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 121;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 122, 119, 'Дніпропетровський р-н', 'Днепропетровский р-н', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 119,
           AREA_NAME = 'Дніпропетровський р-н',
           AREA_NAME_RU = 'Днепропетровский р-н',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 122;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 123, 120, 'Добровеличківський р-н', 'Добровеличковский р-н', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 120,
           AREA_NAME = 'Добровеличківський р-н',
           AREA_NAME_RU = 'Добровеличковский р-н',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 123;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 124, 121, 'Добропільський р-н', 'Добропольский р-н', 4, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 121,
           AREA_NAME = 'Добропільський р-н',
           AREA_NAME_RU = 'Добропольский р-н',
           REGION_ID = 4,
           KOATUU = null
     where AREA_ID = 124;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 125, 122, 'Долинський р-н', 'Долинский р-н', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 122,
           AREA_NAME = 'Долинський р-н',
           AREA_NAME_RU = 'Долинский р-н',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 125;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 126, 122, 'Долинський р-н', 'Долинский р-н', 8, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 122,
           AREA_NAME = 'Долинський р-н',
           AREA_NAME_RU = 'Долинский р-н',
           REGION_ID = 8,
           KOATUU = null
     where AREA_ID = 126;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 127, 123, 'Доманівський р-н', 'Доманевский р-н', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 123,
           AREA_NAME = 'Доманівський р-н',
           AREA_NAME_RU = 'Доманевский р-н',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 127;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 128, 124, 'Драбівський р-н', 'Драбовский р-н', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 124,
           AREA_NAME = 'Драбівський р-н',
           AREA_NAME_RU = 'Драбовский р-н',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 128;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 129, 125, 'Дрогобицький р-н', 'Дрогобычский р-н', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 125,
           AREA_NAME = 'Дрогобицький р-н',
           AREA_NAME_RU = 'Дрогобычский р-н',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 129;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 130, 126, 'Дубенський р-н', 'Дубенский р-н', 18, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 126,
           AREA_NAME = 'Дубенський р-н',
           AREA_NAME_RU = 'Дубенский р-н',
           REGION_ID = 18,
           KOATUU = null
     where AREA_ID = 130;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 131, 127, 'Дубровицький р-н', 'Дубровицкий р-н', 18, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 127,
           AREA_NAME = 'Дубровицький р-н',
           AREA_NAME_RU = 'Дубровицкий р-н',
           REGION_ID = 18,
           KOATUU = null
     where AREA_ID = 131;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 132, 128, 'Дунаєвецький р-н', 'Дунаевецкий р-н', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 128,
           AREA_NAME = 'Дунаєвецький р-н',
           AREA_NAME_RU = 'Дунаевецкий р-н',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 132;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 133, 129, 'Єланецький р-н', 'Еланецкий р-н', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 129,
           AREA_NAME = 'Єланецький р-н',
           AREA_NAME_RU = 'Еланецкий р-н',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 133;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 134, 130, 'Ємільчинський р-н', 'Емильчинский р-н', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 130,
           AREA_NAME = 'Ємільчинський р-н',
           AREA_NAME_RU = 'Емильчинский р-н',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 134;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 135, 131, 'Жашківський р-н', 'Жашковский р-н', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 131,
           AREA_NAME = 'Жашківський р-н',
           AREA_NAME_RU = 'Жашковский р-н',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 135;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 136, 132, 'Жидачівський р-н', 'Жидачовский р-н', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 132,
           AREA_NAME = 'Жидачівський р-н',
           AREA_NAME_RU = 'Жидачовский р-н',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 136;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 137, 133, 'Житомирський р-н', 'Житомирский р-н', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 133,
           AREA_NAME = 'Житомирський р-н',
           AREA_NAME_RU = 'Житомирский р-н',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 137;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 138, 134, 'Жмеринський р-н', 'Жмеринский р-н', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 134,
           AREA_NAME = 'Жмеринський р-н',
           AREA_NAME_RU = 'Жмеринский р-н',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 138;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 139, 135, 'Жовківський р-н', 'Жовковский р-н', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 135,
           AREA_NAME = 'Жовківський р-н',
           AREA_NAME_RU = 'Жовковский р-н',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 139;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 140, 136, 'Жовтневий р-н', 'Жовтневый р-н', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 136,
           AREA_NAME = 'Жовтневий р-н',
           AREA_NAME_RU = 'Жовтневый р-н',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 140;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 141, 137, 'Заліщицький р-н', 'Залещицкий р-н', 21, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 137,
           AREA_NAME = 'Заліщицький р-н',
           AREA_NAME_RU = 'Залещицкий р-н',
           REGION_ID = 21,
           KOATUU = null
     where AREA_ID = 141;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 142, 138, 'Запорізький р-н', 'Запорожский р-н', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 138,
           AREA_NAME = 'Запорізький р-н',
           AREA_NAME_RU = 'Запорожский р-н',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 142;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 143, 139, 'Зарічненський р-н', 'Заречненский р-н', 18, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 139,
           AREA_NAME = 'Зарічненський р-н',
           AREA_NAME_RU = 'Заречненский р-н',
           REGION_ID = 18,
           KOATUU = null
     where AREA_ID = 143;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 144, 140, 'Заставнівський р-н', 'Заставновский р-н', 26, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 140,
           AREA_NAME = 'Заставнівський р-н',
           AREA_NAME_RU = 'Заставновский р-н',
           REGION_ID = 26,
           KOATUU = null
     where AREA_ID = 144;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 145, 141, 'Зачепилівський р-н', 'Зачепиловский р-н', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 141,
           AREA_NAME = 'Зачепилівський р-н',
           AREA_NAME_RU = 'Зачепиловский р-н',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 145;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 146, 142, 'Збаразький р-н', 'Збаражский р-н', 21, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 142,
           AREA_NAME = 'Збаразький р-н',
           AREA_NAME_RU = 'Збаражский р-н',
           REGION_ID = 21,
           KOATUU = null
     where AREA_ID = 146;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 147, 143, 'Зборівський р-н', 'Зборовский р-н', 21, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 143,
           AREA_NAME = 'Зборівський р-н',
           AREA_NAME_RU = 'Зборовский р-н',
           REGION_ID = 21,
           KOATUU = null
     where AREA_ID = 147;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 148, 144, 'Звенигородський р-н', 'Звенигородский р-н', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 144,
           AREA_NAME = 'Звенигородський р-н',
           AREA_NAME_RU = 'Звенигородский р-н',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 148;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 149, 145, 'Згурівський р-н', 'Згуровский р-н', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 145,
           AREA_NAME = 'Згурівський р-н',
           AREA_NAME_RU = 'Згуровский р-н',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 149;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 150, 146, 'Здолбунівський р-н', 'Здолбуновский р-н', 18, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 146,
           AREA_NAME = 'Здолбунівський р-н',
           AREA_NAME_RU = 'Здолбуновский р-н',
           REGION_ID = 18,
           KOATUU = null
     where AREA_ID = 150;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 151, 147, 'Зіньківський р-н', 'Зеньковский р-н', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 147,
           AREA_NAME = 'Зіньківський р-н',
           AREA_NAME_RU = 'Зеньковский р-н',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 151;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 152, 148, 'Зміївський р-н', 'Змиевский р-н', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 148,
           AREA_NAME = 'Зміївський р-н',
           AREA_NAME_RU = 'Змиевский р-н',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 152;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 153, 149, 'Знам’янський р-н', 'Знаменский р-н', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 149,
           AREA_NAME = 'Знам’янський р-н',
           AREA_NAME_RU = 'Знаменский р-н',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 153;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 154, 150, 'Золотоніський р-н', 'Золотоношский р-н', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 150,
           AREA_NAME = 'Золотоніський р-н',
           AREA_NAME_RU = 'Золотоношский р-н',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 154;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 155, 151, 'Золочівський р-н', 'Золочевский р-н', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 151,
           AREA_NAME = 'Золочівський р-н',
           AREA_NAME_RU = 'Золочевский р-н',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 155;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 156, 151, 'Золочівський р-н', 'Золочевский р-н', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 151,
           AREA_NAME = 'Золочівський р-н',
           AREA_NAME_RU = 'Золочевский р-н',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 156;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 157, 152, 'Іваничівський р-н', 'Иваничевский р-н', 2, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 152,
           AREA_NAME = 'Іваничівський р-н',
           AREA_NAME_RU = 'Иваничевский р-н',
           REGION_ID = 2,
           KOATUU = null
     where AREA_ID = 157;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 158, 153, 'Іванівський р-н', 'Ивановский р-н', 23, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 153,
           AREA_NAME = 'Іванівський р-н',
           AREA_NAME_RU = 'Ивановский р-н',
           REGION_ID = 23,
           KOATUU = null
     where AREA_ID = 158;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 159, 153, 'Іванівський р-н', 'Ивановский р-н', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 153,
           AREA_NAME = 'Іванівський р-н',
           AREA_NAME_RU = 'Ивановский р-н',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 159;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 160, 154, 'Іванківський р-н', 'Иванковский р-н', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 154,
           AREA_NAME = 'Іванківський р-н',
           AREA_NAME_RU = 'Иванковский р-н',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 160;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 161, 155, 'Ізмаїльський р-н', 'Измаильский р-н', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 155,
           AREA_NAME = 'Ізмаїльський р-н',
           AREA_NAME_RU = 'Измаильский р-н',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 161;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 162, 156, 'Ізюмський р-н', 'Изюмский р-н', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 156,
           AREA_NAME = 'Ізюмський р-н',
           AREA_NAME_RU = 'Изюмский р-н',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 162;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 163, 157, 'Ізяславський р-н', 'Изяславский р-н', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 157,
           AREA_NAME = 'Ізяславський р-н',
           AREA_NAME_RU = 'Изяславский р-н',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 163;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 164, 158, 'Іллінецький р-н', 'Ильинецкий р-н', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 158,
           AREA_NAME = 'Іллінецький р-н',
           AREA_NAME_RU = 'Ильинецкий р-н',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 164;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 165, 159, 'Іршавський р-н', 'Иршавский р-н', 6, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 159,
           AREA_NAME = 'Іршавський р-н',
           AREA_NAME_RU = 'Иршавский р-н',
           REGION_ID = 6,
           KOATUU = null
     where AREA_ID = 165;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 166, 160, 'Ічнянський р-н', 'Ичнянский р-н', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 160,
           AREA_NAME = 'Ічнянський р-н',
           AREA_NAME_RU = 'Ичнянский р-н',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 166;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 167, 161, 'Кагарлицький р-н', 'Кагарлыкский р-н', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 161,
           AREA_NAME = 'Кагарлицький р-н',
           AREA_NAME_RU = 'Кагарлыкский р-н',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 167;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 168, 162, 'Казанківський р-н', 'Казанковский р-н', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 162,
           AREA_NAME = 'Казанківський р-н',
           AREA_NAME_RU = 'Казанковский р-н',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 168;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 169, 163, 'Каланчацький р-н', 'Каланчакский р-н', 23, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 163,
           AREA_NAME = 'Каланчацький р-н',
           AREA_NAME_RU = 'Каланчакский р-н',
           REGION_ID = 23,
           KOATUU = null
     where AREA_ID = 169;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 170, 164, 'Калинівський р-н', 'Калиновский р-н', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 164,
           AREA_NAME = 'Калинівський р-н',
           AREA_NAME_RU = 'Калиновский р-н',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 170;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 171, 165, 'Калуський р-н', 'Калушский р-н', 8, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 165,
           AREA_NAME = 'Калуський р-н',
           AREA_NAME_RU = 'Калушский р-н',
           REGION_ID = 8,
           KOATUU = null
     where AREA_ID = 171;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 172, 166, 'Кам’янець-Подільський р-н', 'Каменец-Подольский р-н', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 166,
           AREA_NAME = 'Кам’янець-Подільський р-н',
           AREA_NAME_RU = 'Каменец-Подольский р-н',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 172;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 173, 167, 'Кам’янка-Бузький р-н', 'Каменка-Бужский р-н', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 167,
           AREA_NAME = 'Кам’янка-Бузький р-н',
           AREA_NAME_RU = 'Каменка-Бужский р-н',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 173;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 174, 168, 'Кам’янський р-н', 'Каменский р-н', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 168,
           AREA_NAME = 'Кам’янський р-н',
           AREA_NAME_RU = 'Каменский р-н',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 174;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 175, 169, 'Кам’янсько-Дніпровський р-н', 'Каменско-Днепровский р-н', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 169,
           AREA_NAME = 'Кам’янсько-Дніпровський р-н',
           AREA_NAME_RU = 'Каменско-Днепровский р-н',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 175;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 176, 170, 'Камінь-Каширський р-н', 'Камень-Каширский р-н', 2, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 170,
           AREA_NAME = 'Камінь-Каширський р-н',
           AREA_NAME_RU = 'Камень-Каширский р-н',
           REGION_ID = 2,
           KOATUU = null
     where AREA_ID = 176;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 177, 171, 'Канівський р-н', 'Каневский р-н', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 171,
           AREA_NAME = 'Канівський р-н',
           AREA_NAME_RU = 'Каневский р-н',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 177;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 178, 172, 'Карлівський р-н', 'Карловский р-н', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 172,
           AREA_NAME = 'Карлівський р-н',
           AREA_NAME_RU = 'Карловский р-н',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 178;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 179, 173, 'Катеринопільський р-н', 'Катеринопольский р-н', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 173,
           AREA_NAME = 'Катеринопільський р-н',
           AREA_NAME_RU = 'Катеринопольский р-н',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 179;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 180, 174, 'Каховський р-н', 'Каховский р-н', 23, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 174,
           AREA_NAME = 'Каховський р-н',
           AREA_NAME_RU = 'Каховский р-н',
           REGION_ID = 23,
           KOATUU = null
     where AREA_ID = 180;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 181, 175, 'Кегичівський р-н', 'Кегичевский р-н', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 175,
           AREA_NAME = 'Кегичівський р-н',
           AREA_NAME_RU = 'Кегичевский р-н',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 181;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 182, 176, 'Кельменецький р-н', 'Кельменецкий р-н', 26, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 176,
           AREA_NAME = 'Кельменецький р-н',
           AREA_NAME_RU = 'Кельменецкий р-н',
           REGION_ID = 26,
           KOATUU = null
     where AREA_ID = 182;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 183, 177, 'Києво-Святошинський р-н', 'Киево-Cвятошинский р-н', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 177,
           AREA_NAME = 'Києво-Святошинський р-н',
           AREA_NAME_RU = 'Киево-Cвятошинский р-н',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 183;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 184, 178, 'Ківерцівський р-н', 'Киверцовский р-н', 2, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 178,
           AREA_NAME = 'Ківерцівський р-н',
           AREA_NAME_RU = 'Киверцовский р-н',
           REGION_ID = 2,
           KOATUU = null
     where AREA_ID = 184;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 185, 179, 'Кілійський р-н', 'Килийский р-н', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 179,
           AREA_NAME = 'Кілійський р-н',
           AREA_NAME_RU = 'Килийский р-н',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 185;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 186, 180, 'Кіровоградський р-н', 'Кировоградский р-н', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 180,
           AREA_NAME = 'Кіровоградський р-н',
           AREA_NAME_RU = 'Кировоградский р-н',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 186;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 187, 181, 'Кіровський р-н', 'Кировский р-н', 12, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 181,
           AREA_NAME = 'Кіровський р-н',
           AREA_NAME_RU = 'Кировский р-н',
           REGION_ID = 12,
           KOATUU = null
     where AREA_ID = 187;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 188, 182, 'Кіцманський р-н', 'Кицманский р-н', 26, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 182,
           AREA_NAME = 'Кіцманський р-н',
           AREA_NAME_RU = 'Кицманский р-н',
           REGION_ID = 26,
           KOATUU = null
     where AREA_ID = 188;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 189, 183, 'Кобеляцький р-н', 'Кобелякский р-н', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 183,
           AREA_NAME = 'Кобеляцький р-н',
           AREA_NAME_RU = 'Кобелякский р-н',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 189;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 190, 184, 'Ковельський р-н', 'Ковельский р-н', 2, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 184,
           AREA_NAME = 'Ковельський р-н',
           AREA_NAME_RU = 'Ковельский р-н',
           REGION_ID = 2,
           KOATUU = null
     where AREA_ID = 190;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 191, 185, 'Кодимський р-н', 'Кодымский р-н', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 185,
           AREA_NAME = 'Кодимський р-н',
           AREA_NAME_RU = 'Кодымский р-н',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 191;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 192, 186, 'Козелецький р-н', 'Козелецкий р-н', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 186,
           AREA_NAME = 'Козелецький р-н',
           AREA_NAME_RU = 'Козелецкий р-н',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 192;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 193, 187, 'Козельщинський р-н', 'Козельщинский р-н', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 187,
           AREA_NAME = 'Козельщинський р-н',
           AREA_NAME_RU = 'Козельщинский р-н',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 193;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 194, 188, 'Козівський р-н', 'Козовский р-н', 21, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 188,
           AREA_NAME = 'Козівський р-н',
           AREA_NAME_RU = 'Козовский р-н',
           REGION_ID = 21,
           KOATUU = null
     where AREA_ID = 194;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 195, 189, 'Козятинський р-н', 'Казатинский р-н', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 189,
           AREA_NAME = 'Козятинський р-н',
           AREA_NAME_RU = 'Казатинский р-н',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 195;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 196, 190, 'Коломацький р-н', 'Коломакский р-н', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 190,
           AREA_NAME = 'Коломацький р-н',
           AREA_NAME_RU = 'Коломакский р-н',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 196;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 197, 191, 'Коломийський р-н', 'Коломыйский р-н', 8, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 191,
           AREA_NAME = 'Коломийський р-н',
           AREA_NAME_RU = 'Коломыйский р-н',
           REGION_ID = 8,
           KOATUU = null
     where AREA_ID = 197;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 198, 192, 'Комінтернівський р-н', 'Коминтерновский р-н', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 192,
           AREA_NAME = 'Комінтернівський р-н',
           AREA_NAME_RU = 'Коминтерновский р-н',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 198;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 199, 193, 'Компаніївський р-н', 'Компанеевский р-н', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 193,
           AREA_NAME = 'Компаніївський р-н',
           AREA_NAME_RU = 'Компанеевский р-н',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 199;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 200, 194, 'Конотопський р-н', 'Конотопский р-н', 20, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 194,
           AREA_NAME = 'Конотопський р-н',
           AREA_NAME_RU = 'Конотопский р-н',
           REGION_ID = 20,
           KOATUU = null
     where AREA_ID = 200;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 201, 195, 'Корецький р-н', 'Корецкий р-н', 18, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 195,
           AREA_NAME = 'Корецький р-н',
           AREA_NAME_RU = 'Корецкий р-н',
           REGION_ID = 18,
           KOATUU = null
     where AREA_ID = 201;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 202, 196, 'Коропський р-н', 'Коропский р-н', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 196,
           AREA_NAME = 'Коропський р-н',
           AREA_NAME_RU = 'Коропский р-н',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 202;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 203, 197, 'Коростенський р-н', 'Коростенский р-н', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 197,
           AREA_NAME = 'Коростенський р-н',
           AREA_NAME_RU = 'Коростенский р-н',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 203;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 204, 198, 'Коростишівський р-н', 'Коростишевский р-н', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 198,
           AREA_NAME = 'Коростишівський р-н',
           AREA_NAME_RU = 'Коростишевский р-н',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 204;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 205, 199, 'Корсунь-Шевченківський р-н', 'Корсунь-Шевченковский р-н', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 199,
           AREA_NAME = 'Корсунь-Шевченківський р-н',
           AREA_NAME_RU = 'Корсунь-Шевченковский р-н',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 205;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 206, 200, 'Корюківський р-н', 'Корюковский р-н', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 200,
           AREA_NAME = 'Корюківський р-н',
           AREA_NAME_RU = 'Корюковский р-н',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 206;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 207, 201, 'Косівський р-н', 'Косовский р-н', 8, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 201,
           AREA_NAME = 'Косівський р-н',
           AREA_NAME_RU = 'Косовский р-н',
           REGION_ID = 8,
           KOATUU = null
     where AREA_ID = 207;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 208, 202, 'Костопільський р-н', 'Костопольский р-н', 18, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 202,
           AREA_NAME = 'Костопільський р-н',
           AREA_NAME_RU = 'Костопольский р-н',
           REGION_ID = 18,
           KOATUU = null
     where AREA_ID = 208;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 209, 203, 'Костянтинівський р-н', 'Константиновский р-н', 4, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 203,
           AREA_NAME = 'Костянтинівський р-н',
           AREA_NAME_RU = 'Константиновский р-н',
           REGION_ID = 4,
           KOATUU = null
     where AREA_ID = 209;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 210, 204, 'Котелевський р-н', 'Котелевский р-н', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 204,
           AREA_NAME = 'Котелевський р-н',
           AREA_NAME_RU = 'Котелевский р-н',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 210;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 211, 205, 'Котовський р-н', 'Котовский р-н', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 205,
           AREA_NAME = 'Котовський р-н',
           AREA_NAME_RU = 'Котовский р-н',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 211;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 212, 206, 'Красилівський р-н', 'Красиловский р-н', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 206,
           AREA_NAME = 'Красилівський р-н',
           AREA_NAME_RU = 'Красиловский р-н',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 212;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 213, 207, 'Красноармійський р-н', 'Красноармейский р-н', 4, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 207,
           AREA_NAME = 'Красноармійський р-н',
           AREA_NAME_RU = 'Красноармейский р-н',
           REGION_ID = 4,
           KOATUU = null
     where AREA_ID = 213;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 214, 208, 'Красногвардійський р-н', 'Красногвардейский р-н', 12, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 208,
           AREA_NAME = 'Красногвардійський р-н',
           AREA_NAME_RU = 'Красногвардейский р-н',
           REGION_ID = 12,
           KOATUU = null
     where AREA_ID = 214;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 215, 209, 'Красноградський р-н', 'Красноградский р-н', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 209,
           AREA_NAME = 'Красноградський р-н',
           AREA_NAME_RU = 'Красноградский р-н',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 215;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 216, 210, 'Краснодонський р-н', 'Краснодонский р-н', 13, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 210,
           AREA_NAME = 'Краснодонський р-н',
           AREA_NAME_RU = 'Краснодонский р-н',
           REGION_ID = 13,
           KOATUU = null
     where AREA_ID = 216;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 217, 211, 'Краснокутський р-н', 'Краснокутский р-н', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 211,
           AREA_NAME = 'Краснокутський р-н',
           AREA_NAME_RU = 'Краснокутский р-н',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 217;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 218, 212, 'Краснолиманський р-н', 'Краснолиманский р-н', 4, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 212,
           AREA_NAME = 'Краснолиманський р-н',
           AREA_NAME_RU = 'Краснолиманский р-н',
           REGION_ID = 4,
           KOATUU = null
     where AREA_ID = 218;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 219, 213, 'Красноокнянський р-н', 'Красноокнянский р-н', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 213,
           AREA_NAME = 'Красноокнянський р-н',
           AREA_NAME_RU = 'Красноокнянский р-н',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 219;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 220, 214, 'Красноперекопський р-н', 'Красноперекопский р-н', 12, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 214,
           AREA_NAME = 'Красноперекопський р-н',
           AREA_NAME_RU = 'Красноперекопский р-н',
           REGION_ID = 12,
           KOATUU = null
     where AREA_ID = 220;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 221, 215, 'Краснопільський р-н', 'Краснопольский р-н', 20, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 215,
           AREA_NAME = 'Краснопільський р-н',
           AREA_NAME_RU = 'Краснопольский р-н',
           REGION_ID = 20,
           KOATUU = null
     where AREA_ID = 221;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 222, 216, 'Кременецький р-н', 'Кременецкий р-н', 21, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 216,
           AREA_NAME = 'Кременецький р-н',
           AREA_NAME_RU = 'Кременецкий р-н',
           REGION_ID = 21,
           KOATUU = null
     where AREA_ID = 222;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 223, 217, 'Кременчуцький р-н', 'Кременчугский р-н', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 217,
           AREA_NAME = 'Кременчуцький р-н',
           AREA_NAME_RU = 'Кременчугский р-н',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 223;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 224, 218, 'Кремінський р-н', 'Кременский р-н', 13, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 218,
           AREA_NAME = 'Кремінський р-н',
           AREA_NAME_RU = 'Кременский р-н',
           REGION_ID = 13,
           KOATUU = null
     where AREA_ID = 224;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 225, 219, 'Кривоозерський р-н', 'Кривоозерский р-н', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 219,
           AREA_NAME = 'Кривоозерський р-н',
           AREA_NAME_RU = 'Кривоозерский р-н',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 225;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 226, 220, 'Криворізький р-н', 'Криворожский р-н', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 220,
           AREA_NAME = 'Криворізький р-н',
           AREA_NAME_RU = 'Криворожский р-н',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 226;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 227, 221, 'Крижопільський р-н', 'Крыжопольский р-н', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 221,
           AREA_NAME = 'Крижопільський р-н',
           AREA_NAME_RU = 'Крыжопольский р-н',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 227;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 228, 222, 'Криничанський р-н', 'Криничанский р-н', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 222,
           AREA_NAME = 'Криничанський р-н',
           AREA_NAME_RU = 'Криничанский р-н',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 228;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 229, 223, 'Кролевецький р-н', 'Кролевецкий р-н', 20, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 223,
           AREA_NAME = 'Кролевецький р-н',
           AREA_NAME_RU = 'Кролевецкий р-н',
           REGION_ID = 20,
           KOATUU = null
     where AREA_ID = 229;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 230, 224, 'Куйбишевський р-н', 'Куйбышевский р-н', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 224,
           AREA_NAME = 'Куйбишевський р-н',
           AREA_NAME_RU = 'Куйбышевский р-н',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 230;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 231, 225, 'Куликівський р-н', 'Куликовский р-н', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 225,
           AREA_NAME = 'Куликівський р-н',
           AREA_NAME_RU = 'Куликовский р-н',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 231;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 232, 226, 'Куп’янський р-н', 'Купянский р-н', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 226,
           AREA_NAME = 'Куп’янський р-н',
           AREA_NAME_RU = 'Купянский р-н',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 232;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 233, 227, 'Лановецький р-н', 'Лановецкий р-н', 21, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 227,
           AREA_NAME = 'Лановецький р-н',
           AREA_NAME_RU = 'Лановецкий р-н',
           REGION_ID = 21,
           KOATUU = null
     where AREA_ID = 233;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 234, 228, 'Лебединський р-н', 'Лебединский р-н', 20, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 228,
           AREA_NAME = 'Лебединський р-н',
           AREA_NAME_RU = 'Лебединский р-н',
           REGION_ID = 20,
           KOATUU = null
     where AREA_ID = 234;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 235, 229, 'Ленінський р-н', 'Ленинский р-н', 12, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 229,
           AREA_NAME = 'Ленінський р-н',
           AREA_NAME_RU = 'Ленинский р-н',
           REGION_ID = 12,
           KOATUU = null
     where AREA_ID = 235;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 236, 230, 'Летичівський р-н', 'Летичевский р-н', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 230,
           AREA_NAME = 'Летичівський р-н',
           AREA_NAME_RU = 'Летичевский р-н',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 236;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 237, 231, 'Липовецький р-н', 'Липовецкий р-н', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 231,
           AREA_NAME = 'Липовецький р-н',
           AREA_NAME_RU = 'Липовецкий р-н',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 237;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 238, 232, 'Липоводолинський р-н', 'Липоводолинский р-н', 20, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 232,
           AREA_NAME = 'Липоводолинський р-н',
           AREA_NAME_RU = 'Липоводолинский р-н',
           REGION_ID = 20,
           KOATUU = null
     where AREA_ID = 238;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 239, 233, 'Лисянський р-н', 'Лысянский р-н', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 233,
           AREA_NAME = 'Лисянський р-н',
           AREA_NAME_RU = 'Лысянский р-н',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 239;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 240, 234, 'Літинський р-н', 'Литинский р-н', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 234,
           AREA_NAME = 'Літинський р-н',
           AREA_NAME_RU = 'Литинский р-н',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 240;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 241, 235, 'Лозівський р-н', 'Лозовский р-н', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 235,
           AREA_NAME = 'Лозівський р-н',
           AREA_NAME_RU = 'Лозовский р-н',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 241;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 242, 236, 'Локачинський р-н', 'Локачинский р-н', 2, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 236,
           AREA_NAME = 'Локачинський р-н',
           AREA_NAME_RU = 'Локачинский р-н',
           REGION_ID = 2,
           KOATUU = null
     where AREA_ID = 242;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 243, 237, 'Лохвицький р-н', 'Лохвицкий р-н', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 237,
           AREA_NAME = 'Лохвицький р-н',
           AREA_NAME_RU = 'Лохвицкий р-н',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 243;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 244, 238, 'Лубенський р-н', 'Лубенский р-н', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 238,
           AREA_NAME = 'Лубенський р-н',
           AREA_NAME_RU = 'Лубенский р-н',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 244;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 245, 239, 'Лугинський р-н', 'Лугинский р-н', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 239,
           AREA_NAME = 'Лугинський р-н',
           AREA_NAME_RU = 'Лугинский р-н',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 245;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 246, 240, 'Лутугинський р-н', 'Лутугинский р-н', 13, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 240,
           AREA_NAME = 'Лутугинський р-н',
           AREA_NAME_RU = 'Лутугинский р-н',
           REGION_ID = 13,
           KOATUU = null
     where AREA_ID = 246;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 247, 241, 'Луцький р-н', 'Луцкий р-н', 2, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 241,
           AREA_NAME = 'Луцький р-н',
           AREA_NAME_RU = 'Луцкий р-н',
           REGION_ID = 2,
           KOATUU = null
     where AREA_ID = 247;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 248, 242, 'Любарський р-н', 'Любарский р-н', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 242,
           AREA_NAME = 'Любарський р-н',
           AREA_NAME_RU = 'Любарский р-н',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 248;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 249, 243, 'Любашівський р-н', 'Любашевский р-н', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 243,
           AREA_NAME = 'Любашівський р-н',
           AREA_NAME_RU = 'Любашевский р-н',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 249;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 250, 244, 'Любешівський р-н', 'Любешовский р-н', 2, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 244,
           AREA_NAME = 'Любешівський р-н',
           AREA_NAME_RU = 'Любешовский р-н',
           REGION_ID = 2,
           KOATUU = null
     where AREA_ID = 250;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 251, 245, 'Любомльський р-н', 'Любомльский р-н', 2, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 245,
           AREA_NAME = 'Любомльський р-н',
           AREA_NAME_RU = 'Любомльский р-н',
           REGION_ID = 2,
           KOATUU = null
     where AREA_ID = 251;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 252, 246, 'Магдалинівський р-н', 'Магдалиновский р-н', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 246,
           AREA_NAME = 'Магдалинівський р-н',
           AREA_NAME_RU = 'Магдалиновский р-н',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 252;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 253, 247, 'Макарівський р-н', 'Макаровский р-н', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 247,
           AREA_NAME = 'Макарівський р-н',
           AREA_NAME_RU = 'Макаровский р-н',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 253;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 254, 248, 'Малинський р-н', 'Малинский р-н', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 248,
           AREA_NAME = 'Малинський р-н',
           AREA_NAME_RU = 'Малинский р-н',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 254;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 255, 249, 'Маловисківський р-н', 'Маловисковский р-н', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 249,
           AREA_NAME = 'Маловисківський р-н',
           AREA_NAME_RU = 'Маловисковский р-н',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 255;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 256, 250, 'Маневицький р-н', 'Маневичский р-н', 2, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 250,
           AREA_NAME = 'Маневицький р-н',
           AREA_NAME_RU = 'Маневичский р-н',
           REGION_ID = 2,
           KOATUU = null
     where AREA_ID = 256;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 257, 251, 'Маньківський р-н', 'Маньковский р-н', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 251,
           AREA_NAME = 'Маньківський р-н',
           AREA_NAME_RU = 'Маньковский р-н',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 257;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 258, 252, 'Мар’їнський р-н', 'Марьинский р-н', 4, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 252,
           AREA_NAME = 'Мар’їнський р-н',
           AREA_NAME_RU = 'Марьинский р-н',
           REGION_ID = 4,
           KOATUU = null
     where AREA_ID = 258;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 259, 253, 'Марківський р-н', 'Марковский р-н', 13, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 253,
           AREA_NAME = 'Марківський р-н',
           AREA_NAME_RU = 'Марковский р-н',
           REGION_ID = 13,
           KOATUU = null
     where AREA_ID = 259;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 260, 254, 'Машівський р-н', 'Машевский р-н', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 254,
           AREA_NAME = 'Машівський р-н',
           AREA_NAME_RU = 'Машевский р-н',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 260;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 261, 255, 'Межівський р-н', 'Меживский р-н', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 255,
           AREA_NAME = 'Межівський р-н',
           AREA_NAME_RU = 'Меживский р-н',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 261;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 262, 256, 'Мелітопольський р-н', 'Мелитопольский р-н', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 256,
           AREA_NAME = 'Мелітопольський р-н',
           AREA_NAME_RU = 'Мелитопольский р-н',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 262;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 263, 257, 'Менський р-н', 'Менский р-н', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 257,
           AREA_NAME = 'Менський р-н',
           AREA_NAME_RU = 'Менский р-н',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 263;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 264, 258, 'Миколаївський р-н', 'Николаевский р-н', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 258,
           AREA_NAME = 'Миколаївський р-н',
           AREA_NAME_RU = 'Николаевский р-н',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 264;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 265, 258, 'Миколаївський р-н', 'Николаевский р-н', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 258,
           AREA_NAME = 'Миколаївський р-н',
           AREA_NAME_RU = 'Николаевский р-н',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 265;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 266, 258, 'Миколаївський р-н', 'Николаевский р-н', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 258,
           AREA_NAME = 'Миколаївський р-н',
           AREA_NAME_RU = 'Николаевский р-н',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 266;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 267, 259, 'Миргородський р-н', 'Миргородский р-н', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 259,
           AREA_NAME = 'Миргородський р-н',
           AREA_NAME_RU = 'Миргородский р-н',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 267;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 268, 260, 'Миронівський р-н', 'Мироновский р-н', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 260,
           AREA_NAME = 'Миронівський р-н',
           AREA_NAME_RU = 'Мироновский р-н',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 268;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 269, 261, 'Михайлівський р-н', 'Михайловский р-н', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 261,
           AREA_NAME = 'Михайлівський р-н',
           AREA_NAME_RU = 'Михайловский р-н',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 269;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 270, 262, 'Міжгірський р-н', 'Межгорский р-н', 6, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 262,
           AREA_NAME = 'Міжгірський р-н',
           AREA_NAME_RU = 'Межгорский р-н',
           REGION_ID = 6,
           KOATUU = null
     where AREA_ID = 270;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 271, 263, 'Міловський р-н', 'Меловский р-н', 13, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 263,
           AREA_NAME = 'Міловський р-н',
           AREA_NAME_RU = 'Меловский р-н',
           REGION_ID = 13,
           KOATUU = null
     where AREA_ID = 271;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 272, 264, 'Млинівський р-н', 'Млиновский р-н', 18, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 264,
           AREA_NAME = 'Млинівський р-н',
           AREA_NAME_RU = 'Млиновский р-н',
           REGION_ID = 18,
           KOATUU = null
     where AREA_ID = 272;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 273, 265, 'Могилів-Подільський р-н', 'Могилев-Подольский р-н', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 265,
           AREA_NAME = 'Могилів-Подільський р-н',
           AREA_NAME_RU = 'Могилев-Подольский р-н',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 273;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 274, 266, 'Монастириський р-н', 'Монастыриский р-н', 21, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 266,
           AREA_NAME = 'Монастириський р-н',
           AREA_NAME_RU = 'Монастыриский р-н',
           REGION_ID = 21,
           KOATUU = null
     where AREA_ID = 274;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 275, 267, 'Монастирищенський р-н', 'Монастырищенский р-н', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 267,
           AREA_NAME = 'Монастирищенський р-н',
           AREA_NAME_RU = 'Монастырищенский р-н',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 275;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 276, 268, 'Мостиський р-н', 'Мостисский р-н', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 268,
           AREA_NAME = 'Мостиський р-н',
           AREA_NAME_RU = 'Мостисский р-н',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 276;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 277, 269, 'Мукачівський р-н', 'Мукачевский р-н', 6, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 269,
           AREA_NAME = 'Мукачівський р-н',
           AREA_NAME_RU = 'Мукачевский р-н',
           REGION_ID = 6,
           KOATUU = null
     where AREA_ID = 277;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 278, 270, 'Мурованокуриловецький р-н', 'Мурованокуриловецкий р-н', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 270,
           AREA_NAME = 'Мурованокуриловецький р-н',
           AREA_NAME_RU = 'Мурованокуриловецкий р-н',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 278;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 279, 271, 'Надвірнянський р-н', 'Надвирнянский р-н', 8, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 271,
           AREA_NAME = 'Надвірнянський р-н',
           AREA_NAME_RU = 'Надвирнянский р-н',
           REGION_ID = 8,
           KOATUU = null
     where AREA_ID = 279;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 280, 272, 'Народицький р-н', 'Народичский р-н', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 272,
           AREA_NAME = 'Народицький р-н',
           AREA_NAME_RU = 'Народичский р-н',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 280;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 281, 273, 'Недригайлівський р-н', 'Недрыгайловский р-н', 20, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 273,
           AREA_NAME = 'Недригайлівський р-н',
           AREA_NAME_RU = 'Недрыгайловский р-н',
           REGION_ID = 20,
           KOATUU = null
     where AREA_ID = 281;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 282, 274, 'Немирівський р-н', 'Немировский р-н', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 274,
           AREA_NAME = 'Немирівський р-н',
           AREA_NAME_RU = 'Немировский р-н',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 282;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 283, 275, 'Нижньогірський р-н', 'Нижнегорский р-н', 12, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 275,
           AREA_NAME = 'Нижньогірський р-н',
           AREA_NAME_RU = 'Нижнегорский р-н',
           REGION_ID = 12,
           KOATUU = null
     where AREA_ID = 283;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 284, 276, 'Нижньосірогозький р-н', 'Нижнесерогозский р-н', 23, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 276,
           AREA_NAME = 'Нижньосірогозький р-н',
           AREA_NAME_RU = 'Нижнесерогозский р-н',
           REGION_ID = 23,
           KOATUU = null
     where AREA_ID = 284;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 285, 277, 'Ніжинський р-н', 'Нежинский р-н', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 277,
           AREA_NAME = 'Ніжинський р-н',
           AREA_NAME_RU = 'Нежинский р-н',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 285;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 286, 278, 'Нікопольський р-н', 'Никопольский р-н', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 278,
           AREA_NAME = 'Нікопольський р-н',
           AREA_NAME_RU = 'Никопольский р-н',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 286;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 287, 279, 'Новгородківський р-н', 'Новгородковский р-н', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 279,
           AREA_NAME = 'Новгородківський р-н',
           AREA_NAME_RU = 'Новгородковский р-н',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 287;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 288, 280, 'Новгород-Сіверський р-н', 'Новгород-Северский р-н', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 280,
           AREA_NAME = 'Новгород-Сіверський р-н',
           AREA_NAME_RU = 'Новгород-Северский р-н',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 288;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 289, 281, 'Новоазовський р-н', 'Новоазовский р-н', 4, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 281,
           AREA_NAME = 'Новоазовський р-н',
           AREA_NAME_RU = 'Новоазовский р-н',
           REGION_ID = 4,
           KOATUU = null
     where AREA_ID = 289;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 290, 282, 'Новоайдарський р-н', 'Новоайдарский р-н', 13, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 282,
           AREA_NAME = 'Новоайдарський р-н',
           AREA_NAME_RU = 'Новоайдарский р-н',
           REGION_ID = 13,
           KOATUU = null
     where AREA_ID = 290;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 291, 283, 'Новоархангельський р-н', 'Новоархангельский р-н', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 283,
           AREA_NAME = 'Новоархангельський р-н',
           AREA_NAME_RU = 'Новоархангельский р-н',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 291;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 292, 284, 'Новобузький р-н', 'Новобугский р-н', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 284,
           AREA_NAME = 'Новобузький р-н',
           AREA_NAME_RU = 'Новобугский р-н',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 292;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 293, 285, 'Нововодолазький р-н', 'Нововодолажский р-н', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 285,
           AREA_NAME = 'Нововодолазький р-н',
           AREA_NAME_RU = 'Нововодолажский р-н',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 293;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 294, 286, 'Нововоронцовський р-н', 'Нововоронцовский р-н', 23, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 286,
           AREA_NAME = 'Нововоронцовський р-н',
           AREA_NAME_RU = 'Нововоронцовский р-н',
           REGION_ID = 23,
           KOATUU = null
     where AREA_ID = 294;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 295, 287, 'Новоград-Волинський р-н', 'Новоград-Волынский р-н', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 287,
           AREA_NAME = 'Новоград-Волинський р-н',
           AREA_NAME_RU = 'Новоград-Волынский р-н',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 295;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 296, 288, 'Новомиколаївський р-н', 'Новониколаевский р-н', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 288,
           AREA_NAME = 'Новомиколаївський р-н',
           AREA_NAME_RU = 'Новониколаевский р-н',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 296;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 297, 289, 'Новомиргородський р-н', 'Новомиргородский р-н', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 289,
           AREA_NAME = 'Новомиргородський р-н',
           AREA_NAME_RU = 'Новомиргородский р-н',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 297;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 298, 290, 'Новомосковський р-н', 'Новомосковский р-н', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 290,
           AREA_NAME = 'Новомосковський р-н',
           AREA_NAME_RU = 'Новомосковский р-н',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 298;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 299, 291, 'Новоодеський р-н', 'Новоодесский р-н', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 291,
           AREA_NAME = 'Новоодеський р-н',
           AREA_NAME_RU = 'Новоодесский р-н',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 299;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 300, 292, 'Новопсковський р-н', 'Новопсковский р-н', 13, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 292,
           AREA_NAME = 'Новопсковський р-н',
           AREA_NAME_RU = 'Новопсковский р-н',
           REGION_ID = 13,
           KOATUU = null
     where AREA_ID = 300;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 301, 293, 'Новосанжарський р-н', 'Новосанжарский р-н', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 293,
           AREA_NAME = 'Новосанжарський р-н',
           AREA_NAME_RU = 'Новосанжарский р-н',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 301;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 302, 294, 'Новоселицький р-н', 'Новоселицкий р-н', 26, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 294,
           AREA_NAME = 'Новоселицький р-н',
           AREA_NAME_RU = 'Новоселицкий р-н',
           REGION_ID = 26,
           KOATUU = null
     where AREA_ID = 302;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 303, 295, 'Новотроїцький р-н', 'Новотроицкий р-н', 23, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 295,
           AREA_NAME = 'Новотроїцький р-н',
           AREA_NAME_RU = 'Новотроицкий р-н',
           REGION_ID = 23,
           KOATUU = null
     where AREA_ID = 303;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 304, 296, 'Новоукраїнський р-н', 'Новоукраинский р-н', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 296,
           AREA_NAME = 'Новоукраїнський р-н',
           AREA_NAME_RU = 'Новоукраинский р-н',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 304;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 305, 297, 'Новоушицький р-н', 'Новоушицкий р-н', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 297,
           AREA_NAME = 'Новоушицький р-н',
           AREA_NAME_RU = 'Новоушицкий р-н',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 305;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 306, 298, 'Носівський р-н', 'Носовский р-н', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 298,
           AREA_NAME = 'Носівський р-н',
           AREA_NAME_RU = 'Носовский р-н',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 306;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 307, 299, 'Обухівський р-н', 'Обуховский р-н', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 299,
           AREA_NAME = 'Обухівський р-н',
           AREA_NAME_RU = 'Обуховский р-н',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 307;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 308, 300, 'Овідіопольський р-н', 'Овидиопольский р-н', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 300,
           AREA_NAME = 'Овідіопольський р-н',
           AREA_NAME_RU = 'Овидиопольский р-н',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 308;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 309, 301, 'Овруцький р-н', 'Овручский р-н', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 301,
           AREA_NAME = 'Овруцький р-н',
           AREA_NAME_RU = 'Овручский р-н',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 309;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 310, 302, 'Олевський р-н', 'Олевский р-н', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 302,
           AREA_NAME = 'Олевський р-н',
           AREA_NAME_RU = 'Олевский р-н',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 310;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 311, 303, 'Олександрівський р-н', 'Александровский р-н', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 303,
           AREA_NAME = 'Олександрівський р-н',
           AREA_NAME_RU = 'Александровский р-н',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 311;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 312, 303, 'Олександрівський р-н', 'Александровский р-н', 4, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 303,
           AREA_NAME = 'Олександрівський р-н',
           AREA_NAME_RU = 'Александровский р-н',
           REGION_ID = 4,
           KOATUU = null
     where AREA_ID = 312;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 313, 304, 'Олександрійський р-н', 'Александрийский р-н', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 304,
           AREA_NAME = 'Олександрійський р-н',
           AREA_NAME_RU = 'Александрийский р-н',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 313;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 314, 305, 'Онуфріївський р-н', 'Онуфриевский р-н', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 305,
           AREA_NAME = 'Онуфріївський р-н',
           AREA_NAME_RU = 'Онуфриевский р-н',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 314;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 315, 306, 'Оратівський р-н', 'Оратовский р-н', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 306,
           AREA_NAME = 'Оратівський р-н',
           AREA_NAME_RU = 'Оратовский р-н',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 315;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 316, 307, 'Оржицький р-н', 'Оржицкий р-н', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 307,
           AREA_NAME = 'Оржицький р-н',
           AREA_NAME_RU = 'Оржицкий р-н',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 316;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 317, 308, 'Оріхівський р-н', 'Ореховский р-н', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 308,
           AREA_NAME = 'Оріхівський р-н',
           AREA_NAME_RU = 'Ореховский р-н',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 317;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 318, 309, 'Острозький р-н', 'Острожский р-н', 18, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 309,
           AREA_NAME = 'Острозький р-н',
           AREA_NAME_RU = 'Острожский р-н',
           REGION_ID = 18,
           KOATUU = null
     where AREA_ID = 318;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 319, 310, 'Охтирський р-н', 'Ахтырский р-н', 20, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 310,
           AREA_NAME = 'Охтирський р-н',
           AREA_NAME_RU = 'Ахтырский р-н',
           REGION_ID = 20,
           KOATUU = null
     where AREA_ID = 319;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 320, 311, 'Очаківський р-н', 'Очаковский р-н', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 311,
           AREA_NAME = 'Очаківський р-н',
           AREA_NAME_RU = 'Очаковский р-н',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 320;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 321, 312, 'П’ятихатський р-н', 'Пятихатский р-н', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 312,
           AREA_NAME = 'П’ятихатський р-н',
           AREA_NAME_RU = 'Пятихатский р-н',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 321;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 322, 313, 'Павлоградський р-н', 'Павлоградский р-н', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 313,
           AREA_NAME = 'Павлоградський р-н',
           AREA_NAME_RU = 'Павлоградский р-н',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 322;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 323, 314, 'Первомайський р-н', 'Первомайский р-н', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 314,
           AREA_NAME = 'Первомайський р-н',
           AREA_NAME_RU = 'Первомайский р-н',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 323;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 324, 314, 'Первомайський р-н', 'Первомайский р-н', 12, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 314,
           AREA_NAME = 'Первомайський р-н',
           AREA_NAME_RU = 'Первомайский р-н',
           REGION_ID = 12,
           KOATUU = null
     where AREA_ID = 324;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 325, 314, 'Первомайський р-н', 'Первомайский р-н', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 314,
           AREA_NAME = 'Первомайський р-н',
           AREA_NAME_RU = 'Первомайский р-н',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 325;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 326, 315, 'Перевальський р-н', 'Перевальский р-н', 13, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 315,
           AREA_NAME = 'Перевальський р-н',
           AREA_NAME_RU = 'Перевальский р-н',
           REGION_ID = 13,
           KOATUU = null
     where AREA_ID = 326;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 327, 316, 'Перемишлянський р-н', 'Перемышлянский р-н', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 316,
           AREA_NAME = 'Перемишлянський р-н',
           AREA_NAME_RU = 'Перемышлянский р-н',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 327;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 328, 317, 'Перечинський р-н', 'Перечинский р-н', 6, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 317,
           AREA_NAME = 'Перечинський р-н',
           AREA_NAME_RU = 'Перечинский р-н',
           REGION_ID = 6,
           KOATUU = null
     where AREA_ID = 328;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 329, 318, 'Переяслав-Хмельницький р-н', 'Переяслав-Хмельницкий р-н', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 318,
           AREA_NAME = 'Переяслав-Хмельницький р-н',
           AREA_NAME_RU = 'Переяслав-Хмельницкий р-н',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 329;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 330, 319, 'Першотравневий р-н', 'Первомайский р-н', 4, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 319,
           AREA_NAME = 'Першотравневий р-н',
           AREA_NAME_RU = 'Первомайский р-н',
           REGION_ID = 4,
           KOATUU = null
     where AREA_ID = 330;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 331, 320, 'Петриківський р-н', 'Петриковский р-н', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 320,
           AREA_NAME = 'Петриківський р-н',
           AREA_NAME_RU = 'Петриковский р-н',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 331;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 332, 321, 'Петрівський р-н', 'Петровский р-н', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 321,
           AREA_NAME = 'Петрівський р-н',
           AREA_NAME_RU = 'Петровский р-н',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 332;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 333, 322, 'Петропавлівський р-н', 'Петропавловский р-н', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 322,
           AREA_NAME = 'Петропавлівський р-н',
           AREA_NAME_RU = 'Петропавловский р-н',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 333;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 334, 323, 'Печенізький р-н', 'Печенежский р-н', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 323,
           AREA_NAME = 'Печенізький р-н',
           AREA_NAME_RU = 'Печенежский р-н',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 334;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 335, 324, 'Пирятинський р-н', 'Пирятинский р-н', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 324,
           AREA_NAME = 'Пирятинський р-н',
           AREA_NAME_RU = 'Пирятинский р-н',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 335;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 336, 325, 'Підволочиський р-н', 'Подволочиский р-н', 21, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 325,
           AREA_NAME = 'Підволочиський р-н',
           AREA_NAME_RU = 'Подволочиский р-н',
           REGION_ID = 21,
           KOATUU = null
     where AREA_ID = 336;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 337, 326, 'Підгаєцький р-н', 'Подгаецкий р-н', 21, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 326,
           AREA_NAME = 'Підгаєцький р-н',
           AREA_NAME_RU = 'Подгаецкий р-н',
           REGION_ID = 21,
           KOATUU = null
     where AREA_ID = 337;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 338, 327, 'Піщанський р-н', 'Песчанский р-н', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 327,
           AREA_NAME = 'Піщанський р-н',
           AREA_NAME_RU = 'Песчанский р-н',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 338;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 339, 328, 'Погребищенський р-н', 'Погребищенский р-н', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 328,
           AREA_NAME = 'Погребищенський р-н',
           AREA_NAME_RU = 'Погребищенский р-н',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 339;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 340, 329, 'Покровський р-н', 'Покровский р-н', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 329,
           AREA_NAME = 'Покровський р-н',
           AREA_NAME_RU = 'Покровский р-н',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 340;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 341, 330, 'Поліський р-н', 'Полесский р-н', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 330,
           AREA_NAME = 'Поліський р-н',
           AREA_NAME_RU = 'Полесский р-н',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 341;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 342, 331, 'Пологівський р-н', 'Пологовский р-н', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 331,
           AREA_NAME = 'Пологівський р-н',
           AREA_NAME_RU = 'Пологовский р-н',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 342;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 343, 332, 'Полонський р-н', 'Полонский р-н', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 332,
           AREA_NAME = 'Полонський р-н',
           AREA_NAME_RU = 'Полонский р-н',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 343;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 344, 333, 'Полтавський р-н', 'Полтавский р-н', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 333,
           AREA_NAME = 'Полтавський р-н',
           AREA_NAME_RU = 'Полтавский р-н',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 344;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 345, 334, 'Попаснянський р-н', 'Попаснянский р-н', 13, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 334,
           AREA_NAME = 'Попаснянський р-н',
           AREA_NAME_RU = 'Попаснянский р-н',
           REGION_ID = 13,
           KOATUU = null
     where AREA_ID = 345;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 346, 335, 'Попільнянський р-н', 'Попельнянский р-н', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 335,
           AREA_NAME = 'Попільнянський р-н',
           AREA_NAME_RU = 'Попельнянский р-н',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 346;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 347, 336, 'Приазовський р-н', 'Приазовский р-н', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 336,
           AREA_NAME = 'Приазовський р-н',
           AREA_NAME_RU = 'Приазовский р-н',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 347;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 348, 337, 'Прилуцький р-н', 'Прилукский р-н', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 337,
           AREA_NAME = 'Прилуцький р-н',
           AREA_NAME_RU = 'Прилукский р-н',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 348;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 349, 338, 'Приморський р-н', 'Приморский р-н', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 338,
           AREA_NAME = 'Приморський р-н',
           AREA_NAME_RU = 'Приморский р-н',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 349;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 350, 339, 'Пустомитівський р-н', 'Пустомытовский р-н', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 339,
           AREA_NAME = 'Пустомитівський р-н',
           AREA_NAME_RU = 'Пустомытовский р-н',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 350;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 351, 340, 'Путивльський р-н', 'Путивльский р-н', 20, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 340,
           AREA_NAME = 'Путивльський р-н',
           AREA_NAME_RU = 'Путивльский р-н',
           REGION_ID = 20,
           KOATUU = null
     where AREA_ID = 351;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 352, 341, 'Путильський р-н', 'Путильский р-н', 26, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 341,
           AREA_NAME = 'Путильський р-н',
           AREA_NAME_RU = 'Путильский р-н',
           REGION_ID = 26,
           KOATUU = null
     where AREA_ID = 352;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 353, 342, 'Радехівський р-н', 'Радеховский р-н', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 342,
           AREA_NAME = 'Радехівський р-н',
           AREA_NAME_RU = 'Радеховский р-н',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 353;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 354, 343, 'Радивилівський р-н', 'Радивиловский р-н', 18, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 343,
           AREA_NAME = 'Радивилівський р-н',
           AREA_NAME_RU = 'Радивиловский р-н',
           REGION_ID = 18,
           KOATUU = null
     where AREA_ID = 354;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 355, 344, 'Радомишльський р-н', 'Радомышльский р-н', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 344,
           AREA_NAME = 'Радомишльський р-н',
           AREA_NAME_RU = 'Радомышльский р-н',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 355;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 356, 345, 'Ратнівський р-н', 'Ратновский р-н', 2, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 345,
           AREA_NAME = 'Ратнівський р-н',
           AREA_NAME_RU = 'Ратновский р-н',
           REGION_ID = 2,
           KOATUU = null
     where AREA_ID = 356;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 357, 346, 'Рахівський р-н', 'Раховский р-н', 6, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 346,
           AREA_NAME = 'Рахівський р-н',
           AREA_NAME_RU = 'Раховский р-н',
           REGION_ID = 6,
           KOATUU = null
     where AREA_ID = 357;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 358, 347, 'Ренійський р-н', 'Ренийский р-н', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 347,
           AREA_NAME = 'Ренійський р-н',
           AREA_NAME_RU = 'Ренийский р-н',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 358;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 359, 348, 'Решетилівський р-н', 'Решетиловский р-н', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 348,
           AREA_NAME = 'Решетилівський р-н',
           AREA_NAME_RU = 'Решетиловский р-н',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 359;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 360, 349, 'Рівненський р-н', 'Ровенский р-н', 18, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 349,
           AREA_NAME = 'Рівненський р-н',
           AREA_NAME_RU = 'Ровенский р-н',
           REGION_ID = 18,
           KOATUU = null
     where AREA_ID = 360;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 361, 350, 'Ріпкинський р-н', 'Репкинский р-н', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 350,
           AREA_NAME = 'Ріпкинський р-н',
           AREA_NAME_RU = 'Репкинский р-н',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 361;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 362, 351, 'Рогатинський р-н', 'Рогатинский р-н', 8, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 351,
           AREA_NAME = 'Рогатинський р-н',
           AREA_NAME_RU = 'Рогатинский р-н',
           REGION_ID = 8,
           KOATUU = null
     where AREA_ID = 362;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 363, 352, 'Рожищенський р-н', 'Рожищенский р-н', 2, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 352,
           AREA_NAME = 'Рожищенський р-н',
           AREA_NAME_RU = 'Рожищенский р-н',
           REGION_ID = 2,
           KOATUU = null
     where AREA_ID = 363;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 364, 353, 'Рожнятівський р-н', 'Рожнятовский р-н', 8, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 353,
           AREA_NAME = 'Рожнятівський р-н',
           AREA_NAME_RU = 'Рожнятовский р-н',
           REGION_ID = 8,
           KOATUU = null
     where AREA_ID = 364;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 365, 354, 'Роздільнянський р-н', 'Раздельнянский р-н', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 354,
           AREA_NAME = 'Роздільнянський р-н',
           AREA_NAME_RU = 'Раздельнянский р-н',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 365;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 366, 355, 'Роздольненський р-н', 'Раздольненский р-н', 12, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 355,
           AREA_NAME = 'Роздольненський р-н',
           AREA_NAME_RU = 'Раздольненский р-н',
           REGION_ID = 12,
           KOATUU = null
     where AREA_ID = 366;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 367, 356, 'Розівський р-н', 'Розовский р-н', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 356,
           AREA_NAME = 'Розівський р-н',
           AREA_NAME_RU = 'Розовский р-н',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 367;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 368, 357, 'Рокитнівський р-н', 'Рокитновский р-н', 18, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 357,
           AREA_NAME = 'Рокитнівський р-н',
           AREA_NAME_RU = 'Рокитновский р-н',
           REGION_ID = 18,
           KOATUU = null
     where AREA_ID = 368;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 369, 358, 'Рокитнянський р-н', 'Ракитнянский р-н', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 358,
           AREA_NAME = 'Рокитнянський р-н',
           AREA_NAME_RU = 'Ракитнянский р-н',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 369;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 370, 359, 'Романівський р-н', 'Романовский р-н', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 359,
           AREA_NAME = 'Романівський р-н',
           AREA_NAME_RU = 'Романовский р-н',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 370;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 371, 360, 'Роменський р-н', 'Роменский р-н', 20, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 360,
           AREA_NAME = 'Роменський р-н',
           AREA_NAME_RU = 'Роменский р-н',
           REGION_ID = 20,
           KOATUU = null
     where AREA_ID = 371;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 372, 361, 'Ружинський р-н', 'Ружинский р-н', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 361,
           AREA_NAME = 'Ружинський р-н',
           AREA_NAME_RU = 'Ружинский р-н',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 372;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 373, 362, 'Савранський р-н', 'Савранский р-н', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 362,
           AREA_NAME = 'Савранський р-н',
           AREA_NAME_RU = 'Савранский р-н',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 373;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 374, 363, 'Сакський р-н', 'Сакский р-н', 12, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 363,
           AREA_NAME = 'Сакський р-н',
           AREA_NAME_RU = 'Сакский р-н',
           REGION_ID = 12,
           KOATUU = null
     where AREA_ID = 374;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 375, 364, 'Самбірський р-н', 'Самборский р-н', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 364,
           AREA_NAME = 'Самбірський р-н',
           AREA_NAME_RU = 'Самборский р-н',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 375;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 376, 365, 'Саратський р-н', 'Саратский р-н', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 365,
           AREA_NAME = 'Саратський р-н',
           AREA_NAME_RU = 'Саратский р-н',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 376;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 377, 366, 'Сарненський р-н', 'Сарненский р-н', 18, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 366,
           AREA_NAME = 'Сарненський р-н',
           AREA_NAME_RU = 'Сарненский р-н',
           REGION_ID = 18,
           KOATUU = null
     where AREA_ID = 377;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 378, 367, 'Сахновщинський р-н', 'Сахновщинский р-н', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 367,
           AREA_NAME = 'Сахновщинський р-н',
           AREA_NAME_RU = 'Сахновщинский р-н',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 378;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 379, 368, 'Свалявський р-н', 'Свалявский р-н', 6, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 368,
           AREA_NAME = 'Свалявський р-н',
           AREA_NAME_RU = 'Свалявский р-н',
           REGION_ID = 6,
           KOATUU = null
     where AREA_ID = 379;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 380, 369, 'Сватівський р-н', 'Сватовский р-н', 13, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 369,
           AREA_NAME = 'Сватівський р-н',
           AREA_NAME_RU = 'Сватовский р-н',
           REGION_ID = 13,
           KOATUU = null
     where AREA_ID = 380;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 381, 370, 'Свердловський р-н', 'Свердловский р-н', 13, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 370,
           AREA_NAME = 'Свердловський р-н',
           AREA_NAME_RU = 'Свердловский р-н',
           REGION_ID = 13,
           KOATUU = null
     where AREA_ID = 381;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 382, 371, 'Світловодський р-н', 'Светловодский р-н', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 371,
           AREA_NAME = 'Світловодський р-н',
           AREA_NAME_RU = 'Светловодский р-н',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 382;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 383, 372, 'Семенівський р-н', 'Семеновский р-н', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 372,
           AREA_NAME = 'Семенівський р-н',
           AREA_NAME_RU = 'Семеновский р-н',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 383;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 384, 372, 'Семенівський р-н', 'Семеновский р-н', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 372,
           AREA_NAME = 'Семенівський р-н',
           AREA_NAME_RU = 'Семеновский р-н',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 384;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 385, 373, 'Середино-Будський р-н', 'Середино-будский р-н', 20, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 373,
           AREA_NAME = 'Середино-Будський р-н',
           AREA_NAME_RU = 'Середино-будский р-н',
           REGION_ID = 20,
           KOATUU = null
     where AREA_ID = 385;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 386, 374, 'Синельниківський р-н', 'Синельниковский р-н', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 374,
           AREA_NAME = 'Синельниківський р-н',
           AREA_NAME_RU = 'Синельниковский р-н',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 386;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 387, 375, 'Сімферопольський р-н', 'Симферопольский р-н', 12, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 375,
           AREA_NAME = 'Сімферопольський р-н',
           AREA_NAME_RU = 'Симферопольский р-н',
           REGION_ID = 12,
           KOATUU = null
     where AREA_ID = 387;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 388, 376, 'Скадовський р-н', 'Скадовский р-н', 23, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 376,
           AREA_NAME = 'Скадовський р-н',
           AREA_NAME_RU = 'Скадовский р-н',
           REGION_ID = 23,
           KOATUU = null
     where AREA_ID = 388;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 389, 377, 'Сквирський р-н', 'Сквирский р-н', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 377,
           AREA_NAME = 'Сквирський р-н',
           AREA_NAME_RU = 'Сквирский р-н',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 389;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 390, 378, 'Сколівський р-н', 'Сколевский р-н', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 378,
           AREA_NAME = 'Сколівський р-н',
           AREA_NAME_RU = 'Сколевский р-н',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 390;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 391, 379, 'Славутський р-н', 'Славутский р-н', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 379,
           AREA_NAME = 'Славутський р-н',
           AREA_NAME_RU = 'Славутский р-н',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 391;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 392, 380, 'Слов’яносербський р-н', 'Славяносербский р-н', 13, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 380,
           AREA_NAME = 'Слов’яносербський р-н',
           AREA_NAME_RU = 'Славяносербский р-н',
           REGION_ID = 13,
           KOATUU = null
     where AREA_ID = 392;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 393, 381, 'Слов’янський р-н', 'Славянский р-н', 4, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 381,
           AREA_NAME = 'Слов’янський р-н',
           AREA_NAME_RU = 'Славянский р-н',
           REGION_ID = 4,
           KOATUU = null
     where AREA_ID = 393;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 394, 382, 'Смілянський р-н', 'Смелянский р-н', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 382,
           AREA_NAME = 'Смілянський р-н',
           AREA_NAME_RU = 'Смелянский р-н',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 394;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 395, 383, 'Снігурівський р-н', 'Снигиревский р-н', 15, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 383,
           AREA_NAME = 'Снігурівський р-н',
           AREA_NAME_RU = 'Снигиревский р-н',
           REGION_ID = 15,
           KOATUU = null
     where AREA_ID = 395;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 396, 384, 'Снятинський р-н', 'Снятынский р-н', 8, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 384,
           AREA_NAME = 'Снятинський р-н',
           AREA_NAME_RU = 'Снятынский р-н',
           REGION_ID = 8,
           KOATUU = null
     where AREA_ID = 396;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 397, 385, 'Совєтський р-н', 'Советский р-н', 12, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 385,
           AREA_NAME = 'Совєтський р-н',
           AREA_NAME_RU = 'Советский р-н',
           REGION_ID = 12,
           KOATUU = null
     where AREA_ID = 397;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 398, 386, 'Сокальський р-н', 'Сокальский р-н', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 386,
           AREA_NAME = 'Сокальський р-н',
           AREA_NAME_RU = 'Сокальский р-н',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 398;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 399, 387, 'Сокирянський р-н', 'Сокирянский р-н', 26, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 387,
           AREA_NAME = 'Сокирянський р-н',
           AREA_NAME_RU = 'Сокирянский р-н',
           REGION_ID = 26,
           KOATUU = null
     where AREA_ID = 399;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 400, 388, 'Солонянський р-н', 'Солонянский р-н', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 388,
           AREA_NAME = 'Солонянський р-н',
           AREA_NAME_RU = 'Солонянский р-н',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 400;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 401, 389, 'Сосницький р-н', 'Сосницкий р-н', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 389,
           AREA_NAME = 'Сосницький р-н',
           AREA_NAME_RU = 'Сосницкий р-н',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 401;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 402, 390, 'Софіївський р-н', 'Софиевский р-н', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 390,
           AREA_NAME = 'Софіївський р-н',
           AREA_NAME_RU = 'Софиевский р-н',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 402;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 403, 391, 'Срібнянський р-н', 'Сребнянский р-н', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 391,
           AREA_NAME = 'Срібнянський р-н',
           AREA_NAME_RU = 'Сребнянский р-н',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 403;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 404, 392, 'Ставищенський р-н', 'Ставищенский р-н', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 392,
           AREA_NAME = 'Ставищенський р-н',
           AREA_NAME_RU = 'Ставищенский р-н',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 404;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 405, 393, 'Станично-Луганський р-н', 'Станично-Луганский р-н', 13, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 393,
           AREA_NAME = 'Станично-Луганський р-н',
           AREA_NAME_RU = 'Станично-Луганский р-н',
           REGION_ID = 13,
           KOATUU = null
     where AREA_ID = 405;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 406, 394, 'Старобешівський р-н', 'Старобешевский р-н', 4, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 394,
           AREA_NAME = 'Старобешівський р-н',
           AREA_NAME_RU = 'Старобешевский р-н',
           REGION_ID = 4,
           KOATUU = null
     where AREA_ID = 406;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 407, 395, 'Старобільський р-н', 'Старобельский р-н', 13, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 395,
           AREA_NAME = 'Старобільський р-н',
           AREA_NAME_RU = 'Старобельский р-н',
           REGION_ID = 13,
           KOATUU = null
     where AREA_ID = 407;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 408, 396, 'Старовижівський р-н', 'Старовыжевский р-н', 2, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 396,
           AREA_NAME = 'Старовижівський р-н',
           AREA_NAME_RU = 'Старовыжевский р-н',
           REGION_ID = 2,
           KOATUU = null
     where AREA_ID = 408;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 409, 397, 'Старокостянтинівський р-н', 'Староконстантиновский р-н', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 397,
           AREA_NAME = 'Старокостянтинівський р-н',
           AREA_NAME_RU = 'Староконстантиновский р-н',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 409;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 410, 398, 'Старосамбірський р-н', 'Старосамборский р-н', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 398,
           AREA_NAME = 'Старосамбірський р-н',
           AREA_NAME_RU = 'Старосамборский р-н',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 410;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 411, 399, 'Старосинявський р-н', 'Старосинявский р-н', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 399,
           AREA_NAME = 'Старосинявський р-н',
           AREA_NAME_RU = 'Старосинявский р-н',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 411;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 412, 400, 'Сторожинецький р-н', 'Сторожинецкий р-н', 26, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 400,
           AREA_NAME = 'Сторожинецький р-н',
           AREA_NAME_RU = 'Сторожинецкий р-н',
           REGION_ID = 26,
           KOATUU = null
     where AREA_ID = 412;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 413, 401, 'Стрийський р-н', 'Стрыйский р-н', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 401,
           AREA_NAME = 'Стрийський р-н',
           AREA_NAME_RU = 'Стрыйский р-н',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 413;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 414, 402, 'Сумський р-н', 'Сумской р-н', 20, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 402,
           AREA_NAME = 'Сумський р-н',
           AREA_NAME_RU = 'Сумской р-н',
           REGION_ID = 20,
           KOATUU = null
     where AREA_ID = 414;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 415, 403, 'Талалаївський р-н', 'Талалаевский р-н', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 403,
           AREA_NAME = 'Талалаївський р-н',
           AREA_NAME_RU = 'Талалаевский р-н',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 415;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 416, 404, 'Тальнівський р-н', 'Тальновский р-н', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 404,
           AREA_NAME = 'Тальнівський р-н',
           AREA_NAME_RU = 'Тальновский р-н',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 416;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 417, 405, 'Таращанський р-н', 'Таращанский р-н', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 405,
           AREA_NAME = 'Таращанський р-н',
           AREA_NAME_RU = 'Таращанский р-н',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 417;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 418, 406, 'Тарутинський р-н', 'Тарутинский р-н', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 406,
           AREA_NAME = 'Тарутинський р-н',
           AREA_NAME_RU = 'Тарутинский р-н',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 418;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 419, 407, 'Татарбунарський р-н', 'Татарбунарский р-н', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 407,
           AREA_NAME = 'Татарбунарський р-н',
           AREA_NAME_RU = 'Татарбунарский р-н',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 419;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 420, 408, 'Тельманівський р-н', 'Тельмановский р-н', 4, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 408,
           AREA_NAME = 'Тельманівський р-н',
           AREA_NAME_RU = 'Тельмановский р-н',
           REGION_ID = 4,
           KOATUU = null
     where AREA_ID = 420;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 421, 409, 'Теофіпольський р-н', 'Теофипольский р-н', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 409,
           AREA_NAME = 'Теофіпольський р-н',
           AREA_NAME_RU = 'Теофипольский р-н',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 421;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 422, 410, 'Теплицький р-н', 'Тепликский р-н', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 410,
           AREA_NAME = 'Теплицький р-н',
           AREA_NAME_RU = 'Тепликский р-н',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 422;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 423, 411, 'Теребовлянський р-н', 'Теребовлянский р-н', 21, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 411,
           AREA_NAME = 'Теребовлянський р-н',
           AREA_NAME_RU = 'Теребовлянский р-н',
           REGION_ID = 21,
           KOATUU = null
     where AREA_ID = 423;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 424, 412, 'Тернопільський р-н', 'Тернопольский р-н', 21, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 412,
           AREA_NAME = 'Тернопільський р-н',
           AREA_NAME_RU = 'Тернопольский р-н',
           REGION_ID = 21,
           KOATUU = null
     where AREA_ID = 424;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 425, 413, 'Тетіївський р-н', 'Тетиевский р-н', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 413,
           AREA_NAME = 'Тетіївський р-н',
           AREA_NAME_RU = 'Тетиевский р-н',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 425;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 426, 414, 'Тиврівський р-н', 'Тывровский р-н', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 414,
           AREA_NAME = 'Тиврівський р-н',
           AREA_NAME_RU = 'Тывровский р-н',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 426;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 427, 415, 'Тисменицький р-н', 'Тысменицкий р-н', 8, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 415,
           AREA_NAME = 'Тисменицький р-н',
           AREA_NAME_RU = 'Тысменицкий р-н',
           REGION_ID = 8,
           KOATUU = null
     where AREA_ID = 427;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 428, 416, 'Тлумацький р-н', 'Тлумачский р-н', 8, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 416,
           AREA_NAME = 'Тлумацький р-н',
           AREA_NAME_RU = 'Тлумачский р-н',
           REGION_ID = 8,
           KOATUU = null
     where AREA_ID = 428;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 429, 417, 'Токмацький р-н', 'Токмакский р-н', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 417,
           AREA_NAME = 'Токмацький р-н',
           AREA_NAME_RU = 'Токмакский р-н',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 429;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 430, 418, 'Томаківський р-н', 'Томаковский р-н', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 418,
           AREA_NAME = 'Томаківський р-н',
           AREA_NAME_RU = 'Томаковский р-н',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 430;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 431, 419, 'Томашпільський р-н', 'Томашпольский р-н', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 419,
           AREA_NAME = 'Томашпільський р-н',
           AREA_NAME_RU = 'Томашпольский р-н',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 431;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 432, 420, 'Троїцький р-н', 'Троицкий р-н', 13, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 420,
           AREA_NAME = 'Троїцький р-н',
           AREA_NAME_RU = 'Троицкий р-н',
           REGION_ID = 13,
           KOATUU = null
     where AREA_ID = 432;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 433, 421, 'Тростянецький р-н', 'Тростянецкий р-н', 20, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 421,
           AREA_NAME = 'Тростянецький р-н',
           AREA_NAME_RU = 'Тростянецкий р-н',
           REGION_ID = 20,
           KOATUU = null
     where AREA_ID = 433;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 434, 421, 'Тростянецький р-н', 'Тростянецкий р-н', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 421,
           AREA_NAME = 'Тростянецький р-н',
           AREA_NAME_RU = 'Тростянецкий р-н',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 434;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 435, 422, 'Тульчинський р-н', 'Тульчинский р-н', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 422,
           AREA_NAME = 'Тульчинський р-н',
           AREA_NAME_RU = 'Тульчинский р-н',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 435;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 436, 423, 'Турійський р-н', 'Турийский р-н', 2, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 423,
           AREA_NAME = 'Турійський р-н',
           AREA_NAME_RU = 'Турийский р-н',
           REGION_ID = 2,
           KOATUU = null
     where AREA_ID = 436;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 437, 424, 'Турківський р-н', 'Турковский р-н', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 424,
           AREA_NAME = 'Турківський р-н',
           AREA_NAME_RU = 'Турковский р-н',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 437;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 438, 425, 'Тячівський р-н', 'Тячевский р-н', 6, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 425,
           AREA_NAME = 'Тячівський р-н',
           AREA_NAME_RU = 'Тячевский р-н',
           REGION_ID = 6,
           KOATUU = null
     where AREA_ID = 438;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 439, 426, 'Ужгородський р-н', 'Ужгородский р-н', 6, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 426,
           AREA_NAME = 'Ужгородський р-н',
           AREA_NAME_RU = 'Ужгородский р-н',
           REGION_ID = 6,
           KOATUU = null
     where AREA_ID = 439;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 440, 427, 'Ульяновський р-н', 'Ульяновский р-н', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 427,
           AREA_NAME = 'Ульяновський р-н',
           AREA_NAME_RU = 'Ульяновский р-н',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 440;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 441, 428, 'Уманський р-н', 'Уманский р-н', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 428,
           AREA_NAME = 'Уманський р-н',
           AREA_NAME_RU = 'Уманский р-н',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 441;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 442, 429, 'Устинівський р-н', 'Устиновский р-н', 11, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 429,
           AREA_NAME = 'Устинівський р-н',
           AREA_NAME_RU = 'Устиновский р-н',
           REGION_ID = 11,
           KOATUU = null
     where AREA_ID = 442;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 443, 430, 'Фастівський р-н', 'Фастовский р-н', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 430,
           AREA_NAME = 'Фастівський р-н',
           AREA_NAME_RU = 'Фастовский р-н',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 443;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 444, 431, 'Фрунзівський р-н', 'Фрунзевский р-н', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 431,
           AREA_NAME = 'Фрунзівський р-н',
           AREA_NAME_RU = 'Фрунзевский р-н',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 444;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 445, 432, 'Харківський р-н', 'Харьковский р-н', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 432,
           AREA_NAME = 'Харківський р-н',
           AREA_NAME_RU = 'Харьковский р-н',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 445;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 446, 433, 'Хмельницький р-н', 'Хмельницкий р-н', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 433,
           AREA_NAME = 'Хмельницький р-н',
           AREA_NAME_RU = 'Хмельницкий р-н',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 446;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 447, 434, 'Хмільницький р-н', 'Хмельницкий р-н', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 434,
           AREA_NAME = 'Хмільницький р-н',
           AREA_NAME_RU = 'Хмельницкий р-н',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 447;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 448, 435, 'Хорольський р-н', 'Хорольский р-н', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 435,
           AREA_NAME = 'Хорольський р-н',
           AREA_NAME_RU = 'Хорольский р-н',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 448;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 449, 436, 'Хотинський р-н', 'Хотинский р-н', 26, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 436,
           AREA_NAME = 'Хотинський р-н',
           AREA_NAME_RU = 'Хотинский р-н',
           REGION_ID = 26,
           KOATUU = null
     where AREA_ID = 449;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 450, 437, 'Христинівський р-н', 'Христиновский р-н', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 437,
           AREA_NAME = 'Христинівський р-н',
           AREA_NAME_RU = 'Христиновский р-н',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 450;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 451, 438, 'Хустський р-н', 'Хустский р-н', 6, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 438,
           AREA_NAME = 'Хустський р-н',
           AREA_NAME_RU = 'Хустский р-н',
           REGION_ID = 6,
           KOATUU = null
     where AREA_ID = 451;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 452, 439, 'Царичанський р-н', 'Царичанский р-н', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 439,
           AREA_NAME = 'Царичанський р-н',
           AREA_NAME_RU = 'Царичанский р-н',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 452;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 453, 440, 'Цюрупинський р-н', 'Цюрупинский р-н', 23, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 440,
           AREA_NAME = 'Цюрупинський р-н',
           AREA_NAME_RU = 'Цюрупинский р-н',
           REGION_ID = 23,
           KOATUU = null
     where AREA_ID = 453;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 454, 441, 'Чаплинський р-н', 'Чаплинский р-н', 23, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 441,
           AREA_NAME = 'Чаплинський р-н',
           AREA_NAME_RU = 'Чаплинский р-н',
           REGION_ID = 23,
           KOATUU = null
     where AREA_ID = 454;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 455, 442, 'Чемеровецький р-н', 'Чемеровецкий р-н', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 442,
           AREA_NAME = 'Чемеровецький р-н',
           AREA_NAME_RU = 'Чемеровецкий р-н',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 455;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 456, 443, 'Червоноармійський р-н', 'Червоноармейский р-н', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 443,
           AREA_NAME = 'Червоноармійський р-н',
           AREA_NAME_RU = 'Червоноармейский р-н',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 456;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 457, 444, 'Черкаський р-н', 'Черкасский р-н', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 444,
           AREA_NAME = 'Черкаський р-н',
           AREA_NAME_RU = 'Черкасский р-н',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 457;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 458, 445, 'Чернівецький р-н', 'Черновецкий р-н', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 445,
           AREA_NAME = 'Чернівецький р-н',
           AREA_NAME_RU = 'Черновецкий р-н',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 458;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 459, 446, 'Чернігівський р-н', 'Черниговский р-н', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 446,
           AREA_NAME = 'Чернігівський р-н',
           AREA_NAME_RU = 'Черниговский р-н',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 459;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 460, 446, 'Чернігівський р-н', 'Черниговский р-н', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 446,
           AREA_NAME = 'Чернігівський р-н',
           AREA_NAME_RU = 'Черниговский р-н',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 460;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 461, 447, 'Черняхівський р-н', 'Черняховский р-н', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 447,
           AREA_NAME = 'Черняхівський р-н',
           AREA_NAME_RU = 'Черняховский р-н',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 461;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 462, 448, 'Чечельницький р-н', 'Чечельницкий р-н', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 448,
           AREA_NAME = 'Чечельницький р-н',
           AREA_NAME_RU = 'Чечельницкий р-н',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 462;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 463, 449, 'Чигиринський р-н', 'Чигиринский р-н', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 449,
           AREA_NAME = 'Чигиринський р-н',
           AREA_NAME_RU = 'Чигиринский р-н',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 463;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 464, 450, 'Чорнобаївський р-н', 'Чернобаевский р-н', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 450,
           AREA_NAME = 'Чорнобаївський р-н',
           AREA_NAME_RU = 'Чернобаевский р-н',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 464;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 465, 451, 'Чорноморський р-н', 'Черноморский р-н', 12, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 451,
           AREA_NAME = 'Чорноморський р-н',
           AREA_NAME_RU = 'Черноморский р-н',
           REGION_ID = 12,
           KOATUU = null
     where AREA_ID = 465;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 466, 452, 'Чорнухинський р-н', 'Чернухинский р-н', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 452,
           AREA_NAME = 'Чорнухинський р-н',
           AREA_NAME_RU = 'Чернухинский р-н',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 466;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 467, 453, 'Чортківський р-н', 'Чортковский р-н', 21, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 453,
           AREA_NAME = 'Чортківський р-н',
           AREA_NAME_RU = 'Чортковский р-н',
           REGION_ID = 21,
           KOATUU = null
     where AREA_ID = 467;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 468, 454, 'Чугуївський р-н', 'Чугуевский р-н', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 454,
           AREA_NAME = 'Чугуївський р-н',
           AREA_NAME_RU = 'Чугуевский р-н',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 468;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 469, 455, 'Чуднівський р-н', 'Чудновский р-н', 5, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 455,
           AREA_NAME = 'Чуднівський р-н',
           AREA_NAME_RU = 'Чудновский р-н',
           REGION_ID = 5,
           KOATUU = null
     where AREA_ID = 469;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 470, 456, 'Чутівський р-н', 'Чутовский р-н', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 456,
           AREA_NAME = 'Чутівський р-н',
           AREA_NAME_RU = 'Чутовский р-н',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 470;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 471, 457, 'Шаргородський р-н', 'Шаргородский р-н', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 457,
           AREA_NAME = 'Шаргородський р-н',
           AREA_NAME_RU = 'Шаргородский р-н',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 471;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 472, 458, 'Шахтарський р-н', 'Шахтерский р-н', 4, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 458,
           AREA_NAME = 'Шахтарський р-н',
           AREA_NAME_RU = 'Шахтерский р-н',
           REGION_ID = 4,
           KOATUU = null
     where AREA_ID = 472;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 473, 459, 'Шацький р-н', 'Шацкий р-н', 2, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 459,
           AREA_NAME = 'Шацький р-н',
           AREA_NAME_RU = 'Шацкий р-н',
           REGION_ID = 2,
           KOATUU = null
     where AREA_ID = 473;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 474, 460, 'Шевченківський р-н', 'Шевченковский р-н', 22, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 460,
           AREA_NAME = 'Шевченківський р-н',
           AREA_NAME_RU = 'Шевченковский р-н',
           REGION_ID = 22,
           KOATUU = null
     where AREA_ID = 474;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 475, 461, 'Шепетівський р-н', 'Шепетовский р-н', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 461,
           AREA_NAME = 'Шепетівський р-н',
           AREA_NAME_RU = 'Шепетовский р-н',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 475;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 476, 462, 'Широківський р-н', 'Широковский р-н', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 462,
           AREA_NAME = 'Широківський р-н',
           AREA_NAME_RU = 'Широковский р-н',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 476;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 477, 463, 'Ширяївський р-н', 'Ширяевский р-н', 16, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 463,
           AREA_NAME = 'Ширяївський р-н',
           AREA_NAME_RU = 'Ширяевский р-н',
           REGION_ID = 16,
           KOATUU = null
     where AREA_ID = 477;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 478, 464, 'Шишацький р-н', 'Шишацкий р-н', 17, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 464,
           AREA_NAME = 'Шишацький р-н',
           AREA_NAME_RU = 'Шишацкий р-н',
           REGION_ID = 17,
           KOATUU = null
     where AREA_ID = 478;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 479, 465, 'Шосткинський р-н', 'Шосткинский р-н', 20, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 465,
           AREA_NAME = 'Шосткинський р-н',
           AREA_NAME_RU = 'Шосткинский р-н',
           REGION_ID = 20,
           KOATUU = null
     where AREA_ID = 479;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 480, 466, 'Шполянський р-н', 'Шполянский р-н', 25, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 466,
           AREA_NAME = 'Шполянський р-н',
           AREA_NAME_RU = 'Шполянский р-н',
           REGION_ID = 25,
           KOATUU = null
     where AREA_ID = 480;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 481, 467, 'Шумський р-н', 'Шумский р-н', 21, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 467,
           AREA_NAME = 'Шумський р-н',
           AREA_NAME_RU = 'Шумский р-н',
           REGION_ID = 21,
           KOATUU = null
     where AREA_ID = 481;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 482, 468, 'Щорський р-н', 'Щорский р-н', 27, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 468,
           AREA_NAME = 'Щорський р-н',
           AREA_NAME_RU = 'Щорский р-н',
           REGION_ID = 27,
           KOATUU = null
     where AREA_ID = 482;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 483, 469, 'Юр’ївський р-н', 'Юрьевский р-н', 3, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 469,
           AREA_NAME = 'Юр’ївський р-н',
           AREA_NAME_RU = 'Юрьевский р-н',
           REGION_ID = 3,
           KOATUU = null
     where AREA_ID = 483;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 484, 470, 'Яворівський р-н', 'Яворовский р-н', 14, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 470,
           AREA_NAME = 'Яворівський р-н',
           AREA_NAME_RU = 'Яворовский р-н',
           REGION_ID = 14,
           KOATUU = null
     where AREA_ID = 484;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 485, 471, 'Яготинський р-н', 'Яготинский р-н', 10, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 471,
           AREA_NAME = 'Яготинський р-н',
           AREA_NAME_RU = 'Яготинский р-н',
           REGION_ID = 10,
           KOATUU = null
     where AREA_ID = 485;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 486, 472, 'Якимівський р-н', 'Якимовский р-н', 7, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 472,
           AREA_NAME = 'Якимівський р-н',
           AREA_NAME_RU = 'Якимовский р-н',
           REGION_ID = 7,
           KOATUU = null
     where AREA_ID = 486;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 487, 473, 'Ямпільський р-н', 'Ямпольский р-н', 1, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 473,
           AREA_NAME = 'Ямпільський р-н',
           AREA_NAME_RU = 'Ямпольский р-н',
           REGION_ID = 1,
           KOATUU = null
     where AREA_ID = 487;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 488, 473, 'Ямпільський р-н', 'Ямпольский р-н', 20, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 473,
           AREA_NAME = 'Ямпільський р-н',
           AREA_NAME_RU = 'Ямпольский р-н',
           REGION_ID = 20,
           KOATUU = null
     where AREA_ID = 488;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 489, 474, 'Ярмолинецький р-н', 'Ярмолинецкий р-н', 24, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 474,
           AREA_NAME = 'Ярмолинецький р-н',
           AREA_NAME_RU = 'Ярмолинецкий р-н',
           REGION_ID = 24,
           KOATUU = null
     where AREA_ID = 489;
end;
/

begin
  Insert into BARS.ADR_AREAS
    ( AREA_ID,SPIU_AREA_ID,AREA_NAME,AREA_NAME_RU,REGION_ID,KOATUU )
  Values
    ( 490, 475, 'Ясинуватський р-н', 'Ясиноватский р-н', 4, null );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_AREAS
       set SPIU_AREA_ID = 475,
           AREA_NAME = 'Ясинуватський р-н',
           AREA_NAME_RU = 'Ясиноватский р-н',
           REGION_ID = 4,
           KOATUU = null
     where AREA_ID = 490;
end;
/


commit;
