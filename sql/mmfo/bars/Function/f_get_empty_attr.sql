
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_empty_attr.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_EMPTY_ATTR (p_rnk number) return varchar2
is
  l_msg    varchar2(2000) := null;
  l_cust   customer%rowtype;
  l_person person%rowtype;
  l_adr    customer_address%rowtype;
  procedure add_msg (i_str varchar2)
  is
  begin
     l_msg := case when l_msg is null then i_str
                   else l_msg || chr(10) || i_str
              end;
  end;
  procedure check_attr (i_value varchar2, i_name varchar2) is
  begin
     if i_value is null then add_msg(i_name); end if;
  end;
  procedure check_attr (i_value number, i_name varchar2) is
  begin
     if i_value is null then add_msg(i_name); end if;
  end;
  procedure check_attr (i_value date, i_name varchar2) is
  begin
     if i_value is null then add_msg(i_name); end if;
  end;
begin

  begin
     select c.* into l_cust
       from customer c
      where c.rnk = p_rnk;
     -- рекв. клиента
     check_attr(l_cust.country, 'Країна');
     check_attr(l_cust.nmk, 'Найменування клієнта (нац.)');
     check_attr(l_cust.nmkv, 'Найменування (міжн.)');
     check_attr(l_cust.okpo, 'Ідентифікаційний код');
     check_attr(l_cust.adm, 'Адм. орган реєстрації');
     check_attr(l_cust.rgtax, 'Реєстр. номер у ПІ');
     check_attr(l_cust.datet, 'Дата реєстр. у ПІ');
     check_attr(l_cust.datea, 'Дата реєстр. у Адм.');
     -- адрес
     begin
        select * into l_adr from customer_address where rnk = p_rnk and type_id = 1;
        check_attr(l_adr.locality, 'Населений пункт (значення)');
        check_attr(l_adr.street, 'вул., просп., б-р. (значення)');
        check_attr(l_adr.home, '№ буд., д/в (значення)');
     exception when no_data_found then null;
     end;
     check_attr( kl.get_customerw(p_rnk, 'K013 '), 'Код виду клієнта (K013)');
     -- рекв. ФЛ
     if l_cust.custtype = 3 then
        check_attr(trim(l_cust.ise), 'Інст. сектор економіки (К070)');
        check_attr(trim(l_cust.fs), 'Форма власності (К080)');
        check_attr(trim(l_cust.ved), 'Вид ек. діяльності(К110)');
        check_attr(trim(l_cust.k050), 'Форма господарювання (К050)');
        begin
           select * into l_person from person where rnk = p_rnk;
           check_attr(l_person.passp , 'Вид документу');
           check_attr(l_person.ser, 'Серія');
           check_attr(l_person.numdoc, 'Номер док.');
           check_attr(l_person.organ, 'Ким виданий');
           check_attr(l_person.pdate, 'Коли виданий');
           check_attr(l_person.bday, 'Дата народження');
           check_attr(l_person.sex, 'Стать');
           check_attr(l_person.teld, 'Дом. тел.');
        exception when no_data_found then null;
        end;
        check_attr(kl.get_customerw(p_rnk, 'MPNO '), 'Моб. тел.');
        check_attr(kl.get_customerw(p_rnk, 'GR   '), 'Громадянство');
        check_attr(kl.get_customerw(p_rnk, 'DATZ '), 'Дата первинного заповнення анкети');
        check_attr(kl.get_customerw(p_rnk, 'IDDPR'), 'Дата проведеної iдентифiкацiї/уточнення інформації');
        check_attr(kl.get_customerw(p_rnk, 'ID_YN'), 'Ідентифікація клієнта проведена');
        check_attr(kl.get_customerw(p_rnk, 'O_REP'), 'Оцінка репутації клієнта');
        check_attr(kl.get_customerw(p_rnk, 'IDPIB'), 'ПІБ та тел. працівника, відповідальн. за ідент-цію і вивчення клієнта');
        check_attr(kl.get_customerw(p_rnk, 'DJER '), 'Характеристика джерел надходжень коштiв');
        check_attr(kl.get_customerw(p_rnk, 'CIGPO') ,'Статус зайнятості особи');
     -- ЮЛ-резидент
     elsif mod(l_cust.codcagent, 2) = 1 then
        check_attr(trim(l_cust.ise), 'Інст. сектор економіки (К070)');
        check_attr(trim(l_cust.fs), 'Форма власності (К080)');
        check_attr(trim(l_cust.ved), 'Вид ек. діяльності(К110)');
        check_attr(trim(l_cust.k050), 'Форма господарювання (К050)');
        check_attr(kl.get_customerw(p_rnk, 'UUCG '), 'Обсяг чистого доходу за календарний рік, що закінчився');
        check_attr(kl.get_customerw(p_rnk, 'UUDV '), 'Частка державної власності');
     end if;
  exception when no_data_found then null;
  end;
  return l_msg;
end f_get_empty_attr;
/
 show err;
 
PROMPT *** Create  grants  F_GET_EMPTY_ATTR ***
grant EXECUTE                                                                on F_GET_EMPTY_ATTR to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_empty_attr.sql =========*** E
 PROMPT ===================================================================================== 
 