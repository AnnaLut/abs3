DECLARE
l_prod varchar2(6);
FUNCTION get_prod_new (p_prod varchar2)
      RETURN VARCHAR2
   IS
  l_prod_new varchar2(6);
   BEGIN
        l_prod_new := p_prod;
        begin
        SELECT r020_new||ob_new
              INTO l_prod_new
              FROM TRANSFER_2017
             WHERE r020_old||ob_old = p_prod and r020_old <> r020_new;
         exception when others then
          return l_prod_new;
        end;
      RETURN l_prod_new;
   END;
BEGIN
 for k in (select kf from mv_kf)
 loop
 bc.go(k.kf);
   FOR dd IN (SELECT *
                FROM cc_deal
               WHERE     vidd IN (1,
                                  2,
                                  3,
                                  11,
                                  12,
                                  13)
                     AND sos >= 10
                     AND sos <= 13
                     AND EXISTS
                            (SELECT 1
                               FROM cck_ob22
                              WHERE nbs || OB22 = SUBSTR (prod, 1, 6) 
                                    and d_close is not null))
   LOOP
      l_prod := get_prod_new (SUBSTR (dd.prod, 1, 6));
      bars_audit.info (
            'cc_deal get prod = '
         || l_prod
         || ' ND = '
         || dd.nd
         || ' old_prod = '
         || dd.prod);

      IF l_prod <> dd.prod
      THEN
         bars_audit.info (
               'update cc_deal set  prod = '
            || l_prod
            || ' where ND = '
            || dd.nd
            || ' ; old_prod = '
            || dd.prod);

         UPDATE cc_deal d
            SET d.prod = l_prod
          WHERE d.nd = dd.nd;
      END IF;
   END LOOP; -- dd
end loop; -- k
 bc.home;
END;
/

commit;