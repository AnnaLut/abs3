

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/DE_SAL.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure DE_SAL ***

  CREATE OR REPLACE PROCEDURE BARS.DE_SAL (
  acc_ NUMBER,
  dat_ DATE,
  s_   DECIMAL,
  sq_  DECIMAL)
IS
--***************************************************************--
--                     Обратное сальдирование
--                    Version 5.02 (11/07/2011)
--                     Казначейство, КомБанки
--                     с поддержкой мульти-МФО (Ощадбанк)
--***************************************************************--
  dos_  DECIMAL(24);
  kos_  DECIMAL(24);
  pdat_ DATE;

BEGIN
  UPDATE saldoa
     SET dos = dos - s_,
         kos = kos - s_
   WHERE acc = acc_
     AND fdat = dat_;

  if sql%rowcount = 0 then
    return; --якщо жодного рядку не оновлено, виходимо з процедури, щоб не отримати no_data_found при наступному селекті.
  end if;

  SELECT dos, kos
    INTO dos_, kos_
    FROM saldoa
   WHERE acc = acc_
     AND fdat = dat_;

  IF dos_ = 0 AND kos_ = 0 THEN
    BEGIN
      SELECT MAX(fdat)
        INTO pdat_
        FROM saldoa
       WHERE acc = acc_
         AND fdat < dat_;

    EXCEPTION
      WHEN NO_DATA_FOUND THEN pdat_ := NULL;
    END;

    UPDATE saldoa
       SET pdat = pdat_
     WHERE acc = acc_
       AND fdat = (SELECT MIN(fdat)
                     FROM saldoa
                    WHERE acc = acc_
                      AND fdat > dat_);

    DELETE FROM saldoa
     WHERE acc = acc_
       AND fdat = dat_
       AND pdat is not null;
  END IF;
END de_sal;
/
show err;

PROMPT *** Create  grants  DE_SAL ***
grant EXECUTE                                                                on DE_SAL          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DE_SAL          to ABS_ADMIN;
grant EXECUTE                                                                on DE_SAL          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/DE_SAL.sql =========*** End *** ==
PROMPT ===================================================================================== 
