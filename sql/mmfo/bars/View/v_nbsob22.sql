CREATE OR REPLACE VIEW V_NBSOB22(  KOD,   NAME,   D_CLOSE,   R020,   OB22) as
                  SELECT  R020 || ob22,   txt,    d_close,   R020,   ob22  FROM sb_ob22    
                  WHERE d_close IS NULL and R020 like PUl.Get('R020') ||'%'  ;

