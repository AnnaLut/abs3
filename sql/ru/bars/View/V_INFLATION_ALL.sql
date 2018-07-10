CREATE OR REPLACE FORCE VIEW BARS.V_INFLATION_ALL
(
   T,
   P,
   K
)
AS
   SELECT '╡мткъж╡им╡ брпюрх р╡кн' AS T,
          '╡мткъж╡им╡ брпюрх опнжемрх' AS P,
          '╡мткъж╡им╡ брпюрх йнл╡я╡ъ' AS K
     FROM DUAL;


GRANT SELECT ON BARS.V_INFLATION_ALL TO BARS_ACCESS_DEFROLE;