

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SKRYNKA_PORT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SKRYNKA_PORT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SKRYNKA_PORT ("N_SK", "SNUM", "O_SK", "NAME", "KEYUSED", "KEYNUMBER", "KEYCOUNT", "S", "KV", "ACC", "NLS_2909", "OSTC", "OSTB", "MDATE", "ND", "NDOC", "SOS", "TARIFF", "NLS_3600", "FIO", "CUSTTYPE", "OKPO1", "DOKUM", "ISSUED", "ADRES", "DATR", "MR", "TEL", "DOCDATE", "DAT_BEGIN", "DAT_END", "DAT_CLOSE", "S_ARENDA", "S_NDS", "SD", "PRSKIDKA", "PENY", "BRANCH") AS 
  SELECT "N_SK",
          "SNUM",
          "O_SK",
          "NAME",
          "KEYUSED",
          "KEYNUMBER",
          "KEYCOUNT",
           s/100 "S",
          "KV",
          "ACC",
          "NLS_2909",
           OSTC/100 "OSTC",
          "OSTB",
          "MDATE",
          "ND",
          "NDOC",
          "SOS",
          "TARIFF",
          "NLS_3600",
          "FIO",
          "CUSTTYPE",
          "OKPO1",
          "DOKUM",
          "ISSUED",
          "ADRES",
          "DATR",
          "MR",
          "TEL",
          "DOCDATE",
          "DAT_BEGIN",
          "DAT_END",
          "DAT_CLOSE",
          "S_ARENDA",
          "S_NDS",
          "SD",
          "PRSKIDKA",
          "PENY",
          "BRANCH"
     FROM TABLE (t_skrynka.f_SKRYNKA_PORT);

PROMPT *** Create  grants  V_SKRYNKA_PORT ***
grant SELECT                                                                 on V_SKRYNKA_PORT  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SKRYNKA_PORT.sql =========*** End ***
PROMPT ===================================================================================== 
