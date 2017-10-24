declare
   l_funcid  operlist.codeoper%type;
   am_ char(1) := chr(38);
begin
     begin
	 
	    Select codeoper
          into l_funcid 
		  from operlist
		 where funcname = '/barsroot/cbirep/rep_list.aspx?codeapp=\S*'
		 and rownum = 1
		 ;
     end;
  
	begin 
	insert into bars.operapp (codeapp, codeoper, approve, grantor)
	 values ('CRCO', l_funcid, 1, 1); 
	 exception when dup_val_on_index then null;
	end;
	
	begin 
	insert into bars.operapp (codeapp, codeoper, approve, grantor)
	 values ('CRCK', l_funcid, 1, 1); 
	 exception when dup_val_on_index then null;
	end;

	begin 
	insert into bars.operapp (codeapp, codeoper, approve, grantor)
	 values ('CRCT', l_funcid, 1, 1); 
	 exception when dup_val_on_index then null;
	end;

	begin 
	insert into bars.operapp (codeapp, codeoper, approve, grantor)
	 values ('CRCC', l_funcid, 1, 1); 
	 exception when dup_val_on_index then null;
	end;
end;
/

commit;

declare
procedure add_arm(p_arm app_rep.codeapp%type, p_id reports.id%type)
as
begin
MERGE INTO BARS.APP_REP A USING
 (SELECT   p_arm as CODEAPP,  p_id as CODEREP,  1 as APPROVE,  NULL as ADATE1,  NULL as ADATE2,  NULL as RDATE1,  NULL as RDATE2,  NULL as REVERSE,  NULL as REVOKED,  1 as GRANTOR,  NULL as ACODE  FROM DUAL) B
  ON (A.CODEAPP = B.CODEAPP and A.CODEREP = B.CODEREP)
WHEN NOT MATCHED THEN 
INSERT ( CODEAPP, CODEREP, APPROVE, ADATE1, ADATE2, RDATE1, RDATE2, REVERSE, REVOKED, GRANTOR,  ACODE)
VALUES (  B.CODEAPP, B.CODEREP, B.APPROVE, B.ADATE1, B.ADATE2, B.RDATE1, B.RDATE2, B.REVERSE, B.REVOKED, B.GRANTOR,  B.ACODE)
WHEN MATCHED THEN
UPDATE SET   A.APPROVE = B.APPROVE, A.ADATE1 = B.ADATE1, A.ADATE2 = B.ADATE2, A.RDATE1 = B.RDATE1, A.RDATE2 = B.RDATE2, A.REVERSE = B.REVERSE, A.REVOKED = B.REVOKED, A.GRANTOR = B.GRANTOR,  A.ACODE = B.ACODE;
end;

Begin

--CRCK    ÀÐÌ Êîíòðîëåð ÐÓ ÖÐÊÐ
--CRCT    ÀÐÌ Êîíòðîëåð ÒÂÁÂ ÖÐÊÐ
--CRCO    ÀÐÌ Îïåðàö³îí³ñò ÖÐÊÐ
--CRCC    ÀÐÌ Áåê-îô³ñ ÖÐÊÐ ÖÀ
--CRCA    ÀÐÌ «Àäì³í³ñòðàòîð ÖÐÊÐ»

add_arm('CRCO',3103);
add_arm('CRCO',3104);
add_arm('CRCO',3105);
add_arm('CRCO',3106);
add_arm('CRCO',3107);
add_arm('CRCO',3108);
add_arm('CRCO',3114);
add_arm('CRCO',3120);

add_arm('CRCK',3103);
add_arm('CRCK',3104);
add_arm('CRCK',3105);
add_arm('CRCK',3106);
add_arm('CRCK',3107);
add_arm('CRCK',3108);
add_arm('CRCK',3114);
add_arm('CRCK',3120);

add_arm('CRCT',3103);
add_arm('CRCT',3104);
add_arm('CRCT',3105);
add_arm('CRCT',3106);
add_arm('CRCT',3107);
add_arm('CRCT',3108);
add_arm('CRCT',3114);

add_arm('CRCC',3109);
add_arm('CRCC',3110);
add_arm('CRCC',3111);
add_arm('CRCC',3112);
add_arm('CRCC',3113);
add_arm('CRCC',3115);
add_arm('CRCC',3116);
add_arm('CRCC',3117);
add_arm('CRCC',3118);
add_arm('CRCC',3120);


end;
/
COMMIT;