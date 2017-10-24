

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/RELID2RNK.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure RELID2RNK ***

  CREATE OR REPLACE PROCEDURE BARS.RELID2RNK 
  (p_rnk  int,          -- RNK
   p_rej  int default 0 -- режим работы (0 - определение, 1 - замена)
   )
is
  l_okpo          customer.OKPO%type;
  l_id            int;
  l_rowid_extern  varchar2(64);
  l_count         int;
begin
  begin
    select trim(okpo)
    into   l_okpo
    from   customer
    where  rnk=p_rnk                 and
           okpo not like '00000%'    and
           okpo not like '99999%'    and
           okpo not like '12345678%' and
           rownum<2;
--
    begin
      select id,
             rowid
      into   l_id,
             l_rowid_extern
      from   customer_extern
      where  trim(okpo)=l_okpo and
             rownum<2;
--
      select count(1)
      into   l_count
      from   customer_rel
      where  rel_rnk=l_id and
             rel_intext=0;
      if l_count>0 then -- "чужие" есть
        if p_rej=1 then
          update customer_rel
          set    rel_rnk=p_rnk,
                 rel_intext=1
          where  rel_rnk=l_id and
                 rel_intext=0;
          if sql%rowcount>0 then
            bars_audit.info('relid2rnk: клиент RNK='||p_rnk||' найден в "чужих" и "перепривязан"');
          end if;
        end if;
        update customer_extern
        set    rnk=p_rnk,
               detrnk=sysdate
        where  rowid=l_rowid_extern;
        if sql%rowcount>0 then
          bars_audit.info('relid2rnk: клиент RNK='||p_rnk||' найден в "чужих" и помечен');
        end if;
      else
        bars_audit.warning('relid2rnk: клиент RNK='||p_rnk||' не найден в "связанных"');
      end if;
    exception when no_data_found then
      bars_audit.warning('relid2rnk: клиент RNK='||p_rnk||' не найден в "чужих"');
    end;

  exception when no_data_found then
    bars_audit.warning('relid2rnk: клиент RNK='||p_rnk||' имеет некорректный код ОКПО');
  end;
--commit;
end relid2rnk;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/RELID2RNK.sql =========*** End ***
PROMPT ===================================================================================== 
