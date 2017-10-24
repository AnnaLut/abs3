

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/MC_KWT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure MC_KWT ***

  CREATE OR REPLACE PROCEDURE BARS.MC_KWT (
	fn_		VARCHAR2,
	dat_  	DATE,
	datk_  	DATE
) IS

ern               CONSTANT POSITIVE := 103;
erm               VARCHAR2(256);   -- максимальная длина 2048
err               EXCEPTION;

fn_i	VARCHAR(12);

BEGIN
	fn_i := NULL;
	-- проверим, может файл уже сквитован
	BEGIN
  	  SELECT fn INTO fn_i FROM zag_mc
		WHERE fn2=fn_ AND TRUNC(dat2)=TRUNC(dat_)
			  AND otm >= 5 -- то есть заквитован квитанцией или автоматом(9)
			  AND datk IS NOT NULL;
	  IF fn_i IS NOT NULL THEN	-- если да
		-- выбросим исключение "повторная обработка квитанции"
		erm := '0701 - Duplicate receipt on file '||fn_;
      	RAISE err;
	  END IF;
	EXCEPTION WHEN NO_DATA_FOUND THEN
	  fn_i := NULL;
	END;

	BEGIN
	  UPDATE zag_mc SET otm=5, datk=datk_
		WHERE fn2=fn_ AND TRUNC(dat2)=TRUNC(dat_)
			  AND otm=3;
	EXCEPTION WHEN NO_DATA_FOUND THEN
	  -- квитанция на файл, который не отправлялся
	  erm := '1103 - Receipt for unissued file!';
	  RAISE err;
	END;
EXCEPTION
  WHEN err THEN
     raise_application_error(-(20000+ern),'\'||erm,TRUE);
  WHEN OTHERS THEN
     raise_application_error(-(20000+ern),SQLERRM,TRUE);
END mc_kwt;
/
show err;

PROMPT *** Create  grants  MC_KWT ***
grant EXECUTE                                                                on MC_KWT          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on MC_KWT          to TOSS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/MC_KWT.sql =========*** End *** ==
PROMPT ===================================================================================== 
