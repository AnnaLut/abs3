create or replace view v_bpk_customer_uo as
select v."RNK",v."TGR",v."CUSTTYPE",v."COUNTRY",v."NMK",v."NMKV",v."NMKK",v."CODCAGENT",v."PRINSIDER",v."OKPO",v."ADR",v."SAB",v."C_REG",v."C_DST",v."RGTAX",v."DATET",v."ADM",v."DATEA",v."STMT",v."DATE_ON",v."DATE_OFF",v."NOTES",v."NOTESEC",v."CRISK",v."PINCODE",v."ND",v."RNKP",v."ISE",v."FS",v."OE",v."VED",v."SED",v."LIM",v."MB",v."RGADM",v."BC",v."BRANCH",v."TOBO",v."ISP",v."TAXF",v."NOMPDV",v."K050",v."NREZID_CODE",
       decode(nvl(trim(v.sed),'00'),'91','тн-яод','тн') ctype,
       trim(s.name || ' ' || p.ser || ' ' || p.numdoc) doc,
       trim(to_char(p.pdate,'dd.MM.yyyy') || ' ' || p.organ) issuer,
       trim(to_char(p.bday,'dd.MM.yyyy') || ' ' || p.bplace) bdayplace,
       fio(trim(replace(nvl(v.nmkv,substr(f_translate_kmu(v.nmk),1,70)), '  ', ' ')),2) || ' ' ||
       fio(trim(replace(nvl(v.nmkv,substr(f_translate_kmu(v.nmk),1,70)), '  ', ' ')),1) pk_name,
       substr(fio(nmkv,2),1,30) nmkv_first,
       substr(fio(nmkv,1),1,30) nmkv_last,
       (select min(t.last_name) keep(dense_rank first order by t.sign_privs, t.type_id)
          from customer_rel t
         where t.rnk = v.rnk and t.rel_id = 20 ) last_name_contact
  from customer v, person p, passp s
 where v.custtype = 3
   and v.rnk = p.rnk
   and p.passp = s.passp
   and v.sed = '91  '
   and v.date_off is null
union all
select v."RNK",v."TGR",v."CUSTTYPE",v."COUNTRY",v."NMK",v."NMKV",v."NMKK",v."CODCAGENT",v."PRINSIDER",v."OKPO",v."ADR",v."SAB",v."C_REG",v."C_DST",v."RGTAX",v."DATET",v."ADM",v."DATEA",v."STMT",v."DATE_ON",v."DATE_OFF",v."NOTES",v."NOTESEC",v."CRISK",v."PINCODE",v."ND",v."RNKP",v."ISE",v."FS",v."OE",v."VED",v."SED",v."LIM",v."MB",v."RGADM",v."BC",v."BRANCH",v."TOBO",v."ISP",v."TAXF",v."NOMPDV",v."K050",v."NREZID_CODE",
       'чн' ctype,
       null doc,
       null issuer,
       null bdayplace,
       fio(trim(replace(nvl(v.nmkv,substr(f_translate_kmu(v.nmk),1,70)), '  ', ' ')),2) || ' ' ||
       fio(trim(replace(nvl(v.nmkv,substr(f_translate_kmu(v.nmk),1,70)), '  ', ' ')),1) pk_name,
       nmkv nmkv_first,
       null nmkv_last,
       (select min(t.last_name) keep(dense_rank first order by t.sign_privs, t.type_id)
          from customer_rel t
         where t.rnk = v.rnk and t.rel_id = 20 ) last_name_contact
  from customer v
 where v.custtype = 2
   and v.date_off is null;
   
GRANT SELECT ON V_BPK_CUSTOMER_UO TO BARS_ACCESS_DEFROLE;