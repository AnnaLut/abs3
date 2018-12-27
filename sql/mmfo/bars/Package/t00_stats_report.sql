create or replace package T00_STATS_REPORT
is
  
  -----------------------------------------------------------------
  --
  --    Константы
  --
  -----------------------------------------------------------------

   G_HEADER_VERSION  constant varchar2(64) := 'version 1.0 17.12.2018';
   
   G_DB_TOTAL_DOCS number := 1;   --Всього деб. оборотів по-документно
   G_DB_IN_$B      number := 2;   --Списання на клієнтські рахунки коштів, що надійшли із СЕП/ВПС в $B
   G_DB_OUT_$A     number := 3;   --Списання коштiв для формування файлу $A для відправки в СЕП/ВПС
   G_DB_BACK_$A    number := 4;   --Списання при розформуванні файлу $A
   G_DB_OTHERS     number := 5;   --Інші (позарегламентні) списання
   
   G_KR_TOTAL_DOCS number := 6;  --Всього кред. оборотів по-документно  
   G_KR_OUT_$A     number := 7;  --Зарахування вихідних документів в $A: 
   G_KR_IN_$B      number := 8;  --Зарахування суми файлів вхідних докумнетів $B
   G_KR_BACK_$A    number := 9;  -- Зарахування розформованих документів $A
   G_KR_OTHERS     number := 10; --Інші (позарегламентні) зарахування 
   
      

   


  -----------------------------------------------------------------
  --
  --    Типы
  --
  -----------------------------------------------------------------




   -----------------------------------------------------------------
   -- HEADER_VERSION()
   --
   --     Функция возвращает строку с версией заголовка пакета
   --
   --
   --
   function header_version return varchar2;


   -----------------------------------------------------------------
   -- BODY_VERSION()
   --
   --     Функция возвращает строку с версией тела пакета
   --
   --
   --
   function body_version return varchar2;


   -----------------------------------------------------------------
   --    GET_INCOME_BALANCE()
   --
   --    Населить информацию по входящим остаткам транзита
   --
   --
   --    p_indoc     -  входящий clob документа
   --    p_packname  -  имя файла
   --
   procedure get_outcome_balance(p_bankdate  date);

   -----------------------------------------------------------------
   --    GET_TURNS_BALANCE()
   --
   --    Населить информацию по составу дебеьтовых и кредитовых оборотов
   --    Предполагаем представление регионом
   --
   procedure get_turns_balance(p_bankdate  date);


   -----------------------------------------------------------------
   --    GET_T00_REPORT()
   --
   --
   procedure get_t00_report(p_bankdate  date);


end;
/

show errors

----------------------------------------------------------------------------------------------------

