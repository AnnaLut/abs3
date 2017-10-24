CREATE OR REPLACE VIEW CC_W_TRANSH AS
SELECT acc,
			 comm,
			 DAPP,
			 D_FAKT,
			 D_PLAN,
			 kv,
			 nls,
			 fdat,
			 npp,
			 REF,
			 REFP,
			 SZ,
			 S,
			 SV,
			 TIP,
			 TO_NUMBER(NULL) SV1,
			 TO_DATE(NULL) D_PLAN1,
			 TO_NUMBER(NULL) SZ1,
			 SV - SZ DEL,
			 CASE
				 WHEN TIP = 'SS ' AND D_FAKT IS NULL THEN
					'В роботі'
				 WHEN TIP = 'SS ' AND D_FAKT > D_PLAN THEN
					'Винесено на просрочку'
				 WHEN TIP = 'SS ' THEN
					'Погашено своєчасно'
				 WHEN D_FAKT IS NOT NULL THEN
					'Погашено з порушенням'
				 ELSE
					'НЕпогашений'
			 END TXT
	FROM (SELECT T.npp,
							 a.TIP,
							 a.kv,
							 a.nls,
							 T.fdat,
							 T.REF,
							 T.sz / 100 SZ,
							 T.D_FAKT,
							 T.DAPP,
							 T.REFP,
							 a.acc,
							 T.comm,
							 o.s / 100 S,
							 t.d_plan,
							 t.sv / 100 SV
					FROM bars.nd_acc n
					join bars.accounts a
						on a.acc = n.acc
					join bars.CC_TRANS t
						on T.acc = a.acc
					left join bars.oper O
						on T.REF = o.REF
				 where n.nd = to_number(pul.get_mas_ini_val('ND'))
				 order by t.fdat, t.ref, t.D_PLAN) x;

