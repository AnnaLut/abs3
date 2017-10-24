

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_TMP_PRIOCOM_CLIENTS.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_TMP_PRIOCOM_CLIENTS ***

  CREATE OR REPLACE TRIGGER BARS.TAI_TMP_PRIOCOM_CLIENTS 
  AFTER INSERT ON "BARS"."TMP_PRIOCOM_CLIENTS"
  REFERENCING FOR EACH ROW
  begin
  priocom_audit.trace('insert into tmp_priocom_clients('||chr(10)||
'  	mfo,'||chr(10)||
'	kod_fil,'||chr(10)||
'	ident,'||chr(10)||
'	lname,'||chr(10)||
'	fname,'||chr(10)||
'	sname,'||chr(10)||
'	birthday,'||chr(10)||
'	birthplace,'||chr(10)||
'	isStockholder,'||chr(10)||
'	isVIP,'||chr(10)||
'	isResident,'||chr(10)||
'	regdate,'||chr(10)||
'	debtorclass,'||chr(10)||
'	gender,'||chr(10)||
'	addr,'||chr(10)||
'	k040,'||chr(10)||
'	k060,'||chr(10)||
'	paspdouble,'||chr(10)||
'	paspseries,'||chr(10)||
'	paspdate,'||chr(10)||
'	paspissuer'||chr(10)||
')'||chr(10)||
'values('||chr(10)||
'   '''||nvl(:new.mfo,'NULL')||''','||chr(10)||
'	'||nvl(to_char(:new.kod_fil),'NULL')||','||chr(10)||
'	'''||nvl(:new.ident,'NULL')||''','||chr(10)||
'	'''||nvl(:new.lname,'NULL')||''','||chr(10)||
'	'''||nvl(:new.fname,'NULL')||''','||chr(10)||
'	'''||nvl(:new.sname,'NULL')||''','||chr(10)||
'	to_date('''||nvl(to_char(:new.birthday,'dd/mm/yyyy'),'NULL')||''',''dd/mm/yyyy''),'||chr(10)||
'	'''||nvl(:new.birthplace,'NULL')||''','||chr(10)||
'	'||nvl(to_char(:new.isStockholder),'NULL')||','||chr(10)||
'	'||nvl(to_char(:new.isVIP),'NULL')||','||chr(10)||
'	'||nvl(to_char(:new.isResident),'NULL')||','||chr(10)||
'	to_date('''||nvl(to_char(:new.regdate,'dd/mm/yyyy'),'NULL')||''',''dd/mm/yyyy''),'||chr(10)||
'	'||nvl(to_char(:new.debtorclass),'NULL')||','||chr(10)||
'	'''||nvl(:new.gender,'NULL')||''','||chr(10)||
'	'''||nvl(:new.addr,'NULL')||''','||chr(10)||
'	'''||nvl(:new.k040,'NULL')||''','||chr(10)||
'	'''||nvl(:new.k060,'NULL')||''','||chr(10)||
'	'''||nvl(:new.paspdouble,'NULL')||''','||chr(10)||
'	'''||nvl(:new.paspseries,'NULL')||''','||chr(10)||
'	to_date('''||nvl(to_char(:new.paspdate,'dd/mm/yyyy'),'NULL')||''',''dd/mm/yyyy''),'||chr(10)||
'	'''||nvl(:new.paspissuer,'NULL')||''')'
  );
end;



/
ALTER TRIGGER BARS.TAI_TMP_PRIOCOM_CLIENTS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_TMP_PRIOCOM_CLIENTS.sql ========
PROMPT ===================================================================================== 