create or replace package body T00_STATS_REPORT
is
  ---------------------------------------------------------
  --
  --  Пакет сбора информации по состоянию транзитов
  --
  --
  ---------------------------------------------------------

  ----------------------------------------------
  --  константы
  ----------------------------------------------
  G_BODY_VERSION    constant varchar2(64) := 'version 1.1  27.12.2018';
  G_MODULE          constant char(3)      := 'T00';    -- код модуля
  G_TRACE           constant varchar2(50) := 't00_stats.';



   -----------------------------------------------------------------
   -- HEADER_VERSION()
   --
   --     Функция возвращает строку с версией заголовка пакета
   --
   --
   --
   function header_version return varchar2
   is
   begin
       return 'package header T00_STATS: ' || G_HEADER_VERSION;
   end header_version;


   -----------------------------------------------------------------
   -- BODY_VERSION()
   --
   --     Функция возвращает строку с версией тела пакета
   --
   --
   --
   function body_version return varchar2
   is
   begin
       return 'package body T00_STATS: ' || G_BODY_VERSION;
   end body_version;

   -----------------------------------------------------------------
   --    GET_TURNS_BALANCE()
   --
   --    Населить информацию по составу дебеьтовых и кредитовых оборотов
   --    Предполагаем представление регионом
   --
   procedure get_turns_balance(p_bankdate  date) is
      l_kf varchar2(6) := sys_context('bars_context','user_mfo');
      l_trace   varchar2(1000) := G_TRACE||'get_turns_balance: ';
      l_acc     number;
      l_cnt     number;
      l_id     number;
   begin
     
     select count(1) into l_cnt 
     from t00_stats where kf = gl.kf and report_date = p_bankdate and stat_id in (select id from t00_stats_desc where stat_type in ('KR','DB'));
     if l_cnt > 0 then
        delete from t00_stats_reflist where id in (select id from t00_stats where  kf = gl.kf and  report_date = p_bankdate and stat_id in (select id from t00_stats_desc where stat_type in ('KR','DB')));
        delete from t00_stats where  kf = gl.kf and  report_date = p_bankdate and stat_id in (select id from t00_stats_desc where stat_type in ('KR','DB'));
        --bars_error.nerror('REP', 'DATE_YET_PROCCED', to_char(p_bankdate, 'dd/mm/yyyy'));  
     end if; 
     
     select acc into l_acc 
       from accounts a 
      where a.tip = 'T00' and a.kv = 980 ; 
   
       -- население дебетовых оборотов 
       bars.bars_audit.info(l_trace||'старт населения информации оп оборотам');
       for c in (
         select row_number() over (partition by stat_type_id order by ref) rn, stat_type_id,  s_total, ref 
         from
         (     with       
                          -- Все дебетовые списания с транзита                          
                          o as (select  ref, s   from bars.opldok where sos = 5  and fdat = p_bankdate and acc = l_acc and dk = 0),
                          -- расформированные $A (формирования уже нету в zag_b)
                          r as (select ref, s  from bars.opldok where tt='R02' and fdat = p_bankdate and dk =1 and sos = 5 and acc =  l_acc),
                          -- Первичный провод - суммы уходящие в СЕП-ВПС
                          z as (select ref, skr from bars.zag_b  where kv = 980 and fn like '$A%' and dat between p_bankdate  and p_bankdate + 2  and skr <> 0),
                          -- Ответный провод - суммы из СЕП-ВПС
                          a as (select ref, s    
                                  from bars.arc_rrp a  
                                 where kv = 980  and a.dk = 1
                                   and ( mfob=bars.gl.KF and fn_a like '$B%' and dat_a > p_bankdate  - 5 and dat_a <=  p_bankdate + 2)
                               ),
                          ot as (     select o.ref,  sum(s) over () s_total  
                                         from o, 
                                              (select ref from r 
                                               union all 
                                               select ref from z 
                                               union all 
                                               select ref from a 
                                               ) docs
                               where o.ref = docs.ref (+)
                                 and docs.ref is null
                              ),
                      o1 as ( select sum(s)   s_total from o),      
                      r1 as ( select sum(s)   s_total from r where ref in  (select ref from o)),      
                      a1 as ( select sum(s)   s_total from a where ref in  (select ref from o)),                              
                      z1 as ( select sum(skr) s_total from z where ref in  (select ref from o)),
                      --
                      -- собираем кредитовые документы
                      --
                      k_o as (select *  from bars.opldok where sos = 5  and fdat = p_bankdate and acc = l_acc and dk = 1),
                      -- расформированные $A
                      k_r as (select ref, s      from bars.opldok where tt='R02' and fdat = p_bankdate and dk =1 and sos = 5 and acc =  l_acc),
                      -- Ответный провод - поступившие суммы на транзит $B файлов
                      k_z as (select ref, skr    from bars.zag_a  where kv = 980 and fn like '$B%' and dat between p_bankdate and p_bankdate + 2  and skr <> 0),
                      -- Первичный провод - зачисления на транзит для дальнешего формирования $A
                      k_a as (select ref, s      from bars.arc_rrp a  
                             where kv = 980  and a.dk = 1
                               and ( mfoa = bars.gl.KF and fn_b like '$A%' and dat_b > p_bankdate - 5 and dat_b <=  p_bankdate + 2)
                           ),
                      -- документы, которые прошли вне регламента
                      k_ot as (     select k_o.ref,  sum(s) over () s_total  
                                     from k_o, 
                                          (select ref from k_r 
                                           union all 
                                           select ref from k_z 
                                           union all 
                                           select ref from k_a 
                                           ) docs
                           where k_o.ref = docs.ref (+)
                             and docs.ref is null
                          ),                      
                      k_o1 as (select sum(s)   s_total from k_o),      
                      k_r1 as (select sum(s)   s_total from k_r where ref in  (select ref from k_o)),      
                      k_a1 as (select sum(s)   s_total from k_a where ref in  (select ref from k_o)),                              
                      k_z1 as (select sum(skr) s_total from k_z where ref in  (select ref from k_o))  
                      --Всього деб. оборотів по-документно  
                      select G_DB_TOTAL_DOCS stat_type_id,    s_total, null ref from o1
                      union all
                      --Списання на клієнтські рахунки коштів, що надійшли із СЕП/ВПС в $B
                      select G_DB_IN_$B,                       s_total, null from a1
                      union all
                      --Списання коштiв для формування файлу $A для відправки в СЕП/ВПС
                      select G_DB_OUT_$A,                      s_total, null from z1
                      union all
                      --Списання при розформуванні файлу $A
                      select G_DB_BACK_$A ,                    s_total, null from r1
                      union all
                      --Інші (позарегламентні) списання
                      select G_DB_OTHERS,                      s_total, ref  from ot
                      union all
                        --Всього кр оборотів по-документно  
                      select G_KR_TOTAL_DOCS stat_type_id,     s_total, null ref from k_o1
                      union all
                      --Списання на клієнтські рахунки коштів, що надійшли із СЕП/ВПС в $B
                      select G_KR_OUT_$A,                      s_total, null from k_a1
                      union all
                      --Списання коштiв для формування файлу $A для відправки в СЕП/ВПС
                      select G_KR_IN_$B,                       s_total, null from k_z1
                      union all
                      --Списання при розформуванні файлу $A
                      select G_KR_BACK_$A ,                    s_total, null from k_r1
                      union all
                      --Інші (позарегламентні) списання
                      select G_KR_OTHERS,                      s_total, ref  from k_ot
           )     
           order by  stat_type_id     
         ) loop

            if c.rn  = 1 then
               l_id := s_t00_stats.nextval; 
               
               insert into  t00_stats(id, kf, report_date,  stat_id, amount)
               values(l_id, gl.kf, p_bankdate, c.stat_type_id, c.s_total);
           end if;            
            
           if c.ref is not null then
              insert into t00_stats_reflist (id, ref ) values(l_id, c.ref);  
           end if;  
            
         end loop;                      
         
   end;
   -----------------------------------------------------------------
   --    GET_OUTCOME_BALANCE()
   --
   --    Населить информацию по составу исходящего остатка на транзите по региону
   --    Предполагаем представление регионом
   --
   procedure get_outcome_balance(p_bankdate  date) is
      l_kf varchar2(6) := sys_context('bars_context','user_mfo');
      l_t00_ost number;
      l_sum     number := 0;
      l_cnt     number;
      l_id      number;
      l_trace   varchar2(1000) := G_TRACE||'get_outcome_balance: ';
      l_acc     number;
   begin

     select count(1) into l_cnt 
     from t00_stats where kf = gl.kf and report_date = p_bankdate and stat_id in (select id from t00_stats_desc where stat_type like 'OST%');
     if l_cnt > 0 then
        delete from t00_stats where  kf = gl.kf and report_date = p_bankdate and stat_id in (select id from t00_stats_desc where stat_type like 'OST%');
        --bars_error.nerror('REP', 'DATE_YET_PROCCED', to_char(p_bankdate, 'dd/mm/yyyy'));  
     end if;

      select s.ostf - s.dos + s.kos, a.acc into l_t00_ost, l_acc 
       from saldoa s, accounts a 
      where a.tip = 'T00' and s.fdat = p_bankdate and a.kv = 980 and a.acc = s.acc; 

      for c in (
                  --Начальный провод. Документ в rec_que, имя файла еще не присвоено
                  select 'OST_BLKOUT' type, sum(s) s, nvl( to_char(blk), 'пусто') blk
                    from bars.rec_que r, 
                         bars.arc_rrp  a
                   where a.mfoa = gl.kf
                     and a.rec = r.rec 
                     and s <> 0
                     group by blk
                  union all
                  -- Ответный провод на T00 (зачисления от НБУ, РУ, ЦА)
                  select 'OST_BLKIN', sum(s) s, nvl( to_char(blk), 'пусто') blk
                    from bars.rec_que r, 
                         bars.arc_rrp  a, 
                         bars.zag_a z
                   where a.sos = 3 
                     and a.fn_a like '$B%'
                     and z.fn = fn_a and z.dat = dat_a
                     and a.mfob = gl.kf
                     and a.rec = r.rec 
                     and s <> 0
                  group by blk
            ) loop
            
            begin 
               select id into l_id 
                 from t00_stats_desc 
                where stat_type = c.type 
                  and stat_id_desc  = c.blk; 
                  bars_audit.info (l_trace||'  '||' - '||l_id);
            exception when no_data_found  then
               select max(id) + 1 into l_id from t00_stats_desc;
               begin 
                  insert into t00_stats_desc(id, stat_type_id, stat_type, stat_id_desc) 
                  values ( l_id, 
                       (select max(stat_type_id) + 1 from t00_stats_desc where stat_type = c.type ),
                        c.type,
                        c.blk
                      );  
                 exception when dup_val_on_index then
                      select id into l_id 
                        from t00_stats_desc 
                       where stat_type = c.type 
                         and stat_id_desc  = c.blk; 
                 end;

            end; 
            
            
            
             
               insert into  t00_stats (id, kf, report_date, stat_id, amount)
               values(s_t00_stats.nextval, gl.kf, p_bankdate, l_id, c.s);
               
               l_sum := l_sum + c.s;
        end loop;    
              
        -- населенеи строки фантомных сумм
        select id into l_id from t00_stats_desc where stat_type = 'OST_OTHER';
        insert into  t00_stats (id, kf, report_date, stat_id, amount)
        values(s_t00_stats.nextval, gl.kf, p_bankdate, l_id, l_t00_ost - l_sum);

        
   end;
   -----------------------------------------------------------------
   --    GET_T00_REPORT()
   --
   --
   procedure get_t00_report(p_bankdate date) is
   begin
       get_outcome_balance(p_bankdate);
       get_turns_balance(p_bankdate);
   end;

end T00_STATS_REPORT;
/

show err;
 
PROMPT *** Create  grants  T00_STATS_REPORT ***
grant EXECUTE                                                                on T00_STATS_REPORT to BARS_ACCESS_DEFROLE;
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/T00_STATS_REPORT.sql =========*** End
 PROMPT ===================================================================================== 
 