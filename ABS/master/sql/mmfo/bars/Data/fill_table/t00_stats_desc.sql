begin 
   begin insert into bars.t00_stats_desc values(1, 1, 'DB', 'Всього деб. оборотів по-документно');         exception when dup_val_on_index then null; end;
   begin insert into bars.t00_stats_desc values(2, 2, 'DB', 'Списання на клієнтські рахунки із СЕП/ВПС');  exception when dup_val_on_index then null; end;
   begin insert into bars.t00_stats_desc values(3, 3, 'DB', 'Списання коштiв для файлу $A в СЕП/ВПС');     exception when dup_val_on_index then null; end;
   begin insert into bars.t00_stats_desc values(4, 4, 'DB', 'Списання при розформуванні файлу $A');        exception when dup_val_on_index then null; end;
   begin insert into bars.t00_stats_desc values(5, 5, 'DB', 'Інші (позарегламентні) списання');            exception when dup_val_on_index then null; end;
   begin insert into bars.t00_stats_desc values(6, 1, 'KR', 'Всього кред. оборотів по-документно');        exception when dup_val_on_index then null; end;
   begin insert into bars.t00_stats_desc values(7, 2, 'KR', 'Зарахування вихідних документів в $A:');      exception when dup_val_on_index then null; end;
   begin insert into bars.t00_stats_desc values(8, 3, 'KR', 'Зарахування вхідних докумнетів $B');          exception when dup_val_on_index then null; end;
   begin insert into bars.t00_stats_desc values(9, 4, 'KR', 'Зарахування розформованих документів $A');    exception when dup_val_on_index then null; end;
   begin insert into bars.t00_stats_desc values(10, 5,'KR', 'Інші (позарегламентні) зарахування');         exception when dup_val_on_index then null; end;
   begin insert into bars.t00_stats_desc values(22, 1, 'OST_BLKIN', 'пусто');                              exception when dup_val_on_index then null; end;
   begin insert into bars.t00_stats_desc values(23, 2, 'OST_BLKIN', '0');                                  exception when dup_val_on_index then null; end;
   begin insert into bars.t00_stats_desc values(24, 3, 'OST_BLKOUT', 'пусто');                             exception when dup_val_on_index then null; end;   
   begin insert into bars.t00_stats_desc values(25, 4, 'OST_BLKOUT', '1');                                 exception when dup_val_on_index then null; end;
   begin insert into bars.t00_stats_desc values(26, 5, 'OST_OTHER', 'Невідомі суми');                      exception when dup_val_on_index then null; end;
end;
/

commit;




