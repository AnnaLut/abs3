CREATE OR REPLACE procedure BARS.P_zay_val_control_do  (
       p_iddo     varchar2,/* I -insert, E- end ,R-повернення,  UM - оновити при розбитті заявки */
       p_zay_id   number,
       p_sum      number          default null,
       p_basis    varchar2        default null,
       p_viza     integer         default null
)
is
       l_rnk      customer.rnk%type;
       l_nmk      customer.nmk%type;
       l_okpo     customer.okpo%type;
       l_SER      person.ser%type;
       l_numdoc   person.numdoc%type;
       l_custtype CUSTOMER.CUSTTYPE%type;
       l_request  zayavka%rowtype;
       l_suma_eq  number;--еквівалент суми заявки
begin
 /*
 06,02,2019: 
   'I'  -  вставка заявки
   'D'  -  видалення заявки
   'E'  -  оновдення статуса кінцеве в zay52
   'UM' -  оновлення статусів заявки при розділенні заявки ділером
   'R'  -  оновлення статусів заявки при поверненні
 30.01.2019 v. 4
 */

       if p_iddo = 'I'
       then
          select *
          into   l_request
          from   zayavka
          where  id = p_zay_id;

         --INSERT
         l_suma_eq := gl.p_icurval(l_request.kv2,
                                   l_request.s2,
                                   trunc(SYSDATE));
         begin
           --пошукаємо клієнта всюди
           select c.rnk, c.nmk, c.okpo, p.SER, p.numdoc, C.CUSTTYPE
           into   l_rnk, l_nmk, l_okpo, l_SER, l_numdoc, l_custtype
           from   customer c
           left   join person p
           on     (p.rnk = c.rnk)
           where  c.rnk = l_request.rnk and c.date_off is null;
--         exception
--           when no_data_found then
--             bc.go(l_request.mfo);
--             select c.rnk, c.nmk, c.okpo, p.SER, p.numdoc
--             into   l_rnk, l_nmk, l_okpo, l_SER, l_numdoc
--             from   customer c
--             left   join person p
--             on     (p.rnk = c.rnk)
--             where  c.rnk = l_request.rnk
--                    and c.kf = l_request.mfo;
--             bc.go('300465');
         end;
          ----------------------------------
          INSERT INTO zay_val_control(
          ZAY_ID,
          ZAY_DATE,
          SOS,
          VIZA,
          RNK,
          NMK,
          OKPO,
          SER_PASP,
          NOM_PASP,
          SUMMA_VAL,
          KV2,
          RATE_O,
          SUMMA,
          MFO,
          BRANCH,
          custtype,
          f092
          )
          VALUES (
          p_zay_id,
          trunc(sysdate),
          0,
          1,
          l_rnk,
          l_nmk,
          l_okpo,
          l_SER,
          l_numdoc,
          l_request.s2,
          l_request.kv2,
          BARS.f_ret_kurs(l_request.kv2, trunc(sysdate)),
          l_suma_eq,
          l_request.kf,
          l_request.branch,
          l_custtype,
          l_request.f092
             );
       end if;

       if p_iddo='D' then --DELETE
          -- update zay_val_control set sos=-1,viza=-1 where ZAY_ID=p_zay_id;
          delete from zay_val_control where ZAY_ID=p_zay_id;
       end if;

       if p_iddo='E' then --ZAY52 Візування курсу дилера
           update zay_val_control set sos=1,viza=2 ,zay_date_v=trunc(sysdate) where ZAY_ID=p_zay_id;
       end if;

       if p_iddo='UM' then --ZAY42 Розбиття заявки, стару треба проапдейтити
        --
           update zay_val_control set sos=-1,viza=2 where ZAY_ID = p_zay_id;
       end if;
       
       if p_iddo='R' then --повернення
           update zay_val_control set sos=0,viza=p_viza where ZAY_ID = p_zay_id;
       end if;
end;
/
