
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_accm_calendar.sql =========*** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_ACCM_CALENDAR 
is

    -----------------------------------------------------------------
    --                                                             --
    --                                                             --
    --             Пакет заполнения таблиц состояний               --
    --                                                             --
    --                                                             --
    -----------------------------------------------------------------


    -----------------------------------------------------------------
    --                                                             --
    -- Константы                                                   --
    --                                                             --
    -----------------------------------------------------------------

    --
    -- Идентификация версии
    --

    VERSION_HEADER       constant varchar2(64)  := 'version 0.2 14.07.2011';
    VERSION_HEADER_DEFS  constant varchar2(512) := '';


    -----------------------------------------------------------------
    -- GET_CALENDAR_ID()
    --
    --     Функция получения идентификатора для указанной даты
    --
    --     Параметры:
    --
    --         p_date     Дата
    --
    function get_calendar_id(
                  p_caldate in date ) return number;

    -----------------------------------------------------------------
    -- GET_CALENDAR_DATE()
    --
    --     Функция получения даты по идентификатору
    --
    --     Параметры:
    --
    --         p_caldtid     ID снимка
    --
    function get_calendar_date(
                  p_caldtid in number ) return date;

    -----------------------------------------------------------------
    -- CREATE_CALENDAR()
    --
    --     Процедура разметки календаря
    --
    --     Параметры:
    --
    --         p_enddate     Конечная дата разметки
    --
    procedure create_calendar(
                  p_enddate in date );


    -----------------------------------------------------------------
    -- SET_CALENDAR_DATES()
    --
    --     Установка банковской и отчетной дат для указанной
    --     календарной даты
    --
    --     Параметры:
    --
    --         p_caldate      Календарная дата
    --
    --         p_bankdate     Банковская дата
    --
    --         p_repdate      Отчетная дата
    --
    --
    procedure set_calendar_dates(
                  p_caldate  in date,
                  p_bankdate in date,
                  p_repdate  in date  );


    -----------------------------------------------------------------
    -- SYNC_CALENDAR()
    --
    --     Процедура синхронизации календаря
    --
    --
    procedure sync_calendar;



    -----------------------------------------------------------------
    --                                                             --
    --  Методы идентификации версии                                --
    --                                                             --
    -----------------------------------------------------------------

    -----------------------------------------------------------------
    -- HEADER_VERSION()
    --
    --     Функция получения версии заголовка пакета
    --
    --
    --
    function header_version return varchar2;


    -----------------------------------------------------------------
    -- BODY_VERSION()
    --
    --     Функция получения версии тела пакета
    --
    --
    --
    function body_version return varchar2;



