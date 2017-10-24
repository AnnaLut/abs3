
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_ies.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_IES 
is

    -----------------------------------------------------------------
    --                                                             --
    --         Пакет иморта/экспорта/синхронизаци                  --
    --         данных/справочников данных АБС БАРС                 --
    --         (anny)                                              --
    -----------------------------------------------------------------


    -----------------------------------------------------------------
    -- Константы                                                   --
    -----------------------------------------------------------------

    head_ver  constant varchar2(64)  := 'version 1.2 08.01.2013';
    head_awk  constant varchar2(512) := '';

    --
    -- возвращает версию заголовка пакета
    --
    function header_version return varchar2;

    --
    -- возвращает версию тела пакета
    --
    function body_version return varchar2;


    ------------------------------------------------------------------
    -- DELETE_TAB_DATA()
    --
    --   Удаление данных из твблицы справоника
    --
    --   p_tabname    - имя таблицы oracle
    --
    procedure delete_tab_data(p_tabname     varchar2 );

    ------------------------------------------------------------------
    -- SYNC_GRANTS()
    --
    --   Устанавливает гранты на start1 для только что созданной промежуточной
    --   таблицы при синхронизации справочников.
    --   Промежуточная табл. создается в схеме БАРС
    --
    --   p_tabname - имя промежуточной таблицы
    --
    --
    procedure sync_grants(
                   p_tabname         varchar2);



    ------------------------------------------------------------------
    -- SYNC_RECREATE_TAB()
    --
    --   Процедура пересоздания таблицы для
    --   функции 'Редактировнаие синхронизируемых таблиц'
    --
    --   p_tabname    - имя таблицы oracle
    --
    --   p_sqlcolumns - sql создания таблицы (только колонки)
    --
    --   p_forcerecr  - пересоздавать ли таблицу
    --
    procedure sync_recreate_tab(
                   p_tabname     varchar2,
                   p_sqlcolumns  varchar2,
                   p_forcerecr   smallint );



    ------------------------------------------------------------------
    -- TAB_EXIS()
    --
    --   Процедура  смотрит на наличие данной таблицы в БД
    --
    --
    --   p_tabname     имя таблицы oracle
    --
    --   p_isexists    существует ли
    --
    --
    procedure tab_exists(
                  p_tabname         varchar2,
                  p_isexists    out smallint);




    ------------------------------------------------------------------
    --  EXPORT_TO_DBF()
    --
    --    Экспорт таблицы в DBF
    --
    --    p_tabname     имя таблицы oracle
    --
    --    p_dbfencode   кодировка (UKG - укр гост, DOS, WIN)
    --
    --
    procedure export_to_dbf(
                  p_tabname         varchar2,
                  p_dbfencode       varchar2 default 'DOS');




    ------------------------------------------------------------------
    --  IMPORT_FROM_DBF()
    --
    --    Экспорт таблицы в DBF
    --
    --    p_tabname     имя таблицы oracle
    --
    --    p_dbfencode   кодировка (UKG - укр гост, DOS, WIN)
    --
    --
    procedure import_from_dbf(
                  p_tabname         varchar2,
                  p_dbfencode       varchar2 default 'DOS');


