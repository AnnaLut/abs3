create or replace procedure CHANGE_BANKING_DATE
is
  l_nxt_dt date;
  -- ф-я зміни банківської дати в автоматичному режимі
begin

  l_nxt_dt := BARS.GLB_BANKDATE();

  --BARS.BARS_CONTEXT.SUBST_MFO(BARS.F_OURMFO_G());

  if ( l_nxt_dt < trunc(sysdate) )
  then

    -- закриття дня
/*    update BARS.PARAMS
       set VAl = 0
     where PAR = 'RRPDAY';*/

    -- виконання ф-й при закритті дня
    -- ...

    -- наступна банківська дата
    l_nxt_dt := BARS.DAT_NEXT_U(l_nxt_dt,1);

    -- insert into FDAT (TIU_PARAMS$BASE_FDAT)
    -- reload_context   (TIU_PARAMS$BASE_BANKDATE)
    
    
   update BARS.PARAMS$BASE
       set VAl = 0
     where PAR = 'RRPDAY';
     
    update BARS.PARAMS$BASE
       set VAL = to_char(l_nxt_dt,'MM/dd/yyyy')
     where PAR = 'BANKDATE';
    update BARS.params$global
       set VAL = to_char(l_nxt_dt,'MM/dd/yyyy')
     where PAR = 'BANKDATE';
     
   update BARS.PARAMS$BASE
       set VAl = 1
     where PAR = 'RRPDAY';     
     
   update bars.fdat 
      set stat = 9
    where fdat <> l_nxt_dt;    


    bars_audit.info( to_char(l_nxt_dt,'MM/dd/yyyy') || ' - ' || sql%rowcount );

    -- Инициализация глобальных переменных используемых процедурами на сервере БД
--    BARS.GL.PARAM;

    -- виконання ф-й при відкритті дня
    -- ...

    -- відкриття дня
/*    update BARS.PARAMS
       set VAL = 1
     where PAR = 'RRPDAY';*/

    -- Зміна робочої банківської дати користувача (gl.pl_dat)
    --BARS.BARS_CONTEXT.SUBST_MFO(BARS.F_OURMFO_G());    
    --BARS.SET_BANKDATE(l_nxt_dt);

  else
    null;
  end if;

end CHANGE_BANKING_DATE;
/

show err