

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/RET_O_ALL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure RET_O_ALL ***

  CREATE OR REPLACE PROCEDURE BARS.RET_O_ALL 
 ( p_MFO varchar2, -- МФО РУ
   p_DAT date -- самая нижняя дата, по которую берем документы,
              --   НЕ включая эту  дату
 ) IS

 -- 28-10-2009 Проверено  на Житомире.

 -- сделать OPER+OPLDOK из СКАРБА-6 до указанной даты
 -- В Луцке : exec RET_O_ALL('303398', null);
 DAT_  date  := NVL(p_DAT, to_date('01-01-2009','dd-mm-yyyy'));
 -------------
 l_cnt  number;  -- признак наличия индекса
begin

 select count(*) into l_cnt from user_indexes where index_name = 'I1_S6DOCUMY';
 If l_cnt >0 then
    execute immediate 'drop index I1_S6DOCUMY';
 end if;

 logger.info ('RET_O_ALL Begin index');
 execute immediate
    'create index I1_S6DOCUMY on S6_DOCUM_Y (DA_MB) tablespace brsdyni';
 logger.info ('RET_O_ALL End index');


 --прикинуться МФО
 bars_context.subst_branch( '/' || P_MFO || '/' );

 FOR d in (select DA_MB
           from ( select distinct DA_MB
                  from S6_DOCUM_Y
                  where DA_MB>DAT_ )
           order by 1)
 loop
    RET_O (d.DA_MB);
    commit;
 end loop;
end RET_O_ALL ;
/
show err;

PROMPT *** Create  grants  RET_O_ALL ***
grant EXECUTE                                                                on RET_O_ALL       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/RET_O_ALL.sql =========*** End ***
PROMPT ===================================================================================== 
