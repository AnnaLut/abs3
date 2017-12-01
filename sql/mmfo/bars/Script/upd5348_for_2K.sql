
PROMPT ===================================================================================== 
PROMPT *** Run *** ======= Scripts /Sql/BARS/Scripts/upd5348_for_2K.sql =========*** Run *** 
PROMPT ===================================================================================== 


exec bc.home;

PROMPT *** Insert  into BARS.ACCOUNTS_FIELD ***

begin
   Insert  into BARS.ACCOUNTS_FIELD  ( TAG, NAME, USE_IN_ARCH )
     Values  ( '#2K_PRIM', 'Примітка по рахунку для файлу #2K (DDD=030)', 0 );
exception  when DUP_VAL_ON_INDEX then null;
end;
/

commit;

PROMPT *** Insert  into BARS.SPARAM_LIST ***

declare
    l_spid     number;
begin

    select count(*)    into l_spid
      from sparam_list
     where tabname ='ACCOUNTSW'
       and tag ='#2K_PRIM';

    if l_spid =0  then

        insert into sparam_list
                 ( SPID, NAME, SEMANTIC,
                   TABNAME, TYPE, INUSE, DELONNULL, TAG, CODE, BRANCH )
          select max(spid)+1, 'VALUE', 'Примітка по рахунку для файлу #2K (DDD=030)',
                   'ACCOUNTSW', 'S', 1, 1, '#2K_PRIM', 'SPECPARAM', '/' 
            from sparam_list;

    end if;

end;
/

commit;

PROMPT *** Insert  into BARS.PS_SPARAM ***

declare
    l_spid     number;
begin

    begin
        select spid    into l_spid
          from sparam_list
         where tabname ='ACCOUNTSW'
           and tag ='#2K_PRIM';
    exception
       when others  then l_spid :=0;
    end;

    if l_spid !=0 then

        delete from ps_sparam where spid =l_spid;

        insert into ps_sparam ( spid, nbs )  values ( l_spid, '2512' );
        insert into ps_sparam ( spid, nbs )  values ( l_spid, '2513' );
        insert into ps_sparam ( spid, nbs )  values ( l_spid, '2520' );
        insert into ps_sparam ( spid, nbs )  values ( l_spid, '2523' );
        insert into ps_sparam ( spid, nbs )  values ( l_spid, '2525' );
        insert into ps_sparam ( spid, nbs )  values ( l_spid, '2530' );
        insert into ps_sparam ( spid, nbs )  values ( l_spid, '2541' );
        insert into ps_sparam ( spid, nbs )  values ( l_spid, '2542' );
        insert into ps_sparam ( spid, nbs )  values ( l_spid, '2544' );
        insert into ps_sparam ( spid, nbs )  values ( l_spid, '2545' );
        insert into ps_sparam ( spid, nbs )  values ( l_spid, '2546' );
        insert into ps_sparam ( spid, nbs )  values ( l_spid, '2550' );
        insert into ps_sparam ( spid, nbs )  values ( l_spid, '2551' );
        insert into ps_sparam ( spid, nbs )  values ( l_spid, '2553' );
        insert into ps_sparam ( spid, nbs )  values ( l_spid, '2555' );
        insert into ps_sparam ( spid, nbs )  values ( l_spid, '2556' );
        insert into ps_sparam ( spid, nbs )  values ( l_spid, '2560' );
        insert into ps_sparam ( spid, nbs )  values ( l_spid, '2561' );
        insert into ps_sparam ( spid, nbs )  values ( l_spid, '2562' );
        insert into ps_sparam ( spid, nbs )  values ( l_spid, '2565' );
        insert into ps_sparam ( spid, nbs )  values ( l_spid, '2600' );
        insert into ps_sparam ( spid, nbs )  values ( l_spid, '2604' );
        insert into ps_sparam ( spid, nbs )  values ( l_spid, '2605' );
        insert into ps_sparam ( spid, nbs )  values ( l_spid, '2610' );
        insert into ps_sparam ( spid, nbs )  values ( l_spid, '2615' );
        insert into ps_sparam ( spid, nbs )  values ( l_spid, '2620' );
        insert into ps_sparam ( spid, nbs )  values ( l_spid, '2625' );
        insert into ps_sparam ( spid, nbs )  values ( l_spid, '2630' );
        insert into ps_sparam ( spid, nbs )  values ( l_spid, '2635' );
        insert into ps_sparam ( spid, nbs )  values ( l_spid, '2650' );
        insert into ps_sparam ( spid, nbs )  values ( l_spid, '2651' );
        insert into ps_sparam ( spid, nbs )  values ( l_spid, '2652' );
        insert into ps_sparam ( spid, nbs )  values ( l_spid, '2655' );
        insert into ps_sparam ( spid, nbs )  values ( l_spid, '3320' );
        insert into ps_sparam ( spid, nbs )  values ( l_spid, '3330' );
        insert into ps_sparam ( spid, nbs )  values ( l_spid, '3340' );

    end if;
end;
/

commit;



PROMPT ===================================================================================== 
PROMPT *** End *** ======= Scripts /Sql/BARS/Scripts/upd5348_for_2K.sql =========*** End *** 
PROMPT ===================================================================================== 




