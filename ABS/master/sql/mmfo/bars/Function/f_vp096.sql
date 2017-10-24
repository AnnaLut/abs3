
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_vp096.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_VP096 (p_REF number)  RETURN varchar2 IS
   VP_   varchar2(15);
   NLSA_ char(2);
   NLSB_ char(2);
BEGIN

   VP_ := '';

   SELECT substr(nlsa,1,2),substr(nlsb,1,2)
   INTO NLSA_,NLSB_ FROM oper WHERE ref=P_REF;

   IF NLSA_ = '77' or NLSB_ = '77' THEN
     VP_:='3800304';
   ELSE
     IF substr(NLSA_,1,1) in ('6','7') or
        substr(NLSB_,1,1) in ('6','7') THEN VP_:='3800203';
     ELSE
       VP_:='3800102';
     END IF;
   END IF;

   RETURN VP_;

END f_vp096;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_vp096.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 