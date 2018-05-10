-- ======================================================================================
-- Module :
-- Author : BAA
-- Date   :
-- ===================================== <Comments> =====================================
-- Script for insert or update table "ADR_STREET_TYPES"
-- ======================================================================================
SET FEEDBACK     OFF

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 1, 'алея', 'аллея' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'алея',
           STR_TP_NM_RU = 'аллея'
     where STR_TP_ID = 1;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 2, 'бул.', 'бул.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'бул.',
           STR_TP_NM_RU = 'бул.'
     where STR_TP_ID = 2;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 3, 'в’їзд', 'въезд' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'в’їзд',
           STR_TP_NM_RU = 'въезд'
     where STR_TP_ID = 3;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 4, 'вул.', 'ул.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'вул.',
           STR_TP_NM_RU = 'ул.'
     where STR_TP_ID = 4;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 5, 'гай', 'роща' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'гай',
           STR_TP_NM_RU = 'роща'
     where STR_TP_ID = 5;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 6, 'дорога', 'дорога' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'дорога',
           STR_TP_NM_RU = 'дорога'
     where STR_TP_ID = 6;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 7, 'ж/м', 'ж/м' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'ж/м',
           STR_TP_NM_RU = 'ж/м'
     where STR_TP_ID = 7;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 9, 'кв.', 'кв.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'кв.',
           STR_TP_NM_RU = 'кв.'
     where STR_TP_ID = 9;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 10, 'лінія', 'линия' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'лінія',
           STR_TP_NM_RU = 'линия'
     where STR_TP_ID = 10;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 11, 'майд.', 'пл.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'майд.',
           STR_TP_NM_RU = 'пл.'
     where STR_TP_ID = 11;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 12, 'мікр.', 'микр.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'мікр.',
           STR_TP_NM_RU = 'микр.'
     where STR_TP_ID = 12;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 13, 'наб.', 'наб.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'наб.',
           STR_TP_NM_RU = 'наб.'
     where STR_TP_ID = 13;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 15, 'остр.', 'остр.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'остр.',
           STR_TP_NM_RU = 'остр.'
     where STR_TP_ID = 15;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 16, 'панс.', 'панс.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'панс.',
           STR_TP_NM_RU = 'панс.'
     where STR_TP_ID = 16;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 17, 'парк', 'парк' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'парк',
           STR_TP_NM_RU = 'парк'
     where STR_TP_ID = 17;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 18, 'пзз.', 'пзз.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'пзз.',
           STR_TP_NM_RU = 'пзз.'
     where STR_TP_ID = 18;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 19, 'пл.', 'пл.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'пл.',
           STR_TP_NM_RU = 'пл.'
     where STR_TP_ID = 19;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 20, 'пров.', 'пер.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'пров.',
           STR_TP_NM_RU = 'пер.'
     where STR_TP_ID = 20;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 21, 'проїзд', 'проезд' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'проїзд',
           STR_TP_NM_RU = 'проезд'
     where STR_TP_ID = 21;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 22, 'просп.', 'просп.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'просп.',
           STR_TP_NM_RU = 'просп.'
     where STR_TP_ID = 22;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 23, 'прохід', 'проход' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'прохід',
           STR_TP_NM_RU = 'проход'
     where STR_TP_ID = 23;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 24, 'радг.', 'совх.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'радг.',
           STR_TP_NM_RU = 'совх.'
     where STR_TP_ID = 24;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 25, 'роз’їзд', 'разъезд' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'роз’їзд',
           STR_TP_NM_RU = 'разъезд'
     where STR_TP_ID = 25;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 26, 'розвилка', 'развилка' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'розвилка',
           STR_TP_NM_RU = 'развилка'
     where STR_TP_ID = 26;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 27, 'санат.', 'санат.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'санат.',
           STR_TP_NM_RU = 'санат.'
     where STR_TP_ID = 27;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 28, 'селище', 'поселок' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'селище',
           STR_TP_NM_RU = 'поселок'
     where STR_TP_ID = 28;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 29, 'сквер', 'сквер' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'сквер',
           STR_TP_NM_RU = 'сквер'
     where STR_TP_ID = 29;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 30, 'ст.', 'ст.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'ст.',
           STR_TP_NM_RU = 'ст.'
     where STR_TP_ID = 30;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 32, 'тракт', 'тракт' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'тракт',
           STR_TP_NM_RU = 'тракт'
     where STR_TP_ID = 32;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 33, 'траса', 'трасса' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'траса',
           STR_TP_NM_RU = 'трасса'
     where STR_TP_ID = 33;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 34, 'тупик', 'тупик' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'тупик',
           STR_TP_NM_RU = 'тупик'
     where STR_TP_ID = 34;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 35, 'узвіз', 'спуск' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'узвіз',
           STR_TP_NM_RU = 'спуск'
     where STR_TP_ID = 35;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 36, 'урочище', 'урочище' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'урочище',
           STR_TP_NM_RU = 'урочище'
     where STR_TP_ID = 36;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 37, 'уч.', 'уч.' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'уч.',
           STR_TP_NM_RU = 'уч.'
     where STR_TP_ID = 37;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 38, 'хутір', 'хутор' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'хутір',
           STR_TP_NM_RU = 'хутор'
     where STR_TP_ID = 38;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 39, 'шахта', 'шахта' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'шахта',
           STR_TP_NM_RU = 'шахта'
     where STR_TP_ID = 39;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 40, 'шлях', 'путь' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'шлях',
           STR_TP_NM_RU = 'путь'
     where STR_TP_ID = 40;
end;
/

begin
  Insert into BARS.ADR_STREET_TYPES
    ( STR_TP_ID,STR_TP_NM,STR_TP_NM_RU )
  Values
    ( 41, 'шосе', 'шоссе' );
exception
  when DUP_VAL_ON_INDEX then
    update BARS.ADR_STREET_TYPES
       set STR_TP_NM = 'шосе',
           STR_TP_NM_RU = 'шоссе'
     where STR_TP_ID = 41;
end;
/


commit;
