BEGIN
   FOR k IN (SELECT * FROM mv_kf)
   LOOP
      bc.go (k.kf);
      FOR s IN (SELECT a.acc, d.wdate
                  FROM cc_deal d, accounts a, nd_acc n
                 WHERE     a.tip = 'LIM'
                       AND a.acc = n.acc
                       AND n.nd = d.nd
                       AND a.mdate IS NULL
                       AND d.sos < 14
                       AND d.vidd IN (1,
                                      2,
                                      3,
                                      11,
                                      12,
                                      13)
                       AND dazs IS NULL)
      LOOP
         UPDATE accounts
            SET mdate = s.wdate
          WHERE acc = s.acc;
      END LOOP; -- s
   END LOOP; --k
bc.home;
END;
/

commit;