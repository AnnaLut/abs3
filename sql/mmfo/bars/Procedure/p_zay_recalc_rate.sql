create or replace procedure p_zay_recalc_rate as  
 v_rate_o number;
 v_summa number;
begin
  
    for rec in (select zay_id,summa_val,rate_o,kv2 from zay_val_control 
                where sos=0 and viza=1 and  zay_date >=trunc(sysdate)-30
               )
    loop 
     -- отримуємо новий курс НБУ
     v_rate_o:=f_ret_kurs(rec.kv2, trunc(sysdate));
     --перераховуємо еквівалент    
     v_summa:= gl.p_icurval(rec.kv2,rec.summa_val,trunc(SYSDATE));
     --оновлюємо дані
     update zay_val_control 
        set rate_o=v_rate_o,
            summa=v_summa 
       where zay_id=rec.zay_id;
       
       if sql%rowcount >=0 
        then logger.info('ZAY. Оновлено курси в '||sql%rowcount||' заявках в таблиці контролю лімітів');
       end if;
                    
    end loop;   
end ;
/


