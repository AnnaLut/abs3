

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/IN_SEP_ADD.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure IN_SEP_ADD ***

  CREATE OR REPLACE PROCEDURE BARS.IN_SEP_ADD (
			rec_ 					NUMBER,			-- Номер строки в arc_rrp
	   	fa_name_  		VARCHAR2,   -- 25 Имя                    файла  A
  		fa_ln_   			NUMBER,     -- 26 Порядковый номер ИС  в файле  A
		  fa_t_arm3_   	VARCHAR2,   -- 27 Время прохождения через АРМ-3 A
		  fa_t_arm2_   	VARCHAR2,   -- 28 Время получения       в АРМ-2 A
			fc_name_ 			VARCHAR2,   -- 29 Имя                    файла  C
		  fc_ln_   			NUMBER,     -- 30 Порядковый номер ИС  в файле  C
		  fc_t1_arm2_  	VARCHAR2,   -- 31 Время формирования    в АРМ-2 C
		  fc_t2_arm2_  	VARCHAR2,   -- 32 Время получения       в АРМ-2 C
			fb_name_ 			VARCHAR2,   -- 33 Имя                    файла  B
		  fb_ln_   			NUMBER,     -- 34 Порядковый номер ИС  в файле  B
		  fb_t_arm2_   	VARCHAR2,   -- 35 Время формирования    в АРМ-2 B
		  fb_t_arm3_   	VARCHAR2,   -- 36 Время получения       в АРМ-3 B
		  fb_d_arm3_   	DATE        -- 37 Дата  получения       в АРМ-3 B
) IS
   ern     CONSTANT POSITIVE := 100;
   err     EXCEPTION;
   erm     VARCHAR2(80);

BEGIN

	UPDATE arc_rrp SET
	   	fa_name			=	fa_name_,
  		fa_ln 			= fa_ln_,
		  fa_t_arm3 	= fa_t_arm3_,
		  fa_t_arm2   = fa_t_arm2_,
			fc_name 		= fc_name_,
		  fc_ln    		= fc_ln_,
		  fc_t1_arm2 	= fc_t1_arm2_,
		  fc_t2_arm2	= fc_t2_arm2_,
			fb_name 		= fb_name_,
		  fb_ln 			= fb_ln_,
		  fb_t_arm2 	= fb_t_arm2_,
		  fb_t_arm3 	= fb_t_arm3_,
		  fb_d_arm3 	= fb_d_arm3_
  WHERE rec=rec_;

	IF SQL%ROWCOUNT = 0 THEN
      -- выбрасываем отрицательную(!) ошибку
      erm := '-1 - Document not found, rec='||rec_;
      RAISE err;
  END IF;

EXCEPTION
 WHEN err THEN
   raise_application_error(-(20000+ern),'\'||erm,TRUE);
 WHEN OTHERS THEN
   raise_application_error(-(20000+ern),SQLERRM,TRUE);
END in_sep_add;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/IN_SEP_ADD.sql =========*** End **
PROMPT ===================================================================================== 
