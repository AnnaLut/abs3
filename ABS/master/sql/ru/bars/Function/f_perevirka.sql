
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_perevirka.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_PEREVIRKA (
   fkodf_    IN   VARCHAR2,
   kodf_     IN   VARCHAR2,
   dat_      IN   DATE,
   userid_        NUMBER
)
   RETURN NUMBER
IS
------------------------------------------------------------------------------------
--- Функція перевірки наявності сформованого файлу (власного та консолідованого) ---
--- перед розрахунком регулятивного капіталу                                     ---
------------------------------------------------------------------------------------
--- Версія від 28.11.2006                                                ---
------------------------------------------------------------------------------------
   count_     NUMBER;
   our_mfo_   VARCHAR2 (12);
   sdat_      VARCHAR2 (8)  := TO_CHAR (dat_, 'ddmmyyyy');
BEGIN
   our_mfo_ := TO_CHAR (f_ourmfo ());

-----------------------------------------------------------
   SELECT COUNT (*)
     INTO count_
     FROM tmp_nbu
    WHERE datf = dat_ AND kodf = kodf_;

   IF count_ = 0
   THEN
      INSERT INTO otcn_log
                  (txt,
                   kodf, userid
                  )
           VALUES (   '---- !!!!!!!!! ----  Не сформовано власний файл #'
                   || kodf_
                   || '---- !!!!!!!!! ----',
                   fkodf_, userid_
                  );
   END IF;

-----------------------------------------------------------
   SELECT COUNT (*)
     INTO count_
     FROM banks
    WHERE mfou = our_mfo_
      AND mfou <> mfop
	  AND BLK <> 4
      AND mfo NOT IN (
             SELECT mfo
               FROM rnbu_in_files
              WHERE last_date = sdat_
                AND SUBSTR (TRIM (file_name), 2, 2) = kodf_);

   IF count_ > 0
   THEN
      INSERT INTO otcn_log
                  (txt,
                   kodf, userid
                  )
           VALUES (   '---- !!!!!!!!! ----  Не заімпортовано файли від філій по #'
                   || kodf_
                   || ':',
                   fkodf_, userid_
                  );

      INSERT INTO otcn_log
                  (txt, kodf, userid)
         SELECT mfo || ' ' || TRIM (nb), fkodf_, userid_
           FROM banks
          WHERE mfou = our_mfo_
            AND mfou <> mfop
	  		AND BLK <> 4
            AND mfo NOT IN (
                   SELECT mfo
                     FROM rnbu_in_files
                    WHERE last_date = sdat_
                      AND SUBSTR (TRIM (file_name), 2, 2) = kodf_);

      RETURN count_;
   END IF;

   RETURN 0;
END;
/
 show err;
 
PROMPT *** Create  grants  F_PEREVIRKA ***
grant EXECUTE                                                                on F_PEREVIRKA     to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_perevirka.sql =========*** End **
 PROMPT ===================================================================================== 
 