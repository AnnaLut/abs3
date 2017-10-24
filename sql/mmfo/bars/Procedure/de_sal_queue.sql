

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/DE_SAL_QUEUE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure DE_SAL_QUEUE ***

  CREATE OR REPLACE PROCEDURE BARS.DE_SAL_QUEUE 
is
--***************************************************************--
--                                                               --
--  Разбираем очередь и удаляем лишние обороты в ЦБД             --
--                                                               --
--***************************************************************--

begin

    for c in (select rec_id, fdat, acc, amount
                from saldoa_turn_queue        )
    loop
        de_sal(c.acc, c.fdat, c.amount, null);
        delete from saldoa_turn_queue
         where rec_id = c.rec_id;
    end loop;

end de_sal_queue;
 
/
show err;

PROMPT *** Create  grants  DE_SAL_QUEUE ***
grant EXECUTE                                                                on DE_SAL_QUEUE    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/DE_SAL_QUEUE.sql =========*** End 
PROMPT ===================================================================================== 
