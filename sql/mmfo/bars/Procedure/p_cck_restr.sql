

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CCK_RESTR.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CCK_RESTR ***

  CREATE OR REPLACE PROCEDURE BARS.P_CCK_RESTR 
(p_par number, p_ND number, p_VID_RESTR number, p_FDAT date, p_TXT varchar2,
 p_SUMR number, p_FDAT_END date, p_PR_NO number,
 p_KND number, p_KDAT date, p_KVID number)
is
    cnt_    number;
begin
  if p_ND is null then
     bars_error.RAISE_ERROR('OTC', 6, 'Не заповнений Реф КД. Перевірте!');
  else
     select count(*)
     into cnt_
     from cc_deal
     where nd = p_ND;

     if cnt_ = 0 then
        bars_error.RAISE_ERROR('OTC', 6, 'Не існує кредиту з таким Реф КД. Перевірте!');
     end if;
  end if;

  if p_VID_RESTR is null then
     bars_error.RAISE_ERROR('OTC', 6, 'Не заповнений вид реструктуризації. Перевірте!');
  else
     select count(*)
     into cnt_
     from CCK_RESTR_VID
     where VID_RESTR = p_VID_RESTR;

     if cnt_ = 0 then
        bars_error.RAISE_ERROR('OTC', 6, 'Не існує такого виду реструктуризації. Перевірте!');
     end if;
  end if;

  if p_FDAT is null then
     bars_error.RAISE_ERROR('OTC', 6, 'Не заповнена дата реструктуризації. Перевірте!');
  end if;

  if p_PR_NO not in (0, 1) then
     bars_error.RAISE_ERROR('OTC', 6, 'Допустимі значення в полі "Ознака включення в F8 файл" 0 чи 1. Перевірте!');
  end if;

  if p_FDAT_END is not null and p_FDAT_END <= p_FDAT then
     bars_error.RAISE_ERROR('OTC', 6, 'Неправильна дата закінчення реструктуризації (вона не може бути меньшою дати початку реструктуризації). Перевірте!');
  end if;

  if p_par = 1 then
    begin
      Insert into CCK_RESTR(ND, FDAT, VID_RESTR, TXT, SUMR, FDAT_END, PR_NO)
      Values (p_ND, p_FDAT, p_VID_RESTR, p_TXT, nvl(p_SUMR, 0), p_FDAT_END, nvl(p_PR_NO, 1));
    end;
  elsif p_par = 2 then
    begin
       update cck_restr
         set nd = p_ND,
             fdat = p_FDAT,
             vid_restr = p_VID_RESTR,
             TXT = p_TXT,
             SUMR = nvl(p_SUMR, 0),
             FDAT_END = p_FDAT_END,
             PR_NO = nvl(p_PR_NO, 1)
       where nd = p_KND and
             fdat = p_KDAT and
             vid_restr = p_KVID;
    exception
        when others then
            if sqlcode = -1 then
                bars_error.RAISE_ERROR('OTC', 6, 'Запис з такими ключовими полями (Реф КД, дата та вид реструктуризації) вже існує. Перевірте!');
            else
                raise;
            end if;
    end;
  elsif p_par = 3 then
    begin
      delete from CCK_RESTR where nd = p_ND and FDAT = p_FDAT and VID_RESTR = p_VID_RESTR;
    end;
  end if;
end;
/
show err;

PROMPT *** Create  grants  P_CCK_RESTR ***
grant EXECUTE                                                                on P_CCK_RESTR     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_CCK_RESTR     to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CCK_RESTR.sql =========*** End *
PROMPT ===================================================================================== 
