

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CC_INS_PARTNERS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CC_INS_PARTNERS ***

  CREATE OR REPLACE PROCEDURE BARS.CC_INS_PARTNERS (p_nd number,
                                            P_nBANK      number default null,        P_NLS         varchar2 default null,  P_NAM_B varchar2 default null, P_ID_B varchar2 default null,
                                            P_nBANK2      number default null,        P_NLS2         varchar2 default null,  P_NAM_B2 varchar2 default null, P_ID_B2 varchar2 default null,
                                            P_nBANK3      number default null,        P_NLS3         varchar2 default null,  P_NAM_B3 varchar2 default null, P_ID_B3 varchar2 default null,
                                            P_nBANK4      number default null,        P_NLS4         varchar2 default null,  P_NAM_B4 varchar2 default null, P_ID_B4 varchar2 default null,
                                            P_nBANK5      number default null,        P_NLS5         varchar2 default null,  P_NAM_B5 varchar2 default null, P_ID_B5 varchar2 default null,
                                            P_CREDIT_ORDER varchar2 default null)
                                            is
BEGIN
  -- Смешались и кони и люди, с целью не плодить процедуры, установка параметра номера Кред.Фабрики будет устанавливатся при вызове процедуры записи платежных инструкций
     pul.set_mas_ini('ND',p_nd,'XXX');

     if P_nBANK is not null and  P_NLS is not null   then
      insert into CCK_PL_INS (ND, MFOB, NLSB, NAM_B, ID_B )  values (p_nd, P_nBANK, P_NLS, P_NAM_B, P_ID_B);
     end if;

     if P_nBANK2 is not null and  P_NLS2 is not null   then
      insert into CCK_PL_INS (ND, MFOB, NLSB, NAM_B, ID_B )  values (p_nd, P_nBANK2, P_NLS2, P_NAM_B2, P_ID_B2);
     end if;

     if P_nBANK3 is not null and  P_NLS3 is not null   then
      insert into CCK_PL_INS (ND, MFOB, NLSB, NAM_B, ID_B )  values (p_nd, P_nBANK3, P_NLS3, P_NAM_B3, P_ID_B3);
     end if;

     if P_nBANK4 is not null and  P_NLS4 is not null   then
      insert into CCK_PL_INS (ND, MFOB, NLSB, NAM_B, ID_B )  values (p_nd, P_nBANK4, P_NLS4,  P_NAM_B4, P_ID_B4);
     end if;

     if P_nBANK5 is not null and  P_NLS5 is not null   then
      insert into CCK_PL_INS (ND, MFOB, NLSB, NAM_B, ID_B )  values (p_nd, P_nBANK5, P_NLS5,  P_NAM_B5, P_ID_B5);
     end if;

     if P_CREDIT_ORDER is not null  then
     CCK_APP.SET_ND_TXT(p_nd,'NUMKF',P_CREDIT_ORDER);
     end if;

END;
/
show err;

PROMPT *** Create  grants  CC_INS_PARTNERS ***
grant EXECUTE                                                                on CC_INS_PARTNERS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CC_INS_PARTNERS.sql =========*** E
PROMPT ===================================================================================== 
