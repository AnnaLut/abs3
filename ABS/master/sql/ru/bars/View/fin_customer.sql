

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/FIN_CUSTOMER.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view FIN_CUSTOMER ***

  CREATE OR REPLACE FORCE VIEW BARS.FIN_CUSTOMER ("RNK", "NMK", "OKPO", "CUSTTYPE", "BRANCH", "RNKP", "VED", "DATE_OFF", "CRISK", "DATEA", "ADR", "MB", "BC", "PRINSIDER", "CODCAGENT", "K050") AS 
  SELECT -okpo AS rnk,
          upper(nmk) nmk,
          okpo,
          custtype,
          branch,
          isp AS rnkp,
          ved,
          NULL AS date_off,
          NULL AS crisk,
          datea,
          NULL adr,
          NULL mb,
          NULL bc,
          NULL prinsider,
          NULL codcagent,
          NULL k050
     FROM fin_cust
   UNION ALL
   SELECT rnk,
          upper(nmk) nmk,
          okpo,
          custtype,
          branch,
          rnkp,
          ved,
          date_off,
          null as crisk,
          datea,
          adr,
          mb,
          bc,
          prinsider,
          codcagent,
          k050
     FROM customer;

PROMPT *** Create  grants  FIN_CUSTOMER ***
grant DELETE,SELECT,UPDATE                                                   on FIN_CUSTOMER    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/FIN_CUSTOMER.sql =========*** End *** =
PROMPT ===================================================================================== 
