
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_s3800.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_S3800 (nlsa_ accounts.nls%type, kva_ accounts.kv%type)
RETURN accounts.nls%type IS
 s3800_    accounts.nls%type;
BEGIN
-- Макаренко И.В. 01/06/2013
-- по просьбе Безродной изменил условие выбора счета ВП
--    IF nlsa_ in ('27087201','27065201') THEN
    IF substr(nlsa_,1,2) = '27' THEN
      s3800_ := '380030301';
    ELSE
      s3800_ := '3800203';
    END IF;
    RETURN s3800_;
END f_get_s3800;
/
 show err;
 
PROMPT *** Create  grants  F_GET_S3800 ***
grant EXECUTE                                                                on F_GET_S3800     to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_s3800.sql =========*** End **
 PROMPT ===================================================================================== 
 