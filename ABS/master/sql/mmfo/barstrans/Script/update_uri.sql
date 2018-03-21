begin
    update barstrans.transp_uri t
    set    t.base_host = 'https://mmfo-web.oschadbank.ua/barsroot/'
    where  t.kf in ('300465');

    commit;
end;
/
