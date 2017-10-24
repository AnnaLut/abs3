

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ZAY_RETRANSMISSION_DATA.sql ====
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ZAY_RETRANSMISSION_DATA ***

  CREATE OR REPLACE PROCEDURE BARS.P_ZAY_RETRANSMISSION_DATA is
  l_mode number;
  l_ref  number;
begin
  select nvl(max(b.val), 0)
    into l_mode
    from birja b
   where b.par = 'ZAY_MODE';

  if l_mode = 1 then
    for c in (select d.*
                from bars.zay_data_transfer d
               where d.transfer_result = 0
               order by d.transfer_type asc) loop
      -- Передача индикативных курсов
      if c.transfer_type = 1 then
        begin
          bars_zay.p_kurs_data_transfer(p_par => 1,
                                        p_url => c.url,
                                        p_dat => c.transfer_date);
        exception when no_data_found then
          delete from zay_data_transfer where id = c.id;
        end;
        delete from zay_data_transfer where id = c.id;
      end if;
     -- Передача курсов дилера
      if c.transfer_type = 4 then
        begin
          bars_zay.p_kurs_data_transfer(p_par => 2,
                                        p_url => c.url,
                                        p_dat => c.transfer_date);
        exception when no_data_found then
          delete from zay_data_transfer where id = c.id;
        end;
        delete from zay_data_transfer where id = c.id;
      end if;
    -- Удолитворение заявки
      if c.transfer_type = 5 then
        begin
          bars_zay.p_viza_reqesr_transfer(c.req_id);
         exception when no_data_found then
           delete from zay_data_transfer where id = c.id;
        end;
        delete from zay_data_transfer where id = c.id;
      end if;
      /*
      if c.transfer_type = 6 then
        select ref_sps_check
          into l_ref
          from zayavka_ru
         where id = c.req_id;
        bars_zay.p_reqest_set_refsps(p_id => c.req_id, p_ref_sps => l_ref);
        delete from zay_data_transfer where id = c.id;
      end if;*/
    end loop;
  end if;

  if l_mode = 2 then
    for c in (select d.*
                from bars.zay_data_transfer d
               where d.transfer_result = 0
               order by d.transfer_type asc) loop
      -- Информация о создании заявки
      if c.transfer_type = 2 then
        begin
          bars_zay.service_request(p_reqest_id => c.req_id, p_flag_klb => 0);
         exception  when no_data_found then
           delete from zay_data_transfer where id = c.id;
        end;
        delete from zay_data_transfer where id = c.id;
         -- Передача информации о изменении заявки
      elsif c.transfer_type = 8 then
        begin
          bars_zay.service_request(p_reqest_id => c.req_id, p_flag_klb => 2);
         exception  when no_data_found then
           delete from zay_data_transfer where id = c.id;
        end;
        delete from zay_data_transfer where id = c.id;
        -- Передача информации о визировании заявки
      elsif c.transfer_type = 9 then
        begin
          bars_zay.service_request(p_reqest_id => c.req_id, p_flag_klb => 3);
         exception  when no_data_found then
           delete from zay_data_transfer where id = c.id;
        end;
        delete from zay_data_transfer where id = c.id;
      end if;
      -- Передача информации о прохождении заявки
      if c.transfer_type = 7 then
        begin
          bars_zay.service_track_request(c.req_id);
         exception  when no_data_found then
           delete from zay_data_transfer where id = c.id;
        end;
        delete from zay_data_transfer where id = c.id;
      end if;
      -- Визирование заявки
      if c.transfer_type = 3 then
        begin
          bars_zay.service_request(p_reqest_id => c.req_id, p_flag_klb => 3);
         exception  when no_data_found then
           delete from zay_data_transfer where id = c.id;
        end;
        delete from zay_data_transfer where id = c.id;
      end if;
    -- Передача денег по заявке
      if c.transfer_type = 6 then
        begin
          select ref_sps into l_ref from zayavka where id = c.req_id;
          bars_zay.p_reqest_set_refsps(p_id => c.req_id, p_ref_sps => l_ref);
         exception  when no_data_found then
           delete from zay_data_transfer where id = c.id;
        end;
        delete from zay_data_transfer where id = c.id;
      end if;

    end loop;
  end if;
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ZAY_RETRANSMISSION_DATA.sql ====
PROMPT ===================================================================================== 