end bars_accm_calendar;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_ACCM_CALENDAR wrapped
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
24c2 a70
h8Ah4U8Yx4a5CD/v18TSHPDXfz8wgw2juiCDWo4ZFz+Ven5GO/BphZ+/Y1DDZTPIVEQTDS7s
EQ3Ccbi6dzlmWQpg/NCaviPi3xsBc2d2Ev8BvE6Qghc5i0G1PJg3cHZbKI8QLQqb4L7PR5yV
nMADxZ/tfM2BpkXLz/WqhCK7cPFAUom2CtKbhhbXNBYdv4cGmiP6Y07B1R+pCvZQtSu55YGf
HdE5ZN2lPY8GZK9Dlbi0LIjlm6bcCRPlJECc0cwCRkaWA1elhqbhKWXpqoDcL8xyTz4lTsR4
vhtI8iiW0U04X8VElNVrnjQU7EOG3dlwHEb6+3jRcblAJE7t3t3o0IloLgLxz9NJuzQUEb/J
Jcp6YJEOJWIVC6h2aJNVIG9IZeOoKduC2caR8zqI4KZTN5NKdDCCda8UnU7omX3SqVLXCA7n
8OE4wxLnccjdfvfjSaLTLU/jfXujyYWTCIZbfSgip/iw4MQ+HAw5qzp14CjjqnWdwkD3ZQN/
NL2MIzkLlqHHIPNGMcoMeix7cwP8nokTc7mIenmxEwBn6Pm+zv6S15M9JFtOx39enAg8wxhk
jtxr0LBl6eORLV1BQBkU9Bepym75I4LwxhnDpKW5bxsvKKaxFTNaiAtPNsB2NaCWv49qMx7J
Msu8lA+8p6lyhFddnnmlGQfHdv5Bi+Y2UVeAdE5p0VZRppHO9zatngmgddxsLszK7rbcqe/w
y15lg2wnIxhiQyxWG3UyO0nE9seE2cqUPl2UCcWt1Cz1AsJEaqNbhjQw+hk4uqf1q+0WDI02
6WOZPv7xenSK+vT2/eE2SUk6uknJoHXwOMDloKINMO0Jt9O6/xWpEVHU3BNKk24LsG4jSsEO
naOyHCxbcn38mMBwVNzTnC/Den9YbQBiSQjsae8F65v3/MpUh9ZWNa8vHFMHfcMQTNGzGmny
m0qm2BgQvTzVS+KpIgODNbHyZTPxgyFOxD6/Hs5OGkOKiVMhe6R/f9HXd0dafAQkNq0tUL0m
9H9hyLc28w/Oi7UUsBzmAkpWAESoHvosgKFGXQ1ngZVZfhruN45e3qEvAK1/JjwfacdB2yJ0
bwQKNgaBNwqggrbtCW2LoVNTaKhNXKs5bTGKNyY4KvHtr9GRirKwsEeHK1TwJZelxAxBdYN0
6G8Jd3jP5upRyWXeHqXU4hhec2hBes5EhGeZfrpvk4L6OG8XGe1qLJhvKkicStj/LcYG2tcD
A55XTfxPXOIqMSFZDf6gbri3gA1IOZr0anyhBpHIMDieTuPkhktVdsAa3J2hdRoUA04W/1AZ
fF9wUL8Te53ednKU9qUiR026bhogV5ZgJ9WFiEq0FSCqHWr3rWDJjqqpYEXsvHzyOPHMQRav
x37PwJSTJSZj3bM6MnFoDXXWQ+KiriuWSu1frTVF9u3Gb0wmYj387n2V+NTUKMwSXu2nsM0A
1WSdwTzMC5Yj1ere+E02/5RMj6KVNFHwlbzC0pSi9zsRAz+0FjGRxVhcGLwV4ECOQaPWYpuX
SJk9gpiOEiRkcyGiwYGK3JjiyAVrU+16UdnE6e2B056tN/Xw4DbvrsRESjfHPWHVTYRi8AZI
FmpUfmM4R5w5hiHlEVMfNjpWSsIFd2vxeBSv61nDH7nbrcTW8lm1vlafUzx0lihI4KWrPGve
FNEyN0oc81CITcEdwGhKVLBa3t6HjHfHppWyEAzXaMC65An5s5gM0ap3o8w/mowTwEQifh4C
jO9Tklbao5EK87RIWrjELN35thg+YUz6mUBgRUXfqBlYhbPEGwpS3i2eadGDWWIRsiB+mlAV
4U2+bo7t9vqtjGdLN35bD0nWIl8whD33OEf+QFL13ibG9DWnhB2n4wdRhFBbleI2ETuocVCY
9NFV1tnq9QyXsxhsfKYcSBsaxiFmpwN7QdWSOktSWbHPYHle9l22suI8B7dlVE87g+wQz6Qn
zjuvQlVLEsofYIC9GtsazAf0S4xpnpbRFlI8MATFwOiH0DutgsHtTVySaRlNfBdgJ2nNOwzY
QZ9oVSuoABd7tLPrUkhBVQ1EMy79XH6zEGIld8hQCgrk2LFaN9GvS0RrayIx3SDYQt9Q+rVi
7/AlsfYHdXB+AgSEHoXrI2Ly3G4Wtoseilrrs/bbvrx/cnRfeSz8isyU8u8g0XkplTnQarF5
IKRWi1P8Q1KJB8ymuymop0OYL/NiuliqD34ityOH2KXsnZqsJ156XE9hEmnNQ0RTSZSbhjMw
i7wKhngoJTzNqJtcPPnSOfxCA4rPHDyCHc+41mt40baiKiwgHaRSp4nrMxxbQVVm4sGD+9hT
2+yb/uHRok8X7+VTBhSp40MoDTVtyVKLcHYTIc9/DQXR2eWjqmgEea9wfGnaHarK6IO0Sv3/
up8ewmaqymuLKFdIO8UdNnrsP7ZfxZ8yN+5jaVTqCtYscslrh7DaQcZ8BNk988hStiQS0lFd
jgyli89+Ej3OYHNNnQ6+AoepEt+SutBhZPw9bgsd+K6Vm8cILTZPl+BcubSgQzKy0lLxTprx
acfO9KoTDsCPUboArvWQCptqIwMZZMT9sMBkkuVL6Fjk3OnPAQ7/ueO2O6ssm4acT2DBc5+B
zy/9m7eQSIUvEFW4Jqrt72n3wUZ/qHJ0wWCd5FteASLt
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_accm_calendar.sql =========*** 
 PROMPT ===================================================================================== 
 