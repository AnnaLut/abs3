update passp p 
set p.NRF = 'Паспорт громадянина України у вигляді книжечки',
    p.name = 'Паспорт гр.України у вигляді книжки'
where p.passp = 1;

commit;

update passp p 
set p.NRF = 'Паспорт громадянина України у вигляді картки',
    p.name = 'Паспорт гр.України у вигляді картки'
where p.passp = 7;

commit;