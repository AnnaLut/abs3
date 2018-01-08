

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CP_SHEDULER.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CP_SHEDULER ***

CREATE OR REPLACE PROCEDURE cp_sheduler (p_mode      IN INT,
                                         p_id        IN cp_kod.id%TYPE,
                                         p_npp       IN cp_dat.npp%TYPE,
                                         p_dok       IN DATE,
                                         p_dnk       IN DATE,
                                         p_kup       IN NUMBER,
                                         p_nom       IN NUMBER,
                                         p_ir        IN NUMBER,
                                         p_expdate   IN DATE)
IS
 title constant varchar2(12) := 'cp_sheduler:';
BEGIN
   /*bars_audit.info(title||' start with params: exec cp_sheduler(p_mode=>'||to_char(p_mode)||', p_id=>'||to_char(p_id)
                        ||',p_npp=>'||to_char(p_npp)||',p_dok=>date'''||to_char(p_dok,'yyyy-mm-dd')||''',p_dnk=>date'''||to_char(p_dnk,'yyyy-mm-dd')
                        ||',p_kup=>'||to_char(p_kup)||',p_nom=>'||to_char(p_nom)||',p_ir='||to_char(p_ir)||',p_expdate=>date'''||to_char(p_expdate,'yyyy-mm-dd')||'''');
   */                     
   IF p_mode = 1                                                     -- insert
   THEN
      BEGIN
         INSERT INTO cp_dat (id,
                             npp,
                             dok,
                             kup,
                             nom,
                             expiry_date,
                             ir)
              VALUES (p_id,
                      p_npp,
                      p_dok,
                      p_kup,
                      p_nom,
                      p_expdate,
                      p_ir);
      EXCEPTION
         WHEN DUP_VAL_ON_INDEX
         THEN
            RAISE;
      END;
   ELSIF p_mode = 2                                                   --update
   THEN
      UPDATE cp_dat
         SET dok = case when p_dok is not null then p_dnk else dok end,
             kup = nvl(p_kup, kup),
             nom = nvl(p_nom, nom),
             expiry_date = nvl(p_expdate, expiry_date),
             ir = nvl(p_ir, ir)
       WHERE id = p_id AND npp = p_npp;
       
   ELSIF p_mode = 3                                                 --deleting
   THEN
      DELETE cp_dat
       WHERE id = p_id AND npp = p_npp;
   ELSE
      NULL;
   END IF;
END;
/
show err;

PROMPT *** Create  grants  CP_SHEDULER ***
grant EXECUTE                                                                on CP_SHEDULER     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CP_SHEDULER.sql =========*** End *
PROMPT ===================================================================================== 
