
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_dbf.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_DBF IS
-----------------------------------------------------------
--
--  Работа с DBF файлами
--
--  1. Выгрузка в DBF файл:
--     Если при выгрузке не указывается явно структура DBF файла (при выгрузке функой
--     DBF_FROM_TABLE и DBF_FROM_SQL(без структуры)), формат исходящих dbf файлов формируется
--     по правилам Centura DBase Driver
--
-----------------------------------------------------------

  G_HEADER_VERSION      constant varchar2(64)  := 'version 4.0 18.11.2010';

  WIN_TBL   varchar(75) :='АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЪЫЭЮЯІЇЄабвгдеёжзийклмнопрстуфхцчшщьъыэюяіїє№Ґґ';
  UKG_TBL   varchar(75) :='ЂЃ‚ѓ„…р†‡€‰Љ‹ЊЌЋЏђ‘’“”•–—™њљ›ќћџцшф ЎўЈ¤Ґс¦§Ё©Є«¬­®Їабвгдежзиймклнопчщхьту';




    ----------------------------------------
    -- IS_MEMO_EXISTS_CNT()
    --
    --    Существуют ли поля MEMO
    --    предполагается что файл был вгружен уже через ы-цию get_buffer и помещен полностью в переменную
    --    G_EXCH_BLOB_DBF
    --
    --    p_exists =0 - не существует, =1 - существует
    ----------------------------------------
    procedure is_memo_exists_cnt(
                p_exists  out smallint);


    ----------------------------------------
    --  GET_MEMO_FIELD()
    --
    --    Получить клоб - для текста MEMO поля
    --    Вля FoxBase - это файл DBT, конец текста определяется наличием символа 1A
    --
    --    p_mblob     - мемо файл
    --    p_blocknbr  - номер блока
    --    p_srcencode - исходная кодировка memo
    ----------------------------------------

    /*procedure  get_memo_field(
                  p_mblob     BLOB,
                  p_blocknbr  number,
                  p_srcencode varchar2 );*/



    ----------------------------------------------------
    --  SET_BUFFER()
    --
    --    Инициализировать или добавить в буффер глоб. переменную
    --
    --    p_buff       - кусок буффера
    --    p_bufftype   - тип загружаемого файла (DBF, DBT)
    --    p_bufflen    - Длинна буффера с данными
    --
    ----------------------------------------------------
    procedure set_buffer(
                  p_buff     varchar2,
                  p_bufftype varchar2,
                  p_bufflen  number );




    ----------------------------------------------------
    --  GET_BUFFER()
    --
    --    Взять часть из буффера пакета
    --
    --
    ----------------------------------------------------
    procedure get_buffer(
                  p_buff     out varchar2,
                  p_bufflen  out number,
                  p_offset       number,
                  p_amount       number);


    ----------------------------------------------------
    --  GET_EXPORTED_ROWSCOUNT()
    --
    --    кол-во выгруженных строк в DBF
    --
    ----------------------------------------------------
    procedure get_exported_rowscount(p_rowscount out number);



    ----------------------------------------
    --  DBF_FROM_TABLE()
    --
    --    Выгрузка таблицы в DBF формат без указания формата файла DBF -
    --    по правилам Centura DBase Driver
    --    Как результат в переменную p_blobdbf помещается созданный dbf
    --
    --    p_tabnam        - имя таблицы для выгрузки
    --    p_where_clause  - WHERE условие выборки данных из таблицы (без слова WHERE)
    --    p_encode        - кодировка
    --    p_blobdbf       - переменная в которую помещаем результирующий blob DBF-а.
    --
    ----------------------------------------
    procedure dbf_from_table (
                     p_tabname           varchar2,
                     p_where_clause      varchar2 default '',
                     p_encode            varchar2 default 'WIN',
                     p_blobdbf       out blob );






    ----------------------------------------
    --  DBF_FROM_TABLE()
    --
    --    Выгрузка таблицы в DBF формат без указания формата файла DBF - по правилам
    --    Centura DBase Driver
    --    Как результат во временную таблицу tmp_lob (колонка rawdata)
    --    помещаем тело созданого DBF. Это для дальнейшей работы с
    --    blob-ами в Centure, через функции PutLoadedDBFToFile (absapi.apl)
    --
    --    p_tabnam        - имя таблицы для выгрузки
    --    p_where_clause  - WHERE условие выборки данных из таблицы (без слова WHERE)
    --    p_encode        - кодировка
    --
    ----------------------------------------
    procedure dbf_from_table (
                     p_tabname       varchar2,
                     p_where_clause varchar2 default '',
                     p_encode       varchar2 default 'WIN');





    ----------------------------------------
    -- DBF_FROM_SQL ()
    --
    --    Выгрузка в DBF структуру c указанием SQL-я,
    --    с указанием структуры DBF файла.
    --    Как результат во временную таблицу tmp_lob (колонка rawdata)
    --    помещаем тело созданого DBF. Это для дальнейшей работы с
    --    blob-ами в Centure, через функции PutLoadedDBFToFile (absapi.apl)
    --
    --    p_sql           - SQL запрос
    --    p_dbfstruct     - структура описанная через запятую
    --                      (если отсутсвует структура берется из динамического описания SQL-я)
    --    p_encode        - кодировка
    --
    ----------------------------------------

    procedure  dbf_from_sql(
                    p_sql       varchar2,
                    p_dbfstruct varchar2 default null,
    		  p_encode    varchar2 default 'WIN');


    ----------------------------------------
    -- DBF_FROM_SQL ()
    --
    --    Выгрузка в DBF структуру c указанием SQL-я,
    --    с указанием структуры DBF файла.
    --    Как результат в переменную p_blobdbf помещается созданный dbf
    --
    --    p_sql           - SQL запрос
    --    p_dbfstruct     - структура описанная через запятую
    --                      (если отсутсвует структура берется из динамического описания SQL-я)
    --    p_encode        - кодировка
    --    p_blobdbf       - переменная в которую помещаем результирующий blob DBF-а.
    --
    ----------------------------------------

    procedure  dbf_from_sql(
                    p_sql           varchar2,
                    p_dbfstruct     varchar2 default null,
    	            p_encode        varchar2 default 'WIN',
                    p_blobdbf   out blob );



    ----------------------------------------
    --  DBF_FROM_SQLDESC()
    --
    --    Выгрузка таблицы в DBF формат по указанной строке.
    --    Создана для функции выгрузки в Centura Bars Millenium в формат DBF
    --    По описанию строки - определяем выгружать как
    --    dbf_from_table или dbf_from_sql
    --
    --    p_sqldesc       - строка описания
    --    p_coldescr      - описание колонок структуры через запятую
    --    p_encode        - кодировка DBF файла (WIN, DOS, UKG). Предполагается, что
    --                      исходные данные в WIN кодировке
    ----------------------------------------
    procedure  dbf_from_sqldesc(
                    p_sqldesc     varchar2,
                    p_coldescr    varchar2,
                    p_encode      varchar2 default 'WIN');



    ----------------------------------------
    -- IMPORT_DBF_CNT()
    --
    --    Весия для Centura (без использования TMP_LOB)
    --    Загрузить DBF файл в таблицу, предполагается что файл
    --    был вгружен уже через ы-цию get_buffer и помещен полностью в переменную
    --    G_EXCH_BLOB
    --
    --    p_tabname     --  Имя таблицы для вгрузки
    --    p_createmode  --  =1 - пересоздавать такую таблицу,
    --                      =0 - если такая существует, создать новую и к имени таблицы
    --                            добавить хвост с текущим временем
    --                      =2 - удалить все данные из таблицы
    --                      =3 - ничего не делать, если такая существует
    --    p_srcencode   --  кодировка вход. файла
    --    p_descencode  --  кодировка данных для вставки
    --
    ----------------------------------------
    procedure  import_dbf_cnt(
                    p_tabname     varchar2,
                    p_createmode  smallint,
  	            p_srcencode   varchar2 default 'DOS',
                    p_destencode  varchar2 default 'WIN');




    ----------------------------------------
    -- EXPORT_DBF_CNT()
    --
    --    Весия для Centura (без использования TMP_LOB)
    --    Выгрузить в DBF файл таблицу. Выгрузка происходит
    --    в глобальную переменную G_EXCH_BLOB. Предполагается, что потом в Centure
    --    эту переменную вычитают процедурой get_buffer
    --
    --    p_tabname     --  Имя таблицы для выгрузки
    --    p_destencode  --  кодировка исход. DBF файла
    --
    ----------------------------------------
    procedure  export_dbf_cnt(
                    p_tabname     varchar2,
                    p_destencode  varchar2 default 'WIN');





    ----------------------------------------
    --  IMPORT_DBF_SRV()
    --
    --    Импорт dbf файла-а с сервера оракла
    --    через BFILE
    --
    --    p_oradir      --  директория оракла oracledir
    --    p_filename    --  имя файла (если null - имя таблицы - это имя файла без расширения)
    --    p_createmode  --  =1 - пересоздавать такую таблицу,
    --                      =0 - если такая существует, создать новую и к имени таблицы
    --                            добавить хвост с текущим временем
    --                      =2 - удалить все данные из таблицы
    --                      =3 - ничего не делать, если такая существует
    --    p_srcencode   --  кодировка вход. файла
    --    p_descencode  --  кодировка данных для вставки
    --
    --
    ----------------------------------------

    procedure  import_dbf_srv(
                  p_oradir      varchar2,
                  p_filename    varchar2,
                  p_tabname     varchar2 default null,
                  p_createmode  smallint default 1,
  	          p_srcencode   varchar2 default 'DOS',
                  p_destencode  varchar2 default 'WIN');



    ----------------------------------------
    -- LOAD_DBF()
    --
    --    Загрузить DBF файл в таблицу
    --
    --    p_dbfblob     --  данные dbf файла
    --    p_tabname     --  Имя таблицы для вгрузки
    --    p_createmode  --  =1 - пересоздавать такую таблицу,
    --                      =0 - если такая существует, создать новую и к имени таблицы
    --                            добавить хвост с текущим временем
    --                      =2 - удалить все данные из таблицы
    --                      =3 - ничего не делать, если такая существует
    --    p_srcencode   --  кодировка вход. файла
    --    p_descencode  --  кодировка данных для вставки
    --
    ----------------------------------------
    procedure  load_dbf(
                    p_dbfblob            blob,
                    p_tabname     in out varchar2,
                    p_createmode         smallint,
  	            p_srcencode          varchar2 default 'DOS',
                    p_destencode         varchar2 default 'WIN');



    ----------------------------------------
    --  GET_TBL()
    --
    --    Отдать таблицу символов
    --
    --    p_encode_table    -   значение WIN или UKG
    --
    ----------------------------------------
    function get_tbl(p_encode_table varchar2) return varchar2;



    ----------------------------------------
    --  GET_DBF_DESCRIPTION_CNT()
    --
    --    Узнать версию(описание) DBF, по данной нформации вычслить сущестует или нет memo
    --    и если существует, то какой расширение лоя файла  с мемо полями
    --
    --    предполагается что файл был вгружен уже через ы-цию get_buffer и помещен полностью в переменную
    --    G_EXCH_BLOB_DBF
    --
    --    p_tabname       - имя таблицы для импорта (для сообщений об ощибках)
    --    p_version       - числовое значение версии
    --    p_description   - описание
    --    p_ismemoexists  - мемо поле  0 - не существует, =1 - существует
    --    p_memofile      - расширение для файла с мемо полем
    ----------------------------------------
    procedure get_dbf_description_cnt(
                p_tabname           varchar2,
		p_version       out number,
                p_description   out varchar2,
                p_ismemoexists  out smallint,
                p_memofile      out varchar2);


