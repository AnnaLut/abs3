begin
  for rec in (select *
                from ps_tts p
               where p.nbs in (select t.old_nbs from TMP_UPDATE_PS_TTS t)
                 and p.ob22 is null) loop
    for rec_2 in (select regexp_substr(new_nbs, '[^,]+', 1, level) as nbs
                    from (select new_nbs
                            from TMP_UPDATE_PS_TTS t
                           where t.old_nbs = rec.nbs)
                  connect by regexp_substr(new_nbs, '[^,]+', 1, level) is not null) loop
      begin
        --Пробуем инсертить
        insert into ps_tts
          (id, tt, nbs, dk, ob22)
        values
          (rec.id, rec.tt, rec_2.nbs, rec.dk, rec.ob22);
      exception
        when others then
          begin
            -- апдейтим если такая запись уже есть
            update ps_tts s
               set s.nbs = rec_2.nbs
             where s.id = rec.id
               and s.tt = rec.tt;
          EXCEPTION
            --избегаем дублей
            WHEN DUP_VAL_ON_INDEX THEN
              null;
          end;
      end;
    end loop;
  end loop;
end;
/
Drop table TMP_UPDATE_PS_TTS;

commit;
