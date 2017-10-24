
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/web_utl_adm.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.WEB_UTL_ADM 
is
-------------------------------------------------------------------
--
-------------------------------------------------------------------
G_HEADER_VERSION   constant varchar2(64)  := 'version 1.1 24.01.2008';
G_AWK_HEADER_DEFS  constant varchar2(512) := '';
-------------------------------------------------------------------
--
-------------------------------------------------------------------
procedure create_webuser(
  webuser_  web_usermap.webuser%type,
  dbuser_   web_usermap.dbuser%type,
  errmode_  web_usermap.errmode%type default 0,
    webpass_  web_usermap.webpass%type,
    adminpass_  web_usermap.adminpass%type default null,
  comm_   web_usermap.comm%type default null
);

procedure change_pass(
  webuser_  web_usermap.webuser%type,
    webpass_  web_usermap.webpass%type,
    adminpass_  web_usermap.adminpass%type default null
);

procedure drop_webuser(
  webuser_  web_usermap.webuser%type
);

procedure edit_webuser(
  webuser_  web_usermap.webuser%type,
  blocked_    web_usermap.blocked%type,
  errmode_  web_usermap.errmode%type default null,
  comm_   web_usermap.comm%type default null
);

procedure set_webuser(
  webuser_  web_usermap.webuser%type,
  dbuser_   web_usermap.dbuser%type,
    webpass_  web_usermap.webpass%type,
  blocked_    web_usermap.blocked%type,
  errmode_  web_usermap.errmode%type default 0,
    adminpass_  web_usermap.adminpass%type default null,
  comm_   web_usermap.comm%type default null
);

procedure set_configparam (
    type_name_  web_barsconfig_grouptypes.TYPE_NAME%type,
    key_    web_barsconfig.KEY%type,
    val_    web_barsconfig.VAL%type,
    comm_     web_barsconfig.COMM%type default null ,
    csharptype_ web_barsconfig.CSHARPTYPE%type default null
);
--------------------------------------------------------
-- HEADER_VERSION()
--
--     Функция возвращает строку с версией заголовка пакета
--
function header_version return varchar2;

--------------------------------------------------------
-- BODY_VERSION()
--
--     Функция возвращает строку с версией тела пакета
--
function body_version return varchar2;
-------------------------------------------------------------------
--
-------------------------------------------------------------------
end web_utl_adm;
 
/
CREATE OR REPLACE PACKAGE BODY BARS.WEB_UTL_ADM wrapped
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
1350 714
eDX6w0nCy1B2CctG2gRgo0LJYUcwg+1UBUiGw45DPToY11rvxvH08cD3ySVKXYNJ9D3b37yg
0vr8UKaUUErogsoa5D3k+5Y0FSxGJeUB8oQ+5k6sIYrHgS2GoNdNbOWr9k8QTBeaBoVSeG4i
N4FQBUC7xq5OnJa8+r+fnXnOoR0kc24cXRMU3OR8pqZ4dPF3vQm09eC/j9vV164iwqYcZDc6
Vc467hmvIvWj1VBCdyckJzug2izsTMMGfnm46RwpbDLyIrnYVFm9woZJGIScMJNZ3fD0t/HP
bdgXvfQTsqYIdQOwbiJKbk1sTSjrzeO0qX5BXcUtQqsfZfdXHAIcJn3Tw9REfS23sl4RXj/U
H62hZSCQCY2Hpsb9OjWysFGcDVsxuFpEVbgh5ZJZ3k5oprJthyV7Kfj78pL7wrDOjUBF9V6m
C5lnfogDYoQtmQ95ySy1KJIcUUhqknz1eOMHVt7yYMzsVBHe64jJFPcYxyaILKzXOF7mJ8Ri
AWaxfl1o5z9sBb3EJdQkCgyWeVX0t2j6eiR5OjWWfuydcaTX0a7RycPrW2QXnBeqTHMQIRCC
RMdl98tZGxshvij2KMi5Ppsd2aBFstMwjSHmukMU/Vc1T1137Wxlioe3a8++k6L3JQH3dcjD
I6b2MmnvDUtZhqvIdYV9U+dtAxyST/kwMjX3tccjrdq1H0pymhUyxMo30Q7YUYqVOKBxqJw1
pYXIyuftV3ZcyFQEBISq0cIsckqwwXgUjeeA/r4lWOfFccKWzHVC6UNpPsA1qpz/oM+7TfVK
h+6NT2cvGDm3y1rdpm5yIqcS5ucIKwZtlhVQO9gydcARBDJCeHOBzzMjnyHtCKxNIJF1iSHE
vsnDcQrkwTEpYg39stYbqZqMnxhJIejiyYhLRi/gUdtk2YPxNT8t2VSM0033mRnUy3M8tkXx
Hk1OvGCleZh9AI7c+KocPWpxYR7pN5/3sBGabZBrz8LkbzezXET/nbKr9qwAdy5tvtxJYWgd
WXG1Qc12HOxvsB/2N/SZ7hkiJGpFZXRhARYffmn3Mey1dHGMg+JkE+Y5yHJx02P1PWhRAXZG
rYvEt/4VdLaJXN9Ew4k/j/ThzEHYIszeZqtff5rh3EqwnTivD3E07TgKS2tXjIDity+5nKBm
/VhC5ew8MbvJAoCgFE7CfQCJvVXGHBsTX6/m4TxJlOwKrsN5aKFXsGP3+bwmMYBVFWFFnT1J
owFoJnMKt6rRh+01jvx63gSxYnpBWf2+9ZvDdR7iYzxRZIBD8ZY7WuRZu5BuZSR9SLStMCsb
T8ss1O6nbb4TZoSYfYO/vgqZnFbozuIrx4hJmpe7F5Z4xYaAE38q61uqZTPkP13b/+fsR0mD
hpvdiPorrhBdcUIkywPjQUlilWOybrLCO9RaqD3mwtRGaTx/qJML8YJwSjs/L+drNqqbZf6b
rX8yoBHetlL4GSp/+D37ykUini2Jt6vD9uJc72Vx++M+cWfRwnHV6+YHTcNjoZ6SQeZvoY6a
Ca+zdEMpgLW6XNgRoW/dJuHbDGq2I4y7CTAC61CipJ/uoC6kw50HjTiZoHsLZVRiZXsct9io
17oKurceo2ADzyAhI5OPwjF4ykoHjWaaRdsU1wZn7Vazv7/IB4sDkHKdGTrAdA/wv5/GckK6
oZN4W7Ybtn3BlDtax1tSA+thpfeuLPkm5YOkqi3Enf7gu3CdQhEA39ms3Q+551XSgcvQS35Z
NlSiVCMKoMPPriifqk1t4hoIi7R17AWi6Ie6CFP1ggSUbN7/9Zr4KGtFsJ8=
/
 show err;
 
PROMPT *** Create  grants  WEB_UTL_ADM ***
grant EXECUTE                                                                on WEB_UTL_ADM     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on WEB_UTL_ADM     to WR_ADMIN;
grant EXECUTE                                                                on WEB_UTL_ADM     to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/web_utl_adm.sql =========*** End ***
 PROMPT ===================================================================================== 
 