end bars_ies;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_IES wrapped
a000000
ab
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
b
1412 6f4
3Dw9V0+zq4Hk8pEDQ2h2jTP8Ou4wg5VUutCDYI65HpLqbngL9MpZnwW5CcWIEqbV1Oi8FBNJ
mVQgGBXhKn49jc4tw/J3jSXwiSv8DA8jeguGmQtwt3n2vQuKWIKa/pDZdoJpdx/ynGcFJYdq
EQTRc6FLjvWALzbdjOSgTm5B74L5DOAdTacpUxgpFQyVKxIYVU3PEMX7caBn5K3nnLc6dF2D
iHedOz1Do4zRJB8TJkRDPZlBAoK+qMyZUd05vxCxK8PhNK/A7f85SdgnU+HQ8saCXOrEWX3z
6e+fNpr0P4PbgX7H9i9pjp7I9TK3hzVlonZ0xiAHIOHOfwSHRO5E4x4ykVZlDYcKAP2vWh4y
ej4i2+NdXLgAWC4rTWB7vbuCn9t3nnXLL1p3tXHOjDo9pEUW5vF1I47k278+5FZRi2vIxdqy
fgxs7Be2uIcT5ZoNs3LcbCgHpB2aXIPoJUkF2r0QPn/U9/uFbMwAnKkZu7Yu6qXydgevuJTd
Bp8hkF84QngTcrlIZkoFbDz28+LBqC7sozM1x9AxeO64YawBfLLU1d2OFqtx1zi+q0DVrfQ9
ZnftEWo6IanTFsWIUARCPe8bVEgoEOEw/6s82mlSP3zDDO9QrBebQoSnfQR8AGoRyagEy/u6
s6TxmG3Lsdop7Oin8VcO6ZQbAwEvBv7NBp4mw3+g6PsJBvagavfiDWKE+CLefN7bytH0R87s
BsWNz6V+TmDgTlRokRCva47WvMvBeGxSr6Kt48AkwOw538x5UXzhNJGP6yYbQml2WaQgMBDr
reC4xsJc0/vdD9wPf3Sk1SDcFnpfU1cX1WXV+lIxYBfg4PBzfHAIHmRA79jv18N9tAm6LaQP
CCFVO7P0lAv2pm/5m7ApMCLt7VhiusO5ib3wp+4R3zS9o5UWo851NIbKoxMADK2hBUuUU4iF
x89XD4rVby7uznrbIV8DS4FZIhAZcD5URzVInouCfEoNdo0WxgNxui/BU8ijoWQYY7Bu2pdf
DbA0bxzShiwTDyRotQ0x+jMkmnkiNKq04wmni3892C9Fk1xyrv3kRSsrMZ8nujVoHVHNhnMp
hiC73yj+uwv7+RnzDi/rCU7IJAbXqUJdqQ2AbcWJoSOf1NDrCaH+1ex6VU/0gL34Kfnuhmpz
uzpQ5oiu+WMQJJi7CDicSED6G3V+GH4kod+VC3hq7f9HOmmPkgkinJ04C8zvMJFqUpuaL0aG
1XBZgT56CeF8cV/JgUVxAsReqt9FlCzMzQJzy4VJttB/ZF2w+tK+YngAY7KAd+/3DFXuxFVD
TL8NGqpnOXej0tmbaHkoqAjs9WvKjdYQE/ysdFevl5MetCskiEOtzoNGU3QGovyC0zkIPv9v
MNb7LdUxwGkrCVTQrD13KD9YVurZbfGXl0HJMz43tuHo6RIuaKkA0rrf0wmrHzuSnIx/YsSp
Ef3zrrbTXcBwMeK7Zmufwd5R4bLzt7wQXcYLsBnMempEzAN2UiBffK9QabIkP44oVjmPdbGV
xapZrCaBEG8LNT2WUKDD4O2ubOhW+Q/3qPyLBUA96NOGv4LtkKaFcwglXc4bpBhkpphEEPhi
kUz09j3gpFEy1XRgg2vrQN/U6Nqgh6wB1jy5A75MBqvbikXtkRvPseUMlWFA0el+BcL2oDTC
HhhNtoDYlwkzjd+xjRruyVQYK7kUz8hNHwLz1gkAfa57IbyvLNeH+/ihz5ezTbe2kiIHpD8G
wZCFlMAtDLVN9OPKVYvqtaYq0zuW
/
 show err;
 
PROMPT *** Create  grants  BARS_IES ***
grant EXECUTE                                                                on BARS_IES        to ABS_ADMIN;
grant EXECUTE                                                                on BARS_IES        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_IES        to IMPEXP;
grant EXECUTE                                                                on BARS_IES        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_ies.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 