

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FF9.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FF9 ***

  CREATE OR REPLACE PROCEDURE BARS.P_FF9 (dat_ DATE )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования #E8 для КБ (универсальная)
% COPYRIGHT   : Copyright UNITY-BARS Limited, 2008.  All Rights Reserved.
% VERSION     : 06.10.2010 (01.10.2009, 07.08.2009)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_ - отчетная дата

06.10.2010 - для бал.счета 2601 будем отбирать только лицевые счета для
             которых R013='4' формируем код 118 другие отражаются на
             внебал. счете 9781
01.10.2009 - добавлены два спецпараметра в SPECPARAM которые будут
             использоваться при формировании
             (D1#F9 - признак счета доверительного управления или нет
              NF#F9 - номер фонда финансирования строительства)
07.08.2009 - не формировался файл, если счета отсутствовали в табл.
             SPECPARAM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
n_	number;
rnk_p_	number;
userid_	number;
ddd_	varchar2(3);
nf_     varchar2(2);

begin
    -------------------------------------------------------------------------------
    SELECT id INTO userid_ FROM staff WHERE upper(logname)=upper(USER);
    EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
    -------------------------------------------------------------------------------
    n_     := 0;	-- порядковый номер фонда
    rnk_p_ := null;	-- код предыдущего контрагента (чтобы следить за сменой порядкового номера)
    nf_    := null;     -- код фонда

    for i in (select s.ostf-s.dos+s.kos ost,
                     a.rnk, a.kv, a.nbs, a.nls, a.acc,
                     k.ddd,
                     (case c.custtype when 3 then '0' else '1' end) z220,
                     NVL(sp.z290,'00') z290, NVL(sp.dp1,'0') dp1,
                     NVL(sp.D1#F9,'0'), NVL(sp.NF#F9,'1') NF,
                     NVL(sp.R013,'0') R013
              from saldoa s, accounts a, kl_f3_29 k, customer c, specparam sp
              where s.fdat = (select max(s1.fdat)
                              from saldoa s1
                              where s1.acc = s.acc and s1.fdat <= dat_)
                 and s.acc = a.acc
                 and a.rnk = c.rnk
                 and a.nbs = k.r020
                 and k.kf = 'F9'
                 and ((a.nbs='2601' and NVL(sp.R013,'0')='4') or
                       a.nbs != '2601')
                 and s.ostf-s.dos+s.kos <> 0
                 and sp.acc(+) = a.acc
                 and NVL(sp.D1#F9,'0') != '1'
               order by sp.NF#F9  --rnk
             )
    loop

        -- проследить за порядковым номером фонда
        --if (i.rnk != rnk_p_ OR rnk_p_ is null) then
        --    n_ := n_ + 1;
        --    rnk_p_ := i.rnk;
        --    -- вставить запись с DDD='180' для ручного редактирования
        --    insert into rnbu_trace(nls, kv, odate, kodp, znap, rnk, acc)
        --   values(i.nls, i.kv, dat_,
        --           '180'||lpad(n_,3,'0')||i.kv||i.z290||i.z220, '-1',
        --           i.rnk, i.acc);
        --end if;

        if (i.NF != NF_ OR NF_ is null) then
            n_ := n_ + 1;
            nf_ := i.nf;
        end if;
        -- определение параметра DDD по балансовому и дополнительному параметру dp1
        ddd_ := i.ddd;
        if (i.nbs = '9782') then
            ddd_ := case i.dp1 when '2' then '112'
                               when '3' then '113'
                               when '4' then '115'
                               when '5' then '116'
                               when '6' then '114'
                                        else '114' end;
        end if;
        if (i.nbs = '9786') then
            ddd_ := case i.dp1 when '4' then '115'
                               when '5' then '116'
                               when '6' then '114'
                                        else '114' end;
        end if;
        if (i.nbs in ('9790','9791')) then
            ddd_ := case i.dp1 when '1' then '107'
                               when '2' then '108'
                               when '7' then '118'
                                        else '107' end;
            -- вставить запись с DDD='180' для ручного редактирования
            insert into rnbu_trace(nls, kv, odate, kodp, znap, rnk, acc)
            values(i.nls, i.kv, dat_,
                   '180'||lpad(n_,3,'0')||i.kv||i.z290||i.z220, '1',
                   i.rnk, i.acc);

        end if;

        if i.nbs = '2601' and i.r013='4' then
           ddd_ := '118';
        end if;

        -- собственно запись в rnbu_trace
        insert into rnbu_trace(nls, kv, odate, kodp, znap, rnk, acc)
            values(i.nls, i.kv, dat_,
                   ddd_||lpad(n_,3,'0')||i.kv||i.z290||i.z220, -- kodp
                   to_char(ABS(i.ost)),
                   i.rnk, i.acc);
        if (ddd_ in ('107','108')) then
            -- продублировать запись, чтобы включить ее в DDD='100'
            insert into rnbu_trace(nls, kv, odate, kodp, znap, rnk, acc)
            values(i.nls, i.kv, dat_,
                   '100'||lpad(n_,3,'0')||i.kv||i.z290||i.z220, -- kodp
                   to_char(ABS(i.ost)),
                   i.rnk, i.acc);
        end if;

        if (ddd_ in ('112','113','114')) then
            -- продублировать запись, чтобы включить ее в DDD='110'
            insert into rnbu_trace(nls, kv, odate, kodp, znap, rnk, acc)
            values(i.nls, i.kv, dat_,
                   '110'||lpad(n_,3,'0')||i.kv||i.z290||i.z220, -- kodp
                   to_char(ABS(i.ost)),
                   i.rnk, i.acc);
        end if;
    end loop;
    -------------------------------------------------------------------------------
    delete from tmp_nbu
     where kodf = 'F9' and datf = dat_;
    insert into tmp_nbu(kodf, datf, kodp, znap)
        select 'F9', dat_, kodp, sum(to_number(znap))
          from rnbu_trace
         where userid = userid_
         group by kodp;
end p_ff9;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FF9.sql =========*** End *** ===
PROMPT ===================================================================================== 
