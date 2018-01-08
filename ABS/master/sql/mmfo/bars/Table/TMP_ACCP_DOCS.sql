/*
begin
  execute immediate 'drop table TMP_ACCP_DOCS';
exception when others then
  if sqlcode = -00942 then null; else raise; end if;
end;
/
*/

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TARIF'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''TARIF'', ''WHOLE'' , null, null, null, null);
               
           end; 
          '; 
END; 
/

begin 
  execute immediate 
    'CREATE TABLE TMP_ACCP_DOCS
	(  okpo_org    varchar2(10),    
	   typepl      number(2),
	   REF         NUMBER,
	   branch      VARCHAR2 (30),
	   fdat        DATE,
	   nlsa        VARCHAR2 (15),
	   nlsb        VARCHAR2 (15),
	   mfoa        VARCHAR2 (6),
	   mfob        VARCHAR2 (6),
	   nam_a       VARCHAR2 (38),
	   nam_b       VARCHAR2 (38),
	   id_a        VARCHAR2 (18),
	   id_b        VARCHAR2 (18),
	   s           NUMBER,
	   s_fee       NUMBER (15),
	   order_fee   NUMBER (2),
	   amount_fee  number,
	   nazn        VARCHAR2 (160),
	   check_on     number(2) default 1,
	   period_start  date,
	   period_end    date,
	   CONSTRAINT pk_accpdocs PRIMARY KEY (ref) USING INDEX TABLESPACE BRSSMLI
	)';
exception when others then 
  if sqlcode=-955 then null; else raise; end if;
end;
/

begin
    execute immediate 'begin bpa.add_column_kf(''accp_orgs''); end;';
end;
/

GRANT DELETE, INSERT, SELECT, UPDATE ON TMP_ACCP_DOCS TO BARS_ACCESS_DEFROLE;
