-- реанимация старых позиций по телу 
update sb_ob22 set d_close =  null  where  r020||ob22 in (select to_prod from RECLASS9)  and d_close is not null ;
commit ;

-- вставка новаых позиций  по телу
insert into sb_ob22 (r020, ob22, txt)
 select distinct Substr (r.to_prod,1,4), Substr (r.to_prod,5,2),  Substr('Корз.'||r.to_k9||'. '||s.txt, 1,254)    
 from RECLASS9 r, sb_ob22 s 
 where s.r020||s.ob22 = r.from_prod  and not exists (select 1 from sb_ob22 where r020||ob22 =r.to_prod)  ;
commit;

/*
insert into sb_ob22 (r020, ob22, txt)
 select distinct Substr (r.to_prod,1,4), k.SP,  Substr('Корз.'||r.to_k9||'. SP для '||s.txt, 1,254)    
 from RECLASS9 r, sb_ob22 s, cck_ob22 k 
 where s.r020||s.ob22 = r.from_prod  and not exists (select 1 from sb_ob22 where r020||ob22 =Substr (r.to_prod,1,4), k.SP  )  
   and k.nbs||k.ob22  = r.TO_prod;

commit;

*/

------------------------------------------------------
insert into sb_ob22 (r020, ob22, txt)
select distinct Substr (kk9.S1NP,1,4), Substr (kk9.S1NP,5,2) , 'грн:NEW_FEE~плюс S1 грн~до спрв~FV_ADJ' from cck_ob22_9 kk9
 where not exists (select 1 from sb_ob22 where r020 =Substr (kk9.S1NP,1,4) and ob22 = Substr (kk9.S1NP,5,2) ) and  S1NP is not null ;

insert into sb_ob22 (r020, ob22, txt)
select distinct Substr (kk9.S1Nm,1,4), Substr (kk9.S1Nm,5,2) , 'грн:NEW_FEE~minus S1 грн~до спрв~FV_ADJ' from cck_ob22_9 kk9
 where not exists (select 1 from sb_ob22 where r020 =Substr (kk9.S1Nm,1,4) and ob22 = Substr (kk9.S1Nm,5,2) ) and  S1Nm is not null ;

insert into sb_ob22 (r020, ob22, txt)
select distinct Substr (kk9.S1vP,1,4), Substr (kk9.S1vP,5,2) , 'val:NEW_FEE~плюс S1 грн~до спрв~FV_ADJ' from cck_ob22_9 kk9
 where not exists (select 1 from sb_ob22 where r020 =Substr (kk9.S1vP,1,4) and ob22 = Substr (kk9.S1vP,5,2) ) and  S1vP is not null ;

insert into sb_ob22 (r020, ob22, txt)
select distinct Substr (kk9.S1vm,1,4), Substr (kk9.S1vm,5,2) , 'val:NEW_FEE~minus S1 грн~до спрв~FV_ADJ' from cck_ob22_9 kk9
 where not exists (select 1 from sb_ob22 where r020 =Substr (kk9.S1vm,1,4) and ob22 = Substr (kk9.S1vm,5,2) ) and  S1vm is not null ;

-------------------
insert into sb_ob22 (r020, ob22, txt)
select distinct Substr (kk9.S3NP,1,4), Substr (kk9.S3NP,5,2) , 'грн:NEW_FEE~плюс S3 грн~від модф~MODIF' from cck_ob22_9 kk9
 where not exists (select 1 from sb_ob22 where r020 =Substr (kk9.S3NP,1,4) and ob22 = Substr (kk9.S3NP,5,2) ) and  S3NP is not null ;

insert into sb_ob22 (r020, ob22, txt)
select distinct Substr (kk9.S3Nm,1,4), Substr (kk9.S3Nm,5,2) , 'грн:NEW_FEE~мінус S3 грн~від модф~MODIF' from cck_ob22_9 kk9
 where not exists (select 1 from sb_ob22 where r020 =Substr (kk9.S3Nm,1,4) and ob22 = Substr (kk9.S3Nm,5,2) ) and  S3Nm is not null ;

insert into sb_ob22 (r020, ob22, txt)
select distinct Substr (kk9.S3vP,1,4), Substr (kk9.S3vP,5,2) , 'val:NEW_FEE~плюс S3 вал~від модф~MODIF' from cck_ob22_9 kk9
 where not exists (select 1 from sb_ob22 where r020 =Substr (kk9.S3vP,1,4) and ob22 = Substr (kk9.S3vP,5,2) ) and  S3vP is not null ;

insert into sb_ob22 (r020, ob22, txt)
select distinct Substr (kk9.S3vm,1,4), Substr (kk9.S3vm,5,2) , 'val:NEW_FEE~мінус S3 вал~від модф~MODIF' from cck_ob22_9 kk9
 where not exists (select 1 from sb_ob22 where r020 =Substr (kk9.S3vm,1,4) and ob22 = Substr (kk9.S3vm,5,2) ) and  S3vm is not null ;

commit;
-----------------------------

