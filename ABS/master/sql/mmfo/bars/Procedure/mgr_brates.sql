

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/MGR_BRATES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure MGR_BRATES ***

  CREATE OR REPLACE PROCEDURE BARS.MGR_BRATES 
( p_kf    in     br_normal_edit.kf%type
) is
  l_br_id   brates.br_id%type;
  l_br_tp   number(1);
  l_br_nm   brates.name%type;
  l_ru_key  number(2);
  ---
  procedure GEN_BRATE_ID
  ( p_br_id   brates.br_id%type
  ) is
  begin

    l_br_id := p_br_id * 100 + l_ru_key;

    begin

      -- пробуємо додати хвіст з кодом РУ
      select NAME
        into l_br_nm
        from BRATES
       where BR_ID = l_br_id;

      -- вільний ID
      with LISTID as ( select LEVEL as ID
                         from DUAL
                      CONNECT BY LEVEL < ( select max(BR_ID) from BRATES )
                     )
         , FREEID as ( select /* MATERIALIZE */ l.ID
                         from LISTID l
                         left
                         join BRATES b
                           on ( b.BR_ID = l.ID )
                        where b.BR_ID Is Null
                     )
      select min( ID )
        into l_br_id
        from FREEID
       where ID > p_br_id;

    exception
      when NO_DATA_FOUND then
        null;
    end;

  end GEN_BRATE_ID;
  ---
begin

  l_ru_key := to_number( BARS_SQNC.GET_RU( p_kf ) );

  for b in ( select b1.BR_ID as BR_ID_MMFO, b1.BR_TYPE as BR_TYPE_MMFO, b1.NAME as BR_NAME_MMFO
                  , b2.BR_ID, b2.BR_TYPE, b2.NAME, b2.FORMULA, b2.INUSE, b2.COMM
               from BARS.BRATES b1
              right outer -- тільки ставки що мають значення
               join ( select b.BR_ID, BR_TYPE, NAME, FORMULA, INUSE, COMM
                        from BRATES@MGRS_335106 b
                        left
                        join ( select BR_ID
                                 from BR_NORMAL_EDIT@MGRS_335106
                                union
                               select BR_ID
                                 from BR_TIER_EDIT@MGRS_335106
                             ) v
                          on ( v.BR_ID = b.BR_ID )
                        where v.br_id is Not Null
                    ) b2
                 on ( b1.BR_ID = b2.BR_ID ) )
  loop

    if ( b.BR_NAME_MMFO = b.NAME and b.BR_TYPE_MMFO = b.BR_TYPE )
    then -- однакові (мігруємо значення)

      l_br_id := b.BR_ID_MMFO;
      l_br_tp := b.BR_TYPE_MMFO;

    else

      if ( b.BR_ID_MMFO Is Null )
      then -- новий код ( з РУ )

        l_br_id := b.BR_ID;

      else

        -- 1) шукати по назві та типу

        -- 2) у випадку не співпадіння типу ( в ММФО шкальна в РУ ні )
        --    залити дані з BR_NORMAL_EDIT в BR_TIER_EDIT

        -- 3) перекодувати
        GEN_BRATE_ID( b.BR_ID );

      end if;

      l_br_tp := b.BR_TYPE;
      l_br_nm := SubStr( p_kf || ' - ' || b.NAME, 1, 35 );

      insert
        into BARS.BRATES
         ( BR_ID, BR_TYPE, NAME, FORMULA, INUSE, COMM )
      values
         ( l_br_id, l_br_tp, l_br_nm, b.FORMULA, b.INUSE, b.COMM );

      insert
        into BARS.BRATES_KF
           ( KF, BR_ID, NEW_BR_ID, ROWS_QTY )
      values
           ( p_kf, b.BR_ID, l_br_id, 0 );

    end if;

    if ( l_br_tp = 1 )
    then

      insert
        into BARS.BR_NORMAL_EDIT
           ( BR_ID, BDATE, KV, RATE, KF )
      select l_br_id, BDATE, KV, RATE, p_kf
        from BARS.BR_NORMAL_EDIT@MGRS_335106
       where BR_ID = b.BR_ID;

    else

      insert
        into BARS.BR_TIER_EDIT
           ( BR_ID, BDATE, KV, S, RATE, KF )
      select l_br_id, BDATE, KV, S, RATE, p_kf
        from BARS.BR_TIER_EDIT@MGRS_335106
       where BR_ID = b.BR_ID
         and rate is not null;

    end if;

  end loop;

end MGR_BRATES;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/MGR_BRATES.sql =========*** End **
PROMPT ===================================================================================== 
