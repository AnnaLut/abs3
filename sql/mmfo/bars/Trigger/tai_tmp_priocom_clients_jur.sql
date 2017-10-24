

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAI_TMP_PRIOCOM_CLIENTS_JUR.sql ====
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAI_TMP_PRIOCOM_CLIENTS_JUR ***

  CREATE OR REPLACE TRIGGER BARS.TAI_TMP_PRIOCOM_CLIENTS_JUR 
  AFTER INSERT ON "BARS"."TMP_PRIOCOM_CLIENTS_JUR"
  REFERENCING FOR EACH ROW
  begin
  priocom_audit.trace('insert into tmp_priocom_clients_jur('||chr(10)||
'  	mfo,'||chr(10)||
'	kod_fil,'||chr(10)||
'	okpo,'||chr(10)||
'	sysname,'||chr(10)||
'	name,'||chr(10)||
'	isStockholder,'||chr(10)||
'	isVIP,'||chr(10)||
'	regdate,'||chr(10)||
'	createdate,'||chr(10)||
'	isBudgetorg,'||chr(10)||
'	isResident,'||chr(10)||
'	debtorclass,'||chr(10)||
'	legaladdr_postind,'||chr(10)||
'	legaladdr,'||chr(10)||
'	legaladdr_phone,'||chr(10)||
'	legaladdr_fax,'||chr(10)||
'	legaladdr_email,'||chr(10)||
'	addr_postind,'||chr(10)||
'	addr,'||chr(10)||
'	fiodirector,'||chr(10)||
'	okpodirector,'||chr(10)||
'	posdirector,'||chr(10)||
'	statut,'||chr(10)||
'	signdirector,'||chr(10)||
'	descriptiondirector,'||chr(10)||
'	fiosyn,'||chr(10)||
'	okposyn,'||chr(10)||
'	possyn,'||chr(10)||
'	signsyn,'||chr(10)||
'	descriptionsyn,'||chr(10)||
'	k050,'||chr(10)||
'	k060,'||chr(10)||
'	k070,'||chr(10)||
'	k080,'||chr(10)||
'	k090,'||chr(10)||
'	k110,'||chr(10)||
'	k120,'||chr(10)||
'	smallbis,'||chr(10)||
'	taxadminnum,'||chr(10)||
'	taxregionnum,'||chr(10)||
'	govermentpart,'||chr(10)||
'	salestaxcode,'||chr(10)||
'	taxform,'||chr(10)||
'	taxdolg,'||chr(10)||
'	taxorg,'||chr(10)||
'	taxnum,'||chr(10)||
'	taxregdate,'||chr(10)||
'	pubadminnum,'||chr(10)||
'	pubadmindate,'||chr(10)||
'	pubadminplace,'||chr(10)||
'	fiofounder,'||chr(10)||
'	okpofounder,'||chr(10)||
'	reltype,'||chr(10)||
'	description'||chr(10)||
')'||chr(10)||
'values('||chr(10)||
'   '''||nvl(:new.mfo,'NULL')||''','||chr(10)||
'	'||nvl(to_char(:new.kod_fil),'NULL')||','||chr(10)||
'	'''||nvl(:new.okpo,'NULL')||''','||chr(10)||
'	'''||nvl(:new.sysname,'NULL')||''','||chr(10)||
'	'''||nvl(:new.name,'NULL')||''','||chr(10)||
'	'||nvl(to_char(:new.isStockholder),'NULL')||','||chr(10)||
'	'||nvl(to_char(:new.isVIP),'NULL')||','||chr(10)||
'	to_date('''||nvl(to_char(:new.regdate,'dd/mm/yyyy'),'NULL')||''',''dd/mm/yyyy''),'||chr(10)||
'	to_date('''||nvl(to_char(:new.createdate,'dd/mm/yyyy'),'NULL')||''',''dd/mm/yyyy''),'||chr(10)||
'	'||nvl(to_char(:new.isBudgetorg),'NULL')||','||chr(10)||
'	'||nvl(to_char(:new.isResident),'NULL')||','||chr(10)||
'	'||nvl(to_char(:new.debtorclass),'NULL')||','||chr(10)||
'	'''||nvl(:new.legaladdr_postind,'NULL')||''','||chr(10)||
'	'''||nvl(:new.legaladdr,'NULL')||''','||chr(10)||
'	'''||nvl(:new.legaladdr_phone,'NULL')||''','||chr(10)||
'	'''||nvl(:new.legaladdr_fax,'NULL')||''','||chr(10)||
'	'''||nvl(:new.legaladdr_email,'NULL')||''','||chr(10)||
'	'''||nvl(:new.addr_postind,'NULL')||''','||chr(10)||
'	'''||nvl(:new.addr,'NULL')||''','||chr(10)||
'	'''||nvl(:new.fiodirector,'NULL')||''','||chr(10)||
'	'''||nvl(:new.okpodirector,'NULL')||''','||chr(10)||
'	'''||nvl(:new.posdirector,'NULL')||''','||chr(10)||
'	'''||nvl(:new.statut,'NULL')||''','||chr(10)||
'	'||nvl(to_char(:new.signdirector),'NULL')||','||chr(10)||
'	'''||nvl(:new.descriptiondirector,'NULL')||''','||chr(10)||
'	'''||nvl(:new.fiosyn,'NULL')||''','||chr(10)||
'	'''||nvl(:new.okposyn,'NULL')||''','||chr(10)||
'	'''||nvl(:new.possyn,'NULL')||''','||chr(10)||
'	'||nvl(to_char(:new.signsyn),'NULL')||','||chr(10)||
'	'''||nvl(:new.descriptionsyn,'NULL')||''','||chr(10)||
'	'''||nvl(:new.k050,'NULL')||''','||chr(10)||
'	'''||nvl(:new.k060,'NULL')||''','||chr(10)||
'	'''||nvl(:new.k070,'NULL')||''','||chr(10)||
'	'''||nvl(:new.k080,'NULL')||''','||chr(10)||
'	'''||nvl(:new.k090,'NULL')||''','||chr(10)||
'	'''||nvl(:new.k110,'NULL')||''','||chr(10)||
'	'''||nvl(:new.k120,'NULL')||''','||chr(10)||
'	'||nvl(to_char(:new.smallbis),'NULL')||','||chr(10)||
'	'||nvl(to_char(:new.taxadminnum),'NULL')||','||chr(10)||
'	'||nvl(to_char(:new.taxregionnum),'NULL')||','||chr(10)||
'	'||nvl(to_char(:new.govermentpart),'NULL')||','||chr(10)||
'	'||nvl(to_char(:new.salestaxcode),'NULL')||','||chr(10)||
'	'||nvl(to_char(:new.taxform),'NULL')||','||chr(10)||
'	'||nvl(to_char(:new.taxdolg),'NULL')||','||chr(10)||
'	'''||nvl(:new.taxorg,'NULL')||''','||chr(10)||
'	'''||nvl(:new.taxnum,'NULL')||''','||chr(10)||
'	to_date('''||nvl(to_char(:new.taxregdate,'dd/mm/yyyy'),'NULL')||''',''dd/mm/yyyy''),'||chr(10)||
'	'''||nvl(:new.pubadminnum,'NULL')||''','||chr(10)||
'	to_date('''||nvl(to_char(:new.pubadmindate,'dd/mm/yyyy'),'NULL')||''',''dd/mm/yyyy''),'||chr(10)||
'	'''||nvl(:new.pubadminplace,'NULL')||''','||chr(10)||
'	'''||nvl(:new.fiofounder,'NULL')||''','||chr(10)||
'	'''||nvl(:new.okpofounder,'NULL')||''','||chr(10)||
'	'''||nvl(:new.reltype,'NULL')||''','||chr(10)||
'	'''||nvl(:new.description,'NULL')||''''||chr(10)
  );
end;



/
ALTER TRIGGER BARS.TAI_TMP_PRIOCOM_CLIENTS_JUR ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAI_TMP_PRIOCOM_CLIENTS_JUR.sql ====
PROMPT ===================================================================================== 
