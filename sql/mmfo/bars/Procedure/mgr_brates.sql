PROMPT *** Create  procedure MGR_BRATES ***

create or replace procedure MGR_BRATES
( p_kf    in     br_normal_edit.kf%type
) is
  l_br_id   brates.br_id%type;
  l_br_tp   number(1);
  l_br_nm   brates.name%type;
  l_ru_key  number(2);
  ---
  cur       sys_refcursor;
  type row_type is record ( br_id_mmfo   brates.br_id%type
                          , br_type_mmfo brates.br_type%type
                          , br_name_mmfo brates.name%type
                          , br_id        brates.br_id%type
                          , br_type      brates.br_type%type
                          , name         brates.name%type
                          , formula      brates.formula%type
                          , inuse        brates.inuse%type
                          , comm         brates.comm%type
                          );
  b         row_type;
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

--    -- вільний ID
--    with LISTID as ( select LEVEL as ID
--                       from DUAL
--                    CONNECT BY LEVEL < ( select max(BR_ID) from BRATES )
--                   )
--       , FREEID as ( select /* MATERIALIZE */ l.ID
--                       from LISTID l
--                       left
--                       join BRATES b
--                         on ( b.BR_ID = l.ID )
--                      where b.BR_ID Is Null
--                   )
--    select min( ID )
--      into l_br_id
--      from FREEID
--     where ID > p_br_id;

      l_br_id := p_br_id;

      for b in ( select BR_ID
                   from BRATES
                  where BR_ID > p_br_id
                  order by BR_ID )
      loop
        l_br_id := l_br_id + 1;
--      dbms_output.put_line('l_br_id='||l_br_id||', b.BR_ID='||b.BR_ID);
        exit when b.BR_ID > l_br_id;
      end loop;

    exception
      when NO_DATA_FOUND then
        null;
    end;

  end GEN_BRATE_ID;
  ---
begin

  l_ru_key := to_number( BARS_SQNC.GET_RU( p_kf ) );

  open cur for 'select b1.BR_ID as BR_ID_MMFO, b1.BR_TYPE as BR_TYPE_MMFO, b1.NAME as BR_NAME_MMFO'
            || '     , b2.BR_ID, b2.BR_TYPE, b2.NAME, b2.FORMULA, b2.INUSE, b2.COMM'
            || '  from BRATES b1'
            || ' right outer' -- тільки ставки що мають значення
            || '  join ( select b.BR_ID, BR_TYPE, NAME, FORMULA, INUSE, COMM'
            || '           from BRATES@MGRS_311647 b'
            || '           left outer'
            || '           join ( select BR_ID'
            || '                    from BR_NORMAL_EDIT@MGRS_'||p_kf
            || '                   union'
            || '                  select BR_ID'
            || '                    from BR_TIER_EDIT@MGRS_'||p_kf
            || '                ) v'
            || '             on ( v.BR_ID = b.BR_ID )'
            || '           where v.br_id is Not Null'
            || '       ) b2'
            || '    on ( b1.BR_ID = b2.BR_ID ) )';

  loop

    fetch cur into b;

    exit when cur%notfound;

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
        into BRATES
           ( BR_ID, BR_TYPE, NAME, FORMULA, INUSE, COMM )
      values
           ( l_br_id, l_br_tp, l_br_nm, b.FORMULA, b.INUSE, b.COMM );

      insert
        into BRATES_KF
           ( KF, BR_ID, NEW_BR_ID, ROWS_QTY )
      values
           ( p_kf, b.BR_ID, l_br_id, 0 );

    end if;

    BC.SUBST_MFO( p_kf );

    if ( l_br_tp = 1 )
    then

      execute immediate 'insert into BR_NORMAL_EDIT ( BR_ID, BDATE, KV, RATE ) '||
                        'select :new_br_id, BDATE, KV, RATE from BR_NORMAL_EDIT@MGRS_'||p_kf||' where BR_ID = :old_br_id'
      using l_br_id, b.BR_ID;

    else

      execute immediate 'insert into BARS.BR_TIER_EDIT ( BR_ID, BDATE, KV, S, RATE ) '||
                        'select :new_br_id, BDATE, KV, S, RATE from BR_TIER_EDIT@MGRS_'||p_kf||' where BR_ID = :old_br_id and RATE is not null'
      using l_br_id, b.BR_ID;

    end if;

    BC.SET_CONTEXT;

  end loop;

end MGR_BRATES;
/

show err;
