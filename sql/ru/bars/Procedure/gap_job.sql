

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/GAP_JOB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure GAP_JOB ***

  CREATE OR REPLACE PROCEDURE BARS.GAP_JOB IS
/*
  GAP_JOB для выполнения
  GAP - накопление в первичный АРХИВ (rnbu_trace1) и в архив ИТОГОВ (ani_gap)
  Джоб стартует в 2 часа ночи и перенакапливает архив за 2 предыдущих банковских дня
  09/03/2013 - добавлена чистка rnbu_trace1
  12/03/2013 - подправлена чистка rnbu_trace1
*/
  n_  int := 1;
begin
  tokf;
  for k in (select fdat
            from   fdat
            where  fdat<trunc(sysdate)
            order  by fdat desc)
  loop
    If n_>2 then
      RETURN;
    end if;
    ----------------------------
    ANI4_bU_ex(2,0,null,k.FDAT);
    ANI_GAPs(1,k.FDAT,k.FDAT);
    n_ := n_+1;
  end loop;
  commit;
--
  begin
    execute immediate 'drop table tmp_rnbu_trace1';
  exception when others then
    if sqlcode=-942 then
      null;
    else
      bars_audit.error('GAP_JOB(1): '||sqlerrm);
    end if;
  end;
  begin
    execute immediate 'create table tmp_rnbu_trace1 as
                       select * from  rnbu_trace1
                                where FDAT>=sysdate-7';
  exception when others then
    if sqlcode=-955 then
      null;
    else
      bars_audit.error('GAP_JOB(2): '||sqlerrm);
    end if;
  end;
  begin
    execute immediate 'truncate table rnbu_trace1 drop storage';
  exception when others then
    null;
  end;
  begin
    execute immediate 'insert into rnbu_trace1
                     select * from tmp_rnbu_trace1';
    commit;
  exception when others then
    null;
  end;
  begin
    execute immediate 'drop table tmp_rnbu_trace1';
  exception when others then
    if sqlcode=-942 then
      null;
    else
      bars_audit.error('GAP_JOB(3): '||sqlerrm);
    end if;
  end;
  toroot;
end GAP_JOB;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/GAP_JOB.sql =========*** End *** =
PROMPT ===================================================================================== 
