
PROMPT ===================================================================================== 
PROMPT *** Run *** ========= Scripts /Sql/BARS/Function/F_NBUR_GET_K020_by_RNK.sql =========
PROMPT ===================================================================================== 

 CREATE OR REPLACE function BARS.F_NBUR_GET_K020_by_RNK( p_rnk number )
       return varchar2
 -------------------------------------------------------------------
 -- функция вычисления параметров клиента K020/K021
 -------------------------------------------------------------------
 -- ВЕРСИЯ: 04.10.2018
 -------------------------------------------------------------------
 -- параметр:
 --    p_rnk   - код клиента
 -- 
 -- возвращаемое значение:
 --    строка вида  K021||K020
 ----------------------------------------------------------------
   is

     l_k020    varchar2(20);
     l_k021    varchar2(1);

     l_codag   varchar2(1);
     l_okpo    varchar2(10);
     l_glb     varchar2(10);
     l_ise     customer.ise%TYPE;
     l_vid_doc        integer;

begin
     l_codag := null;

     begin
       select codcagent, okpo, ise
         into l_codag, l_okpo, l_ise
         from customer
        where rnk = p_rnk;
     exception
       when others  then l_codag :=null;
     end;

     if l_codag is not null  then

        if      l_codag =1  then              -- банки-резиденти

              begin
                  select lpad( to_char(nvl(rc.glb,0)), 10,'0')      into l_k020
                    from custbank cb, rcukru rc
                   where cb.rnk = p_rnk
                     and cb.mfo = rc.mfo(+);

              exception
                 when no_data_found then
                    l_k020 :='0000000000';
              end;
              l_k021 :='3';

        elsif   l_codag =2  then              -- банки-нерезиденти

              begin
                  select lpad( nvl(cb.alt_bic,'0'), 10,'0')      into l_k020
                    from custbank cb
                   where cb.rnk = p_rnk;

              exception
                 when no_data_found then
                    l_k020 :='0000000000';
              end;
              l_k021 :='4';

              if p_rnk = 90040601           -- кб евростраст москва
              then
                  l_k020 := 'I' || LPAD (TO_CHAR (p_rnk), 9,'0');
                  l_k021 := '9';
              end if;

        elsif   l_codag =3  then              -- юр.особи-резиденти

            -- наличие ИНН(ОКПО)
            IF nvl(ltrim(trim(l_okpo), '0'), 'Z') <> 'Z' AND
               nvl(ltrim(trim(l_okpo), '9'), 'Z') <> 'Z'
            THEN
               l_k020 := LPAD (l_okpo, 10,'0');
               l_k021 := '1';

               if l_ise in ('13110','13120','13131','13132')
               then
                  l_k021 := 'G';
               end if;
            ELSE
            -- отсутствие ИНН(ОКПО)
               l_k020 := LPAD (to_char (p_rnk), 10,'0');
               l_k021 := 'E';
            END IF;

        elsif   l_codag =4  then              -- юр.особи-нерезиденти

            -- наличие ИНН(ОКПО)
            IF nvl(ltrim(trim(l_okpo), '0'), 'Z') <> 'Z' AND
               nvl(ltrim(trim(l_okpo), '9'), 'Z') <> 'Z'
            THEN
               l_k020 := LPAD (l_okpo, 10, '0');
               l_k021 := '1';
            ELSE
            -- отсутствие ИНН(ОКПО)
               l_k020 := 'I' || LPAD (TO_CHAR (p_rnk), 9, '0');
               l_k021 := 'C';
            END IF;

        elsif   l_codag =5  then              -- фiз.особи-резиденти

            -- наличие ИНН(ОКПО)
            IF nvl(ltrim(trim(l_okpo), '0'), 'Z') <> 'Z' AND
               nvl(ltrim(trim(l_okpo), '9'), 'Z') <> 'Z'
            THEN
               l_k020 := LPAD (l_okpo, 10, '0');
               l_k021 := '2';
            ELSE
            -- отсутствие ИНН(ОКПО)
               BEGIN
                  SELECT LPAD (SUBSTR (TRIM (ser) || TRIM (numdoc), 1, 10),
                                 10, '0'  ), passp
                    INTO l_k020, l_vid_doc
                    FROM person
                   WHERE rnk = p_rnk;
                   if l_vid_doc =3  then 
                                l_k021  := 'A';    --k020 T
                   else         l_k021  := '6';
                   end if;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     l_k020 := LPAD (p_rnk, 10,'0');
                     l_k021 := '9';
               END;
            END IF;

        elsif   l_codag =6  then              -- фiз.особи-нерезиденти

            -- наличие ИНН(ОКПО)
            IF nvl(ltrim(trim(l_okpo), '0'), 'Z') <> 'Z' AND
               nvl(ltrim(trim(l_okpo), '9'), 'Z') <> 'Z'
            THEN
               l_k020 := LPAD (l_okpo, 10, '0');
               l_k021 := '2';
            ELSE
            -- отсутствие ИНН(ОКПО)
               BEGIN
                  SELECT 'I' || LPAD (SUBSTR (TRIM (ser) || TRIM (numdoc), 1, 9),
                               9, '0' )
                    INTO l_k020
                    FROM person
                   WHERE rnk = p_rnk;
                   l_k021 := 'B';
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     l_k020 := 'I' || LPAD (TO_CHAR (p_rnk), 9, '0');
                     l_k021 := '9';
               END;
            END IF;

        else

            l_k021 :='0';
        end if;

     else
        l_k021 :='0';
     end if;

     return l_k021||l_k020;
end;
/

PROMPT ===================================================================================== 
PROMPT *** Run *** ========= Scripts /Sql/BARS/Function/F_NBUR_GET_K020_by_RNK.sql =========
PROMPT ===================================================================================== 
