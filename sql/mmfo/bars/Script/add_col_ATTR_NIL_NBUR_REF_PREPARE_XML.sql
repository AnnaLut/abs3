--scripts
begin  EXECUTE IMMEDIATE 'ALTER TABLE BARS.NBUR_REF_PREPARE_XML ADD (ATTR_NIL varchar(128)) ' ;
exception when others then   if SQLCODE = - 01430 then null;   else raise; end if; -- ORA-01430: column being added already exists in table
end;
/
comment on column BARS.NBUR_REF_PREPARE_XML.ATTR_NIL is 'Перелік (через кому без пробілів, elem1,elem2,...,elemN) елементів для заміни атрибуту xsi:nil';
/

-- допускаються значення формату elem1,elem2,...,elemN
--alter table NBUR_REF_PREPARE_XML
--  add constraint CC_NBURREFPREPXML_ATTRNIL
--  check (regexp_like(ATTR_NIL, '^(\d|[A-Z]|[a-z]|_){1,}$|^((\d|[A-Z]|[a-z]|_){1,},){1,}(\d|[A-Z]|[a-z]|_){1,}$'));

-- 3EX
update nbur_ref_prepare_xml 
set attr_nil=REGEXP_REPLACE('Q007_7,Q007_8', '(\s)+?','') where file_code='3EX';
/
-- 3KX
update nbur_ref_prepare_xml 
set attr_nil=REGEXP_REPLACE('Q007_1,Q003_2,Q006,Q001', '(\s)+?','') where file_code='3KX';
/
-- 3MX
update nbur_ref_prepare_xml 
set attr_nil=REGEXP_REPLACE('Q007_1', '(\s)+?','') where file_code='3MX';
/
-- D9X
update nbur_ref_prepare_xml 
set attr_nil=REGEXP_REPLACE('Q029_1,Q029_2', '(\s)+?','') where file_code='D9X';
/
-- 2KX
update nbur_ref_prepare_xml 
set attr_nil=REGEXP_REPLACE('Q007_2,Q007_3', '(\s)+?','') where file_code='2KX';
/
-- E8X
update nbur_ref_prepare_xml 
set attr_nil=REGEXP_REPLACE('Q001,Q029,Q003_2,Q007_2', '(\s)+?','') where file_code='E8X';
/
-- 4PX
update nbur_ref_prepare_xml 
set attr_nil=REGEXP_REPLACE('Q001_1,Q001_2,Q003_1,Q006,Q007_1,Q007_2,Q007_3,Q012,Q013,Q021,Q022', '(\s)+?','') where file_code='4PX';
/
-- 3BX
update nbur_ref_prepare_xml 
set attr_nil=REGEXP_REPLACE('Q001,Q026', '(\s)+?','') where file_code='3BX';
/
commit;
/
