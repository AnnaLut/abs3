

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CC_GPK_SVK.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CC_GPK_SVK ***

  CREATE OR REPLACE PROCEDURE BARS.CC_GPK_SVK (p_nd number, p_fdat date := null) is
  /******************************************************************************
     NAME:       cc_gpk_svk
     PURPOSE:

     p_nd   - номер договора
     p_fdat - дата с которой считать ставку

     REVISIONS:
     Ver        Date        Author           Description
     ---------  ----------  ---------------  ------------------------------------
     1.0        03/06/2011   novikov       1. Created this procedure.

     NOTES:
   ADD income
  SV0K1    Разова комiсiя, %
  SV1RK    Розр-Кас.Обсл., %


   -- third person income
   SV2PW    Страх.застави, щорiчно, %
   SV3CV    Страх.життя, щорiчно, %
   SV4TI    Страх.титулу, щорiчно(3 р), %
   SV5GO    Страх.цив.вiдпов, грн
   SV6NO    Послуги нотарiуса, грн
   SV7RE    Послуги реєстрат., грн
   SV8MI    Державне мито, % вiд застави
   SV9PF    Пенсiйн.фонд, % вiд застави
   SV:BT    Послуги БТI(МРЕО), грн

  ******************************************************************************/

  l_Fdat     date;
  l_Irr_bank number;
  l_Irr_kl   number;

BEGIN
  -- cc_tag
  delete from tmp_gpk;
  delete from TMP_IRR;

  for k in (select rownum rn, l.*
              from (select l.fdat,
                           (case
                             when rownum = 1 then
                              -l.lim2
                             else
                              sumo
                           end) sumo,
                           l.lim2,
                           sumg as sumg,
                           (sumo - sumg) as sum_pr,
                           (case
                             when rownum = 1 then
                              cck_app.to_number2(cck_app.get_nd_txt(l.nd,
                                                                    'S_SDI'))
                             else
                              0
                           end) S_SDI,
                           (case
                             when rownum = 1 then
                              cck_app.to_number2(cck_app.get_nd_txt(l.nd,
                                                                    'SV7RE'))
                             else
                              0
                           end) SV7RE,
                           (case
                             when rownum = 1 then
                              cck_app.to_number2(cck_app.get_nd_txt(l.nd,
                                                                    'SV2PW'))
                             else
                              0
                           end) SV2PW,
                           (case
                             when rownum = 1 then
                              cck_app.to_number2(cck_app.get_nd_txt(l.nd,
                                                                    'SV6NO'))
                             else
                              0
                           end) SV6NO,
                           (case
                             when rownum = 1 then
                              cck_app.to_number2(cck_app.get_nd_txt(l.nd,
                                                                    'SV:BT'))
                             else
                              0
                           end) SVBT
                      from cc_lim l
                     where nd = p_nd
                       and (fdat >= p_fdat or p_fdat is null)
                     order by fdat) l) loop
    if k.rn = 1 then
      l_Fdat := k.fdat;
    end if;

    insert into tmp_gpk
      (fdat, sumo, sumg, lim2, SV0K1, SV7RE, SV2PW, SV6NO, SVBT)
    values
      (k.fdat,
       nvl(k.sumo, 0),
       nvl(k.sumg, 0),
       nvl(k.lim2, 0),
       nvl(k.S_SDI, 0),
       nvl(k.SV7RE, 0),
       nvl(k.SV2PW, 0),
       nvl(k.SV6NO, 0),
       nvl(k.SVBT, 0));

  end loop;

  insert into TMP_IRR
    (n, s)
    (select fdat - l_fdat, sumo + SV0K1 from tmp_gpk);
  select XIRR(1) * 100 into l_Irr_bank from dual;

  insert into TMP_IRR
    (n, s)
    (select fdat - l_fdat, sumo + SV0K1 + SV7RE + SV2PW + SV6NO + SVBT
       from tmp_gpk);
  select XIRR(10) * 100 into l_Irr_kl from dual;

  update tmp_gpk set irr_bank = trunc(l_irr_bank, 4);
  update tmp_gpk set irr_kl = trunc(l_irr_kl, 4);

  dbms_output.put_line('l_Irr_bank=' || to_char(l_Irr_bank));

  --   EXCEPTION
  --     WHEN NO_DATA_FOUND THEN
  --       NULL;
  --     WHEN OTHERS THEN
  -- Consider logging the error and then re-raise
  --     RAISE;
END cc_gpk_svk;
/
show err;

PROMPT *** Create  grants  CC_GPK_SVK ***
grant EXECUTE                                                                on CC_GPK_SVK      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CC_GPK_SVK      to RCC_DEAL;
grant EXECUTE                                                                on CC_GPK_SVK      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CC_GPK_SVK.sql =========*** End **
PROMPT ===================================================================================== 
