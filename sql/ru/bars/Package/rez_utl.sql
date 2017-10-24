
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/rez_utl.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.REZ_UTL AS
/******************************************************************************
   NAME:       rez_utl
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        07.04.2009             1. Created this package.
******************************************************************************/
  -- по клиентскому счету возвращает счет резерфного фонда
  FUNCTION f_get_fond(p_s080 number,
                                   p_custtype number,
                                   p_idr number,
                                   p_specrez number ,
                                   p_rz varchar2
                                   ) RETURN varchar2 deterministic;

END rez_utl;
/
CREATE OR REPLACE PACKAGE BODY BARS.REZ_UTL AS
/******************************************************************************
   NAME:       rez_utl
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        07.04.2009             1. Created this package body.
******************************************************************************/

  FUNCTION  f_get_fond(p_s080 number,
                           p_custtype number,
                           p_idr number,
                           p_specrez number,
                           p_rz varchar2
                           ) RETURN varchar2
  deterministic
  is
  r varchar2(20);
  BEGIN
    --для сбербанка
    if GetGlobalOption('OB22') = 1 then
       null;
    else
      select decode(p_rz,'2',nvl(s_fondnr, s_fond), s_fond)
      into r
      from srezerv r
      where r.s080=p_s080
        AND r.custtype=p_custtype
        AND r.id=p_idr
        and r.SPECREZ = p_specrez;
    end if;
    return r;
  END;



END rez_utl;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/rez_utl.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 