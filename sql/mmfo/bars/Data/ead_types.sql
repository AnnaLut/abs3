PROMPT *** Refresh data ead_types ***

set constraints all deferred;

delete from ead_types;

insert into ead_types (ID, NAME, METHOD, MSG_LIFETIME, MSG_RETRY_INTERVAL)
values ('DICT', 'Довідник', 'SetDictionaryData', 4320, 5);

insert into ead_types (ID, NAME, METHOD, MSG_LIFETIME, MSG_RETRY_INTERVAL)
values ('CLIENT', 'Клієнт', 'SetClientData', 4320, 5);

insert into ead_types (ID, NAME, METHOD, MSG_LIFETIME, MSG_RETRY_INTERVAL)
values ('UCLIENT', 'клiент - Юр.особа', 'SetClientDataU', 4320, 5);

insert into ead_types (ID, NAME, METHOD, MSG_LIFETIME, MSG_RETRY_INTERVAL)
values ('ACC', 'Рахунок Фіз.особи', 'SetAccountData', 4320, 5);

insert into ead_types (ID, NAME, METHOD, MSG_LIFETIME, MSG_RETRY_INTERVAL)
values ('UACC', 'Рахунок Юр.особи', 'SetAccountDataU', 4320, 5);

insert into ead_types (ID, NAME, METHOD, MSG_LIFETIME, MSG_RETRY_INTERVAL)
values ('AGR', 'Угода', 'SetAgreementData', 4320, 5);

insert into ead_types (ID, NAME, METHOD, MSG_LIFETIME, MSG_RETRY_INTERVAL)
values ('UAGR', 'Угода Юр.особи', 'SetAgreementDataU', 4320, 5);

insert into ead_types (ID, NAME, METHOD, MSG_LIFETIME, MSG_RETRY_INTERVAL)
values ('ACT', 'Актуалізація ідент. документів', 'ActualizeIdDocs', 4320, 5);

insert into ead_types (ID, NAME, METHOD, MSG_LIFETIME, MSG_RETRY_INTERVAL)
values ('DOC', 'Надрукований документ', 'SetDocumentData', 4320, 5);

commit work;