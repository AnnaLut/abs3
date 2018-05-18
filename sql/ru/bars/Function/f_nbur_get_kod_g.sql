CREATE OR REPLACE FUNCTION BARS.f_nbur_get_kod_g(p_ref in number, p_type in number) return varchar2
 -------------------------------------------------------------------
 -- функція визначення код країни отримувача/платника
 -------------------------------------------------------------------
 -- ВЕРСИЯ: 27/04/2018 (28/02/2018)
 -------------------------------------------------------------------
 -- параметри:
 --    p_ref - референс документу
 --    p_type = 1- код країни платника
 --           = 2- код країни отримувача
 ----------------------------------------------------------------
is
    l_kod_g     varchar2(3) := null;
    l_kod_g_inp varchar2(3) := null;
    
    l_swift_k   varchar2 (12);
begin
   for k in (select ref, trim(tag) tag, trim(value) value from operw where ref = p_ref order by ref, trim(tag))
   loop
      -- с 01.08.2012 добавляется код страны отправителя или получателя перевода
      if k.tag like 'n%' and substr(trim(k.value),1,1) in ('O','P','О','П')
      then
         l_kod_g := substr(trim(k.value),2,3);
      end if;

      if k.tag like 'n%' and substr(trim(k.value),1,1) not in ('O','P','О','П')
      then
         l_kod_g := substr(trim(k.value),1,3);
      end if;

      if l_kod_g_inp is null and k.tag like 'D6#70%' and substr(trim(k.value),1,1) in ('O','P','О','П')
      then
         l_kod_g_inp := substr(trim(k.value),2,3);
      end if;

      if l_kod_g_inp is null and k.tag like 'D6#70%' and substr(trim(k.value),1,1) not in ('O','P','О','П')
      then
         l_kod_g_inp := substr(trim(k.value),1,3);
      end if;

      if l_kod_g_inp is null and k.tag like 'D6#E2%' and substr(trim(k.value),1,1) in ('O','P','О','П')
      then
         l_kod_g_inp := substr(trim(k.value),2,3);
      end if;

      if l_kod_g_inp is null and k.tag like 'D6#E2%' and substr(trim(k.value),1,1) not in ('O','P','О','П')
      then
         l_kod_g_inp := substr(trim(k.value),1,3);
      end if;

      if l_kod_g_inp is null and k.tag like 'D1#E9%' and substr(trim(k.value),1,1) in ('O','P','О','П')
      then
         l_kod_g_inp := substr(trim(k.value),2,3);
      end if;

      if l_kod_g_inp is null and k.tag like 'D1#E9%' and substr(trim(k.value),1,1) not in ('O','P','О','П')
      then
         l_kod_g_inp := substr(trim(k.value),1,3);
      end if;

      if l_kod_g_inp is null and k.tag like 'F1%'
      then
         l_kod_g_inp := substr(trim(k.value),8,3);
      end if;

      if l_kod_g_inp is null and k.tag like 'KOD_G' and trim(k.value) is not null
      then
         l_kod_g_inp := substr(trim(k.value),1,3);
      end if;
      
      if p_type = 1 then
          -- код країни платника
          if l_kod_g is null and k.tag like '50F%' then
              if instr(upper(trim(k.value)),'3/UA') > 0
              then
                 l_kod_g := '804';
              else
                 l_swift_k := substr(trim(k.value), instr(UPPER(trim(k.value)),'3/')+2, 2);

                 BEGIN
                     SELECT max(k040)
                        INTO l_kod_g
                     FROM KL_K040
                     WHERE A2 LIKE l_swift_k||'%'
                       AND ROWNUM = 1;
                 exception
                    when no_data_found then
                        null;
                 end;
              end if;
          end if;

          if l_kod_g is null and k.tag like '52A%' then
              if length(trim(k.value)) between 3 and 11 then
                 l_swift_k := substr(trim(k.value), 1, 11);
                 
                 BEGIN
                     SELECT k040
                        INTO l_kod_g
                     FROM RC_BNK
                     WHERE (SWIFT_CODE LIKE l_swift_k||'%' or 
                            SWIFT_CODE LIKE substr(l_swift_k,1,4)||' '||
                                            substr(l_swift_k,5,2)||' '||
                                            substr(l_swift_k,7,2)||'%')
                       AND ROWNUM = 1;
                 EXCEPTION WHEN NO_DATA_FOUND THEN
                    null;
                 end;
                 
                 if l_kod_g is null and l_swift_k is not null then
                     BEGIN
                         select max(k.k040)
                            INTO l_kod_g
                         from SW_BANKS s, kl_k040 k
                         where s.bic like l_swift_k || '%' and
                               upper(s.country) =  upper(k.txt_eng) and
                               k.d_close is null;
                     EXCEPTION WHEN NO_DATA_FOUND THEN
                        null;
                     end;  
                 end if;            
              elsif length(trim(k.value)) > 11 then
                 for p in (select tag, value 
                           from operw 
                           where ref = k.ref and 
                                 tag like 'C%' and 
                                 value like 'F52A:%' and
                                 value not like 'F52A:/%')
                 loop
                    l_swift_k := substr(trim(p.value), 6, 10);
                    
                     BEGIN
                         SELECT k040
                            INTO l_kod_g
                         FROM RC_BNK
                         WHERE (SWIFT_CODE LIKE l_swift_k||'%' or 
                                SWIFT_CODE LIKE substr(l_swift_k,1,4)||' '||
                                                substr(l_swift_k,5,2)||' '||
                                                substr(l_swift_k,7,2)||'%')
                           AND ROWNUM = 1;
                           
                           if trim(l_kod_g) is not null then exit; end if;
                     EXCEPTION WHEN NO_DATA_FOUND THEN
                        null;
                     end;

                     if l_kod_g is null and l_swift_k is not null then
                         BEGIN
                             select max(k.k040)
                                INTO l_kod_g
                             from SW_BANKS s, kl_k040 k
                             where s.bic like l_swift_k || '%' and
                                   upper(s.country) =  upper(k.txt_eng) and
                                   k.d_close is null;
                         EXCEPTION WHEN NO_DATA_FOUND THEN
                            null;
                         end;  
                     end if;   
                 end loop;
              end if;
          end if;

          if l_kod_g is null and k.tag like '52D%' then
              for p in (select tag, value 
                        from operw 
                        where ref = k.ref and 
                              tag like 'C%' and 
                              value like 'F52D://%')
                 loop
                     l_swift_k := substr(trim(p.value), 8, 2);

                     BEGIN
                         SELECT max(k040)
                            INTO l_kod_g
                         FROM KL_K040
                         WHERE A2 LIKE l_swift_k||'%'
                           AND ROWNUM = 1;
                     exception
                        when no_data_found then
                            null;
                     end;
                 end loop;
          end if;
      else    
          -- кодкраїни отримувача 
          IF l_kod_g is null and k.tag like '59%'
          THEN
             if instr(k.value, '/UA') > 0 or
                instr(k.value, 'UA-') > 0 or  
                instr(UPPER(trim(k.value)),'UKRAINE') > 0 then
                l_kod_g := '804';
             else
                l_swift_k := substr(trim(k.value), instr(UPPER(trim(k.value)),'3/')+2, 2);

                 BEGIN
                     SELECT max(k040)
                        INTO l_kod_g
                     FROM KL_K040
                     WHERE A2 LIKE l_swift_k||'%'
                       AND ROWNUM = 1;
                 exception
                    when no_data_found then
                        null;
                 end;
             end if;
          END IF;
      end if;
   end loop;
   
   -- приорітетом є введені чи змінені вручну
   if nvl(l_kod_g_inp, '804') <> '804' or l_kod_g is null then
      return trim(lpad(l_kod_g_inp, 3, '0'));
   else
      return trim(lpad(l_kod_g, 3, '0'));
   end if;
end;
/