end;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_DBF wrapped
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
11e4c 8be2
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
ilTMUiwpBUxw+qxTuRINvwqMO1fc1O0eM8tQueB6lbEz3SnNA9Yw6XZkUW0in/6Xsp90OwH1
cmC+77UnCGp4hbL67RfaMR+q/vpmQQW5p7of/GjDDfwtI7HEpld1Ulc/4dRFtfoxJNPON+bG
cte0x0u2BfzA6TEnthmvf1gTPc8MU6qx9CMtCsDnIX2Gb8y/pXgud1yYnSFO21jslztY9R6F
d4Urya0Tc11gYWXZnvumtJdLJKN3/3hvxLZE56Znpt0IasNxVi6FUsy+DWjC5qbd3FSfrdTp
QzTFOyHfjuGmTYzAhz6aB72cC3HD/9VD13moZ6a4ZEPPgcEPqrVDxJqB1MeUv9yHnR7UdqrO
hv6ac6cU1TamuJT9HthIO/SvmiFxSq+VjyDsTQphpqamZ6am56a6WOappvvhZ6bnpvvKpjap
pi+m4Wem56b7bntBQMOmpqampmmAQzTFOyHfpg5uJDKFo6SNTvJCx5mmFsFc0aampqamTYzA
h4gq+7mt3WCtZF/spqaXQumopp8V0YzJLvX5w9ZlJ/GCfgLhpnwnPKLBPVo8DTtZ/FHAh4gq
+iaMwIeNK6v9ytU2pnB32PT/CvfY9rpYd+lDNGUn8V6AQzQJGWjxlOE256amZ6amMsP/1Ywb
nAsfjU6XTaGopqam+3DVXspnqab74Wem56b7yqY2qaYvpuFnpuem+8qmNmekNGHJHFZgLvkP
rVcKjMCHiCr7puQ06a1khTbdoPOmqW2XQlyj3n6maf/VnvumU01u6pcTuqZp/9We+6ZTTW7q
YC6mpkM0US+mqW15yIPhprhi1tEBU1q/W3ym4WcxCt5spqZxftZopCLSt4ssu7L9pmempnEx
36sqf5su1GiGsKA4ewzBMnmEo8Yr5fL/fqdD4aampqapexmJ37RNkG54pwhe/DBeg3CMn8AZ
smk2pqampqYyoI0z1OGmhrB3syuD/ROZpqampqYOSpdCXKPefqbUrlLMrWTy1fCyreGmpqam
pk2MwIc+IEj7BCSV6UM0CRlo8ZThpjamqTNc60C+SIzMtgkfjU7loCW0yIZRwIc+IEjHccP/
1QOSnXT7pnB32PT/CrMUVAWDk83WdMQmbZdCXKPefoWe+6Zwd9j0/wqzFFQFg5PN1nTEJm2X
QmM0vtee++GmDkqXQgF3XcBfbZdCAXcaL6ZhZQKm++E256b7yqY2qaYvpuFnpuem+8qmNqmm
L6bhDsuHuoIob4wbUtPkVmEJrQzFpqampqZNC9VcbBdvplOnNZxlcV3hpqampql7GYnftE2Q
bnhv4gFQY3QfBNr3x7HxFL6mpqampg5KYSUZVKap9oj1PmpE1NxdaA0UeOvF+jbdoPOmqW2X
QgF3NqZp/9We+6am56YBZOiNpvumcHcU3KxPlSvFF6FEpqampqYyfmPlXUeL4aampqapexmJ
37RNkG543x+mpqampnezK4P9E5mmpqampnHD/9WMG5OoZ6amFojsfTSrMf72LINNbuombZdC
AXcU1TamqcwDG3tkYLdwefYXDShlaOjRxcGNzLfYL8qmfgGe++E25y+m4Wem56b7yqY2qaYv
puFnpuem+8qmNmekNGHJHFYRJAoBS7NNoSFz9RimpqamqXv8QqZT/pGPJTamgxF3FKcrq/3A
+6ampqYyoKgRIFY/GcBi1tEBU4VEpqampnezQHz24qVOp/aI9T5qRFimdd/hprgtjcXO/aZ8
Jzzbi1j9iAV9tPJc56bd6XPWH20xL6apzQnR0cZulOGmdeGmplBHGsfr5UPAR5Oopont7Cvm
pqYyoKgRIFacC/EDAwMDGi+mqW15yIOHSmTg/Rphv7/6gE+qkgooh7zjciTkVyKqCJWAnKGo
pqaMyS5+Qb73LfDLXgGMM0giCuygSiMcwHF3GSnl11ItjcXOE9gv4aYrmNWgv0Un+KrjTQve
FVoSsAqnYaCNpqam/BGEUBlU0cYUFxfBuxQCpqam/BGEdSrquK1g+lCi/awojNUF1JdAj4R+
zfh5Iw2Q27y9vEUYg9pMDaHLO9BFiagyzBKwCt/Z3hB3Y3TepAy2YIPaTA2TK+empsq0nxzl
5qamYWVZSQIvpqmmpuhxSlItjcVuaEzVNqam2vhwHlTsfCUZDcQNLrCIC9O3Z7qDnjampqam
pllJU7TylOQue9dgg5i0GTynv08lYO+6DLqD8qampqampo9Rsjiq8CqmpnDVavUJ5y+mpqam
aIlhUUpjve/NTBK6BfXsfxuzvXne1fumpqampuu9U7TylOQue9dgg5i0GTynv09ltPPV1dZt
O8Ovmhrrfhrtbc15eUL+Pnl3Y3RQp2HTpqampqamj1Gy7sDPh+empqampkuNOHs+Nqampqbh
pqamqRMlK3ctITga7fYg9hPcgtQUXOa6g542pqampqZZSY/g1VyleCkh/d674BK6uhkQ8v0K
Olkxpnne1fumpqampqbRgy/RxsECpqampqamuojot+am4aampqb7pqam3S7e1fxU7HwlGQ3E
DS6wiAvTnFCnYeH7pqampqbrvabRYQlEqrfcA/cz0WHEDUNVsKAIozlMl7g3pqampqamZys5
H7omrJ2hsDFaEh8FBYObuV6DTQyINqampqampsJlU7TylOQue9dgg5i0GTynv08l1CciXt+m
ed7V+6ampqamqW3fRtkIQqimpqampt0rQCkaL+GmpqamHquZ4aampqZNjLI1Egu+drdukJBz
Vj42pqampmmA/RXYvqzZf/JAG4MvzwRMMd8r3zYs4PaaIOsKV07JuX7/9OlXMlYuBN67xa0D
KSHZ3hB3Y3QmbTvDr5oa634a7W3NeXkD2C+mpqamZ0vNesMCpqampkuNNdlzzWOmWUlTEYRw
R6153tX7pqampnezQA7tLXFKof//0f/x5qampqamMqCoR+zVU3aMkRFRsq8Hs415CwGEpahh
M3Pf7RiCIIv/ixR4r+rqzBKxGTzf+iYL3hVaEur6WC6wk9ykDLZgg5gzYWEpIdneQb60GTzf
qwV9d5Ur5Y8gJd7fJRmVM2FhiJECpqampqasecFrxTampqapO3Troag2pqZ8Q8BfbTvDr508
M7r7prSXjzRkmaimfgGeqDappi+m4Wem56b7yqY2qaYvpuEOy4e6gihvoE89ZbQRdxSrBX3D
pqampmekgXqmadcXl0BxpqampmekDLamEYzMt1Sj3n6FNt2g86apbd82zfBDozlMl7j3+SHV
NqaPUbI4PHGvDXRFie7gvnssZ6YWEio7NqYOc9inr2CMG7O0YLDhpqampvxNwfupCF78TcGo
H6ampqZpxiU2ptSuJgve5tGmpqamDkrfNs3wAeSOH3nng/0TmaampqZNjLI4PHGvzj7Rgy/J
11wr56Zwe6/p/awz1Ju5XvEDAwMDRmGgjaampmyEtnnnIl+sbt/fK982LCUKV07JuX7cwAHV
/eh7gy/PWsBxoKhH7NXC4TamcNVq9QnnpqY2qTtZqKY2qaYvpuFnpuem+8qmNqmmL6bhDsuH
uoIob+J+/fDsBDGXV70/bxMX0ZSmpqamacaLWB2mplOnNZxlcV3hpqampvwRdxreanHEprhi
1tEBU9209G6Ypye5cdGmpqampg5KYSUZVKam4gFQY3QfBNr3x7HxaFkKFB+mpqampjLD/wol
8gsdPxlRbuqt4aampqb8TW7qlxO63XK6iU7FHft8eTamj1HAh40rq/2miU4Y5qam0cXBjZuL
b6aJThjmpqbRqzHypqZTpzWcZXEaJADa2tme+6ZTMKT1iKC/prhi1tEBU1qqI5+fp5Thprgt
7CYO7R2m5TpZMcgiOuk/P6eU4aa4s4U8J7umpu+6uuem3enNNCUZ+6aDQlznpt2V9CiCMeGm
cdkODIjRJU+QAUThprgtIfumphGMzLdUo95+Fjamj1FBW6amDuxyibICpqZxdGFEpqblOlkx
aeem3ZXfWnn7plOnNZxlcRofFxcXk6imqT6mpqZp1xeXQObnpgFk6I2mpnF+1nczwM+UBcoN
7ZgMzhMfZAZOKCQ/+a8KKAbGliS1IT8Iv09xGwKm++GmfCc8osE9WlvVugWDk83WdMQmbZdC
YzS+1zhmTAsD5qamYNfsfTSrKXAB9rraChDI7t8yzK1k8tXwpNxvvS+mqaamcXdO3UO0TZO2
ExdIXfa66QAo8CgCpqaJdC6Jx4J5gHnIg+jRYTUnEr+c5GSq+XO/nfgzHiCdOuyazzr4u534
apyc+lVMpBMX0dU2pnB32PTXgnjlARF+/FFBB25733JxSswDG99yaE3xzdKDyQKmpjamfJDI
PLNNoetAvkhY38O8Y+zanLOnYdPhpqYniKv98Ozb6LLHVegyIScloDjiBXYfgXpdU1TsyJTh
pqagTz1ltBF3FKsFfXfpACit0acbkQIvpqky8EQ2pqZ3ZSHfqyr0Lv2LRS5Md07IhuDe5ivn
pt0rQCkaL6ap8Wv0wEjozU2yCQV3ld9aebu58tXwsi2BLd5qoEXyTFYuhcLmpqam4aa4f7Qz
wH532PTXgnjCu7oAIHn8UUEH2C/KRi+m3dtb6FnV/4DvHwy2YIPaTA2PNGREpqbKpqamYv1t
bWO9781MEroF9ew3pqampqaP6KCU9KERDLr7YNfstHrH7wtJ65dgzVXPK2PR/EKFsL5tYGEr
EpyU4aamplM+eelRtoMlK6nMAxvfcmiFtPqgwswSeE9cJm0jHJveuQYyUAFQGUNTVOx8JRmt
umPrVtU2pqamuF6DGBryEQy6+2DX7LR6x+8LSeuXYM1Vzytj0fxChbC+bT1ZRM1MK+empqaP
6KCU9AwRDLr7YNfstHrH7wtJ65dgzVXPK2PR/EKFsL5tsTWcNRKcx0GUpqampqamqaampqZ+
AVDCLQKmpn4BuBmxAqampjampsqmpqb74aa4LSE4juTw4oPZCJOopqkTwPxWYNfstHrHjPR5
MojWnd4JH4F6keQoC/+4GbHhpqZxIcKNnIZGGqY2pqZTVOx8nvlg6s1DtJUlRsyleEUnmnuW
NqamWeQzV7gfDLZgg9pMDVe79qZnpqamqafwlZUlRvcz4u07eZKHG6ampqapEyUrFBtrYnls
pqampqampozJLn5BvvczSCIKBg31xxNFTcGowe12H/B+OzPR1TampqampqaPUfc7NHaYEZHV
u7lxYtcGj9Q8gEyXyEURkfYNvzqfeWmnSRSTP5TwkKLvuv2QO+KDZdU256ampqaP6KCU9NwR
DLq9pqampqam3U2TthMXSBrtE3LlMGJVaOjR/EKFQpbGlR4O2Q7t2Z77pqampqampubnpqam
pqamZ6ampqampqbRh1tMOc1VQ3X8g2PRh1tMOc1MQciRAqampqampqZxNMtFdIOY2X+D6rHf
oLMrg/0TRTCk9Yigv60yoI0z1IsUeOvF+p77pqampqam56ampqampmempqampqam0YdbTDnN
VUNTWArosiZtsTWcNRKcT8FTVOx8JRmtumO7AZOopqampqampvumpqampqZTMKT1iKC/nIZp
DLdFMKT1iKC/rdGnG1+gv/8rKRKTK+empqampqbd6e+6Qq2fs4UrGVW+MKT1iKC/Aqb7pqam
pmiJYWYm04MlK+GmpqampqZ8Jzzbi1j93ruLA8WHDHjEJm0jHMAZ2VIt7CYO7dme+6ampqam
puempqampqZnpqampqampuu90acbX6C/8J8pErDQE/umpqYvpqampqampo8G2wdYfr52hife
9YglXZAUSUJJ+lItITga7cdh8prZMP0fDLZgg5hgmNLtX8StwXn/QhNOirnRrf1sv7/ip2Cc
qC4ZocDxv/F2Hwy2YIOYYJjS7VbVNqampqampqZTEZHVN9l/0asxl5iY/INjO9BFiagyLewm
Du3ZUlIGallhk0HIkQKmpqampqam2Ji/kASpbWBh01N2hlH3OzSYxw0h3jLNJTyATJfIRVTX
w1AZAULm8UPRpxtfoL//KykSkyumpqampqam4aampqampkuNOHs+RqampqampqamL6ampqbd
Lt7V05xQp2HTpqampqamqcwDG99yaFoSeE9cCKNFvi5Md07ITodKbbE1nDUSnJThpqampqam
uAh7fWURu9HGw7HRMgh7fWURu5tdVvqe+6ampqampllJGtGHW0w5zVWYrrcDNpOIcTTLRXSD
mL9PG8G9wmVTMKT1iKC/uyIuG73CZVMwpPWIoL+7Ii6DFIxieWympqampqampmyEtnnnIl+s
bt/fgy/PWmQGRxO+A60fwa3Rh1tMOc2kk/vhpqampqamS404ez4v4aampqampqamcSHCjZwL
H/B+Q1VMGKfwlZUeDtkO7dYTJSsUF72gYztaG73hpqampqampqampqampqamSPK6925JUKdh
Zt62+6ampqampqampqampqampjwqbx9k1tHWM8u6iMLmpqampqY8Km/7pqampqam8kAbgy/P
BESteX6gqM7Ih5VYeMcXx/nBbl3NXbn/lSVG9zPi7Tt5koefv5w0kMiUymempqa0lw4BC5n7
4aamuohu/jKopqYvpqYEKvZRTif1tug7jTJ51bdFTW7qlxMFdhcKCmFZTCHCjZP/jXnWNKFM
IcKNkyvnpt0rOcEQTOem3U2TthMXSBqQIH53TlDOyEVNwajVNqbKpqamNqbKpqbNCuiyx1Vg
jBstoCW0yEVU7MiGUcCHjSur/cLmpqam4aZNjMCHjSur/dHGU01u6mON1EDmpqYyw//VQ9di
cUpSzK1kiXjEROGmL6bdXH7YA0UNGzmq67it1JUlRsyleEUnmfumFojsFsHJg0qDyg0uTH7W
dzO50Tr8cp35+dkgne++mJgY8DIrxDzbjyDsmJhGJOQI+Ls/DPGU4d0r6C+mqaampqampqam
pqb74Wem56b7yqY2qaYvpuFnpuem+8qmNqmmTdaxPEfWRIwbUtPkVt9yccWmpqampvy0esem
pt0NdEWJ7mYfpqampqYyIScloDjiuqbiAVBjdB8E2vfHsQnXkNlEpqampqZnpHlj7S2mprFl
fQlAmV+Qhb72oUjoXPGZpqampql7xcGNzLbdcrqJThhZpln9+6ZTTW7qY43UOaZDNFEvpqlt
l0JjNL5EpkM0US+mqW2XQgF3NqZp/9We+6ZTtDkmYqamsWV9CUBt0gaKilbVNqbKpont7Cvh
pqampqamL6apbXnIg4dKZOD9GmG/v/pOKCRKLJ3k5OvOlZoQwFiO4TamuAEFEXfbhSvUoaUD
tHrHGuGmpqamqXvfcnam3c4+Mn5BvnGmpqampmmAjBsu/YtFAghe/BF3Gt5qccS+pqampqYO
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
WQo67ANjhXlfMrhQVZqampqampq/p2bEfzyvNb+aJrAhW6ampsgFIWQmd4HpP1dd39f2xTIQ
9yDEubGdEPhhBVumpqYJh16mpqamvi5O7PJMD10HhEjrNOgJsR86nx4Zc+gQ+ZJVEy6xMsS6
SAvYas08MlVMsXO5v534VWQ/gTrBTMTNM/umpqkh0OiGIqam+6bnpqbd2V7sMr5ert7Lpmem
pqZweyMYQqsLLmKW0OsvThvEfzw4HsZPU+qu3sumpqZwe0WghglAdwk+y0EmsCGZpqampr7w
Lcscy4v2//impqamCYe3pqamplDGwmHDlwmfbNz2JyaJY34cBUKIZK1VQp+qScR/PO7cTIO4
GAGCebtdn6vZSFSbdnLeTrfNkAwKLU+GrTG5HaamplpOEXu5Haampt4cLsYQpqamysTeh14m
Hm3kuIV57LHD/JJmmkgN20LXLeinnMbe40K3BQQeS1VbpsqmpqaWrt48kNqBiYsvpqamhc1u
/9l86ihbvpDrQoiL/FtBzR2mL6ampuempqZZgK5/rgvYJtexx0+XG8R/PDgexk9T6q7ey6am
pnB7RaCGCUB3CT7LQSawIZmmpqamvoFCiD97/pVqr3MipqamqYmxFKampqbSLdhijcKJTPTr
7INu8pOXiy2QnAjs65BIhyf9pwklaQWtkJzxSlWQaNRUB9oy3mo+p9eg7bcF3laYOPrHerDX
rmG/0TvUP0rBkZgopqamyteMKVMfpqamWkIu4aampoU7ctml676WHMv8JYsevq4BgiRDLmLr
QrcFBB5L7ZiaSP77pqapIdDohhz7pqappqbOteWYE4cxjR40hlgZko6dMbnco/34ftVauHvt
N2a+RROf94pekbsDu00v2WVw3ZYd3sivOko6nnjCIMpavLEtAso5IbjAATEj9IoW40lY8TYY
Nm8YCqXksU6myvumpnxBjTyNY7Xtvgr5am1JBSqLNqamptQDDG3E+YNFwvV5GN5/4osSPmH2
R9OmpqZn3hCTRaggMfi3BwcL4aampsw8yKampqbyHtklskLZGU9x4PZeWQza0MxATOGmpqam
prj2Xuqny26HcaM0gbE8jWP2XlnZqPumpqamplMN4lZzu9dMQ9JRoOJWc7vXTAAUpqampqam
xGE8Ios/iBUplTs7DdC+D0BXFKampqampsRhQ+LbbrC4I1L2urmLepWo+6ampqamUw0+6AH4
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
/
 show err;
 
PROMPT *** Create  grants  BARS_DBF ***
grant EXECUTE                                                                on BARS_DBF        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_DBF        to IMPEXP;
grant EXECUTE                                                                on BARS_DBF        to OBPC;
grant EXECUTE                                                                on BARS_DBF        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_dbf.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 