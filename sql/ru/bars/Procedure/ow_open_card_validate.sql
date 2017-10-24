create or replace procedure ow_open_card_validate(rnk        in number,
                                                  nls        in varchar2,
                                                  card_code  in varchar2,
                                                  branch     in varchar2,
                                                  first_name in varchar2,
                                                  last_name  in varchar2,
												  sec_name   in varchar2,
                                                  chboxsms   in number default 1,
                                                  res_code   out number,
                                                  res_text   out varchar2) is
  l_nd    number;
  l_reqid number;
  invalid_ascii constant varchar2(32) := chr(00) || chr(01) || chr(02) ||
                                         chr(03) || chr(04) || chr(05) ||
                                         chr(06) || chr(07) || chr(08) ||
                                         chr(10) || chr(11) || chr(12) ||
                                         chr(13) || chr(14) || chr(15) ||
                                         chr(16) || chr(17) || chr(18) ||
                                         chr(19) || chr(20) || chr(21) ||
                                         chr(22) || chr(23) || chr(24) ||
                                         chr(25) || chr(26) || chr(27) ||
                                         chr(28) || chr(29) || chr(30) ||
                                         chr(31);
  l_branch varchar2(30);
  g_w4_engname_char constant varchar2(100) := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890/-. ';
  l_name_err varchar2(250);
begin

  res_code := 0;
  res_text := null;

  begin
    l_branch := branch;
  
    select branch into l_branch from branch where branch = l_branch;
  exception
    when others then
      raise_application_error(-20000, 'Не вказано віддлення');
  end;

  l_name_err := translate(translate(first_name, g_w4_engname_char, chr(1)),
                          chr(0) || chr(1), ' ');

  if length(trim(l_name_err)) > 0 then
    raise_application_error(-20000, 'Назва компанії на картці(Англ.) містить не допустимі символи ' || l_name_err);
  end if;

  bars_ow.open_card(p_rnk          => rnk,
                    p_nls          => nls,
                    p_cardcode     => card_code,
                    p_branch       => branch,
                    p_embfirstname => first_name,
                    p_emblastname  => last_name,
                    p_secname      => sec_name,
                    p_work         => null,
                    p_office       => null,
                    p_wdate        => null,
                    p_salaryproect => null,
                    p_term         => null,
                    p_branchissue  => branch,
                    p_barcode      => null,
                    p_cobrandid    => null,
                    p_sendsms      => chboxsms,
                    p_nd           => l_nd,
					p_reqid        => l_reqid);

exception
  when others then
  
    res_code := -1;
    res_text := substr(translate(translate(dbms_utility.format_error_stack(),
                                           invalid_ascii, chr(1)), chr(0) || chr(1), ' '), 11, 500);
  
end;
/
grant execute on BARS.ow_open_card_validate to bars_access_defrole;
/
