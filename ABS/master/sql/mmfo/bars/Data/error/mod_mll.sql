PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_MLL.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR модуль MLL ***
declare
  l_mod  varchar2(3) := 'MLL';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'Ядро. Работа с почтовыми сообщениями', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'Функция вычитки сообшений временно приостановлена. Для включения отправки сообщений - активируйье oracle очередь bars_mail_queue на операцию DEQUE', '', 1, 'DEQUEUE_IS_DISABLED');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'Функция вычитки сообшений временно приостановлена. Для включения отправки сообщений - активируйье oracle очередь bars_mail_queue на операцию DEQUE', '', 1, 'DEQUEUE_IS_DISABLED');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_MLL.sql =========*** Run *** ==
PROMPT ===================================================================================== 
